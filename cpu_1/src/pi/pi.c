float leibniz(int n)
{
    int i = 0;
    float ret = 0.0;
    for (i = 0; i < n; i++)
    {
        if (i % 2 == 0)
        {
            ret += 1.0 / (2 * i + 1);
        }
        else
        {
            ret -= 1.0 / (2 * i + 1);
        }
    }
    return 4 * ret;
}