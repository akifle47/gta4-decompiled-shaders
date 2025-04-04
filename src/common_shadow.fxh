#if !defined(NO_SHADOW_CASTING) && !defined(NO_SHADOW_CASTING_VEHICLE)
    struct VS_ShadowDepthInput
    {
        float3 Position : POSITION;
    #ifdef ALPHA_SHADOW
        float2 TexCoord : TEXCOORD0;
    #endif //ALPHA_SHADOW
    };

    #ifndef NO_SKINNING
        struct VS_ShadowDepthSkinInput
        {
            float3 Position : POSITION;
            float4 BlendWeights : BLENDWEIGHT;
            float4 BlendIndices : BLENDINDICES;
        #ifdef ALPHA_SHADOW
            float2 TexCoord : TEXCOORD0;
        #endif //ALPHA_SHADOW
        };
    #endif //NO_SKINNING

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

    #ifndef NO_SKINNING
        VS_ShadowDepthOutput VS_ShadowDepthSkin(VS_ShadowDepthSkinInput IN)
        {
            VS_ShadowDepthOutput OUT;
            float4x3 skinMtx = ComputeSkinMatrix(IN.BlendIndices, IN.BlendWeights);
            float3 posWorld = mul(float4(IN.Position, 1.0), skinMtx).xyz + gWorld[3].xyz;
            float4 posClip = mul(float4(posWorld, 1), gShadowMatrix);

            OUT.Position.z = 1.0 - min(posClip.z, 1.0);
            float4 v0;

            //only this branch seems to ever be used for directional shadows
            if(gShadowParam14151617.x == 0)
            {
                float v1 = posClip.z + gShadowParam891113.z;
                float z0 = v1 * ((gShadowParam14151617.y == 0.0) - 0.5);
                float z1 = z0 * 2.0;
                float len = length(float3(posClip.xy, z1));
                v0.xy = posClip.xy / ((z0 * -2.0) + len);
                v0.w = z1 * -gShadowParam0123.w;
                v0.z = len * -gShadowParam0123.w;
            }
            else if(gShadowParam14151617.x == 1)
            {
                v0.xyz = float3(posClip.xy, 0.5) * float3(gShadowParam0123.zw, posClip.z * gShadowParam0123.z);
                float2 v1 = v0.xy * facetMask[gShadowParam14151617.y].xy;
                v0.z = max(v0.z, 0.0);
                v0.w = v1.x + v1.y + 2.0;
            }
            else
            {
                v0.xy = posClip.xy * gShadowParam0123.z;
                float v1 = gShadowParam0123.x - gShadowParam891113.w;
                float v2 = gShadowParam891113.w / v1;
                float v3 = (gShadowParam0123.x * gShadowParam891113.w) / v1;
                v0.z = posClip.z * v2 + v1;
                v0.w = -posClip.z;
            }

            OUT.Position.x = dot(v0, float4(1, 1, 1, 1)) * 0.00001 + posClip.x;
            OUT.Position.yw = posClip.yw * float2(1, 0) + float2(0, 0);

            #ifdef ALPHA_SHADOW
                OUT.DepthColorAndTexCoord.x = posClip.w;
                OUT.DepthColorAndTexCoord.yz = IN.TexCoord;
            #else
                OUT.DepthColor = posClip.w;
            #endif //ALPHA_SHADOW
            return OUT;
        }
    #endif //NO_SKINNING

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