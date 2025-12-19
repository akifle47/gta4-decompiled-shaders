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