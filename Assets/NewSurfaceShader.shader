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
            float4 test = float4(1, 0, 0, 1);

            // o.Albedo = test; // p.93 ���� �����ֵ�, o.Albedo �� fixed3, �� float3 �ε�, float4 �� �޾Ƶ� ������ ����ǰ� ����.
            // ��� �̰��� ������ �ùٸ��� �Ҵ��ϴ� ����� �ƴϸ�, �� ���� �Ǽ��� �������� �˾Ƽ� ó�����ֱ� ������ ������ ���� �ʴ� �� ����. 
            // ����, float4 �� float3 �� ������ ��, test.rgb �̷� ������ float4 �ȿ��� �տ� 3���� ���� �����Ͽ� float3 ���·� �־��ִ� �� ����.
            // o.Albedo = test.rgb;
            
            // �Ʒ��� ���� test�� �κа����� ��ġ�� �ٲٰų� �ߺ��ؼ� �����ص� �����Ӱ� ��� ����.
            // o.Albedo = test.grb; // float(0, 1, 0) �� ����.
            // o.Albedo = test.bgr; // float(0, 0, 1) �� ����.
            // o.Albedo = test.rrr; // float(1, 1, 1) �� ����.

            // �Ʒ��� ���� 1�ڸ� ���ڸ� �ִ´ٰ� �ص�, �̸� float3�� �ڵ� ��ȯ�ؼ� �Ҵ��� ��.  
            // o.Albedo = 0.5; // float(0.5, 0.5, 0.5) �� �ڵ���ȯ.
            o.Albedo = test.b; // float(0, 0, 0) �� �ڵ���Ⱥ
            // �̷��� �������� ��������� �ٲٴ� ���� ������(swizzling) �̶�� ��.

            o.Alpha = c.a;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
