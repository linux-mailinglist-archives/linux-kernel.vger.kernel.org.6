Return-Path: <linux-kernel+bounces-255439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D3279340BE
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 18:47:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C52E21F221F2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 16:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0C4D1822F7;
	Wed, 17 Jul 2024 16:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="QxtvNTTu"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987E5181CF2;
	Wed, 17 Jul 2024 16:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721234835; cv=none; b=YbkKJAF+k5qHv4EDOzhOegfLP1IlVQ6dLZGCEi6sO7dLnEEgOoQSg10bnPV04seiBpNXn1Hy7J3ujmSMYFR4jPkWO0oGf+2emyF42OQIN/xNBeH0WozOfwTl4DiUcKfLEkAbhvwB7fTyy+msUSLrhetAVRXPAPttoMu/RmlLnQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721234835; c=relaxed/simple;
	bh=P2dDFKJmMIs4Vq1hfm4USmI4h/Ps+EuQ82HQavo6OOw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GnG00yeDV0Qh/D/bnPStA2xR08B08X+cg9xGJU8XYh/DyVReVOnXzzkEaFBxvBKrkXcDlbegPgmjMFJJ8LVbS3RguBMLCozevA7odCi9hoJV0EF14tUEvHcEu9z8/Dhp45KpNts6q/s2nwz6Rw/ltqpZlzREtii7TLKidOat3ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=QxtvNTTu; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1721234831;
	bh=P2dDFKJmMIs4Vq1hfm4USmI4h/Ps+EuQ82HQavo6OOw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=QxtvNTTuFfpykQUkQ0hfZ+w0ofLutCflssm9KeB2qK+worxZNC41l2q8pi315iCsb
	 Rsd2UbFgY2lTG7E9ip7hsTFkjLo5jkdBmgsY5VY7BZVmvpnaQvdwHQgiNNxT/pS00U
	 26LbWQURlxtem1mWA3s5xRYhZCNhIJ24iYCowzAMJsxlDW63T6fGtE6HZYYWv/q/YR
	 GTUoS9eltA2JcDUjlmD/0cz4mEfgJk1d9JmtiQSZJQLDacDC9sKVJhR0yFcDrbiAOP
	 8suJkwtuG1uRN9FP52anRQ2MLhMr4yY+gdHFGhlJU6Gl0a0YbgDgGa14ONNaiXeFDs
	 3AZWrMeL6JbhA==
Received: from [127.0.1.1] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: obbardc)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 9D32D37820DE;
	Wed, 17 Jul 2024 16:47:10 +0000 (UTC)
From: Christopher Obbard <chris.obbard@collabora.com>
Date: Wed, 17 Jul 2024 17:47:01 +0100
Subject: [PATCH v2 3/3] arm64: dts: rockchip: add Firefly JD4 baseboard
 with Core-PX30-JD4 SoM
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240717-rockchip-px30-firefly-v2-3-06541a5a5946@collabora.com>
References: <20240717-rockchip-px30-firefly-v2-0-06541a5a5946@collabora.com>
In-Reply-To: <20240717-rockchip-px30-firefly-v2-0-06541a5a5946@collabora.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Kever Yang <kever.yang@rock-chips.com>, Dragan Simic <dsimic@manjaro.org>, 
 Collabora Kernel Mailing List <kernel@collabora.com>, 
 Christopher Obbard <chris.obbard@collabora.com>
X-Mailer: b4 0.13.0

The Firefly MB-PX30-JD4 is a baseboard for the Core-PX30-JD4 SoM.

Signed-off-by: Christopher Obbard <chris.obbard@collabora.com>
---
 arch/arm64/boot/dts/rockchip/Makefile             |   1 +
 arch/arm64/boot/dts/rockchip/px30-firefly-jd4.dts | 178 ++++++++++++++++++++++
 2 files changed, 179 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
