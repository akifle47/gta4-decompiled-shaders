#define IS_VEHICLE_SHADER

#include "megashader_todo.fxh"
#include "common_functions.fxh"
#ifndef NO_SHADOW_CASTING
    #include "common_shadow.fxh"
#endif //!NO_SHADOW_CASTING
#include "common_lighting.fxh"

#ifdef VEHICLE_DAMAGE
    float3 DecodeDamageSample(in float dmgSample)
    {
        float3 result;
        float v0 = dmgSample / 65536.0;
        float v0_frc = frac(v0);
        float v0_int = v0 - v0_frc;
        float v1 = v0 < -v0;
        float v2 = -v0_frc < v0_frc;
        result.z = v1 * v2 + v0_int;
        float v3 = dmgSample - (result.z * 65536.0);
        float v4 = v3 / 256.0;
        float d4_frc = frac(v4);
        float d4_int = v4 - d4_frc;
        float v5 = v4 < -v4;
        float v6 = -d4_frc < d4_frc;
        result.y = v5 * v6 + d4_int;
        result.x = v3 - (result.y * 256);

        return result;
    }
    
    void ComputeVehicleDamage(inout float3 position, inout float3 normal)
    {
        const float textureSize = 126.732674;
        const float textureOffset = 1.0 / textureSize;

        if(switchOn)
        {
            float dist = length(position);
            float invDist = 1.0 / (dist + 0.00001);
            float v0 = (1.0 - position.z * invDist) * 0.5;
            float2 v1 = normalize(position.xy * invDist + 0.00001) * v0;

            float2 v2 = v1 * 0.5 + 0.5;
            float2 v3 = v2 * textureSize;
            float2 v4 = frac(v3) * sign(v3);
            float2 inv_v4 = 1.0 - v4;
            v3 = v2 - (v4 / textureSize);
            
            float4 sampleCoords = float4(v2, 0, 0);
            float sample1 = tex2Dlod(DamageSampler, sampleCoords).x;

            sampleCoords = float4(v3 + float2(textureOffset, 0), 0, 0);
            float sample2 = tex2Dlod(DamageSampler, sampleCoords).x;

            sampleCoords = float4(v3 + float2(0, textureOffset), 0, 0);
            float sample3 = tex2Dlod(DamageSampler, sampleCoords).x;

            sampleCoords = float4(v3 + float2(textureOffset, textureOffset), 0, 0);
            float sample4 = tex2Dlod(DamageSampler, sampleCoords).x;

            float3 a = DecodeDamageSample(sample1);
            float3 b = DecodeDamageSample(sample2);
            float3 c = DecodeDamageSample(sample3);
            float3 d = DecodeDamageSample(sample4);
            
            float boundMult = min(dist / BoundRadius, 1.0);

            float3 positionOffset = (a * inv_v4.x * inv_v4.y) + (b * v4.x * inv_v4.y) + (c * inv_v4.x * v4.y) + (d * v4.x * v4.y);
            positionOffset = (positionOffset - 128.0) / 128.0;
            position += (positionOffset * boundMult * 0.5);

            float3 v9 = (normal - 1.0) == 0;
            float v9_prod = v9.x * v9.y * v9.z;
            if(v9_prod != -v9_prod)
            {
                normal = float3(0, 0, normal.z);
            }
            else
            {
                float4 n0 = (v3.xyxy + float4(-0.5, -0.5, -0.492109388, -0.5)) * 2;
                float4 n1 = n0 * n0;
                n1.xy = n1.yw + n1.xz;
                n1.xy = sqrt(n1.xy) * (n1.xy > 0.0);

                float n3 = 1.0 - (n1.x * 2.0);
                float n4 = lerp(n3, -1, n3 < -1.0);
                float n5 = (n4 < 1.0) * (n4 > -1.0) * (n1.x > 0.0);
                float n8 = sqrt(1.0 - (n4 * n4));
                n1.x = n8 / n1.x;
                n1.x *= n5;
                float2 n9 = n0.xy * n1.x;
                float3 n10 = (a - 128.0) * boundMult;
                n10 /= 256.0;

                float n12 = 1.0 - (n1.y * 2.0);
                float n13 = lerp(n12, -1.0, n12 < -1.0);
                float n14 = (n13 < 1.0) * (-1.0 < n13) * (0.0 < n1.y);
                float n17 = sqrt(1.0 - (n13 * n13));
                n1.y = n17 / n1.y;
                n1.y *= n14;
                float2 n18 = n0.zw * n1.y;
                float3 n20 = (b - 128.0) * boundMult;
                n20 = (n20 / 256) - n10;
                
                float3 n19 = float3(n18, n13) + 0.00001;
                n19 -= float3(n9, n4);

                float n21 = dot(n20, normal);
                float n22 = dot(n19, n19);
                n21 /= -n22;
                float3 n24 = n19 * n21;
                float3 n25 = normal + (n24 * (0.0 < n22));

                v3 = (v3 - float2(0.5, 0.492109388)) * 2;
                float2 n26 = v3 * v3;
                float n27 = n26.x + n26.y;
                n27 = sqrt(n27) * (0 < n27);
                float n29 = 1.0 - (n27 * 2.0);
                float n31 = lerp(n29, -1.0, n29 < -1.0);
                float n32 = (n31 < 1.0) * (-1.0 < n31) * (0.0 < n27);
                float n35 = sqrt(1.0 - (n31 * n31)); 
                n27 = n35 / n27;
                n27 *= n32;
                float2 n36 = v3 * n27;
                float3 n37 = (c - 128.0) * boundMult;
                n37 = (n37 / 256.0) - n10;

                float3 n38 = float3(n36, n31) - float3(n9, n4);
                float n39 = dot(n37, normal);
                float n40 = dot(n38, n38);
                n39 /= -n40;
                float3 n42 = n38 * n39;
                n42 = n42 * (0 < n40) + n25;
                normal = normalize(n42);
            }
        }
    }
#endif //VEHICLE_DAMAGE

#ifdef DIRT
    void ComputeDirt(inout float4 diffuse, in float2 dirtTexCoord)
    {
        if(dirtLevel > 0.0)
        {
            float dirtTex = tex2D(DirtSampler, dirtTexCoord).x;
            float4 dirtCol;
            dirtCol.w = dirtTex * dirtLevel;
            dirtCol.xyz = lerp(diffuse.xyz, dirtColor, dirtCol.w);
            diffuse = dirtTex >= 0.0 ? float4(dirtCol.xyz, 1.0 - dirtCol.w) : float4(diffuse.xyz, 1.0);
        }
        else
        {
            diffuse.w = 1.0;
        }
    }
#endif //DIRT

#if defined(DIRT_UV) && defined(DIFFUSE_TEXTURE2)
    #error DIRT_UV and DIFFUSE_TEXTURE2 are mutually exclusive
#endif //DIRT_UV && DIFFUSE_TEXTURE2

struct VS_InputVehicle
{
    float3 Position     : POSITION;
    float2 TexCoord0    : TEXCOORD0;
#ifdef DIRT_UV
    float2 DirtTexCoord : TEXCOORD1;
#elif defined(DIFFUSE_TEXTURE2)
    float2 TexCoord1    : TEXCOORD1;
#endif //DIRT_UV
    float3 Normal       : NORMAL;
#ifdef NORMAL_MAP
    float4 Tangent      : TANGENT;
#endif //NORMAL_MAP
    float4 Color        : COLOR;
};

