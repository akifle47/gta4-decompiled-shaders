//base for most shaders. you should use or extend this to reduce code duplication unless you really need specialized shaders for an effect

#ifndef NO_LIGHTING
    void AlphaClip(float alpha, float2 screenCoords)
    {
        float y = saturate(alpha) * 3.996;
        float x = frac(y) * 4;
        float2 alphaOffset = float2((int)x, (int)y) / 4.0;

        float2 uvOffset = frac(abs(screenCoords.xy / 8));
        uvOffset = (screenCoords.xy >= 0) ? uvOffset : -uvOffset;
        uvOffset /= 4;
        
        float4 uv = float4(alphaOffset + uvOffset, 0, 0);
        if(tex2Dlod(StippleTexture, uv).y <= 0)
            discard;
    }
#endif

#ifdef ANIMATED
    float2 ComputeUvAnimation(in float2 texCoord)
    {
        //float3(IN.TexCoord0.xy, 1)
        float3 uv = texCoord.xyx * float3(1.0, 1.0, 0.0) + float3(0.0, 0.0, 1.0);
        return float2(dot(globalAnimUV0, uv), dot(globalAnimUV1, uv));
    }
#endif

#ifdef DEPTH_SHIFT
    float3 ComputeDepthShift(inout float4 clipPos)
    {
        float3 clipPosOut = clipPos.xyz;
        clipPosOut.xy = globalScreenSize.zw * (clipPos.w / 2) + clipPos.xy; //?
        #ifdef DEPTH_SHIFT_POSITIVE
            clipPosOut.z = clipPos.z + zShift;
        #else
            clipPosOut.z = clipPos.z - zShift;
        #endif //DEPTH_SHIFT_POSITIVE

        return clipPosOut;
    }
#endif

struct VS_Input
{
    float3 Position  : POSITION;
    float4 Color     : COLOR0;
    float2 TexCoord0 : TEXCOORD0;
    float2 TexCoord1 : TEXCOORD1; 
    float3 Normal    : NORMAL;
#if defined(NORMAL_MAP) || defined(PARALLAX)
    float4 Tangent   : TANGENT; 
#endif //NORMAL_MAP || PARALLAX
};

struct VS_Output
{
    float4 Position                 : POSITION;
    float2 TexCoord                 : TEXCOORD0;
    float4 WorldNormalAndDepthColor : TEXCOORD1;
#ifdef SPECULAR
    //view pos to vertex
    float3 ViewDir                  : TEXCOORD3;
#endif //SPECULAR
#if defined(NORMAL_MAP) || defined(PARALLAX)
    float3 WorldTangent             : TEXCOORD4; 
    float3 WorldBitangent           : TEXCOORD5; 
#endif //NORMAL_MAP || PARALLAX
    float4 Color                    : COLOR0;
    float4 WorldPosition            : TEXCOORD6;
#ifdef PARALLAX
    //(tangent) view pos to vertex
    float4 TangentViewDir           : TEXCOORD7;
#endif //PARALLAX
};

