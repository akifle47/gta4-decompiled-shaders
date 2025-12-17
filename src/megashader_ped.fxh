#include "common_functions.fxh"
#include "common_shadow.fxh"
#include "common_lighting.fxh"
#include "shader_inputs.fxh"

#if defined(SPECULAR_MAP) && !defined(HAIR_SORTED_EXP)
    #define USE_SPECULAR_MAP 
#endif //SPECULAR_MAP && !HAIR_SORTED_EXP

float ComputeBoneDamage(int4 boneIndices, float4 boneWeights)
{
    int4 dmgIndex = boneIndices / 4;
    int4 mtxIndex = boneIndices % 4;

    const float4x4 identity = float4x4(1, 0, 0, 0,
                                       0, 1, 0, 0,
                                       0, 0, 1, 0,
                                       0, 0, 0, 1);
    float4 v0;
    v0.x = dot(gBoneDamage0[dmgIndex.x], identity[mtxIndex.x]);
    v0.y = dot(gBoneDamage0[dmgIndex.y], identity[mtxIndex.y]);
    v0.z = dot(gBoneDamage0[dmgIndex.z], identity[mtxIndex.z]);
    v0.w = dot(gBoneDamage0[dmgIndex.w], identity[mtxIndex.w]);

    return dot(v0, boneWeights);
}

struct VS_InputPed
{
    float3 Position : POSITION;
    float4 Color    : COLOR0;
    float2 TexCoord : TEXCOORD0;
    float3 Normal   : NORMAL;
#if defined(NORMAL_MAP) || defined(PARALLAX)
    float4 Tangent  : TANGENT; 
#endif //NORMAL_MAP || PARALLAX
};

struct VS_OutputPed
{
    float4 Position            : POSITION;
    float2 TexCoord            : TEXCOORD0;
    float4 NormalWorldAndDepth : TEXCOORD1;
    float4 PositionWorld       : TEXCOORD2;
#if defined(SPECULAR) || defined(ENVIRONMENT_MAP)
    float3 FragToViewDir       : TEXCOORD3;
#endif //SPECULAR || ENVIRONMENT_MAP
#if defined(NORMAL_MAP) || defined(PARALLAX)
    float3 TangentWorld        : TEXCOORD4;
    float3 BitangentWorld      : TEXCOORD5; 
#endif //NORMAL_MAP || PARALLAX
    float  DamageMask          : TEXCOORD6;
    float4 Color               : COLOR0;
};

VS_OutputPed VS_PedTransform(VS_InputPed IN)
{
    VS_OutputPed OUT;

    float3 posWorld = mul(float4(IN.Position, 1.0), gWorld).xyz;
    float4 posClip = mul(float4(IN.Position, 1.0), gWorldViewProj);
    OUT.PositionWorld.xyz = posWorld;
    OUT.Position = posClip;
    
    #if defined(SPECULAR) || defined(ENVIRONMENT_MAP)
        OUT.FragToViewDir = gViewInverse[3].xyz - posWorld;
    #endif //SPECULAR || ENVIRONMENT_MAP

    float3 normalWorld = normalize(mul(IN.Normal, (float3x3)gWorld) + 0.00001);
    OUT.NormalWorldAndDepth.xyz = normalWorld;
    OUT.NormalWorldAndDepth.w = posClip.w;

    #if defined(NORMAL_MAP) || defined(PARALLAX)
        float3 tangentWorld = normalize(mul(IN.Tangent.xyz, (float3x3)gWorld) + 0.00001);
        float3 bitangentWorld = cross(tangentWorld, normalWorld);
        OUT.TangentWorld.xyz = tangentWorld;
        OUT.BitangentWorld.xyz = bitangentWorld * IN.Tangent.w;
    #endif //NORMAL_MAP || PARALLAX

    OUT.TexCoord = IN.TexCoord;
    OUT.Color = IN.Color;
    OUT.DamageMask = 0;
    OUT.PositionWorld.w = 1;

    return OUT;
}


