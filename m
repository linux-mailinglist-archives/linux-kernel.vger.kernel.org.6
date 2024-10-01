Return-Path: <linux-kernel+bounces-346239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 545A598C197
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 17:27:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12AB2282474
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 15:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2812F1CB501;
	Tue,  1 Oct 2024 15:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Iobx3EGf"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB5821C9ECC;
	Tue,  1 Oct 2024 15:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727796423; cv=none; b=RNY73G6PeppSopnh9hw+YAdg+v1cYjRBbvV77rlGN0mEtoLx6f3/FCSWm6RT+yZVYmmJyfCT7VpXCkEz+pvSJTbeyCsF02hRJavOnIVZlQg7J8D+ua/9YFMZKVzF4IMPHz9bwkrLeO3jEDqtj+UX0XjLbCeSk1QdJ4fNZagrT14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727796423; c=relaxed/simple;
	bh=trRBFATpR648P3udrT6WnKHGd1pf7C9JdpR92dcdcfU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n1iA4Yrx1GkTwlk1kDKa46Hnk16fbjQ1y+Ftm6SalSz9xVsErHNyIen+Ie/9357MNeTNbrpmcC+rIz0xIN0RW1WR6PneOUeU2TLx32i3dKYsrvlMmjVITDL8q3xzq0+N2yv0NOMN2gcACzRMStWbqm3rFkvSTfOgAh2Us/HhiO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Iobx3EGf; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1727796421; x=1759332421;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=trRBFATpR648P3udrT6WnKHGd1pf7C9JdpR92dcdcfU=;
  b=Iobx3EGftFw6aMuijubhHCPdV00VVZOXWszUptYj/SZsNKaUPJcCldcZ
   Xkna5qzaffzgL25cBfC39VE7yhmoyN9Lh4VQaDQirOcjKpmHMMlxbwEUB
   Q1kURg5kJk3HVou7h4uMDvTR3hYYZa+54WZ4Z4SujObIG0yie9hR/jQjd
   BO619Pv3TdPSKHlinycz9qyv3+Hi4ImT8t5qaKxnk2UJJhdw9mdOoQg7U
   xdH1gI50gzxsD2y8E76bEImF/WgWRnxsk5BARv7UgCURdBpzDiBRTl3lb
   ZOO39XN/53+ll4W7UifdhrPx3BR9ANRYxD5gx8BN+6mQN/wSYAR+LIFPX
   A==;
X-CSE-ConnectionGUID: C4iJhjyxTv2OpDXExwgrvQ==
X-CSE-MsgGUID: V/7H1qO2T8uKp3h4HKrElA==
X-IronPort-AV: E=Sophos;i="6.11,167,1725346800"; 
   d="scan'208";a="35727109"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Oct 2024 08:26:59 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 1 Oct 2024 08:26:46 -0700
Received: from ROB-ULT-M76677.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Tue, 1 Oct 2024 08:26:42 -0700
From: Andrei Simion <andrei.simion@microchip.com>
To: <nicolas.ferre@microchip.com>, <claudiu.beznea@tuxon.dev>,
	<alexandre.belloni@bootlin.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, Andrei Simion <andrei.simion@microchip.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 3/4] ARM: dts: microchip: Rename LED sub nodes name
Date: Tue, 1 Oct 2024 18:25:40 +0300
Message-ID: <20241001152541.91945-4-andrei.simion@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241001152541.91945-1-andrei.simion@microchip.com>
References: <20241001152541.91945-1-andrei.simion@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

dtbs_check warnings:
leds: 'd[0-9]', 'ds[0-9]' do not match any of the regexes :
'(^led-[0-9a-f]$|led)', 'pinctrl-[0-9]+'
leds: 'red', 'green', 'blue' do not match any of regexes :
'(^led-[0-9a-f]$|led)', 'pinctrl-[0-9]+'

