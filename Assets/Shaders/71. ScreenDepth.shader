﻿Shader "Example/ScreenDepth" {

	// Allows to visualize the scene depth given the actual Unity Render Texture as an input
	// This shader must be used together with the DepthRenderImage script applied to the Camera

	Properties
	{
		_MainTex ("Main Texture", 2D) = "white" {}
		_DepthPower ("Depth Power", Range(0,5)) = 1
	}

 	SubShader {

		Pass
		{
			CGPROGRAM
			
			#pragma vertex vert_img
			#pragma fragment frag
			#pragma fragmentoption ARB_precision_hint_fastest

			#include "UnityCG.cginc"

			uniform sampler2D _MainTex;
			sampler2D _CameraDepthTexture;
			uniform fixed _DepthPower;
	
			fixed4 frag(v2f_img i) : SV_TARGET
			{
				float d = UNITY_SAMPLE_DEPTH(tex2D(_CameraDepthTexture, i.uv.xy));
				d = pow(Linear01Depth(d), _DepthPower);

				return d;
			}

			ENDCG
		}
	}

	FallBack Off
}