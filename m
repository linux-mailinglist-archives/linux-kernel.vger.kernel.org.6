Return-Path: <linux-kernel+bounces-518358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11CAAA38DDD
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 22:09:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B7E03ACDEA
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 21:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 548BC239588;
	Mon, 17 Feb 2025 21:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=detlev.casanova@collabora.com header.b="algXobVO"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA9D23875A;
	Mon, 17 Feb 2025 21:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739826507; cv=pass; b=Xk5f3r57lMM+vR27jky2lBnxRr5P70eEHdnlqM1Lz/KxD84v585HcHVTF1q2YFVPto/GNhysh3PiaTRvvNYFkMLu8vLFRGQKZPGBoZxvnJDXZfsaWLzP9DKEYH8g7QRdSE3aCpYxU3gLdTTfN198eNpsPjwJ8sV6C1OFfs135yk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739826507; c=relaxed/simple;
	bh=UvoFp2AhuIMJiIgtSTAPdnhZPJDE7uVNmeKLM7X/yUE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=alG/LzFDETgANllSPADx0dC7PXg1pSadXTP95KS4LuRpmr0l96f616s0ARh4C8tvaU6ZwZdO8NRISEENIZSEI8EDWRLuHgHQ9yatnZBUiopXM8f4g9wRsVZ707QdqiUXjitwr24Ar9G1ZWDf4IuYhQQ8tXcaUQ+UvTNWnh8JSwo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=detlev.casanova@collabora.com header.b=algXobVO; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1739826431; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=HhEkljVKt39ADhG7pp+dqbGTT2q7if2wkDiRssx+77m+TCv5yQWlptgQq70M/15KF5QfvgP7VA1LQ/yEWIBJt3PyOUzbhZnKsB9Dba5eYGu4XChfkK64MoRAamby2k0Zq3HFkYMhBRHN8WWC7PWhSEU3i5+YKz6g/wOIrVoHUzs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1739826431; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=pRQFZzYtqTLP27umhcyhFHsYIAfHuroONaDM4I1jd5w=; 
	b=Kebtp9LRVQKzodiwzXLGuDfZ2vzdbO18J6ccG7YaHwwhDFEe6qHnkIgm+MfYElUQItIS7A9nqJrL9Yzt31dUpa1pACZ7hAclDU+cyQQLUXckFStI5AQukCPWRhannJXQdcaRmikwnwyFfVJsoo8iRb26PGu8lM/1c7O9I9rqnzs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=detlev.casanova@collabora.com;
	dmarc=pass header.from=<detlev.casanova@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1739826431;
	s=zohomail; d=collabora.com; i=detlev.casanova@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
	bh=pRQFZzYtqTLP27umhcyhFHsYIAfHuroONaDM4I1jd5w=;
	b=algXobVOj51O8xtX5tt2RqXkyTnRGowyqWAgMIPS4vyEgfT+Z8oPj+1Y1c0BqlmI
	25hZMBTEemqk2Lb84AZ1Ex7Ao64Pl9svnT+NBpjhrMjLK8d65UVAq4jq1i9Bv17u7PV
	33agMumaXmn/Ac9lPiVLLBn1tYhzvEcn4RpFLCTE=
Received: by mx.zohomail.com with SMTPS id 17398264292801003.4427564452692;
	Mon, 17 Feb 2025 13:07:09 -0800 (PST)
From: Detlev Casanova <detlev.casanova@collabora.com>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Chris Morgan <macromorgan@hotmail.com>,
 Kever Yang <kever.yang@rock-chips.com>, Dragan Simic <dsimic@manjaro.org>,
 Tim Lunn <tim@feathertop.org>, FUKAUMI Naoki <naoki@radxa.com>,
 Michael Riesch <michael.riesch@wolfvision.net>,
 Stephen Chen <stephen@radxa.com>, Elon Zhang <zhangzj@rock-chips.com>,
 Alexey Charkov <alchark@gmail.com>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 kernel@collabora.com, linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH v4 2/2] arm64: dts: rockchip: Add Radxa ROCK 4D device tree
