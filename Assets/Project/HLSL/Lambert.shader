Shader "Unlit/Lambert"
{
    Properties
    {
        _MainTex("Main Texture", 2D) = "white"{}
        _Glossiness("Glossiness",Range(0,1)) = 0
        _olor("Main Color", Color) = (1,1,1,1)
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
            #include "Lighting.cginc"
            #include  "AutoLight.cginc"
            
            struct MeshData
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
                float3 normal: NORMAL;
            };

            struct Interpolators
            {
                float4 vertex : SV_POSITION;
                float2 uv : TEXCOORD0;
                float3 normal: TEXCOORD1;
                float3 worlPos: TEXCOORD2;
            };

            sampler2D _MainTex;
            float4 _MainTex_ST;
            float _Glossiness;
            float4 _Color;
            Interpolators vert (MeshData v)
            {
                Interpolators o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv =TRANSFORM_TEX(v.uv, _MainTex);
                o.normal = UnityObjectToWorldNormal(v.normal);
                o.worlPos = mul(unity_ObjectToWorld, v.vertex);
                return o;
            }

            fixed4 frag (Interpolators i) : SV_Target
            {
                //Diffuse lighting
                float3 N = normalize(i.normal);
                float3 L = _WorldSpaceLightPos0.xyz; //Can be either position or direction

                float diffuseLight = saturate(dot(N,L)) * _LightColor0;
                
                //Spectacular lighting
                float3 worldCameraPos = _WorldSpaceCameraPos;
                float3 V = normalize(worldCameraPos - i.worlPos);
                float3 R = reflect(-L, N);
                float3 specularL = saturate(dot(V, R));

                _Glossiness = exp2(_Glossiness*11 ) + 2; // Re map Glosiness in range (0,1)
                specularL = pow(specularL, _Glossiness);

                //Blinn Phong
                float3 H = normalize(L + V);
                float3 blinn = pow( saturate(dot(H, N)) * (diffuseLight >0), _Glossiness) * _LightColor0;
                
                return float4(blinn + diffuseLight * _Color,1);
            }
            ENDCG
        }
    }
}