VS_OutputPed VS_PedTransformSkin(VS_InputSkin IN)
{
    VS_OutputPed OUT;

    #ifdef PED_BONE_DAMAGE
        if(gBoneDamageEnabled)
        {
            OUT.DamageMask = ComputeBoneDamage(D3DCOLORtoUBYTE4(IN.BlendIndices).bgra, IN.BlendWeights);
        }
        else
    #endif //PED_BONE_DAMAGE
    {
        OUT.DamageMask = 0;
    }

    float4x3 skinMtx = ComputeSkinMatrix(IN.BlendIndices, IN.BlendWeights);

    float3 posWorld = mul(float4(IN.Position, 1.0), skinMtx).xyz;
    float4 posClip = mul(float4(posWorld, 1.0), gWorldViewProj);
    OUT.PositionWorld = float4(posWorld + gWorld[3].xyz, 1);
    OUT.Position = posClip;

    #if defined(SPECULAR) || defined(ENVIRONMENT_MAP)
        OUT.FragToViewDir = gViewInverse[3].xyz - posWorld;
    #endif //SPECULAR || ENVIRONMENT_MAP

    float3 normalWorld = mul(IN.Normal, (float3x3)skinMtx);
    OUT.NormalWorldAndDepth.xyz = normalWorld;
    OUT.NormalWorldAndDepth.w = posClip.w;

    #if defined(NORMAL_MAP) || defined(PARALLAX)
        float3 tangentWorld = mul(IN.Tangent.xyz, (float3x3)skinMtx);
        float3 bitangentWorld = cross(tangentWorld, normalWorld);
        OUT.TangentWorld.xyz = tangentWorld;
        OUT.BitangentWorld.xyz = bitangentWorld * IN.Tangent.w;
    #endif //NORMAL_MAP || PARALLAX

    OUT.Color = IN.Color;
    OUT.TexCoord = IN.TexCoord;

    return OUT;
}

struct VS_OutputDeferredPed
{
    float4 Position             : POSITION;
    float2 TexCoord             : TEXCOORD0;
    float4 NormalWorldAndDepth  : TEXCOORD1;
#ifdef ENVIRONMENT_MAP
    float3 FragToViewDir        : TEXCOORD3;
#endif //ENVIRONMENT_MAP
#if defined(NORMAL_MAP) || defined(PARALLAX)
    float3 TangentWorld         : TEXCOORD4;
    float3 BitangentWorld       : TEXCOORD5;
#endif //NORMAL_MAP || PARALLAX
    float4 Color                : COLOR0;
#ifdef ENVIRONMENT_MAP
    float4 PositionWorld        : TEXCOORD2;
#else
    float4 PositionWorld        : TEXCOORD7;
#endif //ENVIRONMENT_MAP
    float  DamageMask           : TEXCOORD6;
};

VS_OutputDeferredPed VS_PedTransformD(VS_InputPed IN)
{
    VS_OutputDeferredPed OUT;

    float3 posWorld = mul(float4(IN.Position, 0.0), gWorld).xyz;
    float4 posClip = mul(float4(IN.Position, 1.0), gWorldViewProj);
    OUT.PositionWorld = float4(posWorld + gWorld[3].xyz * 2, 1);
    OUT.Position = posClip;

    #ifdef ENVIRONMENT_MAP
        OUT.FragToViewDir = gViewInverse[3].xyz - posWorld;
    #endif //ENVIRONMENT_MAP

    float3 normalWorld = normalize(mul(IN.Normal, (float3x3)gWorld) + 0.00001);
    OUT.NormalWorldAndDepth.xyz = normalWorld;
    OUT.NormalWorldAndDepth.w = posClip.w;

    #if defined(NORMAL_MAP) || defined(PARALLAX)
        float3 tangentWorld = normalize(mul(IN.Tangent.xyz, (float3x3)gWorld) + 0.00001);
        float3 bitangentWorld = cross(tangentWorld, normalWorld);
        OUT.TangentWorld.xyz = tangentWorld;
        OUT.BitangentWorld.xyz = bitangentWorld * IN.Tangent.w;
    #endif //NORMAL_MAP || PARALLAX

    OUT.Color.x = (globalScalars2.y * globalScalars2.z) * (IN.Color.x * globalScalars.z - 1) + 1;
    OUT.Color.y = globalScalars2.w * IN.Color.y;
    #ifdef SUBSURFACE_SCATTERING
        OUT.Color.z = 1.0 - (IN.Color.y * IN.Color.x);
    #else
        OUT.Color.z = IN.Color.z;
    #endif //SUBSURFACE_SCATTERING
    OUT.Color.w = IN.Color.w;

    OUT.TexCoord = IN.TexCoord;
    OUT.DamageMask = 0;

    return OUT;
}

