Return-Path: <linux-kernel+bounces-377281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F24D9ABC7A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 05:52:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E285B1F2231E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 03:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBDD4137776;
	Wed, 23 Oct 2024 03:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l2U7Ws7i"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E727D17741;
	Wed, 23 Oct 2024 03:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729655528; cv=none; b=Jl7MHKxl84tmblCyE+YzGy3GCSsrSNAxczWd3K29TjIKyi52qRn8ohZWO5lAZFbkPW7AnSP/L09uWOoTenrM+cmRAyNeeDkRbWNgZrPGdtBEmMZdvvYyYKFjX8uESqUXXkt3IR8IoMikHaUWKG1xIu2oicwgj1LlSufXCIXnkdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729655528; c=relaxed/simple;
	bh=uIJhPElawMU0L0RV8kB18HIcQiqGuNmTqtIusIFMOR0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TfY2nJIU//BfD9IlP0Wg4lnxpYdjngoDv3g1jgsrguX7k+4FbFUCrLaZczJ3zGe4tj9P70uZn5PP0VebvuutJhCRpWk4zKJUdHGgec5XoeMWbmkFnehXwmkuqJKb9FD2KqGldzEWfIQ/gSDgK6zMUxxj55LlTwEso6ZPAv1eNdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l2U7Ws7i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7775FC4CEC6;
	Wed, 23 Oct 2024 03:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729655527;
	bh=uIJhPElawMU0L0RV8kB18HIcQiqGuNmTqtIusIFMOR0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l2U7Ws7iFf2b1TmSktmbERRlwP8Kie2zhROzyT7CFJlyYatpZPYQ+gtyDHSfMaJq7
	 kwg5HpiYt7VJUKL6isayrH7B3yXRUlSoQ96dDF1FXolSAIAfPI/dZEbS3GcKxbzCik
	 swvJawjO0AntT2mR6RO1BgGMViHF/OJSyxmvuTCL8W3s/6Eh2XJRTXg1kHVy5HKHdg
	 G5MlrY7nlj6cQUGvEzRrznTXIikDqlgqFyo8x/67unaBRiv2hgRihxBzo04LFpjqRv
	 gqFICoJOEFfSSuZ4SU/a1XeeO6afAIkV8eTJWvtvLh/P6qaJhtB5S419ytLGQl9JUS
	 JjpgJl8y3OtDA==
Date: Tue, 22 Oct 2024 22:52:04 -0500
From: Bjorn Andersson <andersson@kernel.org>
To: Melody Olvera <quic_molvera@quicinc.com>
Cc: Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Taniya Das <quic_tdas@quicinc.com>, Trilok Soni <quic_tsoni@quicinc.com>, 
	"Satya Durga Srinivasu Prabhala --cc=linux-arm-msm @ vger . kernel . org" <quic_satyap@quicinc.com>, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/7] dt-bindings: clock: qcom: Add SM8750 GCC clock
 controller
Message-ID: <zhv2oznu2lnlqkuafswqbxz3xqn5o2fsfval7as2k3xb76f53q@dum6ti6dpp46>
References: <20241021230359.2632414-1-quic_molvera@quicinc.com>
 <20241021230359.2632414-5-quic_molvera@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241021230359.2632414-5-quic_molvera@quicinc.com>

On Mon, Oct 21, 2024 at 04:03:56PM GMT, Melody Olvera wrote:
> From: Taniya Das <quic_tdas@quicinc.com>
> 
> Add device tree bindings for the video clock controller on Qualcomm

"video"...


I'd also suggest s/GCC/global/ in subject, to avoid the double cc

Regards,
Bjorn

