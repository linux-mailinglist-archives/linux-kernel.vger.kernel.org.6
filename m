Return-Path: <linux-kernel+bounces-239276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 86F069258B7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 12:34:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 152961F28E54
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 10:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91F8317C200;
	Wed,  3 Jul 2024 10:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="bCdsGAWJ"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED31017BB34;
	Wed,  3 Jul 2024 10:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720002616; cv=none; b=OKaqRe7LBAnJq0rtfRBR5uNuhauBbm3gN5JTTXwT5wLWPWld1WMCEDnm6nAAUBZbgUGlsW2qpZcKK8jcOn5isA8qd2IxxWGrrNwa5mY1Ig29qpSmnV1byseuacPnbiDjEpX4P01EFzusEV5dKBpxRuV7iJuvJbE8eBXw5GNLgy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720002616; c=relaxed/simple;
	bh=/15Y3Zpi8Var8QL6+W+Mio28E5cOyXXOEi36jOEbS04=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e7vvAQqZH9hY8M69SOAMKGVgbfEs5oLw2R6cwFaqMZgVYxp1mrulxFRh2zuDw1naEMSatEWzXF4yvR6XgiY4uESSgwAUwVqJs100WRvfFbl0oeTkYNIVqGKTN4ss1MLRG3ukXMIiDfipgOlRjoeMKhCuN2tU66MtOgslvp7hh6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=fail smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=bCdsGAWJ; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1720002615; x=1751538615;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=/15Y3Zpi8Var8QL6+W+Mio28E5cOyXXOEi36jOEbS04=;
  b=bCdsGAWJWU53fCmYe2aFiLkzxu3/1nFdyBNG3qHNTFrPjkuEN4nwYmtq
   m9ZDxbTzNNKG9lkGqSdeKl6iQekYXDspSejsZ4V3X6V5jdkDXC4Er4beW
   eD97v/Z1l4BpBgtfEXPpIZDNIYO29cD/Zuq4vbPvkyXc+Aws5npS0yKxe
   UtM3MPFh2CZGQSIPrkWNuqI5VO2B2KWQOWtRAWxjtVjk/kGJ81hHxjET8
   eOcI1TWMAHEvV4iN7NXjGbFQ/iyGFB7VDnpnOUb8C0y1zIxlK0J4nSDD5
   jURXQXq5eIItb2lg0Ar48+DX/WijMOrl14VhtxKQXAOHorCtVFmBtijnR
   w==;
X-CSE-ConnectionGUID: hLLhwY7cQcOyno5TMnxZqQ==
X-CSE-MsgGUID: FghAYx1gRYSxDQ+Y/kzGpA==
X-IronPort-AV: E=Sophos;i="6.09,181,1716274800"; 
   d="scan'208";a="29441576"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 Jul 2024 03:30:12 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 3 Jul 2024 03:29:50 -0700
Received: from che-lt-i67070.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Wed, 3 Jul 2024 03:29:46 -0700
From: Varshini Rajendran <varshini.rajendran@microchip.com>
To: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>, <mihai.sain@microchip.com>,
	<varshini.rajendran@microchip.com>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v5 27/27] ARM: dts: microchip: sam9x75_curiosity: add sam9x75 curiosity board
Date: Wed, 3 Jul 2024 15:59:43 +0530
Message-ID: <20240703102943.196655-1-varshini.rajendran@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240703102011.193343-1-varshini.rajendran@microchip.com>
References: <20240703102011.193343-1-varshini.rajendran@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add device tree file for sam9x75 curiosity board.

Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
---
Changes in v5:
- Update commit message to match the directory structure.
- Alphanumerically sorted Makefile entries.
- Corrected VDDCore minimum voltage.
- Enabled the i2s node.
- Removed additional blank lines.
- Enclosed each entry with separate <>.
- Corrected pinctrl names to match Microchip convention.
- Enabled slewrate in sdmmc node.
- Corrected pinmux mask.
- Added phandle to leds for ease of access with upcoming device entries.
- Updated gpio pin number for red led.
---
 arch/arm/boot/dts/microchip/Makefile          |   3 +
 .../dts/microchip/at91-sam9x75_curiosity.dts  | 312 ++++++++++++++++++
 2 files changed, 315 insertions(+)
 create mode 100644 arch/arm/boot/dts/microchip/at91-sam9x75_curiosity.dts

