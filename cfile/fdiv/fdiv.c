#include <stdbool.h>
//#include <stdint.h>

typedef int rep_t;
typedef unsigned int srep_t;
typedef unsigned int uint32_t;
typedef unsigned long long uint64_t;
typedef int si_int;
typedef unsigned su_int;
typedef float fp_t;
#define CHAR_BIT 8
#define significandBits 23
#define typeWidth (sizeof(rep_t) * CHAR_BIT)
#define exponentBits (typeWidth - significandBits - 1)
#define maxExponent ((1 << exponentBits) - 1)
#define exponentBias (maxExponent >> 1)

#define implicitBit (1 << significandBits)
#define significandMask (implicitBit - 1U)
#define signBit (1 << (significandBits + exponentBits))
#define absMask (signBit - 1U)
#define exponentMask (absMask ^ significandMask)
#define oneRep ((rep_t)exponentBias << significandBits)
#define infRep exponentMask
#define quietBit (implicitBit >> 1)
#define qnanRep (exponentMask | quietBit)

static __inline rep_t toRep(fp_t x) {
    const union {
        fp_t f;
        rep_t i;
    } rep = {.f = x};
    return rep.i;
}

static __inline fp_t fromRep(rep_t x) {
    const union {
        fp_t f;
        rep_t i;
    } rep = {.i = x};
    return rep.f;
}

si_int clzsi2(si_int a) {
    su_int x = (su_int)a;
    si_int t = ((x & 0xFFFF0000) == 0) << 4;  // if (x is small) t = 16 else 0
    x >>= 16 - t;                             // x = [0 - 0xFFFF]
    su_int r = t;                             // r = [0, 16]
    // return r + clz(x)
    t = ((x & 0xFF00) == 0) << 3;
    x >>= 8 - t;  // x = [0 - 0xFF]
    r += t;       // r = [0, 8, 16, 24]
    // return r + clz(x)
    t = ((x & 0xF0) == 0) << 2;
    x >>= 4 - t;  // x = [0 - 0xF]
    r += t;       // r = [0, 4, 8, 12, 16, 20, 24, 28]
    // return r + clz(x)
    t = ((x & 0xC) == 0) << 1;
    x >>= 2 - t;  // x = [0 - 3]
    r += t;       // r = [0 - 30] and is even
    return r + ((2 - x) & -((x & 2) == 0));
}

static __inline int rep_clz(rep_t a) { return clzsi2(a); }

static __inline int normalize(rep_t *significand) {
    const int shift = rep_clz(*significand) - rep_clz(implicitBit);
    *significand <<= shift;
    return 1 - shift;
}

