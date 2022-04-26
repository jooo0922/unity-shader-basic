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

            // o.Albedo = test; // p.93 에도 나와있듯, o.Albedo 는 fixed3, 즉 float3 인데, float4 를 받아도 색상이 적용되고 있음.
            // 사실 이것은 변수를 올바르게 할당하는 방법은 아니며, 이 정도 실수는 엔진에서 알아서 처리해주기 때문에 에러만 나지 않는 것 뿐임. 
            // 따라서, float4 를 float3 에 적용할 때, test.rgb 이런 식으로 float4 안에서 앞에 3가지 값만 접근하여 float3 형태로 넣어주는 게 맞음.
            // o.Albedo = test.rgb;
            
            // 아래와 같이 test의 부분값들의 위치를 바꾸거나 중복해서 접근해도 자유롭게 사용 가능.
            // o.Albedo = test.grb; // float(0, 1, 0) 과 같음.
            // o.Albedo = test.bgr; // float(0, 0, 1) 과 같음.
            // o.Albedo = test.rrr; // float(1, 1, 1) 과 같음.

            // 아래와 같이 1자리 숫자를 넣는다고 해도, 이를 float3로 자동 변환해서 할당해 줌.  
            // o.Albedo = 0.5; // float(0.5, 0.5, 0.5) 로 자동변환.
            o.Albedo = test.b; // float(0, 0, 0) 로 자동변횐
            // 이렇게 변수값을 자유자재로 바꾸는 것을 스위즐링(swizzling) 이라고 함.

            o.Alpha = c.a;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