VS_OutputDeferredPed VS_PedTransformSkinD(VS_InputSkin IN)
{
    VS_OutputDeferredPed OUT;

    #ifdef PED_BONE_DAMAGE
        if(gBoneDamageEnabled)
        {
            OUT.DamageMask = ComputeBoneDamage(D3DCOLORtoUBYTE4(IN.BlendIndices).bgra, IN.BlendWeights);
        }
        else
    #endif //PED_BONE_DAMAGE
    {
        OUT.DamageMask = 0;
    }

    float4x3 skinMtx = ComputeSkinMatrix(IN.BlendIndices, IN.BlendWeights);

    float3 posWorld = mul(float4(IN.Position, 1.0), skinMtx).xyz;
    float4 posClip = mul(float4(posWorld, 1.0), gWorldViewProj);
    OUT.PositionWorld = float4(posWorld + gWorld[3].xyz, 1);
    OUT.Position = posClip;

    #ifdef ENVIRONMENT_MAP
        OUT.FragToViewDir = gViewInverse[3].xyz - posWorld;
    #endif //ENVIRONMENT_MAP

    float3 normalWorld = mul(IN.Normal, (float3x3)skinMtx);
    OUT.NormalWorldAndDepth.xyz = normalWorld;
    OUT.NormalWorldAndDepth.w = posClip.w;

    #if defined(NORMAL_MAP) || defined(PARALLAX)
        float3 tangentWorld = mul(IN.Tangent.xyz, (float3x3)skinMtx);
        float3 bitangentWorld = cross(tangentWorld, normalWorld);
        OUT.TangentWorld.xyz = tangentWorld;
        OUT.BitangentWorld.xyz = bitangentWorld * IN.Tangent.w;
    #endif //NORMAL_MAP || PARALLAX

    OUT.Color.x = (globalScalars2.y * globalScalars2.z) * (IN.Color.x * globalScalars.z - 1) + 1;
    OUT.Color.y = globalScalars2.w * IN.Color.y;
    #ifdef SUBSURFACE_SCATTERING
        OUT.Color.z = 1.0 - (IN.Color.y * IN.Color.x);
    #else
        OUT.Color.z = IN.Color.z;
    #endif //SUBSURFACE_SCATTERING
    OUT.Color.w = IN.Color.w;

    OUT.TexCoord = IN.TexCoord;

    return OUT;
}


