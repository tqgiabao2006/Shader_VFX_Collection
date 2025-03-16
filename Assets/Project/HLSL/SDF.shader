Shader "Unlit/SDF"
{
    Properties
    {
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

            struct MeshData
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct Interpolator
            {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
            };


            Interpolator vert (MeshData v)
            {
                Interpolator o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv*2 - 1; 
                return o;
            }

            float4 frag (Interpolator i) : SV_Target
            {
                float dst = distance(float2(0,0), i.uv) - 0.3;
                return step(0, dst) + float4(1,0,0,1);
                return step(0, dst);
                return dst;
                return float4(i.uv.xy,0,1);
            }
            ENDCG
        }
    }
}
