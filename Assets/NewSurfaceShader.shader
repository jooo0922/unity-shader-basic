Shader "Custom/NewSurfaceShader"
{
    Properties
    {
        // _Brightness ("Brightness!!", Range(0, 1)) = 0.5
        // _TestFloat ("TestFloat!!", Float) = 0.5
        // _TestColor ("TestColor!!", Color) = (0, 0, 1, 1)
        // _TestVector ("TestVector!!", Vector) = (1, 1, 1, 1)
        // _TestTexture ("Test texture!!", 2D) = "white" {}
        _Color ("Color", Color) = (1,1,1,1)
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _Glossiness ("Smoothness", Range(0,1)) = 0.5
        _Metallic ("Metallic", Range(0,1)) = 0.0
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 200

        CGPROGRAM
        // Physically based Standard lighting model, and enable shadows on all light types
        #pragma surface surf Standard fullforwardshadows noambient

        // Use shader model 3.0 target, to get nicer looking lighting
        #pragma target 3.0

        sampler2D _MainTex;

        struct Input
        {
            float2 uv_MainTex;
        };

        half _Glossiness;
        half _Metallic;
        fixed4 _Color;

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            // Albedo comes from a texture tinted by color
            fixed4 c = tex2D (_MainTex, IN.uv_MainTex) * _Color;
            // o.Albedo = float3(1, 0, 0); // SurfaceOutputStandard.Albedo 값에 빨강색 넣어보기
            
            // SurfaceOutputStandard.Emission 으로 색상 더하기
            // o.Emission = float3(1, 0, 0) + float3(0, 1, 0);
            // o.Emission = float3(0.5, 0.5, 0.5) + float3(0.5, 0.5, 0.5);
            
            // SurfaceOutputStandard.Emission 으로 색상 곱하기
            // o.Emission = float3(1, 0, 0) * float3(0, 1, 0);
            // o.Emission = float3(0.5, 0.5, 0.5) * float3(0.5, 0.5, 0.5);

            // 0 ~ 1 사이를 넘어가는 색상의 연산
            // o.Emission = float3(1, 0, 0) + float3(1, 0, 0); // 내부적으로는 데이터를 float(2, 0, 0) 으로 저장하지만, 모니터는 float(1, 0, 0) 과 동일하게 표현함.

            // float3 와 한 자리수와의 연산
            o.Emission = float3(0, 0, 0); // -1 을 연산하는 건 -float3(1, 1, 1) 을 연산하는 것과 동일함. 따라서 데이터 처리는 float3(0, -1, -1) 로 저장되지만, 모니터는 float(0, 0, 0) 과 동일하게 표현함.
            
            // Metallic and smoothness come from slider variables
            // o.Metallic = _Metallic;
            // o.Smoothness = _Glossiness;
            o.Alpha = c.a;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
