#include "../headers/EasyRand.h"
#include <float.h>

using namespace EasyRand;

bool Random::initialised = false;
std::mt19937 Random::generator;
std::uniform_int_distribution<int32_t> Random::booldistribution;
std::uniform_int_distribution<int32_t> Random::distribution;
std::uniform_real_distribution<double> Random::realdistribution;

void Random::seed() {
    std::random_device rDevice;
    generator = std::mt19937(rDevice());
    initialised = true;
}

bool Random::randBool() {
    booldistribution = std::uniform_int_distribution<int32_t>(0,1);
    if (!initialised) {
        seed();
    }
    int32_t random = booldistribution(generator);
    if (random == 1) {
        return true;
    } else {
        return false;
    }
}

int32_t Random::randInt() {
    distribution = std::uniform_int_distribution<int32_t>();
    if (!initialised) {
        seed();
    }
    int32_t random = distribution(generator);
    return random;
}

int32_t Random::randInt(const int32_t iStart, const int32_t iEnd) {
    distribution = std::uniform_int_distribution<int32_t>(iStart, iEnd);
    if (!initialised) {
        seed();
    }
    int32_t random = distribution(generator);
    return random;
}

double Random::randReal() {
    realdistribution = std::uniform_real_distribution<double>(0, DBL_MAX);
    if (!initialised) {
        seed();
    }
    double random = realdistribution(generator);
    return random;
}

double Random::randReal(const double iStart, const double iEnd) {
    realdistribution = std::uniform_real_distribution<double>(iStart, iEnd);
    if (!initialised) {
        seed();
    }
    double random = realdistribution(generator);
    return random;
}