VS_Output VS_Transform(VS_Input IN)
{
    VS_Output OUT;
    
    float3 worldPos = mul(float4(IN.Position, 1.0), gWorld).xyz;

    #ifdef SPECULAR
        float3 viewDir = gViewInverse[3].xyz - worldPos;
        OUT.ViewDir = viewDir;
    #endif //SPECULAR
    OUT.WorldPosition.xyz = worldPos;
    
    float3 worldNormal = normalize(mul(IN.Normal, (float3x3)gWorld) + 0.00001);
    #if defined(NORMAL_MAP) || defined(PARALLAX)
        float3 worldTangent = normalize(mul(IN.Tangent.xyz, (float3x3)gWorld) + 0.00001);
        float3 worldBitangent = cross(worldTangent, worldNormal);
    #endif //NORMAL_MAP || PARALLAX

    OUT.WorldNormalAndDepthColor.xyz = worldNormal;

    #if defined(NORMAL_MAP) || defined(PARALLAX)
        OUT.WorldTangent.xyz = worldTangent;
        OUT.WorldBitangent.xyz = worldBitangent * IN.Tangent.w;
    #endif //NORMAL_MAP || PARALLAX

    #ifdef PARALLAX
        OUT.TangentViewDir.x = dot(worldTangent, viewDir);
        OUT.TangentViewDir.y = dot(worldBitangent, viewDir);
        OUT.TangentViewDir.z = dot(worldNormal, viewDir);
    #endif //PARALLAX

    #ifdef ANIMATED
        OUT.TexCoord = ComputeUvAnimation(IN.TexCoord0);
    #endif //ANIMATED

    #ifdef DAY_NIGHT_EFFECTS
        float2 color = gDayNightEffects.xy * IN.Color.xy;
        color.x = color.y + color.x;
        color.x = color.x * globalScalars.z  - 1;
        color.x = color.x * globalScalars2.z + 1;
        OUT.Color.xy = color.xx;
    #else
        OUT.Color.xy = IN.Color.xy;
    #endif //DAY_NIGHT_EFFECTS

    float4 clipPos = mul(float4(IN.Position, 1.0), gWorldViewProj);

    #ifdef DEPTH_SHIFT
        OUT.Position.xyz = ComputeDepthShift(clipPos);
    #else
        OUT.Position.xyz = clipPos.xyz;
    #endif //DEPTH_SHIFT

    OUT.Position.w = OUT.WorldNormalAndDepthColor.w = clipPos.w;
    #ifndef ANIMATED
        OUT.TexCoord = IN.TexCoord0;
    #endif //ANIMATED
    OUT.Color.zw = IN.Color.zw;

    OUT.WorldPosition.w = 1.0;
    #ifdef PARALLAX
        OUT.TangentViewDir.w = 1.0;
    #endif
    return OUT;
}

struct VS_OutputDeferred
{
    float4 Position                 : POSITION;
    float2 TexCoord                 : TEXCOORD0;
    float4 WorldNormalAndDepthColor : TEXCOORD1;
#ifdef ENVIRONMENT_MAP
    //view pos to vertex
    float3 ViewDir                  : TEXCOORD3;
#endif //ENVIRONMENT_MAP
#if defined(NORMAL_MAP) || defined(PARALLAX)
    float3 WorldTangent             : TEXCOORD4; 
    float3 WorldBitangent           : TEXCOORD5; 
#endif //NORMAL_MAP || PARALLAX
    float4 Color                    : COLOR0;
    float4 WorldPosition            : TEXCOORD6;
#ifdef PARALLAX
    //(tangent) view pos to vertex
    float4 TangentViewDir           : TEXCOORD7;
#endif //PARALLAX
};

