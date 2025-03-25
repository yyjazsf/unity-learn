Shader "Graph/Point Surface"
{
    Properties
    {
        _Smoothness ("Smoothness", Range(0, 1)) = 0.5
    }
    
    SubShader
    {
        // 定义渲染管线和渲染类型标签
        // RenderType="Opaque" 表示这是一个不透明物体的着色器
        // RenderPipeline="UniversalPipeline" 指定使用URP（Universal Render Pipeline）渲染管线
        Tags { "RenderType"="Opaque" "RenderPipeline" = "UniversalPipeline" }

        // 定义渲染通道
        Pass {
            // 通道名称，用于调试和编辑器显示
            Name "ForwardLit"
            
            // 通道标签
            // LightMode="UniversalForward" 表示这是一个前向渲染通道
            Tags { "LightMode" = "UniversalForward" }

            // HLSL代码块开始
            HLSLPROGRAM
            // 声明顶点着色器和片段着色器
            #pragma vertex vert
            #pragma fragment frag
            
            // 包含URP的核心库和光照库
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"

            // 定义顶点着色器的输入结构
            struct Attributes
            {
                // 模型空间中的顶点位置
                float4 positionOS : POSITION;
            };

            // 定义顶点着色器到片段着色器的传递结构
            struct Varyings
            {
                // 裁剪空间中的顶点位置（用于最终渲染）
                float4 positionCS : SV_POSITION;
                // 世界空间中的顶点位置（用于计算颜色）
                float3 positionWS : TEXCOORD0;
            };

            // 定义材质属性缓冲区
            // 这个缓冲区包含了在Inspector中可以调整的属性
            CBUFFER_START(UnityPerMaterial)
                float _Smoothness;  // 光滑度属性
            CBUFFER_END

            // 顶点着色器函数
            // 将模型空间顶点转换到世界空间和裁剪空间
            Varyings vert(Attributes IN)
            {
                Varyings OUT;
                // 使用URP提供的函数计算各种空间中的位置
                VertexPositionInputs positionInputs = GetVertexPositionInputs(IN.positionOS.xyz);
                // 设置裁剪空间位置
                OUT.positionCS = positionInputs.positionCS;
                // 设置世界空间位置
                OUT.positionWS = positionInputs.positionWS;
                return OUT;
            }

            // 片段着色器函数
            // 计算每个像素的最终颜色
            float4 frag(Varyings IN) : SV_TARGET
            {
                // 使用世界坐标计算颜色
                // 将世界坐标从[-1,1]范围映射到[0,1]范围
                float3 color = saturate(IN.positionWS * 0.5 + 0.5);
                // 返回最终颜色（RGB + Alpha）
                return float4(color, 1);
            }
            ENDHLSL
        }
    }
}
