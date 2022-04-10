#include <map>

int main()
{
    std::map<int, int> m = {
        {1, 1},
        {2, 4},
        {3, 9},
        {4, 16},
    };
    for (const std::pair<const int, int>& kv : m)
    {
        printf("%d x %d = %d\n", kv.first, kv.first, kv.second);
    }
    return 0;
}