index fda1b980eb4bc..24e1e5b606876 100644
--- a/arch/arm64/boot/dts/rockchip/Makefile
+++ b/arch/arm64/boot/dts/rockchip/Makefile
@@ -3,6 +3,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += px30-evb.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += px30-engicam-px30-core-ctouch2.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += px30-engicam-px30-core-ctouch2-of10.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += px30-engicam-px30-core-edimm2.2.dtb
+dtb-$(CONFIG_ARCH_ROCKCHIP) += px30-firefly-jd4.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += px30-ringneck-haikou.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3308-evb.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3308-roc-cc.dtb
diff --git a/arch/arm64/boot/dts/rockchip/px30-firefly-jd4.dts b/arch/arm64/boot/dts/rockchip/px30-firefly-jd4.dts
new file mode 100644
index 0000000000000..bb79a7eb9f028
--- /dev/null
+++ b/arch/arm64/boot/dts/rockchip/px30-firefly-jd4.dts
@@ -0,0 +1,178 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2019 Fuzhou Rockchip Electronics Co., Ltd
+ */
+
+/dts-v1/;
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/leds/common.h>
+#include "px30-firefly-jd4-core.dtsi"
+
+/ {
+	model = "Firefly Core-PX30-JD4 with MB-JD4-PX30 baseboard";
+	compatible = "firefly,px30-mb-jd4", "firefly,px30-core-jd4", "rockchip,px30";
+
+	aliases {
+		ethernet0 = &gmac;
+		mmc0 = &sdmmc;
+		mmc1 = &sdio;
+		mmc2 = &emmc;
+	};
+
+	chosen {
+		stdout-path = "serial2:115200n8";
+	};
+
+	dc_12v: dc-12v-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "dc_12v";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <12000000>;
+		regulator-max-microvolt = <12000000>;
+	};
+
+	adc-keys {
+		compatible = "adc-keys";
+		io-channels = <&saradc 2>;
+		io-channel-names = "buttons";
+		keyup-threshold-microvolt = <1500000>;
+		poll-interval = <100>;
+
+		button-recovery {
+			label = "Recovery";
+			linux,code = <KEY_VENDOR>;
+			press-threshold-microvolt = <18000>;
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&blue_led>, <&green_led>;
+
+		blue-led {
+			color = <LED_COLOR_ID_BLUE>;
+			default-state = "on";
+			function = LED_FUNCTION_HEARTBEAT;
+			gpios = <&gpio1 RK_PB5 GPIO_ACTIVE_HIGH>;
+			label = "px30-mb-jd4:blue:work";
+			linux,default-trigger = "heartbeat";
+		};
+
+		green-led {
+			color = <LED_COLOR_ID_GREEN>;
+			default-state = "on";
+			function = LED_FUNCTION_POWER;
+			gpios = <&gpio1 RK_PB4 GPIO_ACTIVE_HIGH>;
+			label = "px30-mb-jd4:blue:diy";
+			linux,default-trigger = "default-on";
+		};
+	};
+
+	sdio_pwrseq: sdio-pwrseq {
+		compatible = "mmc-pwrseq-simple";
+		pinctrl-names = "default";
+		pinctrl-0 = <&wifi_enable_h>;
+
+		/*
+		 * On the module itself this is one of these (depending
+		 * on the actual card populated):
+		 * - SDIO_RESET_L_WL_REG_ON
+		 * - PDN (power down when low)
+		 */
+		reset-gpios = <&gpio0 RK_PA2 GPIO_ACTIVE_LOW>; /* GPIO3_A4 */
+	};
+
+	vcc5v0_baseboard: vcc5v0-baseboard-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc5v0_baseboard";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		vin-supply = <&dc_12v>;
+	};
+};
+
+&gmac {
+	clock_in_out = "output";
+	phy-supply = <&vcc_rmii>;
+	snps,reset-gpio = <&gpio2 13 GPIO_ACTIVE_LOW>;
+	snps,reset-active-low;
+	snps,reset-delays-us = <0 50000 50000>;
+	status = "okay";
+};
+
+&pinctrl {
+	leds {
+		blue_led: blue-led {
+			rockchip,pins = <1 RK_PB5 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+
+		green_led: green-led {
+			rockchip,pins = <1 RK_PB4 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
+	sdio-pwrseq {
+		wifi_enable_h: wifi-enable-h {
+			rockchip,pins =
+				<0 RK_PA2 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+};
+
+&sdmmc {
+	bus-width = <4>;
+	cap-mmc-highspeed;
+	cap-sd-highspeed;
+	card-detect-delay = <800>;
+	sd-uhs-sdr12;
+	sd-uhs-sdr25;
+	sd-uhs-sdr50;
+	sd-uhs-sdr104;
+	vmmc-supply = <&vcc_sd>;
+	vqmmc-supply = <&vccio_sd>;
+	status = "okay";
+};
+
+&sdio {
+	bus-width = <4>;
+	cap-sd-highspeed;
+	keep-power-in-suspend;
+	non-removable;
+	mmc-pwrseq = <&sdio_pwrseq>;
+	sd-uhs-sdr104;
+	status = "okay";
+};
+
+&u2phy {
+	status = "okay";
+
+	u2phy_host: host-port {
+		status = "okay";
+	};
+
+	u2phy_otg: otg-port {
+		status = "okay";
+	};
+};
+
+&uart2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart2m1_xfer>;
+	status = "okay";
+};
+
+&usb20_otg {
+	status = "okay";
+};
+
+&usb_host0_ehci {
+	status = "okay";
+};
+
+&usb_host0_ohci {
+	status = "okay";
+};

-- 
2.45.2


