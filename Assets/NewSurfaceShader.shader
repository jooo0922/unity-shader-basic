Shader "Custom/NewSurfaceShader"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _Glossiness ("Smoothness", Range(0,1)) = 0.5
        _Metallic ("Metallic", Range(0,1)) = 0.0

        // �̹����� r, g, b ���� Range �����̴� �������̽��� ���� �޾� ������ ����ϱ� ���� �������̽��� 3�� ����.
        _Red ("Red", Range(0, 1)) = 0
        _Green("Green", Range(0, 1)) = 0
        _Blue("Blue", Range(0, 1)) = 0

        // �̹����� Range �����̴� �������̽��κ��� ���� �Է¹޴� ��, o.Albedo ���� �����༭ ��Ⱚ�� �����ϴ� �������̽��� �߰���.
        _BrightDark ("Brightness $ Darkness", Range(-1, 1)) = 0
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

        // �������̽��� �� �Ͱ� ������ Ÿ�԰� �̸��� ������ �� ����(������ ����� �Լ� ���� ��)�� ������ ��.
        // ����� Range �������̽��� �����̴��� 0 ~ 1 ������ float ���� �Է¹����Ƿ�, ������ �Է°� Ÿ���� float �� �����ϰ���
        float _Red;
        float _Green;
        float _Blue;

        float _BrightDark; // �������̽� �߰��ϸ� �׻� �� ������ ������ �̸��� Ÿ������ ���� �����ϱ�

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            // Albedo comes from a texture tinted by color
            fixed4 c = tex2D (_MainTex, IN.uv_MainTex) * _Color;

            // _BrightDark �� -1 ~ 1 ������ ���� �Է¹޴� �����̹Ƿ�, float3(-1, -1, -1) ~ float3(1, 1, 1) ������ ���� �����༭ ��Ⱚ�� �������ִ� �Ͱ� ������!
            o.Albedo = float3(_Red, _Green, _Blue) + _BrightDark; // �������̽��κ��� ���� ������ �Է°��� ��� �������� float3() �� ��� o.Albedo �� �Ҵ����ָ�, �����̴��� �Է¹��� ������ ���� ���� ������ �����!
            o.Alpha = c.a;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
