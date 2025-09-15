//do not add any new variables to existing effects or change the names or order of existing ones otherwise all vanilla drawables using them will no longer be compatible
#include "common_globals.fxh"

#ifdef DIFFUSE_TEXTURE
    texture DiffuseTex;
    sampler TextureSampler : register(s0) <string UIName = "Diffuse Texture";> = 
    sampler_state
    {
        Texture = <DiffuseTex>;
        AddressU = WRAP;
        AddressV = WRAP;
        AddressW = WRAP;
        MipFilter = LINEAR;
        MinFilter = ANISOTROPIC;
        MagFilter = LINEAR;
    };
#endif

#ifdef TIRE_DEFORMATION
    bool tyreDeformSwitchOn : tyreDeformSwitchOn : register(b9) = true;
    float4 tyreDeformParams : tyreDeformParams  : register(vs, c68) = float4(0.0, 0.0, 0.0, 1.0);
    float4 tyreDeformParams2 : tyreDeformParams2 : register(vs, c69) = float4(0.261999995, 1495.05005, 0, 0);
    row_major float4x4 matWheelTransform : matWheelTransform0 : register(vs, c64);
#endif

#ifdef DRAWBUCKET_ALPHA
    int drawBucket : __rage_drawbucket<int Bucket = 1;> = 1;
#endif

#ifdef DRAWBUCKET_DECAL
    int drawBucket : __rage_drawbucket<int Bucket = 2;> = 2;
#endif

//these draw buckets are only used in common/shaders/db but might as well still include them here for completeness
#ifdef DRAW_BUCKET_CUTOUT
    int drawBucket : __rage_drawbucket<int Bucket = 3;> = 3;
#endif

#ifdef DRAW_BUCKET_EMISSIVE
    int drawBucket : __rage_drawbucket<int Bucket = 4;> = 4;
#endif

#ifdef DRAW_BUCKET_EMISSIVE_ALPHA
    int drawBucket : __rage_drawbucket<int Bucket = 5;> = 5;
#endif

#ifdef VEHICLE_DAMAGE
    texture damagetexture;
    sampler DamageSampler = 
    sampler_state
    {
        Texture = <damagetexture>;
        AddressU = CLAMP;
        AddressV = CLAMP;
        AddressW = CLAMP;
        MipFilter = POINT;
        MinFilter = POINT;
        MagFilter = POINT;
    };
    bool switchOn : switchOn : register(b8) = false;
    float BoundRadius : BoundRadius;
#endif

float shadowmap_res : ShadowMapResolution = 1280.0;

#ifndef NO_SHADOW_CASTING_VEHICLE
    float2 facetMask[4] : facetMask =
    {
        float2(-1.0, 0.0), 
        float2(1.0, 0.0), 
        float2(0.0, -1.0), 
        float2(0.0, 1.0)
    };
#endif

float3 matDiffuseColor : DiffuseColor<string UIName = "Vehicle Diffuse Color"; float UIMin = 0.0; float UIMax = 10.0; float UIStep = 0.010000;> = float3(1.0, 1.0, 1.0);
float4 matDiffuseColor2 : DiffuseColor2 = float4(1.0, 1.0, 1.0, 1.0);

#ifdef EMISSIVE
    float emissiveMultiplier : EmissiveMultiplier<string UIName = "Emissive HDR Multiplier"; float UIMin = 0.0; float UIMax = 255.0; float UIStep = 0.100000;> = 1.0;
#endif

#ifdef DIMMER_SET
    float dimmerSet[15] : dimmerSet;
#endif

#ifdef DISK_BRAKE_GLOW 
    float DiskBrakeGlow : DiskBrakeGlow = 0.0;
#endif

#ifdef DIRT
    float dirtLevel : DirtLevel = 1.0;
    float3 dirtColor : DirtColor = float3(0.231371999, 0.223528996, 0.203921005);
#endif

#ifdef SPECULAR
    float specularFactor : specularFactor = 180.0;
#endif

float specularFactorED : Specular<string UIName = "Specular Falloff"; float UIMin = 0.0; float UIMax = 10000.0; float UIStep = 0.100000;> = 1.0;

#ifdef SPECULAR
    float specularColorFactor : specularColorFactor = 0.150000;
#endif

float specularColorFactorED : SpecularColor<string UIName = "Specular Intensity"; float UIMin = 0.0; float UIMax = 10000.0; float UIStep = 0.100000;> = 1.0;

#ifdef SPECULAR_MAP
    float3 specMapIntMask : SpecularMapIntensityMask<string UIWidget = "slider"; float UIMin = 0.0; float UIMax = 1.0; float UIStep = 0.010000; string UIName = "specular map intensity mask color";> = float3(1.0, 0.0, 0.0);
#elif defined(SPECULAR_MAP_LOD_BIAS)
    float3 specMapIntMask : SpecularMapIntensityMask<string UIWidget = "slider"; float UIMin = 0.0; float UIMax = 1.0; float UIStep = 0.010000; string UIName = "specular map intensity mask color";> = float3(1.0, 0.0, 0.0);
