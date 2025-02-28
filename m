Return-Path: <linux-kernel+bounces-538805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70C94A49D44
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 16:23:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7B297A4A18
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 15:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4402527602C;
	Fri, 28 Feb 2025 15:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="EuIwCPGt"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF58275614;
	Fri, 28 Feb 2025 15:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740756018; cv=none; b=DgWeXK83nLhI1jzWc187JMH/EIt6T2OUVproDuNmuT7WssrAwTrIV2+Im5pnvbPEwKgITXWSye/Xweznt8ATFWuvuo5EMn7hv+Qo6nGriQ8n/Qik6SoOZkIapX1hYEqtBea0VclVczoGqYDVBl9/9wJcMr6rv/ahRsS5lFojYwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740756018; c=relaxed/simple;
	bh=3Y3ycwkI4guKo2cJTtwqwLFX1DLSZo1k3gutFJtNA+A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WE2EwiU6rS4jg8xWzR1vTEbhiflrMJEpryQ7bFEGpvbAisFRzMu3+14yDdrJKgQzCTvJ5HYtsoEg8BkxtEAWth7rP99Ldzsz9BmMAnYdy4rKb070MKxLZOaPK6noJ56NNEaqLmER0PqQGdKmllUmc4aRO0at6SLI56kqcxH6500=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=EuIwCPGt; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E1AF1442A3;
	Fri, 28 Feb 2025 15:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1740756014;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xtSjeSfqwjkYzPd2tXI+bXemIInGY1i78OMxh6tisG4=;
	b=EuIwCPGtPOnHHb1KgiM7+8N3D9Lkp2+9SDjAJy0F0L/XElisIZymVXqcpHLP+I+KSSM1lr
	YjpZ528H+J0k7RJ3CtdfwJCzMfolJ16f7C2CtOWcPlS7YvVX5RpeBiy3bIQ97ZRLxX+Jll
	SPmUfrtoSX5xn+qJ81caNTo1z41dlLG68vLy/RC4+PYLeRWgT95kABZh52T4D7a2/jJ8AI
	TrFpEDAkx/5PJ3ZuFiHcQsdOZFmkipjki+1a/9U30Pj3uF9G5cqLKAQMkZSM75Sqs3REmV
	uIoBiDCtNzjYIBi7426/lI+5WAQmJ0E+dXt3gWEdsaZNdKrAEJw+Aylu7i1BLQ==
From: Olivier Benjamin <olivier.benjamin@bootlin.com>
Date: Fri, 28 Feb 2025 16:19:50 +0100
Subject: [PATCH 1/2] arm64: dts: PinePhone Pro: describe I2c Bus 1 and
 IMX258 world camera
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250228-camera-v1-1-c51869f94e97@bootlin.com>
References: <20250228-camera-v1-0-c51869f94e97@bootlin.com>
In-Reply-To: <20250228-camera-v1-0-c51869f94e97@bootlin.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Olivier Benjamin <olivier.benjamin@bootlin.com>, oren@taumoda.com, 
 Dragan Simic <dsimic@manjaro.org>, Ondrej Jirman <megi@xff.cz>
X-Mailer: b4 0.14.2
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeltdejfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefqlhhivhhivghruceuvghnjhgrmhhinhcuoeholhhivhhivghrrdgsvghnjhgrmhhinhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgeeugeeivddvveevvedvudefjeevffdtuefgffekieelheehfeeihefgleefieelnecukfhppedvrgdtudemvgefgeemvggtfeekmedvgegvtdemfhehtggvmehffeegvdemieehkeejmehfieehieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemvgefgeemvggtfeekmedvgegvtdemfhehtggvmehffeegvdemieehkeejmehfieehiedphhgvlhhopegludelvddrudeikedruddrvddtngdpmhgrihhlfhhrohhmpeholhhivhhivghrrdgsvghnjhgrmhhinhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepudefpdhrtghpthhtohepuggvvhhitggvthhrvggvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhosghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdgrrhhmqdhkvghrnhgvlheslhhishhts
 hdrihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehkrhiikhdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhrohgtkhgthhhipheslhhishhtshdrihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopegushhimhhitgesmhgrnhhjrghrohdrohhrghdprhgtphhtthhopehmvghgihesgihffhdrtgii
