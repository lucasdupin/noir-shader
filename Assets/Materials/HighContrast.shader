Shader "Custom/HighContrast" {
	Properties {
		_Color ("Color", Color) = (1,1,1,1)
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
		_Glossiness ("Smoothness", Range(0,1)) = 0.5
		_Metallic ("Metallic", Range(0,1)) = 0.0
	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 200
		
		CGPROGRAM
		// Physically based Standard lighting model, and enable shadows on all light types
		//#pragma surface surf Standard fullforwardshadows
		#pragma surface surf Standard finalcolor:highContrast

		// Use shader model 3.0 target, to get nicer looking lighting
		#pragma target 3.0

		sampler2D _MainTex;

		struct Input {
			float2 uv_MainTex;
		};

		void highContrast (Input IN, SurfaceOutputStandard o, inout fixed4 color) {
//			fixed3 target = smoothstep(o.Albedo, fixed3(0, 0, 0), color.r+color.g+color.b);
//			color = fixed4(target, color.a);
			float val = smoothstep(0.9, 0.91, (color.r+color.g+color.b)/3);
			color = fixed4(val, val, val, 1);
			//color *= fixed4(1.0, 0, 0, 1);
	    }

		half _Glossiness;
		half _Metallic;
		fixed4 _Color;

		void surf (Input IN, inout SurfaceOutputStandard o) {
			// Albedo comes from a texture tinted by color
			fixed4 c = tex2D (_MainTex, IN.uv_MainTex) * _Color;
			o.Albedo = c.rgb;
			// Metallic and smoothness come from slider variables
			o.Metallic = _Metallic;
			o.Smoothness = _Glossiness;
			o.Alpha = c.a;
		}
		ENDCG
	}
	FallBack "Diffuse"
}
