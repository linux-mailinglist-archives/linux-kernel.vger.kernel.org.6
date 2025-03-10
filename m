Return-Path: <linux-kernel+bounces-554675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4797CA59B45
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 17:40:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FE843A78B7
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 16:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81C8323237B;
	Mon, 10 Mar 2025 16:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Ctxr40Tz"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB97230BE8;
	Mon, 10 Mar 2025 16:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741624811; cv=none; b=XJz1f5tV/Ik9z8ANeR1Hrv1orQ402WLLcRvNY9HcjKx8RnwBPkgqs+nVlFe8Vc3UrGH7i1ZPE47RdqoT1HDXuwcM/dAjlM+GPOa1Du3Ylb4L2JCvXeUQh6OsTJ89Wu+Kd2jCieoVSTHnoQ8VhkBEzJXjCYJrljR7VqAMmdck2Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741624811; c=relaxed/simple;
	bh=jG2AhQ8rfFnaTwya10N47DF4WYRctsn28OpF3DNfM1U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GLKh3/CzRxwec19vm6qDRoMdnGWvVfqXhLWOcLUSD+ibanYz7mUYC95saW4Z1wly534MrgBCM4zdRABaZOlW9G/ITEIbUerF8gPNfChvpTCg3nLpLegG0B2EYhV8TBLY8Nn+YPkzfLnn/japDbrT/JVhaetsuCu0qNBmekUtB8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Ctxr40Tz; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D8E2944430;
	Mon, 10 Mar 2025 16:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1741624807;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a+jhmNSWGtF6gwCaOphrzoK/yfH+/FtGdxKL5Im1AWA=;
	b=Ctxr40TztXSUsyl12pTNFDb1xb3FyY//+PeF5GfStZyzF4XtM4a+4FfX6Ud3r24dSgsdQO
	6C7EEdHxb2T0Jz6zwPpXlZIYpSCpXweYR2iSTz2RmdFFTPrmIm0/a5hcIwcNjgLmvV8aGl
	aHDh2YbJQcW1O45QCaVUeYKrYuyDsTyrRyhO3RwpV7Tog7eN7+PJr1GG5u/8wuNVLIjOEY
	jEUWO7PUhblawju9gFRmqfuLSP+eAXl1/qAliHvzC2fEp5DPKvagerGnkuUidRqsXbtAbm
	A4jXTIMHO+x8Frp3bG1h2ri9pJt3j+8LV5mghDMPK5gFty/wJbvy7Vbp0mrKKA==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Mon, 10 Mar 2025 17:39:49 +0100
Subject: [PATCH v4 2/3] ARM: dts: imx6ul: Add Variscite VAR-SOM-MX6UL SoM
 support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250310-varsom6ul-concerto-dts-v4-2-6034fda6ec64@bootlin.com>
References: <20250310-varsom6ul-concerto-dts-v4-0-6034fda6ec64@bootlin.com>
In-Reply-To: <20250310-varsom6ul-concerto-dts-v4-0-6034fda6ec64@bootlin.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7899;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=jG2AhQ8rfFnaTwya10N47DF4WYRctsn28OpF3DNfM1U=;
 b=kA0DAAgB0YBBQCmjqDYByyZiAGfPFeWhE88pX5S2aqICactDuiuZq77zkE/zX8QF1d9WH5Zvb
 4kCMwQAAQgAHRYhBIZIclGI3UAbuaDT/9GAQUApo6g2BQJnzxXlAAoJENGAQUApo6g2vFoP/iNM
 j5qShed0pMKax1FlHwK2gPZ3ZmMovvDLVhFAOIsW38prJSXpe9xrk4EZXfQ200TARIL/3Fnt6Dw
 oVX/YS3hxa8pTWEWxltAaOJsQyGUFt/mMTILgPk2dUJitj3wmyd9p6cyZLNemBsG0xl/1fHmR2K
 fpKrtl2y/z0O0/cf3CWMsdf272lUAvjyNTPeCfwcbsRtklNyLZtrO+/ZsABMLWtYf/d1RvaRSso
 nPwM6f00W4sVPGormnmsqtwPd1xdSBDUGLV6ihmQ5aX6tnbAgL3kq6tBkMGI/FDsIq/ba8t2xzO
 7+MqvspaWSXCsyL0ZDFXcRhs9qXKgVkgTgWjB5kwomp8zFiRla0C8IfkufXWTGThh3QZeiYayk+
 8Yevr/Yo/lW15fANkdqGjoUR+MaJh4uWoELJWyqL3ng7JVjdKEEcQmdSNq0cs3ipvQviF9qUKTa
 xmukhkeOI2jQ7Oc3Shjizj9GOAoJIFSNGCmJLEycU5QEQRubM/zHTE7ASIzX9pYXiUhoVc0ivAe
 +hRaJmJMGPdC1TW3vUj6wCepADC9y782TiIWaW2ryhl6UcFPlduWRNX9wUNLjXPP5+WdCtpGN58
 FJ3nXYKyqub8ZNi+xlQ6TYCHyr4ai9BQcoGif+dXX53bNncqBNXjnl0dTrId+ND7BWC5feB4isz
 VJWrc
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduudelkeeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthekredtredtjeenucfhrhhomheptehnthhonhhinhcuifhouggrrhguuceorghnthhonhhinhdrghhouggrrhgusegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpefhvdetuefghfeugfeutdeuueettdffudefgfeljeehvdetvefhjeffvdetvdehhfenucffohhmrghinhepvhgrrhhishgtihhtvgdrtghomhenucfkphepvdgrtddumegtsgdugeemheehieemjegrtddtmeejtgehtgemiegruggvmeejleegkeemgedtheelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgdugeemheehieemjegrtddtmeejtgehtgemiegruggvmeejleegkeemgedtheelpdhhvghloheplgduvdejrddtrddurddungdpmhgrihhlfhhrohhmpegrnhhtohhnihhnrdhgohgurghrugessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepudefpdhrtghpthhtoheptghonhhorhdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrhiikhdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehrohgshheskhgvrhhnvghlr
 dhorhhgpdhrtghpthhtohepfhgvshhtvghvrghmsehgmhgrihhlrdgtohhmpdhrtghpthhtohepihhmgieslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopehshhgrfihnghhuoheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghnthhonhhinhdrghhouggrrhgusegsohhothhlihhnrdgtohhmpdhrtghpthhtohepthhhohhmrghsrdhpvghtrgiiiihonhhisegsohhothhlihhnrdgtohhm
