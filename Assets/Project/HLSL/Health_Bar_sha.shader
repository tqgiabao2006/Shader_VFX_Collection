Shader "Unlit/Health_Bar_sha"
{
    Properties
    {
        _Health("Health", Range(0,1)) = 1
        _StartColor("Start Color", Color) = (1,0,0,1) // Red
        _EndColor("End Color", Color) = (0,1,0,1) // Green
        
        _EdgeColor("Edge Color", Color) = (1,1,0,1)
        
        _EdgeThick("Edge Thick", Float) = 0.1
        
        _GreenThreshold("Green Threshold", Range(0,1)) = 0.8
        _RedThreshold("Red Threshold", Range(0,1)) = 0.2
        
        _HealthTexture("Health Texture", 2D) = "white"{}
        
        _Speed("Flash Speed", Float) = 5
    }
    SubShader
    {
        Tags { "RenderType"="Transparent" "Queue"="Transparent" }
        LOD 100
        
        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #pragma target 3.0

            #include "UnityCG.cginc"

            struct MeshData
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct Interpolator
            {
                float4 vertex : SV_POSITION;
                float2 uv: TEXCOORD0;
                float2 worldPos: TEXCOORD1;
            };

            float _Health;
            float4 _StartColor;
            float4 _EndColor;
            
            float _EdgeColor;
            float  _EdgeThick;
            float _RedThreshold;
            float _GreenThreshold;

            sampler2D _HealthTexture;

            float _Speed;

            Interpolator vert (MeshData v)
            {
                Interpolator o;
                o.worldPos = mul(unity_ObjectToWorld, v.vertex);
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;
                return o;
            }

            
            float3 GetScale()
            {
                float3 scale;
                scale.x = length(float3(unity_ObjectToWorld._m00, unity_ObjectToWorld._m10, unity_ObjectToWorld._m20));
                scale.y = length(float3(unity_ObjectToWorld._m01, unity_ObjectToWorld._m11, unity_ObjectToWorld._m21));
                scale.z = length(float3(unity_ObjectToWorld._m02, unity_ObjectToWorld._m12, unity_ObjectToWorld._m22));
                return scale;
            }

            

            float4 frag (Interpolator i) : SV_Target
            {
                float2 uniCoord = i.uv;
                uniCoord.x *= GetScale().x/GetScale().z;
                float2 pointOnSeg = float2(clamp(uniCoord.x, 0.5,GetScale().x/GetScale().z - 0.5 ), 0.5);

                float dst = distance(pointOnSeg, uniCoord) * 2 - 1;
                clip(-dst);

                float border = dst + _EdgeThick;

                float pd = fwidth(border);

                float borderMask = 1-saturate(border/pd);
                
               
                float wave = (sin(_Time.y * _Speed) + 1) * 0.5;
                float flash = lerp(float4(0,0,0,1), float4(1,1,1,1), wave);
                if (i.uv.x > _Health)
                
                {
                   return fixed4(0, 0, 0, 1);
                }

                if (_Health < _RedThreshold)
                {
                   return flash * tex2D(_HealthTexture, float2(_Health, i.uv.y));
                }
                
                return tex2D(_HealthTexture, float2(_Health, i.uv.y))  * borderMask;

                // if (i.uv.x > _Health)
                // {
                //    return fixed4(0, 0, 0, 0); // Fully transparent for empty part
                // }
                //
                // float4 healthColor;
                // if (_Health > _GreenThreshold)
                // {
                //     healthColor = _EndColor;
                // }
                // else if (_Health < _RedThreshold)
                // {
                //     healthColor = _StartColor;
                // }
                // else
                // {
                //     healthColor = lerp(_StartColor, _EndColor, _Health);
                // }
                //
                // return fixed4(healthColor.rgb, 1); // Ensure the health part is fully visible
            }


         
            ENDCG
        }
    }
}
