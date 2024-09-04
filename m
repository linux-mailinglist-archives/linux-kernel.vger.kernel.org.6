Return-Path: <linux-kernel+bounces-314860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0144A96BA12
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 13:19:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80A741F21BA1
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 11:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 706871D61B5;
	Wed,  4 Sep 2024 11:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=classfun.cn header.i=@classfun.cn header.b="B5IG5sRe"
Received: from classfun.cn (unknown [129.204.178.38])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 807311CCECF;
	Wed,  4 Sep 2024 11:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.204.178.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725448537; cv=none; b=YlHhH5sAh/CCP1yklkDilhDr2yASS4gkq6G5Erq3R8xH2F806VwaiFUtZKmBSjzP3JB+CFcM5FRDVmPVBDLC19N9njvNzLoSsAA2amfKpTkHiPNpHMoCMgto00ZPiedk8DonCRTTgoPgKErabmJQIuQZswmBI272XL08R6N1roo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725448537; c=relaxed/simple;
	bh=mRkK5q0SiXb6PE2Le1xbZco7m3cTKy8Ap+C6yK9oMuM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c1Js2u9IJMWF7a+PY/5PQiM44BNvJrruJGYyoDMnMlX4oYNFf9WZldpPSzhXgmkKhR9gnaItfGoSlnxkozsrhBfKMjNidRjCuW/HnNkmqJWUxKLMMvbGUeazy/IA2EUApqLVcHeUf8uVy20MiXS2O7r54lZD4mtXGDYpiQnL9LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=classfun.cn; spf=pass smtp.mailfrom=classfun.cn; dkim=pass (1024-bit key) header.d=classfun.cn header.i=@classfun.cn header.b=B5IG5sRe; arc=none smtp.client-ip=129.204.178.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=classfun.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=classfun.cn
Received: from bigfoot-server-storage.classfun.cn (unknown [124.72.162.211])
	(Authenticated sender: bigfoot)
	by classfun.cn (Postfix) with ESMTPSA id D49DF78924;
	Wed,  4 Sep 2024 19:15:32 +0800 (CST)
DKIM-Filter: OpenDKIM Filter v2.11.0 classfun.cn D49DF78924
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=classfun.cn;
	s=default; t=1725448533;
	bh=zDU/Hwte3MiTMxriBvYciPGJ6b8B37sQfcUDJhOxbL8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B5IG5sRe01w+gJ2YGzb5m1a6XHVrENrOC4W2AESCs51NqQZBs9y46pMU9njOzWf8E
	 nEPpUMJhwSUQBx7TtlPSwBSQMDI/vMfc5RS24Q5Bg5h0esi3DAtIAhIAQSGyVbCWEk
	 srfVnVeZe9WmmV2qNUplfkiP8BsDWgkeSg0siErk=
From: Junhao Xie <bigfoot@classfun.cn>
To: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Jonas Karlman <jonas@kwiboo.se>,
	Chukun Pan <amadeus@jmu.edu.cn>,
	Junhao Xie <bigfoot@classfun.cn>,
	FUKAUMI Naoki <naoki@radxa.com>,
	Dragan Simic <dsimic@manjaro.org>,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] arm64: dts: rockchip: add dts for Ariaboard Photonicat RK3568
Date: Wed,  4 Sep 2024 19:14:56 +0800
Message-ID: <20240904111456.87089-4-bigfoot@classfun.cn>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240904111456.87089-1-bigfoot@classfun.cn>
References: <20240904111456.87089-1-bigfoot@classfun.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add dts for Ariaboard Photonicat RK3568.

Working IO:
    Debug UART
    SDIO QCA9377 WiFi and Bluetooth
    M.2 E-Key PCIe WiFi and Bluetooth
    M.2 B-Key USB Modem WWAN
    Ethernet WAN Port
    MicroSD Card slot
    eMMC
    HDMI Output
    Mali GPU
    USB Type-A

Not working IO:
    Ethernet LAN Port (Lack of SGMII support)
    Power management MCU on UART4 (Driver pending)

Not working IO in MCU:
    Battery voltage sensor
    Board temperature sensor
    Hardware Power-off
    Hardware Watchdog
    Network status LED
    Real-time clock
    USB Charger voltage sensor

About onboard power management MCU:
    A heartbeat must be sent to the MCU within 60 seconds,
    otherwise the MCU will restart the system.
    When powering off, a shutdown command needs to be sent to the MCU.
    When the power button is long pressed, the MCU will send a shutdown
    command to the system. If the system does not shutdown within 60
    seconds, the power will be turned off directly.
    MCU only provides voltage for charger and battery.
    Manufacturer removed RK8xx PMIC.

Signed-off-by: Junhao Xie <bigfoot@classfun.cn>
---
 arch/arm64/boot/dts/rockchip/Makefile         |   1 +
 .../rockchip/rk3568-ariaboard-photonicat.dts  | 598 ++++++++++++++++++
 2 files changed, 599 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3568-ariaboard-photonicat.dts

diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
index fda1b980eb4b..9d92d084e996 100644
--- a/arch/arm64/boot/dts/rockchip/Makefile
+++ b/arch/arm64/boot/dts/rockchip/Makefile
@@ -103,6 +103,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-soquartz-cm4.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-soquartz-model-a.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-box-demo.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-lubancat-1.dtb
+dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-ariaboard-photonicat.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-bpi-r2-pro.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-evb1-v10.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-fastrhino-r66s.dtb
diff --git a/arch/arm64/boot/dts/rockchip/rk3568-ariaboard-photonicat.dts b/arch/arm64/boot/dts/rockchip/rk3568-ariaboard-photonicat.dts
new file mode 100644
index 000000000000..ab2bb14b8ed7
--- /dev/null
+++ b/arch/arm64/boot/dts/rockchip/rk3568-ariaboard-photonicat.dts
@@ -0,0 +1,598 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+
+/dts-v1/;
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/leds/common.h>
+#include <dt-bindings/pinctrl/rockchip.h>
+#include <dt-bindings/soc/rockchip,vop2.h>
+#include <dt-bindings/soc/rockchip,boot-mode.h>
+#include "rk3568.dtsi"
+
+/ {
+	model = "Ariaboard Photonicat RK3568";
+	compatible = "ariaboard,photonicat", "rockchip,rk3568";
+
+	aliases {
+		ethernet0 = &gmac0;
+		ethernet1 = &gmac1;
+		mmc0 = &sdhci;
+		mmc1 = &sdmmc0;
+		mmc2 = &sdmmc1;
+	};
+
+	battery: battery {
+		compatible = "simple-battery";
+		device-chemistry = "lithium-ion";
+		charge-full-design-microamp-hours = <6800000>;
+		energy-full-design-microwatt-hours = <25000000>;
+		voltage-max-design-microvolt = <4200000>;
+		voltage-min-design-microvolt = <3400000>;
+
+		ocv-capacity-celsius = <25>;
+		ocv-capacity-table-0 =  <4100000 100>, <4040000 90>,
+					<3980000 80>, <3920000 70>,
+					<3870000 60>, <3820000 50>,
+					<3790000 40>, <3770000 30>,
+					<3740000 20>, <3680000 10>,
+					<3450000 0>;
+	};
+
+	chosen: chosen {
+		stdout-path = "serial2:1500000n8";
+	};
+
+	firmware {
+		optee: optee {
+			compatible = "linaro,optee-tz";
+			method = "smc";
+		};
+	};
+
+	hdmi_con: hdmi-con {
+		compatible = "hdmi-connector";
+		type = "a";
+
+		port {
+			hdmi_con_in: endpoint {
+				remote-endpoint = <&hdmi_out_con>;
+			};
+		};
+	};
+
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		ramoops: ramoops@110000 {
+			compatible = "ramoops";
+			reg = <0 0x110000 0 0xf0000>;
+			console-size = <0x80000>;
+			ftrace-size = <0x00000>;
+			pmsg-size = <0x50000>;
+			record-size = <0x20000>;
+		};
+	};
+
+	rfkill-modem {
+		compatible = "rfkill-gpio";
+		label = "M.2 USB Modem";
+		radio-type = "wwan";
+		reset-gpios = <&gpio0 RK_PB0 GPIO_ACTIVE_LOW>;
+		shutdown-gpios = <&gpio4 RK_PC4 GPIO_ACTIVE_HIGH>;
+	};
+
+	vcca1v8: regulator-1v8-vcca {
+		compatible = "regulator-fixed";
+		regulator-name = "vcca1v8";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		vin-supply = <&vcc3v3_sys>;
+	};
+
+	vcc3v3_pcie: regulator-3v3-vcc-pcie {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		gpios = <&gpio0 RK_PA6 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pcie_enable_h>;
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-name = "vcc3v3_pcie";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&vcc5v0_sys>;
+	};
+
+	vcc3v3_sd: regulator-3v3-vcc-sd {
+		compatible = "regulator-fixed";
+		gpio = <&gpio0 RK_PB6 GPIO_ACTIVE_LOW>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&vcc_sd_h>;
+		regulator-boot-on;
+		regulator-name = "vcc3v3_sd";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&vcc_3v3>;
+	};
+
+	vcc3v3_sys: regulator-3v3-vcc-sys {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc3v3_sys";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&vcc5v0_sys>;
+	};
+
+	vcc5v0_sys: regulator-5v0-vcc-sys {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc5v0_sys";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+	};
+
+	vcc5v0_usb_host: regulator-5v0-vcc-usb-host {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		gpio = <&gpio0 RK_PA5 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&vcc5v0_usb_host_en>;
+		regulator-name = "vcc5v0_usb_host";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		vin-supply = <&vcc5v0_sys>;
+	};
+
+	vcc5v0_usb_modem: regulator-5v0-vcc-usb-modem {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		gpio = <&gpio4 RK_PC2 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&vcc5v0_usb_modem_en>;
+		regulator-name = "vcc5v0_usb_modem";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		vin-supply = <&vcc5v0_sys>;
+	};
+
+	vcc_1v8: regulator-1v8-vcc {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc_1v8";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		vin-supply = <&vcc3v3_sys>;
+	};
+
+	vcc_3v3: regulator-3v3-vcc {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc_3v3";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&vcc3v3_sys>;
+	};
+
+	vdda0v9: regulator-0v9-vdda {
+		compatible = "regulator-fixed";
+		regulator-name = "vdda0v9";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <900000>;
+		regulator-max-microvolt = <900000>;
+		vin-supply = <&vcc3v3_sys>;
+	};
+
+	vdd_gpu: regulator-vdd-gpu {
+		compatible = "pwm-regulator";
+		pwms = <&pwm2 0 5000 1>;
+		pwm-supply = <&vcc5v0_sys>;
+		regulator-name = "vdd_gpu";
+		regulator-min-microvolt = <800000>;
+		regulator-max-microvolt = <1350000>;
+		regulator-ramp-delay = <6001>;
+		regulator-settling-time-up-us = <250>;
+	};
+
+	vdd_logic: regulator-vdd-logic {
+		compatible = "pwm-regulator";
+		pwms = <&pwm1 0 5000 1>;
+		pwm-supply = <&vcc5v0_sys>;
+		regulator-name = "vdd_logic";
+		regulator-min-microvolt = <500000>;
+		regulator-max-microvolt = <1350000>;
+		regulator-ramp-delay = <6001>;
+		regulator-settling-time-up-us = <250>;
+	};
+
+	wifi_pwrseq: wifi-pwrseq {
+		compatible = "mmc-pwrseq-simple";
+		pinctrl-names = "default";
+		pinctrl-0 = <&wifi_enable_h>;
+		post-power-on-delay-ms = <200>;
+		reset-gpios = <&gpio2 RK_PB1 GPIO_ACTIVE_LOW>;
+	};
+};
+
+&combphy0 {
+	status = "okay";
+};
+
+&combphy1 {
+	status = "okay";
+};
+
+&combphy2 {
+	status = "okay";
+};
+
+&cpu0 {
+	cpu-supply = <&vdd_cpu>;
+};
+
+&cpu1 {
+	cpu-supply = <&vdd_cpu>;
+};
+
+&cpu2 {
+	cpu-supply = <&vdd_cpu>;
+};
+
+&cpu3 {
+	cpu-supply = <&vdd_cpu>;
+};
+
+&gmac0 {
+	status = "disabled";
+	/* Motoromm YT8521SC LAN port (require SGMII) */
+};
+
+&gmac1 {
+	assigned-clocks = <&cru SCLK_GMAC1_RX_TX>, <&cru SCLK_GMAC1>;
+	assigned-clock-parents = <&cru SCLK_GMAC1_RGMII_SPEED>;
+	assigned-clock-rates = <0>, <125000000>;
+	clock_in_out = "output";
+	phy-handle = <&rgmii_phy1>;
+	phy-mode = "rgmii";
+	phy-supply = <&vcc_3v3>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&gmac1m1_miim
+		     &gmac1m1_tx_bus2
+		     &gmac1m1_rx_bus2
+		     &gmac1m1_rgmii_clk
+		     &gmac1m1_rgmii_bus>;
+	snps,reset-gpio = <&gpio4 RK_PC0 GPIO_ACTIVE_LOW>;
+	snps,reset-active-low;
+	snps,reset-delays-us = <0 20000 100000>;
+	tx_delay = <0x38>;
+	rx_delay = <0x15>;
+	status = "okay";
+	/* Motoromm YT8521SC WAN port */
+};
+
+&gpu {
+	mali-supply = <&vdd_gpu>;
+	status = "okay";
+};
+
+&hdmi {
+	avdd-0v9-supply = <&vdda0v9>;
+	avdd-1v8-supply = <&vcca1v8>;
+	status = "okay";
+};
+
+&hdmi_in {
+	hdmi_in_vp0: endpoint {
+		remote-endpoint = <&vp0_out_hdmi>;
+	};
+};
+
+&hdmi_out {
+	hdmi_out_con: endpoint {
+		remote-endpoint = <&hdmi_con_in>;
+	};
+};
+
+&hdmi_sound {
+	status = "okay";
+};
+
+&i2c0 {
+	status = "okay";
+
+	vdd_cpu: regulator@1c {
+		compatible = "tcs,tcs4525";
+		reg = <0x1c>;
+		fcs,suspend-voltage-selector = <1>;
+		regulator-name = "vdd_cpu";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <800000>;
+		regulator-max-microvolt = <1150000>;
+		regulator-ramp-delay = <2300>;
+		vin-supply = <&vcc5v0_sys>;
+
+		regulator-state-mem {
+			regulator-off-in-suspend;
+		};
+	};
+};
+
+&i2c2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c2m1_xfer>;
+	status = "okay";
+};
+
+&i2s0_8ch {
+	status = "okay";
+};
+
+&mdio1 {
+	rgmii_phy1: ethernet-phy@0 {
+		compatible = "ethernet-phy-ieee802.3-c22";
+		reg = <0x0>;
+	};
+};
+
+&pcie30phy {
+	phy-supply = <&vcc3v3_pcie>;
+	status = "okay";
+};
+
+&pcie3x2 {
+	max-link-speed = <1>;
+	num-lanes = <1>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcie30x2m1_pins>;
+	reset-gpios = <&gpio0 RK_PC3 GPIO_ACTIVE_HIGH>;
+	vpcie3v3-supply = <&vcc3v3_pcie>;
+	status = "okay";
+	/* M.2 E-Key for PCIe WLAN */
+};
+
+&pinctrl {
+	bt {
+		bt_enable_h: bt-enable-h {
+			rockchip,pins = <2 RK_PB7 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
+	pcie {
+		pcie_enable_h: pcie-enable-h {
+			rockchip,pins = <0 RK_PA6 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
+	pmic {
+		pmic_int: pmic-int {
+			rockchip,pins = <0 RK_PA3 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+	};
+
+	sdio-pwrseq {
+		wifi_enable_h: wifi-enable-h {
+			rockchip,pins = <2 RK_PB1 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
+	usb2 {
+		vcc5v0_usb_host_en: vcc5v0-host-en {
+			rockchip,pins = <0 RK_PA5 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+
+		vcc5v0_usb_modem_en: vcc5v0-modem-en {
+			rockchip,pins = <4 RK_PC2 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
+	vcc_sd {
+		vcc_sd_h: vcc-sd-h {
+			rockchip,pins = <0 RK_PB6 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
+};
+
+&pmu_io_domains {
+	pmuio1-supply = <&vcc_3v3>;
+	pmuio2-supply = <&vcc_3v3>;
+	vccio1-supply = <&vcc_3v3>;
+	vccio2-supply = <&vcc_1v8>;
+	vccio3-supply = <&vcc_3v3>;
+	vccio4-supply = <&vcc_1v8>;
+	vccio5-supply = <&vcc_3v3>;
+	vccio6-supply = <&vcc_3v3>;
+	vccio7-supply = <&vcc_3v3>;
+	status = "okay";
+};
+
+&pmugrf {
+	reboot-mode {
+		compatible = "syscon-reboot-mode";
+		offset = <0x200>;
+		mode-normal = <BOOT_NORMAL>;
+		mode-loader = <BOOT_BL_DOWNLOAD>;
+		mode-recovery = <BOOT_RECOVERY>;
+		mode-bootloader = <BOOT_FASTBOOT>;
+	};
+};
+
+&pwm1 {
+	status = "okay";
+};
+
+&pwm2 {
+	status = "okay";
+};
+
+&saradc {
+	vref-supply = <&vcca1v8>;
+	status = "okay";
+};
+
+&sdhci {
+	bus-width = <8>;
+	max-frequency = <200000000>;
+	non-removable;
+	pinctrl-names = "default";
+	pinctrl-0 = <&emmc_bus8 &emmc_clk &emmc_cmd>;
+	vmmc-supply = <&vcc_3v3>;
+	vqmmc-supply = <&vcc_1v8>;
+	status = "okay";
+};
+
+&sdmmc0 {
+	bus-width = <4>;
+	cap-mmc-highspeed;
+	cap-sd-highspeed;
+	cd-gpios = <&gpio0 RK_PB5 GPIO_ACTIVE_LOW>;
+	disable-wp;
+	max-frequency = <150000000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&sdmmc0_bus4 &sdmmc0_clk &sdmmc0_cmd &sdmmc0_det>;
+	sd-uhs-sdr104;
+	vmmc-supply = <&vcc3v3_sd>;
+	vqmmc-supply = <&vcc_3v3>;
+	status = "okay";
+};
+
+&sdmmc1 {
+	bus-width = <4>;
+	cap-sd-highspeed;
+	cap-sdio-irq;
+	disable-wp;
+	keep-power-in-suspend;
+	max-frequency = <150000000>;
+	mmc-pwrseq = <&wifi_pwrseq>;
+	non-removable;
+	pinctrl-names = "default";
+	pinctrl-0 = <&sdmmc1_bus4 &sdmmc1_cmd &sdmmc1_clk>;
+	sd-uhs-sdr104;
+	vmmc-supply = <&vcc3v3_sys>;
+	vqmmc-supply = <&vcc_1v8>;
+	#address-cells = <1>;
+	#size-cells = <0>;
+	status = "okay";
+
+	qca_wifi: qca-wifi@1 {
+		compatible = "qcom,ath10k";
+		reg = <1>;
+	};
+};
+
+&tsadc {
+	rockchip,hw-tshut-mode = <1>;
+	rockchip,hw-tshut-polarity = <0>;
+	status = "okay";
+};
+
+&uart1 {
+	dma-names = "tx", "rx";
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart1m0_xfer &uart1m0_ctsn &uart1m0_rtsn>;
+	uart-has-rtscts;
+	status = "okay";
+
+	bluetooth: bluetooth {
+		compatible = "qcom,qca9377-bt";
+		clocks = <&pmucru CLK_RTC_32K>;
+		enable-gpios = <&gpio2 RK_PB7 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&bt_enable_h>;
+		vddio-supply = <&vcc_1v8>;
+	};
+};
+
+&uart2 {
+	status = "okay";
+};
+
+&uart4 {
+	dma-names = "tx", "rx";
+	status = "okay";
+	/* Onboard power management MCU */
+};
+
+&usb_host0_ohci {
+	status = "okay";
+};
+
+&usb_host0_ehci {
+	status = "okay";
+};
+
+&usb_host0_xhci {
+	dr_mode = "host";
+	status = "okay";
+	/* USB Type-A Port */
+};
+
+&usb_host1_ohci {
+	status = "okay";
+};
+
+&usb_host1_ehci {
+	status = "okay";
+};
+
+&usb_host1_xhci {
+	dr_mode = "host";
+	status = "okay";
+	/* M.2 B-Key for USB Modem WWAN */
+};
+
+&usb2phy0 {
+	status = "okay";
+};
+
+&usb2phy0_host {
+	phy-supply = <&vcc5v0_usb_modem>;
+	status = "okay";
+};
+
+&usb2phy0_otg {
+	phy-supply = <&vcc5v0_usb_host>;
+	status = "okay";
+};
+
+&usb2phy1 {
+	status = "okay";
+};
+
+&usb2phy1_host {
+	phy-supply = <&vcc5v0_usb_modem>;
+	status = "okay";
+};
+
+&usb2phy1_otg {
+	phy-supply = <&vcc5v0_usb_host>;
+	status = "okay";
+};
+
+&vop {
+	assigned-clocks = <&cru DCLK_VOP0>, <&cru DCLK_VOP1>;
+	assigned-clock-parents = <&pmucru PLL_HPLL>, <&cru PLL_VPLL>;
+	status = "okay";
+};
+
+&vop_mmu {
+	status = "okay";
+};
+
+&vp0 {
+	vp0_out_hdmi: endpoint@ROCKCHIP_VOP2_EP_HDMI0 {
+		reg = <ROCKCHIP_VOP2_EP_HDMI0>;
+		remote-endpoint = <&hdmi_in_vp0>;
+	};
+};
-- 
2.46.0


