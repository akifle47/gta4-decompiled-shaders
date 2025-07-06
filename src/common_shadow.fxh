#if !defined(NO_SHADOW_CASTING) && !defined(NO_SHADOW_CASTING_VEHICLE)
    float ComputeDirectionalShadow(in float3 posWorld)
    {
        const int numShadowSamples = 12;
        const float2 jitter[numShadowSamples] =
        {
            float2(-0.326212, -0.405810), 
            float2(-0.840144, -0.073580), 
            float2(-0.695914, 0.457137), 
            float2(-0.203345, 0.620716), 
            float2(0.962340, -0.194983), 
            float2(0.473434, -0.480026), 
            float2(0.519456, 0.767022), 
            float2(0.185461, -0.893124), 
            float2(0.507431, 0.064425), 
            float2(0.896420, 0.412458), 
            float2(-0.321940, -0.932615), 
            float2(-0.791559, -0.597710)
        };

        float3 posShadow = posWorld.xxx * gShadowMatrix[0].xyw;
        posShadow += posWorld.yyy * gShadowMatrix[1].xyw;
        posShadow += posWorld.zzz * gShadowMatrix[2].xyw;
        posShadow += gShadowMatrix[3].xyw;
        
        float4 cascadeMask;
        cascadeMask.x = 1.0;
        cascadeMask.yzw = -(dot(gViewInverse[2].xyz, posWorld.xyz).xxx + gFacetCentre.xyz);
        cascadeMask.yzw = cascadeMask.yzw >= 0 ? 1 : 0;

        posShadow.xy *= float2(dot(cascadeMask, gShadowParam0123), dot(cascadeMask, gShadowParam4567));
        posShadow.xy += float2(dot(cascadeMask, gShadowParam891113), dot(cascadeMask, gShadowParam14151617));

        float dist = distance(posWorld, gViewInverse[3].xyz);

        float atlasPixelOffset = gShadowParam18192021.y;
        float shadow = 0.0;
        for(int i = 0; i < numShadowSamples; i++)
        {
            float2 sampleCoords = posShadow.xy + jitter[i] * atlasPixelOffset;
            shadow += posShadow.z >= tex2D(gShadowZSamplerDir, sampleCoords).x ? 1.0 : 0.0;
        }

        float shadowFade = dist / gShadowParam18192021.w;
        shadowFade = shadowFade * shadowFade * 1.5;
        shadow = (shadow / numShadowSamples) + shadowFade;

        float2 pastShadowDistance = dist >= gShadowParam18192021.w ? float2(1, -1) : float2(0, -0);
        shadow = saturate(pastShadowDistance.y + shadow >= 0.0 ? shadow : pastShadowDistance.x);

        return shadow;
    }
    
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

    #ifndef DEFERRED_LIGHTING
        float4 ComputeCascadeMask(in float4 posClip)
        {
            float4 cascadeMask;
            //only this branch seems to ever be used for directional shadows
            if(gShadowParam14151617.x == 0)
            {
                float v1 = posClip.z + gShadowParam891113.z;
                float z0 = v1 * ((gShadowParam14151617.y == 0.0) - 0.5);
                float z1 = z0 * 2.0;
                float len = length(float3(posClip.xy, z1));
                cascadeMask.xy = posClip.xy / ((z0 * -2.0) + len);
                cascadeMask.w = z1 * -gShadowParam0123.w;
                cascadeMask.z = len * -gShadowParam0123.w;
            }
            else if(gShadowParam14151617.x == 1)
            {
                cascadeMask.xyz = float3(posClip.xy, 0.5) * float3(gShadowParam0123.zw, posClip.z * gShadowParam0123.z);
                float2 v1 = cascadeMask.xy * facetMask[gShadowParam14151617.y].xy;
                cascadeMask.z = max(cascadeMask.z, 0.0);
                cascadeMask.w = v1.x + v1.y + 2.0;
            }
            else
            {
                cascadeMask.xy = posClip.xy * gShadowParam0123.z;
                float v1 = gShadowParam0123.x - gShadowParam891113.w;
                float v2 = gShadowParam891113.w / v1;
                float v3 = (gShadowParam0123.x * gShadowParam891113.w) / v1;
                cascadeMask.z = posClip.z * v2 + v1;
                cascadeMask.w = -posClip.z;
            }

            return cascadeMask;
        }

        struct VS_ShadowDepthPedOutput
        {
            float4 Position                : POSITION;
            float4 PositionWorldAndUnknown : TEXCOORD1;
        };

        VS_ShadowDepthPedOutput VS_ShadowDepthPed(VS_ShadowDepthInput IN)
        {
            VS_ShadowDepthPedOutput OUT;

            float3 posWorld = mul(float4(IN.Position, 1.0), gWorld).xyz;
            float4 posClip =  mul(float4(posWorld, 1), gShadowMatrix);
            float4 cascadeMask = ComputeCascadeMask(posClip);

            float3 a;
            a.xy = float2(cascadeMask.w, posWorld.z);
            a.z = cascadeMask.w * gShadowParam0123.w + cascadeMask.w;
            a.z = a.z * (gShadowParam14151617.x == 3) + cascadeMask.w;
            float3 b = float3(1, cascadeMask.wz);
            float3 v4 = lerp(a, b, gShadowParam14151617.x == 0.0);

            OUT.Position.xyz = cascadeMask.xyz;
            OUT.Position.w = v4.x;
            OUT.PositionWorldAndUnknown.xy = posWorld.xy;
            OUT.PositionWorldAndUnknown.zw = v4.yz;

            return OUT;
        }
    #endif //!DEFERRED_LIGHTING

    #ifndef NO_SKINNING
        struct VS_ShadowDepthSkinInput
        {
            float3 Position     : POSITION;
            float4 BlendWeights : BLENDWEIGHT;
            float4 BlendIndices : BLENDINDICES;
        #ifdef ALPHA_SHADOW
            float2 TexCoord     : TEXCOORD0;
        #endif //ALPHA_SHADOW
        };
    
        VS_ShadowDepthOutput VS_ShadowDepthSkin(VS_ShadowDepthSkinInput IN)
        {
            VS_ShadowDepthOutput OUT;

            float4x3 skinMtx = ComputeSkinMatrix(IN.BlendIndices, IN.BlendWeights);
            float3 posWorld = mul(float4(IN.Position, 1.0), skinMtx).xyz + gWorld[3].xyz;
            float4 posClip = mul(float4(posWorld, 1), gShadowMatrix);

            OUT.Position.z = 1.0 - min(posClip.z, 1.0);
            float4 cascadeMask = ComputeCascadeMask(posClip);

            OUT.Position.x = dot(cascadeMask, float4(1, 1, 1, 1)) * 0.00001 + posClip.x;
            OUT.Position.yw = posClip.yw * float2(1, 0) + float2(0, 0);

            #ifdef ALPHA_SHADOW
                OUT.DepthColorAndTexCoord.x = posClip.w;
                OUT.DepthColorAndTexCoord.yz = IN.TexCoord;
            #else
                OUT.DepthColor = posClip.w;
            #endif //ALPHA_SHADOW
            return OUT;
        }

        VS_ShadowDepthPedOutput VS_ShadowDepthSkinPed(VS_ShadowDepthSkinInput IN)
        {
            VS_ShadowDepthPedOutput OUT;

            float4x3 skinMtx = ComputeSkinMatrix(IN.BlendIndices, IN.BlendWeights);
            float3 posWorld = mul(float4(IN.Position, 1.0), skinMtx).xyz + gWorld[3].xyz;
            float4 posClip =  mul(float4(posWorld, 1), gShadowMatrix);
            float4 cascadeMask = ComputeCascadeMask(posClip);

            float3 a;
            a.xy = float2(cascadeMask.w, posWorld.z);
            a.z = cascadeMask.w * gShadowParam0123.w + cascadeMask.w;
            a.z = a.z * (gShadowParam14151617.x == 3) + cascadeMask.w;
            float3 b = float3(1, cascadeMask.wz);
            float3 v4 = lerp(a, b, gShadowParam14151617.x == 0.0);

            OUT.Position.xyz = cascadeMask.xyz;
            OUT.Position.w = v4.x;
            OUT.PositionWorldAndUnknown.xy = posWorld.xy;
            OUT.PositionWorldAndUnknown.zw = v4.yz;

            return OUT;
        }
    #endif //!NO_SKINNING


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

    #ifndef DEFERRED_LIGHTING
        float4 PS_ShadowDepthPed(VS_ShadowDepthPedOutput IN) : COLOR
        {
            clip(gShadowParam14151617.x == 0 ? 0.0099 - IN.PositionWorldAndUnknown.z : 0);
            return IN.PositionWorldAndUnknown.w;
        }
    #endif //!DEFERRED_LIGHTING

#endif //NO_SHADOW_CASTING