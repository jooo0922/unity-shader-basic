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
            float r = 1;
            float2 gg = float2(0.5, 0);
            float3 bbb = float3(1, 0, 1);

            // Albedo comes from a texture tinted by color
            fixed4 c = tex2D (_MainTex, IN.uv_MainTex) * _Color;
            // o.Albedo = float3(r, 0, 0); // ���� float r �� 1�� �����Ƿ�, �� ������ ��ġ ���� 1ó�� �Ҵ��ϴ� ������ ��� ����
            //o.Albedo = float3(0, gg); // �굵 ���������� ���� gg �� �� float(0.5, 0) �� ��ġ ����ó�� �Ҵ� ����
            o.Albedo = float3(bbb.b, gg.r, r.r); // �̷� ������, �� ������ rgba �� �����ؼ� ����ó�� �Ҵ� ����. -> bbb.b = 1, gg.r = 0.5, r.r = 1 �̹Ƿ�, float3(1, 0.5, 1) �� �� ������!
            o.Alpha = c.a;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
