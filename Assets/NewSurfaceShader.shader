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
            // o.Albedo = float3(1, 0, 0); // SurfaceOutputStandard.Albedo ���� ������ �־��
            
            // SurfaceOutputStandard.Emission ���� ���� ���ϱ�
            // o.Emission = float3(1, 0, 0) + float3(0, 1, 0);
            // o.Emission = float3(0.5, 0.5, 0.5) + float3(0.5, 0.5, 0.5);
            
            // SurfaceOutputStandard.Emission ���� ���� ���ϱ�
            // o.Emission = float3(1, 0, 0) * float3(0, 1, 0);
            // o.Emission = float3(0.5, 0.5, 0.5) * float3(0.5, 0.5, 0.5);

            // 0 ~ 1 ���̸� �Ѿ�� ������ ����
            // o.Emission = float3(1, 0, 0) + float3(1, 0, 0); // ���������δ� �����͸� float(2, 0, 0) ���� ����������, ����ʹ� float(1, 0, 0) �� �����ϰ� ǥ����.

            // float3 �� �� �ڸ������� ����
            o.Emission = float3(0, 0, 0); // -1 �� �����ϴ� �� -float3(1, 1, 1) �� �����ϴ� �Ͱ� ������. ���� ������ ó���� float3(0, -1, -1) �� ���������, ����ʹ� float(0, 0, 0) �� �����ϰ� ǥ����.
            
            // Metallic and smoothness come from slider variables
            // o.Metallic = _Metallic;
            // o.Smoothness = _Glossiness;
            o.Alpha = c.a;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