diff --git a/arch/arm/boot/dts/microchip/Makefile b/arch/arm/boot/dts/microchip/Makefile
index 0c45c8d17468..470fe46433a9 100644
--- a/arch/arm/boot/dts/microchip/Makefile
+++ b/arch/arm/boot/dts/microchip/Makefile
@@ -2,6 +2,7 @@
 # Enables support for device-tree overlays
 DTC_FLAGS_at91-sam9x60_curiosity := -@
 DTC_FLAGS_at91-sam9x60ek := -@
+DTC_FLAGS_at91-sam9x75_curiosity := -@
 DTC_FLAGS_at91-sama5d27_som1_ek := -@
 DTC_FLAGS_at91-sama5d27_wlsom1_ek := -@
 DTC_FLAGS_at91-sama5d29_curiosity := -@
@@ -60,6 +61,8 @@ dtb-$(CONFIG_SOC_AT91SAM9) += \
 dtb-$(CONFIG_SOC_SAM9X60) += \
 	at91-sam9x60_curiosity.dtb \
 	at91-sam9x60ek.dtb
+dtb-$(CONFIG_SOC_SAM9X7) += \
+	at91-sam9x75_curiosity.dtb
 dtb-$(CONFIG_SOC_SAM_V7) += \
 	at91-kizbox2-2.dtb \
 	at91-kizbox3-hs.dtb \
