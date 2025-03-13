Shader "Unlit/First"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _Value("Value", Float) = 2
        _Scale("Scale", FLoat) = 1
        _Offset("Offset", Float) = 0
        _ColorA("Start Color", Color) = (1,1,1,1)
        _ColorB("End Color", Color) = (0,0,0,0)
        
        _Start("Start", Float) = 0
        _End("End", Float) = 1
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            float _Value;
            float _Scale;
            float _Offset;
            float4 _ColorA;
            float4 _ColorB;

            float _Start;
            float _End;
            
            struct MeshData
            {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float2 uv0 : TEXCOORD0;
          
            };

            struct Interpolators
            {
                float4 vertex : SV_POSITION;
                float3 normal: TEXCOORD0;
                float2 uv : TEXCOORD1;
            };

            sampler2D _MainTex;
            float4 _MainTex_ST;
 
            Interpolators vert (MeshData v)
            {
                Interpolators o; //Output
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.normal = UnityObjectToWorldNormal(v.normal); //Transfer from local normal to world normal
                o.uv = v.uv0;
                return o;
            }

            //float  (32 bit float)
            // half (16 bit float)
            // fixed (low legacy, low precision) (12)
            // half4, fixed4,..
            // float4x4 => matrix 4x4
            // half4x4
            // bool: 0 1  
            
            fixed4 frag (Interpolators i) : SV_Target
            {

                float x = abs(frac(5 * i.uv.x)* 2 - 1);
                return x;
                
                float t = saturate((i.uv.x - _Start)/(_End - _Start));
                t = frac(t ); 
                float4 outputColor = lerp(_ColorA, _ColorB, t);
                return outputColor;
            }
            ENDCG
        }
    }
}