Rename the led sub nodes according to devicetree specification and
leds-gpio.yaml

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Andrei Simion <andrei.simion@microchip.com>
---
v1 -> v2:
- add acked-by
- use pattern led-<old-label> when rename sub nodes
- rewrap commit message
---
 arch/arm/boot/dts/microchip/aks-cdu.dts        | 8 ++++----
 arch/arm/boot/dts/microchip/animeo_ip.dts      | 8 ++++----
 arch/arm/boot/dts/microchip/at91-sam9x60ek.dts | 6 +++---
 arch/arm/boot/dts/microchip/at91rm9200ek.dts   | 6 +++---
 arch/arm/boot/dts/microchip/at91sam9260ek.dts  | 4 ++--
 arch/arm/boot/dts/microchip/at91sam9261ek.dts  | 6 +++---
 arch/arm/boot/dts/microchip/at91sam9263ek.dts  | 4 ++--
 arch/arm/boot/dts/microchip/at91sam9g20ek.dts  | 4 ++--
 8 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/arch/arm/boot/dts/microchip/aks-cdu.dts b/arch/arm/boot/dts/microchip/aks-cdu.dts
index 742fcf525e1b..0c3373ad1723 100644
--- a/arch/arm/boot/dts/microchip/aks-cdu.dts
+++ b/arch/arm/boot/dts/microchip/aks-cdu.dts
@@ -98,23 +98,23 @@ rootfs@500000 {
 	leds {
 		compatible = "gpio-leds";
 
-		red {
+		led-red {
 			gpios = <&pioC 10 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "none";
 		};
 
-		green {
+		led-green {
 			gpios = <&pioA 5 GPIO_ACTIVE_LOW>;
 			linux,default-trigger = "none";
 			default-state = "on";
 		};
 
-		yellow {
+		led-yellow {
 			gpios = <&pioB 20 GPIO_ACTIVE_LOW>;
 			linux,default-trigger = "none";
 		};
 
-		blue {
+		led-blue {
 			gpios = <&pioB 21 GPIO_ACTIVE_LOW>;
 			linux,default-trigger = "none";
 		};
diff --git a/arch/arm/boot/dts/microchip/animeo_ip.dts b/arch/arm/boot/dts/microchip/animeo_ip.dts
index 29936bfbeeb7..7f527622d3f2 100644
--- a/arch/arm/boot/dts/microchip/animeo_ip.dts
+++ b/arch/arm/boot/dts/microchip/animeo_ip.dts
@@ -146,23 +146,23 @@ usb0: ohci@500000 {
 	leds {
 		compatible = "gpio-leds";
 
-		power_green {
+		led-power-green {
 			label = "power_green";
 			gpios = <&pioC 17 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "heartbeat";
 		};
 
-		power_red {
+		led-power-red {
 			label = "power_red";
 			gpios = <&pioA 2 GPIO_ACTIVE_HIGH>;
 		};
 
-		tx_green {
+		led-tx-green {
 			label = "tx_green";
 			gpios = <&pioC 19 GPIO_ACTIVE_HIGH>;
 		};
 
-		tx_red {
+		led-tx-red {
 			label = "tx_red";
 			gpios = <&pioC 18 GPIO_ACTIVE_HIGH>;
 		};
diff --git a/arch/arm/boot/dts/microchip/at91-sam9x60ek.dts b/arch/arm/boot/dts/microchip/at91-sam9x60ek.dts
index 3b38707d736e..c416cbe99580 100644
--- a/arch/arm/boot/dts/microchip/at91-sam9x60ek.dts
+++ b/arch/arm/boot/dts/microchip/at91-sam9x60ek.dts
@@ -53,17 +53,17 @@ leds {
 		pinctrl-0 = <&pinctrl_gpio_leds>;
 		status = "okay"; /* Conflict with pwm0. */
 
-		red {
+		led-red {
 			label = "red";
 			gpios = <&pioB 11 GPIO_ACTIVE_HIGH>;
 		};
 
-		green {
+		led-green {
 			label = "green";
 			gpios = <&pioB 12 GPIO_ACTIVE_HIGH>;
 		};
 
-		blue {
+		led-blue {
 			label = "blue";
 			gpios = <&pioB 13 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "heartbeat";
diff --git a/arch/arm/boot/dts/microchip/at91rm9200ek.dts b/arch/arm/boot/dts/microchip/at91rm9200ek.dts
index 4624a6f076f8..0bf472b157a5 100644
--- a/arch/arm/boot/dts/microchip/at91rm9200ek.dts
+++ b/arch/arm/boot/dts/microchip/at91rm9200ek.dts
@@ -127,19 +127,19 @@ root@350000  {
 	leds {
 		compatible = "gpio-leds";
 
-		ds2 {
+		led-ds2 {
 			label = "green";
 			gpios = <&pioB 0 GPIO_ACTIVE_LOW>;
 			linux,default-trigger = "mmc0";
 		};
 
-		ds4 {
+		led-ds4 {
 			label = "yellow";
 			gpios = <&pioB 1 GPIO_ACTIVE_LOW>;
 			linux,default-trigger = "heartbeat";
 		};
 
-		ds6 {
+		led-ds6 {
 			label = "red";
 			gpios = <&pioB 2 GPIO_ACTIVE_LOW>;
 		};
diff --git a/arch/arm/boot/dts/microchip/at91sam9260ek.dts b/arch/arm/boot/dts/microchip/at91sam9260ek.dts
index 6bd60dce8378..e8e65e60564d 100644
--- a/arch/arm/boot/dts/microchip/at91sam9260ek.dts
+++ b/arch/arm/boot/dts/microchip/at91sam9260ek.dts
@@ -174,13 +174,13 @@ eeprom@50 {
 	leds {
 		compatible = "gpio-leds";
 
-		ds1 {
+		led-ds1 {
 			label = "ds1";
 			gpios = <&pioA 9 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "heartbeat";
 		};
 
-		ds5 {
+		led-ds5 {
 			label = "ds5";
 			gpios = <&pioA 6 GPIO_ACTIVE_LOW>;
 		};
diff --git a/arch/arm/boot/dts/microchip/at91sam9261ek.dts b/arch/arm/boot/dts/microchip/at91sam9261ek.dts
index 045cb253f23a..a8f523131cd6 100644
--- a/arch/arm/boot/dts/microchip/at91sam9261ek.dts
+++ b/arch/arm/boot/dts/microchip/at91sam9261ek.dts
@@ -192,19 +192,19 @@ watchdog@fffffd40 {
 	leds {
 		compatible = "gpio-leds";
 
-		ds8 {
+		led-ds8 {
 			label = "ds8";
 			gpios = <&pioA 13 GPIO_ACTIVE_LOW>;
 			linux,default-trigger = "none";
 		};
 
-		ds7 {
+		led-ds7 {
 			label = "ds7";
 			gpios = <&pioA 14 GPIO_ACTIVE_LOW>;
 			linux,default-trigger = "nand-disk";
 		};
 
-		ds1 {
+		led-ds1 {
 			label = "ds1";
 			gpios = <&pioA 23 GPIO_ACTIVE_LOW>;
 			linux,default-trigger = "heartbeat";
diff --git a/arch/arm/boot/dts/microchip/at91sam9263ek.dts b/arch/arm/boot/dts/microchip/at91sam9263ek.dts
index bad7dbecba3c..f25692543d71 100644
--- a/arch/arm/boot/dts/microchip/at91sam9263ek.dts
+++ b/arch/arm/boot/dts/microchip/at91sam9263ek.dts
@@ -219,13 +219,13 @@ &pioA 21 GPIO_ACTIVE_HIGH
 	leds {
 		compatible = "gpio-leds";
 
-		d3 {
+		led-d3 {
 			label = "d3";
 			gpios = <&pioB 7 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "heartbeat";
 		};
 
-		d2 {
+		led-d2 {
 			label = "d2";
 			gpios = <&pioC 29 GPIO_ACTIVE_LOW>;
 			linux,default-trigger = "nand-disk";
diff --git a/arch/arm/boot/dts/microchip/at91sam9g20ek.dts b/arch/arm/boot/dts/microchip/at91sam9g20ek.dts
index 6de7a7cd3c07..1e62fd371ddb 100644
--- a/arch/arm/boot/dts/microchip/at91sam9g20ek.dts
+++ b/arch/arm/boot/dts/microchip/at91sam9g20ek.dts
@@ -14,13 +14,13 @@ / {
 	leds {
 		compatible = "gpio-leds";
 
-		ds1 {
+		led-ds1 {
 			label = "ds1";
 			gpios = <&pioA 9 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "heartbeat";
 		};
 
-		ds5 {
+		led-ds5 {
 			label = "ds5";
 			gpios = <&pioA 6 GPIO_ACTIVE_LOW>;
 		};
-- 
2.34.1