struct VS_InputSkinVehicle
{
    float3 Position     : POSITION;
    float4 BlendWeights : BLENDWEIGHT;
    float4 BlendIndices : BLENDINDICES;
    float2 TexCoord0    : TEXCOORD0;
#ifdef DIRT_UV
    float2 DirtTexCoord : TEXCOORD1;
#elif defined(DIFFUSE_TEXTURE2)
    float2 TexCoord1    : TEXCOORD1;
#endif //DIRT_UV
    float3 Normal       : NORMAL;
#ifdef NORMAL_MAP
    float4 Tangent      : TANGENT;
#endif //NORMAL_MAP
    float4 Color        : COLOR;
};

struct VS_OutputVehicleShadowDepth
{
    float4 Position : POSITION;
    float  Depth    : TEXCOORD0;
};

struct VS_OutputVehicleShadowDepthDisc
{
    float4 Position : POSITION;
    float2 TexCoord : TEXCOORD0;
    float4 Color    : COLOR;
};

VS_OutputVehicleShadowDepthDisc VS_VehicleTransformUnlitDisc(VS_InputVehicle IN)
{
    VS_OutputVehicleShadowDepthDisc OUT;

    OUT.Position = mul(float4(IN.Position, 1.0), gWorldViewProj);
    OUT.TexCoord = IN.TexCoord0;
    OUT.Color = IN.Color;
    
    return OUT;
}

VS_OutputVehicleShadowDepth VS_VehicleShadowDepth(VS_InputVehicle IN)
{
    VS_OutputVehicleShadowDepth OUT;

    float3 position = IN.Position;
    float3 normal = float3(0, 0, 0);

    #ifdef VEHICLE_DAMAGE
        ComputeVehicleDamage(position, normal);
    #endif

    #ifdef TIRE_DEFORMATION
        position = mul(float4(position, 1.0), matWheelTransform).xyz;
    #endif //TIRE_DEFORMATION

    float3 posWorld = mul(float4(position, 1.0), gWorld).xyz;
    float4 posClip = mul(float4(posWorld, 1.0), gShadowMatrix);

    OUT.Position.xyw = float3(posClip.xy, 1.0);
    OUT.Position.z = 1.0 - min(posClip.z, 1.0);
    OUT.Depth = posClip.w;
    
    return OUT;
}

#ifdef NO_SHADOW_CASTING_VEHICLE
    VS_OutputVehicleShadowDepthDisc VS_VehicleShadowDepthSkinDisc(VS_InputSkinVehicle IN)
    {
        VS_OutputVehicleShadowDepthDisc OUT;

        int i = D3DCOLORtoUBYTE4(IN.BlendIndices).b;
        float4x3 skinMtx = gBoneMtx[i];
        float3 posWorld = mul(float4(IN.Position, 1.0), skinMtx).xyz;

        OUT.Position = mul(float4(posWorld, 1.0), gWorldViewProj);
        OUT.TexCoord = IN.TexCoord0;
        OUT.Color = IN.Color;
        
        return OUT;
    }
#else
    VS_OutputVehicleShadowDepth VS_VehicleShadowDepthSkin(VS_InputSkinVehicle IN)
    {
        VS_OutputVehicleShadowDepth OUT;

        float3 position = IN.Position;
        float3 normal = float3(0, 0, 0);

        #ifdef VEHICLE_DAMAGE
            ComputeVehicleDamage(position, normal);
        #endif

        float4x3 skinMtx = ComputeSkinMatrix(IN.BlendIndices, IN.BlendWeights);
        float3 posWorld = mul(float4(position, 1.0), skinMtx).xyz + gWorld[3].xyz;
        float4 posClip = mul(float4(posWorld, 1), gShadowMatrix);

        float4 cascadeMask = ComputeCascadeMask(posClip);

        OUT.Position.x = dot(cascadeMask, float4(1, 1, 1, 1)) * 0.00001 + posClip.x;
        OUT.Position.yw = float2(posClip.y, 1);
        OUT.Position.z = 1.0 - min(posClip.z, 1.0);

        OUT.Depth = posClip.w;

        return OUT;
    }
#endif //NO_SHADOW_CASTING_VEHICLE


struct VS_OutputVehicleUnlit
{
    float4 Position      : POSITION;
#ifdef DIRT_UV
    float2 TexCoord0     : TEXCOORD0;
    float2 DirtTexCoord  : TEXCOORD7;
#elif defined(DIFFUSE_TEXTURE2)
    float4 TexCoord0And1 : TEXCOORD0;
#else
    float2 TexCoord0     : TEXCOORD0;
#endif //DIRT_UV
    float4 Color         : COLOR;
};

VS_OutputVehicleUnlit VS_VehicleTransformUnlit(VS_InputVehicle IN)
{
    VS_OutputVehicleUnlit OUT;

    float3 position = IN.Position;
    float3 normal = float3(0, 0, 0);
    
    #ifdef VEHICLE_DAMAGE
        ComputeVehicleDamage(position, normal);
    #endif

    OUT.Position = mul(float4(position, 1.0), gWorldViewProj);
    OUT.Color = IN.Color;

    #ifdef DIFFUSE_TEXTURE2
        OUT.TexCoord0And1.xy = IN.TexCoord0;
        OUT.TexCoord0And1.zw = IN.TexCoord1;
    #else
        OUT.TexCoord0 = IN.TexCoord0;
    #endif //DIFFUSE_TEXTURE2

    #ifdef DIRT_UV
        OUT.DirtTexCoord = IN.DirtTexCoord;
    #endif //DIRT_UV

    return OUT;
}

VS_OutputVehicleUnlit VS_VehicleTransformSkinUnlit(VS_InputSkinVehicle IN)
{
    VS_OutputVehicleUnlit OUT;

    float3 position = IN.Position;
    float3 normal = float3(0, 0, 0);

    #ifdef VEHICLE_DAMAGE
        ComputeVehicleDamage(position, normal);
    #endif

    int i = D3DCOLORtoUBYTE4(IN.BlendIndices).b;
    float4x3 skinMtx = gBoneMtx[i];
    float3 posWorld = mul(float4(position, 1.0), skinMtx).xyz;

    OUT.Position = mul(float4(posWorld, 1.0), gWorldViewProj);
    
    #ifdef DIFFUSE_TEXTURE2
        OUT.TexCoord0And1.xy = IN.TexCoord0;
        OUT.TexCoord0And1.zw = IN.TexCoord1;
    #else
        OUT.TexCoord0 = IN.TexCoord0;
    #endif //DIFFUSE_TEXTURE2

    #ifdef DIRT_UV
        OUT.DirtTexCoord = IN.DirtTexCoord;
    #endif //DIRT_UV

    #ifdef DIMMER_SET
        int index = int(IN.Color.w * 255.0 + 0.5);
        OUT.Color.xyz = IN.Color.xyz * dimmerSet[index];
    #else
        OUT.Color.xyz = IN.Color.xyz;
    #endif //DIMMER_SET
    OUT.Color.w = 1.0;

    return OUT;
}


struct VS_OutputVehicle
{
    float4 Position            : POSITION;
#ifdef DIRT_UV
    float2 TexCoord0           : TEXCOORD0;
    float2 DirtTexCoord        : TEXCOORD7;
#elif defined(DIFFUSE_TEXTURE2)
    float4 TexCoord0And1       : TEXCOORD0;
#else
    float2 TexCoord0           : TEXCOORD0;
#endif //DIRT_UV
    float4 NormalWorldAndDepth : TEXCOORD1;
    float4 PositionWorld       : TEXCOORD2;
#ifdef NORMAL_MAP
    float3 TangentWorld        : TEXCOORD4;
    float3 BitangentWorld      : TEXCOORD5;
#endif //NORMAL_MAP
    float3 FragToViewDir       : TEXCOORD3;
    float4 Color               : COLOR;
};

