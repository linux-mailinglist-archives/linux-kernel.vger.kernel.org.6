Return-Path: <linux-kernel+bounces-554616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79F45A59A80
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 16:57:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 408261666CC
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 15:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DF9622FF2F;
	Mon, 10 Mar 2025 15:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="JOjpWx5p"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC741B3934;
	Mon, 10 Mar 2025 15:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741622233; cv=none; b=gnRgbUTn8ZWqtkdGsWiIzQKUsrom3+a5gQ+P1eA8EY5aYPPqFKC2UQU8wjgy6116rbNfuQkwHgWVX82r+PmM2jdF3l6mHZgQTQehywXEu6grQq5TeIOJUJzI81edIDMCzBprFwqFMbqdy/v111KfBGBLWgqJOLl4ovDC2qsm9NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741622233; c=relaxed/simple;
	bh=MgCdjpVn5JjBH9Q7mqPRM+D+GIItbuUSnEVe5WROEq4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aSS9XDyGrgk08UG4EO8CaDZJwuYrLE2Ui4sajIwOzhb6M/q4Ud0XxV4RPQZkrWmIGj0CCQr1h0dlOz5NrraemLyyWlohKGa43TBDCoQrEVILb8x378oiUIZ8w0qAjBnCq/YlASUQw7l1xUIVAcGirTrFuyOTt39ruipgrLmBunU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=JOjpWx5p; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7A740441BC;
	Mon, 10 Mar 2025 15:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1741622229;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A5Z5zPAM+0f74IQVMyMnuPc/AXbhtFbg6j2IA+SJm9I=;
	b=JOjpWx5pK4JZM/gmtnma9Fd+4RWYpYmrpI7loThL2w/eu9D07CZtoUYSSABX5Njc+4NfzU
	FTd49DDXOvINZ6u5rZuG2U5Ep+MHTGGy0CgHECpqf4aScmQqExYEImIiJQlLkbWY+ck4Fv
	P2tWElMMB/ISWnhlgumdzg3ovUoc6rNgwSPXC9mZuKmGFPV9P8bATTrEVwFq81H9bLm75q
	cnVJ+Mu6pwTXK1dEAgIAIit08ggt/76isx6gyaZNvFNlmzkVXIUyw6NNaB6la3B/YjtSpp
	mY0LEGIVEO29P1npHruVXCyPydeg1+xTX/C8vOv1SyzLBdvSr8lze7dJ4X9h6g==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Mon, 10 Mar 2025 16:56:09 +0100
Subject: [PATCH v3 3/3] ARM: dts: imx6ul: Add Variscite Concerto board
 support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250310-varsom6ul-concerto-dts-v3-3-551e60713523@bootlin.com>
