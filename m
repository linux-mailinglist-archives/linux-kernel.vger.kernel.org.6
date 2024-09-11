Return-Path: <linux-kernel+bounces-325068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD676975478
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 15:50:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A4A51F2753B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 13:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6130D19C553;
	Wed, 11 Sep 2024 13:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m+ZX/vz7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9187919343E;
	Wed, 11 Sep 2024 13:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726062609; cv=none; b=Q2XIatUkF+JQxqYZ43FtO+K0GgLjLwRh7Ylah4CPCkJtBMNlIY79Gk7KSEY4EOAStZr2SG/W3vRmP4ka76mSESfwOQ69LzysomS2mblc2QiEf3SJNZ2h1UKvu5coSTrAC966Fq5LHjkPkJQGf6PE34K9lcikhIwkfbJaIEzdrHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726062609; c=relaxed/simple;
	bh=N81tFhroIl/Qerhb+Gan0l3fOl6h2MuZvqVlrmL1Op4=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=opirrdkuHrfh5qU1NroJLb/XtOSc3Plxl5o/SE8B4AjbuWgGnOfGtXHT+uJ1MYwN9pGgvwPBrdZXSv2esSGkSbvmQgOnsgtn5eocs7FfXxRtOxSqea8UqkKeEZx5QMhaOAT+5qVx+YfJa6damEyKGmX6zFGKbN8i3lEc9i/+9ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m+ZX/vz7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A823C4CEC5;
	Wed, 11 Sep 2024 13:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726062609;
	bh=N81tFhroIl/Qerhb+Gan0l3fOl6h2MuZvqVlrmL1Op4=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=m+ZX/vz79xdEvcQq3LII2KIDx4oswbO8HI7Pyd2QEsLPgjdFhOskHmuxxhS4JKoiB
	 MWf7HBfXTzmW0+6wbs5J/0NChEwL0aMccQ+H1lpiMCjGZPnCZC4xRu8LozEHFY1+4t
	 CTzF8+iUXuzknMZSUKLVnsQyvBMvjwiKtcSG88Cu0RepC9GQyy7ikqe2C+LD+Hocx1
	 Es4cXg6OItqHE5il2rnt4jrnd39HhiNERbKlhm6bA/5zxjnl26rkaMjo89iKctgdHm
	 V/zvfqhw9ODqC+h+TVfAJ7F4i3pC1v1BYj4Z7rAg8s7mwMgOqfANNeXB+OP4sylclC
	 Id8BUq0fsXaPg==
Date: Wed, 11 Sep 2024 08:50:08 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@baylibre.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, linux-amlogic@lists.infradead.org, 
 Jerome Brunet <jbrunet@baylibre.com>
In-Reply-To: <20240911-topic-amlogic-arm32-upstream-bindings-fixes-v1-0-feaabb45916b@linaro.org>
References: <20240911-topic-amlogic-arm32-upstream-bindings-fixes-v1-0-feaabb45916b@linaro.org>
Message-Id: <172606224585.90829.12080764539678935748.robh@kernel.org>
Subject: Re: [PATCH 0/7] ARM: dts: amlogic: first easy dtbs fixes


