Return-Path: <linux-kernel+bounces-329547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24C599792C3
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 19:57:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1702B2219E
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 17:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 977811D1312;
	Sat, 14 Sep 2024 17:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="Qr7rASQ7"
Received: from mail-m17236.xmail.ntesmail.com (mail-m17236.xmail.ntesmail.com [45.195.17.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D301D0DC9;
	Sat, 14 Sep 2024 17:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.195.17.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726336643; cv=none; b=ieiEtwoU0dEh/jcKc7zZ0Cs0xSY2RFQErxYNfw3qDCCuE84/0hTcrTMLy8Gs0kRI/9P+WpyusJlPeReWZo0yDAl3BQVDHPKA9oi7MrTpEfecMC+o1LqyN0xE8mm4iDtQmUjVQFAdGgXXGmGaALIbVwDhNnfoXXgHkCe9vLtIppE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726336643; c=relaxed/simple;
	bh=AEWOvM1j1h7m29g4cDoQAZUsGji3DoDiJyl+jKNs+iw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aiF8Ms6Xt2gCvQjwX99+vUX0zxMgEgFpiBHUT+hqkNKv8aRebze+jhou6hogNJaRj/7Lhwm4LMmdaHJUiZQGU183KMm8lRb4ZBfPVRUzxvwSP6Z8QOPDCAsmC7W0z0dz2SkocJd5AwnOJSarQUIOhL2P6lrqEHuL6Njyek+Q/Zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=Qr7rASQ7; arc=none smtp.client-ip=45.195.17.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
DKIM-Signature: a=rsa-sha256;
	b=Qr7rASQ7egdvs7ctwxGy5PoXZLCp9mkVJvx60hAvSwlEKkgsaJceNZtJk7SmgqA3jgo/JAektWvc3mVwsO2ZN5tx2ZZKsxIDjVCZD0rmA5g7lYEx/D7znQt4VWBsTLgMhBT0J2u2d9UPBIYdRXPa4QNoPDKflZpTPAe4Vcik/xY=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=vGgWwshm1MoM9vgXWajYT4/OhZwCOZuC5osokTj8Rg8=;
	h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.26] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTPA id D50DA10043A;
	Sat, 14 Sep 2024 17:17:57 +0800 (CST)
Message-ID: <1c4fc5d7-4b8b-4bff-bc8e-264c43b5168e@rock-chips.com>
Date: Sat, 14 Sep 2024 17:17:57 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] arm64: dts: rockchip: Add RK3588S EVB1 board
To: Jonas Karlman <jonas@kwiboo.se>, heiko@sntech.de
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 macromorgan@hotmail.com, tim@feathertop.org, knaerzche@gmail.com,
 efectn@protonmail.com, andyshrk@163.com, jagan@edgeble.ai,
 dsimic@manjaro.org, megi@xff.cz, sebastian.reichel@collabora.com,
 alchark@gmail.com, boris.brezillon@collabora.com,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240912080248.1133061-1-damon.ding@rock-chips.com>
 <20240912080248.1133061-3-damon.ding@rock-chips.com>
 <9dcbde7f-b169-4c14-aa81-97c5684d8537@kwiboo.se>
Content-Language: en-US
From: Damon Ding <damon.ding@rock-chips.com>
In-Reply-To: <9dcbde7f-b169-4c14-aa81-97c5684d8537@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQk1MSVZPTE5NSkpMHx8dS0lWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
X-HM-Tid: 0a91efd328f603a7kunmd50da10043a
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NC46Qxw*KDIrGRMiVgofSx0U
	EBcwCjZVSlVKTElNSEtOT0xCTUhKVTMWGhIXVR8aFhQVVR8SFRw7CRQYEFYYExILCFUYFBZFWVdZ
	EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFIT0lOSDcG

Hi Jonas:

On 2024/9/12 20:21, Jonas Karlman wrote:
> On 2024-09-12 10:02, Damon Ding wrote:
>> RK3588S EVB1 board features:
>> - Rockchip RK3588S
>> - PMIC: RK806-2x2pcs+DiscretePower
>> - RAM: LPDDR4/4x 2pcsx 32bit
>> - ROM: eMMC5.1+ SPI Falsh
>>
>> Add support for pmic, eMMC, SD-card, USB, PCIE and audio.
>>
>> Signed-off-by: Damon Ding <damon.ding@rock-chips.com>
>> ---
>>
>> Changes in v2:
>> - rename amplifier nodes to amplifier-headphone and amplifier-speaker
>> - sort audio and backlight nodes by node name
>> - format names of regulator nodes to regulator-*
>> - add CPU/memory regulator coupling
>> - fix "VOP-" to "VOL-" in commit message
>> - remove bootargs property in chosen node
>>
>> Changes in v3:
>> - remove unevaluated properties:
>>      pcie@fe190000: 'rockchip,skip-scan-in-resume'
>>      pmic@1: regulators: dcdc-reg*: 'regulator-init-microvolt'
>>      phy@fed80000: 'svid'
>>
>> Change in v4:
>> - remove unexpected property bootargs which added by mistake in v3
>> - add cd-gpios property in sdmmc node
>> - enable combphy2_psu for pcie2x1l1
>> - improve commit message
>>
>>   arch/arm64/boot/dts/rockchip/Makefile         |    1 +
>>   .../boot/dts/rockchip/rk3588s-evb1-v10.dts    | 1129 +++++++++++++++++
>>   2 files changed, 1130 insertions(+)
>>   create mode 100644 arch/arm64/boot/dts/rockchip/rk3588s-evb1-v10.dts
>>
>> diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
>> index fda1b980eb4b..f2992da01ada 100644
>> --- a/arch/arm64/boot/dts/rockchip/Makefile
>> +++ b/arch/arm64/boot/dts/rockchip/Makefile
>> @@ -139,6 +139,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-tiger-haikou.dtb
>>   dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-toybrick-x0.dtb
>>   dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-turing-rk1.dtb
>>   dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588s-coolpi-4b.dtb
>> +dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588s-evb1-v10.dtb
>>   dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588s-indiedroid-nova.dtb
>>   dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588s-khadas-edge2.dtb
>>   dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588s-nanopi-r6s.dtb
>> diff --git a/arch/arm64/boot/dts/rockchip/rk3588s-evb1-v10.dts b/arch/arm64/boot/dts/rockchip/rk3588s-evb1-v10.dts
>> new file mode 100644
>> index 000000000000..43decc6698e7
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/rockchip/rk3588s-evb1-v10.dts
>> @@ -0,0 +1,1129 @@
>> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>> +/*
>> + * Copyright (c) 2024 Rockchip Electronics Co., Ltd.
>> + *
>> + */
>> +
>> +/dts-v1/;
>> +
>> +#include <dt-bindings/gpio/gpio.h>
>> +#include <dt-bindings/input/input.h>
>> +#include <dt-bindings/pinctrl/rockchip.h>
>> +#include <dt-bindings/usb/pd.h>
>> +#include "rk3588s.dtsi"
>> +
>> +/ {
>> +	model = "Rockchip RK3588S EVB1 V10 Board";
>> +	compatible = "rockchip,rk3588s-evb1-v10", "rockchip,rk3588s";
>> +
> 
> [snip]
> 
>> +
>> +	vbus5v0_typec: regulator-vbus5v0-typec {
>> +		compatible = "regulator-fixed";
>> +		enable-active-high;
>> +		gpio = <&gpio1 RK_PA1 GPIO_ACTIVE_HIGH>;
> 
> Please use the gpios prop consistently in this file.

I will update accordingly.

> 
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = <&typec5v_pwren>;
>> +		regulator-name = "vbus5v0_typec";
>> +		regulator-min-microvolt = <5000000>;
>> +		regulator-max-microvolt = <5000000>;
>> +		vin-supply = <&vcc5v0_usb>;
>> +	};
>> +
>> +	vcc12v_dcin: regulator-vcc12v-dcin {
>> +		compatible = "regulator-fixed";
>> +		regulator-name = "vcc12v_dcin";
>> +		regulator-always-on;
>> +		regulator-boot-on;
>> +		regulator-min-microvolt = <12000000>;
>> +		regulator-max-microvolt = <12000000>;
>> +	};
>> +
>> +	vcc3v3_lcd_edp: regulator-vcc3v3-lcd-edp {
>> +		compatible = "regulator-fixed";
>> +		enable-active-high;
>> +		gpio = <&gpio1 RK_PA5 GPIO_ACTIVE_HIGH>;
> 
> Same.
> 
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = <&vcc3v3_lcd_edp_en>;
>> +		regulator-name = "vcc3v3_lcd_edp";
>> +		regulator-boot-on;
>> +		vin-supply = <&vcc_3v3_s3>;
>> +	};
>> +
>> +	vcc3v3_pcie20: regulator-vcc3v3-pcie20 {
>> +		compatible = "regulator-fixed";
>> +		enable-active-high;
>> +		gpios = <&gpio4 RK_PB1 GPIO_ACTIVE_HIGH>;
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = <&vcc3v3_pcie20_en>;
>> +		regulator-name = "vcc3v3_pcie20";
>> +		regulator-min-microvolt = <3300000>;
>> +		regulator-max-microvolt = <3300000>;
>> +		startup-delay-us = <5000>;
>> +		vin-supply = <&vcc12v_dcin>;
>> +	};
>> +
>> +	vcc5v0_host: regulator-vcc5v0-host {
>> +		compatible = "regulator-fixed";
>> +		enable-active-high;
>> +		gpio = <&gpio1 RK_PB1 GPIO_ACTIVE_HIGH>;
> 
> Same.
> 
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = <&vcc5v0_host_en>;
>> +		regulator-name = "vcc5v0_host";
>> +		regulator-always-on;
>> +		regulator-boot-on;
>> +		regulator-min-microvolt = <5000000>;
>> +		regulator-max-microvolt = <5000000>;
>> +		vin-supply = <&vcc5v0_usb>;
>> +	};
>> +
>> +	vcc5v0_sys: regulator-vcc5v0-sys {
>> +		compatible = "regulator-fixed";
>> +		regulator-name = "vcc5v0_sys";
>> +		regulator-always-on;
>> +		regulator-boot-on;
>> +		regulator-min-microvolt = <5000000>;
>> +		regulator-max-microvolt = <5000000>;
>> +		vin-supply = <&vcc12v_dcin>;
>> +	};
>> +
>> +	vcc5v0_usb: regulator-vcc5v0-usb {
>> +		compatible = "regulator-fixed";
>> +		regulator-name = "vcc5v0_usb";
>> +		regulator-always-on;
>> +		regulator-boot-on;
>> +		regulator-min-microvolt = <5000000>;
>> +		regulator-max-microvolt = <5000000>;
>> +		vin-supply = <&vcc5v0_usbdcin>;
>> +	};
>> +
>> +	vcc5v0_usbdcin: regulator-vcc5v0-usbdcin {
>> +		compatible = "regulator-fixed";
>> +		regulator-name = "vcc5v0_usbdcin";
>> +		regulator-always-on;
>> +		regulator-boot-on;
>> +		regulator-min-microvolt = <5000000>;
>> +		regulator-max-microvolt = <5000000>;
>> +		vin-supply = <&vcc12v_dcin>;
>> +	};
>> +};
>> +
>> +&combphy0_ps {
>> +	status = "okay";
>> +};
>> +
>> +&combphy2_psu {
>> +	status = "okay";
>> +};
>> +
>> +&i2c3 {
>> +	status = "okay";
>> +
>> +	es8388: audio-codec@11 {
>> +		compatible = "everest,es8388";
>> +		reg = <0x11>;
>> +		clocks = <&cru I2S0_8CH_MCLKOUT>;
>> +		assigned-clocks = <&cru I2S0_8CH_MCLKOUT>;
>> +		assigned-clock-rates = <12288000>;
>> +		AVDD-supply = <&avcc_1v8_s0>;
>> +		DVDD-supply = <&avcc_1v8_s0>;
>> +		HPVDD-supply = <&vcc_3v3_s0>;
>> +		PVDD-supply = <&vcc_3v3_s0>;
>> +		#sound-dai-cells = <0>;
>> +	};
>> +};
>> +
>> +&i2c8 {
>> +	status = "okay";
> 
> status should be last prop before child nodes.

I'll fix it in next version.

> 
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&i2c8m2_xfer>;
>> +
>> +	usbc0: usb-typec@22 {
>> +		compatible = "fcs,fusb302";
>> +		reg = <0x22>;
>> +		interrupt-parent = <&gpio0>;
>> +		interrupts = <RK_PD3 IRQ_TYPE_LEVEL_LOW>;
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = <&usbc0_int>;
>> +		vbus-supply = <&vbus5v0_typec>;
>> +		status = "okay";
> 
> status prop is not needed here.

I appreciate your advice and plan to follow it.

> 
>> +
>> +		usb_con: connector {
>> +			compatible = "usb-c-connector";
>> +			label = "USB-C";
>> +			data-role = "dual";
>> +			op-sink-microwatt = <1000000>;
>> +			power-role = "dual";
>> +			sink-pdos =
>> +				<PDO_FIXED(5000, 1000, PDO_FIXED_USB_COMM)>;
>> +			source-pdos =
>> +				<PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)>;
>> +			try-power-role = "source";
>> +
>> +			ports {
>> +				#address-cells = <1>;
>> +				#size-cells = <0>;
>> +
>> +				port@0 {
>> +					reg = <0>;
>> +
>> +					usbc0_orien_sw: endpoint {
>> +						remote-endpoint = <&usbdp_phy0_orientation_switch>;
>> +					};
>> +				};
>> +
>> +				port@1 {
>> +					reg = <1>;
>> +
>> +					usbc0_role_sw: endpoint {
>> +						remote-endpoint = <&dwc3_0_role_switch>;
>> +					};
>> +				};
>> +
>> +				port@2 {
>> +					reg = <2>;
>> +
>> +					dp_altmode_mux: endpoint {
>> +						remote-endpoint = <&usbdp_phy0_dp_altmode_mux>;
>> +					};
>> +				};
>> +			};
>> +		};
>> +	};
>> +
>> +	hym8563: rtc@51 {
>> +		compatible = "haoyu,hym8563";
>> +		reg = <0x51>;
>> +		#clock-cells = <0>;
>> +		clock-output-names = "hym8563";
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = <&hym8563_int>;
>> +		interrupt-parent = <&gpio0>;
>> +		interrupts = <RK_PD4 IRQ_TYPE_LEVEL_LOW>;
>> +		wakeup-source;
>> +	};
>> +};
>> +
>> +&pcie2x1l1 {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&pcie2_1_rst>;
> 
> Should probably also include clkreqn and waken pins.

I have tested the PCIE with an NVMe SSD, and it works with these two 
pins in their default settings.

> 
>> +	reset-gpios = <&gpio4 RK_PA2 GPIO_ACTIVE_HIGH>;
>> +	vpcie3v3-supply = <&vcc3v3_pcie20>;
>> +	status = "okay";
>> +};
>> +
>> +&pcie2x1l2 {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&pcie2_2_rst>;
> 
> Same.
> 
>> +	reset-gpios = <&gpio4 RK_PC1 GPIO_ACTIVE_HIGH>;
>> +	status = "okay";
>> +};
>> +
>> +&pinctrl {
>> +	audio {
>> +		hp_detect: headphone-detect {
>> +			rockchip,pins = <1 RK_PD0 RK_FUNC_GPIO &pcfg_pull_none>;
>> +		};
>> +
>> +		headphone_amplifier_en: headphone-amplifier-en {
>> +			rockchip,pins = <4 RK_PA4 RK_FUNC_GPIO &pcfg_pull_none>;
>> +		};
>> +
>> +		speaker_amplifier_en: speaker-amplifier-en {
>> +			rockchip,pins = <4 RK_PA5 RK_FUNC_GPIO &pcfg_pull_none>;
>> +		};
>> +	};
>> +
>> +	hym8563 {
>> +		hym8563_int: hym8563-int {
>> +			rockchip,pins = <0 RK_PC4 RK_FUNC_GPIO &pcfg_pull_up>;
>> +		};
>> +	};
>> +
>> +	lcd-edp {
>> +		vcc3v3_lcd_edp_en: vcc3v3-lcd-edp-en {
>> +			rockchip,pins = <1 RK_PA5 RK_FUNC_GPIO &pcfg_pull_none>;
>> +		};
>> +	};
>> +
>> +	pcie2 {
>> +		pcie2_1_rst: pcie2-1-rst {
>> +			rockchip,pins = <4 RK_PA2 RK_FUNC_GPIO &pcfg_pull_none>;
>> +		};
>> +
>> +		pcie2_2_rst: pcie2-2-rst {
>> +			rockchip,pins = <4 RK_PC1 RK_FUNC_GPIO &pcfg_pull_none>;
>> +		};
>> +
>> +		vcc3v3_pcie20_en: vcc3v3-pcie20-en {
>> +			rockchip,pins = <4 RK_PB1 RK_FUNC_GPIO &pcfg_pull_none>;
>> +		};
>> +	};
>> +
>> +	usb {
>> +		vcc5v0_host_en: vcc5v0-host-en {
>> +			rockchip,pins = <1 RK_PB1 RK_FUNC_GPIO &pcfg_pull_none>;
>> +		};
>> +	};
>> +
>> +	usb-typec {
>> +		typec5v_pwren: typec5v-pwren {
>> +			rockchip,pins = <1 RK_PA1 RK_FUNC_GPIO &pcfg_pull_none>;
>> +		};
>> +
>> +		usbc0_int: usbc0-int {
>> +			rockchip,pins = <0 RK_PD3 RK_FUNC_GPIO &pcfg_pull_up>;
>> +		};
>> +	};
>> +};
>> +
>> +&pwm12 {
>> +	status = "okay";
>> +};
>> +
>> +&saradc {
>> +	vref-supply = <&vcc_1v8_s0>;
>> +	status = "okay";
>> +};
>> +
>> +&sdhci {
>> +	bus-width = <8>;
>> +	mmc-hs400-1_8v;
>> +	mmc-hs400-enhanced-strobe;
>> +	no-sdio;
>> +	no-sd;
>> +	non-removable;
>> +	status = "okay";
>> +};
>> +
>> +&sdmmc {
>> +	bus-width = <4>;
>> +	cap-mmc-highspeed;
> 
> Probably not needed with no-mmc prop.

The board only supports SD-card for this device, and the no-mmc prop 
will make it clearer.

> 
>> +	cap-sd-highspeed;
>> +	cd-gpios = <&gpio0 RK_PA4 GPIO_ACTIVE_LOW>;
>> +	disable-wp;
>> +	max-frequency = <150000000>;
>> +	no-sdio;
>> +	no-mmc;
> 
> Please sort alphabetically, no-mmc before no-sdio,

I'll sort these properties alphabetically in next version.

> 
>> +	vmmc-supply = <&vcc_3v3_sd_s0>;
>> +	vqmmc-supply = <&vccio_sd_s0>;
>> +	sd-uhs-sdr104;
> 
> and sd-uhs-sdr104 before vmmc-supply.
> 
>> +	status = "okay";
>> +};
>> +
>> +&spi2 {
>> +	assigned-clocks = <&cru CLK_SPI2>;
>> +	assigned-clock-rates = <200000000>;
>> +	num-cs = <2>;
>> +	status = "okay";
>> +
>> +	pmic@0 {
>> +		compatible = "rockchip,rk806";
>> +		reg = <0x0>;
>> +		#gpio-cells = <2>;
>> +		gpio-controller;
>> +		interrupt-parent = <&gpio0>;
>> +		interrupts = <7 IRQ_TYPE_LEVEL_LOW>;
> 
> Should probably use RK_PA7 and not a plain 7.

Indeed, I will fix it.

> 
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = <&pmic_pins>, <&rk806_dvs1_null>,
>> +			    <&rk806_dvs2_null>, <&rk806_dvs3_null>;
>> +		spi-max-frequency = <1000000>;
>> +		system-power-controller;
>> +
>> +		vcc1-supply = <&vcc5v0_sys>;
>> +		vcc2-supply = <&vcc5v0_sys>;
>> +		vcc3-supply = <&vcc5v0_sys>;
>> +		vcc4-supply = <&vcc5v0_sys>;
>> +		vcc5-supply = <&vcc5v0_sys>;
>> +		vcc6-supply = <&vcc5v0_sys>;
>> +		vcc7-supply = <&vcc5v0_sys>;
>> +		vcc8-supply = <&vcc5v0_sys>;
>> +		vcc9-supply = <&vcc5v0_sys>;
>> +		vcc10-supply = <&vcc5v0_sys>;
>> +		vcc11-supply = <&vcc_2v0_pldo_s3>;
>> +		vcc12-supply = <&vcc5v0_sys>;
>> +		vcc13-supply = <&vcc5v0_sys>;
>> +		vcc14-supply = <&vcc_1v1_nldo_s3>;
>> +		vcca-supply = <&vcc5v0_sys>;
>> +
>> +		rk806_dvs1_null: dvs1-null-pins {
>> +			pins = "gpio_pwrctrl1";
>> +			function = "pin_fun0";
>> +		};
>> +
>> +		rk806_dvs2_null: dvs2-null-pins {
>> +			pins = "gpio_pwrctrl2";
>> +			function = "pin_fun0";
>> +		};
>> +
>> +		rk806_dvs3_null: dvs3-null-pins {
>> +			pins = "gpio_pwrctrl3";
>> +			function = "pin_fun0";
>> +		};
>> +
>> +		regulators {
>> +			vdd_gpu_s0: dcdc-reg1 {
>> +				regulator-boot-on;
>> +				regulator-min-microvolt = <550000>;
>> +				regulator-max-microvolt = <950000>;
>> +				regulator-ramp-delay = <12500>;
>> +				regulator-enable-ramp-delay = <400>;
>> +				regulator-name = "vdd_gpu_s0";
>> +				regulator-state-mem {
>> +					regulator-off-in-suspend;
>> +				};
>> +			};
>> +
>> +			vdd_npu_s0: dcdc-reg2 {
>> +				regulator-always-on;
>> +				regulator-boot-on;
>> +				regulator-min-microvolt = <550000>;
>> +				regulator-max-microvolt = <950000>;
>> +				regulator-ramp-delay = <12500>;
>> +				regulator-name = "vdd_npu_s0";
>> +				regulator-state-mem {
>> +					regulator-off-in-suspend;
>> +				};
>> +			};
>> +
>> +			vdd_log_s0: dcdc-reg3 {
>> +				regulator-always-on;
>> +				regulator-boot-on;
>> +				regulator-min-microvolt = <675000>;
>> +				regulator-max-microvolt = <800000>;
>> +				regulator-ramp-delay = <12500>;
>> +				regulator-name = "vdd_log_s0";
>> +				regulator-state-mem {
>> +					regulator-off-in-suspend;
>> +					regulator-suspend-microvolt = <750000>;
>> +				};
>> +			};
>> +
>> +			vdd_vdenc_s0: dcdc-reg4 {
>> +				regulator-always-on;
>> +				regulator-boot-on;
>> +				regulator-min-microvolt = <550000>;
>> +				regulator-max-microvolt = <950000>;
>> +				regulator-ramp-delay = <12500>;
>> +				regulator-name = "vdd_vdenc_s0";
>> +				regulator-state-mem {
>> +					regulator-off-in-suspend;
>> +				};
>> +			};
>> +
>> +			vdd_gpu_mem_s0: dcdc-reg5 {
>> +				regulator-boot-on;
>> +				regulator-min-microvolt = <675000>;
>> +				regulator-max-microvolt = <950000>;
>> +				regulator-ramp-delay = <12500>;
>> +				regulator-enable-ramp-delay = <400>;
>> +				regulator-name = "vdd_gpu_mem_s0";
>> +				regulator-state-mem {
>> +					regulator-off-in-suspend;
>> +				};
>> +			};
>> +
>> +			vdd_npu_mem_s0: dcdc-reg6 {
>> +				regulator-always-on;
>> +				regulator-boot-on;
>> +				regulator-min-microvolt = <675000>;
>> +				regulator-max-microvolt = <950000>;
>> +				regulator-ramp-delay = <12500>;
>> +				regulator-name = "vdd_npu_mem_s0";
>> +				regulator-state-mem {
>> +					regulator-off-in-suspend;
>> +				};
>> +			};
>> +
>> +			vcc_2v0_pldo_s3: dcdc-reg7 {
>> +				regulator-always-on;
>> +				regulator-boot-on;
>> +				regulator-min-microvolt = <2000000>;
>> +				regulator-max-microvolt = <2000000>;
>> +				regulator-ramp-delay = <12500>;
>> +				regulator-name = "vdd_2v0_pldo_s3";
>> +				regulator-state-mem {
>> +					regulator-on-in-suspend;
>> +					regulator-suspend-microvolt = <2000000>;
>> +				};
>> +			};
>> +
>> +			vdd_vdenc_mem_s0: dcdc-reg8 {
>> +				regulator-always-on;
>> +				regulator-boot-on;
>> +				regulator-min-microvolt = <675000>;
>> +				regulator-max-microvolt = <950000>;
>> +				regulator-ramp-delay = <12500>;
>> +				regulator-name = "vdd_vdenc_mem_s0";
>> +				regulator-state-mem {
>> +					regulator-off-in-suspend;
>> +				};
>> +			};
>> +
>> +			vdd2_ddr_s3: dcdc-reg9 {
>> +				regulator-always-on;
>> +				regulator-boot-on;
>> +				regulator-name = "vdd2_ddr_s3";
>> +				regulator-state-mem {
>> +					regulator-on-in-suspend;
>> +				};
>> +			};
>> +
>> +			vcc_1v1_nldo_s3: dcdc-reg10 {
>> +				regulator-always-on;
>> +				regulator-boot-on;
>> +				regulator-min-microvolt = <1100000>;
>> +				regulator-max-microvolt = <1100000>;
>> +				regulator-ramp-delay = <12500>;
>> +				regulator-name = "vcc_1v1_nldo_s3";
>> +				regulator-state-mem {
>> +					regulator-on-in-suspend;
>> +					regulator-suspend-microvolt = <1100000>;
>> +				};
>> +			};
>> +
>> +			avcc_1v8_s0: pldo-reg1 {
>> +				regulator-always-on;
>> +				regulator-boot-on;
>> +				regulator-min-microvolt = <1800000>;
>> +				regulator-max-microvolt = <1800000>;
>> +				regulator-ramp-delay = <12500>;
>> +				regulator-name = "avcc_1v8_s0";
>> +				regulator-state-mem {
>> +					regulator-off-in-suspend;
>> +				};
>> +			};
>> +
>> +			vdd1_1v8_ddr_s3: pldo-reg2 {
>> +				regulator-always-on;
>> +				regulator-boot-on;
>> +				regulator-min-microvolt = <1800000>;
>> +				regulator-max-microvolt = <1800000>;
>> +				regulator-ramp-delay = <12500>;
>> +				regulator-name = "vdd1_1v8_ddr_s3";
>> +				regulator-state-mem {
>> +					regulator-on-in-suspend;
>> +					regulator-suspend-microvolt = <1800000>;
>> +				};
>> +			};
>> +
>> +			vcc_1v8_s3: pldo-reg3 {
>> +				regulator-always-on;
>> +				regulator-boot-on;
>> +				regulator-min-microvolt = <1800000>;
>> +				regulator-max-microvolt = <1800000>;
>> +				regulator-ramp-delay = <12500>;
>> +				regulator-name = "vcc_1v8_s3";
>> +				regulator-state-mem {
>> +					regulator-on-in-suspend;
>> +					regulator-suspend-microvolt = <1800000>;
>> +				};
>> +			};
>> +
>> +			vcc_3v3_s0: pldo-reg4 {
>> +				regulator-always-on;
>> +				regulator-boot-on;
>> +				regulator-min-microvolt = <3300000>;
>> +				regulator-max-microvolt = <3300000>;
>> +				regulator-ramp-delay = <12500>;
>> +				regulator-name = "vcc_3v3_s0";
>> +				regulator-state-mem {
>> +					regulator-off-in-suspend;
>> +				};
>> +			};
>> +
>> +			vccio_sd_s0: pldo-reg5 {
>> +				regulator-always-on;
>> +				regulator-boot-on;
>> +				regulator-min-microvolt = <1800000>;
>> +				regulator-max-microvolt = <3300000>;
>> +				regulator-ramp-delay = <12500>;
>> +				regulator-name = "vccio_sd_s0";
>> +				regulator-state-mem {
>> +					regulator-off-in-suspend;
>> +				};
>> +			};
>> +
>> +			master_pldo6_s3: pldo-reg6 {
>> +				regulator-always-on;
>> +				regulator-boot-on;
>> +				regulator-min-microvolt = <1800000>;
>> +				regulator-max-microvolt = <1800000>;
>> +				regulator-name = "master_pldo6_s3";
>> +				regulator-state-mem {
>> +					regulator-on-in-suspend;
>> +					regulator-suspend-microvolt = <1800000>;
>> +				};
>> +			};
>> +
>> +			vdd_0v75_s3: nldo-reg1 {
>> +				regulator-always-on;
>> +				regulator-boot-on;
>> +				regulator-min-microvolt = <750000>;
>> +				regulator-max-microvolt = <750000>;
>> +				regulator-ramp-delay = <12500>;
>> +				regulator-name = "vdd_0v75_s3";
>> +				regulator-state-mem {
>> +					regulator-on-in-suspend;
>> +					regulator-suspend-microvolt = <750000>;
>> +				};
>> +			};
>> +
>> +			vdd2l_0v9_ddr_s3: nldo-reg2 {
>> +				regulator-always-on;
>> +				regulator-boot-on;
>> +				regulator-min-microvolt = <900000>;
>> +				regulator-max-microvolt = <900000>;
>> +				regulator-name = "vdd2l_0v9_ddr_s3";
>> +				regulator-state-mem {
>> +					regulator-on-in-suspend;
>> +					regulator-suspend-microvolt = <900000>;
>> +				};
>> +			};
>> +
>> +			master_nldo3: nldo-reg3 {
>> +				regulator-name = "master_nldo3";
>> +				regulator-state-mem {
>> +					regulator-off-in-suspend;
>> +				};
>> +			};
>> +
>> +			avdd_0v75_s0: nldo-reg4 {
>> +				regulator-always-on;
>> +				regulator-boot-on;
>> +				regulator-min-microvolt = <750000>;
>> +				regulator-max-microvolt = <750000>;
>> +				regulator-name = "avdd_0v75_s0";
>> +				regulator-state-mem {
>> +					regulator-off-in-suspend;
>> +				};
>> +			};
>> +
>> +			vdd_0v85_s0: nldo-reg5 {
>> +				regulator-always-on;
>> +				regulator-boot-on;
>> +				regulator-min-microvolt = <850000>;
>> +				regulator-max-microvolt = <850000>;
>> +				regulator-name = "vdd_0v85_s0";
>> +				regulator-state-mem {
>> +					regulator-off-in-suspend;
>> +				};
>> +			};
>> +		};
>> +	};
>> +
>> +	pmic@1 {
>> +		compatible = "rockchip,rk806";
>> +		reg = <0x01>;
>> +		#gpio-cells = <2>;
>> +		gpio-controller;
>> +		interrupt-parent = <&gpio0>;
>> +		interrupts = <7 IRQ_TYPE_LEVEL_LOW>;
> 
> Should probably use RK_PA7 and not a plain 7.
> 
>> +		pinctrl-0 = <&rk806_slave_dvs1_null>, <&rk806_slave_dvs2_null>,
>> +			    <&rk806_slave_dvs3_null>;
>> +		pinctrl-names = "default";
> 
> Inconsistent order of pinctrl-names and pinctrl-0 compared to rest of file.

I will put pinctrl-names before pinctrl-0.

> 
>> +		spi-max-frequency = <1000000>;
>> +
>> +		vcc1-supply = <&vcc5v0_sys>;
>> +		vcc2-supply = <&vcc5v0_sys>;
>> +		vcc3-supply = <&vcc5v0_sys>;
>> +		vcc4-supply = <&vcc5v0_sys>;
>> +		vcc5-supply = <&vcc5v0_sys>;
>> +		vcc6-supply = <&vcc5v0_sys>;
>> +		vcc7-supply = <&vcc5v0_sys>;
>> +		vcc8-supply = <&vcc5v0_sys>;
>> +		vcc9-supply = <&vcc5v0_sys>;
>> +		vcc10-supply = <&vcc5v0_sys>;
>> +		vcc11-supply = <&vcc_2v0_pldo_s3>;
>> +		vcc12-supply = <&vcc5v0_sys>;
>> +		vcc13-supply = <&vcc_1v1_nldo_s3>;
>> +		vcc14-supply = <&vcc_2v0_pldo_s3>;
>> +		vcca-supply = <&vcc5v0_sys>;
>> +
>> +		rk806_slave_dvs1_null: dvs1-null-pins {
>> +			pins = "gpio_pwrctrl1";
>> +			function = "pin_fun0";
>> +		};
>> +
>> +		rk806_slave_dvs2_null: dvs2-null-pins {
>> +			pins = "gpio_pwrctrl2";
>> +			function = "pin_fun0";
>> +		};
>> +
>> +		rk806_slave_dvs3_null: dvs3-null-pins {
>> +			pins = "gpio_pwrctrl3";
>> +			function = "pin_fun0";
>> +		};
>> +
>> +		regulators {
>> +			vdd_cpu_big1_s0: dcdc-reg1 {
>> +				regulator-always-on;
>> +				regulator-boot-on;
>> +				regulator-coupled-with = <&vdd_cpu_big1_mem_s0>;
>> +				regulator-coupled-max-spread = <10000>;
>> +				regulator-min-microvolt = <550000>;
>> +				regulator-max-microvolt = <1050000>;
>> +				regulator-ramp-delay = <12500>;
>> +				regulator-name = "vdd_cpu_big1_s0";
>> +				regulator-state-mem {
>> +					regulator-off-in-suspend;
>> +				};
>> +			};
>> +
>> +			vdd_cpu_big0_s0: dcdc-reg2 {
>> +				regulator-always-on;
>> +				regulator-boot-on;
>> +				regulator-coupled-with = <&vdd_cpu_big0_mem_s0>;
>> +				regulator-coupled-max-spread = <10000>;
>> +				regulator-min-microvolt = <550000>;
>> +				regulator-max-microvolt = <1050000>;
>> +				regulator-ramp-delay = <12500>;
>> +				regulator-name = "vdd_cpu_big0_s0";
>> +				regulator-state-mem {
>> +					regulator-off-in-suspend;
>> +				};
>> +			};
>> +
>> +			vdd_cpu_lit_s0: dcdc-reg3 {
>> +				regulator-always-on;
>> +				regulator-boot-on;
>> +				regulator-coupled-with = <&vdd_cpu_lit_mem_s0>;
>> +				regulator-coupled-max-spread = <10000>;
>> +				regulator-min-microvolt = <550000>;
>> +				regulator-max-microvolt = <950000>;
>> +				regulator-ramp-delay = <12500>;
>> +				regulator-name = "vdd_cpu_lit_s0";
>> +				regulator-state-mem {
>> +					regulator-off-in-suspend;
>> +				};
>> +			};
>> +
>> +			vcc_3v3_s3: dcdc-reg4 {
>> +				regulator-always-on;
>> +				regulator-boot-on;
>> +				regulator-min-microvolt = <3300000>;
>> +				regulator-max-microvolt = <3300000>;
>> +				regulator-ramp-delay = <12500>;
>> +				regulator-name = "vcc_3v3_s3";
>> +				regulator-state-mem {
>> +					regulator-on-in-suspend;
>> +					regulator-suspend-microvolt = <3300000>;
>> +				};
>> +			};
>> +
>> +			vdd_cpu_big1_mem_s0: dcdc-reg5 {
>> +				regulator-always-on;
>> +				regulator-boot-on;
>> +				regulator-coupled-with = <&vdd_cpu_big1_s0>;
>> +				regulator-coupled-max-spread = <10000>;
>> +				regulator-min-microvolt = <675000>;
>> +				regulator-max-microvolt = <1050000>;
>> +				regulator-ramp-delay = <12500>;
>> +				regulator-name = "vdd_cpu_big1_mem_s0";
>> +				regulator-state-mem {
>> +					regulator-off-in-suspend;
>> +				};
>> +			};
>> +
>> +
>> +			vdd_cpu_big0_mem_s0: dcdc-reg6 {
>> +				regulator-always-on;
>> +				regulator-boot-on;
>> +				regulator-coupled-with = <&vdd_cpu_big0_s0>;
>> +				regulator-coupled-max-spread = <10000>;
>> +				regulator-min-microvolt = <675000>;
>> +				regulator-max-microvolt = <1050000>;
>> +				regulator-ramp-delay = <12500>;
>> +				regulator-name = "vdd_cpu_big0_mem_s0";
>> +				regulator-state-mem {
>> +					regulator-off-in-suspend;
>> +				};
>> +			};
>> +
>> +			vcc_1v8_s0: dcdc-reg7 {
>> +				regulator-always-on;
>> +				regulator-boot-on;
>> +				regulator-min-microvolt = <1800000>;
>> +				regulator-max-microvolt = <1800000>;
>> +				regulator-ramp-delay = <12500>;
>> +				regulator-name = "vcc_1v8_s0";
>> +				regulator-state-mem {
>> +					regulator-off-in-suspend;
>> +				};
>> +			};
>> +
>> +			vdd_cpu_lit_mem_s0: dcdc-reg8 {
>> +				regulator-always-on;
>> +				regulator-boot-on;
>> +				regulator-coupled-with = <&vdd_cpu_lit_s0>;
>> +				regulator-coupled-max-spread = <10000>;
>> +				regulator-min-microvolt = <675000>;
>> +				regulator-max-microvolt = <950000>;
>> +				regulator-ramp-delay = <12500>;
>> +				regulator-name = "vdd_cpu_lit_mem_s0";
>> +				regulator-state-mem {
>> +					regulator-off-in-suspend;
>> +				};
>> +			};
>> +
>> +			vddq_ddr_s0: dcdc-reg9 {
>> +				regulator-always-on;
>> +				regulator-boot-on;
>> +				regulator-name = "vddq_ddr_s0";
>> +				regulator-state-mem {
>> +					regulator-off-in-suspend;
>> +				};
>> +			};
>> +
>> +			vdd_ddr_s0: dcdc-reg10 {
>> +				regulator-always-on;
>> +				regulator-boot-on;
>> +				regulator-min-microvolt = <675000>;
>> +				regulator-max-microvolt = <900000>;
>> +				regulator-ramp-delay = <12500>;
>> +				regulator-name = "vdd_ddr_s0";
>> +				regulator-state-mem {
>> +					regulator-off-in-suspend;
>> +				};
>> +			};
>> +
>> +			vcc_1v8_cam_s0: pldo-reg1 {
>> +				regulator-always-on;
>> +				regulator-boot-on;
>> +				regulator-min-microvolt = <1800000>;
>> +				regulator-max-microvolt = <1800000>;
>> +				regulator-ramp-delay = <12500>;
>> +				regulator-name = "vcc_1v8_cam_s0";
>> +				regulator-state-mem {
>> +					regulator-off-in-suspend;
>> +				};
>> +			};
>> +
>> +			avdd1v8_ddr_pll_s0: pldo-reg2 {
>> +				regulator-always-on;
>> +				regulator-boot-on;
>> +				regulator-min-microvolt = <1800000>;
>> +				regulator-max-microvolt = <1800000>;
>> +				regulator-ramp-delay = <12500>;
>> +				regulator-name = "avdd1v8_ddr_pll_s0";
>> +				regulator-state-mem {
>> +					regulator-off-in-suspend;
>> +				};
>> +			};
>> +
>> +			vdd_1v8_pll_s0: pldo-reg3 {
>> +				regulator-always-on;
>> +				regulator-boot-on;
>> +				regulator-min-microvolt = <1800000>;
>> +				regulator-max-microvolt = <1800000>;
>> +				regulator-ramp-delay = <12500>;
>> +				regulator-name = "vdd_1v8_pll_s0";
>> +				regulator-state-mem {
>> +					regulator-off-in-suspend;
>> +				};
>> +			};
>> +
>> +			vcc_3v3_sd_s0: pldo-reg4 {
>> +				regulator-always-on;
>> +				regulator-boot-on;
>> +				regulator-min-microvolt = <3300000>;
>> +				regulator-max-microvolt = <3300000>;
>> +				regulator-ramp-delay = <12500>;
>> +				regulator-name = "vcc_3v3_sd_s0";
>> +				regulator-state-mem {
>> +					regulator-off-in-suspend;
>> +				};
>> +			};
>> +
>> +			vcc_2v8_cam_s0: pldo-reg5 {
>> +				regulator-always-on;
>> +				regulator-boot-on;
>> +				regulator-min-microvolt = <2800000>;
>> +				regulator-max-microvolt = <2800000>;
>> +				regulator-ramp-delay = <12500>;
>> +				regulator-name = "vcc_2v8_cam_s0";
>> +				regulator-state-mem {
>> +					regulator-off-in-suspend;
>> +				};
>> +			};
>> +
>> +			pldo6_s3: pldo-reg6 {
>> +				regulator-always-on;
>> +				regulator-boot-on;
>> +				regulator-min-microvolt = <1800000>;
>> +				regulator-max-microvolt = <1800000>;
>> +				regulator-name = "pldo6_s3";
>> +				regulator-state-mem {
>> +					regulator-on-in-suspend;
>> +					regulator-suspend-microvolt = <1800000>;
>> +				};
>> +			};
>> +
>> +			vdd_0v75_pll_s0: nldo-reg1 {
>> +				regulator-always-on;
>> +				regulator-boot-on;
>> +				regulator-min-microvolt = <750000>;
>> +				regulator-max-microvolt = <750000>;
>> +				regulator-ramp-delay = <12500>;
>> +				regulator-name = "vdd_0v75_pll_s0";
>> +				regulator-state-mem {
>> +					regulator-off-in-suspend;
>> +				};
>> +			};
>> +
>> +			vdd_ddr_pll_s0: nldo-reg2 {
>> +				regulator-always-on;
>> +				regulator-boot-on;
>> +				regulator-min-microvolt = <850000>;
>> +				regulator-max-microvolt = <850000>;
>> +				regulator-name = "vdd_ddr_pll_s0";
>> +				regulator-state-mem {
>> +					regulator-off-in-suspend;
>> +				};
>> +			};
>> +
>> +			slave_nldo3: nldo-reg3 {
>> +				regulator-name = "slave_nldo3";
>> +				regulator-state-mem {
>> +					regulator-off-in-suspend;
>> +				};
>> +			};
>> +
>> +			avdd_1v2_cam_s0: nldo-reg4 {
>> +				regulator-always-on;
>> +				regulator-boot-on;
>> +				regulator-min-microvolt = <1200000>;
>> +				regulator-max-microvolt = <1200000>;
>> +				regulator-ramp-delay = <12500>;
>> +				regulator-name = "avdd_1v2_cam_s0";
>> +				regulator-state-mem {
>> +					regulator-off-in-suspend;
>> +				};
>> +			};
>> +
>> +			avdd_1v2_s0: nldo-reg5 {
>> +				regulator-always-on;
>> +				regulator-boot-on;
>> +				regulator-min-microvolt = <1200000>;
>> +				regulator-max-microvolt = <1200000>;
>> +				regulator-ramp-delay = <12500>;
>> +				regulator-name = "avdd_1v2_s0";
>> +				regulator-state-mem {
>> +					regulator-off-in-suspend;
>> +				};
>> +			};
>> +		};
>> +	};
>> +};
>> +
>> +&tsadc {
>> +	status = "okay";
>> +};
>> +
>> +&u2phy0 {
>> +	status = "okay";
>> +};
>> +
>> +&u2phy2 {
>> +	status = "okay";
>> +};
>> +
>> +&u2phy3 {
>> +	status = "okay";
>> +};
>> +
>> +&u2phy0_otg {
>> +	status = "okay";
>> +};
>> +
>> +&u2phy2_host {
>> +	phy-supply = <&vcc5v0_host>;
>> +	status = "okay";
>> +};
>> +
>> +&u2phy3_host {
>> +	phy-supply = <&vcc5v0_host>;
>> +	status = "okay";
>> +};
>> +
>> +&uart2 {
>> +	pinctrl-0 = <&uart2m0_xfer>;
> 
> Missing pinctrl-names prop.

Indeed, it is better to add pinctrl-names.

> 
>> +	status = "okay";
>> +};
>> +
>> +&usb_host0_ehci {
>> +	status = "okay";
>> +};
>> +
>> +&usb_host0_ohci {
>> +	status = "okay";
>> +};
>> +
>> +&usb_host0_xhci {
>> +	dr_mode = "otg";
> 
> This is already default for usb_host0_xhci.

I will take your advice and remove it.

> 
> Regards,
> Jonas
> 
>> +	usb-role-switch;
>> +	status = "okay";
>> +
>> +	port {
>> +		#address-cells = <1>;
>> +		#size-cells = <0>;
>> +
>> +		dwc3_0_role_switch: endpoint@0 {
>> +			reg = <0>;
>> +			remote-endpoint = <&usbc0_role_sw>;
>> +		};
>> +	};
>> +};
>> +
>> +&usb_host1_ehci {
>> +	status = "okay";
>> +};
>> +
>> +&usb_host1_ohci {
>> +	status = "okay";
>> +};
>> +
>> +&usbdp_phy0 {
>> +	mode-switch;
>> +	orientation-switch;
>> +	sbu1-dc-gpios = <&gpio1 RK_PB6 GPIO_ACTIVE_HIGH>;
>> +	sbu2-dc-gpios = <&gpio1 RK_PB7 GPIO_ACTIVE_HIGH>;
>> +	status = "okay";
>> +
>> +	port {
>> +		#address-cells = <1>;
>> +		#size-cells = <0>;
>> +
>> +		usbdp_phy0_orientation_switch: endpoint@0 {
>> +			reg = <0>;
>> +			remote-endpoint = <&usbc0_orien_sw>;
>> +		};
>> +
>> +		usbdp_phy0_dp_altmode_mux: endpoint@1 {
>> +			reg = <1>;
>> +			remote-endpoint = <&dp_altmode_mux>;
>> +		};
>> +	};
>> +};
> 
> 