//ignoring macros this produces the same result as VS_Transform just with some stuff moved around to generate the same(ish) assembly
VS_OutputDeferred VS_TransformD(VS_Input IN)
{
    VS_OutputDeferred OUT;
    
    float3 worldPos = mul(float4(IN.Position, 1.0), gWorld).xyz;
    float3 viewDir = gViewInverse[3].xyz - worldPos;

    #ifdef ENVIRONMENT_MAP
        OUT.ViewDir = viewDir;
    #endif //ENVIRONMENT_MAP
    OUT.WorldPosition.xyz = worldPos;
    
    #ifdef PARALLAX
        float3 worldTangent = normalize(mul(IN.Tangent.xyz, (float3x3)gWorld) + 0.00001);
        OUT.TangentViewDir.x = dot(worldTangent, viewDir);
        
        float3 worldNormal = normalize(mul(IN.Normal, (float3x3)gWorld) + 0.00001);
        float3 worldBitangent = cross(worldTangent, worldNormal);

        OUT.WorldTangent.xyz = worldTangent;
        worldBitangent *= IN.Tangent.w;
        OUT.TangentViewDir.y = dot(worldBitangent, viewDir);
        OUT.WorldBitangent.xyz = worldBitangent;
        OUT.TangentViewDir.z = dot(worldNormal, viewDir);
        OUT.WorldNormalAndDepthColor.xyz = worldNormal;
    #else
        float3 worldNormal = normalize(mul(IN.Normal, (float3x3)gWorld) + 0.00001);
        #if defined(NORMAL_MAP) || defined(PARALLAX)
            float3 worldTangent = normalize(mul(IN.Tangent.xyz, (float3x3)gWorld) + 0.00001);
            float3 worldBitangent = cross(worldTangent, worldNormal);
        #endif //NORMAL_MAP

        OUT.WorldNormalAndDepthColor.xyz = worldNormal;

        #if defined(NORMAL_MAP)
            OUT.WorldTangent.xyz = worldTangent;
            OUT.WorldBitangent.xyz = worldBitangent * IN.Tangent.w;
        #endif //NORMAL_MAP
    #endif //PARALLAX

    #ifdef ANIMATED
        OUT.TexCoord = ComputeUvAnimation(IN.TexCoord0);
    #endif //ANIMATED

    #if !defined(DIRT_DECAL_MASK) && !defined(NO_LIGHTING) //idk
        float2 color = gDayNightEffects.xy * IN.Color.xy;
        color.x = color.y + color.x;
        color.x = color.x * globalScalars.z  - 1;
        color.x = color.x * globalScalars2.z + 1;
        OUT.Color.xy = color.xx;
    #else
        OUT.Color.xy = IN.Color.xy;
    #endif //DIRT_DECAL_MASK

    float4 clipPos = mul(float4(IN.Position, 1.0), gWorldViewProj);

    #ifdef DEPTH_SHIFT
        OUT.Position.xyz = ComputeDepthShift(clipPos);
    #else
        OUT.Position.xyz = clipPos.xyz;
    #endif //DEPTH_SHIFT

    OUT.Position.w = OUT.WorldNormalAndDepthColor.w = clipPos.w;
    #ifndef ANIMATED
        OUT.TexCoord = IN.TexCoord0;
    #endif //ANIMATED
    OUT.Color.zw = IN.Color.zw;

    OUT.WorldPosition.w = 1.0;
    #ifdef PARALLAX
        OUT.TangentViewDir.w = 1.0;
    #endif
    return OUT;
}

VS_OutputDeferred VS_TransformAlphaClipD(VS_Input IN)
{
    return VS_TransformD(IN);
}


struct VS_TransformUnlitInput
{
    float3 Position : POSITION;
    float4 Color    : COLOR;
    float2 TexCoord : TEXCOORD0;
};

struct VS_TransformUnlitOutput
{
    float4 Position : POSITION;
    float2 TexCoord : TEXCOORD0;
    float4 Color    : COLOR;
};

VS_TransformUnlitOutput VS_TransformUnlit(VS_TransformUnlitInput IN)
{
    VS_TransformUnlitOutput OUT;

    float4 clipPos = mul(float4(IN.Position, 1.0), gWorldViewProj);
    #ifndef DEPTH_SHIFT
        OUT.Position = clipPos;
    #endif //DEPTH_SHIFT

    #ifdef ANIMATED
        OUT.TexCoord = ComputeUvAnimation(IN.TexCoord);
    #else
        OUT.TexCoord = IN.TexCoord;
    #endif //ANIMATED

    #ifdef DEPTH_SHIFT
        OUT.Position.xyz = ComputeDepthShift(clipPos);
        OUT.Position.w = clipPos.w;
    #endif

    OUT.Color = IN.Color;
    return OUT;
}

VS_TransformUnlitOutput VS_VehicleTransformUnlit(VS_TransformUnlitInput IN)
{
    return VS_TransformUnlit(IN);
}