On Wed, 11 Sep 2024 12:19:39 +0200, Neil Armstrong wrote:
> This is the easy fixes to start and fully document the ARM Amlogic
> Device Trees, remaining work includes:
> - ethmac with required phy-mode/clocks/clock-names
> - amlogic,meson-hhi-sysctrl
> - amlogic,meson8-clkc
> - pinctrl: Unevaluated properties are not allowed ('reg', 'reg' were unexpected)
> - bank@80b0:gpio-line-names is too short
> - realtek,rt5640
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
> Neil Armstrong (7):
>       ARM: dts: amlogic: meson6: fix clk81 node name
>       ARM: dts: amlogic: meson8: fix soc thermal-zone node name
>       ARM: dts: amlogic: meson8: fix ao_arc_sram node name
>       ARM: dts: amlogic: meson6: delete undocumented nodes
>       ARM: dts: amlogic: meson8b-odroidc1: fix invalid reset-gpio
>       ARM: dts: amlogic: fix /memory node name
>       ARM: dts: amlogic: meson8: use correct pinctrl bank node name
> 
>  arch/arm/boot/dts/amlogic/meson6-atv1200.dts      |  2 +-
>  arch/arm/boot/dts/amlogic/meson6.dtsi             | 18 +++++++++++++++++-
>  arch/arm/boot/dts/amlogic/meson8-minix-neo-x8.dts |  2 +-
>  arch/arm/boot/dts/amlogic/meson8.dtsi             |  8 ++++----
>  arch/arm/boot/dts/amlogic/meson8b-ec100.dts       |  2 +-
>  arch/arm/boot/dts/amlogic/meson8b-mxq.dts         |  2 +-
>  arch/arm/boot/dts/amlogic/meson8b-odroidc1.dts    |  4 ++--
>  arch/arm/boot/dts/amlogic/meson8b.dtsi            |  8 ++++----
>  arch/arm/boot/dts/amlogic/meson8m2-mxiii-plus.dts |  2 +-
>  9 files changed, 32 insertions(+), 16 deletions(-)
> ---
> base-commit: 100cc857359b5d731407d1038f7e76cd0e871d94
> change-id: 20240911-topic-amlogic-arm32-upstream-bindings-fixes-69d624b8bccd
> 
> Best regards,
> --
> Neil Armstrong <neil.armstrong@linaro.org>
> 
> 
> 


My bot found new DTB warnings on the .dts files added or changed in this
series.

Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
are fixed by another series. Ultimately, it is up to the platform
maintainer whether these warnings are acceptable or not. No need to reply
unless the platform maintainer has comments.

If you already ran DT checks and didn't see these error(s), then
make sure dt-schema is up to date:

  pip3 install dtschema --upgrade


New warnings running 'make CHECK_DTBS=y amlogic/meson6-atv1200.dtb amlogic/meson8-minix-neo-x8.dtb amlogic/meson8b-ec100.dtb amlogic/meson8b-mxq.dtb amlogic/meson8b-odroidc1.dtb amlogic/meson8m2-mxiii-plus.dtb' for 20240911-topic-amlogic-arm32-upstream-bindings-fixes-v1-0-feaabb45916b@linaro.org:

arch/arm/boot/dts/amlogic/meson8b-mxq.dtb: pinctrl@9880: Unevaluated properties are not valid under the given schema ('reg', 'reg' were unevaluated and invalid)
	from schema $id: http://devicetree.org/schemas/pinctrl/amlogic,meson8-pinctrl-cbus.yaml#
arch/arm/boot/dts/amlogic/meson8b-odroidc1.dtb: pinctrl@9880: bank@80b0: Unevaluated properties are not allowed ('gpio-line-names' was unexpected)
	from schema $id: http://devicetree.org/schemas/pinctrl/amlogic,meson8-pinctrl-cbus.yaml#