References: <20250310-varsom6ul-concerto-dts-v3-0-551e60713523@bootlin.com>
In-Reply-To: <20250310-varsom6ul-concerto-dts-v3-0-551e60713523@bootlin.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=9091;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=MgCdjpVn5JjBH9Q7mqPRM+D+GIItbuUSnEVe5WROEq4=;
 b=owEBbQKS/ZANAwAIAdGAQUApo6g2AcsmYgBnzwvS9pnIy+Nmty70GKu5BsHxlJt9AXpuDa+MJ
 CmkXp9OSxGJAjMEAAEIAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCZ88L0gAKCRDRgEFAKaOo
 Nu8QD/9L3pQ34PqLB5C/Zo5iJLxy1OjdY9cFZO3QEw0WSioOu+vLO3NE0/DjYr/hczUSLMyhJ8J
 RC8GddvanpuXdcnknKh4nMF3UzW+Dc8RvtgGjlqPmwQ7jvW+mZP8Xt+wRegAPkROyOc4aCTt3Lt
 PzLV1rAx8XZyOSIQJ8zivynobIYkD9YNo5w1NYjS5jr6PiO9RrH9vhPP44ZBIDcMqYnOkUZJVlf
 WcD3C19xgexuS+N1xkRO4B+llQBB8CEp2/nO2nXCPH0rCt6N5tVVbnMx6OMlwsU7NgMbery1LnD
 ju7qh/GdZM3mMUr8W6Xxpr6BppXJVKvO36yBSNPTcpUhPbFHQZmA+1uEnafKnTanei4stlvC+1t
 Qy1/eGMV5poEUfsfgUT5B7aL4hYmVmDBP5yY8Wli6+mxLuxIkQAX+RvFWqa5paB28r7wzSdMElZ
 2OrIH64X5EAJ1v0spyT0ST8dpkd07SBKL4AL0+Hh2avGu6BUEsDtVig5VNcm0vKhKvhUFe7GcH1
 Ssp19NePpz13137z3mDhtLibit8olSVNH9bpyMDEYnlH4jKCdOMr+4eY0FEJTSPAstycl2yqxji
 qDCAPXf+4Xs60bjSgp+mo6hGtOc3EzKeUUN+1Zs59HpkDwJsJT49VsUdtZRiDzdP1qaHeUJuWbU
 qOTC1rbHO0YVyUg==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduudeljeejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheptehnthhonhhinhcuifhouggrrhguuceorghnthhonhhinhdrghhouggrrhgusegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeekgeekvdduvdetheetgeefgfeljeevgfegkeduheeutdevvddtfedvveettddtvdenucffohhmrghinhepvhgrrhhishgtihhtvgdrtghomhenucfkphepvdgrtddumegtsgdugeemheehieemjegrtddtmeejtgehtgemiegruggvmeejleegkeemgedtheelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgdugeemheehieemjegrtddtmeejtgehtgemiegruggvmeejleegkeemgedtheelpdhhvghloheplgduvdejrddtrddurddungdpmhgrihhlfhhrohhmpegrnhhtohhnihhnrdhgohgurghrugessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepudefpdhrtghpthhtohepihhmgieslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopehlihhnuhigqdgrrhhmqdhkvghrnhgvlheslhhishhtshdrihhnfhhrrgguvggrugdrohhrghdpr
 hgtphhtthhopehfvghsthgvvhgrmhesghhmrghilhdrtghomhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegrnhhtohhnihhnrdhgohgurghrugessghoohhtlhhinhdrtghomhdprhgtphhtthhopehsrdhhrghuvghrsehpvghnghhuthhrohhnihigrdguvgdprhgtphhtthhopegtohhnohhrodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhriihkodgutheskhgvrhhnvghlrdhorhhg
X-GND-Sasl: antonin.godard@bootlin.com

Add support for the Variscite Concerto Carrier Board with:

- LVDS interface for the VLCD-CAP-GLD-LVDS 7" LCD 800 x 480 touch
  display (not configured)
- USB Host + USB OTG Connector
- 10/100 Mbps Ethernet
- miniPCI-Express slot
- SD Card connector
- Audio Headphone/Line In jack connectors
- S-ATA
- On-board DMIC

Product Page: https://www.variscite.com/product/single-board-computers/concerto-board

This file is based on the one provided by Variscite on their own kernel,
but adapted for mainline.

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
 arch/arm/boot/dts/nxp/imx/Makefile                 |   1 +
 .../boot/dts/nxp/imx/imx6ul-var-som-concerto.dts   | 320 +++++++++++++++++++++
 2 files changed, 321 insertions(+)

diff --git a/arch/arm/boot/dts/nxp/imx/Makefile b/arch/arm/boot/dts/nxp/imx/Makefile
index 39a153536d2a2b8f75b5fbe4332660f89442064a..94c9bc94cc8e2daa1fb3b5686b0b58db1f6678b6 100644
--- a/arch/arm/boot/dts/nxp/imx/Makefile
+++ b/arch/arm/boot/dts/nxp/imx/Makefile
@@ -329,6 +329,7 @@ dtb-$(CONFIG_SOC_IMX6UL) += \
 	imx6ul-tx6ul-0010.dtb \
 	imx6ul-tx6ul-0011.dtb \
 	imx6ul-tx6ul-mainboard.dtb \
