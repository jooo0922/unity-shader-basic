Shader "Custom/NewSurfaceShader"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _Glossiness ("Smoothness", Range(0,1)) = 0.5
        _Metallic ("Metallic", Range(0,1)) = 0.0
        _TestColor ("testcolor", Color) = (1, 1, 1, 1) // float4 타입으로 색상값을 입력받는 인터페이스 추가
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
        float4 _TestColor; // 인터페이스에서 지정한 것과 동일한 변수명과 동일한 타입으로 빈 영역에 변수 선언 
        // 이때, 구조체나 함수 영역은 변수를 실제로 사용하는 부분이므로, 가급적 이보다 앞서있는 빈 영역에 변수 선언을 해주는 것이 좋음!

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            // Albedo comes from a texture tinted by color
            fixed4 c = tex2D (_MainTex, IN.uv_MainTex) * _Color;
            o.Albedo = _TestColor.rgb; // 그리고 o.Albedo 에 인터페이스로부터 색상값을 입력받는 변수의 부분값(.rgb) 를 그대로 넣어주면 됨. (_TestColor 는 float4 이지만, o.Albedo 는 float3 니까, 3개의 부분값만 넣어주면 되겠지!)
            o.Metallic = _Metallic;
            o.Smoothness = _Glossiness;
            o.Alpha = c.a;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