diff --git a/arch/arm/boot/dts/microchip/at91-sam9x75_curiosity.dts b/arch/arm/boot/dts/microchip/at91-sam9x75_curiosity.dts
new file mode 100644
index 000000000000..4a4f14f13634
--- /dev/null
+++ b/arch/arm/boot/dts/microchip/at91-sam9x75_curiosity.dts
@@ -0,0 +1,312 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * at91-sam9x75_curiosity.dts - Device Tree file for Microchip SAM9X75 Curiosity board
+ *
+ * Copyright (C) 2023 Microchip Technology Inc. and its subsidiaries
+ *
+ * Author: Varshini Rajendran <varshini.rajendran@microchip.com>
+ */
+/dts-v1/;
+#include "sam9x7.dtsi"
+#include <dt-bindings/input/input.h>
+
+/ {
+	model = "Microchip SAM9X75 Curiosity";
+	compatible = "microchip,sam9x75-curiosity", "microchip,sam9x7", "atmel,at91sam9";
+
+	aliases {
+		i2c0 = &i2c6;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_key_gpio_default>;
+
+		button-user {
+			label = "USER";
+			gpios = <&pioC 9 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_0>;
+			wakeup-source;
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		led_red: led-red {
+			label = "red";
+			gpios = <&pioC 14 GPIO_ACTIVE_HIGH>;
+			pinctrl-0 = <&pinctrl_red_led_gpio_default>;
+		};
+
+		led_green: led-green {
+			label = "green";
+			gpios = <&pioC 21 GPIO_ACTIVE_HIGH>;
+			pinctrl-0 = <&pinctrl_green_led_gpio_default>;
+		};
+
+		led_blue: led-blue {
+			label = "blue";
+			gpios = <&pioC 20 GPIO_ACTIVE_HIGH>;
+			pinctrl-0 = <&pinctrl_blue_led_gpio_default>;
+			linux,default-trigger = "heartbeat";
+		};
+	};
+
+	memory@20000000 {
+		reg = <0x20000000 0x10000000>;
+		device_type = "memory";
+	};
+};
+
+&classd {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_classd_default>;
+	atmel,pwm-type = "diff";
+	atmel,non-overlap-time = <10>;
+	status = "okay";
+};
+
+&dbgu {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_dbgu_default>;
+	status = "okay";
+};
+
+&dma0 {
+	status = "okay";
+};
+
+&flx6 {
+	atmel,flexcom-mode = <ATMEL_FLEXCOM_MODE_TWI>;
+	status = "okay";
+};
+
+&i2c6 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_flx6_default>;
+	i2c-analog-filter;
+	i2c-digital-filter;
+	i2c-digital-filter-width-ns = <35>;
+	status = "okay";
+
+	pmic@5b {
+		compatible = "microchip,mcp16502";
+		reg = <0x5b>;
+
+		regulators {
+			vdd_3v3: VDD_IO {
+				regulator-name = "VDD_IO";
+				regulator-min-microvolt = <3000000>;
+				regulator-max-microvolt = <3600000>;
+				regulator-initial-mode = <2>;
+				regulator-allowed-modes = <2>, <4>;
+				regulator-always-on;
+
+				regulator-state-standby {
+					regulator-on-in-suspend;
+					regulator-mode = <4>;
+				};
+
+				regulator-state-mem {
+					regulator-mode = <4>;
+				};
+			};
+
+			vddioddr: VDD_DDR {
+				regulator-name = "VDD_DDR";
+				regulator-min-microvolt = <1283000>;
+				regulator-max-microvolt = <1450000>;
+				regulator-initial-mode = <2>;
+				regulator-allowed-modes = <2>, <4>;
+				regulator-always-on;
+
+				regulator-state-standby {
+					regulator-on-in-suspend;
+					regulator-mode = <4>;
+				};
+
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-mode = <4>;
+				};
+			};
+
+			vddcore: VDD_CORE {
+				regulator-name = "VDD_CORE";
+				regulator-min-microvolt = <1140000>;
+				regulator-max-microvolt = <1210000>;
+				regulator-initial-mode = <2>;
+				regulator-allowed-modes = <2>, <4>;
+				regulator-always-on;
+
+				regulator-state-standby {
+					regulator-on-in-suspend;
+					regulator-mode = <4>;
+				};
+
+				regulator-state-mem {
+					regulator-mode = <4>;
+				};
+			};
+
+			vddcpu: VDD_OTHER {
+				regulator-name = "VDD_OTHER";
+				regulator-min-microvolt = <1700000>;
+				regulator-max-microvolt = <3600000>;
+				regulator-initial-mode = <2>;
+				regulator-allowed-modes = <2>, <4>;
+				regulator-ramp-delay = <3125>;
+				regulator-always-on;
+
+				regulator-state-standby {
+					regulator-on-in-suspend;
+					regulator-mode = <4>;
+				};
+
+				regulator-state-mem {
+					regulator-mode = <4>;
+				};
+			};
+
+			vldo1: LDO1 {
+				regulator-name = "LDO1";
+				regulator-min-microvolt = <1200000>;
+				regulator-max-microvolt = <3700000>;
+				regulator-always-on;
+
+				regulator-state-standby {
+					regulator-on-in-suspend;
+				};
+			};
+
+			vldo2: LDO2 {
+				regulator-name = "LDO2";
+				regulator-min-microvolt = <1200000>;
+				regulator-max-microvolt = <3700000>;
+
+				regulator-state-standby {
+					regulator-on-in-suspend;
+				};
+			};
+		};
+	};
+};
+
+&i2s {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2s_default>;
+	#sound-dai-cells = <0>;
+	status = "okay";
+};
+
+&main_xtal {
+	clock-frequency = <24000000>;
+};
+
+&pinctrl {
+	classd {
+		pinctrl_classd_default: classd-default {
+			atmel,pins =
+				<AT91_PIOA 18 AT91_PERIPH_C AT91_PINCTRL_PULL_UP>,
+				<AT91_PIOA 19 AT91_PERIPH_C AT91_PINCTRL_PULL_DOWN>;
+		};
+	};
+
+	dbgu {
+		pinctrl_dbgu_default: dbgu-default {
+			atmel,pins = <AT91_PIOA 26 AT91_PERIPH_A AT91_PINCTRL_PULL_UP>,
+				     <AT91_PIOA 27 AT91_PERIPH_A AT91_PINCTRL_NONE>;
+		};
+	};
+
+	flexcom {
+		pinctrl_flx6_default: flx6-default {
+			atmel,pins =
+				<AT91_PIOA 24 AT91_PERIPH_A AT91_PINCTRL_PULL_UP>,
+				<AT91_PIOA 25 AT91_PERIPH_A AT91_PINCTRL_PULL_UP>;
+		};
+	};
+
+	gpio-keys {
+		pinctrl_key_gpio_default: key-gpio-default {
+			atmel,pins = <AT91_PIOC 9 AT91_PERIPH_GPIO AT91_PINCTRL_NONE>;
+		};
+	};
+
+	i2s {
+		pinctrl_i2s_default: i2s-default {
+			atmel,pins =
+				<AT91_PIOB 26 AT91_PERIPH_D AT91_PINCTRL_NONE>,		/* I2SCK */
+				<AT91_PIOB 15 AT91_PERIPH_D AT91_PINCTRL_NONE>,		/* I2SWS */
+				<AT91_PIOB 16 AT91_PERIPH_D AT91_PINCTRL_NONE>,		/* I2SDIN */
+				<AT91_PIOB 17 AT91_PERIPH_D AT91_PINCTRL_NONE>,		/* I2SDOUT */
+				<AT91_PIOB 25 AT91_PERIPH_D AT91_PINCTRL_NONE>;		/* I2SMCK */
+		};
+	};
+
+	leds {
+		pinctrl_red_led_gpio_default: red-led-gpio-default {
+			atmel,pins = <AT91_PIOC 14 AT91_PERIPH_GPIO AT91_PINCTRL_NONE>;
+		};
+		pinctrl_green_led_gpio_default: green-led-gpio-default {
+			atmel,pins = <AT91_PIOC 21 AT91_PERIPH_GPIO AT91_PINCTRL_NONE>;
+		};
+		pinctrl_blue_led_gpio_default: blue-led-gpio-default {
+			atmel,pins = <AT91_PIOC 20 AT91_PERIPH_GPIO AT91_PINCTRL_NONE>;
+		};
+	};
+
+	sdmmc0 {
+		pinctrl_sdmmc0_default: sdmmc0-default {
+			atmel,pins =
+				<AT91_PIOA 2 AT91_PERIPH_A (AT91_PINCTRL_DRIVE_STRENGTH_HI | AT91_PINCTRL_SLEWRATE_ENA)>,				/* PA2 CK  periph A with pullup */
+				<AT91_PIOA 1 AT91_PERIPH_A (AT91_PINCTRL_PULL_UP | AT91_PINCTRL_DRIVE_STRENGTH_HI | AT91_PINCTRL_SLEWRATE_ENA)>,	/* PA1 CMD periph A with pullup */
+				<AT91_PIOA 0 AT91_PERIPH_A (AT91_PINCTRL_PULL_UP | AT91_PINCTRL_DRIVE_STRENGTH_HI | AT91_PINCTRL_SLEWRATE_ENA)>,	/* PA0 DAT0 periph A */
+				<AT91_PIOA 3 AT91_PERIPH_A (AT91_PINCTRL_PULL_UP | AT91_PINCTRL_DRIVE_STRENGTH_HI | AT91_PINCTRL_SLEWRATE_ENA)>,	/* PA3 DAT1 periph A with pullup */
+				<AT91_PIOA 4 AT91_PERIPH_A (AT91_PINCTRL_PULL_UP | AT91_PINCTRL_DRIVE_STRENGTH_HI | AT91_PINCTRL_SLEWRATE_ENA)>,	/* PA4 DAT2 periph A with pullup */
+				<AT91_PIOA 5 AT91_PERIPH_A (AT91_PINCTRL_PULL_UP | AT91_PINCTRL_DRIVE_STRENGTH_HI | AT91_PINCTRL_SLEWRATE_ENA)>;	/* PA5 DAT3 periph A with pullup */
+		};
+	};
+}; /* pinctrl */
+
+&rtt {
+	atmel,rtt-rtc-time-reg = <&gpbr 0x0>;
+};
+
+&sdmmc0 {
+	bus-width = <4>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_sdmmc0_default>;
+	cd-gpios = <&pioA 23 GPIO_ACTIVE_LOW>;
+	disable-wp;
+	status = "okay";
+};
+
+&slow_xtal {
+	clock-frequency = <32768>;
+};
+
+&poweroff {
+	debounce-delay-us = <976>;
+	status = "okay";
+
+	input@0 {
+		reg = <0>;
+	};
+};
+
+&trng {
+	status = "okay";
+};
+
+&watchdog {
+	status = "okay";
+};
-- 
2.25.1


