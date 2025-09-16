#include "megashader_todo.fxh"
#include "common_functions.fxh"
#include "common_shadow.fxh"

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

struct VS_InputVehicleUnlit
{
    float3 Position     : POSITION;
    float4 Color        : COLOR;
    float2 TexCoord0    : TEXCOORD0;
#ifdef DIRT_UV
    float2 DirtTexCoord : TEXCOORD1;
#elif defined(DIFFUSE_TEXTURE2)
    float2 TexCoord1    : TEXCOORD1;
#endif //DIRT_UV
};

struct VS_InputSkinVehicleUnlit
{
    float3 Position     : POSITION;
    float4 BlendIndices : BLENDINDICES;
    float4 Color        : COLOR;
    float2 TexCoord0    : TEXCOORD0;
#ifdef DIRT_UV
    float2 DirtTexCoord : TEXCOORD1;
#elif defined(DIFFUSE_TEXTURE2)
    float2 TexCoord1    : TEXCOORD1;
#endif //DIRT_UV
};

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

VS_OutputVehicleUnlit VS_VehicleTransformUnlit(VS_InputVehicleUnlit IN)
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

VS_OutputVehicleUnlit VS_VehicleTransformSkinUnlit(VS_InputSkinVehicleUnlit IN)
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
            float2 v0 = position.yz * position.yz;

            float3 v2 = position * tyreDeformParams2.w;
            float v3 = (v0.x + v0.y) * tyreDeformParams2.w;
            v3 = v3 > pow(tyreDeformParams2.x * 1.1, 2);
            float v5 = tyreDeformParams2.y + 0.03;
            float v6 = posWorld.z < v5;
            float v7 = tyreDeformParams2.y - posWorld.z;
            float v9 = v7 - (v7 * (v7 < 0));
            v5 -= posWorld.z;
            float v10 = v5 * tyreDeformParams2.z;
            v5 = 1.0 - (v5 * tyreDeformParams2.z);
            v5 = (v10 > 1) * v5 + v10;
            
            float t = (tyreDeformParams2.x * tyreDeformParams2.x) < (v0.x + v0.y);
            float3 targetPos;
            targetPos.x = v2.x - (tyreDeformParams.w * v5);
            targetPos.x += (tyreDeformParams.x * position.x * v5);
            targetPos.yz = tyreDeformParams.yz * v9 + v2.yz;

            targetPos -= (position * tyreDeformParams2.w);
            targetPos *= v6;
            targetPos = v2 + (targetPos * v3);
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