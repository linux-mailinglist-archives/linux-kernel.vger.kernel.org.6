Return-Path: <linux-kernel+bounces-217055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84F1F90AA18
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 11:45:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EAD81C22BCB
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 09:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADAE5198A31;
	Mon, 17 Jun 2024 09:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qMzo4Fkn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DCD9194C83;
	Mon, 17 Jun 2024 09:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718617106; cv=none; b=PmWeUYhmXDQ1SXhAJN+VaFDPU65037NFVuKEAYyBGipo/W6orGvFbGGCDU+3NNcNgG0VsbbTHMATciDRI+zUnm2T+zDU0pXfDMnW5Tz+waRUzkTsMm++8Ng4lCQabweQ6MbbYVsziRoAec2tBkR8Gp6ZZP8jZnWOMs402r3w8F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718617106; c=relaxed/simple;
	bh=kegMs5uhODxJGpWVpDmFdsZZDFuYrLYfPGjM2n5jZSQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=o2hhmf4eaHFhDmoX95X1ajizumtWPce4mQbdI4bCKBLaD6mVjRA3rL7LXvMAxJpEJ2q4tjv93cHdPm6t+xZia9rQxHGfYq+urhKzmFJLyAT/SepDl9wBXHIwyy4ODdZeISZYHbqvBqnGRvwv6yCih/+/AzdNRb6pJut6rqsLTwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qMzo4Fkn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7EC41C4DDFF;
	Mon, 17 Jun 2024 09:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718617105;
	bh=kegMs5uhODxJGpWVpDmFdsZZDFuYrLYfPGjM2n5jZSQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=qMzo4FkniSGW9rlZnBNBv+V3RgwXdC4+aboH9sRS344F4mFQbwh3OFRlFLklvXF3C
	 m4wMyNvuATD4iFt00taAqu85z3P21wZANzjdKd9mgxM0ubaktP8XBbayZkFOZOXNsY
	 R9vacQNMQap/9MLdExOLZg/ja//NqACbeILH6LW7wkBMkih0rvBFQ4rvu2MEk56Oz1
	 PgtKzM7o/OeBJ1Y8SzY+9IwgxpoF81YrTqkmIhb3YSinVlcBPs0bwcMY0xhMoDDUH9
	 GEsF/ICttd9U+/eO49XeWErOsgEsBGbsIwXYl4B5CTDoLiZlimB1YwPa66eoMpo+ui
	 Z8JxcXjBQc96g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F5AAC27C7B;
	Mon, 17 Jun 2024 09:38:25 +0000 (UTC)
From: Nikita Shubin via B4 Relay <devnull+nikita.shubin.maquefel.me@kernel.org>
Date: Mon, 17 Jun 2024 12:37:04 +0300
Subject: [PATCH v10 30/38] ARM: dts: ep93xx: add ts7250 board
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240617-ep93xx-v10-30-662e640ed811@maquefel.me>
References: <20240617-ep93xx-v10-0-662e640ed811@maquefel.me>
In-Reply-To: <20240617-ep93xx-v10-0-662e640ed811@maquefel.me>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Nikita Shubin <nikita.shubin@maquefel.me>, 
 Andre Przywara <andre.przywara@arm.com>, 
 Manivannan Sadhasivam <mani@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Nick Hawkins <nick.hawkins@hpe.com>, 
 Alexander Sverdlin <alexander.sverdlin@gmail.com>
Cc: Michal Simek <michal.simek@amd.com>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Alexandre TORGUE <alexandre.torgue@st.com>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
X-Mailer: b4 0.13-dev-e3e53
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718617100; l=6186;
 i=nikita.shubin@maquefel.me; s=20230718; h=from:subject:message-id;
 bh=F8g8fhLrok2XoBODc7kkFWBfV9QlTn8N1KFztkjBqBQ=;
 b=6WChbtLx8mppSs/fWk/Fr63Cdv0LrZJvbEhN6feGJxn7Qa2Q7ErvCLNIpheX6S8t7bIIrYShtwka
 DzW277LPCiedp1wtLFBhDWBOqB5EjwWO7jHOOtM+Vw7L9J6/UFFM
X-Developer-Key: i=nikita.shubin@maquefel.me; a=ed25519;
 pk=vqf5YIUJ7BJv3EJFaNNxWZgGuMgDH6rwufTLflwU9ac=