fp_t test__divsf3(fp_t a, fp_t b) {
    const unsigned int aExponent = toRep(a) >> significandBits & maxExponent;
    const unsigned int bExponent = toRep(b) >> significandBits & maxExponent;
    const rep_t quotientSign = (toRep(a) ^ toRep(b)) & signBit;

    rep_t aSignificand = toRep(a) & significandMask;
    rep_t bSignificand = toRep(b) & significandMask;
    int scale = 0;

    // Detect if a or b is zero, denormal, infinity, or NaN.
    if (aExponent - 1U >= maxExponent - 1U ||
        bExponent - 1U >= maxExponent - 1U) {
        const rep_t aAbs = toRep(a) & absMask;
        const rep_t bAbs = toRep(b) & absMask;

        // NaN / anything = qNaN
        if (aAbs > infRep) return fromRep(toRep(a) | quietBit);
        // anything / NaN = qNaN
        if (bAbs > infRep) return fromRep(toRep(b) | quietBit);

        if (aAbs == infRep) {
            // infinity / infinity = NaN
            if (bAbs == infRep) return fromRep(qnanRep);
            // infinity / anything else = +/- infinity
            else
                return fromRep(aAbs | quotientSign);
        }

        // anything else / infinity = +/- 0
        if (bAbs == infRep) return fromRep(quotientSign);

        if (!aAbs) {
            // zero / zero = NaN
            if (!bAbs) return fromRep(qnanRep);
            // zero / anything else = +/- zero
            else
                return fromRep(quotientSign);
        }
        // anything else / zero = +/- infinity
        if (!bAbs) return fromRep(infRep | quotientSign);

        // One or both of a or b is denormal.  The other (if applicable) is a
        // normal number.  Renormalize one or both of a and b, and set scale to
        // include the necessary exponent adjustment.
        if (aAbs < implicitBit) scale += normalize(&aSignificand);
        if (bAbs < implicitBit) scale -= normalize(&bSignificand);
    }

    // Set the implicit significand bit.  If we fell through from the
    // denormal path it was already set by normalize( ), but setting it twice
    // won't hurt anything.
    aSignificand |= implicitBit;
    bSignificand |= implicitBit;
    int quotientExponent = aExponent - bExponent + scale;
    // 0x7504F333 / 2^32 + 1 = 3/4 + 1/sqrt(2)

    // Align the significand of b as a Q31 fixed-point number in the range
    // [1, 2.0) and get a Q32 approximate reciprocal using a small minimax
    // polynomial approximation: reciprocal = 3/4 + 1/sqrt(2) - b/2.  This
    // is accurate to about 3.5 binary digits.
    uint32_t q31b = bSignificand << 8;
    uint32_t reciprocal = 0x7504f333u - q31b;

    // Now refine the reciprocal estimate using a Newton-Raphson iteration:
    //
    //     x1 = x0 * (2 - x0 * b)
    //
    // This doubles the number of correct binary digits in the approximation
    // with each iteration.
    uint32_t correction;
    correction = -((uint64_t)reciprocal * q31b >> 32);
    reciprocal = (uint64_t)reciprocal * correction >> 31;
    correction = -((uint64_t)reciprocal * q31b >> 32);
    reciprocal = (uint64_t)reciprocal * correction >> 31;
    correction = -((uint64_t)reciprocal * q31b >> 32);
    reciprocal = (uint64_t)reciprocal * correction >> 31;

    // Adust the final 32-bit reciprocal estimate downward to ensure that it is
    // strictly smaller than the infinitely precise exact reciprocal.  Because
    // the computation of the Newton-Raphson step is truncating at every step,
    // this adjustment is small; most of the work is already done.
    reciprocal -= 2;

    // The numerical reciprocal is accurate to within 2^-28, lies in the
    // interval [0x1.000000eep-1, 0x1.fffffffcp-1], and is strictly smaller
    // than the true reciprocal of b.  Multiplying a by this reciprocal thus
    // gives a numerical q = a/b in Q24 with the following properties:
    //
    //    1. q < a/b
    //    2. q is in the interval [0x1.000000eep-1, 0x1.fffffffcp0)
    //    3. The error in q is at most 2^-24 + 2^-27 -- the 2^24 term comes
    //       from the fact that we truncate the product, and the 2^27 term
    //       is the error in the reciprocal of b scaled by the maximum
    //       possible value of a.  As a consequence of this error bound,
    //       either q or nextafter(q) is the correctly rounded.
    rep_t quotient = (uint64_t)reciprocal * (aSignificand << 1) >> 32;

    // Two cases: quotient is in [0.5, 1.0) or quotient is in [1.0, 2.0).
    // In either case, we are going to compute a residual of the form
    //
    //     r = a - q*b
    //
    // We know from the construction of q that r satisfies:
    //
    //     0 <= r < ulp(q)*b
    //
    // If r is greater than 1/2 ulp(q)*b, then q rounds up.  Otherwise, we
    // already have the correct result.  The exact halfway case cannot occur.
    // We also take this time to right shift quotient if it falls in the [1,2)
    // range and adjust the exponent accordingly.
    rep_t residual;
    if (quotient < (implicitBit << 1)) {
        residual = (aSignificand << 24) - quotient * bSignificand;
        quotientExponent--;
    } else {
        quotient >>= 1;
        residual = (aSignificand << 23) - quotient * bSignificand;
    }

    const int writtenExponent = quotientExponent + exponentBias;

    if (writtenExponent >= maxExponent) {
        // If we have overflowed the exponent, return infinity.
        return fromRep(infRep | quotientSign);
    }

    else if (writtenExponent < 1) {
        if (writtenExponent == 0) {
            // Check whether the rounded result is normal.
            const bool round = (residual << 1) > bSignificand;
            // Clear the implicit bit.
            rep_t absResult = quotient & significandMask;
            // Round.
            absResult += round;
            if (absResult & ~significandMask) {
                // The rounded result is normal; return it.
                return fromRep(absResult | quotientSign);
            }
        }
        // Flush denormals to zero.  In the future, it would be nice to add
        // code to round them correctly.
        return fromRep(quotientSign);
    }

    else {
        const bool round = (residual << 1) > bSignificand;
        // Clear the implicit bit.
        rep_t absResult = quotient & significandMask;
        // Insert the exponent.
        absResult |= (rep_t)writtenExponent << significandBits;
        // Round.
        absResult += round;
        // Insert the sign and return.
        return fromRep(absResult | quotientSign);
    }
}
