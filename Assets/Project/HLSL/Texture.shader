Shader "Unlit/Texture"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _Pattern("Pattern", 2D) = "white"{} 
        _Rock("Rock", 2D) = "white"{}
        _MipLevel("Mip Level", Float)  = 0
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100

        Pass
        {
            CGPROGRAM
            #pragma vertex interpolation
            #pragma fragment frag

            #include "UnityCG.cginc"
            #define  TAU 6.28318530718

            struct MeshData
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct Interpolator
            {
                float2 uv : TEXCOORD0;
                float3 worldPos: TEXCOORD1;
                float4 vertex : SV_POSITION;
            };

            sampler2D _MainTex;
            float4 _MainTex_ST;

            sampler2D _Pattern;
            sampler2D _Rock;

            float _MipLevel;
            
            Interpolator interpolation (MeshData v)
            {
                Interpolator o;
                o.worldPos = mul(unity_ObjectToWorld, v.vertex);
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;
                
                return o;
            }

            float GetWave(float pattern)
            {
                 
                 float2 uvCenter = pattern * 2 -1;
                 float radius = length(uvCenter);
 
                 float wave = cos((radius - _Time.y * 0.2) * TAU *5);
                 // float wave = radius * t;e
                 wave *= 1-radius;
                 return wave;
            }
            
            fixed4 frag (Interpolator i) : SV_Target
            {
                // sample the texture
                float2 topdown = i.worldPos.xz;
                float4 mos = tex2Dlod(_MainTex, float4(topdown, _MipLevel.xx));

                float4 rock = tex2D(_Rock, topdown);
                
                
                return mos;
            }
            ENDCG
        }
    }
}