X-Endpoint-Received: by B4 Relay for nikita.shubin@maquefel.me/20230718
 with auth_id=65
X-Original-From: Nikita Shubin <nikita.shubin@maquefel.me>
Reply-To: nikita.shubin@maquefel.me

From: Nikita Shubin <nikita.shubin@maquefel.me>

Add device tree file for Technologic Systems ts7250 board and
Liebherr bk3 board which have many in common, both are based on
ep9302 SoC variant.

Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
---
 arch/arm/boot/dts/cirrus/Makefile          |   3 +
 arch/arm/boot/dts/cirrus/ep93xx-bk3.dts    | 125 +++++++++++++++++++++++++
 arch/arm/boot/dts/cirrus/ep93xx-ts7250.dts | 145 +++++++++++++++++++++++++++++
 3 files changed, 273 insertions(+)

diff --git a/arch/arm/boot/dts/cirrus/Makefile b/arch/arm/boot/dts/cirrus/Makefile
index e944d3e2129d..211a7e2f2115 100644
--- a/arch/arm/boot/dts/cirrus/Makefile
+++ b/arch/arm/boot/dts/cirrus/Makefile
@@ -3,3 +3,6 @@ dtb-$(CONFIG_ARCH_CLPS711X) += \
 	ep7211-edb7211.dtb
 dtb-$(CONFIG_ARCH_CLPS711X) += \
 	ep7211-edb7211.dtb