X-GND-Sasl: olivier.benjamin@bootlin.com

Add the description of the rear/world camera (IMX258) on the PinePhone Pro
to the device dts file.
It receives commands on the I2C Bus 1 at address 0x1a and transmits data
over CSI-MIPI.

The I2C address for IMX258 can be found in the IMX258-0AQH5 Software
Reference Manual, page 24, section 2.3.1: 0b0011010 = 0x1a.
Section 3 indicates the module has 4 pairs of data lines. While 4-lane
mode is nominal, 2-lane mode should also be supported.

The pin muxing info was extracted from the PinePhone Pro schematic v1.0
as well as the RK3399 datasheet revision 1.8.

Table 2-3 in section 2.8 of the RK3399 datasheet contains the mapping
of IO functions for the SoC pins. Page 52 shows GPIO1_A0, page 54 shows
GPIO2_D4.

For I2C power, the PinePhone Pro schematic page 11 quadrants A4 and A5:
RK3399_J.AA8 and RK3399_J.Y8 get power from vcaa1v8_codec, so turn it on

The IMX258 also uses the following regulators, expected by its driver:
 - vana (2.8V analog), called AVDD2V8_DVP on P.18 q.C1 and derived from
   VCC1V8_S3 on P.13 q.B2
 - vdig (1.2V digital core), called DVDD_DVP on P.18 q.C1 and shown on
   P.18 q.D3 to be equivalent to VCC1V2_DVP derived from VCC3V3_SYS on
   P.13 q.B3. Note that this regulator's voltage is inconsistently
   labeled either 1.2V or 1.5V

RK3399_J.AG1 is GPIO4_A1/I2C1_SDA, RK3399_J.Y6 is GPIO4_A2/I2C1_SCL
This is the default pinctrl "i2c1_xfer" for i2c1 from rk3399-base.

For the reset (RESET) signal:
page 11 quadrant D2             | p.18 q.C3-4 | p.18 q.C2
RK3399_E.R25 -> GPIO1_A0 -> Camera_RST -> MIPI_RST0 -> IMX258.12

For the powerdown (PWDN) signal:
page 11 quadrants B4-5          | p.18 q.C2
RK3399_G.AF8 -> GPIO2_D4 -> DVP_PDN1_H -> IMX258.14

Helped-by: Dragan Simic <dsimic@manjaro.org>
Co-developed-by: Ondrej Jirman <megi@xff.cz>
Signed-off-by: Ondrej Jirman <megi@xff.cz>
Signed-off-by: Olivier Benjamin <olivier.benjamin@bootlin.com>
---
 .../boot/dts/rockchip/rk3399-pinephone-pro.dts     | 93 ++++++++++++++++++++++
 1 file changed, 93 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts b/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
index 1a44582a49fb6cb815bc441a548d38f3984c4c4e..4c059b4cda198b0f1973c7bba677ce12d37211b3 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
@@ -114,6 +114,16 @@ vcc3v3_sys: vcc3v3-sys-regulator {
 		vin-supply = <&vcc_sys>;
 	};
 
