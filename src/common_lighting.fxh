//by ParallelLines
float3 ComputeDepthEffects(in float noSkyMask, in float3 color, in float linearDepth)
{
    float colorFactor = 1.0 - saturate((gDepthFxParams.w - linearDepth) / (gDepthFxParams.w - gDepthFxParams.z));
    colorFactor *= noSkyMask;

    float saturation = colorFactor * (gDepthFxParams.x - 1.0) + 1.0;
    float gamma = colorFactor * (gDepthFxParams.y - 1.0);
    float luminance = dot(color, float3(0.2125, 0.7154, 0.0721));

    color = lerp(luminance, color, saturation) * pow(abs(luminance + 0.0000001), gamma);

    float fogCameraToStartFactor = saturate(linearDepth / globalFogParams.x);
    float fogStartToEndFactor = saturate((linearDepth - globalFogParams.x) / (globalFogParams.y - globalFogParams.x));
    float fogFactor = lerp(fogStartToEndFactor, fogCameraToStartFactor, globalFogParams.w) + globalFogParams.z;
    fogFactor *= noSkyMask;

    float3 fogColor = lerp(globalFogColorN.xyz, globalFogColor.xyz, fogStartToEndFactor);

    float skyFogFactor = (1.0 - noSkyMask) * globalFogParams.w;
    color = lerp(color, globalFogColorN.xyz, skyFogFactor); // sky pixels are affected when "fog density" > 0.0
    return lerp(color, fogColor, fogFactor);
}

#ifndef NO_LIGHTING
    struct SurfaceProperties
    {
        float3 Diffuse;
        float3 Normal;
        float  SpecularIntensity;
        float  SpecularPower;
        float  AmbientOcclusion;
    };

    float3 ComputeLighting(in bool shadowed, in float3 posWorld, in float3 viewDir, in SurfaceProperties surfProperties)
    {
        float shadow = 1;
        if(shadowed)
            shadow = ComputeShadow(posWorld);

        float3 normal = surfProperties.Normal;
        float3 directionalColor = gDirectionalColour.xyz * gDirectionalColour.w;

        float3 R = reflect(viewDir, normal);
        float3 specularLight = 0;
        if(shadowed)
        {
            #if defined(SPECULAR) || defined(DEFERRED_LIGHTING)
                specularLight = saturate(dot(-gDirectionalLight.xyz, R)).xxx + 0.00001;
                specularLight = pow(specularLight, surfProperties.SpecularPower + 0.00001);
                specularLight *= directionalColor * shadow;
                #ifdef DEFERRED_LIGHTING
                    specularLight *= (gDirectionalLight.w * 2);
                #else
                    specularLight *= gDirectionalLight.w;
                #endif //DEFERRED_LIGHTING
            #endif //SPECULAR
        }

        #ifdef DEFERRED_LIGHTING
            float rimLighting = pow(1.0 - abs(dot(-viewDir, normal)), 4) * 0.75 + 0.25;

            float dist = distance(posWorld, gViewInverse[3].xyz);
            float3 v3 = viewDir * saturate(dist / 50) + R;
            v3 = normalize(v3 + 0.00001);
            float parabReflDistanceFade = 1.0 - saturate(dist / 100);
            float parabReflVerticalFade = saturate(v3.z * 5);

            float v4 = (saturate(v3.z) + 1) * 2;
            float2 parabReflCoords = (v3.xy / v4) + 0.5;
            float parabReflMip = surfProperties.SpecularPower * dReflectionParams.x;
            parabReflMip = parabReflMip * -4 + 4;
            float3 parabRefl = tex2Dlod(ParabSampler, float4(1 - parabReflCoords, 0, parabReflMip)).xyz;
            parabRefl = parabRefl * parabReflDistanceFade * parabReflVerticalFade * surfProperties.AmbientOcclusion * globalScalars.w * rimLighting * 10;
            
            specularLight += parabRefl;
        #endif //DEFERRED_LIGHTING

        specularLight *= surfProperties.SpecularIntensity;
        
        float3 ambientLight = gLightAmbient1.xyz * saturate(normal.z * -0.5 + 0.5) + gLightAmbient0.xyz;
        #ifndef DIRT_DECAL_MASK
            ambientLight *= surfProperties.AmbientOcclusion;
        #endif //!DIRT_DECAL_MASK

        float nDotL = dot(-gDirectionalLight.xyz, normal);
        nDotL = saturate((nDotL - 0.25) * 1.33333337);
        float3 diffuseLight = (directionalColor * nDotL * shadow) + ambientLight;

        return surfProperties.Diffuse * diffuseLight + specularLight;
    }
#endif //NO_LIGHTING