PS_OutputDeferred PS_DeferredPedTextured(VS_OutputDeferredPed IN, float2 screenCoords : VPOS)
{
    PS_OutputDeferred OUT;

    float4 diffuse = tex2D(TextureSampler, IN.TexCoord);
    diffuse.w *= globalScalars.x;

    #ifdef HAIR_SORTED
        AlphaClip(diffuse.w * IN.Color.w, screenCoords);
    #else
        AlphaClip(globalScalars.x, screenCoords);
    #endif //HAIR_SORTED

    #ifdef USE_SPECULAR_MAP
        float4 specMap = tex2D(SpecSampler, IN.TexCoord);
        float specPower = specMap.w * specularFactor;
        float specIntensity = dot(specMap.xyz, specMapIntMask.xyz) * specularColorFactor;
    #else
        float specIntensity = 0;
        float specPower = 0.3125;
    #endif //USE_SPECULAR_MAP

    if(IN.DamageMask > 0)
    {
        float4 damageDiffTex = tex2D(damageTextureSampler, IN.TexCoord);
        if(damageDiffTex.w > 0)
        {
            #ifdef USE_SPECULAR_MAP
                float4 damageSpecTex = tex2D(damageSpecTextureSampler, IN.TexCoord);
                specPower = lerp(damageSpecTex.w * specularFactor, specPower, IN.DamageMask);
                float damageSpecInt = damageSpecTex.x + damageSpecTex.y + damageSpecTex.z;
                damageSpecInt = (damageSpecInt * IN.DamageMask * specularColorFactor) / 3;
                specIntensity = (1 - IN.DamageMask) * specIntensity + damageSpecInt;
            #endif //USE_SPECULAR_MAP

            float damageAlpha = 1 - (IN.DamageMask * damageDiffTex.w);
            float3 damage = damageDiffTex.xyz * damageDiffTex.w * IN.DamageMask;

            diffuse.xyz = diffuse.xyz * damageAlpha + damage;
        }
    }

    float4 normalMap = tex2D(BumpSampler, IN.TexCoord);
    float3 normal = UnpackNormalMap(normalMap);
    float3x3 tbn = float3x3(IN.TangentWorld.xyz, IN.BitangentWorld.xyz, IN.NormalWorldAndDepth.xyz);
    normal = normalize(mul(normal, tbn) + 0.00001);

    #ifdef SUBSURFACE_SCATTERING
        float wrappedNdotL = (dot(gDirectionalLight.xyz, normal) + SubScatWrap) / (1 + SubScatWrap);
        wrappedNdotL = max(wrappedNdotL, 0);

        float a = smoothstep(0.0, SubScatWidth, wrappedNdotL);
        float b = 1.0 - smoothstep(SubScatWidth, SubScatWidth * 2.0, wrappedNdotL);

        float subScattIntensity = a * b;
        float3 subScattColor = subScattIntensity * SubColor.xyz * diffuse.w;
        diffuse.xyz += (subScattColor * 0.5);
    #endif //SUBSURFACE_SCATTERING

    OUT.Diffuse.xyz = diffuse.xyz * matMaterialColorScale.x;
    #ifdef SUBSURFACE_SCATTERING
        OUT.Diffuse.w = IN.Color.w * globalScalars.x;
    #else
        OUT.Diffuse.w = diffuse.w * IN.Color.w;
    #endif //SUBSURFACE_SCATTERING

    #ifdef USE_SPECULAR_MAP
        specIntensity *= matMaterialColorScale.w;
        specPower *= matMaterialColorScale.w;
        #ifdef HAIR_SORTED
            specPower /= 1024.0;
        #else
            specPower /= 682.6666666666666;
        #endif //HAIR_SORTED
    #endif //USE_SPECULAR_MAP

    float3 viewToFragDir = IN.PositionWorld.xyz - gViewInverse[3].xyz;
    viewToFragDir = normalize(viewToFragDir + 0.00001);

    float specHighlight = dot(normal, viewToFragDir);
    specHighlight = specHighlight <= 0 ? specHighlight * 2 + 1 : 1;
    specHighlight = specHighlight >= 0 ? specHighlight * IN.Color.y : 0;
    specHighlight = specHighlight * specHighlight;

    specIntensity = specIntensity * 0.5 + specHighlight;

    #ifdef HAIR_SORTED_EXP
        OUT.Normal.xyz = (normal + 1) * 0.5;
        OUT.Normal.w = diffuse.w;
    #else
        OUT.Normal = EncodeGBufferNormal(normal);
    #endif //HAIR_SORTED_EXP

    OUT.SpecularAndAO.x = specIntensity * 0.5;

    #ifdef USE_SPECULAR_MAP
        OUT.SpecularAndAO.y = sqrt(specPower);
        OUT.SpecularAndAO.z = IN.Color.x + specHighlight;
    #else
        OUT.SpecularAndAO.y = specPower;
        OUT.SpecularAndAO.z = IN.Color.x;
    #endif //USE_SPECULAR_MAP

    #ifdef HAIR_SORTED_EXP
        OUT.SpecularAndAO.w = diffuse.w;
    #else
        OUT.SpecularAndAO.w = 1;
    #endif //HAIR_SORTED_EXP
    
    OUT.Stencil = float4(stencil.x, 0, 0, 0);

    return OUT;
}


PS_OutputDeferred PS_DeferredPedTexturedOnlyPedMaterialID()
{
    PS_OutputDeferred OUT;
    OUT.Diffuse = float4(0, 0, 0, 1.0 / 255.0);
    OUT.Normal = float4(0, 0, 0, 0);
    OUT.SpecularAndAO = float4(0, 0, 0, 0);
    OUT.Stencil = float4(stencil.x, 0, 0, 0);

    return OUT;
}