VS_OutputVehicle VS_VehicleTransform(VS_InputSkinVehicle IN)
{
    VS_OutputVehicle OUT;

    float3 position = IN.Position;
    float3 normal = IN.Normal;

    #ifdef VEHICLE_DAMAGE
        ComputeVehicleDamage(position, normal);
    #endif

    float4x4 worldMtx = gWorld;
    #ifdef TIRE_DEFORMATION
        worldMtx = matWheelTransform;
    #endif //TIRE_DEFORMATION
    float3 posWorld = mul(float4(position, 1.0), worldMtx).xyz;
    float4 posClip = mul(float4(posWorld, 1.0), gWorldViewProj);

    posWorld += gWorld[3].xyz;
    OUT.FragToViewDir = gViewInverse[3].xyz - posWorld;

    OUT.Position = posClip;
    OUT.PositionWorld = float4(posWorld, 1.0);
    
    float3 normalWorld = normalize(mul(normal, (float3x3)worldMtx) + 0.00001);
    OUT.NormalWorldAndDepth.xyz = normalWorld;
    OUT.NormalWorldAndDepth.w = posClip.w;
    #ifdef NORMAL_MAP
        float3 tangentWorld = normalize(mul(IN.Tangent.xyz, (float3x3)worldMtx) + 0.00001);
        float3 bitangentWorld = cross(tangentWorld, normalWorld);
        OUT.TangentWorld.xyz = tangentWorld;
        OUT.BitangentWorld.xyz = bitangentWorld * IN.Tangent.w;
    #endif //NORMAL_MAP

    #ifdef DIFFUSE_TEXTURE2
        OUT.TexCoord0And1.xy = IN.TexCoord0;
        OUT.TexCoord0And1.zw = IN.TexCoord1;
    #else
        OUT.TexCoord0 = IN.TexCoord0;
    #endif //DIFFUSE_TEXTURE2

    #ifdef DIRT_UV
        OUT.DirtTexCoord = IN.DirtTexCoord;
    #endif //DIRT_UV

    #ifdef DIMMER_SET
        int index = int(IN.Color.w * 255.0 + 0.5);
        OUT.Color.xyz = IN.Color.xyz * dimmerSet[index];
    #else
        OUT.Color.xyz = IN.Color.xyz;
    #endif //DIMMER_SET
    OUT.Color.w = 1.0;

    return OUT;
}

VS_OutputVehicle VS_VehicleTransformSkin(VS_InputSkinVehicle IN)
{
    VS_OutputVehicle OUT;

    float3 position = IN.Position;
    float3 normal = IN.Normal;

    #ifdef VEHICLE_DAMAGE
        ComputeVehicleDamage(position, normal);
    #endif

    int i = D3DCOLORtoUBYTE4(IN.BlendIndices).b;
    float4x3 skinMtx = gBoneMtx[i];
    float3 posWorld = mul(float4(position, 1.0), skinMtx).xyz;
    float4 posClip = mul(float4(posWorld, 1.0), gWorldViewProj);

    posWorld += gWorld[3].xyz;
    OUT.FragToViewDir = gViewInverse[3].xyz - posWorld;

    OUT.Position = posClip;
    OUT.PositionWorld = float4(posWorld, 1.0);
    
    float3 normalWorld = mul(normal, (float3x3)skinMtx);
    OUT.NormalWorldAndDepth.xyz = normalWorld;
    OUT.NormalWorldAndDepth.w = posClip.w;
    #ifdef NORMAL_MAP
        float3 tangentWorld = mul(IN.Tangent.xyz, (float3x3)skinMtx);
        float3 bitangentWorld = cross(tangentWorld, normalWorld);
        OUT.TangentWorld.xyz = tangentWorld;
        OUT.BitangentWorld.xyz = bitangentWorld * IN.Tangent.w;
    #endif //NORMAL_MAP

    #ifdef DIFFUSE_TEXTURE2
        OUT.TexCoord0And1.xy = IN.TexCoord0;
        OUT.TexCoord0And1.zw = IN.TexCoord1;
    #else
        OUT.TexCoord0 = IN.TexCoord0;
    #endif //DIFFUSE_TEXTURE2

    #ifdef DIRT_UV
        OUT.DirtTexCoord = IN.DirtTexCoord;
    #endif //DIRT_UV

    #ifdef DIMMER_SET
        int index = int(IN.Color.w * 255.0 + 0.5);
        OUT.Color.xyz = IN.Color.xyz * dimmerSet[index];
    #else
        OUT.Color.xyz = IN.Color.xyz;
    #endif //DIMMER_SET
    OUT.Color.w = 1.0;

    return OUT;
}


#if defined(ENVIRONMENT_MAP) || defined(SPECULAR2)
    #define COMPUTE_VIEW_DIR
#endif

struct VS_OutputVehicleDeferred
{
    float4 Position            : POSITION;
#ifdef DIRT_UV
    float2 TexCoord0           : TEXCOORD0;
    float2 DirtTexCoord        : TEXCOORD7;
#elif defined(DIFFUSE_TEXTURE2)
    float4 TexCoord0And1       : TEXCOORD0;
#else
    float2 TexCoord0           : TEXCOORD0;
#endif //DIRT_UV
    float4 NormalWorldAndDepth : TEXCOORD1;
#ifdef NORMAL_MAP
    float3 TangentWorld        : TEXCOORD4;
    float3 BitangentWorld      : TEXCOORD5;
#endif //NORMAL_MAP
#ifdef COMPUTE_VIEW_DIR
    float3 FragToViewDir       : TEXCOORD3;
#endif //COMPUTE_VIEW_DIR
    float4 Color               : COLOR;
    float4 PositionWorld       : TEXCOORD6;
};

