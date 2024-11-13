Return-Path: <linux-kernel+bounces-407410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 13B179C6D1A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 11:45:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B34BB29E8D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 10:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10FD21FEFD9;
	Wed, 13 Nov 2024 10:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="n+iRLP5Q"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ECEE1FEFAB;
	Wed, 13 Nov 2024 10:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731494599; cv=none; b=VNbdl6fNHiQYLwki9nlMAN1RNz/iZWzZq6iJS+AIUBbuIyMG+Qkd3w5eAE9cCnpyUxRfIqhoAj4NqXYUeFJ0zzXwziRRkJINJX9bW6esEu3IuDAYZ3F5HgbxWAWpPNdpyRQSnDu7X9IewzK0p4Zxj2Xq9pn+Eg+fZW7rdFlE+mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731494599; c=relaxed/simple;
	bh=h40xhQ46kbUAWQX1WtBL9x9b1UvY110yo1B+sqO7KaA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=cUydEUAm/KXExzkxk5POEs5mcAIV/+FiUY8b6KjV2HgxyHHqDj0D5AtbzhiuBbFJgku3+1XYNSFaScxfkEYjUWv8GLpg4DlblmocqA4n1qpSdsoknLK4Dad+m8vtHdUswBELCwp05XnZBW1/fM20Sx9B5NC1+WKKuP5ITA2D+xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=n+iRLP5Q; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1B14CFF804;
	Wed, 13 Nov 2024 10:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1731494595;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Ixrjd5uZ9x2LFF0ZoaV1n0QKwuapda4UZQIU/cTO4co=;
	b=n+iRLP5Q4VlQ32AYwug3P/LoBvB7lIWa4X3UE//5tEFCB72k0eue63oBEUPwsWMMRFoBXZ
	dL0oSc7UjffMBdrarFA4jMdYfU1MPNMF/WLlAHFp5WIam0v8lvg7yP32x+pTjXvPB2vkMq
	IWlN6SIub6d1LGUHdsbH95SSPLkLxE4e25/37dDQRydokW4KbKTxFdei0thC7rH91Tt+8C
	qaqehhKbQZH9dOE2PvBtDXmTM5NYzC8nRz5m4ZKHXTI1ugh6wgjDwik54Tm5ztMmRR4MIo
	1lS4L0cI/chqhclho1six/yAqvJbhmNwZKtdQO049Tg9Yv/Wz5EXpTFu5lYYgQ==
From: Thomas Richard <thomas.richard@bootlin.com>
Date: Wed, 13 Nov 2024 11:43:05 +0100
Subject: [PATCH] arm64: dts: ti: k3-j784s4: use ti,j7200-padconf compatible
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241113-j784s4-s2r-pinctrl-v1-1-19aeb62739bc@bootlin.com>
X-B4-Tracking: v=1; b=H4sIALiCNGcC/x3MQQqDQAxA0atI1gYm01DFq4gLmcaaUkZJRASZu
 3fo8i3+v8HFVByG5gaTU123XEFtA2md81tQX9UQQ2Si0OOn69kZPRrumtNhX3zyQ2hOMRAnqOF
 usuj1n45TKT/vQCOYZAAAAA==
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Tero Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, gregory.clement@bootlin.com, 
 thomas.petazzoni@bootlin.com, richard.genoud@bootlin.com, u-kumar1@ti.com, 
 Thomas Richard <thomas.richard@bootlin.com>
X-Mailer: b4 0.14.1
X-GND-Sasl: thomas.richard@bootlin.com

Like on j7200, pinctrl contexts shall be saved and restored during
suspend-to-ram.

So use ti,j7200-padconf compatible.

Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>
---
Use ti,j7200-padconf compatible to save and restore pinctrl contexts during
suspend-to-ram.
---
 arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi       |  6 +++---
 arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi | 12 ++++++------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
