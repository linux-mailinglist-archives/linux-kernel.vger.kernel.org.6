Return-Path: <linux-kernel+bounces-560480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B594A60520
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 00:11:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEE6D19C43DE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 23:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 824A81F9423;
	Thu, 13 Mar 2025 23:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WRivEGXL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDF5E1F8BC7;
	Thu, 13 Mar 2025 23:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741907461; cv=none; b=pD4K+VfTX+IM0IWc6jQIgs5ti7DtZOkwS8TL+Q+TaQPOqiFV0//jBt0rpF8irokM+dGoQFIKKbW9PtuANudoLvTw5q7uUU7JKAHQ2v7o57WRUTOJq+pcMLjQww5efrmWW8+uB8o5Q/VZ41sDjmc3UbGfNPJNwpSs8FqW0PqFkhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741907461; c=relaxed/simple;
	bh=1YMIKyMyiIHxQT9I7V2KJ6dMxmvfNZry8pelzl171bk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IkEwTb1jq+ZS9sHOfpWfWIgITHQZ4H+kjfFh5ayIzpRjhtwCtONHgP8sHv0d9x00AuWl5TeQiARwiWl0XQ6Ymsjq27Wx7zcqVSK8sOG5av/8TBkszbe6y03AfgNL/m2cqQrlldrZahzo/AfCS0seD29bZiyNhu9+gy1249v6T/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WRivEGXL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 34D95C4CEE5;
	Thu, 13 Mar 2025 23:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741907461;
	bh=1YMIKyMyiIHxQT9I7V2KJ6dMxmvfNZry8pelzl171bk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=WRivEGXLxLFhUVLhb8SVLsLpNF5wTkbdJSqFqyyt/rBP6V3/P62tkW38b1A3YXoCt
	 WoEd8ReVQPFO3sD4JZsXYhbT64HNKzn8PHtsUjZk2xSIXvFKHY4ViBNKUjC9VGn7z9
	 x+cZE4CYVTJqlHUr5Knv8ng+xxMKhDttGCmDjN+3HCnSRUJOsgpqypVkkAt4/fe5MG
	 1gq6aUoUQ/YUsHU3FjmS3A2IF9Rbps5GY/PI0G6+pmfr62dg1VLUJbZHPSUzO7Du2R
	 2OuoWRP6JvGGGcYmbDDYxOweHHPTukHrsOEGidsK3g6PFyYBZmbg933xMq1MTlF35M
	 Ula9PhlWrvvpA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 289C9C35FF6;
	Thu, 13 Mar 2025 23:11:01 +0000 (UTC)
From: =?utf-8?q?J=2E_Neusch=C3=A4fer_via_B4_Relay?= <devnull+j.ne.posteo.net@kernel.org>
Date: Fri, 14 Mar 2025 00:11:00 +0100
Subject: [PATCH v2 2/2] arm64: dts: amlogic: Add Ugoos AM3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250314-ugoos-am3-v2-2-422104b0cec5@posteo.net>
References: <20250314-ugoos-am3-v2-0-422104b0cec5@posteo.net>
In-Reply-To: <20250314-ugoos-am3-v2-0-422104b0cec5@posteo.net>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Jerome Brunet <jbrunet@baylibre.com>, Kevin Hilman <khilman@baylibre.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
 =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741907460; l=4596;
 i=j.ne@posteo.net; s=20240329; h=from:subject:message-id;
 bh=m3invKokLgdJ1eCdXuhwHYci6oBGOULnHFVI8Wy8tiI=;
 b=h5PCF4nsdbjTbwVFveX7lFEADyFz+xxk+07lMMMq6sLw/WUAvtmvQjLPr91KEmOCSjRsUAvKy
 uwyGgJ5YPgnBYGmkPOb8gWawgVEoEbBrfGGWI2N4hsP9SLcMLXum8OY
X-Developer-Key: i=j.ne@posteo.net; a=ed25519;
 pk=NIe0bK42wNaX/C4bi6ezm7NJK0IQE+8MKBm7igFMIS4=
X-Endpoint-Received: by B4 Relay for j.ne@posteo.net/20240329 with
 auth_id=156
X-Original-From: =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
Reply-To: j.ne@posteo.net

From: "J. Neuschäfer" <j.ne@posteo.net>

The Ugoos AM3 is a small set-top box based on the Amlogic S912 SoC,
with a board design that is very close to the Q20x development boards.
The MMC max-frequency properties are copied from the downstream device
tree.

  https://ugoos.com/ugoos-am3-16g

The following functionality has been tested and is known to work:
 - debug serial port
 - "update" button inside the case
 - USB host mode, on all three ports
 - HDMI video/audio output
 - eMMC, MicroSD, and SDIO WLAN
 - S/PDIF audio output
 - Ethernet
 - Infrared remote control input

