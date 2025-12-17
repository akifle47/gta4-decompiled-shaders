int orderNumber : OrderNumber<string UIName = "Draw Order"; int UIMin = 0; int UIMax = 9; int UIStep = 1;> = 0;

#define DIFFUSE_TEXTURE
#define SPECULAR
#define SPECULAR_MAP
#define NORMAL_MAP
#define HAIR_SORTED_EXP
#include "common_ped.fxh"
#include "megashader_ped.fxh"

//Pixel shaders
PixelShader PixelShader0 = NULL;