+dtb-$(CONFIG_ARCH_EP93XX) += \
+	ep93xx-bk3.dtb \
+	ep93xx-ts7250.dtb
diff --git a/arch/arm/boot/dts/cirrus/ep93xx-bk3.dts b/arch/arm/boot/dts/cirrus/ep93xx-bk3.dts
new file mode 100644
index 000000000000..40bc9b2a6ba8
--- /dev/null
+++ b/arch/arm/boot/dts/cirrus/ep93xx-bk3.dts
@@ -0,0 +1,125 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Device Tree file for Liebherr controller BK3.1 based on Cirrus EP9302 SoC
+ */
+/dts-v1/;
+#include "ep93xx.dtsi"
+
+/ {
+	model = "Liebherr controller BK3.1";
+	compatible = "liebherr,bk3", "cirrus,ep9301";
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	chosen {
+	};
+
+	memory@0 {
+		device_type = "memory";
+		/* should be set from ATAGS */
+		reg = <0x00000000 0x02000000>,
+		      <0x000530c0 0x01fdd000>;
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		led-0 {
+			label = "grled";
+			gpios = <&gpio4 0 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "heartbeat";
+			function = LED_FUNCTION_HEARTBEAT;
+		};
+
+		led-1 {
+			label = "rdled";
+			gpios = <&gpio4 1 GPIO_ACTIVE_HIGH>;
+			function = LED_FUNCTION_FAULT;
+		};
+	};
+};
+
+&ebi {
+	nand-controller@60000000 {
+		compatible = "technologic,ts7200-nand";
+		reg = <0x60000000 0x8000000>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		nand@0 {
+			reg = <0>;
+			partitions {
+				compatible = "fixed-partitions";
+				#address-cells = <1>;
+				#size-cells = <1>;
+
+				partition@0 {
+					label = "System";
+					reg = <0x00000000 0x01e00000>;
+					read-only;
+				};
+
+				partition@1e00000 {
+					label = "Data";
+					reg = <0x01e00000 0x05f20000>;
+				};
+
+				partition@7d20000 {
+					label = "RedBoot";
+					reg = <0x07d20000 0x002e0000>;
+					read-only;
+				};
+			};
+		};
+	};
+};
+
+&eth0 {
+	phy-handle = <&phy0>;
+};
+
+&i2s {
+	dmas = <&dma0 0 1>, <&dma0 0 2>;
+	dma-names = "tx", "rx";
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2s_on_ac97_pins>;
+	status = "okay";
+};
+
+&gpio1 {
+	/* PWM */
+	gpio-ranges = <&syscon 6 163 1>;
+};
+
+&gpio4 {
+	gpio-ranges = <&syscon 0 97 2>;
+	status = "okay";
+};
+
+&gpio6 {
+	gpio-ranges = <&syscon 0 87 2>;
+	status = "okay";
+};
+
+&gpio7 {
+	gpio-ranges = <&syscon 2 199 4>;
+	status = "okay";
+};
+
+&mdio0 {
+	phy0: ethernet-phy@1 {
+		reg = <1>;
+		device_type = "ethernet-phy";
+	};
+};
+
+&uart0 {
+	status = "okay";
+};
+
+&uart1 {
+	status = "okay";
+};
+
+&usb0 {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/cirrus/ep93xx-ts7250.dts b/arch/arm/boot/dts/cirrus/ep93xx-ts7250.dts
new file mode 100644
index 000000000000..9e03f93d9fc8
--- /dev/null
+++ b/arch/arm/boot/dts/cirrus/ep93xx-ts7250.dts
@@ -0,0 +1,145 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Device Tree file for Technologic Systems ts7250 board based on Cirrus EP9302 SoC
+ */
+/dts-v1/;
+#include "ep93xx.dtsi"
+
+/ {
+	compatible = "technologic,ts7250", "cirrus,ep9301";
+	model = "TS-7250 SBC";
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	chosen {
+	};
+
+	memory@0 {
+		device_type = "memory";
+		/* should be set from ATAGS */
+		reg = <0x00000000 0x02000000>,
+		      <0x000530c0 0x01fdd000>;
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		led-0 {
+			label = "grled";
+			gpios = <&gpio4 0 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "heartbeat";
+			function = LED_FUNCTION_HEARTBEAT;
+		};
+
+		led-1 {
+			label = "rdled";
+			gpios = <&gpio4 1 GPIO_ACTIVE_HIGH>;
+			function = LED_FUNCTION_FAULT;
+		};
+	};
+};
+
+&ebi {
+	nand-controller@60000000 {
+		compatible = "technologic,ts7200-nand";
+		reg = <0x60000000 0x8000000>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		nand@0 {
+			reg = <0>;
+			partitions {
+				compatible = "fixed-partitions";
+				#address-cells = <1>;
+				#size-cells = <1>;
+
+				partition@0 {
+					label = "TS-BOOTROM";
+					reg = <0x00000000 0x00020000>;
+					read-only;
+				};
+
+				partition@20000 {
+					label = "Linux";
+					reg = <0x00020000 0x07d00000>;
+				};
+
+				partition@7d20000 {
+					label = "RedBoot";
+					reg = <0x07d20000 0x002e0000>;
+					read-only;
+				};
+			};
+		};
+	};
+
+	rtc@10800000 {
+		compatible = "st,m48t86";
+		reg = <0x10800000 0x1>,
+			<0x11700000 0x1>;
+	};
+
+	watchdog@23800000 {
+		compatible = "technologic,ts7200-wdt";
+		reg = <0x23800000 0x01>,
+			<0x23c00000 0x01>;
+		timeout-sec = <30>;
+	};
+};
+
+&eth0 {
+	phy-handle = <&phy0>;
+};
+
+&gpio1 {
+	/* PWM */
+	gpio-ranges = <&syscon 6 163 1>;
+};
+
+/* ts7250 doesn't have GPIO Port D present */
+&gpio3 {
+	status = "disabled";
+};
+
+&gpio4 {
+	gpio-ranges = <&syscon 0 97 2>;
+};
+
+&gpio6 {
+	gpio-ranges = <&syscon 0 87 2>;
+};
+
+&gpio7 {
+	gpio-ranges = <&syscon 2 199 4>;
+};
+
+&spi0 {
+	cs-gpios = <&gpio5 2 GPIO_ACTIVE_HIGH>;
+	dmas = <&dma1 10 2>, <&dma1 10 1>;
+	dma-names = "rx", "tx";
+	status = "okay";
+
+	tmp122: temperature-sensor@0 {
+		compatible = "ti,tmp122";
+		reg = <0>;
+		spi-max-frequency = <2000000>;
+	};
+};
+
+&mdio0 {
+	phy0: ethernet-phy@1 {
+		reg = <1>;
+		device_type = "ethernet-phy";
+	};
+};
+
+&uart0 {
+	status = "okay";
+};
+
+&uart1 {
+	status = "okay";
+};
+
+&usb0 {
+	status = "okay";
+};

-- 
2.43.2



