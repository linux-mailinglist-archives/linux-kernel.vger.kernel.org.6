Return-Path: <linux-kernel+bounces-347490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A778E98D35D
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 14:33:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D2DEB23CBE
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 12:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DC0B194A73;
	Wed,  2 Oct 2024 12:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Ra/btmZf"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7FEE1CF7B4;
	Wed,  2 Oct 2024 12:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727872342; cv=none; b=oF9oPHGUz6rx54MC2oM/Ppl0ryj7lE4aYGLN+2BGw/9gxO9FZ1oCJZpJ6c9dBWLQyhq4ugxBJ1Qp2M274EYOqfrT73M7w2axA7CKXMox09ruvw3zasrf+A+ZljQZ9WRh3YbnpqcWNqwY0wj7BLrNGghfqSJVEP6z47se8wK2Uio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727872342; c=relaxed/simple;
	bh=1KPMHR+qoSXWDATf97dUZSsEqXPn2O3scWgcw60WuUU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZKQsZo+iddItotSWDZo+vg3CMidVkDignLR2tJiwQa7tiOx31x6YWiMZmNgy7AQWYIWhfv173W3CNZXHMofaC0kNG2q+khIUrcMevB6yjBnTlZlLiK8BvCIy9LgiUvkaMODBY0UJEDNcyQn3Q7aQyP+khNPDJxjCQJTY+Vcv9VI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Ra/btmZf; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1727872341; x=1759408341;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1KPMHR+qoSXWDATf97dUZSsEqXPn2O3scWgcw60WuUU=;
  b=Ra/btmZf/3YMY5RJhHj1Led5VrGnyJSLY4HDVEI7ubiGPnL/PnZyIV2R
   CFu4Mf5a39UkQKIaFKRbzObCtH4ZocZoQIzujK2jP8mDF7nVFeNx1+rF2
   JxCOf5+cNpzw6dboeyRZvKRqVwZymCGwdWD8QHgtiUXdSYfOI1mfTsl4c
   ZYWFbBhNHetTGUpfVm5IOD5rIro0C5gWJ+WDy0FhoMlGaG+cpo9+GEBsu
   WOqhYv/OoU0jLLDv0yWFJOihtfBGqZOHJlysr57qCzs4cVDBB4k4XrJBV
   fmGX1K2zvNoqgsX0V9CKJ64Mn88KqwYZ8iMQdckXGI2xRzGclwp4JzFPd
   g==;
X-CSE-ConnectionGUID: bC3PJkpdQaubmgASvokKyw==
X-CSE-MsgGUID: vUrSO4urT4iKNZ4kxGhwhA==
X-IronPort-AV: E=Sophos;i="6.11,171,1725346800"; 
   d="scan'208";a="32506432"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Oct 2024 05:32:20 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 2 Oct 2024 05:31:05 -0700
Received: from ROB-ULT-M76677.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Wed, 2 Oct 2024 05:31:03 -0700
From: Andrei Simion <andrei.simion@microchip.com>
To: <nicolas.ferre@microchip.com>, <claudiu.beznea@tuxon.dev>,
	<alexandre.belloni@bootlin.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, Andrei Simion <andrei.simion@microchip.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 3/3] ARM: dts: microchip: Rename LED sub nodes name
Date: Wed, 2 Oct 2024 15:30:11 +0300
Message-ID: <20241002123010.111028-4-andrei.simion@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241002123010.111028-1-andrei.simion@microchip.com>
References: <20241002123010.111028-1-andrei.simion@microchip.com>
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
leds-gpio.yaml and for aks-cdu add label property and use the old node
name as value to stay stable and avoid breaking the userspace applications
that depend on those paths.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Andrei Simion <andrei.simion@microchip.com>
---
v2 -> v3:
- squash ARM: dts: microchip: aks-cdu: Add label for LED sub nodes
- update commit message

v1 -> v2:
- add acked-by
- use pattern led-<old-label> when rename sub nodes
- rewrap commit message
---
 arch/arm/boot/dts/microchip/aks-cdu.dts        | 12 ++++++++----
 arch/arm/boot/dts/microchip/animeo_ip.dts      |  8 ++++----
 arch/arm/boot/dts/microchip/at91-sam9x60ek.dts |  6 +++---
 arch/arm/boot/dts/microchip/at91rm9200ek.dts   |  6 +++---
 arch/arm/boot/dts/microchip/at91sam9260ek.dts  |  4 ++--
 arch/arm/boot/dts/microchip/at91sam9261ek.dts  |  6 +++---
 arch/arm/boot/dts/microchip/at91sam9263ek.dts  |  4 ++--
 arch/arm/boot/dts/microchip/at91sam9g20ek.dts  |  4 ++--
 8 files changed, 27 insertions(+), 23 deletions(-)

diff --git a/arch/arm/boot/dts/microchip/aks-cdu.dts b/arch/arm/boot/dts/microchip/aks-cdu.dts
index 742fcf525e1b..b65f80e1ef05 100644
--- a/arch/arm/boot/dts/microchip/aks-cdu.dts
+++ b/arch/arm/boot/dts/microchip/aks-cdu.dts
@@ -98,23 +98,27 @@ rootfs@500000 {
 	leds {
 		compatible = "gpio-leds";
 
-		red {
+		led-red {
+			label = "red";
 			gpios = <&pioC 10 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "none";
 		};
 
-		green {
+		led-green {
+			label = "green";
 			gpios = <&pioA 5 GPIO_ACTIVE_LOW>;
 			linux,default-trigger = "none";
 			default-state = "on";
 		};
 
-		yellow {
+		led-yellow {
+			label = "yellow";
 			gpios = <&pioB 20 GPIO_ACTIVE_LOW>;
 			linux,default-trigger = "none";
 		};
 
-		blue {
+		led-blue {
+			label = "blue";
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


