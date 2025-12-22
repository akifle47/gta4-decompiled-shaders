#define SQUARE(x) x * x

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
    OUT.Position = float4(IN.Position.xyz, 1);
    OUT.TexCoord = float4(IN.TexCoord.xy, 0, 0);
    return OUT;
}

struct VS_BlitPositionOnlyInput
{
    float3 Position : POSITION;
};

float4 VS_BlitPositionOnly(VS_BlitPositionOnlyInput IN) : POSITION
{
    return float4(IN.Position.xyz, 1);
}

#ifndef NO_LIGHTING
    float2 ComputeDayNightEffects(in float2 vertexColor)
    {
        float2 color = gDayNightEffects.xy * vertexColor;
        color.x = color.y + color.x;
        color.x = color.x * globalScalars.z  - 1;
        color.x = color.x * globalScalars2.z + 1;
        return color.xx;
    }
#endif //NO_LIGHTING

#ifdef ANIMATED
    float2 ComputeUvAnimation(in float2 texCoord)
    {
        float3 uv = float3(texCoord, 1.0);
        return float2(dot(globalAnimUV0, uv), dot(globalAnimUV1, uv));
    }
#endif //ANIMATED

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
#endif //DEPTH_SHIFT

#ifdef PARALLAX
    void ComputeParallax(in float3 fragToViewDirTangent, in float2 texCoordIn, out float2 texCoordOut, out float4 normalMapOut)
    {
        fragToViewDirTangent.xy = normalize(fragToViewDirTangent + 0.00001).xy;

        #if defined(PARALLAX_STEEP)
            const int numSamples = 8;
            const float stepSize = 1.0 / numSamples;
            
            fragToViewDirTangent.xy = -fragToViewDirTangent.xy * parallaxScaleBias;
            texCoordOut = texCoordIn;
            normalMapOut = tex2D(BumpSampler, texCoordOut);
            float height = -normalMapOut.w;
            float layerHeight = -1.0;

            for(int i = 0; i < numSamples; i++)
            {
                float2 sampleTexCoord = texCoordOut + (fragToViewDirTangent.xy * stepSize);
                float4 sampleNormalMap = tex2D(BumpSampler, sampleTexCoord);

                if(layerHeight <= height)
                {
                    texCoordOut = sampleTexCoord;
                    normalMapOut = sampleNormalMap;
                    height = -normalMapOut.w;
                    layerHeight += stepSize;
                }
            }
        #else
            float height = (tex2D(BumpSampler, texCoordIn).w * parallaxScaleBias) - (parallaxScaleBias / 2.0);
            #ifndef DEPTH_SHIFT_SCALE
                height = saturate(height);
            #endif //DEPTH_SHIFT_SCALE
            texCoordOut = saturate(fragToViewDirTangent.xy * height + texCoordIn);
            normalMapOut = tex2D(BumpSampler, texCoordOut);
        #endif //PARALLAX_STEEP
    }
#endif //PARALLAX

#ifndef NO_LIGHTING
    void AlphaClip(in float alpha, in float2 screenCoords)
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
#endif //NO_LIGHTING

#ifndef NO_SKINNING
    float4x3 ComputeSkinMatrix(in float4 indices, in float4 weights)
    {
        int4 i = D3DCOLORtoUBYTE4(indices).bgra;
        
        float4x3 skinMtx;
        skinMtx  = gBoneMtx[i.x] * weights.x;
        skinMtx += gBoneMtx[i.y] * weights.y;
        skinMtx += gBoneMtx[i.z] * weights.z;
        skinMtx += gBoneMtx[i.w] * weights.w;
        
        return skinMtx;
    }
#endif //NO_SKINNING

float4 EncodeGBufferNormal(in float3 normal)
{
    normal = normal + 1.0;
    float3 intPart = floor(normal * 64.0);
    float3 fracPart = normal * 64.0 - intPart;

    float3 v0 = floor(fracPart * float3(8.0, 8.0, 4.0));
    float v1 = dot(v0, float3(32.0, 4.0, 1.0));

    return float4(intPart / 128, v1 / 255);
}

#if defined(NORMAL_MAP) || defined(PARALLAX)
    float3 UnpackNormalMap(in float4 normalMap)
    {
        float3 normal;
        #ifdef PARALLAX
            normal.xy = normalMap.xy;
        #else
            //use wy as the xy axis if the alpha channel is not white and the red channel is black. gives better precision if using dxt5 compression
            normal.xy = (1.0 - normalMap.w) - normalMap.x >= 0.0 ? normalMap.wy : normalMap.xy;
        #endif //PARALLAX

        normal.z = sqrt(dot(normal.xy, -normal.xy) + 1.0);
        normal.xy -= 0.5;
        #ifndef NO_BUMPINESS
            normal.xy *= bumpiness;
        #endif //NO_BUMPINESS
        return normal;
    }
#endif //NORMAL_MAP || PARALLAX

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