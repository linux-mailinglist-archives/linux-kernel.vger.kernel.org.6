Return-Path: <linux-kernel+bounces-532504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A4E5A44EAB
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 22:20:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5655189C866
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 21:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 028281DF994;
	Tue, 25 Feb 2025 21:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oEfLsdZi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D9A2AEE4;
	Tue, 25 Feb 2025 21:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740518400; cv=none; b=a1Y55sFQmUtvXqFrgl7WN+LJBJByz+OHUsPwH/i7dgb0Lrn5PVz0eGQxYSOuaKa5WF8cSW9GS2CrLhc812++9W3w01Q/fsqdghZkU3DsMa5t3OteMemIKBDJXOiRqiEFEJiqvIjThUKXy84MxRxMIspeNQbJiLRwBOvMdzKz16A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740518400; c=relaxed/simple;
	bh=ghGqvv7GAFe1nH4x2u9vuYujrKPbpOccmWJvpRRHSB0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Q8ayB/pBHPjU6HAjrk0OJIEd64r3T/4aluFEVwRv1XQmz+kRPsarm2ysvBIJj1ngiLhdi4FgiO0+Y86bHuvNwkSUEsxxhpeqgaaEdX/IJnTwgxr6ju78AD6fnGFYB3QY8DRFoxFokphDIbt85jGUEefFBI1M+8emPnsGezLT0CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oEfLsdZi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1CB9EC4CEDD;
	Tue, 25 Feb 2025 21:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740518400;
	bh=ghGqvv7GAFe1nH4x2u9vuYujrKPbpOccmWJvpRRHSB0=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=oEfLsdZidnIj7asGdSYT+SxvKF0L4dS9GdI91lLDxuTpfI9v9DUnVfXSE4Oz5ZPAd
	 YB29VFmLy4Mz4ASTZqX0gYJ/OV3y7PzfEdXYNA0i9dxgk8P8Qy8/0w7Y0/XMrLY+vI
	 JR7JiVxPJmGGxMhglc/tDiz1V5dB9Oexp/SvHn6aeRlJC7XvUGlwxcq5+sa/m9Z8Yd
	 yc0vwG929D7/SIo90G+gOx7Jga1A2G584Tfeek0vUzr4sxXI/jq6L1RsoA6b+eyvTS
	 YUNOrhAqeXT1DrCJmvCn3t8PWq3WHCo2enUNxP/L5OcnTsGQLFQLi5oYMVeAS5lYn3
	 6XYT0dwRc0QDA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D316C021B2;
	Tue, 25 Feb 2025 21:20:00 +0000 (UTC)
From: Sasha Finkelstein via B4 Relay <devnull+fnkl.kernel.gmail.com@kernel.org>
Date: Tue, 25 Feb 2025 22:19:54 +0100
Subject: [PATCH] arm64: dts: apple: Add touchbar digitizer nodes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250225-z2-dts-v1-1-df101a7c17c8@gmail.com>
X-B4-Tracking: v=1; b=H4sIAPkzvmcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDIyNT3Soj3ZSSYt3URBMjQ+OUVJNEIyMloOKCotS0zAqwQdGxtbUANAL
 YuFgAAAA=
X-Change-ID: 20250225-z2-dts-ea4213de4a22
To: Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Janne Grunau <j@jannau.net>, Neal Gompa <neal@gompa.dev>, 
 Sasha Finkelstein <fnkl.kernel@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740518398; l=3677;
 i=fnkl.kernel@gmail.com; s=20241124; h=from:subject:message-id;
 bh=SeavfPLsBuaZJzKTxcJ2pMU97oNr50qsmltlLTUZBAI=;
 b=IUfKp0rV+n8SLeaZzuhEz2/BzCOvdP8DpjHRR8/QFLEjh1S/nritzhjqCFiwTm60uKcGoQUhS
 9UVzH2t39tdApIBmwR7Ffe/bhkqbKOeo/4fAKbwTsfJ3q1LtGrjPK6y
X-Developer-Key: i=fnkl.kernel@gmail.com; a=ed25519;
 pk=aSkp1PdZ+eF4jpMO6oLvz/YfT5XkBUneWwyhQrOgmsU=
X-Endpoint-Received: by B4 Relay for fnkl.kernel@gmail.com/20241124 with
 auth_id=283
X-Original-From: Sasha Finkelstein <fnkl.kernel@gmail.com>
Reply-To: fnkl.kernel@gmail.com

From: Sasha Finkelstein <fnkl.kernel@gmail.com>

Adds device tree entries for the touchbar digitizer

