Return-Path: <linux-kernel+bounces-260986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CC5C93B141
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 15:02:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3E3C285BDE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 13:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69B7415D5C1;
	Wed, 24 Jul 2024 12:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="Upct3tO5";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="AS6991fa"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791D715B57D;
	Wed, 24 Jul 2024 12:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721825972; cv=none; b=LkVNqcw58xrvwdRltCMQat2ri0VttWEqVfeTzCKekNp8NCxiMUHktcpOywL2vwq0QaijhOg89csDftiT3S385vEm2XvQAwgGaJQqrQtjwZvK18e7wPRjA3WXf6hqDhSP/MnwpWL6Z7XNw57X2wL11KrsM7uaYQujV/1E8dx6xeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721825972; c=relaxed/simple;
	bh=mVDE/FBqsWMsgHeNB9I06PuqjJniPQD/72xQGbM6dVE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZkXqNvQy8F/Bn9+eZJLeNvMdtUH+hqhjz16qw0ok78i0/ncJGzzn+hkyg5+jXF8mF4zpJPmjTWoBkcH/f+FXPpf6Qf1JC8x/f5dLqZMoPbfaLrKFBd+wvPsr7ymzcO+SFdCNPS3iaNokcc2fp044t77LhLIZPPIFwgIs8rVOTlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=Upct3tO5; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=AS6991fa reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1721825969; x=1753361969;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xw/tigMBZlg/a9stNOkPWq+Hwjql6T8KpCr0bQhNXvk=;
  b=Upct3tO5Q8jO9mP0N4Ifucj0+4DzNy7q9yrZ9CfkAejR5N2l/jG9bsQG
   QLfjFCzYf6exbDOVp4uM0EY3tPj9iNOWe5kkIwpFEEoCTwo40CssQeIqc
   kJpZ5LXTLrfZyHog7OPzjgOIMA5/5QtMyMqY/1qwasa+lVLT/2T0R6f7G
   cbsNW8dSg9SlN1ClHih4kZcxFQ08IwY8Vy3U0lNFMgKGxPWhiutRZaLE5
   VuRpLpYXh4lk49XFpG1JhwfvDeRjRsrr2wT9VehYTPIvyXMJ60v0ppHqt
   Esfq8wtWEaOCe215HAH3cYsklALobQOmra/gfVGQ3AY1FNRDejzFoiJwS
   A==;
X-CSE-ConnectionGUID: wybokt7kTDCjTYz92MstZQ==
X-CSE-MsgGUID: WEWgOBIUSwWS27p7i3cawA==
X-IronPort-AV: E=Sophos;i="6.09,232,1716242400"; 
   d="scan'208";a="38058832"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 24 Jul 2024 14:59:28 +0200
X-CheckPoint: {66A0FAB0-24-6C016D47-F93F7C64}
X-MAIL-CPID: EDF6915F7D60E5CF4CD1FADAF7536834_0
X-Control-Analysis: str=0001.0A782F26.66A0FAB0.0180,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DA1DA163656;
	Wed, 24 Jul 2024 14:59:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1721825968; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=xw/tigMBZlg/a9stNOkPWq+Hwjql6T8KpCr0bQhNXvk=;
	b=AS6991faC9pHgRdIKNJIZABWXIjzdqrhI0YY4iOTbaMEz9O5qzHQ8jIGbeUBhJ34OEK03n
	V5k9N3V5gRvuT64k9jcCssm69OyfKW9LfWu0yEg7kg8dFcyW/Tf4DG9y3mc9R4SIwrL1wY
	T7IOzv+kGBGA3iZxhmhpkiSK1O8Gk+ePPnzGFBdLWc08ht4GE/aRNMy74bgi7pYzyFfRI4
	KAK8E6bQYd1HbukAI06ePBnQByzqNF3XVcmacjrMEfVJZbRkvi4v8vNqOl8Kj4yXdzSx9k
	vpIpE6W7C0rUT1pImz7KFW8uMXyfApLh9IwSYsK3DiaIdT5RzQUTLIxariZNHQ==
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
Subject: [PATCH 10/14] arm64: dts: freescale: imx93-tqma9352-mba93xxca: improve pad configuration
Date: Wed, 24 Jul 2024 14:58:57 +0200
Message-Id: <20240724125901.1391698-11-alexander.stein@ew.tq-group.com>
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

Pad config changes suggested by hardware team.

Signed-off-by: Markus Niebel <Markus.Niebel@ew.tq-group.com>
Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 .../freescale/imx93-tqma9352-mba93xxca.dts    | 235 ++++++++++++------
 1 file changed, 159 insertions(+), 76 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxca.dts b/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxca.dts
index 852dd3d2eac7..99a0b6b9e304 100644
--- a/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxca.dts
+++ b/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxca.dts
@@ -289,6 +289,11 @@ tcpc-irq-hog {
 	};
 };
 
+&gpio2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_gpio2>;
+};
+
 &lpi2c3 {
 	#address-cells = <1>;
 	#size-cells = <0>;
@@ -559,22 +564,23 @@ &iomuxc {
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
@@ -582,7 +588,8 @@ MX93_PAD_ENET1_TXC__CCM_ENET_QOS_CLOCK_GENERATE_TX_CLK	0x58e
 
 	pinctrl_eqos_phy: eqosphygrp {
 		fsl,pins = <
-			MX93_PAD_CCM_CLKO1__GPIO3_IO26		0x1306
+			/* HYS | FSEL_0 | DSE no drive */
+			MX93_PAD_CCM_CLKO1__GPIO3_IO26			0x1000
 		>;
 	};
 
@@ -590,15 +597,16 @@ pinctrl_fec: fecgrp {
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
@@ -612,147 +620,222 @@ MX93_PAD_ENET2_TXC__ENET1_RGMII_TXC		0x58e
 
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
 		>;
 	};
 
 	pinctrl_lpspi6: lpspi6grp {
 		fsl,pins = <
-			MX93_PAD_GPIO_IO00__LPSPI6_PCS0		0x3fe
-			MX93_PAD_GPIO_IO01__LPSPI6_SIN		0x3fe
-			MX93_PAD_GPIO_IO02__LPSPI6_SOUT		0x3fe
-			MX93_PAD_GPIO_IO03__LPSPI6_SCK		0x3fe
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
+		>;
+	};
+
+	pinctrl_pcf85063: pcf85063grp {
+		fsl,pins = <
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
 
 	pinctrl_pwmfan: pwmfangrp {
 		fsl,pins = <
-			MX93_PAD_GPIO_IO09__GPIO2_IO09		0x1306
+			/* HYS | PU | FSEL_0 | no DSE */
+			MX93_PAD_GPIO_IO09__GPIO2_IO09			0x1200
+		>;
+	};
+
+	pinctrl_tc9595: tc9595-grp {
+		fsl,pins = <
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
 
 	pinctrl_tpm6: tpm6grp {
 		fsl,pins = <
-			MX93_PAD_GPIO_IO08__TPM6_CH0		0x57e
+			MX93_PAD_GPIO_IO08__TPM6_CH0			0x57e
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
-			MX93_PAD_SAI1_TXD0__LPUART2_RTS_B   0x51e
+			/* HYS | FSEL_0 | No DSE */
+			MX93_PAD_UART2_RXD__LPUART2_RX			0x1000
+			/* FSEL_2 | DSE X4 */
+			MX93_PAD_UART2_TXD__LPUART2_TX			0x011e
+			/* FSEL_2 | DSE X4 */
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


