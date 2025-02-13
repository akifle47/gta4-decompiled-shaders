//base for most shaders. you should use or extend this to reduce code duplication unless you really need specialized shaders for an effect

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
        //float3(IN.TexCoord0.xy, 1)
        float3 uv = IN.TexCoord0.xyx * float3(1.0, 1.0, 0.0) + float3(0.0, 0.0, 1.0);
        OUT.TexCoord.x = dot(globalAnimUV0, uv);
        OUT.TexCoord.y = dot(globalAnimUV1, uv);
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
        OUT.Position.xy = globalScreenSize.zw * (clipPos.w / 2) + clipPos.xy; //?
        #ifdef DEPTH_SHIFT_POSITIVE //bug?
            OUT.Position.z = clipPos.z + zShift;
        #else
            OUT.Position.z = clipPos.z - zShift;
        #endif //DEPTH_SHIFT_POSITIVE
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