> SM8750 platform.
> 
> Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
> ---
>  .../bindings/clock/qcom,sm8750-gcc.yaml       |  65 +++++
>  include/dt-bindings/clock/qcom,sm8750-gcc.h   | 226 ++++++++++++++++++
>  2 files changed, 291 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/qcom,sm8750-gcc.yaml
>  create mode 100644 include/dt-bindings/clock/qcom,sm8750-gcc.h
> 
> diff --git a/Documentation/devicetree/bindings/clock/qcom,sm8750-gcc.yaml b/Documentation/devicetree/bindings/clock/qcom,sm8750-gcc.yaml
> new file mode 100644
> index 000000000000..5e46cccd6e6c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/qcom,sm8750-gcc.yaml
> @@ -0,0 +1,65 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/qcom,sm8750-gcc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm Global Clock & Reset Controller on SM8750
> +
> +maintainers:
> +  - Taniya Das <quic_tdas@quicinc.com>
> +
> +description: |
> +  Qualcomm global clock control module provides the clocks, resets and power
> +  domains on SM8750
> +
> +  See also:: include/dt-bindings/clock/qcom,sm8750-gcc.h
> +
> +properties:
> +  compatible:
> +    const: qcom,sm8750-gcc
> +
> +  clocks:
> +    items:
> +      - description: Board XO source
> +      - description: Board Always On XO source
> +      - description: Sleep clock source
> +      - description: PCIE 0 Pipe clock source
> +      - description: PCIE 1 Pipe clock source
> +      - description: PCIE 1 Phy Auxiliary clock source
> +      - description: UFS Phy Rx symbol 0 clock source
> +      - description: UFS Phy Rx symbol 1 clock source
> +      - description: UFS Phy Tx symbol 0 clock source
> +      - description: USB3 Phy wrapper pipe clock source
> +
> +required:
> +  - compatible
> +  - clocks
> +
> +allOf:
> +  - $ref: qcom,gcc.yaml#
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/qcom,rpmh.h>
> +    clock-controller@100000 {
> +      compatible = "qcom,sm8750-gcc";
> +      reg = <0x00100000 0x001f4200>;
> +      clocks = <&rpmhcc RPMH_CXO_CLK>,
> +               <&rpmhcc RPMH_CXO_CLK_A>,
> +               <&sleep_clk>,
> +               <&pcie0_phy>,
> +               <&pcie1_phy>,
> +               <&pcie_1_phy_aux_clk>,
> +               <&ufs_mem_phy 0>,
> +               <&ufs_mem_phy 1>,
> +               <&ufs_mem_phy 2>,
> +               <&usb_1_qmpphy>;
> +      #clock-cells = <1>;
> +      #reset-cells = <1>;
> +      #power-domain-cells = <1>;
> +    };
> +
> +...
> diff --git a/include/dt-bindings/clock/qcom,sm8750-gcc.h b/include/dt-bindings/clock/qcom,sm8750-gcc.h
> new file mode 100644
> index 000000000000..e234595d7f42
> --- /dev/null
> +++ b/include/dt-bindings/clock/qcom,sm8750-gcc.h
> @@ -0,0 +1,226 @@
> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
> +/*
> + * Copyright (c) 2024, Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +#ifndef _DT_BINDINGS_CLK_QCOM_GCC_SM8750_H
> +#define _DT_BINDINGS_CLK_QCOM_GCC_SM8750_H
> +
> +/* GCC clocks */
> +#define GCC_AGGRE_NOC_PCIE_AXI_CLK				0
> +#define GCC_AGGRE_UFS_PHY_AXI_CLK				1
> +#define GCC_AGGRE_UFS_PHY_AXI_HW_CTL_CLK			2
> +#define GCC_AGGRE_USB3_PRIM_AXI_CLK				3
> +#define GCC_BOOT_ROM_AHB_CLK					4
> +#define GCC_CAM_BIST_MCLK_AHB_CLK				5
> +#define GCC_CAMERA_AHB_CLK					6
> +#define GCC_CAMERA_HF_AXI_CLK					7
> +#define GCC_CAMERA_SF_AXI_CLK					8
> +#define GCC_CAMERA_XO_CLK					9
> +#define GCC_CFG_NOC_PCIE_ANOC_AHB_CLK				10
> +#define GCC_CFG_NOC_USB3_PRIM_AXI_CLK				11
> +#define GCC_CNOC_PCIE_SF_AXI_CLK				12
> +#define GCC_DDRSS_GPU_AXI_CLK					13
> +#define GCC_DDRSS_PCIE_SF_QTB_CLK				14
> +#define GCC_DISP_AHB_CLK					15
> +#define GCC_DISP_HF_AXI_CLK					16
> +#define GCC_EVA_AHB_CLK						17
> +#define GCC_EVA_AXI0_CLK					18
> +#define GCC_EVA_AXI0C_CLK					19
> +#define GCC_EVA_XO_CLK						20
> +#define GCC_GP1_CLK						21
> +#define GCC_GP1_CLK_SRC						22
> +#define GCC_GP2_CLK						23
> +#define GCC_GP2_CLK_SRC						24
> +#define GCC_GP3_CLK						25
> +#define GCC_GP3_CLK_SRC						26
> +#define GCC_GPLL0						27
> +#define GCC_GPLL0_OUT_EVEN					28
> +#define GCC_GPLL1						29
> +#define GCC_GPLL4						30
> +#define GCC_GPLL7						31
> +#define GCC_GPLL9						32
> +#define GCC_GPU_CFG_AHB_CLK					33
> +#define GCC_GPU_GEMNOC_GFX_CLK					34
> +#define GCC_GPU_GPLL0_CLK_SRC					35
> +#define GCC_GPU_GPLL0_DIV_CLK_SRC				36
> +#define GCC_PCIE_0_AUX_CLK					37
> +#define GCC_PCIE_0_AUX_CLK_SRC					38
> +#define GCC_PCIE_0_CFG_AHB_CLK					39
> +#define GCC_PCIE_0_MSTR_AXI_CLK					40
> +#define GCC_PCIE_0_PHY_RCHNG_CLK				41
> +#define GCC_PCIE_0_PHY_RCHNG_CLK_SRC				42
> +#define GCC_PCIE_0_PIPE_CLK					43
> +#define GCC_PCIE_0_PIPE_CLK_SRC					44
> +#define GCC_PCIE_0_SLV_AXI_CLK					45
> +#define GCC_PCIE_0_SLV_Q2A_AXI_CLK				46
> +#define GCC_PCIE_RSCC_CFG_AHB_CLK				47
> +#define GCC_PCIE_RSCC_XO_CLK					48
> +#define GCC_PDM2_CLK						49
> +#define GCC_PDM2_CLK_SRC					50
> +#define GCC_PDM_AHB_CLK						51
> +#define GCC_PDM_XO4_CLK						52
> +#define GCC_QMIP_CAMERA_CMD_AHB_CLK				53
> +#define GCC_QMIP_CAMERA_NRT_AHB_CLK				54
> +#define GCC_QMIP_CAMERA_RT_AHB_CLK				55
> +#define GCC_QMIP_GPU_AHB_CLK					56
> +#define GCC_QMIP_PCIE_AHB_CLK					57
> +#define GCC_QMIP_VIDEO_CV_CPU_AHB_CLK				58
> +#define GCC_QMIP_VIDEO_CVP_AHB_CLK				59
> +#define GCC_QMIP_VIDEO_V_CPU_AHB_CLK				60
> +#define GCC_QMIP_VIDEO_VCODEC_AHB_CLK				61
> +#define GCC_QUPV3_I2C_CORE_CLK					62
> +#define GCC_QUPV3_I2C_S0_CLK					63
> +#define GCC_QUPV3_I2C_S0_CLK_SRC				64
> +#define GCC_QUPV3_I2C_S1_CLK					65
> +#define GCC_QUPV3_I2C_S1_CLK_SRC				66
> +#define GCC_QUPV3_I2C_S2_CLK					67
> +#define GCC_QUPV3_I2C_S2_CLK_SRC				68
> +#define GCC_QUPV3_I2C_S3_CLK					69
> +#define GCC_QUPV3_I2C_S3_CLK_SRC				70
> +#define GCC_QUPV3_I2C_S4_CLK					71
> +#define GCC_QUPV3_I2C_S4_CLK_SRC				72
> +#define GCC_QUPV3_I2C_S5_CLK					73
> +#define GCC_QUPV3_I2C_S5_CLK_SRC				74
> +#define GCC_QUPV3_I2C_S6_CLK					75
> +#define GCC_QUPV3_I2C_S6_CLK_SRC				76
> +#define GCC_QUPV3_I2C_S7_CLK					77
> +#define GCC_QUPV3_I2C_S7_CLK_SRC				78
> +#define GCC_QUPV3_I2C_S8_CLK					79
> +#define GCC_QUPV3_I2C_S8_CLK_SRC				80
> +#define GCC_QUPV3_I2C_S9_CLK					81
> +#define GCC_QUPV3_I2C_S9_CLK_SRC				82
> +#define GCC_QUPV3_I2C_S_AHB_CLK					83
> +#define GCC_QUPV3_WRAP1_CORE_2X_CLK				84
> +#define GCC_QUPV3_WRAP1_CORE_CLK				85
> +#define GCC_QUPV3_WRAP1_QSPI_REF_CLK				86
> +#define GCC_QUPV3_WRAP1_QSPI_REF_CLK_SRC			87
> +#define GCC_QUPV3_WRAP1_S0_CLK					88
> +#define GCC_QUPV3_WRAP1_S0_CLK_SRC				89
> +#define GCC_QUPV3_WRAP1_S1_CLK					90
> +#define GCC_QUPV3_WRAP1_S1_CLK_SRC				91
> +#define GCC_QUPV3_WRAP1_S2_CLK					92
> +#define GCC_QUPV3_WRAP1_S2_CLK_SRC				93
> +#define GCC_QUPV3_WRAP1_S3_CLK					94
> +#define GCC_QUPV3_WRAP1_S3_CLK_SRC				95
> +#define GCC_QUPV3_WRAP1_S4_CLK					96
> +#define GCC_QUPV3_WRAP1_S4_CLK_SRC				97
> +#define GCC_QUPV3_WRAP1_S5_CLK					98
> +#define GCC_QUPV3_WRAP1_S5_CLK_SRC				99
> +#define GCC_QUPV3_WRAP1_S6_CLK					100
> +#define GCC_QUPV3_WRAP1_S6_CLK_SRC				101
> +#define GCC_QUPV3_WRAP1_S7_CLK					102
> +#define GCC_QUPV3_WRAP1_S7_CLK_SRC				103
> +#define GCC_QUPV3_WRAP2_CORE_2X_CLK				104
> +#define GCC_QUPV3_WRAP2_CORE_CLK				105
> +#define GCC_QUPV3_WRAP2_IBI_CTRL_0_CLK_SRC			106
> +#define GCC_QUPV3_WRAP2_IBI_CTRL_2_CLK				107
> +#define GCC_QUPV3_WRAP2_IBI_CTRL_3_CLK				108
> +#define GCC_QUPV3_WRAP2_S0_CLK					109
> +#define GCC_QUPV3_WRAP2_S0_CLK_SRC				110
> +#define GCC_QUPV3_WRAP2_S1_CLK					111
> +#define GCC_QUPV3_WRAP2_S1_CLK_SRC				112
> +#define GCC_QUPV3_WRAP2_S2_CLK					113
> +#define GCC_QUPV3_WRAP2_S2_CLK_SRC				114
> +#define GCC_QUPV3_WRAP2_S3_CLK					115
> +#define GCC_QUPV3_WRAP2_S3_CLK_SRC				116
> +#define GCC_QUPV3_WRAP2_S4_CLK					117
> +#define GCC_QUPV3_WRAP2_S4_CLK_SRC				118
> +#define GCC_QUPV3_WRAP2_S5_CLK					119
> +#define GCC_QUPV3_WRAP2_S5_CLK_SRC				120
> +#define GCC_QUPV3_WRAP2_S6_CLK					121
> +#define GCC_QUPV3_WRAP2_S6_CLK_SRC				122
> +#define GCC_QUPV3_WRAP2_S7_CLK					123
> +#define GCC_QUPV3_WRAP2_S7_CLK_SRC				124
> +#define GCC_QUPV3_WRAP_1_M_AHB_CLK				125
> +#define GCC_QUPV3_WRAP_1_S_AHB_CLK				126
> +#define GCC_QUPV3_WRAP_2_IBI_2_AHB_CLK				127
> +#define GCC_QUPV3_WRAP_2_IBI_3_AHB_CLK				128
> +#define GCC_QUPV3_WRAP_2_M_AHB_CLK				129
> +#define GCC_QUPV3_WRAP_2_S_AHB_CLK				130
> +#define GCC_SDCC2_AHB_CLK					131
> +#define GCC_SDCC2_APPS_CLK					132
> +#define GCC_SDCC2_APPS_CLK_SRC					133
> +#define GCC_SDCC4_AHB_CLK					134
> +#define GCC_SDCC4_APPS_CLK					135
> +#define GCC_SDCC4_APPS_CLK_SRC					136
> +#define GCC_UFS_PHY_AHB_CLK					137
> +#define GCC_UFS_PHY_AXI_CLK					138
> +#define GCC_UFS_PHY_AXI_CLK_SRC					139
> +#define GCC_UFS_PHY_AXI_HW_CTL_CLK				140
> +#define GCC_UFS_PHY_ICE_CORE_CLK				141
> +#define GCC_UFS_PHY_ICE_CORE_CLK_SRC				142
> +#define GCC_UFS_PHY_ICE_CORE_HW_CTL_CLK				143
> +#define GCC_UFS_PHY_PHY_AUX_CLK					144
> +#define GCC_UFS_PHY_PHY_AUX_CLK_SRC				145
> +#define GCC_UFS_PHY_PHY_AUX_HW_CTL_CLK				146
> +#define GCC_UFS_PHY_RX_SYMBOL_0_CLK				147
> +#define GCC_UFS_PHY_RX_SYMBOL_0_CLK_SRC				148
> +#define GCC_UFS_PHY_RX_SYMBOL_1_CLK				149
> +#define GCC_UFS_PHY_RX_SYMBOL_1_CLK_SRC				150
> +#define GCC_UFS_PHY_TX_SYMBOL_0_CLK				151
> +#define GCC_UFS_PHY_TX_SYMBOL_0_CLK_SRC				152
> +#define GCC_UFS_PHY_UNIPRO_CORE_CLK				153
> +#define GCC_UFS_PHY_UNIPRO_CORE_CLK_SRC				154
> +#define GCC_UFS_PHY_UNIPRO_CORE_HW_CTL_CLK			155
> +#define GCC_USB30_PRIM_MASTER_CLK				156
> +#define GCC_USB30_PRIM_MASTER_CLK_SRC				157
> +#define GCC_USB30_PRIM_MOCK_UTMI_CLK				158
> +#define GCC_USB30_PRIM_MOCK_UTMI_CLK_SRC			159
> +#define GCC_USB30_PRIM_MOCK_UTMI_POSTDIV_CLK_SRC		160
> +#define GCC_USB30_PRIM_SLEEP_CLK				161
> +#define GCC_USB3_PRIM_PHY_AUX_CLK				162
> +#define GCC_USB3_PRIM_PHY_AUX_CLK_SRC				163
> +#define GCC_USB3_PRIM_PHY_COM_AUX_CLK				164
> +#define GCC_USB3_PRIM_PHY_PIPE_CLK				165
> +#define GCC_USB3_PRIM_PHY_PIPE_CLK_SRC				166
> +#define GCC_VIDEO_AHB_CLK					167
> +#define GCC_VIDEO_AXI0_CLK					168
> +#define GCC_VIDEO_AXI1_CLK					169
> +#define GCC_VIDEO_XO_CLK					170
> +
> +/* GCC power domains */
> +#define GCC_PCIE_0_GDSC						0
> +#define GCC_PCIE_0_PHY_GDSC					1
> +#define GCC_UFS_MEM_PHY_GDSC					2
> +#define GCC_UFS_PHY_GDSC					3
> +#define GCC_USB30_PRIM_GDSC					4
> +#define GCC_USB3_PHY_GDSC					5
> +
> +/* GCC resets */
> +#define GCC_CAMERA_BCR						0
> +#define GCC_DISPLAY_BCR						1
> +#define GCC_EVA_BCR						2
> +#define GCC_GPU_BCR						3
> +#define GCC_PCIE_0_BCR						4
> +#define GCC_PCIE_0_LINK_DOWN_BCR				5
> +#define GCC_PCIE_0_NOCSR_COM_PHY_BCR				6
> +#define GCC_PCIE_0_PHY_BCR					7
> +#define GCC_PCIE_0_PHY_NOCSR_COM_PHY_BCR			8
> +#define GCC_PCIE_PHY_BCR					9
> +#define GCC_PCIE_PHY_CFG_AHB_BCR				10
> +#define GCC_PCIE_PHY_COM_BCR					11
> +#define GCC_PCIE_RSCC_BCR					12
> +#define GCC_PDM_BCR						13
> +#define GCC_QUPV3_WRAPPER_1_BCR					14
> +#define GCC_QUPV3_WRAPPER_2_BCR					15
> +#define GCC_QUPV3_WRAPPER_I2C_BCR				16
> +#define GCC_QUSB2PHY_PRIM_BCR					17
> +#define GCC_QUSB2PHY_SEC_BCR					18
> +#define GCC_SDCC2_BCR						19
> +#define GCC_SDCC4_BCR						20
> +#define GCC_UFS_PHY_BCR						21
> +#define GCC_USB30_PRIM_BCR					22
> +#define GCC_USB3_DP_PHY_PRIM_BCR				23
> +#define GCC_USB3_DP_PHY_SEC_BCR					24
> +#define GCC_USB3_PHY_PRIM_BCR					25
> +#define GCC_USB3_PHY_SEC_BCR					26
> +#define GCC_USB3PHY_PHY_PRIM_BCR				27
> +#define GCC_USB3PHY_PHY_SEC_BCR					28
> +#define GCC_VIDEO_AXI0_CLK_ARES					29
> +#define GCC_VIDEO_AXI1_CLK_ARES					30
> +#define GCC_VIDEO_BCR						31
> +#define GCC_EVA_AXI0_CLK_ARES					32
> +#define GCC_EVA_AXI0C_CLK_ARES					33
> +
> +#endif
> -- 
> 2.46.1
> 