+	imx6ul-var-som-concerto.dtb \
 	imx6ull-14x14-evk.dtb \
 	imx6ull-colibri-aster.dtb \
 	imx6ull-colibri-emmc-aster.dtb \
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ul-var-som-concerto.dts b/arch/arm/boot/dts/nxp/imx/imx6ul-var-som-concerto.dts
new file mode 100644
index 0000000000000000000000000000000000000000..9ff3b374a2b31ceb7c4974adf86c2f036c78d4d5
--- /dev/null
+++ b/arch/arm/boot/dts/nxp/imx/imx6ul-var-som-concerto.dts
@@ -0,0 +1,320 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Support for Variscite MX6 Concerto Carrier board with the VAR-SOM-MX6UL
+ * Variscite SoM mounted on it
+ *
+ * Copyright 2019 Variscite Ltd.
+ * Copyright 2025 Bootlin
+ */
+
+#include "imx6ul-var-som.dtsi"
+#include <dt-bindings/leds/common.h>
+
+/ {
+	model = "Variscite VAR-SOM-MX6UL Concerto Board";
+	compatible = "variscite,mx6ulconcerto", "variscite,var-som-imx6ul", "fsl,imx6ul";
+
+	chosen {
+		stdout-path = &uart1;
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_gpio_key_back>, <&pinctrl_gpio_key_wakeup>;
+
+		key-back {
+			gpios = <&gpio4 14 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_BACK>;
+		};
+
+		key-wakeup {
+			gpios = <&gpio5 8 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_WAKEUP>;
+			wakeup-source;
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_gpio_leds>;
+
+		led-0 {
+			function = LED_FUNCTION_STATUS;
+			color = <LED_COLOR_ID_GREEN>;
+			label = "gpled2";
+			gpios = <&gpio1 25 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "heartbeat";
+		};
+	};
+};
+
+&can1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_flexcan1>;
+	status = "okay";
+};
+
+&fec1 {
+	status = "disabled";
+};
+
+&fec2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_enet2>, <&pinctrl_enet2_gpio>, <&pinctrl_enet2_mdio>;
+	phy-mode = "rmii";
+	phy-handle = <&ethphy1>;
+	status = "okay";
+
+	mdio {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		ethphy1: ethernet-phy@3 {
+			compatible = "ethernet-phy-ieee802.3-c22";
+			reg = <3>;
+			clocks = <&rmii_ref_clk>;
+			clock-names = "rmii-ref";
+			reset-gpios = <&gpio5 5 GPIO_ACTIVE_LOW>;
+			reset-assert-us = <100000>;
+			micrel,led-mode = <0>;
+			micrel,rmii-reference-clock-select-25-mhz = <1>;
+		};
+	};
+};
+
+&i2c1 {
+	clock-frequency = <100000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c1>;
+	status = "okay";
+
+	rtc@68 {
+		/*
+		 * To actually use this interrupt
+		 * connect pins J14.8 & J14.10 on the Concerto-Board.
+		 */
+		compatible = "dallas,ds1337";
+		reg = <0x68>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_rtc>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <10 IRQ_TYPE_EDGE_FALLING>;
+	};
+};
+
+&iomuxc {
+	pinctrl_enet2: enet2grp {
+		fsl,pins = <
+			MX6UL_PAD_ENET2_RX_EN__ENET2_RX_EN	0x1b0b0
+			MX6UL_PAD_ENET2_RX_ER__ENET2_RX_ER	0x1b0b0
+			MX6UL_PAD_ENET2_RX_DATA0__ENET2_RDATA00	0x1b0b0
+			MX6UL_PAD_ENET2_RX_DATA1__ENET2_RDATA01	0x1b0b0
+			MX6UL_PAD_ENET2_TX_EN__ENET2_TX_EN	0x1b0b0
+			MX6UL_PAD_ENET2_TX_DATA0__ENET2_TDATA00	0x1b0b0
+			MX6UL_PAD_ENET2_TX_DATA1__ENET2_TDATA01	0x1b0b0
+			MX6UL_PAD_ENET2_TX_CLK__ENET2_REF_CLK2	0x4001b031
+		>;
+	};
+
+	pinctrl_enet2_gpio: enet2-gpiogrp {
+		fsl,pins = <
+			MX6UL_PAD_SNVS_TAMPER5__GPIO5_IO05	0x1b0b0 /* fec2 reset */
+		>;
+	};
+
+	pinctrl_enet2_mdio: enet2-mdiogrp {
+		fsl,pins = <
+			MX6UL_PAD_GPIO1_IO06__ENET2_MDIO	0x1b0b0
+			MX6UL_PAD_GPIO1_IO07__ENET2_MDC		0x1b0b0
+		>;
+	};
+
+	pinctrl_flexcan1: flexcan1grp {
+		fsl,pins = <
+			MX6UL_PAD_UART3_RTS_B__FLEXCAN1_RX	0x1b020
+			MX6UL_PAD_UART3_CTS_B__FLEXCAN1_TX	0x1b020
+		>;
+	};
+
+	pinctrl_gpio_key_back: gpio-key-backgrp {
+		fsl,pins = <
+			MX6UL_PAD_NAND_CE1_B__GPIO4_IO14	0x17059
+		>;
+	};
+
+	pinctrl_gpio_leds: gpio-ledsgrp {
+		fsl,pins = <
+			MX6UL_PAD_UART3_RX_DATA__GPIO1_IO25	0x1b0b0	/* GPLED2 */
+		>;
+	};
+
+	pinctrl_gpio_key_wakeup: gpio-keys-wakeupgrp {
+		fsl,pins = <
+			MX6UL_PAD_SNVS_TAMPER8__GPIO5_IO08	0x17059
+		>;
+	};
+
+	pinctrl_i2c1: i2c1grp {
+		fsl,pins = <
+			MX6UL_PAD_CSI_PIXCLK__I2C1_SCL		0x4001b8b0
+			MX6UL_PAD_CSI_MCLK__I2C1_SDA		0x4001b8b0
+		>;
+	};
+
+	pinctrl_pwm4: pwm4grp {
+		fsl,pins = <
+			MX6UL_PAD_GPIO1_IO05__PWM4_OUT		0x110b0
+		>;
+	};
+
+	pinctrl_rtc: rtcgrp {
+		fsl,pins = <
+			MX6UL_PAD_JTAG_MOD__GPIO1_IO10		0x1b0b0 /* RTC alarm IRQ */
+		>;
+	};
+
+	pinctrl_uart1: uart1grp {
+		fsl,pins = <
+			MX6UL_PAD_UART1_TX_DATA__UART1_DCE_TX	0x1b0b1
+			MX6UL_PAD_UART1_RX_DATA__UART1_DCE_RX	0x1b0b1
+		>;
+	};
+
+	pinctrl_uart5: uart5grp {
+		fsl,pins = <
+			MX6UL_PAD_CSI_DATA00__UART5_DCE_TX	0x1b0b1
+			MX6UL_PAD_CSI_DATA01__UART5_DCE_RX	0x1b0b1
+			MX6UL_PAD_GPIO1_IO09__UART5_DCE_CTS	0x1b0b1
+			MX6UL_PAD_GPIO1_IO08__UART5_DCE_RTS	0x1b0b1
+		>;
+	};
+
+	pinctrl_usb_otg1_id: usbotg1idgrp {
+		fsl,pins = <
+			MX6UL_PAD_UART3_TX_DATA__ANATOP_OTG1_ID	0x17059
+		>;
+	};
+
+	pinctrl_usdhc1: usdhc1grp {
+		fsl,pins = <
+			MX6UL_PAD_SD1_CMD__USDHC1_CMD		0x17059
+			MX6UL_PAD_SD1_CLK__USDHC1_CLK		0x17059
+			MX6UL_PAD_SD1_DATA0__USDHC1_DATA0	0x17059
+			MX6UL_PAD_SD1_DATA1__USDHC1_DATA1	0x17059
+			MX6UL_PAD_SD1_DATA2__USDHC1_DATA2	0x17059
+			MX6UL_PAD_SD1_DATA3__USDHC1_DATA3	0x17059
+		>;
+	};
+
+	pinctrl_usdhc1_100mhz: usdhc1-100mhzgrp {
+		fsl,pins = <
+			MX6UL_PAD_SD1_CMD__USDHC1_CMD		0x170b9
+			MX6UL_PAD_SD1_CLK__USDHC1_CLK		0x100b9
+			MX6UL_PAD_SD1_DATA0__USDHC1_DATA0	0x170b9
+			MX6UL_PAD_SD1_DATA1__USDHC1_DATA1	0x170b9
+			MX6UL_PAD_SD1_DATA2__USDHC1_DATA2	0x170b9
+			MX6UL_PAD_SD1_DATA3__USDHC1_DATA3	0x170b9
+		>;
+	};
+
+	pinctrl_usdhc1_200mhz: usdhc1-200mhzgrp {
+		fsl,pins = <
+			MX6UL_PAD_SD1_CMD__USDHC1_CMD		0x170f9
+			MX6UL_PAD_SD1_CLK__USDHC1_CLK		0x100f9
+			MX6UL_PAD_SD1_DATA0__USDHC1_DATA0	0x170f9
+			MX6UL_PAD_SD1_DATA1__USDHC1_DATA1	0x170f9
+			MX6UL_PAD_SD1_DATA2__USDHC1_DATA2	0x170f9
+			MX6UL_PAD_SD1_DATA3__USDHC1_DATA3	0x170f9
+		>;
+	};
+
+	pinctrl_usdhc1_gpio: usdhc1-gpiogrp {
+		fsl,pins = <
+			MX6UL_PAD_GPIO1_IO00__GPIO1_IO00	0x1b0b1 /* CD */
+		>;
+	};
+
+	pinctrl_wdog: wdoggrp {
+		fsl,pins = <
+			MX6UL_PAD_GPIO1_IO01__WDOG1_WDOG_B	0x78b0
+		>;
+	};
+};
+
+&pwm4 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pwm4>;
+	status = "okay";
+};
+
+&snvs_pwrkey {
+	status = "disabled";
+};
+
+&snvs_rtc {
+	status = "disabled";
+};
+
+&tsc {
+	/*
+	 * Conflics with wdog1 ext-reset-output & SD CD pins,
+	 * so we keep it disabled by default.
+	 */
+	status = "disabled";
+};
+
+/* Console UART */
+&uart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart1>;
+	status = "okay";
+};
+
+/* ttymxc4 UART */
+&uart5 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart5>;
+	uart-has-rtscts;
+	status = "okay";
+};
+
+&usbotg1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usb_otg1_id>;
+	dr_mode = "otg";
+	disable-over-current;
+	srp-disable;
+	hnp-disable;
+	adp-disable;
+	status = "okay";
+};
+
+&usbotg2 {
+	dr_mode = "host";
+	disable-over-current;
+	status = "okay";
+};
+
+&usdhc1 {
+	pinctrl-names = "default", "state_100mhz", "state_200mhz";
+	pinctrl-0 = <&pinctrl_usdhc1>, <&pinctrl_usdhc1_gpio>;
+	pinctrl-1 = <&pinctrl_usdhc1_100mhz>, <&pinctrl_usdhc1_gpio>;
+	pinctrl-2 = <&pinctrl_usdhc1_200mhz>, <&pinctrl_usdhc1_gpio>;
+	cd-gpios = <&gpio1 0 GPIO_ACTIVE_LOW>;
+	no-1-8-v;
+	keep-power-in-suspend;
+	wakeup-source;
+	status = "okay";
+};
+
+&wdog1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_wdog>;
+	/*
+	 * To actually use ext-reset-output
+	 * connect pins J17.3 & J17.8 on the Concerto-Board
+	 */
+	fsl,ext-reset-output;
+};

-- 
2.47.0


