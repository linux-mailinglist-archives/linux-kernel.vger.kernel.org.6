Return-Path: <linux-kernel+bounces-316931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42A6A96D732
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 13:32:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E05C31F25B0B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 11:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59104199252;
	Thu,  5 Sep 2024 11:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="kw16o/JK"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E40BF199934;
	Thu,  5 Sep 2024 11:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725535954; cv=none; b=XjlVmTJKIC7rLDoBVCylnPWCH00zSWVtGvQtZYUWU/iDVTjexkAzHvtN+u9Gs8YtHgGtGjPcGYMngxhTzYv3JS+H0BE2DklGu1JxZB2/km3A6FEOEcY2F3bgCe8mJlmLO8hueha4I5yGJ5K3fBcIqbtu+xCAH9gCZTFAF1iRnjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725535954; c=relaxed/simple;
	bh=8pgTWXKFnVm36YkNjWt4EqpXaxerwdD3Y7wKt9GJCn8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nzbuYSoVtTx643F4835IdGd/gdjYFGBPVZadKUpgt+7AcBE4xki1zWR6SUkSstfxPD6kLNBM2RyeZJeEKmEXmEdioBPd5Oucm29K723+xIY2AHq8UiCVdvBP8paLUfEdGJlQF+phH07bd09N4i6FT+4E7+IujpblTcPOZPEwiq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=kw16o/JK; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
From: Dragan Simic <dsimic@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1725535949;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=MITZUtkw5bagB0eVerd/j8Yzb+fVQlvaPcZds1xrZjs=;
	b=kw16o/JKlg5aGkXHHhhG/ITTlNiWvRjaihOKX5D3/SmPXrmaTcP0xsYTJ93b8yTd5iDKWV
	GN+sqCUIuV8VZOPPQxFamoBWhiVocioLwOiAygfY5NFtEpJwwz7VEfynjeGBFOA2U5Bwna
	VP3Ppa9xhu/2IsEL2Oy1st0XivEfx5TAIW0dqn1l4x0mYQ/wl67mLESlZ9pJm2P5ezyWQJ
	FaTb0YAG6m3LSx1/kZ328AJ/cr/bf3KQ68K6QLxmMIYkIrNg9S9d6gDJpyl5khC4jY0dDC
	9HZBwTiimAv54ojebZqvJlK0PxmzDHKBhuLRHkkWaVNdqlwcbtS4JwLey+7FMQ==
To: linux-rockchip@lists.infradead.org
Cc: heiko@sntech.de,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-kernel@vger.kernel.org,
	Diederik de Haas <didi.debian@cknow.org>
Subject: [PATCH] arm64: dts: rockchip: Add a few aliases to the PineTab2 dtsi
Date: Thu,  5 Sep 2024 13:32:19 +0200
Message-Id: <987e68d1c5e9a0cc56d730aec87246aa5ab8ea14.1725535770.git.dsimic@manjaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Sprinkle a few commonly used aliases onto the PineTab2 dtsi file, to improve
its readability a bit, to make it easier to refer to the actual nodes later,
if needed, and to add a bit more detail to some of the labels.

No functional changes are introduced, which was validated by decompiling and
comparing all affected board dtb files before and after these changes.  When
compared with the decompiled original dtb files, some of the phandles in the
updated dtb files have different values, and the updated dtb files contain
some additional phandles and additional symbols that come from the introduced
aliases, but they still effectively remain the same as the originals.

Suggested-by: Diederik de Haas <didi.debian@cknow.org>
Signed-off-by: Dragan Simic <dsimic@manjaro.org>
---

Notes:
    This patch wasn't tested on a PineTab2 before it was submitted to the
    mailing list, because I don't have that device, but Diederik has already
    agreed to test this patch on his PineTab2 and provide feedback.

 arch/arm64/boot/dts/rockchip/rk3566-pinetab2.dtsi | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3566-pinetab2.dtsi b/arch/arm64/boot/dts/rockchip/rk3566-pinetab2.dtsi
index db40281eafbe..04d98715ae6e 100644
--- a/arch/arm64/boot/dts/rockchip/rk3566-pinetab2.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3566-pinetab2.dtsi
@@ -41,7 +41,7 @@ button-vol-down {
 		};
 	};
 
-	backlight: backlight {
+	backlight: backlight-dsi {
 		compatible = "pwm-backlight";
 		pwms = <&pwm4 0 25000 0>;
 		brightness-levels = <20 220>;
@@ -551,20 +551,20 @@ regulator-state-mem {
 			};
 		};
 
-		charger {
+		rk817_charger: charger {
 			monitored-battery = <&battery>;
 			rockchip,resistor-sense-micro-ohms = <10000>;
 			rockchip,sleep-enter-current-microamp = <300000>;
 			rockchip,sleep-filter-current-microamp = <100000>;
 		};
 	};
 };
 
 &i2c1 {
 	clock-frequency = <400000>;
 	status = "okay";
 
-	touchscreen@5d {
+	touchscreen: touchscreen@5d {
 		compatible = "goodix,gt911";
 		reg = <0x5d>;
 		interrupt-parent = <&gpio0>;
@@ -583,13 +583,13 @@ &i2c2 {
 	pinctrl-0 = <&i2c2m1_xfer>;
 	status = "okay";
 
-	vcm@c {
+	vcm: vcm@c {
 		compatible = "dongwoon,dw9714";
 		reg = <0x0c>;
 		vcc-supply = <&vcc1v8_dvp>;
 	};
 
-	camera@36 {
+	camerab: camera@36 {
 		compatible = "ovti,ov5648";
 		reg = <0x36>;
 		pinctrl-names = "default";
@@ -619,7 +619,7 @@ &i2c5 {
 	clock-frequency = <400000>;
 	status = "okay";
 
-	accelerometer@18 {
+	accelerometer: accelerometer@18 {
 		compatible = "silan,sc7a20";
 		reg = <0x18>;
 		interrupt-parent = <&gpio3>;

