Return-Path: <linux-kernel+bounces-252709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 951C7931725
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 16:47:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 081AAB2254D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 14:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20DEC18EA71;
	Mon, 15 Jul 2024 14:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="eKyMUzUX"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C502018F2D0;
	Mon, 15 Jul 2024 14:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721054831; cv=none; b=C//wSxMJ3o9xr3XQqQRkjoo5hlV0kUAkyHAMWQX0Mzaci5tbYHQvlOhA9eT1/XSg7Tr1cez+2dqZvBxFq+OO83vEwGLmaU5E3EW9U16MbWp6GWHneUMshntjN0klFHqF78C3U5HSt7NARBNPqKkIOOa7NvlPop+sJ3eGAoqgycI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721054831; c=relaxed/simple;
	bh=QOz8cUY1U/SdCKsFckYnbKXTCTcKGwZgMrYU/8q/x5Y=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=GBoVC18+AxMz8aQCL7Aiarq+9iK6XFm5vvIh7wGFgq8q4s3If56qa64eSZ7jBDHSzQP5K85wmgIX3cTfu+F/yzandUulIevdsQDrTinDqbV/U7i4tC+CAO5eADYtClKU7batfuXc6q2T3p1K/O/v7jSEsLz8nYNJo2SGnIdl6Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=eKyMUzUX; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1721054824;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ikrtE+WPTjiFIF37ws5+rF+HDl17JuZgKsVcPfieaNk=;
	b=eKyMUzUX02k4Hp1qD0L1O5tAcerW07AwdOX2Dj14eH/R/+RM1W0Zm4osFQuqB4Nde4Y8Ix
	DbnU07H/+G4RH0q4b18qMBQdpBg4NcIz/4uLzotRhGp0MC3Rv+gv0BcxH6L4UTzdHArvfv
	luiL+wi6hPv1YBMx0wMcldBUf1YKz41uk4db97muUSO3cJbPU+hTXsXFFDggE40pY0yB8W
	PQBi2uKtLc5EpN663OiVr/dLkFsTLHkpus42FxBDmgk68NgasU23+4w9qxMC0Eb7pk2Wbl
	CtIbjNR7/9GQ0LytvQNw107Y4zZOxR+tDxh1ghej0wCWRCfwMyeylH8hlQZNRw==
Date: Mon, 15 Jul 2024 16:47:04 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Andy Yan <andyshrk@163.com>
Cc: heiko@sntech.de, krzk+dt@kernel.org, robh@kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH 2/2] arm64: dts: rockchip: Add support for rk3588 GenBook
In-Reply-To: <32f2518d.a66c.190b5fe86a6.Coremail.andyshrk@163.com>
References: <20240714112851.1048184-1-andyshrk@163.com>
 <20240714112851.1048184-2-andyshrk@163.com>
 <983cfe67f4d83ea96ffc37ec2dde00aa@manjaro.org>
 <32f2518d.a66c.190b5fe86a6.Coremail.andyshrk@163.com>
Message-ID: <f16ab2d662a7bd35748cb19b3bb89135@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Andy,

On 2024-07-15 12:44, Andy Yan wrote:
> At 2024-07-14 23:27:54, "Dragan Simic" <dsimic@manjaro.org> wrote:
>> Please see a few comments below.
>> 
>> On 2024-07-14 13:28, Andy Yan wrote:
>>> Cool Pi GenBook works as a mother board connect with CM5 [0].
>> 
>> s/mother board/carrier board/
> 
> This can be changed to carrier board in next version。
> 
>> s/CM5/GenM5/
> 
> In fact, the SOM  is called  CM5 always[0]， even this laptop was
> called cm5 laptop from the
> very beginning of the design。
> They just gave it a new name GenBook when it comes to crowdsupply.
> 
> The dtsi for CM5 is aready landing upstream，I inclulde it in the
> current genbook dts。
> 
> [0]https://forum.cool-pi.com/topic/98/cool-pi-5-compute-module-minipc-carrier-board-spec

Ah, that's quite interesting, it was probably renamed for marketing
purposes.  Thanks for the clarification.

To add to the confusion, none of "GenBook", "CM5" or "GenM5" appear
on the labels found on the actual PCBs. [1]  Instead, there are only
some rather generic terms.

[1] 
https://www.crowdsupply.com/img/6185/60c35852-7a58-4b6f-80fc-af3a0e3d6185/genbook-rk3588-main-board-close-up_jpg_gallery-lg.jpg

