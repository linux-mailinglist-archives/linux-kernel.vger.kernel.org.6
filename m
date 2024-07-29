Return-Path: <linux-kernel+bounces-265232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5635793EE2E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 09:13:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FA441C21A3B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 07:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87F9E13A400;
	Mon, 29 Jul 2024 07:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="yOKe+ke/"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B282512E1F9;
	Mon, 29 Jul 2024 07:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722237027; cv=none; b=p7jYBdby9JLkXP/VfLTNxn9tG9Ek8LANaDOp1L3h8X0tjpzUyLiSQEdSrXWvzU45j2axvSMeBKSG5MChr0G1B+BQxBWvt/0G9UA9CLrrZ6g45nL7qh2cH2mhlpm3hvexr/oYLF3MWBz/tNsmMhffW6W/IcE4iKZAzC+awXie6xM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722237027; c=relaxed/simple;
	bh=Fy03B8yiu2Way3mFHHeNbbjCDOG9ABmV+Hm8/1S0ELI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Nk4/pjpGbylobb2+s/3M9pR8bfuAjtkW29JHH+OBmYyii1lw66rfx2nLDeM/K915panoz6vupUoiEuNrce97JSTVqAe6/G9b29PKKReT3ayJtTXd74fZiHZ4b9PJNCmOQDI4jiOJfZvmNpmm1fq3SivZjFeiMDKDAqP57k/cRzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=yOKe+ke/; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1722237025; x=1753773025;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=Fy03B8yiu2Way3mFHHeNbbjCDOG9ABmV+Hm8/1S0ELI=;
  b=yOKe+ke/RYXXy+lgSDa8WgyOOh2YqTu5N7hngjtnlEZNxdvvjWZtcCat
   LHfKo2eB9jC5LFnUVO6mH9/F/tn7+3iYk6hcU3pNwzN3itQ8I9sZdnwah
   PvwaQ2NU6m6JtPIqu2N3ceRpwt/RVpUiOz3DB1yjI5wPSWjUe8WrJhwwY
   atXPpYFTfBFG8+qGMKyj7evpHFRqrkXi2BJXunapcoIKQ5d5/r16vGAzV
   iHa7ZNQwX3IpX14TyKIA/LQo0PQsTD1LN9V0WKYRWuC5EJTha7R5ijWed
   J8EpbzhZG+SHdkoWrQoveD7X0Ss2IlZq2G8hjJLjnEX79uB8tileGOm18
   A==;
X-CSE-ConnectionGUID: nya7fybtRtOcSI+sfk742g==
X-CSE-MsgGUID: y2pZL6FfS1eMFBrJtx4PDQ==
X-IronPort-AV: E=Sophos;i="6.09,245,1716274800"; 
   d="scan'208";a="32597015"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Jul 2024 00:10:23 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 29 Jul 2024 00:10:06 -0700
Received: from che-lt-i67070.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 29 Jul 2024 00:10:02 -0700
From: Varshini Rajendran <varshini.rajendran@microchip.com>
To: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>, <mihai.sain@microchip.com>,
	<varshini.rajendran@microchip.com>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v6 27/27] ARM: dts: microchip: sam9x75_curiosity: add sam9x75 curiosity board
Date: Mon, 29 Jul 2024 12:40:00 +0530
Message-ID: <20240729071000.1991575-1-varshini.rajendran@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240729065603.1986074-1-varshini.rajendran@microchip.com>
References: <20240729065603.1986074-1-varshini.rajendran@microchip.com>
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
Changes in v6:

 - Corrected the regulator voltages according to the schematics
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
index 000000000000..4cab66b317ba
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
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
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
+				regulator-min-microvolt = <1350000>;
+				regulator-max-microvolt = <1350000>;
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
+				regulator-min-microvolt = <1150000>;
+				regulator-max-microvolt = <1150000>;
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
+			dcdc4: VDD_OTHER {
+				regulator-name = "VDD_OTHER";
+				regulator-min-microvolt = <1150000>;
+				regulator-max-microvolt = <1150000>;
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
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
+
+				regulator-state-standby {
+					regulator-on-in-suspend;
+				};
+			};
+
+			vldo2: LDO2 {
+				regulator-name = "LDO2";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
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