index e73bb750b09a..b25d9a6aff2c 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
@@ -230,7 +230,7 @@ main_gpio_intr: interrupt-controller@a00000 {
 	};
 
 	main_pmx0: pinctrl@11c000 {
-		compatible = "pinctrl-single";
+		compatible = "ti,j7200-padconf", "pinctrl-single";
 		/* Proxy 0 addressing */
 		reg = <0x00 0x11c000 0x00 0x120>;
 		#pinctrl-cells = <1>;
@@ -240,7 +240,7 @@ main_pmx0: pinctrl@11c000 {
 
 	/* TIMERIO pad input CTRLMMR_TIMER*_CTRL registers */
 	main_timerio_input: pinctrl@104200 {
-		compatible = "pinctrl-single";
+		compatible = "ti,j7200-padconf", "pinctrl-single";
 		reg = <0x00 0x104200 0x00 0x50>;
 		#pinctrl-cells = <1>;
 		pinctrl-single,register-width = <32>;
@@ -249,7 +249,7 @@ main_timerio_input: pinctrl@104200 {
 
 	/* TIMERIO pad output CTCTRLMMR_TIMERIO*_CTRL registers */
 	main_timerio_output: pinctrl@104280 {
-		compatible = "pinctrl-single";
+		compatible = "ti,j7200-padconf", "pinctrl-single";
 		reg = <0x00 0x104280 0x00 0x20>;
 		#pinctrl-cells = <1>;
 		pinctrl-single,register-width = <32>;
diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi
index 2c97d1c7ebcd..36341665177f 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi
@@ -76,7 +76,7 @@ mcu_ram: sram@41c00000 {
 	};
 
 	wkup_pmx0: pinctrl@4301c000 {
-		compatible = "pinctrl-single";
+		compatible = "ti,j7200-padconf", "pinctrl-single";
 		/* Proxy 0 addressing */
 		reg = <0x00 0x4301c000 0x00 0x034>;
 		#pinctrl-cells = <1>;
@@ -85,7 +85,7 @@ wkup_pmx0: pinctrl@4301c000 {
 	};
 
 	wkup_pmx1: pinctrl@4301c038 {
-		compatible = "pinctrl-single";
+		compatible = "ti,j7200-padconf", "pinctrl-single";
 		/* Proxy 0 addressing */
 		reg = <0x00 0x4301c038 0x00 0x02c>;
 		#pinctrl-cells = <1>;
@@ -94,7 +94,7 @@ wkup_pmx1: pinctrl@4301c038 {
 	};
 
 	wkup_pmx2: pinctrl@4301c068 {
-		compatible = "pinctrl-single";
+		compatible = "ti,j7200-padconf", "pinctrl-single";
 		/* Proxy 0 addressing */
 		reg = <0x00 0x4301c068 0x00 0x120>;
 		#pinctrl-cells = <1>;
@@ -103,7 +103,7 @@ wkup_pmx2: pinctrl@4301c068 {
 	};
 
 	wkup_pmx3: pinctrl@4301c190 {
-		compatible = "pinctrl-single";
+		compatible = "ti,j7200-padconf", "pinctrl-single";
 		/* Proxy 0 addressing */
 		reg = <0x00 0x4301c190 0x00 0x004>;
 		#pinctrl-cells = <1>;
@@ -125,7 +125,7 @@ wkup_gpio_intr: interrupt-controller@42200000 {
 
 	/* MCU_TIMERIO pad input CTRLMMR_MCU_TIMER*_CTRL registers */
 	mcu_timerio_input: pinctrl@40f04200 {
-		compatible = "pinctrl-single";
+		compatible = "ti,j7200-padconf", "pinctrl-single";
 		reg = <0x00 0x40f04200 0x00 0x28>;
 		#pinctrl-cells = <1>;
 		pinctrl-single,register-width = <32>;
@@ -136,7 +136,7 @@ mcu_timerio_input: pinctrl@40f04200 {
 
 	/* MCU_TIMERIO pad output CTRLMMR_MCU_TIMERIO*_CTRL registers */
 	mcu_timerio_output: pinctrl@40f04280 {
-		compatible = "pinctrl-single";
+		compatible = "ti,j7200-padconf", "pinctrl-single";
 		reg = <0x00 0x40f04280 0x00 0x28>;
 		#pinctrl-cells = <1>;
 		pinctrl-single,register-width = <32>;

---
base-commit: eff6d7cad08c4ce4e3456fd7f8f1d94c81cd2b63
change-id: 20241108-j784s4-s2r-pinctrl-643e1ac2014c

Best regards,
-- 
Thomas Richard <thomas.richard@bootlin.com>