X-GND-Sasl: antonin.godard@bootlin.com

Add support for the Variscite VAR_SOM-MX6UL SoM with:

- NXP i.MX6 UltraLite SoC
- 128–1024 MB DDR3L
- 8–128 GB eMMC
- 128–512 MB SLC NAND
- Camera Interface
- LVDS / Parallel RGB interfaces (not configured)
- Touch controller (not configured)
- Ethernet RMII interface (not configured)
- On-SoM Wi-Fi/Bluetooth with CYW43353 on SDIO Module (not configured)
- SD/MMC/SDIO interface
- USB Host + USB OTG interface
- I2C interfaces
- SPI interfaces
- PCI-Express 2.0 interface
- on-SoM Audio Codec (not configured)
- S/PDIF interface (not configured)

Product website: https://www.variscite.com/product/system-on-module-som/cortex-a7/var-som-6ul-nxp-imx6ul-6ull-6ulz

Support is handled with a SoM-centric dtsi exporting the default
interfaces along the default pinmuxing to be enabled by the board dts
file.

I tested this on a VAR-SOM-6UL_G2_700C_512R_8N_IT_REV1.3A, which is why
some of the features above are mentioned as "not configured" (I couldn't
test them).

This file is based on the one provided by Variscite on their own kernel,
but adapted for mainline.

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
 arch/arm/boot/dts/nxp/imx/imx6ul-var-som.dtsi | 233 ++++++++++++++++++++++++++
 1 file changed, 233 insertions(+)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6ul-var-som.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ul-var-som.dtsi