#ifndef NO_SHADOW_CASTING 
    struct VS_ShadowDepthInput
    {
        float3 Position : POSITION;
    #ifdef ALPHA_SHADOW
        float2 TexCoord : TEXCOORD0;
    #endif //ALPHA_SHADOW
    };
    struct VS_ShadowDepthOutput
    {
        float4 Position              : POSITION;
    #ifdef ALPHA_SHADOW
        float3 DepthColorAndTexCoord : TEXCOORD0;
    #else
        float  DepthColor            : TEXCOORD0;
    #endif //ALPHA_SHADOW
    };

    VS_ShadowDepthOutput VS_ShadowDepth(VS_ShadowDepthInput IN)
    {
        VS_ShadowDepthOutput OUT;
        float4 clipPos = mul(mul(float4(IN.Position, 1),  gWorld), gShadowMatrix);
        OUT.Position.z = 1.0 - min(clipPos.z, 1.0);
        OUT.Position.xyw = clipPos.xyw * float3(1, 1, 0) + float3(0, 0, 1);
        #ifdef ALPHA_SHADOW
            OUT.DepthColorAndTexCoord.x = clipPos.w;
            OUT.DepthColorAndTexCoord.yz = IN.TexCoord;
        #else
            OUT.DepthColor = clipPos.w;
        #endif //ALPHA_SHADOW
        return OUT;
    }

    #ifdef ALPHA_SHADOW
        float4 PS_ShadowDepth(VS_ShadowDepthOutput IN, float2 screenCoords : VPOS) : COLOR
    #else
        float4 PS_ShadowDepth(VS_ShadowDepthOutput IN) : COLOR
    #endif //ALPHA_SHADOW
    {
        #ifdef ALPHA_SHADOW
            float alpha = tex2D(TextureSampler, IN.DepthColorAndTexCoord.yz).a * globalScalars.x;
            AlphaClip(alpha, screenCoords);
            return float4(IN.DepthColorAndTexCoord.xxx, alpha);
        #else
            return IN.DepthColor.x * float4(1, 1, 1, 0) + float4(0, 0, 0, 1);
        #endif //ALPHA_SHADOW
    }

    //probably something they wanted to implement in the pc port as an optimization but didn't have time 
    //to finish it so it's always the same as PS_ShadowDepth
    #ifdef ALPHA_SHADOW
        float4 PS_ShadowDepthMasked(VS_ShadowDepthOutput IN, float2 screenCoords : VPOS) : COLOR
    #else
        float4 PS_ShadowDepthMasked(VS_ShadowDepthOutput IN) : COLOR
    #endif //ALPHA_SHADOW
    {
        #ifdef ALPHA_SHADOW
            return PS_ShadowDepth(IN, screenCoords);
        #else
            return PS_ShadowDepth(IN);
        #endif //ALPHA_SHADOW
    }
#endif //NO_SHADOW_CASTING


struct VS_BlitInput
{
    float3 Position : POSITION;
    float2 TexCoord : TEXCOORD0;
};
struct VS_BlitOutput
{
    float4 Position : POSITION;
    float4 TexCoord : TEXCOORD0;
};
VS_BlitOutput VS_Blit(VS_BlitInput IN)
{
    VS_BlitOutput OUT;
    OUT.Position = IN.Position.xyzx * float4(1, 1, 1, 0) + float4(0, 0, 0, 1);
    OUT.TexCoord = IN.TexCoord.xyxx * float4(1, 1, 0, 0);
    return OUT;
}

struct VS_BlitPositionOnlyInput
{
    float3 Position : POSITION;
};

float4 VS_BlitPositionOnly(VS_BlitPositionOnlyInput IN) : POSITION
{
    return IN.Position.xyzx * float4(1, 1, 1, 0) + float4(0, 0, 0, 1);
}

//[0] TODO: make this a part of the megashader's VS_TransformUnlit
//[1] TODO: make this a part of the megashader's VS_VehicleTransformUnlit