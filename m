Return-Path: <linux-kernel+bounces-439209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE9759EAC44
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 10:36:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A019284993
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 09:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E02011DC98F;
	Tue, 10 Dec 2024 09:33:03 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B2AA1DC988
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 09:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733823182; cv=none; b=dKjolXEK0PmqYf6cK1AJR96IiHus3vA++DvHzulWj/jUnrroz2SftxZ0BFcHY0g4IxIzN65A8xlobhBiYVEl90F453Jj54D1e/W9yJYCcQnQ2sBKQPnmQz3pBBFhcJif8tYd2rvz3ksDq5hSwm+DUmtAQTM2j2hLL3iCQYeJhDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733823182; c=relaxed/simple;
	bh=WFo8Hz2lV6TuVZvgZv4GloCAmcAc1zcPExjDCV8h1e8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=l/S8QFNQuATresMltsaZx8VgCEFLwnUmsdlJnrScjGUxwC9tOygJ2Rk0NnAaG1FgWD1EwpKQ7Rdaiw4fTtpiBZvnPGDatDtUeGbr24KvrviFHqAkGnec5at2SV8f3eBV3L29oT9QKbUGsq5/kE5nwNVRgX9vODaEVh/faAiprn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tKwbt-00016O-BO
	for linux-kernel@vger.kernel.org; Tue, 10 Dec 2024 10:32:53 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tKwbs-002fKl-0k
	for linux-kernel@vger.kernel.org;
	Tue, 10 Dec 2024 10:32:53 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 871D638A556
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 09:32:52 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 8BD1138A532;
	Tue, 10 Dec 2024 09:32:49 +0000 (UTC)