new file mode 100644
index 0000000000000000000000000000000000000000..4e536e0252def06a7660c29b7231169e3aa38dba
--- /dev/null
+++ b/arch/arm/boot/dts/nxp/imx/imx6ul-var-som.dtsi
@@ -0,0 +1,233 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Support for Variscite VAR-SOM-MX6UL Module
+ *
+ * Copyright 2019 Variscite Ltd.
+ * Copyright 2025 Bootlin
+ */
+
+/dts-v1/;
+
+#include "imx6ul.dtsi"
+#include <dt-bindings/clock/imx6ul-clock.h>
+#include <dt-bindings/gpio/gpio.h>
+
+/ {
+	model = "Variscite VAR-SOM-MX6UL module";
+	compatible = "variscite,var-som-imx6ul", "fsl,imx6ul";
+
+	memory@80000000 {
+		device_type = "memory";
+		reg = <0x80000000 0x20000000>;
+	};
+
+	reg_gpio_dvfs: reg-gpio-dvfs {
+		compatible = "regulator-gpio";
+		regulator-min-microvolt = <1300000>;
+		regulator-max-microvolt = <1400000>;
+		regulator-name = "gpio_dvfs";
+		regulator-type = "voltage";
+		gpios = <&gpio4 13 GPIO_ACTIVE_HIGH>;
+		states = <1300000 0x1
+			  1400000 0x0>;
+	};
+
+	rmii_ref_clk: rmii-ref-clk {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <25000000>;
+		clock-output-names = "rmii-ref";
+	};
+};
+
+&clks {
+	assigned-clocks = <&clks IMX6UL_CLK_PLL4_AUDIO_DIV>;
+	assigned-clock-rates = <786432000>;
+};
+
+&cpu0 {
+	dc-supply = <&reg_gpio_dvfs>;
+};
+
+&fec1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_enet1>, <&pinctrl_enet1_gpio>, <&pinctrl_enet1_mdio>;
+	phy-mode = "rmii";
+	phy-handle = <&ethphy0>;
+	status = "okay";
+
+	mdio {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		ethphy0: ethernet-phy@1 {
+			compatible = "ethernet-phy-ieee802.3-c22";
+			reg = <1>;
+			clocks = <&rmii_ref_clk>;
+			clock-names = "rmii-ref";
+			reset-gpios = <&gpio5 0 GPIO_ACTIVE_LOW>;
+			reset-assert-us = <100000>;
+			micrel,led-mode = <1>;
+			micrel,rmii-reference-clock-select-25-mhz = <1>;
+		};
+	};
+};
+
+&iomuxc {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_hog>;
+
+	pinctrl_enet1: enet1grp {
+		fsl,pins = <
+			MX6UL_PAD_ENET1_RX_EN__ENET1_RX_EN	0x1b0b0
+			MX6UL_PAD_ENET1_RX_ER__ENET1_RX_ER	0x1b0b0
+			MX6UL_PAD_ENET1_RX_DATA0__ENET1_RDATA00	0x1b0b0
+			MX6UL_PAD_ENET1_RX_DATA1__ENET1_RDATA01	0x1b0b0
+			MX6UL_PAD_ENET1_TX_EN__ENET1_TX_EN	0x1b0b0
+			MX6UL_PAD_ENET1_TX_DATA0__ENET1_TDATA00	0x1b0b0
+			MX6UL_PAD_ENET1_TX_DATA1__ENET1_TDATA01	0x1b0b0
+			MX6UL_PAD_ENET1_TX_CLK__ENET1_REF_CLK1	0x4001b031
+		>;
+	};
+
+	pinctrl_enet1_gpio: enet1-gpiogrp {
+		fsl,pins = <
+			MX6UL_PAD_SNVS_TAMPER0__GPIO5_IO00	0x1b0b0 /* fec1 reset */
+		>;
+	};
+
+	pinctrl_enet1_mdio: enet1-mdiogrp {
+		fsl,pins = <
+			MX6UL_PAD_GPIO1_IO06__ENET1_MDIO	0x1b0b0
+			MX6UL_PAD_GPIO1_IO07__ENET1_MDC		0x1b0b0
+		>;
+	};
+
+	pinctrl_hog: hoggrp {
+		fsl,pins = <
+			MX6UL_PAD_SNVS_TAMPER4__GPIO5_IO04	0x1b0b0	/* BT Enable */
+			MX6UL_PAD_SNVS_TAMPER6__GPIO5_IO06	0x03029	/* WLAN Enable */
+		>;
+	};
+
+	pinctrl_sai2: sai2grp {
+		fsl,pins = <
+			MX6UL_PAD_JTAG_TDI__SAI2_TX_BCLK	0x17088
+			MX6UL_PAD_JTAG_TDO__SAI2_TX_SYNC	0x17088
+			MX6UL_PAD_JTAG_TRST_B__SAI2_TX_DATA	0x11088
+			MX6UL_PAD_JTAG_TCK__SAI2_RX_DATA	0x11088
+			MX6UL_PAD_JTAG_TMS__SAI2_MCLK		0x17088
+		>;
+	};
+
+	pinctrl_tsc: tscgrp {
+		fsl,pins = <
+			MX6UL_PAD_GPIO1_IO01__GPIO1_IO01	0xb0
+			MX6UL_PAD_GPIO1_IO02__GPIO1_IO02	0xb0
+			MX6UL_PAD_GPIO1_IO03__GPIO1_IO03	0xb0
+			MX6UL_PAD_GPIO1_IO04__GPIO1_IO04	0xb0
+		>;
+	};
+
+	pinctrl_uart2: uart2grp {
+		fsl,pins = <
+			MX6UL_PAD_UART2_TX_DATA__UART2_DCE_TX	0x1b0b1
+			MX6UL_PAD_UART2_RX_DATA__UART2_DCE_RX	0x1b0b1
+			MX6UL_PAD_UART2_CTS_B__UART2_DCE_CTS	0x1b0b1
+			MX6UL_PAD_UART2_RTS_B__UART2_DCE_RTS	0x1b0b1
+		>;
+	};
+
+	pinctrl_usdhc2: usdhc2grp {
+		fsl,pins = <
+			MX6UL_PAD_NAND_RE_B__USDHC2_CLK		0x10069
+			MX6UL_PAD_NAND_WE_B__USDHC2_CMD		0x17059
+			MX6UL_PAD_NAND_DATA00__USDHC2_DATA0	0x17059
+			MX6UL_PAD_NAND_DATA01__USDHC2_DATA1	0x17059
+			MX6UL_PAD_NAND_DATA02__USDHC2_DATA2	0x17059
+			MX6UL_PAD_NAND_DATA03__USDHC2_DATA3	0x17059
+			MX6UL_PAD_NAND_DATA04__USDHC2_DATA4	0x17059
+			MX6UL_PAD_NAND_DATA05__USDHC2_DATA5	0x17059
+			MX6UL_PAD_NAND_DATA06__USDHC2_DATA6	0x17059
+			MX6UL_PAD_NAND_DATA07__USDHC2_DATA7	0x17059
+		>;
+	};
+
+	pinctrl_usdhc2_100mhz: usdhc2-100mhzgrp {
+		fsl,pins = <
+			MX6UL_PAD_NAND_RE_B__USDHC2_CLK		0x100b9
+			MX6UL_PAD_NAND_WE_B__USDHC2_CMD		0x170b9
+			MX6UL_PAD_NAND_DATA00__USDHC2_DATA0	0x170b9
+			MX6UL_PAD_NAND_DATA01__USDHC2_DATA1	0x170b9
+			MX6UL_PAD_NAND_DATA02__USDHC2_DATA2	0x170b9
+			MX6UL_PAD_NAND_DATA03__USDHC2_DATA3	0x170b9
+			MX6UL_PAD_NAND_DATA04__USDHC2_DATA4	0x170b9
+			MX6UL_PAD_NAND_DATA05__USDHC2_DATA5	0x170b9
+			MX6UL_PAD_NAND_DATA06__USDHC2_DATA6	0x170b9
+			MX6UL_PAD_NAND_DATA07__USDHC2_DATA7	0x170b9
+		>;
+	};
+
+	pinctrl_usdhc2_200mhz: usdhc2-200mhzgrp {
+		fsl,pins = <
+			MX6UL_PAD_NAND_RE_B__USDHC2_CLK		0x100f9
+			MX6UL_PAD_NAND_WE_B__USDHC2_CMD		0x170f9
+			MX6UL_PAD_NAND_DATA00__USDHC2_DATA0	0x170f9
+			MX6UL_PAD_NAND_DATA01__USDHC2_DATA1	0x170f9
+			MX6UL_PAD_NAND_DATA02__USDHC2_DATA2	0x170f9
+			MX6UL_PAD_NAND_DATA03__USDHC2_DATA3	0x170f9
+			MX6UL_PAD_NAND_DATA04__USDHC2_DATA4	0x170f9
+			MX6UL_PAD_NAND_DATA05__USDHC2_DATA5	0x170f9
+			MX6UL_PAD_NAND_DATA06__USDHC2_DATA6	0x170f9
+			MX6UL_PAD_NAND_DATA07__USDHC2_DATA7	0x170f9
+		>;
+	};
+};
+
+&pxp {
+	status = "okay";
+};
+
+&sai2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_sai2>;
+	assigned-clocks = <&clks IMX6UL_CLK_SAI2_SEL>,
+			  <&clks IMX6UL_CLK_SAI2>;
+	assigned-clock-parents = <&clks IMX6UL_CLK_PLL4_AUDIO_DIV>;
+	assigned-clock-rates = <0>, <12288000>;
+	fsl,sai-mclk-direction-output;
+	status = "okay";
+};
+
+&snvs_poweroff {
+	status = "okay";
+};
+
+&tsc {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_tsc>;
+	xnur-gpios = <&gpio1 3 GPIO_ACTIVE_LOW>;
+	measure-delay-time = <0xffff>;
+	pre-charge-time = <0xfff>;
+	status = "okay";
+};
+
+&uart2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart2>;
+	uart-has-rtscts;
+	status = "okay";
+};
+
+&usdhc2 {
+	pinctrl-names = "default", "state_100mhz", "state_200mhz";
+	pinctrl-0 = <&pinctrl_usdhc2>;
+	pinctrl-1 = <&pinctrl_usdhc2_100mhz>;
+	pinctrl-2 = <&pinctrl_usdhc2_200mhz>;
+	bus-width = <8>;
+	no-1-8-v;
+	non-removable;
+	keep-power-in-suspend;
+	wakeup-source;
+	status = "okay";
+};

-- 
2.47.0