The following functionality doesn't seem to work:
 - USB role switching and device mode on the "OTG" port
 - case LED

Signed-off-by: J. Neuschäfer <j.ne@posteo.net>
---

V2:
- Fix vendor name in patch subject
- Remove incorrect override of SDIO pwrseq reset line
---
 arch/arm64/boot/dts/amlogic/Makefile               |  1 +
 .../arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi |  2 +-
 .../arm64/boot/dts/amlogic/meson-gxm-ugoos-am3.dts | 91 ++++++++++++++++++++++
 3 files changed, 93 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/amlogic/Makefile b/arch/arm64/boot/dts/amlogic/Makefile
index 2fbda8419c65a3056410ac45ca3ddaceb69ea4f5..bf2bc14528bfa27e8d6ae2730085fc356d6c6dd8 100644
--- a/arch/arm64/boot/dts/amlogic/Makefile
+++ b/arch/arm64/boot/dts/amlogic/Makefile
@@ -76,6 +76,7 @@ dtb-$(CONFIG_ARCH_MESON) += meson-gxm-q200.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxm-q201.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxm-rbox-pro.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxm-s912-libretech-pc.dtb
+dtb-$(CONFIG_ARCH_MESON) += meson-gxm-ugoos-am3.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxm-vega-s96.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxm-wetek-core2.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-s4-s805x2-aq222.dtb
diff --git a/arch/arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi b/arch/arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi
index 45ccddd1aaf0546632c81a52c8917a923beae883..4223b26f7d0f3aa47e42e9434d24f73b20441981 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi
@@ -97,7 +97,7 @@ sdio_pwrseq: sdio-pwrseq {
 		clock-names = "ext_clock";
 	};
 
-	cvbs-connector {
+	cvbs_connector: cvbs-connector {
 		compatible = "composite-video-connector";
 
 		port {
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxm-ugoos-am3.dts b/arch/arm64/boot/dts/amlogic/meson-gxm-ugoos-am3.dts
new file mode 100644
index 0000000000000000000000000000000000000000..ba871f3f53bb99b47b325bae228b59b722c5123b
--- /dev/null
+++ b/arch/arm64/boot/dts/amlogic/meson-gxm-ugoos-am3.dts
@@ -0,0 +1,91 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2025 J. Neuschäfer <j.ne@posteo.net>
+ *
+ * Debug UART (3.3V, 115200 baud) at the corner of the board:
+ *   (4) (3) (2) [1]
+ *   Vcc RXD TXD GND
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/interrupt-controller/amlogic,meson-g12a-gpio-intc.h>
+
+#include "meson-gxm.dtsi"
+#include "meson-gx-p23x-q20x.dtsi"
+
+/ {
+	compatible = "ugoos,am3", "amlogic,s912", "amlogic,meson-gxm";
+	model = "Ugoos AM3";
+
+	adc-keys {
+		compatible = "adc-keys";
+		io-channels = <&saradc 0>;
+		io-channel-names = "buttons";
+		keyup-threshold-microvolt = <1710000>;
+
+		button-function {
+			label = "Update";
+			linux,code = <KEY_VENDOR>;
+			press-threshold-microvolt = <10000>;
+		};
+	};
+};
+
+&cvbs_connector {
+	/* Not used on this board */
+	status = "disabled";
+};
+
+&ethmac {
+	pinctrl-0 = <&eth_pins>;
+	pinctrl-names = "default";
+
+	/* Select external PHY by default */
+	phy-handle = <&external_phy>;
+
+	amlogic,tx-delay-ns = <2>;
+
+	/* External PHY is in RGMII */
+	phy-mode = "rgmii";
+
+	status = "okay";
+};
+
+&external_mdio {
+	external_phy: ethernet-phy@0 {
+		/* Realtek RTL8211F (0x001cc916) */
+		reg = <0>;
+
+		reset-assert-us = <10000>;
+		reset-deassert-us = <80000>;
+		reset-gpios = <&gpio GPIOZ_14 GPIO_ACTIVE_LOW>;
+
+		interrupt-parent = <&gpio_intc>;
+		/* MAC_INTR on GPIOZ_15 */
+		interrupts = <25 IRQ_TYPE_LEVEL_LOW>;
+	};
+};
+
+&i2c_B {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c_b_pins>;
+
+	rtc: rtc@51 {
+		compatible = "haoyu,hym8563";
+		reg = <0x51>;
+		#clock-cells = <0>;
+	};
+};
+
+/* WLAN: Atheros 10k (QCA9377) */
+&sd_emmc_a {
+	max-frequency = <200000000>;
+};
+
+/* eMMC */
+&sd_emmc_c {
+	max-frequency = <100000000>;
+};

-- 
2.48.0.rc1.219.gb6b6757d772