VS_OutputVehicleDeferred VS_VehicleTransformD(VS_InputVehicle IN)
{
    VS_OutputVehicleDeferred OUT;

    float3 position = IN.Position;
    float3 normal = IN.Normal;

    #ifdef VEHICLE_DAMAGE
        ComputeVehicleDamage(position, normal);
    #endif

    float4x4 worldMtx = gWorld;
    #ifdef TIRE_DEFORMATION
        worldMtx = matWheelTransform;
    #endif //TIRE_DEFORMATION
    float3 posWorld = mul(float4(position, 1.0), worldMtx).xyz;

    #ifdef COMPUTE_VIEW_DIR
        OUT.FragToViewDir = gViewInverse[3].xyz - (posWorld + worldMtx[3].xyz);
    #endif //COMPUTE_VIEW_DIR

    #ifdef TIRE_DEFORMATION
        if(tyreDeformSwitchOn)
        {
            const float rimRadius = tyreDeformParams2.x;
            const float groundZ = tyreDeformParams2.y;
            const float deformScalar = tyreDeformParams2.z;
            const float tireScalar = tyreDeformParams2.w;

            float tireDist = dot(position.yz, position.yz);

            float3 scaledPos = position * tireScalar;
            float isRubber = (tireDist * tireScalar) > pow(rimRadius * 1.1, 2);

            float isUnderGround = posWorld.z < groundZ + 0.03;
            float flatFactor = max(groundZ - posWorld.z, 0.0);
            float groundDist = ((groundZ + 0.03) - posWorld.z) * deformScalar;
            float bulgeFactor = 1.0 - groundDist;
            bulgeFactor = (groundDist > 1) * bulgeFactor + groundDist;
            
            float3 targetPos;
            targetPos.x = scaledPos.x - (tyreDeformParams.w * bulgeFactor);
            targetPos.x += (tyreDeformParams.x * position.x * bulgeFactor);
            targetPos.yz = tyreDeformParams.yz * flatFactor + scaledPos.yz;

            targetPos -= (position * tireScalar);
            targetPos *= isUnderGround;
            targetPos = scaledPos + (targetPos * isRubber);
            float t = (rimRadius * rimRadius) < tireDist;
            position = lerp(position, targetPos, t);
        }
    #endif //TIRE_DEFORMATION

    posWorld = mul(float4(position, 1.0), worldMtx).xyz;
    float4 posClip = mul(float4(posWorld, 1.0), gWorldViewProj);

    OUT.Position = posClip;
    OUT.PositionWorld = float4(posWorld, 1.0);
    
    float3 normalWorld = normalize(mul(normal, (float3x3)worldMtx) + 0.00001);
    OUT.NormalWorldAndDepth.xyz = normalWorld;
    OUT.NormalWorldAndDepth.w = posClip.w;
    #ifdef NORMAL_MAP
        float3 tangentWorld = normalize(mul(IN.Tangent.xyz, (float3x3)worldMtx) + 0.00001);
        float3 bitangentWorld = cross(tangentWorld, normalWorld);
        OUT.TangentWorld.xyz = tangentWorld;
        OUT.BitangentWorld.xyz = bitangentWorld * IN.Tangent.w;
    #endif //NORMAL_MAP

    #ifdef DIFFUSE_TEXTURE2
        OUT.TexCoord0And1.xy = IN.TexCoord0;
        OUT.TexCoord0And1.zw = IN.TexCoord1;
    #else
        OUT.TexCoord0 = IN.TexCoord0;
    #endif //DIFFUSE_TEXTURE2

    #ifdef DIRT_UV
        OUT.DirtTexCoord = IN.DirtTexCoord;
    #endif //DIRT_UV

    #ifdef DIMMER_SET
        int index = int(IN.Color.w * 255.0 + 0.5);
        OUT.Color.xyz = IN.Color.xyz * dimmerSet[index];
    #else
        OUT.Color.xyz = IN.Color.xyz;
    #endif //DIMMER_SET
    OUT.Color.w = 1.0;

    return OUT;
}

VS_OutputVehicleDeferred VS_VehicleTransformSkinD(VS_InputSkinVehicle IN)
{
    VS_OutputVehicleDeferred OUT;

    float3 position = IN.Position;
    float3 normal = IN.Normal;

    #ifdef VEHICLE_DAMAGE
        ComputeVehicleDamage(position, normal);
    #endif

    int i = D3DCOLORtoUBYTE4(IN.BlendIndices).b;
    float4x3 skinMtx = gBoneMtx[i];
    float3 posWorld = mul(float4(position, 1.0), skinMtx).xyz;
    float4 posClip = mul(float4(posWorld, 1.0), gWorldViewProj);

    #ifdef COMPUTE_VIEW_DIR
        OUT.FragToViewDir = gViewInverse[3].xyz - (posWorld + gWorld[3].xyz);
    #endif //COMPUTE_VIEW_DIR

    OUT.Position = posClip;
    OUT.PositionWorld = float4(posWorld, 1.0);
    
    float3 normalWorld = mul(normal, (float3x3)skinMtx);
    OUT.NormalWorldAndDepth.xyz = normalWorld;
    OUT.NormalWorldAndDepth.w = posClip.w;
    #ifdef NORMAL_MAP
        float3 tangentWorld = mul(IN.Tangent.xyz, (float3x3)skinMtx);
        float3 bitangentWorld = cross(tangentWorld, normalWorld);
        OUT.TangentWorld.xyz = tangentWorld;
        OUT.BitangentWorld.xyz = bitangentWorld * IN.Tangent.w;
    #endif //NORMAL_MAP

    #ifdef DIFFUSE_TEXTURE2
        OUT.TexCoord0And1.xy = IN.TexCoord0;
        OUT.TexCoord0And1.zw = IN.TexCoord1;
    #else
        OUT.TexCoord0 = IN.TexCoord0;
    #endif //DIFFUSE_TEXTURE2

    #ifdef DIRT_UV
        OUT.DirtTexCoord = IN.DirtTexCoord;
    #endif //DIRT_UV

    #ifdef DIMMER_SET
        int index = int(IN.Color.w * 255.0 + 0.5);
        OUT.Color.xyz = IN.Color.xyz * dimmerSet[index];
    #else
        OUT.Color.xyz = IN.Color.xyz;
    #endif //DIMMER_SET
    OUT.Color.w = 1.0;

    return OUT;
}


struct PS_OutputDeferred
{
    float4 Diffuse       : COLOR0;
    float4 Normal        : COLOR1;
    //intensity and power/glossiness
    float4 SpecularAndAO : COLOR2;
    float4 Stencil       : COLOR3;
};