Co-developed-by: Janne Grunau <j@jannau.net>
Signed-off-by: Janne Grunau <j@jannau.net>
Reviewed-by: Neal Gompa <neal@gompa.dev>
Acked-by: Sven Peter <sven@svenpeter.dev>
Signed-off-by: Sasha Finkelstein <fnkl.kernel@gmail.com>
---
 arch/arm64/boot/dts/apple/t8103-j293.dts | 27 +++++++++++++++++++++++++++
 arch/arm64/boot/dts/apple/t8112-j493.dts | 23 +++++++++++++++++++++++
 arch/arm64/boot/dts/apple/t8112.dtsi     |  2 +-
 3 files changed, 51 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/apple/t8103-j293.dts b/arch/arm64/boot/dts/apple/t8103-j293.dts
index 56b0c67bfcda321b60c621de092643017693ff91..0a93d3891c23da8b8c77dce64001caacb69ee140 100644
--- a/arch/arm64/boot/dts/apple/t8103-j293.dts
+++ b/arch/arm64/boot/dts/apple/t8103-j293.dts
@@ -17,6 +17,14 @@ / {
 	compatible = "apple,j293", "apple,t8103", "apple,arm-platform";
 	model = "Apple MacBook Pro (13-inch, M1, 2020)";
 
+	/*
+	 * All of those are used by the bootloader to pass calibration
+	 * blobs and other device-specific properties
+	 */
+	aliases {
+		touchbar0 = &touchbar0;
+	};
+
 	led-controller {
 		compatible = "pwm-leds";
 		led-0 {
@@ -49,3 +57,22 @@ &i2c4 {
 &fpwm1 {
 	status = "okay";
 };
+
+&spi0 {
+	cs-gpios = <&pinctrl_ap 109 GPIO_ACTIVE_LOW>;
+	status = "okay";
+
+	touchbar0: touchbar@0 {
+		compatible = "apple,j293-touchbar";
+		reg = <0>;
+		spi-max-frequency = <11500000>;
+		spi-cs-setup-delay-ns = <2000>;
+		spi-cs-hold-delay-ns = <2000>;
+		reset-gpios = <&pinctrl_ap 139 GPIO_ACTIVE_LOW>;
+		interrupts-extended = <&pinctrl_ap 194 IRQ_TYPE_EDGE_FALLING>;
+		firmware-name = "apple/dfrmtfw-j293.bin";
+		touchscreen-size-x = <23045>;
+		touchscreen-size-y = <640>;
+		touchscreen-inverted-y;
+	};
+};
diff --git a/arch/arm64/boot/dts/apple/t8112-j493.dts b/arch/arm64/boot/dts/apple/t8112-j493.dts
index 0ad908349f55406783942735a2e9dad54cda00ec..045bd0716cb7d20c1379ebc1e3ff7f4d0dddc179 100644
--- a/arch/arm64/boot/dts/apple/t8112-j493.dts
+++ b/arch/arm64/boot/dts/apple/t8112-j493.dts
@@ -17,8 +17,13 @@ / {
 	compatible = "apple,j493", "apple,t8112", "apple,arm-platform";
 	model = "Apple MacBook Pro (13-inch, M2, 2022)";
 
+	/*
+	 * All of those are used by the bootloader to pass calibration
+	 * blobs and other device-specific properties
+	 */
 	aliases {
 		bluetooth0 = &bluetooth0;
+		touchbar0 = &touchbar0;
 		wifi0 = &wifi0;
 	};
 
@@ -67,3 +72,21 @@ &i2c4 {
 &fpwm1 {
 	status = "okay";
 };
+
+&spi3 {
+	status = "okay";
+
+	touchbar0: touchbar@0 {
+		compatible = "apple,j493-touchbar";
+		reg = <0>;
+		spi-max-frequency = <8000000>;
+		spi-cs-setup-delay-ns = <2000>;
+		spi-cs-hold-delay-ns = <2000>;
+		reset-gpios = <&pinctrl_ap 170 GPIO_ACTIVE_LOW>;
+		interrupts-extended = <&pinctrl_ap 174 IRQ_TYPE_EDGE_FALLING>;
+		firmware-name = "apple/dfrmtfw-j493.bin";
+		touchscreen-size-x = <23045>;
+		touchscreen-size-y = <640>;
+		touchscreen-inverted-y;
+	};
+};
diff --git a/arch/arm64/boot/dts/apple/t8112.dtsi b/arch/arm64/boot/dts/apple/t8112.dtsi
index 58d88f1ef92a32061765bd3b569fdae0255dcd7e..271986a7697f7033e96d11fb4ea6a50a467f0f2f 100644
--- a/arch/arm64/boot/dts/apple/t8112.dtsi
+++ b/arch/arm64/boot/dts/apple/t8112.dtsi
@@ -499,7 +499,7 @@ spi3: spi@23510c000 {
 			power-domains = <&ps_spi3>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-			status = "disabled";
+			status = "disabled"; /* only used in J493 */
 		};
 
 		serial0: serial@235200000 {

---
base-commit: 3febe9de5ca5267618675650871a626d0901f8cb
change-id: 20250225-z2-dts-ea4213de4a22