float4 TexturedLit(in int numLights, in VS_OutputPed IN, in float2 screenCoords)
{
    float4 diffuse = tex2D(TextureSampler, IN.TexCoord);
    #ifdef SUBSURFACE_SCATTERING
        diffuse.w = IN.Color.w;
    #else
        diffuse.w *= IN.Color.w;
    #endif //SUBSURFACE_SCATTERING

    float4 normalMap = tex2D(BumpSampler, IN.TexCoord);
    float3 normal = UnpackNormalMap(normalMap);
    float3x3 tbn = float3x3(IN.TangentWorld.xyz, IN.BitangentWorld.xyz, IN.NormalWorldAndDepth.xyz);
    normal = normalize(mul(normal, tbn) + 0.00001);

    float4 specMap = tex2D(SpecSampler, IN.TexCoord);
    float specPower = specMap.w * specularFactor;
    float specIntensity = dot(specMap.xyz, specMapIntMask.xyz) * specularColorFactor;
    float specIntensityUndamaged = specIntensity;

    if(IN.DamageMask > 0)
    {
        float4 damageDiffTex = tex2D(damageTextureSampler, IN.TexCoord);
        if(damageDiffTex.w > 0)
        {
            #ifdef USE_SPECULAR_MAP
                float4 damageSpecTex = tex2D(damageSpecTextureSampler, IN.TexCoord);
                specPower = lerp(damageSpecTex.w * specularFactor, specPower, IN.DamageMask);
                float damageSpecInt = damageSpecTex.x + damageSpecTex.y + damageSpecTex.z;
                damageSpecInt = (damageSpecInt * IN.DamageMask * specularColorFactor) / 3;
                specIntensity = (1 - IN.DamageMask) * specIntensity + damageSpecInt;
            #endif //USE_SPECULAR_MAP

            float damageAlpha = 1 - (IN.DamageMask * damageDiffTex.w);
            float3 damage = damageDiffTex.xyz * damageDiffTex.w * IN.DamageMask;

            diffuse.xyz = diffuse.xyz * damageAlpha + damage;
        }
    }

    float3 viewToFragDir = -normalize(IN.FragToViewDir + 0.00001);

    #ifdef ENVIRONMENT_MAP
        float3 R = reflect(viewToFragDir, normal);
        R = normalize(R + 0.00001);

        float3 envRefl = tex2D(EnvironmentSampler, (R.xz + 1) * -0.5).xyz;
        envRefl *= tex2D(EnvironmentSampler, IN.TexCoord).w * specIntensityUndamaged * reflectivePower;
        diffuse.xyz += envRefl;
    #endif //ENVIRONMENT_MAP

    SurfaceProperties surfaceProperties;
    surfaceProperties.Diffuse = diffuse.xyz;
    surfaceProperties.Normal = normal;
    surfaceProperties.SpecularIntensity = specIntensity;
    surfaceProperties.SpecularPower = specPower;
    surfaceProperties.AmbientOcclusion = IN.Color.x;
    float4 lighting = float4(ComputeLighting(numLights, true, IN.PositionWorld.xyz, viewToFragDir, surfaceProperties), globalScalars.x);

    lighting.xyz = ComputeDepthEffects(1.0, lighting.xyz, IN.NormalWorldAndDepth.w) * matMaterialColorScale.x;

    lighting.w *= diffuse.w;
    #ifdef ENVIRONMENT_MAP
        AlphaClip(globalScalars.x, screenCoords);
    #else
        AlphaClip(lighting.w, screenCoords);
    #endif //ENVIRONMENT_MAP

    return lighting;
}

float4 PS_PedTexturedZero(VS_OutputPed IN, float2 screenCoords : VPOS) : COLOR
{
    return TexturedLit(0, IN, screenCoords);
}

float4 PS_PedTexturedFour(VS_OutputPed IN, float2 screenCoords : VPOS) : COLOR
{
    return TexturedLit(4, IN, screenCoords);
}

float4 PS_PedTexturedEight(VS_OutputPed IN, float2 screenCoords : VPOS) : COLOR
{
    return TexturedLit(8, IN, screenCoords);
}



