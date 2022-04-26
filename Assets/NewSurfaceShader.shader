Shader "Custom/NewSurfaceShader"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _Glossiness ("Smoothness", Range(0,1)) = 0.5
        _Metallic ("Metallic", Range(0,1)) = 0.0
        _TestColor ("testcolor", Color) = (1, 1, 1, 1) // float4 Ÿ������ ������ �Է¹޴� �������̽� �߰�
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
        float4 _TestColor; // �������̽����� ������ �Ͱ� ������ ������� ������ Ÿ������ �� ������ ���� ���� 
        // �̶�, ����ü�� �Լ� ������ ������ ������ ����ϴ� �κ��̹Ƿ�, ������ �̺��� �ռ��ִ� �� ������ ���� ������ ���ִ� ���� ����!

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            // Albedo comes from a texture tinted by color
            fixed4 c = tex2D (_MainTex, IN.uv_MainTex) * _Color;
            o.Albedo = _TestColor.rgb; // �׸��� o.Albedo �� �������̽��κ��� ������ �Է¹޴� ������ �κа�(.rgb) �� �״�� �־��ָ� ��. (_TestColor �� float4 ������, o.Albedo �� float3 �ϱ�, 3���� �κа��� �־��ָ� �ǰ���!)
            o.Metallic = _Metallic;
            o.Smoothness = _Glossiness;
            o.Alpha = c.a;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
