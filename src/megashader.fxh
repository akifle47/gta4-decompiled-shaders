//base for most shaders. you should use or extend this to reduce code duplication unless you really need specialized shaders for an effect

#define PARABOLOID_HEIGHT_OFFSET 512

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

    float2 ComputeDayNightEffects(in float2 vertexColor)
    {
        float2 color = gDayNightEffects.xy * vertexColor;
        color.x = color.y + color.x;
        color.x = color.x * globalScalars.z  - 1;
        color.x = color.x * globalScalars2.z + 1;
        return color.xx;
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
    float3 ComputeDepthShift(inout float4 posClip)
    {
        float3 posClipOut = posClip.xyz;
        posClipOut.xy = globalScreenSize.zw * (posClip.w / 2) + posClip.xy; //?
        #ifdef DEPTH_SHIFT_POSITIVE
            posClipOut.z = posClip.z + zShift;
        #else
            posClipOut.z = posClip.z - zShift;
        #endif //DEPTH_SHIFT_POSITIVE

        return posClipOut;
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
    float4 NormalWorldAndDepthColor : TEXCOORD1;
#ifdef SPECULAR
    //view pos to vertex
    float3 ViewDir                  : TEXCOORD3;
#endif //SPECULAR
#if defined(NORMAL_MAP) || defined(PARALLAX)
    float3 TangentWorld             : TEXCOORD4; 
    float3 WorldBitangent           : TEXCOORD5; 
#endif //NORMAL_MAP || PARALLAX
    float4 Color                    : COLOR0;
    float4 PositionWorld            : TEXCOORD6;
#ifdef PARALLAX
    //(tangent) view pos to vertex
    float4 ViewDirTangent           : TEXCOORD7;
#endif //PARALLAX
};

VS_Output VS_Transform(VS_Input IN)
{
    VS_Output OUT;
    
    float3 posWorld = mul(float4(IN.Position, 1.0), gWorld).xyz;

    #ifdef SPECULAR
        float3 viewDir = gViewInverse[3].xyz - posWorld;
        OUT.ViewDir = viewDir;
    #endif //SPECULAR
    OUT.PositionWorld.xyz = posWorld;
    
    float3 normalWorld = normalize(mul(IN.Normal, (float3x3)gWorld) + 0.00001);
    #if defined(NORMAL_MAP) || defined(PARALLAX)
        float3 tangentWorld = normalize(mul(IN.Tangent.xyz, (float3x3)gWorld) + 0.00001);
        float3 bitangentWorld = cross(tangentWorld, normalWorld);
    #endif //NORMAL_MAP || PARALLAX

    OUT.NormalWorldAndDepthColor.xyz = normalWorld;

    #if defined(NORMAL_MAP) || defined(PARALLAX)
        OUT.TangentWorld.xyz = tangentWorld;
        OUT.WorldBitangent.xyz = bitangentWorld * IN.Tangent.w;
    #endif //NORMAL_MAP || PARALLAX

    #ifdef PARALLAX
        OUT.ViewDirTangent.x = dot(tangentWorld, viewDir);
        OUT.ViewDirTangent.y = dot(bitangentWorld, viewDir);
        OUT.ViewDirTangent.z = dot(normalWorld, viewDir);
    #endif //PARALLAX

    #ifdef ANIMATED
        OUT.TexCoord = ComputeUvAnimation(IN.TexCoord0);
    #endif //ANIMATED

    #ifdef DAY_NIGHT_EFFECTS
        OUT.Color.xy = ComputeDayNightEffects(IN.Color.xy);
    #else
        OUT.Color.xy = IN.Color.xy;
    #endif //DAY_NIGHT_EFFECTS

    float4 posClip = mul(float4(IN.Position, 1.0), gWorldViewProj);

    #ifdef DEPTH_SHIFT
        OUT.Position.xyz = ComputeDepthShift(posClip);
    #else
        OUT.Position.xyz = posClip.xyz;
    #endif //DEPTH_SHIFT

    OUT.Position.w = OUT.NormalWorldAndDepthColor.w = posClip.w;
    #ifndef ANIMATED
        OUT.TexCoord = IN.TexCoord0;
    #endif //ANIMATED
    OUT.Color.zw = IN.Color.zw;

    OUT.PositionWorld.w = 1.0;
    #ifdef PARALLAX
        OUT.ViewDirTangent.w = 1.0;
    #endif
    return OUT;
}


struct VS_OutputDeferred
{
    float4 Position                 : POSITION;
    float2 TexCoord                 : TEXCOORD0;
    float4 NormalWorldAndDepthColor : TEXCOORD1;
#ifdef ENVIRONMENT_MAP
    //view pos to vertex
    float3 ViewDir                  : TEXCOORD3;
#endif //ENVIRONMENT_MAP
#if defined(NORMAL_MAP) || defined(PARALLAX)
    float3 TangentWorld             : TEXCOORD4; 
    float3 WorldBitangent           : TEXCOORD5; 
#endif //NORMAL_MAP || PARALLAX
    float4 Color                    : COLOR0;
    float4 PositionWorld            : TEXCOORD6;
#ifdef PARALLAX
    //(tangent) view pos to vertex
    float4 ViewDirTangent           : TEXCOORD7;
#endif //PARALLAX
};

//ignoring macros this produces the same result as VS_Transform just with some stuff moved around to generate the same(ish) assembly
VS_OutputDeferred VS_TransformD(VS_Input IN)
{
    VS_OutputDeferred OUT;
    
    float3 posWorld = mul(float4(IN.Position, 1.0), gWorld).xyz;
    float3 viewDir = gViewInverse[3].xyz - posWorld;

    #ifdef ENVIRONMENT_MAP
        OUT.ViewDir = viewDir;
    #endif //ENVIRONMENT_MAP
    OUT.PositionWorld.xyz = posWorld;
    
    #ifdef PARALLAX
        float3 tangentWorld = normalize(mul(IN.Tangent.xyz, (float3x3)gWorld) + 0.00001);
        OUT.ViewDirTangent.x = dot(tangentWorld, viewDir);
        
        float3 normalWorld = normalize(mul(IN.Normal, (float3x3)gWorld) + 0.00001);
        float3 bitangentWorld = cross(tangentWorld, normalWorld);

        OUT.TangentWorld.xyz = tangentWorld;
        bitangentWorld *= IN.Tangent.w;
        OUT.ViewDirTangent.y = dot(bitangentWorld, viewDir);
        OUT.WorldBitangent.xyz = bitangentWorld;
        OUT.ViewDirTangent.z = dot(normalWorld, viewDir);
        OUT.NormalWorldAndDepthColor.xyz = normalWorld;
    #else
        float3 normalWorld = normalize(mul(IN.Normal, (float3x3)gWorld) + 0.00001);
        #if defined(NORMAL_MAP) || defined(PARALLAX)
            float3 tangentWorld = normalize(mul(IN.Tangent.xyz, (float3x3)gWorld) + 0.00001);
            float3 bitangentWorld = cross(tangentWorld, normalWorld);
        #endif //NORMAL_MAP

        OUT.NormalWorldAndDepthColor.xyz = normalWorld;

        #if defined(NORMAL_MAP)
            OUT.TangentWorld.xyz = tangentWorld;
            OUT.WorldBitangent.xyz = bitangentWorld * IN.Tangent.w;
        #endif //NORMAL_MAP
    #endif //PARALLAX

    #ifdef ANIMATED
        OUT.TexCoord = ComputeUvAnimation(IN.TexCoord0);
    #endif //ANIMATED

    #if !defined(DIRT_DECAL_MASK) && !defined(NO_LIGHTING) //idk
        OUT.Color.xy = ComputeDayNightEffects(IN.Color.xy);
    #else
        OUT.Color.xy = IN.Color.xy;
    #endif //DIRT_DECAL_MASK

    float4 posClip = mul(float4(IN.Position, 1.0), gWorldViewProj);

    #ifdef DEPTH_SHIFT
        OUT.Position.xyz = ComputeDepthShift(posClip);
    #else
        OUT.Position.xyz = posClip.xyz;
    #endif //DEPTH_SHIFT

    OUT.Position.w = OUT.NormalWorldAndDepthColor.w = posClip.w;
    #ifndef ANIMATED
        OUT.TexCoord = IN.TexCoord0;
    #endif //ANIMATED
    OUT.Color.zw = IN.Color.zw;

    OUT.PositionWorld.w = 1.0;
    #ifdef PARALLAX
        OUT.ViewDirTangent.w = 1.0;
    #endif
    return OUT;
}

VS_OutputDeferred VS_TransformAlphaClipD(VS_Input IN)
{
    return VS_TransformD(IN);
}


struct VS_InputUnlit
{
    float3 Position : POSITION;
    float4 Color    : COLOR;
    float2 TexCoord : TEXCOORD0;
};

struct VS_OutputUnlit
{
    float4 Position : POSITION;
    float2 TexCoord : TEXCOORD0;
    float4 Color    : COLOR;
};

VS_OutputUnlit VS_TransformUnlit(VS_InputUnlit IN)
{
    VS_OutputUnlit OUT;

    float4 posClip = mul(float4(IN.Position, 1.0), gWorldViewProj);
    #ifndef DEPTH_SHIFT
        OUT.Position = posClip;
    #endif //DEPTH_SHIFT

    #ifdef ANIMATED
        OUT.TexCoord = ComputeUvAnimation(IN.TexCoord);
    #else
        OUT.TexCoord = IN.TexCoord;
    #endif //ANIMATED

    #ifdef DEPTH_SHIFT
        OUT.Position.xyz = ComputeDepthShift(posClip);
        OUT.Position.w = posClip.w;
    #endif

    OUT.Color = IN.Color;
    return OUT;
}

VS_OutputUnlit VS_VehicleTransformUnlit(VS_InputUnlit IN)
{
    return VS_TransformUnlit(IN);
}


struct VS_InputParaboloid
{
    float3 Position : POSITION;
    float4 Color    : COLOR0;
    float2 TexCoord : TEXCOORD0;
    float3 Normal   : NORMAL;
};

struct VS_OutputParaboloid
{
    float4 Position            : POSITION;
    float2 TexCoord            : TEXCOORD0;
    float4 NormalWorldAndDepth : TEXCOORD1;
    //view pos to world pos 
    float3 ViewDir             : TEXCOORD3;
    float4 Color               : COLOR0;
};

VS_OutputParaboloid VS_TransformParaboloid(VS_InputParaboloid IN)
{
    VS_OutputParaboloid OUT;
    
    OUT.NormalWorldAndDepth.xyz = normalize(mul(IN.Normal, (float3x3)gWorld) + 0.00001);

    float3 posWorld = mul(float4(IN.Position, 1.0), gWorld).xyz;
    float3 viewDir = gViewInverse[3].xyz - posWorld;
    OUT.ViewDir = -viewDir;

    float3 posView = mul(float4(IN.Position, 1.0), gWorldView).xyz;
    posView.z += PARABOLOID_HEIGHT_OFFSET;
    float L = length(posView);
    posView.z = 1.0 - (posView.z / L);
    posView.z *= L;

    OUT.Position.xy = posView.xy / posView.z;
    OUT.NormalWorldAndDepth.w = L;
    L = 1.0 / (L + 1.0);
    OUT.Position.z = 1.0 - L;

    #ifdef ANIMATED
        OUT.TexCoord = ComputeUvAnimation(IN.TexCoord);
    #endif //ANIMATED

    #ifdef DAY_NIGHT_EFFECTS
        OUT.Color.xy = ComputeDayNightEffects(IN.Color.xy);
    #else
        OUT.Color.xy = IN.Color.xy;
    #endif //DAY_NIGHT_EFFECTS

    OUT.Position.w = 1.0;
    #ifndef ANIMATED
        OUT.TexCoord = IN.TexCoord;
    #endif //ANIMATED
    OUT.Color.zw = IN.Color.zw;

    return OUT;
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
        float4 posClip = mul(mul(float4(IN.Position, 1),  gWorld), gShadowMatrix);
        OUT.Position.z = 1.0 - min(posClip.z, 1.0);
        OUT.Position.xyw = posClip.xyw * float3(1, 1, 0) + float3(0, 0, 1);
        #ifdef ALPHA_SHADOW
            OUT.DepthColorAndTexCoord.x = posClip.w;
            OUT.DepthColorAndTexCoord.yz = IN.TexCoord;
        #else
            OUT.DepthColor = posClip.w;
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


struct VS_InputBlit
{
    float3 Position : POSITION;
    float2 TexCoord : TEXCOORD0;
};
struct VS_OutputBlit
{
    float4 Position : POSITION;
    float4 TexCoord : TEXCOORD0;
};
VS_OutputBlit VS_Blit(VS_InputBlit IN)
{
    VS_OutputBlit OUT;
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


//TODO: make these a part of VS_VehicleTransformUnlit
#ifdef VEHICLE_DAMAGE
    #ifdef DIRT_UV
        #ifdef DIFFUSE_TEXTURE2
            VertexShader VS_VehicleTransformUnlitVehicleDamage
            <
                string BoundRadius    = "parameter register(208)";
                string DamageSampler  = "parameter register(0)";
                string gWorldViewProj = "parameter register(8)";
                string switchOn       = "parameter register(8)";
            > =
            asm
            {
                //
                // Generated by Microsoft (R) HLSL Shader Compiler 9.26.952.2844
                //
                // Parameters:
                //
                //   float BoundRadius;
                //   sampler2D DamageSampler;
                //   row_major float4x4 gWorldViewProj;
                //   bool switchOn;
                //
                //
                // Registers:
                //
                //   Name           Reg   Size
                //   -------------- ----- ----
                //   switchOn       b8       1
                //   gWorldViewProj c8       4
                //   BoundRadius    c208     1
                //   DamageSampler  s0       1
                //
                
                    vs_3_0
                    def c0, 9.99999975e-006, 1, 0.5, 126.732674
                    def c1, 0, 0.00789062493, 1.52587891e-005, 65536
                    def c2, 0.00390625, 256, -128, 0.0078125
                    dcl_position v0
                    dcl_color v1
                    dcl_texcoord v2
                    dcl_texcoord1 v3
                    dcl_2d s0
                    dcl_position o0
                    dcl_texcoord o1
                    dcl_color o2
                    if b8
                      dp3 r0.x, v0, v0
                      rsq r0.x, r0.x
                      rcp r0.x, r0.x
                      add r0.y, r0.x, c0.x
                      rcp r0.y, r0.y
                      mad r0.z, v0.z, -r0.y, c0.y
                      mul r0.z, r0.z, c0.z
                      mad r0.yw, v0.xxzy, r0.y, c0.x
                      mul r1.xy, r0.ywzw, r0.ywzw
                      add r1.x, r1.y, r1.x
                      rsq r1.x, r1.x
                      mul r0.yw, r0, r1.x
                      mul r0.yz, r0.z, r0.xyww
                      mad r1.xy, r0.yzzw, c0.z, c0.z
                      mul r0.yz, r1.xxyw, c0.w
                      frc r2.xy, r0_abs.yzzw
                      sge r0.yz, r0, -r0
                      lrp r3.xy, r0.yzzw, r2, -r2
                      mov r1.zw, c1.x
                      texldl r2, r1, s0
                      mad r0.yz, r3.xxyw, -c1.y, r1.xxyw
                      add r1.xy, r0.yzzw, c1.yxzw
                      mov r1.zw, c1.x
                      texldl r1, r1, s0
                      add r4.xy, r0.yzzw, c1
                      mov r4.zw, c1.x
                      texldl r4, r4, s0
                      add r5.xy, r0.yzzw, c1.y
                      mov r5.zw, c1.x
                      texldl r5, r5, s0
                      mul r0.y, r2.x, c1.z
                      frc r0.z, r0.y
                      add r0.w, r0.y, -r0.z
                      slt r0.y, r0.y, -r0.y
                      slt r0.z, -r0.z, r0.z
                      mad r6.z, r0.y, r0.z, r0.w
                      mad r0.y, r6.z, -c1.w, r2.x
                      mul r0.z, r0.y, c2.x
                      frc r0.w, r0.z
                      add r1.y, r0.z, -r0.w
                      slt r0.z, r0.z, -r0.z
                      slt r0.w, -r0.w, r0.w
                      mad r6.y, r0.z, r0.w, r1.y
                      mad r6.x, r6.y, -c2.y, r0.y
                      mul r0.y, r1.x, c1.z
                      frc r0.z, r0.y
                      add r0.w, r0.y, -r0.z
                      slt r0.y, r0.y, -r0.y
                      slt r0.z, -r0.z, r0.z
                      mad r2.z, r0.y, r0.z, r0.w
                      mad r0.y, r2.z, -c1.w, r1.x
                      mul r0.z, r0.y, c2.x
                      frc r0.w, r0.z
                      add r1.x, r0.z, -r0.w
                      slt r0.z, r0.z, -r0.z
                      slt r0.w, -r0.w, r0.w
                      mad r2.y, r0.z, r0.w, r1.x
                      mad r2.x, r2.y, -c2.y, r0.y
                      mul r0.y, r4.x, c1.z
                      frc r0.z, r0.y
                      add r0.w, r0.y, -r0.z
                      slt r0.y, r0.y, -r0.y
                      slt r0.z, -r0.z, r0.z
                      mad r1.z, r0.y, r0.z, r0.w
                      mad r0.y, r1.z, -c1.w, r4.x
                      mul r0.z, r0.y, c2.x
                      frc r0.w, r0.z
                      add r1.w, r0.z, -r0.w
                      slt r0.z, r0.z, -r0.z
                      slt r0.w, -r0.w, r0.w
                      mad r1.y, r0.z, r0.w, r1.w
                      mad r1.x, r1.y, -c2.y, r0.y
                      mul r0.y, r5.x, c1.z
                      frc r0.z, r0.y
                      add r0.w, r0.y, -r0.z
                      slt r0.y, r0.y, -r0.y
                      slt r0.z, -r0.z, r0.z
                      mad r4.z, r0.y, r0.z, r0.w
                      mad r0.y, r4.z, -c1.w, r5.x
                      mul r0.z, r0.y, c2.x
                      frc r0.w, r0.z
                      add r1.w, r0.z, -r0.w
                      slt r0.z, r0.z, -r0.z
                      slt r0.w, -r0.w, r0.w
                      mad r4.y, r0.z, r0.w, r1.w
                      mad r4.x, r4.y, -c2.y, r0.y
                      add r0.yz, -r3.xxyw, c0.y
                      mul r5.xyz, r6, r0.y
                      mul r2.xyz, r3.x, r2
                      mul r2.xyz, r0.z, r2
                      mad r2.xyz, r5, r0.z, r2
                      mul r0.yzw, r1.xxyz, r0.y
                      mad r0.yzw, r0, r3.y, r2.xxyz
                      mul r1.xyz, r3.x, r4
                      mad r0.yzw, r1.xxyz, r3.y, r0
                      add r0.yzw, r0, c2.z
                      mul r0.yzw, r0, c2.w
                      rcp r1.x, c208.x
                      mul r0.x, r0.x, r1.x
                      min r0.x, r0.x, c0.y
                      mul r0.xyz, r0.yzww, r0.x
                      mad r0.xyz, r0, c0.z, v0
                    else
                      mov r0.xyz, v0
                    endif
                    mul r1, r0.y, c9
                    mad r1, r0.x, c8, r1
                    mad r0, r0.z, c10, r1
                    add o0, r0, c11
                    mov o1.xy, v2
                    mov o1.zw, v3.xyxy
                    mov o2, v1
                
                // approximately 119 instruction slots used (8 texture, 111 arithmetic)
            };
        #else
            VertexShader VS_VehicleTransformUnlitVehicleDamage
            <
                string BoundRadius    = "parameter register(208)";
                string DamageSampler  = "parameter register(0)";
                string gWorldViewProj = "parameter register(8)";
                string switchOn       = "parameter register(8)";
            > =
            asm
            {
                //
                // Generated by Microsoft (R) HLSL Shader Compiler 9.26.952.2844
                //
                // Parameters:
                //
                //   float BoundRadius;
                //   sampler2D DamageSampler;
                //   row_major float4x4 gWorldViewProj;
                //   bool switchOn;
                //
                //
                // Registers:
                //
                //   Name           Reg   Size
                //   -------------- ----- ----
                //   switchOn       b8       1
                //   gWorldViewProj c8       4
                //   BoundRadius    c208     1
                //   DamageSampler  s0       1
                //
                
                    vs_3_0
                    def c0, 9.99999975e-006, 1, 0.5, 126.732674
                    def c1, 0, 0.00789062493, 1.52587891e-005, 65536
                    def c2, 0.00390625, 256, -128, 0.0078125
                    dcl_position v0
                    dcl_color v1
                    dcl_texcoord v2
                    dcl_texcoord1 v3
                    dcl_2d s0
                    dcl_position o0
                    dcl_texcoord o1.xy
                    dcl_color o2
                    dcl_texcoord1 o3.xy
                    if b8
                      dp3 r0.x, v0, v0
                      rsq r0.x, r0.x
                      rcp r0.x, r0.x
                      add r0.y, r0.x, c0.x
                      rcp r0.y, r0.y
                      mad r0.z, v0.z, -r0.y, c0.y
                      mul r0.z, r0.z, c0.z
                      mad r0.yw, v0.xxzy, r0.y, c0.x
                      mul r1.xy, r0.ywzw, r0.ywzw
                      add r1.x, r1.y, r1.x
                      rsq r1.x, r1.x
                      mul r0.yw, r0, r1.x
                      mul r0.yz, r0.z, r0.xyww
                      mad r1.xy, r0.yzzw, c0.z, c0.z
                      mul r0.yz, r1.xxyw, c0.w
                      frc r2.xy, r0_abs.yzzw
                      sge r0.yz, r0, -r0
                      lrp r3.xy, r0.yzzw, r2, -r2
                      mov r1.zw, c1.x
                      texldl r2, r1, s0
                      mad r0.yz, r3.xxyw, -c1.y, r1.xxyw
                      add r1.xy, r0.yzzw, c1.yxzw
                      mov r1.zw, c1.x
                      texldl r1, r1, s0
                      add r4.xy, r0.yzzw, c1
                      mov r4.zw, c1.x
                      texldl r4, r4, s0
                      add r5.xy, r0.yzzw, c1.y
                      mov r5.zw, c1.x
                      texldl r5, r5, s0
                      mul r0.y, r2.x, c1.z
                      frc r0.z, r0.y
                      add r0.w, r0.y, -r0.z
                      slt r0.y, r0.y, -r0.y
                      slt r0.z, -r0.z, r0.z
                      mad r6.z, r0.y, r0.z, r0.w
                      mad r0.y, r6.z, -c1.w, r2.x
                      mul r0.z, r0.y, c2.x
                      frc r0.w, r0.z
                      add r1.y, r0.z, -r0.w
                      slt r0.z, r0.z, -r0.z
                      slt r0.w, -r0.w, r0.w
                      mad r6.y, r0.z, r0.w, r1.y
                      mad r6.x, r6.y, -c2.y, r0.y
                      mul r0.y, r1.x, c1.z
                      frc r0.z, r0.y
                      add r0.w, r0.y, -r0.z
                      slt r0.y, r0.y, -r0.y
                      slt r0.z, -r0.z, r0.z
                      mad r2.z, r0.y, r0.z, r0.w
                      mad r0.y, r2.z, -c1.w, r1.x
                      mul r0.z, r0.y, c2.x
                      frc r0.w, r0.z
                      add r1.x, r0.z, -r0.w
                      slt r0.z, r0.z, -r0.z
                      slt r0.w, -r0.w, r0.w
                      mad r2.y, r0.z, r0.w, r1.x
                      mad r2.x, r2.y, -c2.y, r0.y
                      mul r0.y, r4.x, c1.z
                      frc r0.z, r0.y
                      add r0.w, r0.y, -r0.z
                      slt r0.y, r0.y, -r0.y
                      slt r0.z, -r0.z, r0.z
                      mad r1.z, r0.y, r0.z, r0.w
                      mad r0.y, r1.z, -c1.w, r4.x
                      mul r0.z, r0.y, c2.x
                      frc r0.w, r0.z
                      add r1.w, r0.z, -r0.w
                      slt r0.z, r0.z, -r0.z
                      slt r0.w, -r0.w, r0.w
                      mad r1.y, r0.z, r0.w, r1.w
                      mad r1.x, r1.y, -c2.y, r0.y
                      mul r0.y, r5.x, c1.z
                      frc r0.z, r0.y
                      add r0.w, r0.y, -r0.z
                      slt r0.y, r0.y, -r0.y
                      slt r0.z, -r0.z, r0.z
                      mad r4.z, r0.y, r0.z, r0.w
                      mad r0.y, r4.z, -c1.w, r5.x
                      mul r0.z, r0.y, c2.x
                      frc r0.w, r0.z
                      add r1.w, r0.z, -r0.w
                      slt r0.z, r0.z, -r0.z
                      slt r0.w, -r0.w, r0.w
                      mad r4.y, r0.z, r0.w, r1.w
                      mad r4.x, r4.y, -c2.y, r0.y
                      add r0.yz, -r3.xxyw, c0.y
                      mul r5.xyz, r6, r0.y
                      mul r2.xyz, r3.x, r2
                      mul r2.xyz, r0.z, r2
                      mad r2.xyz, r5, r0.z, r2
                      mul r0.yzw, r1.xxyz, r0.y
                      mad r0.yzw, r0, r3.y, r2.xxyz
                      mul r1.xyz, r3.x, r4
                      mad r0.yzw, r1.xxyz, r3.y, r0
                      add r0.yzw, r0, c2.z
                      mul r0.yzw, r0, c2.w
                      rcp r1.x, c208.x
                      mul r0.x, r0.x, r1.x
                      min r0.x, r0.x, c0.y
                      mul r0.xyz, r0.yzww, r0.x
                      mad r0.xyz, r0, c0.z, v0
                    else
                      mov r0.xyz, v0
                    endif
                    mul r1, r0.y, c9
                    mad r1, r0.x, c8, r1
                    mad r0, r0.z, c10, r1
                    add o0, r0, c11
                    mov o1.xy, v2
                    mov o2, v1
                    mov o3.xy, v3
                
                // approximately 119 instruction slots used (8 texture, 111 arithmetic)
            };
        #endif
    #else
        VertexShader VS_VehicleTransformUnlitVehicleDamage
        <
            string BoundRadius    = "parameter register(208)";
            string DamageSampler  = "parameter register(0)";
            string gWorldViewProj = "parameter register(8)";
            string switchOn       = "parameter register(8)";
        > =
        asm
        {
            //
            // Generated by Microsoft (R) HLSL Shader Compiler 9.26.952.2844
            //
            // Parameters:
            //
            //   float BoundRadius;
            //   sampler2D DamageSampler;
            //   row_major float4x4 gWorldViewProj;
            //   bool switchOn;
            //
            //
            // Registers:
            //
            //   Name           Reg   Size
            //   -------------- ----- ----
            //   switchOn       b8       1
            //   gWorldViewProj c8       4
            //   BoundRadius    c208     1
            //   DamageSampler  s0       1
            //
            
                vs_3_0
                def c0, 9.99999975e-006, 1, 0.5, 126.732674
                def c1, 0, 0.00789062493, 1.52587891e-005, 65536
                def c2, 0.00390625, 256, -128, 0.0078125
                dcl_position v0
                dcl_color v1
                dcl_texcoord v2
                dcl_2d s0
                dcl_position o0
                dcl_texcoord o1.xy
                dcl_color o2
                if b8
                  dp3 r0.x, v0, v0
                  rsq r0.x, r0.x
                  rcp r0.x, r0.x
                  add r0.y, r0.x, c0.x
                  rcp r0.y, r0.y
                  mad r0.z, v0.z, -r0.y, c0.y
                  mul r0.z, r0.z, c0.z
                  mad r0.yw, v0.xxzy, r0.y, c0.x
                  mul r1.xy, r0.ywzw, r0.ywzw
                  add r1.x, r1.y, r1.x
                  rsq r1.x, r1.x
                  mul r0.yw, r0, r1.x
                  mul r0.yz, r0.z, r0.xyww
                  mad r1.xy, r0.yzzw, c0.z, c0.z
                  mul r0.yz, r1.xxyw, c0.w
                  frc r2.xy, r0_abs.yzzw
                  sge r0.yz, r0, -r0
                  lrp r3.xy, r0.yzzw, r2, -r2
                  mov r1.zw, c1.x
                  texldl r2, r1, s0
                  mad r0.yz, r3.xxyw, -c1.y, r1.xxyw
                  add r1.xy, r0.yzzw, c1.yxzw
                  mov r1.zw, c1.x
                  texldl r1, r1, s0
                  add r4.xy, r0.yzzw, c1
                  mov r4.zw, c1.x
                  texldl r4, r4, s0
                  add r5.xy, r0.yzzw, c1.y
                  mov r5.zw, c1.x
                  texldl r5, r5, s0
                  mul r0.y, r2.x, c1.z
                  frc r0.z, r0.y
                  add r0.w, r0.y, -r0.z
                  slt r0.y, r0.y, -r0.y
                  slt r0.z, -r0.z, r0.z
                  mad r6.z, r0.y, r0.z, r0.w
                  mad r0.y, r6.z, -c1.w, r2.x
                  mul r0.z, r0.y, c2.x
                  frc r0.w, r0.z
                  add r1.y, r0.z, -r0.w
                  slt r0.z, r0.z, -r0.z
                  slt r0.w, -r0.w, r0.w
                  mad r6.y, r0.z, r0.w, r1.y
                  mad r6.x, r6.y, -c2.y, r0.y
                  mul r0.y, r1.x, c1.z
                  frc r0.z, r0.y
                  add r0.w, r0.y, -r0.z
                  slt r0.y, r0.y, -r0.y
                  slt r0.z, -r0.z, r0.z
                  mad r2.z, r0.y, r0.z, r0.w
                  mad r0.y, r2.z, -c1.w, r1.x
                  mul r0.z, r0.y, c2.x
                  frc r0.w, r0.z
                  add r1.x, r0.z, -r0.w
                  slt r0.z, r0.z, -r0.z
                  slt r0.w, -r0.w, r0.w
                  mad r2.y, r0.z, r0.w, r1.x
                  mad r2.x, r2.y, -c2.y, r0.y
                  mul r0.y, r4.x, c1.z
                  frc r0.z, r0.y
                  add r0.w, r0.y, -r0.z
                  slt r0.y, r0.y, -r0.y
                  slt r0.z, -r0.z, r0.z
                  mad r1.z, r0.y, r0.z, r0.w
                  mad r0.y, r1.z, -c1.w, r4.x
                  mul r0.z, r0.y, c2.x
                  frc r0.w, r0.z
                  add r1.w, r0.z, -r0.w
                  slt r0.z, r0.z, -r0.z
                  slt r0.w, -r0.w, r0.w
                  mad r1.y, r0.z, r0.w, r1.w
                  mad r1.x, r1.y, -c2.y, r0.y
                  mul r0.y, r5.x, c1.z
                  frc r0.z, r0.y
                  add r0.w, r0.y, -r0.z
                  slt r0.y, r0.y, -r0.y
                  slt r0.z, -r0.z, r0.z
                  mad r4.z, r0.y, r0.z, r0.w
                  mad r0.y, r4.z, -c1.w, r5.x
                  mul r0.z, r0.y, c2.x
                  frc r0.w, r0.z
                  add r1.w, r0.z, -r0.w
                  slt r0.z, r0.z, -r0.z
                  slt r0.w, -r0.w, r0.w
                  mad r4.y, r0.z, r0.w, r1.w
                  mad r4.x, r4.y, -c2.y, r0.y
                  add r0.yz, -r3.xxyw, c0.y
                  mul r5.xyz, r6, r0.y
                  mul r2.xyz, r3.x, r2
                  mul r2.xyz, r0.z, r2
                  mad r2.xyz, r5, r0.z, r2
                  mul r0.yzw, r1.xxyz, r0.y
                  mad r0.yzw, r0, r3.y, r2.xxyz
                  mul r1.xyz, r3.x, r4
                  mad r0.yzw, r1.xxyz, r3.y, r0
                  add r0.yzw, r0, c2.z
                  mul r0.yzw, r0, c2.w
                  rcp r1.x, c208.x
                  mul r0.x, r0.x, r1.x
                  min r0.x, r0.x, c0.y
                  mul r0.xyz, r0.yzww, r0.x
                  mad r0.xyz, r0, c0.z, v0
                else
                  mov r0.xyz, v0
                endif
                mul r1, r0.y, c9
                mad r1, r0.x, c8, r1
                mad r0, r0.z, c10, r1
                add o0, r0, c11
                mov o1.xy, v2
                mov o2, v1
            
            // approximately 118 instruction slots used (8 texture, 110 arithmetic)
        };
    #endif
#endif

VertexShader VS_VehicleTransformUnlitRims
<
    string gWorldViewProj = "parameter register(8)";
> =
asm
{
    //
    // Generated by Microsoft (R) HLSL Shader Compiler 9.26.952.2844
    //
    // Parameters:
    //
    //   row_major float4x4 gWorldViewProj;
    //
    //
    // Registers:
    //
    //   Name           Reg   Size
    //   -------------- ----- ----
    //   gWorldViewProj c8       4
    //
    
        vs_3_0
        dcl_position v0
        dcl_color v1
        dcl_texcoord v2
        dcl_texcoord1 v3
        dcl_position o0
        dcl_texcoord o1.xy
        dcl_color o2
        dcl_texcoord1 o3.xy
        mul r0, c9, v0.y
        mad r0, v0.x, c8, r0
        mad r0, v0.z, c10, r0
        add o0, r0, c11
        mov o1.xy, v2
        mov o2, v1
        mov o3.xy, v3
    
    // approximately 7 instruction slots used
};

#if defined(VEHICLE_DAMAGE) && defined(DEPTH_SHIFT_SCALE)
    //TODO: make this a part of VS_Transform
    VertexShader VS_TransformProjTex
    <
        string BoundRadius      = "parameter register(208)";
        string DamageSampler    = "parameter register(0)";
        string gDayNightEffects = "parameter register(45)";
        string gViewInverse     = "parameter register(12)";
        string gWorld           = "parameter register(0)";
        string gWorldViewProj   = "parameter register(8)";
        string globalScalars    = "parameter register(39)";
        string globalScalars2   = "parameter register(40)";
        string switchOn         = "parameter register(8)";
        string zShiftScale      = "parameter register(209)";
    > =
    asm
    {
        //
        // Generated by Microsoft (R) HLSL Shader Compiler 9.26.952.2844
        //
        // Parameters:
        //
        //   float BoundRadius;
        //   sampler2D DamageSampler;
        //   float4 gDayNightEffects;
        //   row_major float4x4 gViewInverse;
        //   row_major float4x4 gWorld;
        //   row_major float4x4 gWorldViewProj;
        //   float4 globalScalars;
        //   float4 globalScalars2;
        //   bool switchOn;
        //   float zShiftScale;
        //
        //
        // Registers:
        //
        //   Name             Reg   Size
        //   ---------------- ----- ----
        //   switchOn         b8       1
        //   gWorld           c0       4
        //   gWorldViewProj   c8       4
        //   gViewInverse     c12      4
        //   globalScalars    c39      1
        //   globalScalars2   c40      1
        //   gDayNightEffects c45      1
        //   BoundRadius      c208     1
        //   zShiftScale      c209     1
        //   DamageSampler    s0       1
        //
        
            vs_3_0
            def c4, 9.99999975e-006, 1, 0.5, 126.732674
            def c5, 0, 0.00789062493, 1.52587891e-005, 65536
            def c6, 0.00390625, 256, -128, 0.0078125
            def c7, 9.99999994e-009, 0, 0, 0
            def c12, -0.5, -0.492109388, 2, 1
            dcl_position v0
            dcl_color v1
            dcl_texcoord v2
            dcl_normal v3
            dcl_tangent v4
            dcl_2d s0
            dcl_position o0
            dcl_texcoord o1.xy
            dcl_texcoord1 o2
            dcl_texcoord3 o3.xyz
            dcl_texcoord4 o4.xyz
            dcl_texcoord5 o5.xyz
            dcl_color o6
            dcl_texcoord6 o7
            dcl_texcoord7 o8
            if b8
              dp3 r0.x, v0, v0
              rsq r0.x, r0.x
              rcp r0.x, r0.x
              add r0.y, r0.x, c4.x
              rcp r0.y, r0.y
              mad r0.z, v0.z, -r0.y, c4.y
              mul r0.z, r0.z, c4.z
              mad r0.yw, v0.xxzy, r0.y, c4.x
              mul r1.xy, r0.ywzw, r0.ywzw
              add r1.x, r1.y, r1.x
              rsq r1.x, r1.x
              mul r0.yw, r0, r1.x
              mul r0.yz, r0.z, r0.xyww
              mad r1.xy, r0.yzzw, c4.z, c4.z
              mul r0.yz, r1.xxyw, c4.w
              frc r2.xy, r0_abs.yzzw
              sge r0.yz, r0, -r0
              lrp r3.xy, r0.yzzw, r2, -r2
              mov r1.zw, c5.x
              texldl r2, r1, s0
              mad r0.yz, r3.xxyw, -c5.y, r1.xxyw
              add r1.xy, r0.yzzw, c5.yxzw
              mov r1.zw, c5.x
              texldl r1, r1, s0
              add r4.xy, r0.yzzw, c5
              mov r4.zw, c5.x
              texldl r4, r4, s0
              add r5.xy, r0.yzzw, c5.y
              mov r5.zw, c5.x
              texldl r5, r5, s0
              mul r0.w, r2.x, c5.z
              frc r1.y, r0.w
              add r1.z, r0.w, -r1.y
              slt r0.w, r0.w, -r0.w
              slt r1.y, -r1.y, r1.y
              mad r6.z, r0.w, r1.y, r1.z
              mad r0.w, r6.z, -c5.w, r2.x
              mul r1.y, r0.w, c6.x
              frc r1.z, r1.y
              add r1.w, r1.y, -r1.z
              slt r1.y, r1.y, -r1.y
              slt r1.z, -r1.z, r1.z
              mad r6.y, r1.y, r1.z, r1.w
              mad r6.x, r6.y, -c6.y, r0.w
              mul r0.w, r1.x, c5.z
              frc r1.y, r0.w
              add r1.z, r0.w, -r1.y
              slt r0.w, r0.w, -r0.w
              slt r1.y, -r1.y, r1.y
              mad r2.z, r0.w, r1.y, r1.z
              mad r0.w, r2.z, -c5.w, r1.x
              mul r1.x, r0.w, c6.x
              frc r1.y, r1.x
              add r1.z, r1.x, -r1.y
              slt r1.x, r1.x, -r1.x
              slt r1.y, -r1.y, r1.y
              mad r2.y, r1.x, r1.y, r1.z
              mad r2.x, r2.y, -c6.y, r0.w
              mul r0.w, r4.x, c5.z
              frc r1.x, r0.w
              add r1.y, r0.w, -r1.x
              slt r0.w, r0.w, -r0.w
              slt r1.x, -r1.x, r1.x
              mad r1.z, r0.w, r1.x, r1.y
              mad r0.w, r1.z, -c5.w, r4.x
              mul r1.w, r0.w, c6.x
              frc r2.w, r1.w
              add r3.z, r1.w, -r2.w
              slt r1.w, r1.w, -r1.w
              slt r2.w, -r2.w, r2.w
              mad r1.y, r1.w, r2.w, r3.z
              mad r1.x, r1.y, -c6.y, r0.w
              mul r0.w, r5.x, c5.z
              frc r1.w, r0.w
              add r2.w, r0.w, -r1.w
              slt r0.w, r0.w, -r0.w
              slt r1.w, -r1.w, r1.w
              mad r4.z, r0.w, r1.w, r2.w
              mad r0.w, r4.z, -c5.w, r5.x
              mul r1.w, r0.w, c6.x
              frc r2.w, r1.w
              add r3.z, r1.w, -r2.w
              slt r1.w, r1.w, -r1.w
              slt r2.w, -r2.w, r2.w
              mad r4.y, r1.w, r2.w, r3.z
              mad r4.x, r4.y, -c6.y, r0.w
              add r3.zw, -r3.xyxy, c4.y
              mul r5.xyz, r6, r3.z
              mul r7.xyz, r3.x, r2
              mul r7.xyz, r3.w, r7
              mad r5.xyz, r5, r3.w, r7
              mul r7.xyz, r1, r3.z
              mad r5.xyz, r7, r3.y, r5
              mul r3.xzw, r3.x, r4.xyyz
              mad r3.xyz, r3.xzww, r3.y, r5
              add r3.xyz, r3, c6.z
              mul r3.xyz, r3, c6.w
              rcp r0.w, c208.x
              mul r0.x, r0.x, r0.w
              min r0.x, r0.x, c4.y
              mul r3.xyz, r3, r0.x
              mad r3.xyz, r3, c4.z, v0
              add r4.xyz, -c4.y, v3
              sge r4.xyz, -r4_abs, r4_abs
              mul r0.w, r4.y, r4.x
              mul r0.w, r4.z, r0.w
              if_ne r0.w, -r0.w
                mov r4.x, c5.x
                mov r0.w, c5.x
                mov r1.w, v3.z
              else
                add r5, r0.yzyz, c12.xxyx
                add r5, r5, r5
                mul r7, r5, r5
                add r7.xy, r7.ywzw, r7.xzzw
                slt r7.zw, c5.x, r7.xyxy
                rsq r2.w, r7.x
                rcp r2.w, r2.w
                mul r2.w, r7.z, r2.w
                mad r3.w, r2.w, -c12.z, c12.w
                slt r4.w, r3.w, -c4.y
                lrp r8.z, r4.w, -c4.y, r3.w
                slt r3.w, r8.z, c4.y
                slt r4.w, -c4.y, r8.z
                mul r3.w, r3.w, r4.w
                slt r4.w, c5.x, r2.w
                mul r3.w, r3.w, r4.w
                mad r4.w, r8.z, -r8.z, c4.y
                rsq r4.w, r4.w
                rcp r4.w, r4.w
                rcp r2.w, r2.w
                mul r2.w, r4.w, r2.w
                mul r2.w, r3.w, r2.w
                mul r8.xy, r5, r2.w
                add r6.xyz, r6, c6.z
                mul r6.xyz, r0.x, r6
                mul r6.xyz, r6, c6.x
                rsq r2.w, r7.y
                rcp r2.w, r2.w
                mul r2.w, r7.w, r2.w
                mad r3.w, r2.w, -c12.z, c12.w
                slt r4.w, r3.w, -c4.y
                lrp r7.z, r4.w, -c4.y, r3.w
                slt r3.w, r7.z, c4.y
                slt r4.w, -c4.y, r7.z
                mul r3.w, r3.w, r4.w
                slt r4.w, c5.x, r2.w
                mul r3.w, r3.w, r4.w
                mad r4.w, r7.z, -r7.z, c4.y
                rsq r4.w, r4.w
                rcp r4.w, r4.w
                rcp r2.w, r2.w
                mul r2.w, r4.w, r2.w
                mul r2.w, r3.w, r2.w
                mul r7.xy, r5.zwzw, r2.w
                add r5.xyz, r7, c7.x
                add r2.xyz, r2, c6.z
                mul r2.xyz, r0.x, r2
                add r5.xyz, -r8, r5
                mad r2.xyz, r2, c6.x, -r6
                dp3 r2.x, r2, v3
                dp3 r2.y, r5, r5
                slt r2.z, c5.x, r2.y
                rcp r2.y, r2.y
                mul r2.x, -r2.x, r2.y
                mul r2.xyw, r5.xyzz, r2.x
                mad r2.xyz, r2.z, r2.xyww, v3
                add r0.yz, r0, c12.xxyw
                add r0.yz, r0, r0
                mul r5.xy, r0.yzzw, r0.yzzw
                add r2.w, r5.y, r5.x
                slt r3.w, c5.x, r2.w
                rsq r2.w, r2.w
                rcp r2.w, r2.w
                mul r2.w, r3.w, r2.w
                mad r3.w, r2.w, -c12.z, c12.w
                slt r4.w, r3.w, -c4.y
                lrp r5.z, r4.w, -c4.y, r3.w
                slt r3.w, r5.z, c4.y
                slt r4.w, -c4.y, r5.z
                mul r3.w, r3.w, r4.w
                slt r4.w, c5.x, r2.w
                mul r3.w, r3.w, r4.w
                mad r4.w, r5.z, -r5.z, c4.y
                rsq r4.w, r4.w
                rcp r4.w, r4.w
                rcp r2.w, r2.w
                mul r2.w, r4.w, r2.w
                mul r2.w, r3.w, r2.w
                mul r5.xy, r0.yzzw, r2.w
                add r1.xyz, r1, c6.z
                mul r0.xyz, r0.x, r1
                add r1.xyz, -r8, r5
                mad r0.xyz, r0, c6.x, -r6
                dp3 r0.x, r0, v3
                dp3 r0.y, r1, r1
                slt r0.z, c5.x, r0.y
                rcp r0.y, r0.y
                mul r0.x, -r0.x, r0.y
                mul r1.xyz, r1, r0.x
                mad r0.xyz, r0.z, r1, r2
                nrm r4.xyz, r0
                mov r0.w, r4.y
                mov r1.w, r4.z
              endif
            else
              mov r3.xyz, v0
              mov r4.x, v3.x
              mov r0.w, v3.y
              mov r1.w, v3.z
            endif
            mul r0.xyz, r3.y, c1
            mad r0.xyz, r3.x, c0, r0
            mad r0.xyz, r3.z, c2, r0
            add r0.xyz, r0, c3
            add r1.xyz, -r0, c15
            mul r2.xyz, r0.w, c1
            mad r2.xyz, r4.x, c0, r2
            mad r2.xyz, r1.w, c2, r2
            add r2.xyz, r2, c4.x
            nrm r4.xyz, r2
            mul r2.xyz, c1, v4.y
            mad r2.xyz, v4.x, c0, r2
            mad r2.xyz, v4.z, c2, r2
            add r2.xyz, r2, c4.x
            nrm r5.xyz, r2
            mul r2.xyz, r4.yzxw, r5.zxyw
            mad r2.xyz, r5.yzxw, r4.zxyw, -r2
            mul r2.xyz, r2, v4.w
            dp3 o8.x, r5, r1
            dp3 o8.y, r2, r1
            dp3 o8.z, r4, r1
            mov r6.xyz, c15
            add r6.xyz, r6, -c3
            dp3 r7.x, c0, r6
            dp3 r7.y, c1, r6
            dp3 r7.z, c2, r6
            add r6.xyz, -r3, r7
            nrm r7.xyz, r6
            mad r3.xyz, r7, c209.x, r3
            mul r6, r3.y, c9
            mad r6, r3.x, c8, r6
            mad r3, r3.z, c10, r6
            add r3, r3, c11
            mul r6.xy, c45, v1
            add r0.w, r6.y, r6.x
            mov r6.y, c4.y
            mad r0.w, r0.w, c39.z, -r6.y
            mad o6.xy, c40.z, r0.w, r6.y
            mov o0, r3
            mov o1.xy, v2
            mov o2.w, r3.w
            mov o2.xyz, r4
            mov o3.xyz, r1
            mov o4.xyz, r5
            mov o5.xyz, r2
            mov o6.zw, v1
            mov o7.xyz, r0
            mov o7.w, c4.y
            mov o8.w, c4.y
        
        // approximately 277 instruction slots used (8 texture, 269 arithmetic)
    };

    //TODO: make this a part of VS_TransformD
    VertexShader VS_TransformDProjTex
    <
        string BoundRadius      = "parameter register(208)";
        string DamageSampler    = "parameter register(0)";
        string gDayNightEffects = "parameter register(45)";
        string gViewInverse     = "parameter register(12)";
        string gWorld           = "parameter register(0)";
        string gWorldViewProj   = "parameter register(8)";
        string globalScalars    = "parameter register(39)";
        string globalScalars2   = "parameter register(40)";
        string switchOn         = "parameter register(8)";
        string zShiftScale      = "parameter register(209)";
    > =
    asm
    {
        //
        // Generated by Microsoft (R) HLSL Shader Compiler 9.26.952.2844
        //
        // Parameters:
        //
        //   float BoundRadius;
        //   sampler2D DamageSampler;
        //   float4 gDayNightEffects;
        //   row_major float4x4 gViewInverse;
        //   row_major float4x4 gWorld;
        //   row_major float4x4 gWorldViewProj;
        //   float4 globalScalars;
        //   float4 globalScalars2;
        //   bool switchOn;
        //   float zShiftScale;
        //
        //
        // Registers:
        //
        //   Name             Reg   Size
        //   ---------------- ----- ----
        //   switchOn         b8       1
        //   gWorld           c0       4
        //   gWorldViewProj   c8       4
        //   gViewInverse     c12      4
        //   globalScalars    c39      1
        //   globalScalars2   c40      1
        //   gDayNightEffects c45      1
        //   BoundRadius      c208     1
        //   zShiftScale      c209     1
        //   DamageSampler    s0       1
        //
        
            vs_3_0
            def c4, 9.99999975e-006, 1, 0.5, 126.732674
            def c5, 0, 0.00789062493, 1.52587891e-005, 65536
            def c6, 0.00390625, 256, -128, 0.0078125
            def c7, 9.99999994e-009, 0, 0, 0
            def c12, -0.5, -0.492109388, 2, 1
            dcl_position v0
            dcl_color v1
            dcl_texcoord v2
            dcl_normal v3
            dcl_tangent v4
            dcl_2d s0
            dcl_position o0
            dcl_texcoord o1.xy
            dcl_texcoord1 o2
            dcl_texcoord4 o3.xyz
            dcl_texcoord5 o4.xyz
            dcl_color o5
            dcl_texcoord6 o6
            dcl_texcoord7 o7
            if b8
              dp3 r0.x, v0, v0
              rsq r0.x, r0.x
              rcp r0.x, r0.x
              add r0.y, r0.x, c4.x
              rcp r0.y, r0.y
              mad r0.z, v0.z, -r0.y, c4.y
              mul r0.z, r0.z, c4.z
              mad r0.yw, v0.xxzy, r0.y, c4.x
              mul r1.xy, r0.ywzw, r0.ywzw
              add r1.x, r1.y, r1.x
              rsq r1.x, r1.x
              mul r0.yw, r0, r1.x
              mul r0.yz, r0.z, r0.xyww
              mad r1.xy, r0.yzzw, c4.z, c4.z
              mul r0.yz, r1.xxyw, c4.w
              frc r2.xy, r0_abs.yzzw
              sge r0.yz, r0, -r0
              lrp r3.xy, r0.yzzw, r2, -r2
              mov r1.zw, c5.x
              texldl r2, r1, s0
              mad r0.yz, r3.xxyw, -c5.y, r1.xxyw
              add r1.xy, r0.yzzw, c5.yxzw
              mov r1.zw, c5.x
              texldl r1, r1, s0
              add r4.xy, r0.yzzw, c5
              mov r4.zw, c5.x
              texldl r4, r4, s0
              add r5.xy, r0.yzzw, c5.y
              mov r5.zw, c5.x
              texldl r5, r5, s0
              mul r0.w, r2.x, c5.z
              frc r1.y, r0.w
              add r1.z, r0.w, -r1.y
              slt r0.w, r0.w, -r0.w
              slt r1.y, -r1.y, r1.y
              mad r6.z, r0.w, r1.y, r1.z
              mad r0.w, r6.z, -c5.w, r2.x
              mul r1.y, r0.w, c6.x
              frc r1.z, r1.y
              add r1.w, r1.y, -r1.z
              slt r1.y, r1.y, -r1.y
              slt r1.z, -r1.z, r1.z
              mad r6.y, r1.y, r1.z, r1.w
              mad r6.x, r6.y, -c6.y, r0.w
              mul r0.w, r1.x, c5.z
              frc r1.y, r0.w
              add r1.z, r0.w, -r1.y
              slt r0.w, r0.w, -r0.w
              slt r1.y, -r1.y, r1.y
              mad r2.z, r0.w, r1.y, r1.z
              mad r0.w, r2.z, -c5.w, r1.x
              mul r1.x, r0.w, c6.x
              frc r1.y, r1.x
              add r1.z, r1.x, -r1.y
              slt r1.x, r1.x, -r1.x
              slt r1.y, -r1.y, r1.y
              mad r2.y, r1.x, r1.y, r1.z
              mad r2.x, r2.y, -c6.y, r0.w
              mul r0.w, r4.x, c5.z
              frc r1.x, r0.w
              add r1.y, r0.w, -r1.x
              slt r0.w, r0.w, -r0.w
              slt r1.x, -r1.x, r1.x
              mad r1.z, r0.w, r1.x, r1.y
              mad r0.w, r1.z, -c5.w, r4.x
              mul r1.w, r0.w, c6.x
              frc r2.w, r1.w
              add r3.z, r1.w, -r2.w
              slt r1.w, r1.w, -r1.w
              slt r2.w, -r2.w, r2.w
              mad r1.y, r1.w, r2.w, r3.z
              mad r1.x, r1.y, -c6.y, r0.w
              mul r0.w, r5.x, c5.z
              frc r1.w, r0.w
              add r2.w, r0.w, -r1.w
              slt r0.w, r0.w, -r0.w
              slt r1.w, -r1.w, r1.w
              mad r4.z, r0.w, r1.w, r2.w
              mad r0.w, r4.z, -c5.w, r5.x
              mul r1.w, r0.w, c6.x
              frc r2.w, r1.w
              add r3.z, r1.w, -r2.w
              slt r1.w, r1.w, -r1.w
              slt r2.w, -r2.w, r2.w
              mad r4.y, r1.w, r2.w, r3.z
              mad r4.x, r4.y, -c6.y, r0.w
              add r3.zw, -r3.xyxy, c4.y
              mul r5.xyz, r6, r3.z
              mul r7.xyz, r3.x, r2
              mul r7.xyz, r3.w, r7
              mad r5.xyz, r5, r3.w, r7
              mul r7.xyz, r1, r3.z
              mad r5.xyz, r7, r3.y, r5
              mul r3.xzw, r3.x, r4.xyyz
              mad r3.xyz, r3.xzww, r3.y, r5
              add r3.xyz, r3, c6.z
              mul r3.xyz, r3, c6.w
              rcp r0.w, c208.x
              mul r0.x, r0.x, r0.w
              min r0.x, r0.x, c4.y
              mul r3.xyz, r3, r0.x
              mad r3.xyz, r3, c4.z, v0
              add r4.xyz, -c4.y, v3
              sge r4.xyz, -r4_abs, r4_abs
              mul r0.w, r4.y, r4.x
              mul r0.w, r4.z, r0.w
              if_ne r0.w, -r0.w
                mov r4.x, c5.x
                mov r0.w, c5.x
                mov r1.w, v3.z
              else
                add r5, r0.yzyz, c12.xxyx
                add r5, r5, r5
                mul r7, r5, r5
                add r7.xy, r7.ywzw, r7.xzzw
                slt r7.zw, c5.x, r7.xyxy
                rsq r2.w, r7.x
                rcp r2.w, r2.w
                mul r2.w, r7.z, r2.w
                mad r3.w, r2.w, -c12.z, c12.w
                slt r4.w, r3.w, -c4.y
                lrp r8.z, r4.w, -c4.y, r3.w
                slt r3.w, r8.z, c4.y
                slt r4.w, -c4.y, r8.z
                mul r3.w, r3.w, r4.w
                slt r4.w, c5.x, r2.w
                mul r3.w, r3.w, r4.w
                mad r4.w, r8.z, -r8.z, c4.y
                rsq r4.w, r4.w
                rcp r4.w, r4.w
                rcp r2.w, r2.w
                mul r2.w, r4.w, r2.w
                mul r2.w, r3.w, r2.w
                mul r8.xy, r5, r2.w
                add r6.xyz, r6, c6.z
                mul r6.xyz, r0.x, r6
                mul r6.xyz, r6, c6.x
                rsq r2.w, r7.y
                rcp r2.w, r2.w
                mul r2.w, r7.w, r2.w
                mad r3.w, r2.w, -c12.z, c12.w
                slt r4.w, r3.w, -c4.y
                lrp r7.z, r4.w, -c4.y, r3.w
                slt r3.w, r7.z, c4.y
                slt r4.w, -c4.y, r7.z
                mul r3.w, r3.w, r4.w
                slt r4.w, c5.x, r2.w
                mul r3.w, r3.w, r4.w
                mad r4.w, r7.z, -r7.z, c4.y
                rsq r4.w, r4.w
                rcp r4.w, r4.w
                rcp r2.w, r2.w
                mul r2.w, r4.w, r2.w
                mul r2.w, r3.w, r2.w
                mul r7.xy, r5.zwzw, r2.w
                add r5.xyz, r7, c7.x
                add r2.xyz, r2, c6.z
                mul r2.xyz, r0.x, r2
                add r5.xyz, -r8, r5
                mad r2.xyz, r2, c6.x, -r6
                dp3 r2.x, r2, v3
                dp3 r2.y, r5, r5
                slt r2.z, c5.x, r2.y
                rcp r2.y, r2.y
                mul r2.x, -r2.x, r2.y
                mul r2.xyw, r5.xyzz, r2.x
                mad r2.xyz, r2.z, r2.xyww, v3
                add r0.yz, r0, c12.xxyw
                add r0.yz, r0, r0
                mul r5.xy, r0.yzzw, r0.yzzw
                add r2.w, r5.y, r5.x
                slt r3.w, c5.x, r2.w
                rsq r2.w, r2.w
                rcp r2.w, r2.w
                mul r2.w, r3.w, r2.w
                mad r3.w, r2.w, -c12.z, c12.w
                slt r4.w, r3.w, -c4.y
                lrp r5.z, r4.w, -c4.y, r3.w
                slt r3.w, r5.z, c4.y
                slt r4.w, -c4.y, r5.z
                mul r3.w, r3.w, r4.w
                slt r4.w, c5.x, r2.w
                mul r3.w, r3.w, r4.w
                mad r4.w, r5.z, -r5.z, c4.y
                rsq r4.w, r4.w
                rcp r4.w, r4.w
                rcp r2.w, r2.w
                mul r2.w, r4.w, r2.w
                mul r2.w, r3.w, r2.w
                mul r5.xy, r0.yzzw, r2.w
                add r1.xyz, r1, c6.z
                mul r0.xyz, r0.x, r1
                add r1.xyz, -r8, r5
                mad r0.xyz, r0, c6.x, -r6
                dp3 r0.x, r0, v3
                dp3 r0.y, r1, r1
                slt r0.z, c5.x, r0.y
                rcp r0.y, r0.y
                mul r0.x, -r0.x, r0.y
                mul r1.xyz, r1, r0.x
                mad r0.xyz, r0.z, r1, r2
                nrm r4.xyz, r0
                mov r0.w, r4.y
                mov r1.w, r4.z
              endif
            else
              mov r3.xyz, v0
              mov r4.x, v3.x
              mov r0.w, v3.y
              mov r1.w, v3.z
            endif
            mul r0.xyz, r3.y, c1
            mad r0.xyz, r3.x, c0, r0
            mad r0.xyz, r3.z, c2, r0
            add r0.xyz, r0, c3
            add r1.xyz, -r0, c15
            mul r2.xyz, r0.w, c1
            mad r2.xyz, r4.x, c0, r2
            mad r2.xyz, r1.w, c2, r2
            add r2.xyz, r2, c4.x
            nrm r4.xyz, r2
            mul r2.xyz, c1, v4.y
            mad r2.xyz, v4.x, c0, r2
            mad r2.xyz, v4.z, c2, r2
            add r2.xyz, r2, c4.x
            nrm r5.xyz, r2
            mul r2.xyz, r4.yzxw, r5.zxyw
            mad r2.xyz, r5.yzxw, r4.zxyw, -r2
            mul r2.xyz, r2, v4.w
            dp3 o7.x, r5, r1
            dp3 o7.y, r2, r1
            dp3 o7.z, r4, r1
            mov r1.xyz, c15
            add r1.xyz, r1, -c3
            dp3 r6.x, c0, r1
            dp3 r6.y, c1, r1
            dp3 r6.z, c2, r1
            add r1.xyz, -r3, r6
            nrm r6.xyz, r1
            mad r1.xyz, r6, c209.x, r3
            mul r3, r1.y, c9
            mad r3, r1.x, c8, r3
            mad r1, r1.z, c10, r3
            add r1, r1, c11
            mul r3.xy, c45, v1
            add r0.w, r3.y, r3.x
            mov r3.y, c4.y
            mad r0.w, r0.w, c39.z, -r3.y
            mad o5.xy, c40.z, r0.w, r3.y
            mov o0, r1
            mov o1.xy, v2
            mov o2.w, r1.w
            mov o2.xyz, r4
            mov o3.xyz, r5
            mov o4.xyz, r2
            mov o5.zw, v1
            mov o6.xyz, r0
            mov o6.w, c4.y
            mov o7.w, c4.y
        
        // approximately 276 instruction slots used (8 texture, 268 arithmetic)
    };

    //== VS_TransformDProjTex
    VertexShader VS_TransformAlphaClipDProjTex
    <
        string BoundRadius      = "parameter register(208)";
        string DamageSampler    = "parameter register(0)";
        string gDayNightEffects = "parameter register(45)";
        string gViewInverse     = "parameter register(12)";
        string gWorld           = "parameter register(0)";
        string gWorldViewProj   = "parameter register(8)";
        string globalScalars    = "parameter register(39)";
        string globalScalars2   = "parameter register(40)";
        string switchOn         = "parameter register(8)";
        string zShiftScale      = "parameter register(209)";
    > =
    asm
    {
        //
        // Generated by Microsoft (R) HLSL Shader Compiler 9.26.952.2844
        //
        // Parameters:
        //
        //   float BoundRadius;
        //   sampler2D DamageSampler;
        //   float4 gDayNightEffects;
        //   row_major float4x4 gViewInverse;
        //   row_major float4x4 gWorld;
        //   row_major float4x4 gWorldViewProj;
        //   float4 globalScalars;
        //   float4 globalScalars2;
        //   bool switchOn;
        //   float zShiftScale;
        //
        //
        // Registers:
        //
        //   Name             Reg   Size
        //   ---------------- ----- ----
        //   switchOn         b8       1
        //   gWorld           c0       4
        //   gWorldViewProj   c8       4
        //   gViewInverse     c12      4
        //   globalScalars    c39      1
        //   globalScalars2   c40      1
        //   gDayNightEffects c45      1
        //   BoundRadius      c208     1
        //   zShiftScale      c209     1
        //   DamageSampler    s0       1
        //
        
            vs_3_0
            def c4, 9.99999975e-006, 1, 0.5, 126.732674
            def c5, 0, 0.00789062493, 1.52587891e-005, 65536
            def c6, 0.00390625, 256, -128, 0.0078125
            def c7, 9.99999994e-009, 0, 0, 0
            def c12, -0.5, -0.492109388, 2, 1
            dcl_position v0
            dcl_color v1
            dcl_texcoord v2
            dcl_normal v3
            dcl_tangent v4
            dcl_2d s0
            dcl_position o0
            dcl_texcoord o1.xy
            dcl_texcoord1 o2
            dcl_texcoord4 o3.xyz
            dcl_texcoord5 o4.xyz
            dcl_color o5
            dcl_texcoord6 o6
            dcl_texcoord7 o7
            if b8
              dp3 r0.x, v0, v0
              rsq r0.x, r0.x
              rcp r0.x, r0.x
              add r0.y, r0.x, c4.x
              rcp r0.y, r0.y
              mad r0.z, v0.z, -r0.y, c4.y
              mul r0.z, r0.z, c4.z
              mad r0.yw, v0.xxzy, r0.y, c4.x
              mul r1.xy, r0.ywzw, r0.ywzw
              add r1.x, r1.y, r1.x
              rsq r1.x, r1.x
              mul r0.yw, r0, r1.x
              mul r0.yz, r0.z, r0.xyww
              mad r1.xy, r0.yzzw, c4.z, c4.z
              mul r0.yz, r1.xxyw, c4.w
              frc r2.xy, r0_abs.yzzw
              sge r0.yz, r0, -r0
              lrp r3.xy, r0.yzzw, r2, -r2
              mov r1.zw, c5.x
              texldl r2, r1, s0
              mad r0.yz, r3.xxyw, -c5.y, r1.xxyw
              add r1.xy, r0.yzzw, c5.yxzw
              mov r1.zw, c5.x
              texldl r1, r1, s0
              add r4.xy, r0.yzzw, c5
              mov r4.zw, c5.x
              texldl r4, r4, s0
              add r5.xy, r0.yzzw, c5.y
              mov r5.zw, c5.x
              texldl r5, r5, s0
              mul r0.w, r2.x, c5.z
              frc r1.y, r0.w
              add r1.z, r0.w, -r1.y
              slt r0.w, r0.w, -r0.w
              slt r1.y, -r1.y, r1.y
              mad r6.z, r0.w, r1.y, r1.z
              mad r0.w, r6.z, -c5.w, r2.x
              mul r1.y, r0.w, c6.x
              frc r1.z, r1.y
              add r1.w, r1.y, -r1.z
              slt r1.y, r1.y, -r1.y
              slt r1.z, -r1.z, r1.z
              mad r6.y, r1.y, r1.z, r1.w
              mad r6.x, r6.y, -c6.y, r0.w
              mul r0.w, r1.x, c5.z
              frc r1.y, r0.w
              add r1.z, r0.w, -r1.y
              slt r0.w, r0.w, -r0.w
              slt r1.y, -r1.y, r1.y
              mad r2.z, r0.w, r1.y, r1.z
              mad r0.w, r2.z, -c5.w, r1.x
              mul r1.x, r0.w, c6.x
              frc r1.y, r1.x
              add r1.z, r1.x, -r1.y
              slt r1.x, r1.x, -r1.x
              slt r1.y, -r1.y, r1.y
              mad r2.y, r1.x, r1.y, r1.z
              mad r2.x, r2.y, -c6.y, r0.w
              mul r0.w, r4.x, c5.z
              frc r1.x, r0.w
              add r1.y, r0.w, -r1.x
              slt r0.w, r0.w, -r0.w
              slt r1.x, -r1.x, r1.x
              mad r1.z, r0.w, r1.x, r1.y
              mad r0.w, r1.z, -c5.w, r4.x
              mul r1.w, r0.w, c6.x
              frc r2.w, r1.w
              add r3.z, r1.w, -r2.w
              slt r1.w, r1.w, -r1.w
              slt r2.w, -r2.w, r2.w
              mad r1.y, r1.w, r2.w, r3.z
              mad r1.x, r1.y, -c6.y, r0.w
              mul r0.w, r5.x, c5.z
              frc r1.w, r0.w
              add r2.w, r0.w, -r1.w
              slt r0.w, r0.w, -r0.w
              slt r1.w, -r1.w, r1.w
              mad r4.z, r0.w, r1.w, r2.w
              mad r0.w, r4.z, -c5.w, r5.x
              mul r1.w, r0.w, c6.x
              frc r2.w, r1.w
              add r3.z, r1.w, -r2.w
              slt r1.w, r1.w, -r1.w
              slt r2.w, -r2.w, r2.w
              mad r4.y, r1.w, r2.w, r3.z
              mad r4.x, r4.y, -c6.y, r0.w
              add r3.zw, -r3.xyxy, c4.y
              mul r5.xyz, r6, r3.z
              mul r7.xyz, r3.x, r2
              mul r7.xyz, r3.w, r7
              mad r5.xyz, r5, r3.w, r7
              mul r7.xyz, r1, r3.z
              mad r5.xyz, r7, r3.y, r5
              mul r3.xzw, r3.x, r4.xyyz
              mad r3.xyz, r3.xzww, r3.y, r5
              add r3.xyz, r3, c6.z
              mul r3.xyz, r3, c6.w
              rcp r0.w, c208.x
              mul r0.x, r0.x, r0.w
              min r0.x, r0.x, c4.y
              mul r3.xyz, r3, r0.x
              mad r3.xyz, r3, c4.z, v0
              add r4.xyz, -c4.y, v3
              sge r4.xyz, -r4_abs, r4_abs
              mul r0.w, r4.y, r4.x
              mul r0.w, r4.z, r0.w
              if_ne r0.w, -r0.w
                mov r4.x, c5.x
                mov r0.w, c5.x
                mov r1.w, v3.z
              else
                add r5, r0.yzyz, c12.xxyx
                add r5, r5, r5
                mul r7, r5, r5
                add r7.xy, r7.ywzw, r7.xzzw
                slt r7.zw, c5.x, r7.xyxy
                rsq r2.w, r7.x
                rcp r2.w, r2.w
                mul r2.w, r7.z, r2.w
                mad r3.w, r2.w, -c12.z, c12.w
                slt r4.w, r3.w, -c4.y
                lrp r8.z, r4.w, -c4.y, r3.w
                slt r3.w, r8.z, c4.y
                slt r4.w, -c4.y, r8.z
                mul r3.w, r3.w, r4.w
                slt r4.w, c5.x, r2.w
                mul r3.w, r3.w, r4.w
                mad r4.w, r8.z, -r8.z, c4.y
                rsq r4.w, r4.w
                rcp r4.w, r4.w
                rcp r2.w, r2.w
                mul r2.w, r4.w, r2.w
                mul r2.w, r3.w, r2.w
                mul r8.xy, r5, r2.w
                add r6.xyz, r6, c6.z
                mul r6.xyz, r0.x, r6
                mul r6.xyz, r6, c6.x
                rsq r2.w, r7.y
                rcp r2.w, r2.w
                mul r2.w, r7.w, r2.w
                mad r3.w, r2.w, -c12.z, c12.w
                slt r4.w, r3.w, -c4.y
                lrp r7.z, r4.w, -c4.y, r3.w
                slt r3.w, r7.z, c4.y
                slt r4.w, -c4.y, r7.z
                mul r3.w, r3.w, r4.w
                slt r4.w, c5.x, r2.w
                mul r3.w, r3.w, r4.w
                mad r4.w, r7.z, -r7.z, c4.y
                rsq r4.w, r4.w
                rcp r4.w, r4.w
                rcp r2.w, r2.w
                mul r2.w, r4.w, r2.w
                mul r2.w, r3.w, r2.w
                mul r7.xy, r5.zwzw, r2.w
                add r5.xyz, r7, c7.x
                add r2.xyz, r2, c6.z
                mul r2.xyz, r0.x, r2
                add r5.xyz, -r8, r5
                mad r2.xyz, r2, c6.x, -r6
                dp3 r2.x, r2, v3
                dp3 r2.y, r5, r5
                slt r2.z, c5.x, r2.y
                rcp r2.y, r2.y
                mul r2.x, -r2.x, r2.y
                mul r2.xyw, r5.xyzz, r2.x
                mad r2.xyz, r2.z, r2.xyww, v3
                add r0.yz, r0, c12.xxyw
                add r0.yz, r0, r0
                mul r5.xy, r0.yzzw, r0.yzzw
                add r2.w, r5.y, r5.x
                slt r3.w, c5.x, r2.w
                rsq r2.w, r2.w
                rcp r2.w, r2.w
                mul r2.w, r3.w, r2.w
                mad r3.w, r2.w, -c12.z, c12.w
                slt r4.w, r3.w, -c4.y
                lrp r5.z, r4.w, -c4.y, r3.w
                slt r3.w, r5.z, c4.y
                slt r4.w, -c4.y, r5.z
                mul r3.w, r3.w, r4.w
                slt r4.w, c5.x, r2.w
                mul r3.w, r3.w, r4.w
                mad r4.w, r5.z, -r5.z, c4.y
                rsq r4.w, r4.w
                rcp r4.w, r4.w
                rcp r2.w, r2.w
                mul r2.w, r4.w, r2.w
                mul r2.w, r3.w, r2.w
                mul r5.xy, r0.yzzw, r2.w
                add r1.xyz, r1, c6.z
                mul r0.xyz, r0.x, r1
                add r1.xyz, -r8, r5
                mad r0.xyz, r0, c6.x, -r6
                dp3 r0.x, r0, v3
                dp3 r0.y, r1, r1
                slt r0.z, c5.x, r0.y
                rcp r0.y, r0.y
                mul r0.x, -r0.x, r0.y
                mul r1.xyz, r1, r0.x
                mad r0.xyz, r0.z, r1, r2
                nrm r4.xyz, r0
                mov r0.w, r4.y
                mov r1.w, r4.z
              endif
            else
              mov r3.xyz, v0
              mov r4.x, v3.x
              mov r0.w, v3.y
              mov r1.w, v3.z
            endif
            mul r0.xyz, r3.y, c1
            mad r0.xyz, r3.x, c0, r0
            mad r0.xyz, r3.z, c2, r0
            add r0.xyz, r0, c3
            add r1.xyz, -r0, c15
            mul r2.xyz, r0.w, c1
            mad r2.xyz, r4.x, c0, r2
            mad r2.xyz, r1.w, c2, r2
            add r2.xyz, r2, c4.x
            nrm r4.xyz, r2
            mul r2.xyz, c1, v4.y
            mad r2.xyz, v4.x, c0, r2
            mad r2.xyz, v4.z, c2, r2
            add r2.xyz, r2, c4.x
            nrm r5.xyz, r2
            mul r2.xyz, r4.yzxw, r5.zxyw
            mad r2.xyz, r5.yzxw, r4.zxyw, -r2
            mul r2.xyz, r2, v4.w
            dp3 o7.x, r5, r1
            dp3 o7.y, r2, r1
            dp3 o7.z, r4, r1
            mov r1.xyz, c15
            add r1.xyz, r1, -c3
            dp3 r6.x, c0, r1
            dp3 r6.y, c1, r1
            dp3 r6.z, c2, r1
            add r1.xyz, -r3, r6
            nrm r6.xyz, r1
            mad r1.xyz, r6, c209.x, r3
            mul r3, r1.y, c9
            mad r3, r1.x, c8, r3
            mad r1, r1.z, c10, r3
            add r1, r1, c11
            mul r3.xy, c45, v1
            add r0.w, r3.y, r3.x
            mov r3.y, c4.y
            mad r0.w, r0.w, c39.z, -r3.y
            mad o5.xy, c40.z, r0.w, r3.y
            mov o0, r1
            mov o1.xy, v2
            mov o2.w, r1.w
            mov o2.xyz, r4
            mov o3.xyz, r5
            mov o4.xyz, r2
            mov o5.zw, v1
            mov o6.xyz, r0
            mov o6.w, c4.y
            mov o7.w, c4.y
        
        // approximately 276 instruction slots used (8 texture, 268 arithmetic)
    };

    //TODO: make this a part of VS_ShadowDepth
    VertexShader VS_ShadowDepthProjTex
    <
        string BoundRadius   = "parameter register(208)";
        string DamageSampler = "parameter register(0)";
        string gShadowMatrix = "parameter register(60)";
        string gWorld        = "parameter register(0)";
        string switchOn      = "parameter register(8)";
    > =
    asm
    {
        //
        // Generated by Microsoft (R) HLSL Shader Compiler 9.26.952.2844
        //
        // Parameters:
        //
        //   float BoundRadius;
        //   sampler2D DamageSampler;
        //   row_major float4x4 gShadowMatrix;
        //   row_major float4x4 gWorld;
        //   bool switchOn;
        //
        //
        // Registers:
        //
        //   Name          Reg   Size
        //   ------------- ----- ----
        //   switchOn      b8       1
        //   gWorld        c0       4
        //   gShadowMatrix c60      4
        //   BoundRadius   c208     1
        //   DamageSampler s0       1
        //
        
            vs_3_0
            def c4, 9.99999975e-006, 1, 0.5, 126.732674
            def c5, 0, 0.00789062493, 1.52587891e-005, 65536
            def c6, 0.00390625, 256, -128, 0.0078125
            def c7, 1, 0, 0, 0
            dcl_position v0
            dcl_texcoord v1
            dcl_2d s0
            dcl_position o0
            dcl_texcoord o1.xyz
            if b8
              dp3 r0.x, v0, v0
              rsq r0.x, r0.x
              rcp r0.x, r0.x
              add r0.y, r0.x, c4.x
              rcp r0.y, r0.y
              mad r0.z, v0.z, -r0.y, c4.y
              mul r0.z, r0.z, c4.z
              mad r0.yw, v0.xxzy, r0.y, c4.x
              mul r1.xy, r0.ywzw, r0.ywzw
              add r1.x, r1.y, r1.x
              rsq r1.x, r1.x
              mul r0.yw, r0, r1.x
              mul r0.yz, r0.z, r0.xyww
              mad r1.xy, r0.yzzw, c4.z, c4.z
              mul r0.yz, r1.xxyw, c4.w
              frc r2.xy, r0_abs.yzzw
              sge r0.yz, r0, -r0
              lrp r3.xy, r0.yzzw, r2, -r2
              mov r1.zw, c5.x
              texldl r2, r1, s0
              mad r0.yz, r3.xxyw, -c5.y, r1.xxyw
              add r1.xy, r0.yzzw, c5.yxzw
              mov r1.zw, c5.x
              texldl r1, r1, s0
              add r4.xy, r0.yzzw, c5
              mov r4.zw, c5.x
              texldl r4, r4, s0
              add r5.xy, r0.yzzw, c5.y
              mov r5.zw, c5.x
              texldl r5, r5, s0
              mul r0.y, r2.x, c5.z
              frc r0.z, r0.y
              add r0.w, r0.y, -r0.z
              slt r0.y, r0.y, -r0.y
              slt r0.z, -r0.z, r0.z
              mad r6.z, r0.y, r0.z, r0.w
              mad r0.y, r6.z, -c5.w, r2.x
              mul r0.z, r0.y, c6.x
              frc r0.w, r0.z
              add r1.y, r0.z, -r0.w
              slt r0.z, r0.z, -r0.z
              slt r0.w, -r0.w, r0.w
              mad r6.y, r0.z, r0.w, r1.y
              mad r6.x, r6.y, -c6.y, r0.y
              mul r0.y, r1.x, c5.z
              frc r0.z, r0.y
              add r0.w, r0.y, -r0.z
              slt r0.y, r0.y, -r0.y
              slt r0.z, -r0.z, r0.z
              mad r2.z, r0.y, r0.z, r0.w
              mad r0.y, r2.z, -c5.w, r1.x
              mul r0.z, r0.y, c6.x
              frc r0.w, r0.z
              add r1.x, r0.z, -r0.w
              slt r0.z, r0.z, -r0.z
              slt r0.w, -r0.w, r0.w
              mad r2.y, r0.z, r0.w, r1.x
              mad r2.x, r2.y, -c6.y, r0.y
              mul r0.y, r4.x, c5.z
              frc r0.z, r0.y
              add r0.w, r0.y, -r0.z
              slt r0.y, r0.y, -r0.y
              slt r0.z, -r0.z, r0.z
              mad r1.z, r0.y, r0.z, r0.w
              mad r0.y, r1.z, -c5.w, r4.x
              mul r0.z, r0.y, c6.x
              frc r0.w, r0.z
              add r1.w, r0.z, -r0.w
              slt r0.z, r0.z, -r0.z
              slt r0.w, -r0.w, r0.w
              mad r1.y, r0.z, r0.w, r1.w
              mad r1.x, r1.y, -c6.y, r0.y
              mul r0.y, r5.x, c5.z
              frc r0.z, r0.y
              add r0.w, r0.y, -r0.z
              slt r0.y, r0.y, -r0.y
              slt r0.z, -r0.z, r0.z
              mad r4.z, r0.y, r0.z, r0.w
              mad r0.y, r4.z, -c5.w, r5.x
              mul r0.z, r0.y, c6.x
              frc r0.w, r0.z
              add r1.w, r0.z, -r0.w
              slt r0.z, r0.z, -r0.z
              slt r0.w, -r0.w, r0.w
              mad r4.y, r0.z, r0.w, r1.w
              mad r4.x, r4.y, -c6.y, r0.y
              add r0.yz, -r3.xxyw, c4.y
              mul r5.xyz, r6, r0.y
              mul r2.xyz, r3.x, r2
              mul r2.xyz, r0.z, r2
              mad r2.xyz, r5, r0.z, r2
              mul r0.yzw, r1.xxyz, r0.y
              mad r0.yzw, r0, r3.y, r2.xxyz
              mul r1.xyz, r3.x, r4
              mad r0.yzw, r1.xxyz, r3.y, r0
              add r0.yzw, r0, c6.z
              mul r0.yzw, r0, c6.w
              rcp r1.x, c208.x
              mul r0.x, r0.x, r1.x
              min r0.x, r0.x, c4.y
              mul r0.xyz, r0.yzww, r0.x
              mad r0.xyz, r0, c4.z, v0
            else
              mov r0.xyz, v0
            endif
            mul r1.xyz, r0.y, c1
            mad r0.xyw, r0.x, c0.xyzz, r1.xyzz
            mad r0.xyz, r0.z, c2, r0.xyww
            add r0.xyz, r0, c3
            mul r1, r0.y, c61
            mad r1, r0.x, c60, r1
            mad r0, r0.z, c62, r1
            add r0, r0, c63
            min r0.z, r0.z, c4.y
            add o0.z, -r0.z, c4.y
            mad o0.xyw, r0.xyzx, c7.xxzy, c7.yyzx
            mov o1.x, r0.w
            mov o1.yz, v1.xxyw
        
        // approximately 125 instruction slots used (8 texture, 117 arithmetic)
    };

    //TODO: make this a part of VS_TransformUnlit
    VertexShader VS_TransformUnlitVehicleDamage
    <
        string BoundRadius    = "parameter register(208)";
        string DamageSampler  = "parameter register(0)";
        string gWorldViewProj = "parameter register(8)";
        string switchOn       = "parameter register(8)";
    > =
    asm
    {
        //
        // Generated by Microsoft (R) HLSL Shader Compiler 9.26.952.2844
        //
        // Parameters:
        //
        //   float BoundRadius;
        //   sampler2D DamageSampler;
        //   row_major float4x4 gWorldViewProj;
        //   bool switchOn;
        //
        //
        // Registers:
        //
        //   Name           Reg   Size
        //   -------------- ----- ----
        //   switchOn       b8       1
        //   gWorldViewProj c8       4
        //   BoundRadius    c208     1
        //   DamageSampler  s0       1
        //
        
            vs_3_0
            def c0, 9.99999975e-006, 1, 0.5, 126.732674
            def c1, 0, 0.00789062493, 1.52587891e-005, 65536
            def c2, 0.00390625, 256, -128, 0.0078125
            dcl_position v0
            dcl_color v1
            dcl_texcoord v2
            dcl_2d s0
            dcl_position o0
            dcl_texcoord o1.xy
            dcl_color o2
            if b8
              dp3 r0.x, v0, v0
              rsq r0.x, r0.x
              rcp r0.x, r0.x
              add r0.y, r0.x, c0.x
              rcp r0.y, r0.y
              mad r0.z, v0.z, -r0.y, c0.y
              mul r0.z, r0.z, c0.z
              mad r0.yw, v0.xxzy, r0.y, c0.x
              mul r1.xy, r0.ywzw, r0.ywzw
              add r1.x, r1.y, r1.x
              rsq r1.x, r1.x
              mul r0.yw, r0, r1.x
              mul r0.yz, r0.z, r0.xyww
              mad r1.xy, r0.yzzw, c0.z, c0.z
              mul r0.yz, r1.xxyw, c0.w
              frc r2.xy, r0_abs.yzzw
              sge r0.yz, r0, -r0
              lrp r3.xy, r0.yzzw, r2, -r2
              mov r1.zw, c1.x
              texldl r2, r1, s0
              mad r0.yz, r3.xxyw, -c1.y, r1.xxyw
              add r1.xy, r0.yzzw, c1.yxzw
              mov r1.zw, c1.x
              texldl r1, r1, s0
              add r4.xy, r0.yzzw, c1
              mov r4.zw, c1.x
              texldl r4, r4, s0
              add r5.xy, r0.yzzw, c1.y
              mov r5.zw, c1.x
              texldl r5, r5, s0
              mul r0.y, r2.x, c1.z
              frc r0.z, r0.y
              add r0.w, r0.y, -r0.z
              slt r0.y, r0.y, -r0.y
              slt r0.z, -r0.z, r0.z
              mad r6.z, r0.y, r0.z, r0.w
              mad r0.y, r6.z, -c1.w, r2.x
              mul r0.z, r0.y, c2.x
              frc r0.w, r0.z
              add r1.y, r0.z, -r0.w
              slt r0.z, r0.z, -r0.z
              slt r0.w, -r0.w, r0.w
              mad r6.y, r0.z, r0.w, r1.y
              mad r6.x, r6.y, -c2.y, r0.y
              mul r0.y, r1.x, c1.z
              frc r0.z, r0.y
              add r0.w, r0.y, -r0.z
              slt r0.y, r0.y, -r0.y
              slt r0.z, -r0.z, r0.z
              mad r2.z, r0.y, r0.z, r0.w
              mad r0.y, r2.z, -c1.w, r1.x
              mul r0.z, r0.y, c2.x
              frc r0.w, r0.z
              add r1.x, r0.z, -r0.w
              slt r0.z, r0.z, -r0.z
              slt r0.w, -r0.w, r0.w
              mad r2.y, r0.z, r0.w, r1.x
              mad r2.x, r2.y, -c2.y, r0.y
              mul r0.y, r4.x, c1.z
              frc r0.z, r0.y
              add r0.w, r0.y, -r0.z
              slt r0.y, r0.y, -r0.y
              slt r0.z, -r0.z, r0.z
              mad r1.z, r0.y, r0.z, r0.w
              mad r0.y, r1.z, -c1.w, r4.x
              mul r0.z, r0.y, c2.x
              frc r0.w, r0.z
              add r1.w, r0.z, -r0.w
              slt r0.z, r0.z, -r0.z
              slt r0.w, -r0.w, r0.w
              mad r1.y, r0.z, r0.w, r1.w
              mad r1.x, r1.y, -c2.y, r0.y
              mul r0.y, r5.x, c1.z
              frc r0.z, r0.y
              add r0.w, r0.y, -r0.z
              slt r0.y, r0.y, -r0.y
              slt r0.z, -r0.z, r0.z
              mad r4.z, r0.y, r0.z, r0.w
              mad r0.y, r4.z, -c1.w, r5.x
              mul r0.z, r0.y, c2.x
              frc r0.w, r0.z
              add r1.w, r0.z, -r0.w
              slt r0.z, r0.z, -r0.z
              slt r0.w, -r0.w, r0.w
              mad r4.y, r0.z, r0.w, r1.w
              mad r4.x, r4.y, -c2.y, r0.y
              add r0.yz, -r3.xxyw, c0.y
              mul r5.xyz, r6, r0.y
              mul r2.xyz, r3.x, r2
              mul r2.xyz, r0.z, r2
              mad r2.xyz, r5, r0.z, r2
              mul r0.yzw, r1.xxyz, r0.y
              mad r0.yzw, r0, r3.y, r2.xxyz
              mul r1.xyz, r3.x, r4
              mad r0.yzw, r1.xxyz, r3.y, r0
              add r0.yzw, r0, c2.z
              mul r0.yzw, r0, c2.w
              rcp r1.x, c208.x
              mul r0.x, r0.x, r1.x
              min r0.x, r0.x, c0.y
              mul r0.xyz, r0.yzww, r0.x
              mad r0.xyz, r0, c0.z, v0
            else
              mov r0.xyz, v0
            endif
            mul r1, r0.y, c9
            mad r1, r0.x, c8, r1
            mad r0, r0.z, c10, r1
            add o0, r0, c11
            mov o1.xy, v2
            mov o2, v1
        
        // approximately 118 instruction slots used (8 texture, 110 arithmetic)
    };
#endif

#ifdef WIRE
    //TODO: make this a part of VS_Transform
    VertexShader VS_TransformWire
    <
        string Fade_Thickness   = "parameter register(210)";
        string gDayNightEffects = "parameter register(45)";
        string gViewInverse     = "parameter register(12)";
        string gWorld           = "parameter register(0)";
        string gWorldViewProj   = "parameter register(8)";
        string globalAnimUV0    = "parameter register(208)";
        string globalAnimUV1    = "parameter register(209)";
        string globalScalars    = "parameter register(39)";
        string globalScalars2   = "parameter register(40)";
    > =
    asm
    {
        //
        // Generated by Microsoft (R) HLSL Shader Compiler 9.26.952.2844
        //
        // Parameters:
        //
        //   float Fade_Thickness;
        //   float4 gDayNightEffects;
        //   row_major float4x4 gViewInverse;
        //   row_major float4x4 gWorld;
        //   row_major float4x4 gWorldViewProj;
        //   float3 globalAnimUV0;
        //   float3 globalAnimUV1;
        //   float4 globalScalars;
        //   float4 globalScalars2;
        //
        //
        // Registers:
        //
        //   Name             Reg   Size
        //   ---------------- ----- ----
        //   gWorld           c0       4
        //   gWorldViewProj   c8       4
        //   gViewInverse     c12      4
        //   globalScalars    c39      1
        //   globalScalars2   c40      1
        //   gDayNightEffects c45      1
        //   globalAnimUV0    c208     1
        //   globalAnimUV1    c209     1
        //   Fade_Thickness   c210     1
        //
        
            vs_3_0
            def c4, 9.99999975e-006, 1, 0, -0.00200000009
            def c5, 320, 0, 0, 0
            dcl_position v0
            dcl_color v1
            dcl_texcoord v2
            dcl_normal v3
            dcl_position o0
            dcl_texcoord o1.xy
            dcl_texcoord1 o2
            dcl_color o3
            dcl_texcoord6 o4
            dcl_texcoord8 o5
            dcl_texcoord7 o6
            mul r0.xyz, c1, v3.y
            mad r0.xyz, v3.x, c0, r0
            mad r0.xyz, v3.z, c2, r0
            add r0.xyz, r0, c4.x
            dp3 r0.w, r0, r0
            rsq r0.w, r0.w
            mul o2.xyz, r0, r0.w
            mad r0.xyz, v2.xyxw, c4.yyzw, c4.zzyw
            dp3 o1.x, c208, r0
            dp3 o1.y, c209, r0
            mov r0.xyz, c12
            mul r0.xyz, r0, c210.x
            dp3 r1.x, r0, c0
            dp3 r1.y, r0, c1
            dp3 r1.z, r0, c2
            add r0.xyz, r1, v0
            mul r0.yw, r0.y, c9.xxzw
            mad r0.xy, r0.x, c8.xwzw, r0.ywzw
            mad r0.xy, r0.z, c10.xwzw, r0
            add r0.xy, r0, c11.xwzw
            rcp r0.y, r0.y
            mul r1, c9, v0.y
            mad r1, v0.x, c8, r1
            mad r1, v0.z, c10, r1
            add r1, r1, c11
            rcp r0.z, r1.w
            mul r0.z, r1.x, r0.z
            mad r0.x, r0.x, r0.y, -r0.z
            mul_sat o6.z, r0.x, c5.x
            mul r0.xy, c45, v1
            add r0.x, r0.y, r0.x
            mov r0.y, c4.y
            mad r0.x, r0.x, c39.z, -r0.y
            mad o3.xy, c40.z, r0.x, r0.y
            mul r0.xyz, c1, v0.y
            mad r0.xyz, v0.x, c0, r0
            mad r0.xyz, v0.z, c2, r0
            add r0.xyz, r0, c3
            add r2.xyz, r0, -c15
            mov o4.xyz, r0
            dp3 r0.x, r2, r2
            rsq r0.x, r0.x
            rcp r0.x, r0.x
            mov r2.xyz, v0
            add r0.yzw, r2.xxyz, v3.xxyz
            mul r2.xy, r0.z, c9
            mad r0.yz, r0.y, c8.xxyw, r2.xxyw
            mad r0.yz, r0.w, c10.xxyw, r0
            add r0.yz, r0, c11.xxyw
            add r0.yz, r1.xxyw, -r0
            mul r0.yz, r0, c4.w
            mad r0.xy, r0.yzzw, r0.x, r1
            mov r0.zw, r1
            mov o6.xyw, r1
            mov o0, r0
            mov o5, r0
            mov o2.w, r0.w
            mov o3.zw, v1
            mov o4.w, c4.y
        
        // approximately 59 instruction slots used
    };

    //TODO: make this a part of VS_TransformD
    VertexShader VS_TransformDWire
    <
        string gDayNightEffects = "parameter register(45)";
        string gWorld           = "parameter register(0)";
        string gWorldViewProj   = "parameter register(8)";
        string globalAnimUV0    = "parameter register(208)";
        string globalAnimUV1    = "parameter register(209)";
        string globalScalars    = "parameter register(39)";
        string globalScalars2   = "parameter register(40)";
    > =
    asm
    {
        //
        // Generated by Microsoft (R) HLSL Shader Compiler 9.26.952.2844
        //
        // Parameters:
        //
        //   float4 gDayNightEffects;
        //   row_major float4x4 gWorld;
        //   row_major float4x4 gWorldViewProj;
        //   float3 globalAnimUV0;
        //   float3 globalAnimUV1;
        //   float4 globalScalars;
        //   float4 globalScalars2;
        //
        //
        // Registers:
        //
        //   Name             Reg   Size
        //   ---------------- ----- ----
        //   gWorld           c0       4
        //   gWorldViewProj   c8       4
        //   globalScalars    c39      1
        //   globalScalars2   c40      1
        //   gDayNightEffects c45      1
        //   globalAnimUV0    c208     1
        //   globalAnimUV1    c209     1
        //
        
            vs_3_0
            def c4, 9.99999975e-006, 1, 0, -1
            dcl_position v0
            dcl_color v1
            dcl_texcoord v2
            dcl_normal v3
            dcl_position o0
            dcl_texcoord o1.xy
            dcl_texcoord1 o2
            dcl_color o3
            dcl_texcoord6 o4
            mul r0.xyz, c1, v0.y
            mad r0.xyz, v0.x, c0, r0
            mad r0.xyz, v0.z, c2, r0
            add o4.xyz, r0, c3
            mul r0.xyz, c1, v3.y
            mad r0.xyz, v3.x, c0, r0
            mad r0.xyz, v3.z, c2, r0
            add r0.xyz, r0, c4.x
            dp3 r0.w, r0, r0
            rsq r0.w, r0.w
            mul o2.xyz, r0, r0.w
            mad r0.xyz, v2.xyxw, c4.yyzw, c4.zzyw
            dp3 o1.x, c208, r0
            dp3 o1.y, c209, r0
            mul r0.xy, c45, v1
            add r0.x, r0.y, r0.x
            mov r0.yw, c4
            mad r0.x, r0.x, c39.z, r0.w
            mad o3.xy, c40.z, r0.x, r0.y
            mul r0, c9, v0.y
            mad r0, v0.x, c8, r0
            mad r0, v0.z, c10, r0
            add r0, r0, c11
            mov o0, r0
            mov o2.w, r0.w
            mov o3.zw, v1
            mov o4.w, c4.y
        
        // approximately 27 instruction slots used
    };

    //== VS_TransformDWire
    VertexShader VS_TransformAlphaClipDWire
    <
        string gDayNightEffects = "parameter register(45)";
        string gWorld           = "parameter register(0)";
        string gWorldViewProj   = "parameter register(8)";
        string globalAnimUV0    = "parameter register(208)";
        string globalAnimUV1    = "parameter register(209)";
        string globalScalars    = "parameter register(39)";
        string globalScalars2   = "parameter register(40)";
    > =
    asm
    {
        //
        // Generated by Microsoft (R) HLSL Shader Compiler 9.26.952.2844
        //
        // Parameters:
        //
        //   float4 gDayNightEffects;
        //   row_major float4x4 gWorld;
        //   row_major float4x4 gWorldViewProj;
        //   float3 globalAnimUV0;
        //   float3 globalAnimUV1;
        //   float4 globalScalars;
        //   float4 globalScalars2;
        //
        //
        // Registers:
        //
        //   Name             Reg   Size
        //   ---------------- ----- ----
        //   gWorld           c0       4
        //   gWorldViewProj   c8       4
        //   globalScalars    c39      1
        //   globalScalars2   c40      1
        //   gDayNightEffects c45      1
        //   globalAnimUV0    c208     1
        //   globalAnimUV1    c209     1
        //
        
            vs_3_0
            def c4, 9.99999975e-006, 1, 0, -1
            dcl_position v0
            dcl_color v1
            dcl_texcoord v2
            dcl_normal v3
            dcl_position o0
            dcl_texcoord o1.xy
            dcl_texcoord1 o2
            dcl_color o3
            dcl_texcoord6 o4
            mul r0.xyz, c1, v0.y
            mad r0.xyz, v0.x, c0, r0
            mad r0.xyz, v0.z, c2, r0
            add o4.xyz, r0, c3
            mul r0.xyz, c1, v3.y
            mad r0.xyz, v3.x, c0, r0
            mad r0.xyz, v3.z, c2, r0
            add r0.xyz, r0, c4.x
            dp3 r0.w, r0, r0
            rsq r0.w, r0.w
            mul o2.xyz, r0, r0.w
            mad r0.xyz, v2.xyxw, c4.yyzw, c4.zzyw
            dp3 o1.x, c208, r0
            dp3 o1.y, c209, r0
            mul r0.xy, c45, v1
            add r0.x, r0.y, r0.x
            mov r0.yw, c4
            mad r0.x, r0.x, c39.z, r0.w
            mad o3.xy, c40.z, r0.x, r0.y
            mul r0, c9, v0.y
            mad r0, v0.x, c8, r0
            mad r0, v0.z, c10, r0
            add r0, r0, c11
            mov o0, r0
            mov o2.w, r0.w
            mov o3.zw, v1
            mov o4.w, c4.y
        
        // approximately 27 instruction slots used
    };
#endif