#ifndef NO_GENERATED_TECHNIQUES
    technique wd_draw
    {
        pass p0
        {
            CullMode = CW;
    
            VertexShader = compile vs_3_0 VS_ShadowDepthPed();
            PixelShader = compile ps_3_0 PS_ShadowDepthPed();
        }
    }
    
    technique wd_drawskinned
    {
        pass p0
        {
            CullMode = CW;
    
            VertexShader =  compile vs_3_0 VS_ShadowDepthSkinPed();
            PixelShader = compile ps_3_0 PS_ShadowDepthPed();
        }
    }
    
    technique draw
    {
        pass p0
        {
            #ifdef HAIR_SORTED
                AlphaBlendEnable = false;
                AlphaTestEnable = false;
                ZWriteEnable = true;
            #else
                AlphaRef = 0x64;
                AlphaBlendEnable = true;
                AlphaTestEnable = true;
            #endif //HAIR_SORTED
    
            VertexShader = compile vs_3_0 VS_PedTransform();
            PixelShader = compile ps_3_0 PS_PedTexturedEight();
        }
    }
    
    technique unlit_draw
    {
        pass p0
        {
            AlphaRef = 0x64;
            AlphaBlendEnable = true;
            AlphaTestEnable = true;
    
            VertexShader = compile vs_3_0 VS_PedTransform();
            PixelShader = compile ps_3_0 PS_PedTexturedZero();
        }
    }
    
    technique lightweight0_draw
    {
        pass p0
        {
            AlphaRef = 0x64;
            AlphaBlendEnable = true;
            AlphaTestEnable = true;
    
            VertexShader = compile vs_3_0 VS_PedTransform();
            PixelShader = compile ps_3_0 PS_PedTexturedZero();
        }
    }
    
    technique lightweight4_draw
    {
        pass p0
        {
            AlphaRef = 0x64;
            AlphaBlendEnable = true;
            AlphaTestEnable = true;
    
            VertexShader = compile vs_3_0 VS_PedTransform();
            PixelShader = compile ps_3_0 PS_PedTexturedFour();
        }
    }
    
    technique drawskinned
    {
        pass p0
        {
            #ifdef HAIR_SORTED
                AlphaBlendEnable = false;
                AlphaTestEnable = false;
                ZWriteEnable = true;
            #else
                AlphaBlendEnable = true;
                AlphaRef = 0x64;
                AlphaTestEnable = true;
            #endif //HAIR_SORTED
    
            VertexShader = compile vs_3_0 VS_PedTransformSkin();
            PixelShader = compile ps_3_0 PS_PedTexturedEight();
        }
    }
    
    technique unlit_drawskinned
    {
        pass p0
        {
            AlphaTestEnable = true;
            AlphaRef = 0x64;
            AlphaBlendEnable = true;
    
            VertexShader = compile vs_3_0 VS_PedTransformSkin();
            PixelShader = compile ps_3_0 PS_PedTexturedZero();
        }
    }
    
    technique lightweight0_drawskinned
    {
        pass p0
        {
            AlphaTestEnable = true;
            AlphaRef = 0x64;
            AlphaBlendEnable = true;
    
            VertexShader = compile vs_3_0 VS_PedTransformSkin();
            PixelShader = compile ps_3_0 PS_PedTexturedZero();
        }
    }
    
    technique lightweight4_drawskinned
    {
        pass p0
        {
            AlphaTestEnable = true;
            AlphaRef = 0x64;
            AlphaBlendEnable = true;
    
            VertexShader = compile vs_3_0 VS_PedTransformSkin();
            PixelShader = compile ps_3_0 PS_PedTexturedFour();
        }
    }
    
    technique deferred_draw
    {
        pass p0
        {
            #ifdef HAIR_SORTED
                ZWriteEnable = true;
                ColorWriteEnable = RED | GREEN | BLUE;
                ColorWriteEnable1 = RED | GREEN | BLUE;
                ColorWriteEnable2 = RED | GREEN | BLUE;
                ColorWriteEnable3 = RED | GREEN | BLUE | ALPHA;
            #endif //HAIR_SORTED

            VertexShader = compile vs_3_0 VS_PedTransformD();
            #ifdef HAIR_SORTED_EXP
                PixelShader = compile ps_3_0 PS_DeferredPedTexturedOnlyPedMaterialID();
            #else
                PixelShader = compile ps_3_0 PS_DeferredPedTextured();
            #endif //HAIR_SORTED_EXP
        }
        #ifdef HAIR_SORTED_EXP
            pass p1
            {
                VertexShader = compile vs_3_0 VS_PedTransformD();
                PixelShader = compile ps_3_0 PS_DeferredPedTextured();
            }        
        #endif //HAIR_SORTED_EXP
    }
    
    technique deferred_drawskinned
    {
        pass p0
        {
            #ifdef HAIR_SORTED
                CullMode = NONE;
                ZWriteEnable = true;
                ColorWriteEnable = RED | GREEN | BLUE;
                ColorWriteEnable1 = RED | GREEN | BLUE;
                ColorWriteEnable2 = RED | GREEN | BLUE;
                ColorWriteEnable3 = RED | GREEN | BLUE | ALPHA;
            #endif //HAIR_SORTED

            VertexShader = compile vs_3_0 VS_PedTransformSkinD();
            #ifdef HAIR_SORTED_EXP
                PixelShader = compile ps_3_0 PS_DeferredPedTexturedOnlyPedMaterialID();
            #else
                PixelShader = compile ps_3_0 PS_DeferredPedTextured();
            #endif //HAIR_SORTED_EXP
        }
        #ifdef HAIR_SORTED_EXP
            pass p1
            {
                VertexShader = compile vs_3_0 VS_PedTransformSkinD();
                PixelShader = compile ps_3_0 PS_DeferredPedTextured();
            }        
        #endif //HAIR_SORTED_EXP
    }
#endif //!NO_GENERATED_TECHNIQUES