+	avdd2v8_dvp: avdd2v8-dvp-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "avdd2v8_dvp";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <2800000>;
+		regulator-max-microvolt = <2800000>;
+		vin-supply = <&vcc3v3_sys>;
+	};
+
 	vcca1v8_s3: vcc1v8-s3-regulator {
 		compatible = "regulator-fixed";
 		regulator-name = "vcca1v8_s3";
@@ -136,6 +146,16 @@ vcc1v8_codec: vcc1v8-codec-regulator {
 		vin-supply = <&vcc3v3_sys>;
 	};
 
+	vcc1v2_dvp: vcc1v2-dvp-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc1v2_dvp";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <1200000>;
+		regulator-max-microvolt = <1200000>;
+		vin-supply = <&vcca1v8_s3>;
+	};
+
 	wifi_pwrseq: sdio-wifi-pwrseq {
 		compatible = "mmc-pwrseq-simple";
 		clocks = <&rk818 1>;
@@ -314,6 +334,8 @@ vcc3v0_touch: LDO_REG2 {
 
 			vcca1v8_codec: LDO_REG3 {
 				regulator-name = "vcca1v8_codec";
+				regulator-always-on;
+				regulator-boot-on;
 				regulator-min-microvolt = <1800000>;
 				regulator-max-microvolt = <1800000>;
 			};
@@ -422,6 +444,45 @@ regulator-state-mem {
 	};
 };
 
+&i2c1 {
+	clock-frequency = <400000>;
+	pinctrl-0 = <&i2c1_xfer &cif_clkouta>;
+	assigned-clocks = <&cru SCLK_CIF_OUT>;
+	assigned-clock-rates = <24000000>;
+	status = "okay";
+
+	wcam: camera@1a {
+		compatible = "sony,imx258";
+		reg = <0x1a>;
+		clocks = <&cru SCLK_CIF_OUT>; /* MIPI_MCLK0, derived from CIF_CLKO */
+		clock-names = "xvclk";
+		pinctrl-names = "default";
+		pinctrl-0 = <&wcam_rst>;
+		/* Note: both cameras also depend on vcca1v8_codec to power the I2C bus. */
+		vif-supply = <&vcc1v8_dvp>;
+		vana-supply = <&avdd2v8_dvp>;
+		vdig-supply = <&vcc1v2_dvp>; /* DVDD_DVP is the same as VCC1V2_DVP */
+		reset-gpios = <&gpio1 RK_PA0 GPIO_ACTIVE_LOW>;
+		orientation = <1>; /* V4L2_CAMERA_ORIENTATION_BACK */
+		rotation = <270>;
+		lens-focus = <&wcam_lens>;
+
+		port {
+			wcam_out: endpoint {
+				remote-endpoint = <&mipi_in_wcam>;
+				data-lanes = <1 2 3 4>;
+			};
+		};
+	};
+
+	wcam_lens: camera-lens@c {
+		compatible = "dongwoon,dw9714";
+		reg = <0x0c>;
+		/* Same I2c bus as both cameras, depends on vcca1v8_codec for power. */
+		vcc-supply = <&vcc1v8_dvp>;
+	};
+};
+
 &i2c3 {
 	i2c-scl-rising-time-ns = <450>;
 	i2c-scl-falling-time-ns = <15>;
@@ -485,6 +546,28 @@ &io_domains {
 	status = "okay";
 };
 
+&isp1 {
+	status = "okay";
+
+	ports {
+		port@0 {
+			mipi_in_wcam: endpoint@0 {
+				reg = <0>;
+				remote-endpoint = <&wcam_out>;
+				data-lanes = <1 2 3 4>;
+			};
+		};
+	};
+};
+
+&mipi_dphy_rx0 {
+	status = "okay";
+};
+
+&isp1_mmu {
+	status = "okay";
+};
+
 &mipi_dsi {
 	status = "okay";
 	clock-master;
@@ -518,6 +601,10 @@ mipi_in_panel: endpoint {
 	};
 };
 
+&mipi_dsi1 {
+	status = "okay";
+};
+
 &pmu_io_domains {
 	pmu1830-supply = <&vcc_1v8>;
 	status = "okay";
@@ -530,6 +617,12 @@ pwrbtn_pin: pwrbtn-pin {
 		};
 	};
 
+	camera {
+		wcam_rst: wcam-rst {
+			rockchip,pins = <1 RK_PA0 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
 	leds {
 		red_led_pin: red-led-pin {
 			rockchip,pins = <4 RK_PD2 RK_FUNC_GPIO &pcfg_pull_none>;

-- 
2.48.1