arch/arm/boot/dts/amlogic/meson8b-odroidc1.dtb: pinctrl@9880: bank@80b0:gpio-line-names: ['J2 Header Pin 35', 'J2 Header Pin 36', 'J2 Header Pin 32', 'J2 Header Pin 31', 'J2 Header Pin 29', 'J2 Header Pin 18', 'J2 Header Pin 22', 'J2 Header Pin 16', 'J2 Header Pin 23', 'J2 Header Pin 21', 'J2 Header Pin 19', 'J2 Header Pin 33', 'J2 Header Pin 8', 'J2 Header Pin 10', 'J2 Header Pin 15', 'J2 Header Pin 13', 'J2 Header Pin 24', 'J2 Header Pin 26', 'Revision (upper)', 'Revision (lower)', 'J2 Header Pin 7', '', 'J2 Header Pin 12', 'J2 Header Pin 11', '', '', '', 'TFLASH_VDD_EN', '', '', 'VCCK_PWM (PWM_C)', 'I2CA_SDA', 'I2CA_SCL', 'I2CB_SDA', 'I2CB_SCL', 'VDDEE_PWM (PWM_D)', '', 'HDMI_HPD', 'HDMI_I2C_SDA', 'HDMI_I2C_SCL', 'ETH_PHY_INTR', 'ETH_PHY_NRST', 'ETH_TXD1', 'ETH_TXD0', 'ETH_TXD3', 'ETH_TXD2', 'ETH_RGMII_TX_CLK', 'SD_DATA1 (SDB_D1)', 'SD_DATA0 (SDB_D0)', 'SD_CLK', 'SD_CMD', 'SD_DATA3 (SDB_D3)', 'SD_DATA2 (SDB_D2)', 'SD_CDN (SD_DET_N)', 'SDC_D0 (EMMC)', 'SDC_D1 (EMMC)', 'SDC_D2 (EMMC
 )', 'SDC_D3 (EMMC)', 'SDC_D4 (EMMC)', 'SDC_D5 (EMMC)', 'SDC_D6 (EMMC)', 'SDC_D7 (EMMC)', 'SDC_CLK (EMMC)', 'SDC_RSTn (EMMC)', 'SDC_CMD (EMMC)', 'BOOT_SEL', '', '', '', '', '', '', '', 'ETH_RXD1', 'ETH_RXD0', 'ETH_RX_DV', 'RGMII_RX_CLK', 'ETH_RXD3', 'ETH_RXD2', 'ETH_TXEN', 'ETH_PHY_REF_CLK_25MOUT', 'ETH_MDC', 'ETH_MDIO'] is too short
	from schema $id: http://devicetree.org/schemas/pinctrl/amlogic,meson8-pinctrl-cbus.yaml#
arch/arm/boot/dts/amlogic/meson8-minix-neo-x8.dtb: pinctrl@9880: Unevaluated properties are not valid under the given schema ('reg', 'reg' were unevaluated and invalid)
	from schema $id: http://devicetree.org/schemas/pinctrl/amlogic,meson8-pinctrl-cbus.yaml#
arch/arm/boot/dts/amlogic/meson8b-odroidc1.dtb: pinctrl@9880: Unevaluated properties are not valid under the given schema ('reg', 'reg' were unevaluated and invalid)
	from schema $id: http://devicetree.org/schemas/pinctrl/amlogic,meson8-pinctrl-cbus.yaml#
arch/arm/boot/dts/amlogic/meson8m2-mxiii-plus.dtb: pinctrl@9880: Unevaluated properties are not valid under the given schema ('reg', 'reg' were unevaluated and invalid)
	from schema $id: http://devicetree.org/schemas/pinctrl/amlogic,meson8-pinctrl-cbus.yaml#
arch/arm/boot/dts/amlogic/meson8b-ec100.dtb: pinctrl@9880: bank@80b0: Unevaluated properties are not allowed ('gpio-line-names' was unexpected)
	from schema $id: http://devicetree.org/schemas/pinctrl/amlogic,meson8-pinctrl-cbus.yaml#
