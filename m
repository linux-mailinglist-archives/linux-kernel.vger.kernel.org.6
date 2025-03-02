Return-Path: <linux-kernel+bounces-540597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BFDB0A4B2AB
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 16:42:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7F2A16AA6D
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 15:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A83681E98FE;
	Sun,  2 Mar 2025 15:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Un8MpdeH"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A6D1E5B6D;
	Sun,  2 Mar 2025 15:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740930152; cv=none; b=srzosxumlJ/X4hh1v3WB3i4HI7f4QOX2oSXv9J7I04DaVm6T/qWHE7TvPMChYDx2VPpEhCF9zgSUY+zmzSHZgXKqLzgHJaLQEMWLJeKRjVmuG87an0KRukhKixArUti4sI3vyl55Lc0VehBY1fTNQwa/0h7l5IQyuQzw44Zw/q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740930152; c=relaxed/simple;
	bh=WlsTDuDX6LrL+lhn4Ir6/IBTGSiKQ/HBJtQ7dayYG+E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Q6zbmONV11yZhq8wRefa6S4kBsIs3fmareAj1EmuEey6cR8+HaCkku9f7S/r7NBKjEmFBBHprQfRclsEsHv233B1TeQjlkwu6DTuOxWphnEtxZHpd8eDoe1RoX+gVJFKeznIz1dqUsg3KoiQJAfjctPpfnxEEAkFqXhGhKZyGmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Un8MpdeH; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2C6A044417;
	Sun,  2 Mar 2025 15:42:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1740930142;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fdnQ5+Le+Og1Av7WQPN6X9ybA51iqbx7l8HzvezJN3g=;
	b=Un8MpdeH2J+qxZ+MJKjzBwSk0gRRBdMDH0Yb0PBCqzgABRh5TYye6RlFUp0rjmWtvupTKR
	p0NdqCgjCdTq6mxoDmVP+07LdwuLGBI6DMQBgCEmoyY8E0xqXyW+3UHL49xrWFMcoohKk+
	f4iYa+e3v5LYDV7uGW8F3UChtmGiRvVHBP98DwkOOuvhJ3b7WNEj3g0i8bMPdziSUnTHXF
	nqzq407zm0U35teBDqO/cfTbE3xMD41W2d9qeiYcbG3keRWKACxAS8Ozqs4OeY+6faxZ2c
	hgMqQdkH5yxk2f2+rRE016YGLGi2frr82BU1eBZZ21xQ50ARKQwVj5SVuQdqHQ==
From: Olivier Benjamin <olivier.benjamin@bootlin.com>
Date: Sun, 02 Mar 2025 16:41:03 +0100
Subject: [PATCH v2 2/2] arm64: dts: rockchip: describe the OV8858 user
 camera on PinePhone Pro
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250302-camera-v2-2-312b44b4a89c@bootlin.com>
References: <20250302-camera-v2-0-312b44b4a89c@bootlin.com>
In-Reply-To: <20250302-camera-v2-0-312b44b4a89c@bootlin.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdelieeitdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefqlhhivhhivghruceuvghnjhgrmhhinhcuoeholhhivhhivghrrdgsvghnjhgrmhhinhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgeeugeeivddvveevvedvudefjeevffdtuefgffekieelheehfeeihefgleefieelnecukfhppedvrgdtudemvgefgeemvggtfeekmedvgegvtdemfhehtggvmehffeegvdemieehkeejmehfieehieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemvgefgeemvggtfeekmedvgegvtdemfhehtggvmehffeegvdemieehkeejmehfieehiedphhgvlhhopegludelvddrudeikedruddrvddtngdpmhgrihhlfhhrohhmpeholhhivhhivghrrdgsvghnjhgrmhhinhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepudefpdhrtghpthhtoheplhhinhhugidqrhhotghktghhihhpsehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtoheptghonhhorhdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehmvghgihesgihffhdrt
 giipdhrtghpthhtohepughsihhmihgtsehmrghnjhgrrhhordhorhhgpdhrtghpthhtoheplhhinhhugidqrghrmhdqkhgvrhhnvghlsehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohepohhrvghnsehtrghumhhouggrrdgtohhmpdhrtghpthhtohepuggvvhhitggvthhrvggvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthhhohhmrghsrdhpvghtrgiiiihonhhisegsohhothhlihhnrdgtohhm