PS_OutputDeferred PS_DeferredVehicleTextured(VS_OutputVehicleDeferred IN)
{
    PS_OutputDeferred OUT;

    #ifdef DIFFUSE_TEXTURE2
        float2 texCoord0 = IN.TexCoord0And1.xy;
        float2 texCoord1 = IN.TexCoord0And1.zw;
    #else
        float2 texCoord0 = IN.TexCoord0.xy;
    #endif //DIFFUSE_TEXTURE2

    #ifdef DIRT_UV
        float2 dirtTexCoord = IN.DirtTexCoord;
    #else
        float2 dirtTexCoord = texCoord0;
    #endif //DIRT_UV

    float4 diffuse = tex2D(TextureSampler, texCoord0);
    diffuse.xyz *= matDiffuseColor;
    #ifdef DIFFUSE_TEXTURE2
        float4 diffuse2 = tex2D(TextureSampler2, texCoord1) * matDiffuseColor2;
        diffuse.xyz = lerp(diffuse.xyz, diffuse2.xyz, diffuse2.w);
    #endif //DIFFUSE_TEXTURE2

    #ifndef EMISSIVE
        diffuse.xyz *= IN.Color.xyz;
    #endif //EMISSIVE

    float alpha = diffuse.w * globalScalars.x * IN.Color.w;

    float3 normal;
    #if defined(NORMAL_MAP)
        float3x3 tbn = float3x3(IN.TangentWorld.xyz, IN.BitangentWorld.xyz, IN.NormalWorldAndDepth.xyz);
        float4 normalMap = tex2D(BumpSampler, texCoord0);
        normal = UnpackNormalMap(normalMap);
        #ifdef VEHICLE_SHUTS
            normal.xy *= 5.0;
        #elif defined(TIRE_DEFORMATION)
            normal.xy *= 3.0;
        #endif //VEHICLE_SHUTS

        normal = normalize(mul(normal, tbn) + 0.00001);
    #else
        normal = normalize(IN.NormalWorldAndDepth.xyz + 0.00001);
    #endif //NORMAL_MAP

    float4 specMap = tex2D(SpecSampler, texCoord0);
    float specIntensity = dot(specMap.xyz, specMapIntMask.xyz) * reflectivePowerED;
    float specPower = specMap.w * reflectivePowerED * matDiffuseColor2.w;

    #ifdef VEHICLE_PAINT
        specPower *= 190;
        specIntensity *= 0.15;
    #elif defined(SPECULAR)
        specPower *= specularFactor;
        specIntensity *= specularColorFactor;
    #endif //SPECULAR

    #ifdef TIRE_DEFORMATION
        specIntensity *= 1.34;
    #endif //TIRE_DEFORMATION

    #ifdef ENVIRONMENT_MAP
        specIntensity = min(specIntensity * 0.225, 1.0);
    #endif //ENVIRONMENT_MAP

    #ifdef VEHICLE_PAINT
        float specIntensity2 = specIntensity / (specularColorFactorED * 0.15);
        float specPower2 = specPower / (specularFactorED * 190);
        specIntensity2 *= SQUARE(specular2ColorIntensityED);
        specPower2 *= specular2FactorED * 6.8;
    #elif defined(SPECULAR2)
        float specIntensity2 = specIntensity / (specularColorFactorED * specularColorFactor);
        float specPower2 = specPower / (specularFactorED * specularFactor);
        specIntensity2 *= SQUARE(specular2ColorIntensityRE * specular2ColorIntensityED);
        specPower2 *= specular2FactorED * specular2Factor;
    #endif //VEHICLE_PAINT

    #ifdef DIRT
        ComputeDirt(diffuse, dirtTexCoord);
        specIntensity *= diffuse.w;
    #endif //DIRT
    
    specIntensity *= matDiffuseColor2.w;

    #ifdef SPECULAR2
        float3 fragToViewDir = normalize(IN.FragToViewDir + 0.000001);
        float3 R = reflect(-fragToViewDir, normal);

        float specularLight = dot(-gDirectionalLight.xyz, R);
        specularLight = specularLight >= 0.0 ? log(specularLight + 0.00001) : -13.2877121;
        specularLight = exp(specPower2 * specularLight);

        #ifdef VEHICLE_PAINT
            diffuse.xyz = specular2ColorIntensityED == 0 ? diffuse.xyz : diffuse.xyz + (specular2Color * specIntensity2 * specularLight);
        #else
            diffuse.xyz = SQUARE(specular2ColorIntensityRE) == 0 ? diffuse.xyz : diffuse.xyz + (specIntensity2 * specularLight);
        #endif //VEHICLE_PAINT
    #endif //SPECULAR2

    diffuse.w = alpha;
    OUT.Diffuse.xyz = diffuse.xyz;

    #ifdef VEHICLE_PAINT
        OUT.Normal = EncodeGBufferNormal(normal);
    #else
        OUT.Normal.xyz = (normal + 1.0) * 0.5;
        OUT.Normal.w = alpha;
    #endif //VEHICLE_PAINT

    #ifdef VEHICLE_INTERIOR
        OUT.SpecularAndAO.x = specIntensity * 0.0025;
        OUT.SpecularAndAO.y = sqrt(specPower / 51.2);
    #else
        #ifdef VEHICLE_SHUTS
            OUT.SpecularAndAO.x = specIntensity * 0.075;
        #else
            OUT.SpecularAndAO.x = specIntensity * 0.5;
        #endif //VEHICLE_SHUTS

        #ifdef POWER_FACTOR
            OUT.SpecularAndAO.y = sqrt(specPower * POWER_FACTOR);
        #else
            OUT.SpecularAndAO.y = sqrt(specPower / 512.0);
        #endif //POWER_FACTOR
    #endif //VEHICLE_INTERIOR

    #ifdef EMISSIVE
        OUT.SpecularAndAO.z = globalScalars.z;
    #else
        OUT.SpecularAndAO.z = dot(IN.Color.xyz, LuminanceConstants) * globalScalars.z;
    #endif //EMISSIVE

    OUT.Stencil = float4(stencil.x, 0, 0, 0);
    OUT.Diffuse.w = alpha;
    OUT.SpecularAndAO.w = alpha;

    return OUT;
}


float4 PS_VehicleTexturedUnlit(VS_OutputVehicle IN) : COLOR
{
    #ifdef DIFFUSE_TEXTURE2
        float2 texCoord0 = IN.TexCoord0And1.xy;
        float2 texCoord1 = IN.TexCoord0And1.zw;
    #else
        float2 texCoord0 = IN.TexCoord0.xy;
    #endif //DIFFUSE_TEXTURE2

    #ifdef DIRT_UV
        float2 dirtTexCoord = IN.DirtTexCoord;
    #else
        float2 dirtTexCoord = texCoord0;
    #endif //DIRT_UV

    float4 diffuse = tex2D(TextureSampler, texCoord0);
    diffuse.xyz *= matDiffuseColor;
    #ifdef DIFFUSE_TEXTURE2
        float4 diffuse2 = tex2D(TextureSampler2, texCoord1);
        diffuse.xyz = lerp(diffuse.xyz, diffuse2.xyz, diffuse2.w);
    #endif //DIFFUSE_TEXTURE2

    diffuse *= IN.Color;
    float alpha = diffuse.w * globalScalars.x;

    #ifdef DIRT
        ComputeDirt(diffuse, dirtTexCoord);
    #endif //DIRT

    diffuse.w = alpha;

    return diffuse;
}


float4 TexturedLit(in int numLights, in VS_OutputVehicle IN)
{
    #ifdef DIFFUSE_TEXTURE2
        float2 texCoord0 = IN.TexCoord0And1.xy;
        float2 texCoord1 = IN.TexCoord0And1.zw;
    #else
        float2 texCoord0 = IN.TexCoord0.xy;
    #endif //DIFFUSE_TEXTURE2

    #ifdef DIRT_UV
        float2 dirtTexCoord = IN.DirtTexCoord;
    #else
        float2 dirtTexCoord = texCoord0;
    #endif //DIRT_UV

    float4 diffuse = tex2D(TextureSampler, texCoord0);
    diffuse.xyz *= matDiffuseColor;
    #ifdef DIFFUSE_TEXTURE2
        float4 diffuse2 = tex2D(TextureSampler2, texCoord1) * matDiffuseColor2;
        diffuse.xyz = lerp(diffuse.xyz, diffuse2.xyz, diffuse2.w);
    #endif //DIFFUSE_TEXTURE2

    #ifdef EMISSIVE
        float3 emissiveColor = diffuse.xyz * IN.Color.xyz;
    #else
        diffuse.xyz *= IN.Color.xyz;
    #endif //EMISSIVE

    float alpha = diffuse.w * IN.Color.w;

    float4 specMap = tex2D(SpecSampler, texCoord0);
    float specIntensity = dot(specMap.xyz, specMapIntMask.xyz) * reflectivePowerED;
    float specPower = specMap.w * reflectivePowerED;

    #ifdef VEHICLE_INTERIOR
        specPower *= 10;
        specIntensity *= 0.005;
    #elif defined(VEHICLE_PAINT) || defined(VEHICLE_SHUTS)
        specPower *= 190;
        specIntensity *= 0.15;
    #elif defined(TIRE_DEFORMATION)
        specIntensity *= 1.4;
        specPower *= 50.0;
    #elif defined(ENVIRONMENT_MAP)
        specPower *= 190;
        specIntensity = min(specIntensity * 0.225, 1.0);
    #elif defined(POWER_FACTOR)
        specPower *= 50.0;
    #endif //VEHICLE_INTERIOR

    #ifdef SPECULAR
        specPower *= specularFactor;
        specIntensity *= specularColorFactor;
    #endif //SPECULAR

    float3 normal;
    #if defined(NORMAL_MAP)
        float3x3 tbn = float3x3(IN.TangentWorld.xyz, IN.BitangentWorld.xyz, IN.NormalWorldAndDepth.xyz);
        float4 normalMap = tex2D(BumpSampler, texCoord0);
        normal = UnpackNormalMap(normalMap);
        #ifdef VEHICLE_SHUTS
            normal.xy *= 5.0;
        #elif defined(TIRE_DEFORMATION)
            normal.xy *= 3.0;
        #endif //VEHICLE_SHUTS

        normal = normalize(mul(normal, tbn) + 0.00001);
    #else
        normal = normalize(IN.NormalWorldAndDepth.xyz + 0.00001);
    #endif //NORMAL_MAP
    
    float3 fragToViewDir = normalize(IN.FragToViewDir.xyz + 0.00001);

    #ifdef DIRT
        ComputeDirt(diffuse, dirtTexCoord);
        specIntensity *= diffuse.w;
    #endif //DIRT

    float ambientOcclusion = globalScalars.z;
    #ifndef EMISSIVE
        ambientOcclusion *= dot(IN.Color.xyz, LuminanceConstants);
    #endif //!EMISSIVE

    float glassSpecFactor = 1;
    #ifdef IS_VEHICLE_GLASS
        alpha = saturate(alpha);
        glassSpecFactor = alpha - 0.001 >= 0 ? 1.0 / alpha : 100.0;
    #endif //IS_VEHICLE_GLASS
    alpha *= globalScalars.x;

    SurfaceProperties surfaceProperties;
    surfaceProperties.Diffuse = diffuse.xyz;
    surfaceProperties.Normal = normal;
    surfaceProperties.SpecularIntensity = specIntensity;
    surfaceProperties.SpecularPower = specPower;
    surfaceProperties.AmbientOcclusion = ambientOcclusion;
    float4 lighting = float4(ComputeLighting(numLights, true, IN.PositionWorld.xyz, -fragToViewDir, glassSpecFactor, surfaceProperties), alpha);
    #ifdef EMISSIVE
        lighting.xyz += emissiveColor * emissiveMultiplier;
    #elif defined(DISK_BRAKE_GLOW)
        lighting.xyz += DiskBrakeGlow * float3(98, 25, 0);
    #endif //EMISSIVE
    lighting.xyz = ComputeDepthEffects(1.0, lighting.xyz, IN.NormalWorldAndDepth.w);

    return lighting;
}

