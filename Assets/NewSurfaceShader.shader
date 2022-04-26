Shader "Custom/NewSurfaceShader"
{
    Properties
    {
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

        CGPROGRAM
        #pragma surface surf Standard fullforwardshadows noambient

        struct Input
        {
            // uv_MainTex 라는 쓸모없는 구조체 값을 지웠더니, Input 구조체는 비워두면 안된다는 콘솔 에러가 발생했음.
            // 그래서 에러를 발생시키지 않을 용도로 임시로 넣어둔 구조체 값. (정확히는 버텍스 컬러값을 받아오는 구조체 값인데, 아직 배우지는 않은 거고, 현재 코드에서는 전혀 사용되지 않는 값임.)
            float4 color: COLOR;
        };

        // 인터페이스에 쓴 것과 동일한 타입과 이름의 변수를 빈 영역(실제로 사용할 함수 영역 앞)에 선언해 줌.
        // 참고로 Range 인터페이스는 슬라이더로 0 ~ 1 사이의 float 값을 입력받으므로, 각각의 입력값 타입은 float 이 적절하겠지
        float _Red;
        float _Green;
        float _Blue;

        // 인터페이스 추가하면 항상 빈 영역에 동일한 이름과 타입으로 변수 선언하기
        float _BrightDark; 

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            // _BrightDark 는 -1 ~ 1 사이의 값을 입력받는 변수이므로, float3(-1, -1, -1) ~ float3(1, 1, 1) 사이의 값을 더해줘서 밝기값을 조절해주는 것과 동일함!
            o.Albedo = float3(_Red, _Green, _Blue) + _BrightDark; // 인터페이스로부터 받은 각각의 입력값이 담긴 변수들을 float3() 에 담아 o.Albedo 에 할당해주면, 슬라이더로 입력받은 각각의 값에 따라 색상이 변경됨!
            o.Alpha = 1; // 원래 fixed c ~ 요런 변수에서 alpha 값을 가져와서 o.Alpha 에 할당해줬는데, 텍스쳐와 관련된 쓸모없는 변수여서 지웠잖아. 
            // -> 그래서 c.a 로 할당한 코드로 인해 에러가 났던 것. 이 에러를 안뜨게 하려고 c.a 말고 일반 상수 1을 넣어서 투명도를 할당한 것. 
            // 참고로, p.130 에도 나와있듯이, 여기에 0이나 0.5 를 넣어도 투명해지지는 않음. '아직까지는' (나중에 배운다는 소리.)
        }
        ENDCG
    }
    FallBack "Diffuse"
}
