#include "int128.h"

Int128 int128_divu(Int128 a, Int128 b)
{
    return (__uint128_t)a / (__uint128_t)b;
}

Int128 int128_remu(Int128 a, Int128 b)
{
    return (__uint128_t)a % (__uint128_t)b;
}

Int128 int128_divs(Int128 a, Int128 b)
{
    return a / b;
}

Int128 int128_rems(Int128 a, Int128 b)
{
    return a % b;
}