arch/arm/boot/dts/amlogic/meson8b-ec100.dtb: pinctrl@9880: bank@80b0:gpio-line-names: ['WIFI_SD_D0', 'WIFI_SD_D1', 'WIFI_SD_D2', 'WIFI_SD_D3', 'BTPCM_DOUT', 'BTPCM_DIN', 'BTPCM_SYNC', 'BTPCM_CLK', 'WIFI_SD_CLK', 'WIFI_SD_CMD', 'WIFI_32K', 'WIFI_PWREN', 'UART_B_TX', 'UART_B_RX', 'UART_B_CTS_N', 'UART_B_RTS_N', 'BT_EN', 'WIFI_WAKE_HOST', '', '', '', '', '', '', '', '', '', '', '', '', 'VCCK_PWM_C', 'I2C_SDA_A', 'I2C_SCL_A', 'I2C_SDA_B', 'I2C_SCL_B', 'VDDEE_PWM_D', 'VDDEE_PWM 3V3_5V_EN', 'HDMI_HPD', 'HDMI_I2C_SDA', 'HDMI_I2C_SCL', 'RMII_IRQ', 'RMII_RST#', 'RMII_TXD1', 'RMII_TXD0', 'AV_select_1', 'AV_select_2', 'MCU_Control_S', 'SD_D1_B', 'SD_D0_B', 'SD_CLK_8726MX', 'SD_CMD_8726MX', 'SD_D3_B', 'SD_D2_B', 'CARD_EN_DET (CARD_DET)', 'NAND_D0 (EMMC)', 'NAND_D1 (EMMC)', 'NAND_D2 (EMMC)', 'NAND_D3 (EMMC)', 'NAND_D4 (EMMC)', 'NAND_D5 (EMMC)', 'NAND_D6 (EMMC)', 'NAND_D7 (EMMC)', 'NAND_CS1 (EMMC)', 'NAND_CS2 iNAND_RS1 (EMMC)', 'NAND_nR/B iNAND_CMD (EMMC)', 'NAND_ALE (EMMC)', 'NAND_CLE (EMMC)', 'n
 RE_S1 NAND_nRE (EMMC)', 'nWE_S1 NAND_nWE (EMMC)', '', '', 'SPI_CS', 'RMII_RXD1', 'RMII_RXD0', 'RMII_CRS_DV', 'RMII_50M_IN', 'GPIODIF_4', 'GPIODIF_5', 'RMII_TXEN', 'CPUETH_25MOUT', 'RMII_MDC', 'RMII_MDIO'] is too short
	from schema $id: http://devicetree.org/schemas/pinctrl/amlogic,meson8-pinctrl-cbus.yaml#
arch/arm/boot/dts/amlogic/meson8b-ec100.dtb: pinctrl@9880: Unevaluated properties are not valid under the given schema ('reg', 'reg' were unevaluated and invalid)
	from schema $id: http://devicetree.org/schemas/pinctrl/amlogic,meson8-pinctrl-cbus.yaml#
arch/arm/boot/dts/amlogic/meson8b-mxq.dtb: pinctrl@84: Unevaluated properties are not valid under the given schema ('reg', 'reg' were unevaluated and invalid)
	from schema $id: http://devicetree.org/schemas/pinctrl/amlogic,meson8-pinctrl-aobus.yaml#
arch/arm/boot/dts/amlogic/meson8b-odroidc1.dtb: pinctrl@84: Unevaluated properties are not valid under the given schema ('reg', 'reg' were unevaluated and invalid)
	from schema $id: http://devicetree.org/schemas/pinctrl/amlogic,meson8-pinctrl-aobus.yaml#
arch/arm/boot/dts/amlogic/meson8b-ec100.dtb: pinctrl@84: Unevaluated properties are not valid under the given schema ('reg', 'reg' were unevaluated and invalid)
	from schema $id: http://devicetree.org/schemas/pinctrl/amlogic,meson8-pinctrl-aobus.yaml#
arch/arm/boot/dts/amlogic/meson8-minix-neo-x8.dtb: pinctrl@84: Unevaluated properties are not valid under the given schema ('reg', 'reg' were unevaluated and invalid)
	from schema $id: http://devicetree.org/schemas/pinctrl/amlogic,meson8-pinctrl-aobus.yaml#
arch/arm/boot/dts/amlogic/meson8m2-mxiii-plus.dtb: pinctrl@84: Unevaluated properties are not valid under the given schema ('reg', 'reg' were unevaluated and invalid)
	from schema $id: http://devicetree.org/schemas/pinctrl/amlogic,meson8-pinctrl-aobus.yaml#






