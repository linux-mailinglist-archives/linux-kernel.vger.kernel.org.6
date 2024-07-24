Return-Path: <linux-kernel+bounces-260982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DF6B93B13A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 15:01:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E38F1F24F90
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 13:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6371815B130;
	Wed, 24 Jul 2024 12:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="d5i1XR0A";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="JsKfxBTq"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922D815A849;
	Wed, 24 Jul 2024 12:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721825966; cv=none; b=aDJ1qxba2dLKw768QLwGNe+JPZPxGZ98C9a/V7WcBYsqMmOEMYcgkBEWRLYccuX4YrnbGcJYcKJ0Y/R3xTLqGecvR7dEKOyslzxaW7lHJ0G2nVA6S98g+mdHNbfxW/Im+gdc0rQXENtSsTQN/Sva3N0gdIy1UrsaIfUmrkIN+gA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721825966; c=relaxed/simple;
	bh=Ki/CrhCP35uTZYUQML+ObOoX5FQItuCwEV8Y3E01sdo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AQcisYW2dqWflsN1D6VSUKzK4I9fBs42d8WJ6H1HtRSoAnlvZwcmLhcmi15aUhwEL9eHGEQ21nXEidmLbdyo39StcClEKlfRvr8xV/ICyD2y2ANsfyLLxCR5jnRSfp0V5hEiOH/9kGexKVVjG7OTxY98+O+rByGpfI2s92mKXYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=d5i1XR0A; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=JsKfxBTq reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1721825964; x=1753361964;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8XIrz5jFCDA1SW+kJ31VWP1tE5Wdq7SFKdyyTuyfCW0=;
  b=d5i1XR0ALnQFF4yx054AcDm9MTXnlnIC7+L0h582lrK1PvIatddPmSHv
   zymBfMhWnQEsoFDW1D1+8M4CoCHaW37/N8SmhZ+Y3DXY0VGb+h11R4xY8
   /q9iHkvp3X3rM0y0tAfsM9vjmDzPqkoVIjug6wj0XfMmAXdj2wiRYpaOQ
   P3ViR0dBS78vYUOn0gDvTCaBj38b+b2nwMW3ObUKj0Xa7yy86Bv/tCMnL
   xfW2JxWL9c1tih0hcO/nU3DET1REhGxvfubsuVdyu8CCrtr+Frbk3v4Ns
   eGU77fh5KbaAAmR+qIpnXzVnKqCFrR5cVxDu5kLGH5wnsmbK2NZk4q3C+
   w==;
X-CSE-ConnectionGUID: fsvqgNPQQF+5NEFvDTDDUg==
X-CSE-MsgGUID: MrGw1zodSjOGhxvDqGJbOw==
X-IronPort-AV: E=Sophos;i="6.09,232,1716242400"; 
   d="scan'208";a="38058828"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 24 Jul 2024 14:59:20 +0200
X-CheckPoint: {66A0FAA8-24-6C016D47-F93F7C64}
X-MAIL-CPID: C1DE786749F29BAE2D7889409F2DD6CC_0
X-Control-Analysis: str=0001.0A782F26.66A0FAA9.0013,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CDAF016E650;
	Wed, 24 Jul 2024 14:59:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1721825960; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=8XIrz5jFCDA1SW+kJ31VWP1tE5Wdq7SFKdyyTuyfCW0=;
	b=JsKfxBTqtVE5PDI4Obf/w60EIxYynQaOGRX8AoBZyLZvCheuxQOZufwOWdCLzxmH7m7QpQ
	i45KaDTUNDUbJhKVXplPxrMm8BxRzj2wTmvEW7nMbEyJPYbQGuk4tj5LnYbVipsQ2z6qfz
	93FbC/0J36YgIGYCOy+mIhvOgOWTOlbR4gc21Df7Bv71udsIAHpe4u+bOsRuEKebneUJET
	9lCb8HDvBeujFh9D0qy2b2nh4+A6TL21ZYK8hYLmtWqsh4ndjE3G/LkzfwVKRnahqVCYQ1
	fRh+pvpR2aHOzBkhJooQnDSJLldNhLerUpVtkNlq6dkO1nSo0gyGy6ypuPkQYw==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Markus Niebel <Markus.Niebel@ew.tq-group.com>,
	linux@ew.tq-group.com,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 06/14] arm64: dts: freescale: imx93-tqma9352-mba93xxla: improve pad configuration