>>> Specification:
>>> - Rockchip RK3588
>>> - LPDDR5X 8/32 GB
>>> - eMMC 64 GB
>>> - HDMI Type A out x 1
>>> - USB 3.0 Host x 1
>>> - USB-C 3.0 with DisplayPort AltMode
>>> - PCIE M.2 E Key for RTL8852BE Wireless connection
>>> - PCIE M.2 M Key for NVME connection
>>> - eDP panel with 1920x1080
>>> 
>>> This patch add basic support to bringup eMMC/USB HOST/WiFi
>>> and can also drive a HDMI output with out of tree hdmi patches.
>>> 
>>> [0]
>>> https://www.crowdsupply.com/shenzhen-tianmao-technology-co-ltd/genbook-rk3588
>>> 
>>> Signed-off-by: Andy Yan <andyshrk@163.com>
>>> ---
>>> 
>>>  arch/arm64/boot/dts/rockchip/Makefile         |   1 +
>>>  .../dts/rockchip/rk3588-coolpi-genbook.dts    | 296 
>>> ++++++++++++++++++
>>>  2 files changed, 297 insertions(+)
>>>  create mode 100644
>>> arch/arm64/boot/dts/rockchip/rk3588-coolpi-genbook.dts
>> 
>> It would be better to split this into two files: a dtsi for the GenM5
>> system
>> on module, and a dts for the GenBook carrier board.  That way, the
>> dts(i) files
>> would describe the actual hardware better.
>> 
>>> diff --git a/arch/arm64/boot/dts/rockchip/Makefile
>>> b/arch/arm64/boot/dts/rockchip/Makefile
>>> index 8fa469db400c..0fad54939bbd 100644
>>> --- a/arch/arm64/boot/dts/rockchip/Makefile
>>> +++ b/arch/arm64/boot/dts/rockchip/Makefile
>>> @@ -122,6 +122,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) +=
>>> rk3568-wolfvision-pf5-display-vz.dtbo
>>>  dtb-$(CONFIG_ARCH_ROCKCHIP) += 
>>> rk3568-wolfvision-pf5-io-expander.dtbo
>>>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-armsom-sige7.dtb
>>>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-coolpi-cm5-evb.dtb
>>> +dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-coolpi-genbook.dtb
>>>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-edgeble-neu6a-io.dtb
>>>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-edgeble-neu6a-wifi.dtbo
>>>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-edgeble-neu6b-io.dtb
>>> diff --git a/arch/arm64/boot/dts/rockchip/rk3588-coolpi-genbook.dts
>>> b/arch/arm64/boot/dts/rockchip/rk3588-coolpi-genbook.dts
>>> new file mode 100644
>>> index 000000000000..28357c6f05fb
>>> --- /dev/null
>>> +++ b/arch/arm64/boot/dts/rockchip/rk3588-coolpi-genbook.dts
>>> @@ -0,0 +1,296 @@
>>> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>>> +/*
>>> + * Copyright (c) 2024 Rockchip Electronics Co., Ltd.
>>> + *
>>> + */
>>> +
>>> +/dts-v1/;
>>> +
>>> +#include <dt-bindings/leds/common.h>
>>> +#include "rk3588-coolpi-cm5.dtsi"
>>> +
>>> +/ {
>>> +	model = "RK3588 CoolPi GenBook";
>>> +	compatible = "coolpi,genbook", "coolpi,pi-cm5", "rockchip,rk3588";
>>> +
>>> +	backlight: backlight {
>>> +		compatible = "pwm-backlight";
>>> +		enable-gpios = <&gpio4 RK_PA3 GPIO_ACTIVE_HIGH>;
>>> +		pinctrl-names = "default";
>>> +		pinctrl-0 = <&bl_en>;
>>> +		power-supply = <&vcc12v_dcin>;
>>> +		pwms = <&pwm6 0 25000 0>;
>>> +	};
>>> +
>>> +	leds: leds {
>>> +		compatible = "gpio-leds";
>>> +
>>> +		heartbeat_led: led-0 {
>>> +			color = <LED_COLOR_ID_GREEN>;
>>> +			function = LED_FUNCTION_STATUS;
>>> +			gpios = <&gpio1 RK_PB0 GPIO_ACTIVE_HIGH>;
>>> +			linux,default-trigger = "heartbeat";
>>> +		};
>>> +
>>> +		wlan_led: led-1 {
>>> +			color = <LED_COLOR_ID_GREEN>;
>>> +			function = LED_FUNCTION_WLAN;
>>> +			gpios = <&gpio0 RK_PC5 GPIO_ACTIVE_HIGH>;
>>> +		};
>>> +
>>> +		charging_red: led-2 {
>>> +			function = LED_FUNCTION_CHARGING;
>>> +			color = <LED_COLOR_ID_RED>;
>>> +			gpios = <&gpio3 RK_PD2 GPIO_ACTIVE_HIGH>;
>>> +		};
>>> +	};
>>> +
>>> +	vcc12v_dcin: vcc12v-dcin-regulator {
>>> +		compatible = "regulator-fixed";
>>> +		regulator-name = "vcc12v_dcin";
>>> +		regulator-always-on;
>>> +		regulator-boot-on;
>>> +		regulator-min-microvolt = <12000000>;
>>> +		regulator-max-microvolt = <12000000>;
>>> +	};
>>> +
>>> +	vcc_sys: vcc-sys-regulator {
>>> +		compatible = "regulator-fixed";
>>> +		regulator-name = "vcc_sys";
>>> +		regulator-always-on;
>>> +		regulator-boot-on;
>>> +		regulator-min-microvolt = <7000000>;
>>> +		regulator-max-microvolt = <7000000>;
>>> +		vin-supply = <&vcc12v_dcin>;
>>> +	};
>>> +
>>> +	vcc5v0_sys: vcc5v0-sys-regulator {
>>> +		compatible = "regulator-fixed";
>>> +		regulator-name = "vcc5v0_sys";
>>> +		regulator-always-on;
>>> +		regulator-boot-on;
>>> +		regulator-min-microvolt = <7000000>;
>>> +		regulator-max-microvolt = <7000000>;
>>> +		vin-supply = <&vcc_sys>;
>>> +	};
>>> +
>>> +	vcc3v3_sys: vcc3v3-sys-regulator {
>>> +		compatible = "regulator-fixed";
>>> +		regulator-name = "vcc3v3_sys";
>>> +		regulator-always-on;
>>> +		regulator-boot-on;
>>> +		regulator-min-microvolt = <3300000>;
>>> +		regulator-max-microvolt = <3300000>;
>>> +		vin-supply = <&vcc5v0_sys>;
>>> +	};
>>> +
>>> +	vcc3v3_lcd: vcc3v3-lcd-regulator {
>>> +		compatible = "regulator-fixed";
>>> +		regulator-name = "vcc3v3_lcd";
>>> +		enable-active-high;
>>> +		gpio = <&gpio1 RK_PC4 GPIO_ACTIVE_HIGH>;
>>> +		pinctrl-names = "default";
>>> +		pinctrl-0 = <&lcdpwr_en>;
>>> +		vin-supply = <&vcc3v3_sys>;
>>> +	};
>>> +
>>> +	vcc5v0_usb: vcc5v0-usb-regulator {
>>> +		compatible = "regulator-fixed";
>>> +		regulator-name = "vcc5v0_usb";
>>> +		regulator-boot-on;
>>> +		regulator-always-on;
>>> +		enable-active-high;
>>> +		regulator-min-microvolt = <5000000>;
>>> +		regulator-max-microvolt = <5000000>;
>>> +		gpio = <&gpio1 RK_PD5 GPIO_ACTIVE_HIGH>;
>>> +		pinctrl-names = "default";
>>> +		pinctrl-0 = <&usb_pwren>;
>>> +		vin-supply = <&vcc_sys>;
>>> +	};
>>> +
>>> +	vcc5v0_usb_host0: vcc5v0_usb30_host: vcc5v0-usb-host-regulator {
>>> +		compatible = "regulator-fixed";
>>> +		regulator-name = "vcc5v0_host";
>>> +		regulator-boot-on;
>>> +		regulator-always-on;
>>> +		enable-active-high;
>>> +		regulator-min-microvolt = <5000000>;
>>> +		regulator-max-microvolt = <5000000>;
>>> +		gpio = <&gpio1 RK_PA7 GPIO_ACTIVE_HIGH>;
>>> +		pinctrl-names = "default";
>>> +		pinctrl-0 = <&usb_host_pwren>;
>>> +		vin-supply = <&vcc5v0_usb>;
>>> +	};
>>> +};
>>> +
>>> +&gmac0 {
>>> +	status = "disabled";
>>> +};
>>> +
>>> +/* M.2 E-Key */
>>> +&pcie2x1l0 {
>>> +	reset-gpios = <&gpio4 RK_PA2 GPIO_ACTIVE_HIGH>;
>>> +	vpcie3v3-supply = <&vcc3v3_sys>;
>>> +	pinctrl-names = "default";
>>> +	pinctrl-0 = <&pcie_clkreq &pcie_wake &pcie_rst &wifi_pwron
>>> &bt_pwron>;
>>> +	status = "okay";
>>> +};
>>> +
>>> +&pcie2x1l2 {
>>> +	status = "disabled";
>>> +};
>>> +
>>> +&pcie30phy {
>>> +	status = "okay";
>>> +};
>>> +
>>> +/* M.2 M-Key ssd */
>>> +&pcie3x4 {
>>> +	reset-gpios = <&gpio4 RK_PB6 GPIO_ACTIVE_HIGH>;
>>> +	vpcie3v3-supply = <&vcc3v3_sys>;
>>> +	status = "okay";
>>> +};
>>> +
>>> +&pinctrl {
>>> +	lcd {
>>> +		lcdpwr_en: lcdpwr-en {
>>> +			rockchip,pins = <1 RK_PC4 RK_FUNC_GPIO &pcfg_pull_down>;
>>> +		};
>>> +
>>> +		bl_en: bl-en {
>>> +			rockchip,pins = <4 RK_PA3 RK_FUNC_GPIO &pcfg_pull_none>;
>>> +		};
>>> +	};
>>> +
>>> +	usb {
>>> +		usb_pwren: usb-pwren {
>>> +			rockchip,pins = <1 RK_PD5 RK_FUNC_GPIO &pcfg_pull_up>;
>>> +		};
>>> +
>>> +		usb_otg_pwren: usb-otg-pwren {
>>> +			rockchip,pins = <0 RK_PA0 RK_FUNC_GPIO &pcfg_pull_up>;
>>> +		};
>>> +
>>> +		usb_host_pwren: usb-host-pwren {
>>> +			rockchip,pins = <1 RK_PA7 RK_FUNC_GPIO &pcfg_pull_up>;
>>> +		};
>>> +	};
>>> +
>>> +	wifi {
>>> +		bt_pwron: bt-pwron {
>>> +			rockchip,pins = <3 RK_PA6 RK_FUNC_GPIO &pcfg_pull_up>;
>>> +		};
>>> +
>>> +		pcie_clkreq: pcie-clkreq {
>>> +			rockchip,pins = <4 RK_PA0 RK_FUNC_GPIO &pcfg_pull_up>;
>>> +		};
>>> +
>>> +		pcie_rst: pcie-rst {
>>> +			rockchip,pins = <4 RK_PA2 RK_FUNC_GPIO &pcfg_pull_up>;
>>> +		};
>>> +
>>> +		wifi_pwron: wifi-pwron {
>>> +			rockchip,pins = <3 RK_PB1 RK_FUNC_GPIO &pcfg_pull_up>;
>>> +		};
>>> +
>>> +		pcie_wake: pcie-wake {
>>> +			rockchip,pins = <4 RK_PA1 RK_FUNC_GPIO &pcfg_pull_up>;
>>> +		};
>>> +	};
>>> +};
>>> +
>>> +&pwm6 {
>>> +	pinctrl-0 = <&pwm6m1_pins>;
>>> +	status = "okay";
>>> +};
>>> +
>>> +&sdmmc {
>>> +	status = "disabled";
>>> +};
>>> +
>>> +&sfc {
>>> +	pinctrl-names = "default";
>>> +	pinctrl-0 = <&fspim2_pins>;
>>> +	status = "okay";
>>> +
>>> +	flash@0 {
>>> +		compatible = "jedec,spi-nor";
>>> +		reg = <0x0>;
>>> +		spi-max-frequency = <100000000>;
>>> +		spi-rx-bus-width = <4>;
>>> +		spi-tx-bus-width = <1>;
>>> +	};
>>> +};
>>> +
>>> +&u2phy0 {
>>> +	status = "okay";
>>> +};
>>> +
>>> +&u2phy0_otg {
>>> +	status = "okay";
>>> +};
>>> +
>>> +&usbdp_phy0 {
>>> +	status = "okay";
>>> +};
>>> +
>>> +&u2phy1 {
>>> +	status = "okay";
>>> +};
>>> +
>>> +&u2phy1_otg {
>>> +	status = "okay";
>>> +};
>>> +
>>> +&u2phy2 {
>>> +	status = "okay";
>>> +};
>>> +
>>> +&u2phy3 {
>>> +	status = "okay";
>>> +};
>>> +
>>> +&u2phy2_host {
>>> +	phy-supply = <&vcc5v0_usb_host0>;
>>> +	status = "okay";
>>> +};
>>> +
>>> +&u2phy3_host {
>>> +	phy-supply = <&vcc5v0_usb>;
>>> +	status = "okay";
>>> +};
>>> +
>>> +&usbdp_phy1 {
>>> +	status = "okay";
>>> +};
>>> +
>>> +/* For Keypad */
>>> +&usb_host0_ehci {
>>> +	status = "okay";
>>> +};
>>> +
>>> +&usb_host0_ohci {
>>> +	status = "okay";
>>> +};
>>> +
>>> +/* Type C port */
>>> +&usb_host0_xhci {
>>> +	dr_mode = "peripheral";
>>> +	maximum-speed = "high-speed";
>>> +	status = "okay";
>>> +};
>>> +
>>> +/* connected to a HUB for camera and BT */
>>> +&usb_host1_ehci {
>>> +	status = "okay";
>>> +};
>>> +
>>> +&usb_host1_ohci {
>>> +	status = "okay";
>>> +};
>>> +
>>> +/* USB A out */
>>> +&usb_host1_xhci {
>>> +	dr_mode = "host";
>>> +	status = "okay";
>>> +};
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip

