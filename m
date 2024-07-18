Return-Path: <linux-kernel+bounces-256164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1104F934A1B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 10:41:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAEAA2832CA
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 08:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F85B80BEC;
	Thu, 18 Jul 2024 08:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Sn7mPMug"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E5F7D3FB;
	Thu, 18 Jul 2024 08:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721292050; cv=none; b=TD0JGTEm2ry/6iFXPO8pM8WmQzl+hGHfWa0HFWds10j3T/ksoRPUUSgL2j5U1zMyMfEGmfKYttrpzdwXVxDQuWTDXOtt1fLSKzg+TmcRsbj+ueIsYcHbg5Y2qzs9but/QzCi0p+ePw9vJuTLLI5DKSWSfH7DqdOFaYHMKSSZUus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721292050; c=relaxed/simple;
	bh=FE+llVdixIGVgAVfM0CVTfAtDvpu6Y0k1yVja8RG0a0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VgnuUdcGxCUv0dyVo6XY4wPOEnpSEn/t+Rt9j5mIKrqAPLUQynOyeg9z05oiVsEaqakrvau3qfO63TgaxIpKpBurHZR8wwowbqT7lteysZkyhsW/7DyYYuA3RhEldI7TXtvOguJ0VnsyJfkWAAvRJRqtjnoHfPhqo2DmDpLVpxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Sn7mPMug; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1721292047;
	bh=FE+llVdixIGVgAVfM0CVTfAtDvpu6Y0k1yVja8RG0a0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Sn7mPMugaRByKx4adM7+CVo+xMKSBG1wT8yR75Fj49MuwLlHVFiRyFcDuE7j3/iBM
	 sPbI8M2UQsKnemfju60XulG7BLPfvo53iTGCM6xpJENw89DGqt1uTRXfnfvWhFH7K1
	 nBr3HhNMYSmZw/Eu3/PsWBbEBBsTNo7GMvGQrcSQcbtu8bKbxbhMibugZaGfWOy9bZ
	 JzpU3efnkN+QPbWY2dVKpVWkShwQOZ719nyPnI1mB8577hCO3wXvwN1dzp9YprDx8O
	 PYsVkbsZ12AyS6Gff6mjq81PruDUwZySnPGwNCzKzGJG0gi2oz7ZpIq7YYVElRzDG4
	 C3cfgqlhNQhAA==
Received: from [127.0.1.1] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: obbardc)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 5C13037821D8;
	Thu, 18 Jul 2024 08:40:46 +0000 (UTC)
From: Christopher Obbard <chris.obbard@collabora.com>
Date: Thu, 18 Jul 2024 09:40:26 +0100
Subject: [PATCH v3 3/3] arm64: dts: rockchip: add Firefly JD4 baseboard
 with Core-PX30-JD4 SoM
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240718-rockchip-px30-firefly-v3-3-3835cdd22eae@collabora.com>
References: <20240718-rockchip-px30-firefly-v3-0-3835cdd22eae@collabora.com>
In-Reply-To: <20240718-rockchip-px30-firefly-v3-0-3835cdd22eae@collabora.com>
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
 arch/arm64/boot/dts/rockchip/Makefile              |   1 +
 .../boot/dts/rockchip/px30-firefly-jd4-core-mb.dts | 179 +++++++++++++++++++++
 2 files changed, 180 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
index fda1b980eb4bc..4861987457a42 100644
--- a/arch/arm64/boot/dts/rockchip/Makefile
+++ b/arch/arm64/boot/dts/rockchip/Makefile
@@ -3,6 +3,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += px30-evb.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += px30-engicam-px30-core-ctouch2.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += px30-engicam-px30-core-ctouch2-of10.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += px30-engicam-px30-core-edimm2.2.dtb
+dtb-$(CONFIG_ARCH_ROCKCHIP) += px30-firefly-jd4-core-mb.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += px30-ringneck-haikou.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3308-evb.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3308-roc-cc.dtb
diff --git a/arch/arm64/boot/dts/rockchip/px30-firefly-jd4-core-mb.dts b/arch/arm64/boot/dts/rockchip/px30-firefly-jd4-core-mb.dts
new file mode 100644
index 0000000000000..e109988f4e6be
--- /dev/null
+++ b/arch/arm64/boot/dts/rockchip/px30-firefly-jd4-core-mb.dts
@@ -0,0 +1,179 @@
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
+	model = "Firefly Core-PX30-JD4 on MB-JD4-PX30 baseboard";
+	compatible = "firefly,px30-jd4-core-mb", "firefly,px30-jd4-core",
+		   "rockchip,px30";
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