#endif

#ifdef NORMAL_MAP
    #ifndef NO_BUMPINESS
        float bumpiness : Bumpiness<string UIWidget = "slider"; float UIMin = 0.0; float UIMax = 200.0; float UIStep = 0.010000; string UIName = "Bumpiness";> = 1.0;
    #endif
#endif

#ifdef VEHICLE_RIMS
    float specular2Factor : specular2Factor = 40.000000;
#endif

#ifdef SPECULAR2
    float specular2FactorED : Specular2Factor<string UIName = "Specular2 Falloff"; float UIMin = 0.0; float UIMax = 10000.0; float UIStep = 0.100000;> = 1.0;
#endif

#ifdef VEHICLE_RIMS
    float specular2ColorIntensityRE : specular2ColorIntensityRE = 1.700000;
#endif

#ifdef SPECULAR2
    float specular2ColorIntensityED : specular2ColorIntensity<string UIName = "Specular2 Intensity"; float UIMin = 0.0; float UIMax = 10000.0; float UIStep = 0.100000;> = 1.0;
    float3 specular2Color : Specular2Color = float3(0.0, 0.500000, 0.0);
#endif

#ifdef REFLECTIVE_POWER
    float reflectivePower : reflectivePower = 0.450000;
#endif

float reflectivePowerED : Reflectivity<string UIName = "Reflectivity"; float UIMin = -10.0; float UIMax = 10.0; float UIStep = 0.100000;> = 1.0;

#ifdef DIFFUSE_TEXTURE2
    float diffuse2SpecMod : Diffuse2ModSpec<string UIName = "Texture2 Specular Modifier"; string UIHelp = "Amount of specular power added by alpha of secondary texture"; float UIMin = 0.0; float UIMax = 1000.0; float UIStep = 0.100000;> = 0.800000;
#endif

float3 LuminanceConstants : LuminanceConstants = float3(0.212500006, 0.715399981, 0.0720999986);

#ifdef DIFFUSE_TEXTURE2
    texture DiffuseTex2;
    sampler TextureSampler2<string UIName = "Secondary Texture"; string UIHint = "uv1";> = 
    sampler_state
    {
        Texture = <DiffuseTex2>;
        AddressU = WRAP;
        AddressV = WRAP;
        AddressW = WRAP;
        MipFilter = LINEAR;
        MinFilter = ANISOTROPIC;
        MagFilter = LINEAR;
    };
#endif

#ifdef DIRT
    texture DirtTex;
    sampler DirtSampler<string UIName = "Dirt Texture";> = 
    sampler_state
    {
        Texture = <DirtTex>;
        AddressU = WRAP;
        AddressV = WRAP;
        AddressW = WRAP;
        MipFilter = LINEAR;
        MinFilter = ANISOTROPIC;
        MagFilter = LINEAR;
    };
#endif

#ifdef NORMAL_MAP
    texture BumpTex;
    sampler BumpSampler<string UIName = "Bump Texture"; string UIHint = "normalmap";> = 
    sampler_state
    {
        Texture = <BumpTex>;
        AddressU = WRAP;
        AddressV = WRAP;
        AddressW = WRAP;
        MipFilter = LINEAR;
        MinFilter = ANISOTROPIC;
        MagFilter = LINEAR;
    };
#endif

#ifdef SPECULAR_MAP
    texture SpecularTex;
    sampler SpecSampler<string UIName = "Specular Texture"; string UIHint = "specularmap";> = 
    sampler_state
    {
        Texture = <SpecularTex>;
        AddressU = WRAP;
        AddressV = WRAP;
        AddressW = WRAP;
        MipFilter = LINEAR;
        MinFilter = ANISOTROPIC;
        MagFilter = LINEAR;
    };
#endif

#ifdef SPECULAR_MAP_LOD_BIAS
    texture SpecularTex;
    sampler SpecSampler<string UIName = "Specular Texture"; string UIHint = "specularmap";> = 
    sampler_state
    {
        Texture = <SpecularTex>;
        AddressU = WRAP;
        AddressV = WRAP;
        AddressW = WRAP;
        MipFilter = LINEAR;
        MinFilter = ANISOTROPIC;
        MagFilter = LINEAR;
        MipMapLodBias = -1.500000;
    };
#endif

#ifdef ENVIRONMENT_MAP
    texture EnvironmentTex;
    sampler EnvironmentSampler = 
    sampler_state
    {
        Texture = <EnvironmentTex>;
        MinFilter = ANISOTROPIC;
        MagFilter = LINEAR;
        MipFilter = LINEAR;
    };
#endif

texture damagevertbuffer;
sampler DamageVertBuffer = 
sampler_state
{
    Texture = <damagevertbuffer>;
    MinFilter = POINT;
    MagFilter = POINT;
    MipFilter = POINT;
    AddressU = CLAMP;
    AddressV = CLAMP;
};