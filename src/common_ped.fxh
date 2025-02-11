//do not add any new variables to existing effects or change the names or order of existing ones otherwise all vanilla drawables using them will no longer be compatible
#include "common_globals.fxh"

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

#ifndef NO_SHADOW_CASTING
    //unused
    float shadowmap_res : ShadowMapResolution = 1280.0;
    float2 facetMask[4] : facetMask : register(c208) = 
    {
        float2(-1.0, 0.0), 
        float2(1.0, 0.0), 
        float2(0.0, -1.0), 
        float2(0.0, 1.0)
    };
#endif

#ifdef PED_MATERIAL_COLOR_SCALE 
    float4 matMaterialColorScale : MaterialColorScale = float4(1.0, 1.0, 1.0, 1.0);
#endif

#ifdef PED_BONE_DAMAGE
    float4 gBoneDamage0[14] : CustomBoneDamageArray;
    bool gBoneDamageEnabled : CustomBoneDamageEnabled;
#endif

#ifdef SUBSURFACE_SCATTERING
    float4 SubColor : SubColor<string UIWidget = "Color"; string UIName = "Subsurface \"Bleed-thru\" Color";> = float4(0.200000003, 0.0825000033, 0.0250000004, 1.0);
    float SubScatWrap : SubWrap = 0.400000006;
    float SubScatWidth : SubScatterWidth = 0.150000006;
#endif

#ifdef ENVIRONMENT_MAP
    float reflectivePower : Reflectivity<string UIName = "Reflectivity"; float UIMin = -10.0; float UIMax = 10.0; float UIStep = 0.100000;> = 0.450000;
    texture EnvironmentTex;
    sampler EnvironmentSampler<string UIName = "Environment Texture"; string ResourceType = "Cube";> = 
    sampler_state
    {
        Texture = <EnvironmentTex>;
        MinFilter = ANISOTROPIC;
        MagFilter = LINEAR;
        MipFilter = LINEAR;
    };
#endif

#ifdef PED_BONE_DAMAGE
    texture damageTex;
    sampler damageTextureSampler = 
    sampler_state
    {
        Texture = <damageTex>;
        AddressU = WRAP;
        AddressV = WRAP;
        AddressW = WRAP;
        MipFilter = LINEAR;
        MinFilter = ANISOTROPIC;
        MagFilter = LINEAR;
    };
    
    texture damageSpecTex;
    sampler damageSpecTextureSampler = 
    sampler_state
    {
        Texture = <damageSpecTex>;
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

#ifdef SPECULAR
    float specularFactor : Specular<string UIName = "Specular Falloff"; float UIMin = 0.0; float UIMax = 10000.0; float UIStep = 0.1;> = 100.0;
    float specularColorFactor : SpecularColor<string UIName = "Specular Intensity"; float UIMin = 0.0; float UIMax = 10000.0; float UIStep = 0.1;> = 1.0;
#endif

#ifdef SPECULAR_MAP
    float3 specMapIntMask : SpecularMapIntensityMask<string UIWidget = "slider"; float UIMin = 0.0; float UIMax = 1.0; float UIStep = 0.010000; string UIName = "specular map intensity mask color";> = float3(1.0, 0.0, 0.0);
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

#ifdef NORMAL_MAP
    float bumpiness : Bumpiness<string UIWidget = "slider"; float UIMin = 0.0; float UIMax = 200.0; float UIStep = 0.010000; string UIName = "Bumpiness";> = 1.0;
#endif

float3 LuminanceConstants : LuminanceConstants = float3(0.212500006, 0.715399981, 0.0720999986);