float4 PS_VehicleTexturedZero(VS_OutputVehicle IN) : COLOR
{
    return TexturedLit(0, IN);
}

float4 PS_VehicleTexturedFour(VS_OutputVehicle IN) : COLOR
{
    return TexturedLit(4, IN);
}

float4 PS_VehicleTexturedEight(VS_OutputVehicle IN) : COLOR
{
    return TexturedLit(8, IN);
}


//i dont car
#ifdef VEHICLE_DAMAGE
    PixelShader PS_VehicleR2VB
    <
        string BoundRadius      = "parameter register(66)";
        string DamageSampler    = "parameter register(0)";
        string DamageVertBuffer = "parameter register(1)";
        string switchOn         = "parameter register(8)";
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
        //   sampler2D DamageVertBuffer;
        //   bool switchOn;
        //
        //
        // Registers:
        //
        //   Name             Reg   Size
        //   ---------------- ----- ----
        //   switchOn         b8       1
        //   BoundRadius      c66      1
        //   DamageSampler    s0       1
        //   DamageVertBuffer s1       1
        //
        
            ps_3_0
            def c0, 1, 0.5, 9.99999975e-006, 0
            def c1, 126.732674, 0.00789062493, 0, 1.52587891e-005
            def c2, 65536, 0.00390625, 256, -128
            def c3, 0.0078125, -0.0078125, 0, 9.99999994e-009
            def c4, -0.5, -0.492109388, 2, 1
            dcl_texcoord v0.xy
            dcl_2d s0
            dcl_2d s1
            texld r0, v0, s1
            if b8
            dp3 r1.x, r0, r0
            rsq r1.x, r1.x
            rcp r1.y, r1.x
            mad r1.z, r0.z, -r1.x, c0.x
            mul r1.z, r1.z, c0.y
            mad r1.xw, r0.xyzy, r1.x, c0.z
            dp2add r2.x, r1.xwzw, r1.xwzw, c0.w
            rsq r2.x, r2.x
            mul r1.xw, r1, r2.x
            mul r1.xz, r1.z, r1.xyww
            mad r2.xy, r1.xzzw, c0.y, c0.y
            mul r1.xz, r2.xyyw, c1.x
            frc r1.xz, r1_abs
            cmp r1.xz, r2.xyyw, r1, -r1
            mov r2.zw, c0.w
            texldl r3, r2, s0
            mad r2.xy, r1.xzzw, -c1.y, r2
            add r4.xy, r2, c1.yzzw
            mov r4.zw, c0.w
            texldl r4, r4, s0
            add r5.xy, r2, c1.zyzw
            mov r5.zw, c0.w
            texldl r5, r5, s0
            add r2.xy, r2, c1.y
            mov r2.zw, c0.w
            texldl r2, r2, s0
            mul r1.w, r3.x, c1.w
            frc r2.y, r1.w
            add r1.w, r1.w, -r2.y
            cmp r2.y, -r2.y, c0.w, c0.x
            cmp r2.y, r3.x, c0.w, r2.y
            add r6.z, r1.w, r2.y
            mad r1.w, r6.z, -c2.x, r3.x
            mul r2.y, r1.w, c2.y
            frc r2.z, r2.y
            add r2.y, r2.y, -r2.z
            cmp r2.z, -r2.z, c0.w, c0.x
            cmp r2.z, r1.w, c0.w, r2.z
            add r6.y, r2.y, r2.z
            mad r6.x, r6.y, -c2.z, r1.w
            mul r1.w, r4.x, c1.w
            frc r2.y, r1.w
            add r1.w, r1.w, -r2.y
            cmp r2.y, -r2.y, c0.w, c0.x
            cmp r2.y, r4.x, c0.w, r2.y
            add r3.z, r1.w, r2.y
            mad r1.w, r3.z, -c2.x, r4.x
            mul r2.y, r1.w, c2.y
            frc r2.z, r2.y
            add r2.y, r2.y, -r2.z
            cmp r2.z, -r2.z, c0.w, c0.x
            cmp r2.z, r1.w, c0.w, r2.z
            add r3.y, r2.y, r2.z
            mad r3.x, r3.y, -c2.z, r1.w
            mul r1.w, r5.x, c1.w
            frc r2.y, r1.w
            add r1.w, r1.w, -r2.y
            cmp r2.y, -r2.y, c0.w, c0.x
            cmp r2.y, r5.x, c0.w, r2.y
            add r4.z, r1.w, r2.y
            mad r1.w, r4.z, -c2.x, r5.x
            mul r2.y, r1.w, c2.y
            frc r2.z, r2.y
            add r2.y, r2.y, -r2.z
            cmp r2.z, -r2.z, c0.w, c0.x
            cmp r2.z, r1.w, c0.w, r2.z
            add r4.y, r2.y, r2.z
            mad r4.x, r4.y, -c2.z, r1.w
            mul r1.w, r2.x, c1.w
            frc r2.y, r1.w
            add r1.w, r1.w, -r2.y
            cmp r2.y, -r2.y, c0.w, c0.x
            cmp r2.y, r2.x, c0.w, r2.y
            add r5.z, r1.w, r2.y
            mad r1.w, r5.z, -c2.x, r2.x
            mul r2.x, r1.w, c2.y
            frc r2.y, r2.x
            add r2.x, r2.x, -r2.y
            cmp r2.y, -r2.y, c0.w, c0.x
            cmp r2.y, r1.w, c0.w, r2.y
            add r5.y, r2.x, r2.y
            mad r5.x, r5.y, -c2.z, r1.w
            add r2.xy, -r1.xzzw, c0.x
            mul r6.xyz, r6, r2.x
            mul r3.xyz, r1.x, r3
            mul r3.xyz, r2.y, r3
            mad r2.yzw, r6.xxyz, r2.y, r3.xxyz
            mul r3.xyz, r4, r2.x
            mad r2.xyz, r3, r1.z, r2.yzww
            mul r3.xyz, r1.x, r5
            mad r1.xzw, r3.xyyz, r1.z, r2.xyyz
            add r1.xzw, r1, c2.w
            mul r1.xzw, r1, c3.x
            rcp r2.x, c66.x
            mul r1.y, r1.y, r2.x
            min r2.x, r1.y, c0.x
            mul r1.xyz, r1.xzww, r2.x
            mad r0.xyz, r1, c0.y, r0
            endif
            add r1.xy, c3.yzzw, v0
            texld r1, r1, s1
            if b8
            add r2.xyz, r1, -c0.x
            cmp r1.w, -r2_abs.z, c0.x, c0.w
            cmp r1.w, -r2_abs.y, r1.w, c0.w
            cmp r1.w, -r2_abs.x, r1.w, c0.w
            if_ne r1.w, -r1.w
                mul r1.xyz, r1.z, c0.wwxw
            else
                dp3 r1.w, r1, r1
                rsq r1.w, r1.w
                rcp r2.x, r1.w
                mad r2.y, r1.z, -r1.w, c0.x
                mul r2.y, r2.y, c0.y
                mad r2.zw, r1.xyxy, r1.w, c0.z
                dp2add r1.w, r2.zwzw, r2.zwzw, c0.w
                rsq r1.w, r1.w
                mul r2.zw, r2, r1.w
                mul r2.yz, r2.y, r2.xzww
                mad r3.xy, r2.yzzw, c0.y, c0.y
                mul r2.yz, r3.xxyw, c1.x
                frc r2.yz, r2_abs
                cmp r2.yz, r3.xxyw, r2, -r2
                mov r3.zw, c0.w
                texldl r4, r3, s0
                mad r2.yz, r2, -c1.y, r3.xxyw
                add r3.xy, r2.yzzw, c1.yzzw
                mov r3.zw, c0.w
                texldl r3, r3, s0
                add r5.xy, r2.yzzw, c1.zyzw
                mov r5.zw, c0.w
                texldl r5, r5, s0
                mul r1.w, r4.x, c1.w
                frc r2.w, r1.w
                add r1.w, r1.w, -r2.w
                cmp r2.w, -r2.w, c0.w, c0.x
                cmp r2.w, r4.x, c0.w, r2.w
                add r1.w, r1.w, r2.w
                mad r2.w, r1.w, -c2.x, r4.x
                mul r3.y, r2.w, c2.y
                frc r3.z, r3.y
                add r3.y, r3.y, -r3.z
                cmp r3.z, -r3.z, c0.w, c0.x
                cmp r3.z, r2.w, c0.w, r3.z
                add r3.y, r3.y, r3.z
                mad r2.w, r3.y, -c2.z, r2.w
                mul r3.z, r3.x, c1.w
                frc r3.w, r3.z
                add r3.z, r3.z, -r3.w
                cmp r3.w, -r3.w, c0.w, c0.x
                cmp r3.w, r3.x, c0.w, r3.w
                add r3.z, r3.z, r3.w
                mad r3.x, r3.z, -c2.x, r3.x
                mul r3.w, r3.x, c2.y
                frc r4.x, r3.w
                add r3.w, r3.w, -r4.x
                cmp r4.x, -r4.x, c0.w, c0.x
                cmp r4.x, r3.x, c0.w, r4.x
                add r3.w, r3.w, r4.x
                mad r3.x, r3.w, -c2.z, r3.x
                mul r4.x, r5.x, c1.w
                frc r4.y, r4.x
                add r4.x, r4.x, -r4.y
                cmp r4.y, -r4.y, c0.w, c0.x
                cmp r4.y, r5.x, c0.w, r4.y
                add r4.x, r4.x, r4.y
                mad r4.y, r4.x, -c2.x, r5.x
                mul r4.z, r4.y, c2.y
                frc r4.w, r4.z
                add r4.z, r4.z, -r4.w
                cmp r4.w, -r4.w, c0.w, c0.x
                cmp r4.w, r4.y, c0.w, r4.w
                add r4.z, r4.z, r4.w
                mad r4.y, r4.z, -c2.z, r4.y
                add r5, r2.yzyz, c4.xxyx
                add r5, r5, r5
                dp2add r4.w, r5, r5, c0.w
                rsq r6.x, r4.w
                rcp r6.x, r6.x
                cmp r4.w, -r4.w, c0.w, r6.x
                mad r6.x, r4.w, -c4.z, c4.w
                max r7.z, -c0.x, r6.x
                add r6.x, r7.z, -c0.x
                add r6.y, -r7.z, -c0.x
                mad r6.z, r7.z, -r7.z, c0.x
                rsq r6.z, r6.z
                rcp r6.z, r6.z
                rcp r6.w, r4.w
                mul r6.z, r6.z, r6.w
                cmp r4.w, -r4.w, -c0.w, -c0.x
                cmp r4.w, r6.y, -c0.w, r4.w
                cmp r4.w, r6.x, -c0.w, r4.w
                cmp r4.w, r4.w, c0.w, r6.z
                mul r7.xy, r5, r4.w
                add r2.w, r2.w, c2.w
                mul r6.x, r2.w, c3.x
                add r2.w, r3.y, c2.w
                mul r6.y, r2.w, c3.x
                add r1.w, r1.w, c2.w
                mul r6.z, r1.w, c3.x
                rcp r1.w, c66.x
                mul r1.w, r2.x, r1.w
                min r2.x, r1.w, c0.x
                mul r6.xyz, r6, r2.x
                mul r6.xyz, r6, c0.y
                dp2add r1.w, r5.zwzw, r5.zwzw, c0.w
                rsq r2.w, r1.w
                rcp r2.w, r2.w
                cmp r1.w, -r1.w, c0.w, r2.w
                mad r2.w, r1.w, -c4.z, c4.w
                max r8.z, -c0.x, r2.w
                add r2.w, r8.z, -c0.x
                add r3.y, -r8.z, -c0.x
                mad r4.w, r8.z, -r8.z, c0.x
                rsq r4.w, r4.w
                rcp r4.w, r4.w
                rcp r5.x, r1.w
                mul r4.w, r4.w, r5.x
                cmp r1.w, -r1.w, -c0.w, -c0.x
                cmp r1.w, r3.y, -c0.w, r1.w
                cmp r1.w, r2.w, -c0.w, r1.w
                cmp r1.w, r1.w, c0.w, r4.w
                mul r8.xy, r5.zwzw, r1.w
                add r5.xyz, r8, c3.w
                add r1.w, r3.x, c2.w
                mul r8.x, r2.x, r1.w
                add r1.w, r3.w, c2.w
                mul r8.y, r2.x, r1.w
                add r1.w, r3.z, c2.w
                mul r8.z, r2.x, r1.w
                add r3.xyz, -r7, r5
                mad r5.xyz, r8, c2.y, -r6
                dp3 r1.w, r5, r1
                dp3 r2.w, r3, r3
                rcp r3.w, r2.w
                mul r1.w, -r1.w, r3.w
                mad r3.xyz, r3, r1.w, r1
                cmp r3.xyz, -r2.w, r1, r3
                add r2.yz, r2, c4.xxyw
                add r2.yz, r2, r2
                dp2add r1.w, r2.yzzw, r2.yzzw, c0.w
                rsq r2.w, r1.w
                rcp r2.w, r2.w
                cmp r1.w, -r1.w, c0.w, r2.w
                mad r2.w, r1.w, -c4.z, c4.w
                max r5.z, -c0.x, r2.w
                add r2.w, r5.z, -c0.x
                add r3.w, -r5.z, -c0.x
                mad r4.w, r5.z, -r5.z, c0.x
                rsq r4.w, r4.w
                rcp r4.w, r4.w
                rcp r5.w, r1.w
                mul r4.w, r4.w, r5.w
                cmp r1.w, -r1.w, -c0.w, -c0.x
                cmp r1.w, r3.w, -c0.w, r1.w
                cmp r1.w, r2.w, -c0.w, r1.w
                cmp r1.w, r1.w, c0.w, r4.w
                mul r5.xy, r2.yzzw, r1.w
                add r1.w, r4.y, c2.w
                mul r8.x, r2.x, r1.w
                add r1.w, r4.z, c2.w
                mul r8.y, r2.x, r1.w
                add r1.w, r4.x, c2.w
                mul r8.z, r2.x, r1.w
                add r2.xyz, -r7, r5
                mad r4.xyz, r8, c2.y, -r6
                dp3 r1.w, r4, r1
                dp3 r2.w, r2, r2
                rcp r3.w, r2.w
                mul r1.w, -r1.w, r3.w
                mad r2.xyz, r2, r1.w, r3
                cmp r2.xyz, -r2.w, r3, r2
                nrm r1.xyz, r2
            endif
            endif
            cmp oC0.xyz, -r0_abs.w, r0, r1
            mov oC0.w, r0.w
        
        // approximately 299 instruction slots used (16 texture, 283 arithmetic)
    };
#else
    PixelShader PS_VehicleR2VB
    <
        string DamageVertBuffer = "parameter register(0)";
    > =
    asm
    {
        //
        // Generated by Microsoft (R) HLSL Shader Compiler 9.26.952.2844
        //
        // Parameters:
        //
        //   sampler2D DamageVertBuffer;
        //
        //
        // Registers:
        //
        //   Name             Reg   Size
        //   ---------------- ----- ----
        //   DamageVertBuffer s0       1
        //
        
            ps_3_0
            dcl_texcoord v0.xy
            dcl_2d s0
            texld oC0, v0, s0
        
        // approximately 1 instruction slot used (1 texture, 0 arithmetic)
    };
#endif //VEHICLE_DAMAGE



#ifndef NO_GENERATED_TECHNIQUES
    technique blitr2vb
    {
        pass p0
        {
            VertexShader = compile vs_3_0 VS_Blit();
            PixelShader = PS_VehicleR2VB;
        }
    }
    
    technique draw
    {
        pass p0
        {
            AlphaBlendEnable = true;
            AlphaTestEnable = true;
    
            VertexShader = compile vs_3_0 VS_VehicleTransform();
            PixelShader = compile ps_3_0 PS_VehicleTexturedEight();
        }
    }
    
    technique drawskinned
    {
        pass p0
        {
            AlphaRef = 0x64;
            AlphaBlendEnable = true;
            AlphaTestEnable = true;
    
            VertexShader = compile vs_3_0 VS_VehicleTransformSkin();
            PixelShader = compile ps_3_0 PS_VehicleTexturedEight();
        }
    }
    
    technique lightweight0_draw
    {
        pass p0
        {
            AlphaBlendEnable = true;
            AlphaTestEnable = true;
    
            VertexShader = compile vs_3_0 VS_VehicleTransform();
            PixelShader = compile ps_3_0 PS_VehicleTexturedZero();
        }
    }
    
    technique lightweight0_drawskinned
    {
        pass p0
        {
            AlphaRef = 0x64;
            AlphaBlendEnable = true;
            AlphaTestEnable = true;
    
            VertexShader = compile vs_3_0 VS_VehicleTransformSkin();
            PixelShader = compile ps_3_0 PS_VehicleTexturedZero();
        }
    }
    
    technique lightweight4_draw
    {
        pass p0
        {
            AlphaBlendEnable = true;
            AlphaTestEnable = true;
    
            VertexShader = compile vs_3_0 VS_VehicleTransform();
            PixelShader = compile ps_3_0 PS_VehicleTexturedFour();
        }
    }
    
    technique lightweight4_drawskinned
    {
        pass p0
        {
            AlphaRef = 0x64;
            AlphaBlendEnable = true;
            AlphaTestEnable = true;
    
            VertexShader = compile vs_3_0 VS_VehicleTransformSkin();
            PixelShader = compile ps_3_0 PS_VehicleTexturedFour();
        }
    }
    
    technique deferred_draw
    {
        pass p0
        {
            VertexShader = compile vs_3_0 VS_VehicleTransformD();
            PixelShader = compile ps_3_0 PS_DeferredVehicleTextured();
        }
    }
    
    technique deferred_drawskinned
    {
        pass p0
        {
            AlphaRef = 0x64;
            AlphaBlendEnable = false;
            AlphaTestEnable = false;
    
            VertexShader = compile vs_3_0 VS_VehicleTransformSkinD();
            PixelShader = compile ps_3_0 PS_DeferredVehicleTextured();
        }
    }
    
    #ifndef NO_SHADOW_CASTING_VEHICLE
        technique wd_draw
        {
            pass p0
            {
                #if defined(VEHICLE_DAMAGE) || defined(TIRE_DEFORMATION)
                    VertexShader = compile vs_3_0  VS_VehicleShadowDepth();
                #else
                    VertexShader = compile vs_3_0 VS_ShadowDepth();
                #endif //VEHICLE_DAMAGE || TIRE_DEFORMATION
                PixelShader = compile ps_3_0 PS_ShadowDepth();
            }
        }
        
        technique wd_drawskinned
        {
            pass p0
            {
                VertexShader = compile vs_3_0 VS_VehicleShadowDepthSkin();
                PixelShader = compile ps_3_0 PS_ShadowDepth();
            }
        }
        
        technique wd_masked_draw
        {
            pass p0
            {
                #if defined(VEHICLE_DAMAGE) || defined(TIRE_DEFORMATION)
                    VertexShader = compile vs_3_0  VS_VehicleShadowDepth();
                #else
                    VertexShader = compile vs_3_0 VS_ShadowDepth();
                #endif //VEHICLE_DAMAGE || TIRE_DEFORMATION
                PixelShader = compile ps_3_0 PS_ShadowDepthMasked();
            }
        }
        
        technique wd_masked_drawskinned
        {
            pass p0
            {
                VertexShader = compile vs_3_0 VS_VehicleShadowDepthSkin();
                PixelShader = compile ps_3_0 PS_ShadowDepthMasked();
            }
        }
    #endif //NO_SHADOW_CASTING_VEHICLE

    technique unlit_draw
    {
        pass p0
        {
            #ifdef DISK_BRAKE_GLOW
                VertexShader = compile vs_3_0 VS_VehicleTransformUnlitDisc();
            #else
                VertexShader = compile vs_3_0 VS_VehicleTransformUnlit();
            #endif //DISK_BRAKE_GLOW
            PixelShader = compile ps_3_0 PS_VehicleTexturedUnlit();
        }
    }
    
    technique unlit_drawskinned
    {
        pass p0
        {
            #ifdef DISK_BRAKE_GLOW
                VertexShader = compile vs_3_0 VS_VehicleTransformUnlitDisc();
            #else
                VertexShader = compile vs_3_0 VS_VehicleTransformUnlit();
            #endif //DISK_BRAKE_GLOW
            PixelShader = compile ps_3_0 PS_VehicleTexturedUnlit();
        }
    }
    
    technique reflection_draw
    {
        pass p0
        {
            VertexShader = compile vs_3_0 VS_VehicleTransform();
            PixelShader = compile ps_3_0 PS_VehicleTexturedZero();
        }
    }
    
    technique reflection_drawskinned
    {
        pass p0
        {
            VertexShader = compile vs_3_0 VS_VehicleTransformSkin();
            PixelShader = compile ps_3_0 PS_VehicleTexturedZero();
        }
    }
#endif //NO_GENERATED_TECHNIQUES