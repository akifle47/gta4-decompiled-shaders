shared float4 gAllGlobals[64] : AllGlobals : register(c0);

#ifndef NO_SKINNING
    shared float4x3 gBoneMtx[48];
#endif

shared float4x4 gWorld : World : register(c0);
shared float4x4 gWorldView : WorldView : register(c4);
shared float4x4 gWorldViewProj : WorldViewProjection : register(c8);
shared float4x4 gViewInverse : ViewInverse : register(c12);

#ifndef NO_LIGHTING
    shared texture stippletexture;
    shared sampler StippleTexture : register(s10) = 
    sampler_state
    {
        Texture = <stippletexture>;
        MinFilter = POINT;
        MagFilter = POINT;
        MipFilter = POINT;
        AddressU = WRAP;
        AddressV = WRAP;
    };

    shared float4 gDepthFxParams : DepthFxParams : register(c16) = float4(1.0, 1.0, 1.0, 1.0);
    shared float4 gDirectionalLight : DirectionalLight : register(c17);
    shared float4 gDirectionalColour : DirectionalColour : register(c18);
    shared float4 gLightPosX : LightPositionX : register(c19);
    shared float4 gLightPosY : LightPositionY : register(c20);
    shared float4 gLightPosZ : LightPositionZ : register(c21);
    shared float4 gLightDirX : LightDirX : register(c22);
    shared float4 gLightDirY : LightDirY : register(c23);
    shared float4 gLightDirZ : LightDirZ : register(c24);
    shared float4 gLightFallOff : LightFallOff : register(c25);
    shared float4 gLightConeScale : LightConeScale : register(c26);
    shared float4 gLightConeOffset : LightConeOffset : register(c27);
    shared float4 gLightColR : LightColR : register(c29);
    shared float4 gLightColG : LightColG : register(c30);
    shared float4 gLightColB : LightColB : register(c31);
    shared float4 gLightPointPosX : LightPointPositionX : register(c32);
    shared float4 gLightPointPosY : LightPointPositionY : register(c33);
    shared float4 gLightPointPosZ : LightPointPositionZ : register(c34);
    shared float4 gLightPointColR : LightPointColR  : register(c35);
    shared float4 gLightPointColG : LightPointColG  : register(c64);
    shared float4 gLightPointColB : LightPointColB  : register(c65);
    shared float4 gLightPointFallOff : LightPointFallOff  : register(c36);
    shared float4 gLightDir2X : LightDir2X : register(c67);
    shared float4 gLightDir2Y : LightDir2Y : register(c68);
    shared float4 gLightDir2Z : LightDir2Z : register(c69);
    shared float4 gLightConeScale2 : LightConeScale2   : register(c70);
    shared float4 gLightConeOffset2 : LightConeOffset2 : register(c71);
    shared float4 gLightAmbient0 : LightAmbientColor0 : register(c37) <string UIWidget = "Ambient Light Color 0"; string Space = "material";> = float4(0.0, 0.0, 0.0, 1.0);
    shared float4 gLightAmbient1 : LightAmbientColor1 : register(c38) <string UIWidget = "Ambient Light Color 1"; string Space = "material";> = float4(0.0, 0.0, 0.0, 1.0);
    
    shared float4 globalScalars  : globalScalars  : register(c39) = float4(1.0, 1.0, 1.0, 1.0);
    shared float4 globalScalars2 : globalScalars2 : register(c40) = float4(1.0, 1.0, 1.0, 1.0);
#endif

#ifdef PAD_LIGHT_CONSTANTS
    //all unused
    shared float4 gLightPosDir[4] : Position<string Object = "PointDirLight"; string Space = "World";> = 
    {
        float4(1403.0, 1441.0, 1690.0, 0.0), 
        float4(0.0, 0.0, 0.0, 0.0), 
        float4(0.0, 0.0, 0.0, 0.0), 
        float4(0.0, 0.0, 0.0, 0.0)
    };
    shared float4 gLightDir[4] : Direction<string Object = "Light Direction"; string Space = "World";> = 
    {
        float4(0.0, 0.0, -1.0, 0.0), 
        float4(0.0, 0.0, 0.0, 0.0), 
        float4(0.0, 0.0, 0.0, 0.0), 
        float4(0.0, 0.0, 0.0, 0.0)
    };
    shared float4 gLightColor[4] : Diffuse<string UIName = "Diffuse Light Color"; string Object = "LightPos";> = 
    {
        float4(1.0, 1.0, 1.0, 1.0), 
        float4(0.0, 0.0, 0.0, 0.0), 
        float4(0.0, 0.0, 0.0, 0.0), 
        float4(0.0, 0.0, 0.0, 0.0)
    };
    shared float4 gLightType : LightType<string UIName = "The type of each light source";> = float4(0.0, 0.0, 0.0, 0.0);
    shared float4 gLightAmbient : Ambient<string UIWidget = "Ambient Light Color"; string Space = "material";> = float4(0.0, 0.0, 0.0, 1.0);