Date: Wed, 24 Jul 2024 14:58:53 +0200
Message-Id: <20240724125901.1391698-7-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240724125901.1391698-1-alexander.stein@ew.tq-group.com>
References: <20240724125901.1391698-1-alexander.stein@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

From: Markus Niebel <Markus.Niebel@ew.tq-group.com>

- disable PU/PD if already done with external resistors
- do not configure Schmitt Trigger for outputs
- do not configure DSE / FSEL for inputs
- add missing pad groups
- assign muxed GPIO pads for X1 to gpio2 node

Signed-off-by: Markus Niebel <Markus.Niebel@ew.tq-group.com>
Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 .../freescale/imx93-tqma9352-mba93xxla.dts    | 237 ++++++++++++------
 1 file changed, 164 insertions(+), 73 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxla.dts b/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxla.dts
index e2ee9f5a042c..c663b6585c3a 100644
--- a/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxla.dts
+++ b/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxla.dts
@@ -222,6 +222,11 @@ rtc-irq-hog {
 	};
 };
 
+&gpio2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_gpio2>;
+};
+
 &gpio3 {
 	ethphy-eqos-irq-hog {
 		gpio-hog;
@@ -509,25 +514,39 @@ &usdhc2 {
 };
 
 &iomuxc {
+	pinctrl_afe: afegrp {
+		fsl,pins = <
+			/* FSEL_2 | DSE X4 */
+			MX93_PAD_GPIO_IO07__GPIO2_IO07			0x011e
+			/* PD | FSEL_2 | DSE X4 */
+			MX93_PAD_GPIO_IO08__GPIO2_IO08			0x051e
+			/* HYS | PD */
+			MX93_PAD_GPIO_IO09__GPIO2_IO09			0x1400
+			/* HYS */
+			MX93_PAD_GPIO_IO24__GPIO2_IO24			0x1000
+		>;
+	};
+
 	pinctrl_eqos: eqosgrp {
 		fsl,pins = <
 			/* PD | FSEL_2 | DSE X4 */
-			MX93_PAD_ENET1_MDC__ENET_QOS_MDC		0x51e
-			MX93_PAD_ENET1_MDIO__ENET_QOS_MDIO		0x4000051e
-			/* PD | FSEL_2 | DSE X6 */
-			MX93_PAD_ENET1_RD0__ENET_QOS_RGMII_RD0		0x57e
-			MX93_PAD_ENET1_RD1__ENET_QOS_RGMII_RD1		0x57e
-			MX93_PAD_ENET1_RD2__ENET_QOS_RGMII_RD2		0x57e
-			MX93_PAD_ENET1_RD3__ENET_QOS_RGMII_RD3		0x57e
-			/* PD | FSEL_3 | DSE X6 */
-			MX93_PAD_ENET1_RXC__CCM_ENET_QOS_CLOCK_GENERATE_RX_CLK	0x5fe
-			MX93_PAD_ENET1_RX_CTL__ENET_QOS_RGMII_RX_CTL	0x57e
+			MX93_PAD_ENET1_MDC__ENET_QOS_MDC			0x51e
+			/* SION | HYS | FSEL_2 | DSE X4 */
+			MX93_PAD_ENET1_MDIO__ENET_QOS_MDIO			0x4000111e
+			/* HYS | FSEL_0 | DSE no drive */
+			MX93_PAD_ENET1_RD0__ENET_QOS_RGMII_RD0			0x1000
+			MX93_PAD_ENET1_RD1__ENET_QOS_RGMII_RD1			0x1000
+			MX93_PAD_ENET1_RD2__ENET_QOS_RGMII_RD2			0x1000
+			MX93_PAD_ENET1_RD3__ENET_QOS_RGMII_RD3			0x1000
+			MX93_PAD_ENET1_RX_CTL__ENET_QOS_RGMII_RX_CTL		0x1000
+			/* HYS | PD | FSEL_0 | DSE no drive */
+			MX93_PAD_ENET1_RXC__CCM_ENET_QOS_CLOCK_GENERATE_RX_CLK	0x1400
 			/* PD | FSEL_2 | DSE X4 */
-			MX93_PAD_ENET1_TD0__ENET_QOS_RGMII_TD0		0x51e
-			MX93_PAD_ENET1_TD1__ENET_QOS_RGMII_TD1		0x51e
-			MX93_PAD_ENET1_TD2__ENET_QOS_RGMII_TD2		0x51e
-			MX93_PAD_ENET1_TD3__ENET_QOS_RGMII_TD3		0x51e
-			MX93_PAD_ENET1_TX_CTL__ENET_QOS_RGMII_TX_CTL	0x51e
+			MX93_PAD_ENET1_TD0__ENET_QOS_RGMII_TD0			0x51e
+			MX93_PAD_ENET1_TD1__ENET_QOS_RGMII_TD1			0x51e
+			MX93_PAD_ENET1_TD2__ENET_QOS_RGMII_TD2			0x51e
+			MX93_PAD_ENET1_TD3__ENET_QOS_RGMII_TD3			0x51e
+			MX93_PAD_ENET1_TX_CTL__ENET_QOS_RGMII_TX_CTL		0x51e
 			/* PD | FSEL_3 | DSE X3 */
 			MX93_PAD_ENET1_TXC__CCM_ENET_QOS_CLOCK_GENERATE_TX_CLK	0x58e
 		>;
@@ -535,7 +554,8 @@ MX93_PAD_ENET1_TXC__CCM_ENET_QOS_CLOCK_GENERATE_TX_CLK	0x58e
 
 	pinctrl_eqos_phy: eqosphygrp {
 		fsl,pins = <
-			MX93_PAD_CCM_CLKO1__GPIO3_IO26		0x1306
+			/* HYS | FSEL_0 | DSE no drive */
+			MX93_PAD_CCM_CLKO1__GPIO3_IO26			0x1000
 		>;
 	};
 
@@ -543,15 +563,16 @@ pinctrl_fec: fecgrp {
 		fsl,pins = <
 			/* PD | FSEL_2 | DSE X4 */
 			MX93_PAD_ENET2_MDC__ENET1_MDC			0x51e
-			MX93_PAD_ENET2_MDIO__ENET1_MDIO			0x4000051e
-			/* PD | FSEL_2 | DSE X6 */
-			MX93_PAD_ENET2_RD0__ENET1_RGMII_RD0		0x57e
-			MX93_PAD_ENET2_RD1__ENET1_RGMII_RD1		0x57e
-			MX93_PAD_ENET2_RD2__ENET1_RGMII_RD2		0x57e
-			MX93_PAD_ENET2_RD3__ENET1_RGMII_RD3		0x57e
-			/* PD | FSEL_3 | DSE X6 */
-			MX93_PAD_ENET2_RXC__ENET1_RGMII_RXC		0x5fe
-			MX93_PAD_ENET2_RX_CTL__ENET1_RGMII_RX_CTL	0x57e
+			/* SION | HYS | FSEL_2 | DSE X4 */
+			MX93_PAD_ENET2_MDIO__ENET1_MDIO			0x4000111e
+			/* HYS | FSEL_0 | DSE no drive */
+			MX93_PAD_ENET2_RD0__ENET1_RGMII_RD0		0x1000
+			MX93_PAD_ENET2_RD1__ENET1_RGMII_RD1		0x1000
+			MX93_PAD_ENET2_RD2__ENET1_RGMII_RD2		0x1000
+			MX93_PAD_ENET2_RD3__ENET1_RGMII_RD3		0x1000
+			MX93_PAD_ENET2_RX_CTL__ENET1_RGMII_RX_CTL	0x1000
+			/* HYS | PD | FSEL_0 | DSE no drive */
+			MX93_PAD_ENET2_RXC__ENET1_RGMII_RXC		0x1400
 			/* PD | FSEL_2 | DSE X4 */
 			MX93_PAD_ENET2_TD0__ENET1_RGMII_TD0		0x51e
 			MX93_PAD_ENET2_TD1__ENET1_RGMII_TD1		0x51e
@@ -565,139 +586,209 @@ MX93_PAD_ENET2_TXC__ENET1_RGMII_TXC		0x58e
 
 	pinctrl_fec_phy: fecphygrp {
 		fsl,pins = <
-			MX93_PAD_CCM_CLKO2__GPIO3_IO27		0x1306
+			/* HYS | FSEL_0 | DSE no drive */
+			MX93_PAD_CCM_CLKO2__GPIO3_IO27			0x1000
 		>;
 	};
 
 	pinctrl_flexcan1: flexcan1grp {
 		fsl,pins = <
-			MX93_PAD_PDM_BIT_STREAM0__CAN1_RX	0x139e
-			MX93_PAD_PDM_CLK__CAN1_TX		0x139e
+			/* HYS | PU | FSEL_0 | DSE no drive */
+			MX93_PAD_PDM_BIT_STREAM0__CAN1_RX		0x1200
+			/* PU | FSEL_3 | DSE X4 */
+			MX93_PAD_PDM_CLK__CAN1_TX			0x039e
 		>;
 	};
 
 	pinctrl_flexcan2: flexcan2grp {
 		fsl,pins = <
-			MX93_PAD_GPIO_IO25__CAN2_TX		0x139e
-			MX93_PAD_GPIO_IO27__CAN2_RX		0x139e
+			/* HYS | PU | FSEL_0 | DSE no drive */
+			MX93_PAD_GPIO_IO27__CAN2_RX			0x1200
+			/* PU | FSEL_3 | DSE X4 */
+			MX93_PAD_GPIO_IO25__CAN2_TX			0x039e
+		>;
+	};
+
+	pinctrl_gpio2: gpio2grp {
+		fsl,pins = <
+			/* HYS | PD | FSEL_2 | DSE X4 */
+			MX93_PAD_GPIO_IO16__GPIO2_IO16			0x151e
+			MX93_PAD_GPIO_IO17__GPIO2_IO17			0x151e
+			MX93_PAD_GPIO_IO18__GPIO2_IO18			0x151e
+			MX93_PAD_GPIO_IO19__GPIO2_IO19			0x151e
+			MX93_PAD_GPIO_IO20__GPIO2_IO20			0x151e
+			MX93_PAD_GPIO_IO21__GPIO2_IO21			0x151e
+			MX93_PAD_GPIO_IO26__GPIO2_IO26			0x151e
+		>;
+	};
+
+	pinctrl_jtag: jtaggrp {
+		fsl,pins = <
+			MX93_PAD_DAP_TCLK_SWCLK__JTAG_MUX_TCK		0x051e
+			MX93_PAD_DAP_TDI__JTAG_MUX_TDI			0x1200
+			MX93_PAD_DAP_TDO_TRACESWO__JTAG_MUX_TDO		0x031e
+			MX93_PAD_DAP_TMS_SWDIO__JTAG_MUX_TMS		0x1200
 		>;
 	};
 
 	pinctrl_lpi2c3: lpi2c3grp {
 		fsl,pins = <
-			MX93_PAD_GPIO_IO28__LPI2C3_SDA		0x40000b9e
-			MX93_PAD_GPIO_IO29__LPI2C3_SCL		0x40000b9e
+			/* SION | HYS | OD | FSEL_3 | DSE X4 */
+			MX93_PAD_GPIO_IO28__LPI2C3_SDA			0x4000199e
+			MX93_PAD_GPIO_IO29__LPI2C3_SCL			0x4000199e
 		>;
 	};
 
 	pinctrl_lpi2c5: lpi2c5grp {
 		fsl,pins = <
-			MX93_PAD_GPIO_IO22__LPI2C5_SDA		0x40000b9e
-			MX93_PAD_GPIO_IO23__LPI2C5_SCL		0x40000b9e
+			/* SION | HYS | OD | FSEL_3 | DSE X4 */
+			MX93_PAD_GPIO_IO22__LPI2C5_SDA			0x4000199e
+			MX93_PAD_GPIO_IO23__LPI2C5_SCL			0x4000199e
+		>;
+	};
+
+	pinctrl_lpspi6: lpspi6grp {
+		fsl,pins = <
+			/* FSEL_2 | DSE X4 */
+			MX93_PAD_GPIO_IO00__LPSPI6_PCS0			0x011e
+			/* HYS | PD | FSEL_0 | DSE no drive */
+			MX93_PAD_GPIO_IO01__LPSPI6_SIN			0x1400
+			/* PD | FSEL_2 | DSE X4 */
+			MX93_PAD_GPIO_IO02__LPSPI6_SOUT			0x051e
+			MX93_PAD_GPIO_IO03__LPSPI6_SCK			0x051e
+		>;
+	};
+
+	pinctrl_mipi_csi: mipicsigrp {
+		fsl,pins = <
+			MX93_PAD_CCM_CLKO3__CCMSRCGPCMIX_CLKO3		0x051e /* MCLK */
+			MX93_PAD_GPIO_IO10__GPIO2_IO10			0x051e /* TRIGGER */
+			MX93_PAD_GPIO_IO11__GPIO2_IO11			0x1400 /* SYNC */
 		>;
 	};
 
 	pinctrl_pcf85063: pcf85063grp {
 		fsl,pins = <
-			MX93_PAD_SAI1_RXD0__GPIO1_IO14		0x1306
+			/* HYS | FSEL_0 | No DSE */
+			MX93_PAD_SAI1_RXD0__GPIO1_IO14			0x1000
 		>;
 	};
 
 	pinctrl_pexp_irq: pexpirqgrp {
 		fsl,pins = <
-			MX93_PAD_SAI1_TXC__GPIO1_IO12		0x1306
+			/* HYS | FSEL_0 | No DSE */
+			MX93_PAD_SAI1_TXC__GPIO1_IO12			0x1000
 		>;
 	};
 
 	pinctrl_tc9595: tc9595-grp {
 		fsl,pins = <
-			/* DP_IRQ */
-			MX93_PAD_CCM_CLKO4__GPIO4_IO29		0x1306
+			/* HYS | PD | FSEL_0 | no DSE */
+			MX93_PAD_CCM_CLKO4__GPIO4_IO29			0x1400
+		>;
+	};
+
+	pinctrl_temp_sensor_som: tempsensorsomgrp {
+		fsl,pins = <
+			/* HYS | FSEL_0 | no DSE */
+			MX93_PAD_SAI1_TXFS__GPIO1_IO11			0x1000
 		>;
 	};
 
 	pinctrl_tpm5: tpm5grp {
 		fsl,pins = <
-			MX93_PAD_GPIO_IO06__TPM5_CH0		0x57e
+			MX93_PAD_GPIO_IO06__TPM5_CH0			0x57e
 		>;
 	};
 
 	pinctrl_typec: typecgrp {
 		fsl,pins = <
-			MX93_PAD_I2C2_SCL__GPIO1_IO02		0x1306
+			/* HYS | FSEL_0 | No DSE */
+			MX93_PAD_I2C2_SCL__GPIO1_IO02			0x1000
 		>;
 	};
 
 	pinctrl_uart1: uart1grp {
 		fsl,pins = <
-			MX93_PAD_UART1_RXD__LPUART1_RX		0x31e
-			MX93_PAD_UART1_TXD__LPUART1_TX		0x31e
+			/* HYS | FSEL_0 | No DSE */
+			MX93_PAD_UART1_RXD__LPUART1_RX			0x1000
+			/* FSEL_2 | DSE X4 */
+			MX93_PAD_UART1_TXD__LPUART1_TX			0x011e
 		>;
 	};
 
 	pinctrl_uart2: uart2grp {
 		fsl,pins = <
-			MX93_PAD_UART2_TXD__LPUART2_TX		0x31e
-			MX93_PAD_UART2_RXD__LPUART2_RX		0x31e
-			MX93_PAD_SAI1_TXD0__LPUART2_RTS_B	0x51e
+			/* HYS | FSEL_0 | No DSE */
+			MX93_PAD_UART2_RXD__LPUART2_RX			0x1000
+			/* FSEL_2 | DSE X4 */
+			MX93_PAD_UART2_TXD__LPUART2_TX			0x011e
+			MX93_PAD_SAI1_TXD0__LPUART2_RTS_B		0x011e
 		>;
 	};
 
 	pinctrl_uart3: uart3grp {
 		fsl,pins = <
-			MX93_PAD_GPIO_IO14__LPUART3_TX		0x31e
-			MX93_PAD_GPIO_IO15__LPUART3_RX		0x31e
+			/* HYS | FSEL_0 | No DSE */
+			MX93_PAD_GPIO_IO15__LPUART3_RX			0x1000
+			/* FSEL_2 | DSE X4 */
+			MX93_PAD_GPIO_IO14__LPUART3_TX			0x011e
 		>;
 	};
 
 	pinctrl_uart6: uart6grp {
 		fsl,pins = <
-			MX93_PAD_GPIO_IO04__LPUART6_TX		0x31e
-			MX93_PAD_GPIO_IO05__LPUART6_RX		0x31e
+			/* HYS | FSEL_0 | No DSE */
+			MX93_PAD_GPIO_IO05__LPUART6_RX			0x1000
+			/* FSEL_2 | DSE X4 */
+			MX93_PAD_GPIO_IO04__LPUART6_TX			0x011e
 		>;
 	};
 
 	pinctrl_uart8: uart8grp {
 		fsl,pins = <
-			MX93_PAD_GPIO_IO12__LPUART8_TX		0x31e
-			MX93_PAD_GPIO_IO13__LPUART8_RX		0x31e
+			/* HYS | FSEL_0 | No DSE */
+			MX93_PAD_GPIO_IO13__LPUART8_RX			0x1000
+			/* FSEL_2 | DSE X4 */
+			MX93_PAD_GPIO_IO12__LPUART8_TX			0x011e
 		>;
 	};
 
 	pinctrl_usdhc2_gpio: usdhc2gpiogrp {
 		fsl,pins = <
-			MX93_PAD_SD2_CD_B__GPIO3_IO00		0x31e
+			/* HYS | FSEL_0 | No DSE */
+			MX93_PAD_SD2_CD_B__GPIO3_IO00			0x1000
 		>;
 	};
 
 	pinctrl_usdhc2_hs: usdhc2hsgrp {
 		fsl,pins = <
-			/* HYS | PD | PU | FSEL_3 | DSE X5 */
-			MX93_PAD_SD2_CLK__USDHC2_CLK		0x17be
-			/* HYS | PD | PU | FSEL_3 | DSE X4 */
-			MX93_PAD_SD2_CMD__USDHC2_CMD		0x139e
-			/* HYS | PD | PU | FSEL_3 | DSE X3 */
-			MX93_PAD_SD2_DATA0__USDHC2_DATA0	0x138e
-			MX93_PAD_SD2_DATA1__USDHC2_DATA1	0x138e
-			MX93_PAD_SD2_DATA2__USDHC2_DATA2	0x138e
-			MX93_PAD_SD2_DATA3__USDHC2_DATA3	0x138e
-			/* PD | PU | FSEL_2 | DSE X3 */
-			MX93_PAD_SD2_VSELECT__USDHC2_VSELECT	0x50e
+			/* PD | FSEL_3 | DSE X5 */
+			MX93_PAD_SD2_CLK__USDHC2_CLK			0x05be
+			/* HYS | PU | FSEL_3 | DSE X4 */
+			MX93_PAD_SD2_CMD__USDHC2_CMD			0x139e
+			/* HYS | PU | FSEL_3 | DSE X3 */
+			MX93_PAD_SD2_DATA0__USDHC2_DATA0		0x138e
+			MX93_PAD_SD2_DATA1__USDHC2_DATA1		0x138e
+			MX93_PAD_SD2_DATA2__USDHC2_DATA2		0x138e
+			MX93_PAD_SD2_DATA3__USDHC2_DATA3		0x138e
+			/* FSEL_2 | DSE X3 */
+			MX93_PAD_SD2_VSELECT__USDHC2_VSELECT		0x010e
 		>;
 	};
 
 	pinctrl_usdhc2_uhs: usdhc2uhsgrp {
 		fsl,pins = <
-			/* HYS | PD | PU | FSEL_3 | DSE X6 */
-			MX93_PAD_SD2_CLK__USDHC2_CLK		0x17fe
-			/* HYS | PD | PU | FSEL_3 | DSE X4 */
-			MX93_PAD_SD2_CMD__USDHC2_CMD		0x139e
-			MX93_PAD_SD2_DATA0__USDHC2_DATA0	0x139e
-			MX93_PAD_SD2_DATA1__USDHC2_DATA1	0x139e
-			MX93_PAD_SD2_DATA2__USDHC2_DATA2	0x139e
-			MX93_PAD_SD2_DATA3__USDHC2_DATA3	0x139e
-			/* PD | PU | FSEL_2 | DSE X3 */
-			MX93_PAD_SD2_VSELECT__USDHC2_VSELECT	0x50e
+			/* PD | FSEL_3 | DSE X6 */
+			MX93_PAD_SD2_CLK__USDHC2_CLK			0x05fe
+			/* HYS | PU | FSEL_3 | DSE X4 */
+			MX93_PAD_SD2_CMD__USDHC2_CMD			0x139e
+			MX93_PAD_SD2_DATA0__USDHC2_DATA0		0x139e
+			MX93_PAD_SD2_DATA1__USDHC2_DATA1		0x139e
+			MX93_PAD_SD2_DATA2__USDHC2_DATA2		0x139e
+			MX93_PAD_SD2_DATA3__USDHC2_DATA3		0x139e
+			/* FSEL_2 | DSE X3 */
+			MX93_PAD_SD2_VSELECT__USDHC2_VSELECT		0x010e
 		>;
 	};
 };
-- 
2.34.1