Received: from [172.20.34.65] (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 37cba87c;
	Tue, 10 Dec 2024 09:32:48 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Tue, 10 Dec 2024 10:32:28 +0100
Subject: [PATCH stm32-next 2/2] ARM: dts: stm32: lxa-fairytux2: add Linux
 Automation GmbH FairyTux 2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241210-lxa-fairytux-v1-2-9aea01cdb83e@pengutronix.de>
References: <20241210-lxa-fairytux-v1-0-9aea01cdb83e@pengutronix.de>
In-Reply-To: <20241210-lxa-fairytux-v1-0-9aea01cdb83e@pengutronix.de>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: kernel@pengutronix.de, devicetree@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Marc Kleine-Budde <mkl@pengutronix.de>, 
 =?utf-8?q?Leonard_G=C3=B6hrs?= <l.goehrs@pengutronix.de>
X-Mailer: b4 0.15-dev-355e8
X-Developer-Signature: v=1; a=openpgp-sha256; l=17560; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=NVATP1Z4sT+6XQFcI41C+1lB79mOE2ABG4Cuxlzn66E=;
 b=owEBbQGS/pANAwAKASg4oj56LbxvAcsmYgBnWAq9rzNIMq8zKAeWbnuOjj9kEsOBT8A6NDLJB
 KBYU0PePS+JATMEAAEKAB0WIQRQQLqG4LYE3Sm8Pl8oOKI+ei28bwUCZ1gKvQAKCRAoOKI+ei28
 bzuJB/47Vc+tumKHlzoMiOPWSnI0L999hdtsmFrk5ilrJ+U18vnjbkhkC3IaCYCJZJc5PlCRrfY
 imPnACvZ47Tbs3FT0dZakhOgOgZWwe/iRPkz6I0n4wFtFEKGrUuyH6zr9V9yLOE8g/8cYZL8U6R
 nn/h5TDkonMYvaHHJqGOo1B2GXpzKqJB7w+/MEl9pm0em2lGkaHkIkGnlLgQXxgE0ssx+qjXq4p
 rgm0EMIobm/eHw2b7ORl3uREJxUhLy5j247GbIGy1EkiNzdqr6h/6rbdBcfnMKUc18KRyUgDa/L
 6PECG9Wc0BQVfNf7C2sDoZRYSCEsqPcFFCG5JcA8tXpvz6VF
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

From: Leonard Göhrs <l.goehrs@pengutronix.de>

The Linux Automation GmbH FairyTux2 is a small Linux device based on
an Octavo Systems OSD32MP153c SiP, that occupies just two slots on a
DIN rail.

The device contains an eMMC for storage, a gigabit Ethernet
connection, a CAN bus and a RS485 transceiver.

Add support for the lxa-fairytux2 generation 1 and 2 boards based on
the STM32MP153c.

Signed-off-by: Leonard Göhrs <l.goehrs@pengutronix.de>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 arch/arm/boot/dts/st/Makefile                      |   2 +
 .../boot/dts/st/stm32mp153c-lxa-fairytux2-gen1.dts | 101 ++++++
 .../boot/dts/st/stm32mp153c-lxa-fairytux2-gen2.dts | 146 ++++++++
 .../arm/boot/dts/st/stm32mp153c-lxa-fairytux2.dtsi | 394 +++++++++++++++++++++
 4 files changed, 643 insertions(+)

diff --git a/arch/arm/boot/dts/st/Makefile b/arch/arm/boot/dts/st/Makefile
index b7d5d305cbbeb78cfae9fab05271992959f6fa56..f68da19d7cbf33fc5424e4900d301b2706d03e5e 100644
--- a/arch/arm/boot/dts/st/Makefile
+++ b/arch/arm/boot/dts/st/Makefile
@@ -39,6 +39,8 @@ dtb-$(CONFIG_ARCH_STM32) += \
 	stm32mp151c-mect1s.dtb \
 	stm32mp153c-dhcom-drc02.dtb \
 	stm32mp153c-dhcor-drc-compact.dtb \
+	stm32mp153c-lxa-fairytux2-gen1.dtb \
+	stm32mp153c-lxa-fairytux2-gen2.dtb \
 	stm32mp153c-lxa-tac-gen3.dtb \
 	stm32mp153c-mecio1r1.dtb \
 	stm32mp157a-avenger96.dtb \
diff --git a/arch/arm/boot/dts/st/stm32mp153c-lxa-fairytux2-gen1.dts b/arch/arm/boot/dts/st/stm32mp153c-lxa-fairytux2-gen1.dts
new file mode 100644
index 0000000000000000000000000000000000000000..a70de0f47afb21f36bf4c74a928910b10adc762f
--- /dev/null
+++ b/arch/arm/boot/dts/st/stm32mp153c-lxa-fairytux2-gen1.dts
@@ -0,0 +1,101 @@
+// SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-3-Clause)
+/*
+ * Copyright (C) 2024 Leonard Göhrs, Pengutronix
+ */
+
+/dts-v1/;
+
+#include "stm32mp153c-lxa-fairytux2.dtsi"
+
+/ {
+	model = "Linux Automation GmbH FairyTux 2 Gen 1";
+	compatible = "lxa,stm32mp153c-fairytux2-gen1", "oct,stm32mp153x-osd32", "st,stm32mp153";
+
+	gpio-keys {
+		compatible = "gpio-keys";
+
+		button-left {
+			label = "USER_BTN1";
+			linux,code = <KEY_ESC>;
+			gpios = <&gpioi 11 (GPIO_ACTIVE_LOW | GPIO_PULL_UP)>;
+		};
+
+		button-right {
+			label = "USER_BTN2";
+			linux,code = <KEY_HOME>;
+			gpios = <&gpioe 9 (GPIO_ACTIVE_LOW | GPIO_PULL_UP)>;
+		};
+	};
+};
+
+&gpiof {
+	gpio-line-names = "GPIO1", "GPIO2", "", "", "", /*  0 */
+	"", "", "", "", "",                             /*  5 */
+	"", "", "", "", "",                             /* 10 */
+	"";                                             /* 15 */
+};
+
+&gpioh {
+	gpio-line-names = "", "", "", "", "LCD_RESET", /*  0 */
+	"", "", "", "", "",                            /*  5 */
+	"", "", "", "GPIO3", "",                       /* 10 */
+	"";                                            /* 15 */
+};
+
+&gpioi {
+	gpio-line-names = "", "", "", "", "", /*  0 */
+	"", "", "", "ETH_", "",               /*  5 */
+	"", "USER_BTN1";                      /* 10 */
+};
+
+&i2c1 {
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&i2c1_pins_b>;
+	pinctrl-1 = <&i2c1_sleep_pins_b>;
+	status = "okay";
+
+	io_board_gpio: tca6408@20 {
+		compatible = "ti,tca6408";
+		reg = <0x20>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		vcc-supply = <&v3v3_hdmi>;
+		gpio-line-names = "LED1_GA_YK", "LED2_GA_YK", "LED1_GK_YA", "LED2_GK_YA",
+		"RS485_EN", "RS485_120R", "", "CAN_120R";
+	};
+};
+
+&led_controller_io {
+	/*
+	 * led-2 and led-3 are internally connected antiparallel to one
+	 * another inside the ethernet jack like this:
+	 * GPIO1 ---+---|led-2|>--+--- GPIO3
+	 *          +--<|led-3|---+
+	 * E.g. only one of the LEDs can be illuminated at a time while
+	 * the other output must be driven low.
+	 * This should likely be implemented using a multi color LED
+	 * driver for antiparallel LEDs.
+	 */
+	led-2 {
+		label = "fairytux2:green:act";
+		gpios = <&io_board_gpio 1 GPIO_ACTIVE_HIGH>;
+	};
+
+	led-3 {
+		label = "fairytux2:orange:act";
+		gpios = <&io_board_gpio 3 GPIO_ACTIVE_HIGH>;
+	};
+};
+
+&usart3 {
+	/*
+	 * On Gen 1 FairyTux 2 only RTS can be used and not CTS as well,
+	 * Because pins PD11 (CTS) and PI11 (USER_BTN1) share the same
+	 * interrupt and only one of them can be used at a time.
+	 */
+	rts-gpios = <&gpiod 12 GPIO_ACTIVE_LOW>;
+};
+
+&usbotg_hs {
+	dr_mode = "peripheral";
+};
diff --git a/arch/arm/boot/dts/st/stm32mp153c-lxa-fairytux2-gen2.dts b/arch/arm/boot/dts/st/stm32mp153c-lxa-fairytux2-gen2.dts
new file mode 100644
index 0000000000000000000000000000000000000000..c84f83a75731f70165c240812f7f4230bf9bfbb0
--- /dev/null
+++ b/arch/arm/boot/dts/st/stm32mp153c-lxa-fairytux2-gen2.dts
@@ -0,0 +1,146 @@
+// SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-3-Clause)
+/*
+ * Copyright (C) 2024 Leonard Göhrs, Pengutronix
+ */
+
+/dts-v1/;
+
+#include "stm32mp153c-lxa-fairytux2.dtsi"
+
+/ {
+	model = "Linux Automation GmbH FairyTux 2 Gen 2";
+	compatible = "lxa,stm32mp153c-fairytux2-gen2", "oct,stm32mp153x-osd32", "st,stm32mp153";
+
+	gpio-keys {
+		compatible = "gpio-keys";
+
+		button-left {
+			label = "USER_BTN1";
+			linux,code = <KEY_ESC>;
+			gpios = <&gpioi 10 (GPIO_ACTIVE_LOW | GPIO_PULL_UP)>;
+		};
+
+		button-right {
+			label = "USER_BTN2";
+			linux,code = <KEY_HOME>;
+			gpios = <&gpioe 9 (GPIO_ACTIVE_LOW | GPIO_PULL_UP)>;
+		};
+	};
+};
+
+&gpiof {
+	gpio-line-names = "", "", "", "", "", /*  0 */
+	"", "", "", "", "",                   /*  5 */
+	"", "", "", "", "",                   /* 10 */
+	"";                                   /* 15 */
+};
+
+&gpioh {
+	gpio-line-names = "", "", "", "", "LCD_RESET", /*  0 */
+	"", "", "", "", "",                            /*  5 */
+	"", "", "GPIO1", "GPIO_INT", "",               /* 10 */
+	"";                                            /* 15 */
+};
+
+&gpioi {
+	gpio-line-names = "GPIO2", "", "", "", "", /*  0 */
+	"", "", "", "ETH_", "",                    /*  5 */
+	"", "USER_BTN1";                           /* 10 */
+};
+
+&i2c1 {
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&i2c1_pins_b>;
+	pinctrl-1 = <&i2c1_sleep_pins_b>;
+	status = "okay";
+
+	io_board_gpio: tca6408@20 {
+		compatible = "ti,tca6408";
+		reg = <0x20>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-parent = <&gpioh>;
+		interrupts = <13 IRQ_TYPE_LEVEL_LOW>;
+		interrupt-controller;
+		pinctrl-names = "default";
+		pinctrl-0 = <&board_tca6408_pins>;
+		#interrupt-cells = <2>;
+		vcc-supply = <&v3v3_hdmi>;
+		gpio-line-names = "LED1_GA_YK", "LED2_GA_YK", "LED1_GK_YA", "USB_CC_ALERT",
+		"RS485_EN", "RS485_120R", "USB_CC_RESET", "CAN_120R";
+	};
+
+	usb_c: stusb1600@28 {
+		compatible = "st,stusb1600";
+		reg = <0x28>;
+		interrupt-parent = <&io_board_gpio>;
+		interrupts = <3 IRQ_TYPE_EDGE_FALLING>;
+		vdd-supply = <&reg_5v>;
+		vsys-supply = <&v3v3_hdmi>;
+
+		connector {
+			compatible = "usb-c-connector";
+			label = "USB-C";
+			power-role = "dual";
+			typec-power-opmode = "default";
+
+			port {
+				con_usbotg_hs_ep: endpoint {
+					remote-endpoint = <&usbotg_hs_ep>;
+				};
+			};
+		};
+	};
+
+	io_board_eeprom: eeprom@56 {
+		compatible = "atmel,24c04";
+		reg = <0x56>;
+		vcc-supply = <&v3v3_hdmi>;
+	};
+
+	temperature-sensor@48 {
+		compatible = "national,lm75a";
+		reg = <0x48>;
+		/*
+		 * The sensor itself is powered by a voltage divider from the
+		 * always-on 5V supply.
+		 * The required pull-up resistors however are on v3v3_hdmi.
+		 */
+		vs-supply = <&v3v3_hdmi>;
+	};
+};
+
+&rtc {
+	status = "okay";
+};
+
+&led_controller_io {
+	led-2 {
+		label = "fairytux2:orange:act";
+		gpios = <&io_board_gpio 1 GPIO_ACTIVE_LOW>;
+	};
+};
+
+&usart3 {
+	rts-gpios = <&gpiod 12 GPIO_ACTIVE_LOW>;
+	cts-gpios = <&gpiod 11 GPIO_ACTIVE_LOW>;
+};
+
+&usbotg_hs {
+	usb-role-switch;
+
+	port {
+		usbotg_hs_ep: endpoint {
+			remote-endpoint = <&con_usbotg_hs_ep>;
+		};
+	};
+};
+
+&pinctrl {
+	board_tca6408_pins: stusb1600-0 {
+		pins {
+			pinmux = <STM32_PINMUX('H', 13, GPIO)>;
+			bias-pull-up;
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/st/stm32mp153c-lxa-fairytux2.dtsi b/arch/arm/boot/dts/st/stm32mp153c-lxa-fairytux2.dtsi
new file mode 100644
index 0000000000000000000000000000000000000000..0e0e1b36cb087dfbfb47e383094c6044786a2c6a
--- /dev/null
+++ b/arch/arm/boot/dts/st/stm32mp153c-lxa-fairytux2.dtsi
@@ -0,0 +1,394 @@
+// SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-3-Clause)
+/*
+ * Copyright (C) 2020 STMicroelectronics - All Rights Reserved
+ * Copyright (C) 2021 Rouven Czerwinski, Pengutronix
+ * Copyright (C) 2023, 2024 Leonard Göhrs, Pengutronix
+ */
+
+#include "stm32mp153.dtsi"
+#include "stm32mp15xc.dtsi"
+#include "stm32mp15xx-osd32.dtsi"
+#include "stm32mp15xxac-pinctrl.dtsi"
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/leds/common.h>
+#include <dt-bindings/pwm/pwm.h>
+
+/ {
+	aliases {
+		can0 = &m_can1;
+		ethernet0 = &ethernet0;
+		i2c0 = &i2c1;
+		i2c1 = &i2c4;
+		mmc1 = &sdmmc2;
+		serial0 = &uart4;
+		serial1 = &usart3;
+		spi0 = &spi4;
+	};
+
+	chosen {
+		stdout-path = &uart4;
+	};
+
+	backlight: backlight {
+		compatible = "pwm-backlight";
+		power-supply = <&v3v3>;
+
+		brightness-levels = <0 31 63 95 127 159 191 223 255>;
+		default-brightness-level = <7>;
+		pwms = <&led_pwm 3 1000000 0>;
+	};
+
+	led-controller-cpu {
+		compatible = "gpio-leds";
+
+		led-0 {
+			label = "fairytux2:green:status";
+			gpios = <&gpioa 13 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "heartbeat";
+		};
+	};
+
+	led_controller_io: led-controller-io {
+		compatible = "gpio-leds";
+
+		/*
+		 * led-0 and led-1 are internally connected antiparallel to one
+		 * another inside the ethernet jack like this:
+		 * GPIO0 ---+---|led-0|>--+--- GPIO2
+		 *          +--<|led-1|---+
+		 * E.g. only one of the LEDs can be illuminated at a time while
+		 * the other output must be driven low.
+		 * This should likely be implemented using a multi color LED
+		 * driver for antiparallel LEDs.
+		 */
+		led-0 {
+			label = "fairytux2:green:link";
+			gpios = <&io_board_gpio 0 GPIO_ACTIVE_HIGH>;
+		};
+
+		led-1 {
+			label = "fairytux2:orange:link";
+			gpios = <&io_board_gpio 2 GPIO_ACTIVE_HIGH>;
+		};
+	};
+
+	reg_5v: regulator-5v {
+		compatible = "regulator-fixed";
+		regulator-name = "5V";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-always-on;
+	};
+
+	reg_1v2: regulator-1v2 {
+		compatible = "regulator-fixed";
+		regulator-name = "1V2";
+		regulator-min-microvolt = <1200000>;
+		regulator-max-microvolt = <1200000>;
+		regulator-always-on;
+		vin-supply = <&reg_5v>;
+	};
+};
+
+baseboard_eeprom: &sip_eeprom {
+};
+
+&crc1 {
+	status = "okay";
+};
+
+&cryp1 {
+	status = "okay";
+};
+
+&dts {
+	status = "okay";
+};
+
+&ethernet0 {
+	assigned-clocks = <&rcc ETHCK_K>, <&rcc PLL4_P>;
+	assigned-clock-parents = <&rcc PLL4_P>;
+	assigned-clock-rates = <125000000>; /* Clock PLL4 to 750Mhz in ATF */
+
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&ethernet0_rgmii_pins_b>;
+	pinctrl-1 = <&ethernet0_rgmii_sleep_pins_b>;
+
+	st,eth-clk-sel;
+	phy-mode = "rgmii-id";
+	phy-handle = <&ethphy>;
+	status = "okay";
+
+	mdio {
+		compatible = "snps,dwmac-mdio";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		ethphy: ethernet-phy@3 { /* KSZ9031RN */
+			reg = <3>;
+			reset-gpios = <&gpioe 11 GPIO_ACTIVE_LOW>; /* ETH_RST# */
+			interrupt-parent = <&gpioa>;
+			interrupts = <6 IRQ_TYPE_EDGE_FALLING>; /* ETH_MDINT# */
+			reset-assert-us = <10000>;
+			reset-deassert-us = <300>;
+			micrel,force-master;
+		};
+	};
+};
+
+&gpioa {
+	gpio-line-names = "", "", "", "", "", /*  0 */
+	"", "ETH_INT", "", "", "",            /*  5 */
+	"", "", "", "BOOTROM_LED", "",        /* 10 */
+	"";                                   /* 15 */
+};
+
+&gpiob {
+	gpio-line-names = "", "", "", "", "", /*  0 */
+	"", "", "", "", "",                   /*  5 */
+	"", "", "", "", "",                   /* 10 */
+	"";                                   /* 15 */
+};
+
+&gpioc {
+	gpio-line-names = "", "", "", "", "", /*  0 */
+	"", "", "", "", "",                   /*  5 */
+	"", "";                               /* 10 */
+};
+
+&gpiod {
+	gpio-line-names = "", "", "", "", "", /*  0 */
+	"", "", "LCD_TE", "", "",             /*  5 */
+	"LCD_DC", "", "", "", "",             /* 10 */
+	"";                                   /* 15 */
+};
+
+&gpioe {
+	gpio-line-names = "LCD_CS", "", "", "", "", /*  0 */
+	"", "", "", "", "",                         /*  5 */
+	"", "", "", "", "",                         /* 10 */
+	"";                                         /* 15 */
+};
+
+&gpiof {
+	gpio-line-names = "GPIO1", "GPIO2", "", "", "", /*  0 */
+	"", "", "", "", "",                             /*  5 */
+	"", "", "", "", "",                             /* 10 */
+	"";                                             /* 15 */
+};
+
+&gpiog {
+	gpio-line-names = "", "", "", "", "", /*  0 */
+	"", "", "", "", "",                   /*  5 */
+	"", "", "", "", "",                   /* 10 */
+	"";                                   /* 15 */
+};
+
+&gpioz {
+	gpio-line-names = "HWID0", "HWID1", "HWID2", "HWID3", "", /*  0 */
+	"", "HWID4", "HWID5";                                     /*  5 */
+};
+
+&hash1 {
+	status = "okay";
+};
+
+&iwdg2 {
+	timeout-sec = <8>;
+	status = "okay";
+};
+
+&m_can1 {
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&m_can1_pins_b>;
+	pinctrl-1 = <&m_can1_sleep_pins_b>;
+	status = "okay";
+	termination-gpios = <&io_board_gpio 7 GPIO_ACTIVE_HIGH>;
+	termination-ohms = <120>;
+};
+
+&pmic {
+	regulators {
+		buck1-supply = <&reg_5v>;	/* VIN */
+		buck2-supply = <&reg_5v>;	/* VIN */
+		buck3-supply = <&reg_5v>;	/* VIN */
+		buck4-supply = <&reg_5v>;	/* VIN */
+		ldo2-supply = <&reg_5v>;	/* PMIC_LDO25IN */
+		ldo4-supply = <&reg_5v>;	/* VIN */
+		ldo5-supply = <&reg_5v>;	/* PMIC_LDO25IN */
+		vref_ddr-supply = <&reg_5v>;	/* VIN */
+		boost-supply = <&reg_5v>;	/* PMIC_BSTIN */
+		pwr_sw2-supply = <&bst_out>;	/* PMIC_SWIN */
+	};
+};
+
+&pwr_regulators {
+	vdd-supply = <&vdd>;
+	vdd_3v3_usbfs-supply = <&vdd_usb>;
+};
+
+&sdmmc2 {
+	pinctrl-names = "default", "opendrain", "sleep";
+	pinctrl-0 = <&sdmmc2_b4_pins_a &sdmmc2_d47_pins_b>;
+	pinctrl-1 = <&sdmmc2_b4_od_pins_a &sdmmc2_d47_pins_b>;
+	pinctrl-2 = <&sdmmc2_b4_sleep_pins_a &sdmmc2_d47_sleep_pins_b>;
+	vmmc-supply = <&v3v3>;
+
+	bus-width = <8>;
+	mmc-ddr-3_3v;
+	no-1-8-v;
+	non-removable;
+	no-sd;
+	no-sdio;
+	st,neg-edge;
+
+	status = "okay";
+};
+
+&spi4 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&spi4_pins_a>;
+	cs-gpios = <&gpioe 0 GPIO_ACTIVE_LOW>;
+	status = "okay";
+
+	lcd: display@0 {
+		compatible = "shineworld,lh133k", "panel-mipi-dbi-spi";
+		reg = <0>;
+		power-supply = <&v3v3>;
+		io-supply = <&v3v3>;
+		backlight = <&backlight>;
+		dc-gpios = <&gpiod 10 GPIO_ACTIVE_HIGH>;
+		reset-gpios = <&gpioh 4 GPIO_ACTIVE_HIGH>;
+		spi-3wire;
+		spi-max-frequency = <32000000>;
+
+		width-mm = <23>;
+		height-mm = <23>;
+		rotation = <180>;
+
+		panel-timing {
+			hactive = <240>;
+			vactive = <240>;
+			hback-porch = <0>;
+			vback-porch = <0>;
+
+			clock-frequency = <0>;
+			hfront-porch = <0>;
+			hsync-len = <0>;
+			vfront-porch = <0>;
+			vsync-len = <0>;
+		};
+	};
+};
+
+&timers2 {
+	/* spare dmas for other usage */
+	/delete-property/dmas;
+	/delete-property/dma-names;
+
+	status = "okay";
+
+	timer@1 {
+		status = "okay";
+	};
+};
+
+&timers3 {
+	/* spare dmas for other usage */
+	/delete-property/dmas;
+	/delete-property/dma-names;
+
+	status = "okay";
+
+	timer@2 {
+		status = "okay";
+	};
+};
+
+&timers4 {
+	/* spare dmas for other usage */
+	/delete-property/dmas;
+	/delete-property/dma-names;
+
+	status = "okay";
+
+	timer@3 {
+		status = "okay";
+	};
+};
+
+&timers8 {
+	/* spare dmas for other usage */
+	/delete-property/dmas;
+	/delete-property/dma-names;
+
+	status = "okay";
+
+	led_pwm: pwm {
+		pinctrl-names = "default", "sleep";
+		pinctrl-0 = <&pwm8_pins_b>;
+		pinctrl-1 = <&pwm8_sleep_pins_b>;
+		status = "okay";
+	};
+};
+
+&uart4 {
+	label = "debug";
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart4_pins_a>;
+
+	/* spare dmas for other usage */
+	/delete-property/dmas;
+	/delete-property/dma-names;
+
+	status = "okay";
+};
+
+&usart3 {
+	label = "external";
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&usart3_pins_a>;
+
+	/* spare dmas for other usage */
+	/delete-property/dmas;
+	/delete-property/dma-names;
+
+	status = "okay";
+};
+
+&usbh_ehci {
+	phys = <&usbphyc_port0>;
+	phy-names = "usb";
+
+	status = "okay";
+};
+
+&usbotg_hs {
+	phys = <&usbphyc_port1 0>;
+	phy-names = "usb2-phy";
+
+	vusb_d-supply = <&vdd_usb>;
+	vusb_a-supply = <&reg18>;
+
+	status = "okay";
+};
+
+&usbphyc {
+	status = "okay";
+};
+
+&usbphyc_port0 {
+	phy-supply = <&vdd_usb>;
+};
+
+&usbphyc_port1 {
+	phy-supply = <&vdd_usb>;
+};
+
+&v3v3_hdmi {
+	regulator-enable-ramp-delay = <1000>;
+};

-- 
2.45.2