#endif

#ifdef NO_LIGHTING
    shared float gInvColorExpBias : ColorExpBias : register(c46);
    shared float4 gForcedColor : ForcedColor : register(c47) = float4(1.0, 1.0, 1.0, 1.0);
    shared float4 gAspectRatio : AspectRatio : register(c48) = float4(1.0, 1.0, 1.0, 1.0);
#else
    shared float4 gAspectRatio : gAspectRatio : register(c47) = float4(1.0, 1.0, 1.0, 1.0);
    shared float4 globalScreenSize : globalScreenSize : register(c44) = float4(1.0, 1.0, 1.0, 1.0);
    shared float4 globalFogParams : globalFogParams : register(c41) = float4(1600.0, 9000000.0, 0.00999999978, 1.0);
    shared float4 globalFogColor : globalFogColor   : register(c42) = float4(1.0, 1.0, 1.0, 1.0);
    shared float4 globalFogColorN : globalFogColorN : register(c43) = float4(1.0, 1.0, 1.0, 1.0);
    shared float4 gDayNightEffects : globalDayNightEffects : register(c45) = float4(1.0, 0.0, 1.0, 0.0);
    shared float gInvColorExpBias : ColorExpBias : register(c46) = 1.000000;
    shared float4 colorize : Colorize : register(c51) = float4(1.0, 1.0, 1.0, 1.0);
    shared float4 stencil : Stencil : register(c52) = float4(0.0, 255.0, 0.0, 0.0);
#endif

#ifndef NO_SHADOW_CASTING
    shared float4 gFacetCentre : FacetCentre : register(c54);
    //not used by any shader but it is set by the renderer. values are {0.62800002, ScreenWidth, ScreenHeight, 0.0}
    shared float4 gShadowCommonParam0123 : ShadowCommonParam0123 : register(c55);
    shared float4 gShadowParam14151617 : ShadowParam14151617 : register(c56);
    shared float4 gShadowParam18192021 : ShadowParam18192021 : register(c53);
    shared float4 gShadowParam0123 : ShadowParam0123 : register(c57);
    shared float4 gShadowParam4567 : ShadowParam4567 : register(c58);
    shared float4 gShadowParam891113 : ShadowParam891113 : register(c59);
    shared float4x4 gShadowMatrix : ShadowMatrix : register(c60);
    
    shared texture ShadowZTextureDir;
    shared sampler gShadowZSamplerDir : register(s15) = 
    sampler_state
    {
        Texture = <ShadowZTextureDir>;
        AddressU = CLAMP;
        AddressV = CLAMP;
        MipFilter = POINT;
        MinFilter = POINT;
        MagFilter = POINT;
    };
    
    shared texture ShadowZTextureDirVS;
    shared sampler gShadowZSamplerDirVS : register(s3) = 
    sampler_state
    {
        Texture = <ShadowZTextureDirVS>;
        AddressU = CLAMP;
        AddressV = CLAMP;
        MipFilter = POINT;
        MinFilter = POINT;
        MagFilter = POINT;
    };
    
    shared texture ShadowZTextureCache;
    shared sampler gShadowZSamplerCache : register(s14) = 
    sampler_state
    {
        Texture = <ShadowZTextureCache>;
        AddressU = CLAMP;
        AddressV = CLAMP;
        MipFilter = POINT;
        MinFilter = POINT;
        MagFilter = POINT;
    };
    
    //unused
    shared texture ShadowTextureLUT;
    shared sampler gShadowSamplerLUT = 
    sampler_state
    {
        Texture = <ShadowTextureLUT>;
        AddressU = WRAP;
        AddressV = WRAP;
        MipFilter = POINT;
        MinFilter = LINEAR;
        MagFilter = LINEAR;
    };
#endif

#ifdef PTX_CLIP_PLANES
    shared float4 NearFarPlane : NearFarPlane : register(c128);
    shared float4 gInvScreenSize : InvScreenSize : register(c129);
#endif

#ifdef PTX_DEPTH_MAP
    shared texture DepthMap;
    shared sampler DepthMapTexSampler : register(s12) = 
    sampler_state
    {
        Texture = <DepthMap>;
        MinFilter = POINT;
        MagFilter = POINT;
        MipFilter = NONE;
        AddressU = CLAMP;
        AddressV = CLAMP;
    };
#endif