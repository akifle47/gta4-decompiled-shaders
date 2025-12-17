#define DRAWBUCKET_ALPHA
#define NO_LUMINANCE_CONSTANTS
#define ANIMATED
#define DAY_NIGHT_EFFECTS
#define DIFFUSE_TEXTURE
#define WIRE
#define ALPHA_SHADOW
#define USE_IMPOSTOR_TECH

#include "common.fxh"

float Fade_Thickness : FadeThickness<string UIName = "Thickness of object in metres"; string UIHelp = "Amount of thickness of object"; float UIMin = 0.000000; float UIMax = 10.000000; float UIStep = 0.010000;> = 0.070000;
float3 LuminanceConstants : LuminanceConstants = float3(0.212500006, 0.715399981, 0.0720999986);

#include "megashader.fxh"