Date: Mon, 17 Feb 2025 16:07:06 -0500
Message-ID: <1914418.tdWV9SEqCh@earth>
In-Reply-To: <01b72ad6-67bc-472e-b04d-c9fd42d37d8d@kwiboo.se>
References:
 <20250217164009.130286-1-detlev.casanova@collabora.com>
 <20250217164009.130286-3-detlev.casanova@collabora.com>
 <01b72ad6-67bc-472e-b04d-c9fd42d37d8d@kwiboo.se>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-ZohoMailClient: External

Hi Jonas,

On Monday, 17 February 2025 12:08:47 EST Jonas Karlman wrote:
> Hi Detlev,
> 
> On 2025-02-17 17:34, Detlev Casanova wrote:
> > From: Stephen Chen <stephen@radxa.com>
> > 
> > The Radxa ROCK 4D board is based on the Rockchip rk3576 SoC.
> > 
> > The device tree adds support for basic devices:
> >  - UART
> >  - SD Card
> >  - Ethernet
> >  - USB
> >  - RTC
> > 
> > It has 4 USB ports but only 3 are usable as the top left one is used
> > for maskrom.
> > 
> > It has a USB-C port that is only used for powering the board.
> > 
> > Signed-off-by: Stephen Chen <stephen@radxa.com>
> > Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
> > ---
> > 
> >  arch/arm64/boot/dts/rockchip/Makefile         |   1 +
> >  .../boot/dts/rockchip/rk3576-rock-4d.dts      | 678 ++++++++++++++++++
> >  2 files changed, 679 insertions(+)
> >  create mode 100644 arch/arm64/boot/dts/rockchip/rk3576-rock-4d.dts
> > 
> > diff --git a/arch/arm64/boot/dts/rockchip/Makefile
> > b/arch/arm64/boot/dts/rockchip/Makefile index
> > def1222c1907e..a112aeb37948a 100644
> > --- a/arch/arm64/boot/dts/rockchip/Makefile
> > +++ b/arch/arm64/boot/dts/rockchip/Makefile
> > @@ -132,6 +132,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) +=
> > rk3568-wolfvision-pf5-display-vz.dtbo> 
> >  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-wolfvision-pf5-io-expander.dtbo
> >  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3576-armsom-sige5.dtb
> >  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3576-evb1-v10.dtb
> > 
> > +dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3576-rock-4d.dtb
> > 
> >  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3582-radxa-e52c.dtb
> >  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-armsom-sige7.dtb
> >  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-armsom-w3.dtb
> > 
> > diff --git a/arch/arm64/boot/dts/rockchip/rk3576-rock-4d.dts
> > b/arch/arm64/boot/dts/rockchip/rk3576-rock-4d.dts new file mode 100644
> > index 0000000000000..b499effd50396
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/rockchip/rk3576-rock-4d.dts
> > @@ -0,0 +1,678 @@
> > +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> > +/*
> > + * Copyright (c) 2024 Radxa Computer (Shenzhen) Co., Ltd.
> > + */
> > +
> > +/dts-v1/;
> > +
> > +#include <dt-bindings/gpio/gpio.h>
> > +#include <dt-bindings/leds/common.h>
> > +#include <dt-bindings/pinctrl/rockchip.h>
> > +#include <dt-bindings/pwm/pwm.h>
> > +#include <dt-bindings/soc/rockchip,vop2.h>
> > +#include <dt-bindings/usb/pd.h>
> > +#include "rk3576.dtsi"
> > +
> > +/ {
> > +	model = "Radxa ROCK 4D";
> > +	compatible = "radxa,rock-4d", "rockchip,rk3576";
> > +
> > +	aliases {
> > +		ethernet0 = &gmac0;
> 
> Should mmc alias be added here?
>
> > +	};
> > +
> > +	chosen {
> > +		stdout-path = "serial0:1500000n8";
> > +	};
> > +
> > +	leds: leds {
> > +		compatible = "gpio-leds";
> > +
> > +		power-led {
> > +			color = <LED_COLOR_ID_GREEN>;
> > +			function = LED_FUNCTION_STATUS;
> > +			gpios = <&gpio0 RK_PB4 GPIO_ACTIVE_HIGH>;
> > +			linux,default-trigger = "default-on";
> > +		};
> > +
> > +		user-led {
> > +			color = <LED_COLOR_ID_BLUE>;
> > +			function = LED_FUNCTION_HEARTBEAT;
> > +			gpios = <&gpio0 RK_PC4 GPIO_ACTIVE_LOW>;
> > +			linux,default-trigger = "heartbeat";
> > +		};
> > +	};
> 
> pinctrl should probably be added for the leds above.
> 
> > +
> > +	vcc_12v0_dcin: regulator-vcc-12v0-dcin {
> > +		compatible = "regulator-fixed";
> > +		regulator-always-on;
> > +		regulator-boot-on;
> > +		regulator-min-microvolt = <12000000>;
> > +		regulator-max-microvolt = <12000000>;
> > +		regulator-name = "vcc_12v0_dcin";
> > +	};
> > +
> > +	vcc_1v1_nldo_s3: regulator-vcc-1v1-nldo-s3 {
> > +		compatible = "regulator-fixed";
> > +		regulator-always-on;
> > +		regulator-boot-on;
> > +		regulator-min-microvolt = <1100000>;
> > +		regulator-max-microvolt = <1100000>;
> > +		regulator-name = "vcc_1v1_nldo_s3";
> > +		vin-supply = <&vcc_5v0_sys>;
> > +	};
> > +
> > +	vcc_1v2_ufs_vccq_s0: regulator-vcc-1v2-ufs-vccq-s0 {
> > +		compatible = "regulator-fixed";
> > +		regulator-always-on;
> > +		regulator-boot-on;
> > +		regulator-min-microvolt = <1200000>;
> > +		regulator-max-microvolt = <1200000>;
> > +		regulator-name = "vcc_1v2_ufs_vccq_s0";
> > +		vin-supply = <&vcc_5v0_sys>;
> > +	};
> > +
> > +	vcc_1v8_s0: regulator-vcc-1v8-s0 {
> > +		compatible = "regulator-fixed";
> > +		regulator-always-on;
> > +		regulator-boot-on;
> > +		regulator-min-microvolt = <1800000>;
> > +		regulator-max-microvolt = <1800000>;
> > +		regulator-name = "vcc_1v8_s0";
> > +		vin-supply = <&vcc_1v8_s3>;
> > +	};
> > +
> > +	vcc_1v8_ufs_vccq2_s0: regulator-vcc1v8-ufs-vccq2-s0 {
> > +		compatible = "regulator-fixed";
> > +		regulator-always-on;
> > +		regulator-boot-on;
> > +		regulator-min-microvolt = <1800000>;
> > +		regulator-max-microvolt = <1800000>;
> > +		regulator-name = "vcc_1v8_ufs_vccq2_s0";
> > +		vin-supply = <&vcc_1v8_s3>;
> > +	};
> > +
> > +	vcc_2v0_pldo_s3: regulator-vcc-2v0-pldo-s3 {
> > +		compatible = "regulator-fixed";
> > +		regulator-always-on;
> > +		regulator-boot-on;
> > +		regulator-min-microvolt = <2000000>;
> > +		regulator-max-microvolt = <2000000>;
> > +		regulator-name = "vcc_2v0_pldo_s3";
> > +		vin-supply = <&vcc_5v0_sys>;
> > +	};
> > +
> > +	vcc_3v3_pcie: regulator-vcc-3v3-pcie {
> > +		compatible = "regulator-fixed";
> > +		enable-active-high;
> > +		gpio = <&gpio2 RK_PD3 GPIO_ACTIVE_HIGH>;
> 
> If I am not mistaken gpios is the preferred property name?

Hehe, looking at the rk3588-rock-5b dts, both "gpio" and "gpios" are used, 
I'll use the second one.

> This should probably also have pinctrl props.

Yes, I'll fix all those pinctrl issues.

> > +		regulator-min-microvolt = <3300000>;
> > +		regulator-max-microvolt = <3300000>;
> > +		regulator-name = "vcc_3v3_pcie";
> > +		startup-delay-us = <5000>;
> > +		vin-supply = <&vcc_5v0_sys>;
> > +	};
> > +
> > +	vcc_3v3_rtc_s5: regulator-vcc-3v3-rtc-s5 {
> > +		compatible = "regulator-fixed";
> > +		regulator-always-on;
> > +		regulator-boot-on;
> > +		regulator-min-microvolt = <3300000>;
> > +		regulator-max-microvolt = <3300000>;
> > +		regulator-name = "vcc_3v3_rtc_s5";
> > +		vin-supply = <&vcc_5v0_sys>;
> > +	};
> > +
> > +	vcc_3v3_s0: regulator-vcc-3v3-s0 {
> > +		compatible = "regulator-fixed";
> > +		regulator-always-on;
> > +		regulator-boot-on;
> > +		regulator-min-microvolt = <3300000>;
> > +		regulator-max-microvolt = <3300000>;
> > +		regulator-name = "vcc_3v3_s0";
> > +		vin-supply = <&vcc_3v3_s3>;
> > +	};
> > +
> > +	vcc_3v3_ufs_s0: regulator-vcc-ufs-s0 {
> > +		compatible = "regulator-fixed";
> > +		regulator-always-on;
> > +		regulator-boot-on;
> > +		regulator-min-microvolt = <3300000>;
> > +		regulator-max-microvolt = <3300000>;
> > +		regulator-name = "vcc_3v3_ufs_s0";
> > +		vin-supply = <&vcc_5v0_sys>;
> > +	};
> > +
> > +	vcc_5v0_device: regulator-vcc-5v0-device {
> > +		compatible = "regulator-fixed";
> > +		regulator-always-on;
> > +		regulator-boot-on;
> > +		regulator-min-microvolt = <5000000>;
> > +		regulator-max-microvolt = <5000000>;
> > +		regulator-name = "vcc_5v0_device";
> > +		vin-supply = <&vcc_12v0_dcin>;
> > +	};
> > +
> > +	vcc_5v0_host: regulator-vcc-5v0-host {
> > +		compatible = "regulator-fixed";
> > +		enable-active-high;
> > +		gpio = <&gpio0 RK_PD3 GPIO_ACTIVE_HIGH>;
> 
> Same here.
> 
> > +		pinctrl-names = "default";
> > +		pinctrl-0 = <&usb_host_pwren>;
> > +		regulator-always-on;
> > +		regulator-boot-on;
> > +		regulator-min-microvolt = <5000000>;
> > +		regulator-max-microvolt = <5000000>;
> > +		regulator-name = "vcc5v0_host";
> > +		vin-supply = <&vcc_5v0_device>;
> > +	};
> > +
> > +	vcc_5v0_sys: regulator-vcc-5v0-sys {
> > +		compatible = "regulator-fixed";
> > +		regulator-always-on;
> > +		regulator-boot-on;
> > +		regulator-min-microvolt = <5000000>;
> > +		regulator-max-microvolt = <5000000>;
> > +		regulator-name = "vcc_5v0_sys";
> > +		vin-supply = <&vcc_12v0_dcin>;
> > +	};
> > +};
> > +
> > +&combphy1_psu {
> > +	status = "okay";
> > +};
> > +
> > +&cpu_b0 {
> > +	cpu-supply = <&vdd_cpu_big_s0>;
> > +};
> > +
> > +&cpu_b1 {
> > +	cpu-supply = <&vdd_cpu_big_s0>;
> > +};
> > +
> > +&cpu_b2 {
> > +	cpu-supply = <&vdd_cpu_big_s0>;
> > +};
> > +
> > +&cpu_b3 {
> > +	cpu-supply = <&vdd_cpu_big_s0>;
> > +};
> > +
> > +&cpu_l0 {
> > +	cpu-supply = <&vdd_cpu_lit_s0>;
> > +};
> > +
> > +&cpu_l1 {
> > +	cpu-supply = <&vdd_cpu_lit_s0>;
> > +};
> > +
> > +&cpu_l2 {
> > +	cpu-supply = <&vdd_cpu_lit_s0>;
> > +};
> > +
> > +&cpu_l3 {
> > +	cpu-supply = <&vdd_cpu_lit_s0>;
> > +};
> > +
> > +&gmac0 {
> > +	phy-mode = "rgmii-id";
> > +	clock_in_out = "output";
> > +
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&eth0m0_miim
> > +		     &eth0m0_tx_bus2
> > +		     &eth0m0_rx_bus2
> > +		     &eth0m0_rgmii_clk
> > +		     &eth0m0_rgmii_bus
> > +		     &ethm0_clk0_25m_out>;
> > +
> > +	phy-handle = <&rgmii_phy0>;
> > +	status = "okay";
> > +};
> 
> The extra blank lines is probably not needed in above node?
> Props is also not sorted in this node, phy-handle and phy-mode should
> probably be placed next to each other.
> 
> > +
> > +&gpu {
> > +	mali-supply = <&vdd_gpu_s0>;
> > +	status = "okay";
> > +};
> > +
> > +&i2c1 {
> > +	status = "okay";
> > +
> > +	pmic@23 {
> > +		compatible = "rockchip,rk806";
> > +		reg = <0x23>;
> > +
> > +		gpio-controller;
> > +
> > +		interrupt-parent = <&gpio0>;
> > +		interrupts = <6 IRQ_TYPE_LEVEL_LOW>;
> > +
> > +		pinctrl-names = "default";
> > +		pinctrl-0 = <&pmic_pins
> > +			     &rk806_dvs1_null
> > +			     &rk806_dvs2_null
> > +			     &rk806_dvs3_null>;
> > +
> > +		system-power-controller;
> > +
> > +		vcc1-supply = <&vcc_5v0_sys>;
> > +		vcc2-supply = <&vcc_5v0_sys>;
> > +		vcc3-supply = <&vcc_5v0_sys>;
> > +		vcc4-supply = <&vcc_5v0_sys>;
> > +		vcc5-supply = <&vcc_5v0_sys>;
> > +		vcc6-supply = <&vcc_5v0_sys>;
> > +		vcc7-supply = <&vcc_5v0_sys>;
> > +		vcc8-supply = <&vcc_5v0_sys>;
> > +		vcc9-supply = <&vcc_5v0_sys>;
> > +		vcc10-supply = <&vcc_5v0_sys>;
> > +		vcc11-supply = <&vcc_2v0_pldo_s3>;
> > +		vcc12-supply = <&vcc_5v0_sys>;
> > +		vcc13-supply = <&vcc_1v1_nldo_s3>;
> > +		vcc14-supply = <&vcc_1v1_nldo_s3>;
> > +		vcca-supply = <&vcc_5v0_sys>;
> > +
> > +		#gpio-cells = <2>;
> 
> This should probably be sorted next to gpio-controller.

It's not unusual to put # props at the end. but I can move it up if it is 
preferred.

> > +
> > +		rk806_dvs1_null: dvs1-null-pins {
> > +			pins = "gpio_pwrctrl1";
> > +			function = "pin_fun0";
> > +		};
> > +
> > +		rk806_dvs1_pwrdn: dvs1-pwrdn-pins {
> > +			pins = "gpio_pwrctrl1";
> > +			function = "pin_fun2";
> > +		};
> > +
> > +		rk806_dvs1_rst: dvs1-rst-pins {
> > +			pins = "gpio_pwrctrl1";
> > +			function = "pin_fun3";
> > +		};
> > +
> > +		rk806_dvs1_slp: dvs1-slp-pins {
> > +			pins = "gpio_pwrctrl1";
> > +			function = "pin_fun1";
> > +		};
> > +
> > +		rk806_dvs2_dvs: dvs2-dvs-pins {
> > +			pins = "gpio_pwrctrl2";
> > +			function = "pin_fun4";
> > +		};
> > +
> > +		rk806_dvs2_gpio: dvs2-gpio-pins {
> > +			pins = "gpio_pwrctrl2";
> > +			function = "pin_fun5";
> > +		};
> > +
> > +		rk806_dvs2_null: dvs2-null-pins {
> > +			pins = "gpio_pwrctrl2";
> > +			function = "pin_fun0";
> > +		};
> > +
> > +		rk806_dvs2_pwrdn: dvs2-pwrdn-pins {
> > +			pins = "gpio_pwrctrl2";
> > +			function = "pin_fun2";
> > +		};
> > +
> > +		rk806_dvs2_rst: dvs2-rst-pins {
> > +			pins = "gpio_pwrctrl2";
> > +			function = "pin_fun3";
> > +		};
> > +
> > +		rk806_dvs2_slp: dvs2-slp-pins {
> > +			pins = "gpio_pwrctrl2";
> > +			function = "pin_fun1";
> > +		};
> > +
> > +		rk806_dvs3_dvs: dvs3-dvs-pins {
> > +			pins = "gpio_pwrctrl3";
> > +			function = "pin_fun4";
> > +		};
> > +
> > +		rk806_dvs3_gpio: dvs3-gpio-pins {
> > +			pins = "gpio_pwrctrl3";
> > +			function = "pin_fun5";
> > +		};
> > +
> > +		rk806_dvs3_null: dvs3-null-pins {
> > +			pins = "gpio_pwrctrl3";
> > +			function = "pin_fun0";
> > +		};
> > +
> > +		rk806_dvs3_pwrdn: dvs3-pwrdn-pins {
> > +			pins = "gpio_pwrctrl3";
> > +			function = "pin_fun2";
> > +		};
> > +
> > +		rk806_dvs3_rst: dvs3-rst-pins {
> > +			pins = "gpio_pwrctrl3";
> > +			function = "pin_fun3";
> > +		};
> > +
> > +		rk806_dvs3_slp: dvs3-slp-pins {
> > +			pins = "gpio_pwrctrl3";
> > +			function = "pin_fun1";
> > +		};
> > +
> > +		regulators {
> > +			vdd_cpu_big_s0: dcdc-reg1 {
> > +				regulator-always-on;
> > +				regulator-boot-on;
> > +				regulator-enable-ramp-delay = <400>;
> > +				regulator-min-microvolt = <550000>;
> > +				regulator-max-microvolt = <950000>;
> > +				regulator-name = "vdd_cpu_big_s0";
> > +				regulator-ramp-delay = <12500>;
> > +				regulator-state-mem {
> > +					regulator-off-in-suspend;
> > +				};
> > +			};
> > +
> > +			vdd_npu_s0: dcdc-reg2 {
> > +				regulator-boot-on;
> > +				regulator-enable-ramp-delay = <400>;
> > +				regulator-min-microvolt = <550000>;
> > +				regulator-max-microvolt = <950000>;
> > +				regulator-name = "vdd_npu_s0";
> > +				regulator-ramp-delay = <12500>;
> > +				regulator-state-mem {
> > +					regulator-off-in-suspend;
> > +				};
> > +			};
> > +
> > +			vdd_cpu_lit_s0: dcdc-reg3 {
> > +				regulator-always-on;
> > +				regulator-boot-on;
> > +				regulator-min-microvolt = <550000>;
> > +				regulator-max-microvolt = <950000>;
> > +				regulator-name = "vdd_cpu_lit_s0";
> > +				regulator-ramp-delay = <12500>;
> > +				regulator-state-mem {
> > +					regulator-off-in-suspend;
> > +					regulator-suspend-microvolt = 
<750000>;
> > +				};
> > +			};
> > +
> > +			vcc_3v3_s3: dcdc-reg4 {
> > +				regulator-always-on;
> > +				regulator-boot-on;
> > +				regulator-min-microvolt = <3300000>;
> > +				regulator-max-microvolt = <3300000>;
> > +				regulator-name = "vcc_3v3_s3";
> > +				regulator-state-mem {
> > +					regulator-on-in-suspend;
> > +					regulator-suspend-microvolt = 
<3300000>;
> > +				};
> > +			};
> > +
> > +			vdd_gpu_s0: dcdc-reg5 {
> > +				regulator-boot-on;
> > +				regulator-enable-ramp-delay = <400>;
> > +				regulator-min-microvolt = <550000>;
> > +				regulator-max-microvolt = <900000>;
> > +				regulator-name = "vdd_gpu_s0";
> > +				regulator-ramp-delay = <12500>;
> > +				regulator-state-mem {
> > +					regulator-off-in-suspend;
> > +					regulator-suspend-microvolt = 
<850000>;
> > +				};
> > +			};
> > +
> > +			vddq_ddr_s0: dcdc-reg6 {
> > +				regulator-always-on;
> > +				regulator-boot-on;
> > +				regulator-name = "vddq_ddr_s0";
> > +				regulator-state-mem {
> > +					regulator-off-in-suspend;
> > +				};
> > +			};
> > +
> > +			vdd_logic_s0: dcdc-reg7 {
> > +				regulator-always-on;
> > +				regulator-boot-on;
> > +				regulator-min-microvolt = <550000>;
> > +				regulator-max-microvolt = <800000>;
> > +				regulator-name = "vdd_logic_s0";
> > +				regulator-state-mem {
> > +					regulator-off-in-suspend;
> > +				};
> > +			};
> > +
> > +			vcc_1v8_s3: dcdc-reg8 {
> > +				regulator-always-on;
> > +				regulator-boot-on;
> > +				regulator-min-microvolt = <1800000>;
> > +				regulator-max-microvolt = <1800000>;
> > +				regulator-name = "vcc_1v8_s3";
> > +				regulator-state-mem {
> > +					regulator-on-in-suspend;
> > +					regulator-suspend-microvolt = 
<1800000>;
> > +				};
> > +			};
> > +
> > +			vdd2_ddr_s3: dcdc-reg9 {
> > +				regulator-always-on;
> > +				regulator-boot-on;
> > +				regulator-name = "vdd2_ddr_s3";
> > +				regulator-state-mem {
> > +					regulator-on-in-suspend;
> > +				};
> > +			};
> > +
> > +			vdd_ddr_s0: dcdc-reg10 {
> > +				regulator-always-on;
> > +				regulator-boot-on;
> > +				regulator-min-microvolt = <550000>;
> > +				regulator-max-microvolt = <1200000>;
> > +				regulator-name = "vdd_ddr_s0";
> > +				regulator-state-mem {
> > +					regulator-off-in-suspend;
> > +				};
> > +			};
> > +
> > +			vcca_1v8_s0: pldo-reg1 {
> > +				regulator-always-on;
> > +				regulator-boot-on;
> > +				regulator-min-microvolt = <1800000>;
> > +				regulator-max-microvolt = <1800000>;
> > +				regulator-name = "vcca_1v8_s0";
> > +				regulator-state-mem {
> > +					regulator-off-in-suspend;
> > +				};
> > +			};
> > +
> > +			vcca1v8_pldo2_s0: pldo-reg2 {
> > +				regulator-always-on;
> > +				regulator-boot-on;
> > +				regulator-min-microvolt = <1800000>;
> > +				regulator-max-microvolt = <1800000>;
> > +				regulator-name = "vcca1v8_pldo2_s0";
> > +				regulator-state-mem {
> > +					regulator-off-in-suspend;
> > +				};
> > +			};
> > +
> > +			vdda_1v2_s0: pldo-reg3 {
> > +				regulator-always-on;
> > +				regulator-boot-on;
> > +				regulator-min-microvolt = <1200000>;
> > +				regulator-max-microvolt = <1200000>;
> > +				regulator-name = "vdda_1v2_s0";
> > +				regulator-state-mem {
> > +					regulator-off-in-suspend;
> > +				};
> > +			};
> > +
> > +			vcca_3v3_s0: pldo-reg4 {
> > +				regulator-always-on;
> > +				regulator-boot-on;
> > +				regulator-min-microvolt = <3300000>;
> > +				regulator-max-microvolt = <3300000>;
> > +				regulator-name = "vcca_3v3_s0";
> > +				regulator-state-mem {
> > +					regulator-off-in-suspend;
> > +				};
> > +			};
> > +
> > +			vccio_sd_s0: pldo-reg5 {
> > +				regulator-always-on;
> > +				regulator-boot-on;
> > +				regulator-min-microvolt = <1800000>;
> > +				regulator-max-microvolt = <3300000>;
> > +				regulator-name = "vccio_sd_s0";
> > +				regulator-state-mem {
> > +					regulator-off-in-suspend;
> > +				};
> > +			};
> > +
> > +			vcca1v8_pldo6_s3: pldo-reg6 {
> > +				regulator-always-on;
> > +				regulator-boot-on;
> > +				regulator-min-microvolt = <1800000>;
> > +				regulator-max-microvolt = <1800000>;
> > +				regulator-name = "vcca1v8_pldo6_s3";
> > +				regulator-state-mem {
> > +					regulator-on-in-suspend;
> > +					regulator-suspend-microvolt = 
<1800000>;
> > +				};
> > +			};
> > +
> > +			vdd_0v75_s3: nldo-reg1 {
> > +				regulator-always-on;
> > +				regulator-boot-on;
> > +				regulator-min-microvolt = <750000>;
> > +				regulator-max-microvolt = <750000>;
> > +				regulator-name = "vdd_0v75_s3";
> > +				regulator-state-mem {
> > +					regulator-on-in-suspend;
> > +					regulator-suspend-microvolt = 
<750000>;
> > +				};
> > +			};
> > +
> > +			vdda_ddr_pll_s0: nldo-reg2 {
> > +				regulator-always-on;
> > +				regulator-boot-on;
> > +				regulator-min-microvolt = <850000>;
> > +				regulator-max-microvolt = <850000>;
> > +				regulator-name = "vdda_ddr_pll_s0";
> > +				regulator-state-mem {
> > +					regulator-off-in-suspend;
> > +				};
> > +			};
> > +
> > +			vdda0v75_hdmi_s0: nldo-reg3 {
> > +				regulator-always-on;
> > +				regulator-boot-on;
> > +				regulator-min-microvolt = <837500>;
> > +				regulator-max-microvolt = <837500>;
> > +				regulator-name = "vdda0v75_hdmi_s0";
> > +				regulator-state-mem {
> > +					regulator-off-in-suspend;
> > +				};
> > +			};
> > +
> > +			vdda_0v85_s0: nldo-reg4 {
> > +				regulator-always-on;
> > +				regulator-boot-on;
> > +				regulator-min-microvolt = <850000>;
> > +				regulator-max-microvolt = <850000>;
> > +				regulator-name = "vdda_0v85_s0";
> > +				regulator-state-mem {
> > +					regulator-off-in-suspend;
> > +				};
> > +			};
> > +
> > +			vdda_0v75_s0: nldo-reg5 {
> > +				regulator-always-on;
> > +				regulator-boot-on;
> > +				regulator-min-microvolt = <750000>;
> > +				regulator-max-microvolt = <750000>;
> > +				regulator-name = "vdda_0v75_s0";
> > +				regulator-state-mem {
> > +					regulator-off-in-suspend;
> > +				};
> > +			};
> > +		};
> > +	};
> > +};
> > +
> > +&i2c2 {
> > +	status = "okay";
> > +
> > +	hym8563: rtc@51 {
> > +		compatible = "haoyu,hym8563";
> > +		reg = <0x51>;
> > +		clock-output-names = "hym8563";
> > +		interrupt-parent = <&gpio0>;
> > +		interrupts = <RK_PB0 IRQ_TYPE_LEVEL_LOW>;
> > +		pinctrl-names = "default";
> > +		pinctrl-0 = <&hym8563_int>;
> > +		wakeup-source;
> > +		#clock-cells = <0>;
> 
> This should probably be sorted next to clock-output-names.

Same for # props.

> > +	};
> > +};
> > +
> > +&mdio0 {
> > +	rgmii_phy0: ethernet-phy@1 {
> > +		compatible = "ethernet-phy-ieee802.3-c22";
> > +		reg = <0x1>;
> > +		clocks = <&cru REFCLKO25M_GMAC0_OUT>;
> > +		reset-assert-us = <20000>;
> > +		reset-deassert-us = <100000>;
> > +		reset-gpio = <&gpio2 RK_PB5 GPIO_ACTIVE_LOW>;
> 
> Pinctrl should probably be added here.
> 
> > +	};
> > +};
> > +
> > +&pinctrl {
> > +	hym8563 {
> > +		hym8563_int: hym8563-int {
> > +			rockchip,pins = <0 RK_PA0 RK_FUNC_GPIO 
&pcfg_pull_up>;
> 
> This does not match (A0 vs B0) the pin used in rtc@51.

This probably explains the errors I've seen with the rtc.

> > +		};
> > +	};
> > +
> > +	leds {
> > +		led_rgb_g: led-green-en {
> > +			rockchip,pins = <4 RK_PB2 RK_FUNC_GPIO 
&pcfg_pull_none>;
> > +		};
> > +		led_rgb_r: led-red-en {
> > +			rockchip,pins = <4 RK_PB1 RK_FUNC_GPIO 
&pcfg_pull_none>;
> > +		};
> 
> These are unreferenced and does not match the pin used by gpio leds.
> 
> > +	};
> > +
> > +	usb {
> > +		usb_host_pwren: usb-host-pwren {
> > +			rockchip,pins = <4 RK_PD3 RK_FUNC_GPIO 
&pcfg_pull_none>;
> 
> This does not match the pin used in the regulator.

I'll fix the pinctrl issues, I had to improve my understanding of those a bit 
:)

let me know for those # props.

Regards,
Detlev.



