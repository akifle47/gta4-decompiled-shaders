//note: adding new variables to existing effects or changing the names or order of existing varables will make drawables 
//using that effect no longer compatible unless you rebuild them
#include "common_globals.fxh"

#ifdef ANIMATED
    float3 globalAnimUV0 : globalAnimUV0 = float3(1.0, 0.0, 0.0);
    float3 globalAnimUV1 : globalAnimUV1 = float3(0.0, 1.0, 0.0);
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

#ifdef DIFFUSE_TEXTURE
    texture DiffuseTex;
    sampler TextureSampler <string UIName = "Diffuse Texture";> = 
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
    bool switchOn : switchOn = false;
    float BoundRadius : BoundRadius;
#endif

#ifndef NO_SHADOW_CASTING
    //both unused
    float shadowmap_res : ShadowMapResolution = 1280.0;
    float2 facetMask[4] : facetMask = 
    {
        float2(-1.0, 0.0), 
        float2(1.0, 0.0), 
        float2(0.0, -1.0), 
        float2(0.0, 1.0)
    };
#endif

#ifdef DEPTH_SHIFT_SCALE
    float zShiftScale : zShiftScale = 0.002000;
#endif

#ifdef DEPTH_SHIFT
    float zShift : zShift = 0.000110;
#endif

#ifdef EMISSIVE
    float emissiveMultiplier : EmissiveMultiplier<string UIName = "Emissive HDR Multiplier"; float UIMin = 0.0; float UIMax = 255.0; float UIStep = 0.100000;> = 1.0;
#endif

#ifdef AMBIENT_DECAL_MASK
    float3 ambientDecalMask : AmbientDecalMask<string UIWidget = "slider"; float UIMin = 0.0; float UIMax = 1.0; float UIStep = 0.00999999978; string UIName = "ambient map mask color";> = float3(1.0, 0.0, 0.0);
#endif

#ifdef DIRT_DECAL_MASK
    float3 dirtDecalMask : DirtDecalMask<string UIWidget = "slider"; float UIMin = 0.0; float UIMax = 1.0; float UIStep = 0.00999999978; string UIName = "dirt map mask color";> = float3(1.0, 0.0, 0.0);
#endif

#ifdef PARALLAX
    float parallaxScaleBias : ParallaxScaleBias<string UIName = "Parallax ScaleBias"; float UIMin = 0.010000; float UIMax = 1.0; float UIStep = 0.010000;>
    #ifdef PARALLAX_STEEP
        = 0.005;
    #else
        = 0.03;
    #endif
#endif

#ifdef SPECULAR
    float specularFactor : Specular<string UIName = "Specular Falloff"; float UIMin = 0.0; float UIMax = 2000.0; float UIStep = 0.100000;> = 100.0;
    #ifdef SPECULAR_COLOR_ZERO //sucks
       float specularColorFactor : SpecularColor<string UIName = "Specular Intensity"; float UIMin = 0.0; float UIMax = 1.0; float UIStep = 0.010000;> = 0.0;
    #else
       float specularColorFactor : SpecularColor<string UIName = "Specular Intensity"; float UIMin = 0.0; float UIMax = 1.0; float UIStep = 0.010000;> = 1.0;
    #endif
#endif

#ifdef SPECULAR_MAP
    float3 specMapIntMask : SpecularMapIntensityMask<string UIWidget = "slider"; float UIMin = 0.0; float UIMax = 1.0; float UIStep = 0.010000; string UIName = "specular map intensity mask color";> = float3(1.0, 0.0, 0.0);
#endif

#if defined(NORMAL_MAP) || defined(PARALLAX)
    float bumpiness : Bumpiness<string UIWidget = "slider"; float UIMin = 0.0; float UIMax = 200.0; float UIStep = 0.010000; string UIName = "Bumpiness";> = 1.0;
#endif

#ifdef ENVIRONMENT_MAP
    float reflectivePower : Reflectivity<string UIName = "Reflectivity"; float UIMin = -10.0; float UIMax = 100.0; float UIStep = 0.100000;> = 0.450000;
#endif

#ifndef NO_LUMINANCE_CONSTANTS
    float3 LuminanceConstants : LuminanceConstants = float3(0.212500, 0.715400, 0.072100);
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
        MinFilter = ANISOTROPIC;
        MagFilter = LINEAR;
        MipFilter = LINEAR;
    };
#endif
#ifdef PARALLAX
    texture BumpTex;
    sampler BumpSampler<string UIName = "Bump [RGB] + Height [A] Texture"; string UIHint = "normalmap+heightmap";> = 
    sampler_state
    {
        Texture = <BumpTex>;
        AddressU = WRAP;
        AddressV = WRAP;
        AddressW = WRAP;
        MipFilter = LINEAR;
        MinFilter = LINEAR;
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
        #ifndef SPECULAR_MAP_NO_FILTER
            MipFilter = LINEAR;
            MinFilter = ANISOTROPIC;
            MagFilter = LINEAR;
        #endif
    };
#endif

#ifdef ENVIRONMENT_MAP
    texture EnvironmentTex;
    #ifdef CUBEMAP_ENVIRONMENT_MAP
        samplerCUBE EnvironmentSampler<string UIName = "Environment Texture"; string ResourceType = "Cube";> = 
    #else
        sampler2D EnvironmentSampler<string UIName = "Environment Texture"; string ResourceType = "Cube";> = 
    #endif //CUBEMAP_ENVIRONMENT_MAP
    sampler_state
    {
        Texture = <EnvironmentTex>;
        MinFilter = ANISOTROPIC;
        MagFilter = LINEAR;
        MipFilter = LINEAR;
    };
#endif