X-GND-Sasl: olivier.benjamin@bootlin.com

Add the description of the front/user camera (OV8858) on the PinePhone Pro
to the device dts file.
It receives commands over SCCB, an I2C-compatible protocol, at
I2C address 0x36 and transmits data over CSI-MIPI.
I confirmed this address experimentally.

The pin control mapping was again extracted from the PinePhone Pro
schematic v1.0 as well as the RK3399 datasheet revision 1.8.

Table 2-3 in section 2.8 of the RK3399 datasheet contains the mapping
of IO functions for the SoC pins. Page 52 shows GPIO1_A4, page 54 shows
GPIO2_B4.

For the reset (RESET) signal:
page 11 quadrant D2             | p.18 q.B3-4 | p.18 q.C2
RK3399_E.R28 -> GPIO1_A4 -> Camera2_RST -> MIPI_RST1 -> OV8858.12

For the powerdown (PWDN) signal:
page 9 quadrants D4-5          | p.18 q.B2
RK3399_L.F31 -> GPIO2_B4 -> DVP_PDN0_H -> OV8858.14

Helped-by: Dragan Simic <dsimic@manjaro.org>
Co-developed-by: Ondrej Jirman <megi@xff.cz>
Signed-off-by: Ondrej Jirman <megi@xff.cz>
Signed-off-by: Olivier Benjamin <olivier.benjamin@bootlin.com>
---
 .../boot/dts/rockchip/rk3399-pinephone-pro.dts     | 45 ++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts b/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
index 7f8fe7577d240f330328b6ea44ea6b06bbc8595b..9c965a00fcf6dbf4c618e1f4668d82a028c76143 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
@@ -479,6 +479,27 @@ wcam_lens: camera-lens@c {
 		/* Same I2c bus as both cameras, depends on vcca1v8_codec for power. */
 		vcc-supply = <&vcc1v8_dvp>;
 	};
+
+	ucam: camera@36 {
+		compatible = "ovti,ov8858";
+		reg = <0x36>;
+		clocks = <&cru SCLK_CIF_OUT>; /* MIPI_MCLK1, derived from CIF_CLK0 */
+		clock-names = "xvclk";
+		pinctrl-names = "default";
+		pinctrl-0 = <&ucam_rst &ucam_pwdn>;
+		dovdd-supply = <&vcc1v8_dvp>;
+		reset-gpios = <&gpio1 RK_PA4 GPIO_ACTIVE_LOW>;
+		powerdown-gpios = <&gpio2 RK_PB4 GPIO_ACTIVE_LOW>;
+		orientation = <0>; /* V4L2_CAMERA_ORIENTATION_FRONT */
+		rotation = <90>;
+
+		port {
+			ucam_out: endpoint {
+				remote-endpoint = <&mipi_in_ucam>;
+				data-lanes = <1 2 3 4>;
+			};
+		};
+	};
 };
 
 &i2c3 {
@@ -523,6 +544,24 @@ &io_domains {
 	status = "okay";
 };
 
+&isp0 {
+	status = "okay";
+
+	ports {
+		port@0 {
+			mipi_in_ucam: endpoint@0 {
+				reg = <0>;
+				remote-endpoint = <&ucam_out>;
+				data-lanes = <1 2 3 4>;
+			};
+		};
+	};
+};
+
+&isp0_mmu {
+	status = "okay";
+};
+
 &isp1 {
 	status = "okay";
 
@@ -598,6 +637,12 @@ camera {
 		wcam_rst: wcam-rst {
 			rockchip,pins = <1 RK_PA0 RK_FUNC_GPIO &pcfg_pull_none>;
 		};
+		ucam_rst: ucam-rst {
+			rockchip,pins = <1 RK_PA4 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+		ucam_pwdn: ucam-pwdn {
+			rockchip,pins = <2 RK_PB4 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
 	};
 
 	leds {

-- 
2.48.1


