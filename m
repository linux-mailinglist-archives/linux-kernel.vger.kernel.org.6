Return-Path: <linux-kernel+bounces-574092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3D20A6E082
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 18:05:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AAC73AB3E2
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 17:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85A802641E6;
	Mon, 24 Mar 2025 17:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="QV8nQYO+"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC384262803;
	Mon, 24 Mar 2025 17:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742835866; cv=none; b=p24FvzHczOTWBW7qc6xY73Kaqs72WZBIxo6pgQVLUbnkMl2/j0NL+2oUgFwCcF8TWdkGCMg8frRK4vDh0i+ISwqRZZb55vflKuT/BkiHUfgsB/2E79aoGpdjWh0Q7pHjItPqZTHKw2+RlMkBjT//kaBzCsxuY4U5X5epkTbl4dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742835866; c=relaxed/simple;
	bh=0gLnYYOisV9YYhtXLBxrTYPVgD131atFQu3Y9z1S44o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Qyh0GxzlCnx2Hwu6o6iIvND3P3l1ZhPZoePyoiXWsJVBowmk4vn1xHOBdxbi5whitqBTsAUC0Mc4iNsHgQwsAVY9N9s+0mdAfEJYt66jGYbQvuDPCXr+HhvAORuN45ho0xLjr3iB2AJn6Rcqf08oO3P+Dtpz/0/k0fvA7xgDSos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=QV8nQYO+; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1742835863;
	bh=0gLnYYOisV9YYhtXLBxrTYPVgD131atFQu3Y9z1S44o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=QV8nQYO+jzLNvensNtcj6/LQdY9vARE3vSc1PSNfxkO/66mAPgmuRkkrD+bc93i5t
	 rS3JXBHUe/rj/XZt3HHLagd9HWmdgJsZ1yrFch00R+5+hACrOO0MAgGB4QAPo9sKY5
	 g/SMEmjQY/13ELGaBfpF3DAhkT3NFXONo0VT+/gk4TDXSs3sOJG8YhgDnVlXcKV+15
	 DnyA66rP3cSZwQ2RBkUwYXb9FyqgzYrfV2T4Z0vc6mojYk4K0NyXFSBXITQuIkCgaZ
	 FrfRHvOlJSfUyJljoW7RxpQhINxAaEDDIWj13gmq12ZpvvZ3v/2fAHekE3XyT48aec
	 OEeOdUjcF1Ehw==
Received: from jupiter.universe (dyndsl-091-248-188-184.ewe-ip-backbone.de [91.248.188.184])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: sre)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 1F9CB17E0C38;
	Mon, 24 Mar 2025 18:04:23 +0100 (CET)
Received: by jupiter.universe (Postfix, from userid 1000)
	id D9D2E48003C; Mon, 24 Mar 2025 18:04:22 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Mon, 24 Mar 2025 18:04:25 +0100
Subject: [PATCH 4/5] arm64: dts: rockchip: add Rock 5B+
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250324-rock5bp-for-upstream-v1-4-6217edf15b19@kernel.org>
References: <20250324-rock5bp-for-upstream-v1-0-6217edf15b19@kernel.org>
In-Reply-To: <20250324-rock5bp-for-upstream-v1-0-6217edf15b19@kernel.org>
To: Heiko Stuebner <heiko@sntech.de>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, 
 Sebastian Reichel <sebastian.reichel@collabora.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4423; i=sre@kernel.org;
 h=from:subject:message-id; bh=0gLnYYOisV9YYhtXLBxrTYPVgD131atFQu3Y9z1S44o=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGfhkJbN2syahpd7q1NftmVTmOJ42npCvflWF
 gYQucPvSgCJS4kCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJn4ZCWAAoJENju1/PI
 O/qaZeIQAJV7JJ2sJ9TFjiFuBcEuVmsO8L6jg+YQbSmBAg8GprwIpT/OzdpY8z0mJe3rhXUHKHg
 TUiEVj9BPPpQZwSdFqw8EXh7BqmHJgE8hwxBtcAnQxzN6n2eTaaPAIQVscQfHBmIyXpEwIGarm6
 i32ThHEWImpoE591c6sLSSVxOAKtkvhK/RdgrFHbOk/zbZI1HMaNYgKoxU3eYsQuD3EO9eL3bSM
 +LI3JlvSENfEBda9a6jMG/ofjwrwXQZgXACs+wMyZGqmgco9JdN6TyK9HswYaXtF53eFN2aeDZt
 VEia9Ll5i+Sj8YchDZbrhEkuq822YXPC6eRaTwfC5BH/3ZdSuShbmov7hrgMWjVTG4QpQPe2iUN
 xr6+CAt3XS8Pf2pFvejF3fZFhu3AZzJaUNVB88KtNKzdtPGY9HcWyJSVbUkf44DxpxL1h050kgK
 Jle7JAKOMqXWwUvwyRkRgOeZIgaYgv6Cy7F0A9ey9j7OaTiFp+HIr4/6fyaTmNfAP1F4OEu11QW
 udu2y5sq/ljFmegX3drKH/cuzsCTpgLd+jLPg0YyCQ4FIltfxlhTrKYBhPez14FFF4UWFjuK8JF
 EktSkuGcwrFA7QY64DEe4B7zCMJDXDzAAhYqNsHtCR53B8JcKH9SJWXCK8KYHQDd+FSt2YSZvS9
 w7APpf3Dcw7EzVdglxt8eKw==
X-Developer-Key: i=sre@kernel.org; a=openpgp;
 fpr=EF660D07463F8B726A795413D8EED7F3C83BFA9A

Add ROCK 5B+, which is an improved version of the ROCK 5B with the
following changes:

 * Memory LPDDR4X -> LPDDR5
 * HDMI input connector size
 * eMMC socket -> onboard
 * M.2 E-Key is replaced by onboard RTL8852BE WLAN/BT
 * M.2 M-Key 1x4 lanes is replaced by 2x2 lanes
 * Added M.2 B-Key for USB connected WWAN modules (untested)
 * Add second camera port (not yet supported in upstream Linux)
 * Add dedicated USB-C port for device power (no impact in DT;
   the existing port has not been changed and the new port is
   handled by CH224D standalone chip)

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 arch/arm64/boot/dts/rockchip/Makefile              |   1 +
 .../boot/dts/rockchip/rk3588-rock-5b-plus.dts      | 113 +++++++++++++++++++++
 2 files changed, 114 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
index 3e8771ef69ba1c1428117cc2ae29b84e13523e21..6525329fcf060aeb89382d184ca4c6c5c1d07088 100644
--- a/arch/arm64/boot/dts/rockchip/Makefile
+++ b/arch/arm64/boot/dts/rockchip/Makefile
@@ -164,6 +164,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-rock-5-itx.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-rock-5b.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-rock-5b-pcie-ep.dtbo
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-rock-5b-pcie-srns.dtbo
+dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-rock-5b-plus.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-tiger-haikou.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-toybrick-x0.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-turing-rk1.dtb
diff --git a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b-plus.dts b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b-plus.dts
new file mode 100644
index 0000000000000000000000000000000000000000..74c7b6502e4dda4b774f43c704ebaee350703c0d
--- /dev/null
+++ b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b-plus.dts
@@ -0,0 +1,113 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+
+/dts-v1/;
+
+#include "rk3588-rock-5b.dtsi"
+
+/ {
+	model = "Radxa ROCK 5B+";
+	compatible = "radxa,rock-5b-plus", "rockchip,rk3588";
+
+	rfkill-wwan {
+		compatible = "rfkill-gpio";
+		label = "rfkill-m2-wwan";
+		radio-type = "wwan";
+		shutdown-gpios = <&gpio3 RK_PA6 GPIO_ACTIVE_HIGH>;
+	};
+
+	vcc3v3_4g: regulator-vcc3v3-4g {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		gpios = <&gpio1 RK_PD2 GPIO_ACTIVE_HIGH>;
+		/* pinctrl for the GPIO is requested by vcc3v3_pcie2x1l0 */
+		regulator-name = "vcc3v3_4g";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		startup-delay-us = <50000>;
+		vin-supply = <&vcc5v0_sys>;
+	};
+
+	vcc3v3_wwan_pwr: regulator-vcc3v3-wwan {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		gpios = <&gpio2 RK_PB1 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&wwan_power_en>;
+		regulator-name = "vcc3v3_wwan_pwr";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&vcc3v3_4g>;
+	};
+};
+
+&gpio0 {
+	wwan-disable2-n-hog {
+		gpios = <RK_PB2 GPIO_ACTIVE_LOW>;
+		output-low;
+		line-name = "M.2 B-key W_DISABLE2#";
+		gpio-hog;
+	};
+};
+
+&gpio2 {
+	wwan-reset-n-hog {
+		gpios = <RK_PB3 GPIO_ACTIVE_LOW>;
+		output-low;
+		line-name = "M.2 B-key RESET#";
+		gpio-hog;
+	};
+
+	wwan-wake-n-hog {
+		gpios = <RK_PB2 GPIO_ACTIVE_LOW>;
+		input;
+		line-name = "M.2 B-key WoWWAN#";
+		gpio-hog;
+	};
+};
+
+&pcie30phy {
+	data-lanes = <1 1 2 2>;
+};
+
+&pcie3x2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcie3x2_rst>;
+	reset-gpios = <&gpio4 RK_PB0 GPIO_ACTIVE_HIGH>;
+	vpcie3v3-supply = <&vcc3v3_pcie30>;
+	status = "okay";
+};
+
+&pcie3x4 {
+	num-lanes = <2>;
+};
+
+&pinctrl {
+	wwan {
+		wwan_power_en: wwan-pwr-en {
+			rockchip,pins = <2 RK_PB1 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
+	pcie3 {
+		pcie3x2_rst: pcie3x2-rst {
+			rockchip,pins = <4 RK_PB0 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
+	usb {
+		vcc5v0_host_en: vcc5v0-host-en {
+			rockchip,pins = <1 RK_PA1 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+};
+
+&vcc5v0_host {
+	enable-active-high;
+	gpio = <&gpio1 RK_PA1 GPIO_ACTIVE_HIGH>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&vcc5v0_host_en>;
+};

-- 
2.47.2


