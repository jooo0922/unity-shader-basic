Shader "Custom/NewSurfaceShader"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _Glossiness ("Smoothness", Range(0,1)) = 0.5
        _Metallic ("Metallic", Range(0,1)) = 0.0

        // 이번에는 r, g, b 값을 Range 슬라이더 인터페이스로 각각 받아 색상을 출력하기 위해 인터페이스를 3개 만듦.
        _Red ("Red", Range(0, 1)) = 0
        _Green("Green", Range(0, 1)) = 0
        _Blue("Blue", Range(0, 1)) = 0

        // 이번에는 Range 슬라이더 인터페이스로부터 값을 입력받는 뒤, o.Albedo 값에 더해줘서 밝기값을 조절하는 인터페이스를 추가함.
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

        // 인터페이스에 쓴 것과 동일한 타입과 이름의 변수를 빈 영역(실제로 사용할 함수 영역 앞)에 선언해 줌.
        // 참고로 Range 인터페이스는 슬라이더로 0 ~ 1 사이의 float 값을 입력받으므로, 각각의 입력값 타입은 float 이 적절하겠지
        float _Red;
        float _Green;
        float _Blue;

        float _BrightDark; // 인터페이스 추가하면 항상 빈 영역에 동일한 이름과 타입으로 변수 선언하기

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            // Albedo comes from a texture tinted by color
            fixed4 c = tex2D (_MainTex, IN.uv_MainTex) * _Color;

            // _BrightDark 는 -1 ~ 1 사이의 값을 입력받는 변수이므로, float3(-1, -1, -1) ~ float3(1, 1, 1) 사이의 값을 더해줘서 밝기값을 조절해주는 것과 동일함!
            o.Albedo = float3(_Red, _Green, _Blue) + _BrightDark; // 인터페이스로부터 받은 각각의 입력값이 담긴 변수들을 float3() 에 담아 o.Albedo 에 할당해주면, 슬라이더로 입력받은 각각의 값에 따라 색상이 변경됨!
            o.Alpha = c.a;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
