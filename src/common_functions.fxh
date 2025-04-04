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