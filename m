Return-Path: <linux-kernel+bounces-255970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA7D1934731
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 06:37:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF05F1C2131B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 04:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C30D3F9FB;
	Thu, 18 Jul 2024 04:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="Yl0uxddX"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50375186A;
	Thu, 18 Jul 2024 04:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721277460; cv=none; b=mdP3nLGj4cQMCnVnisqbJSLnJsMNhmxxxmTbag9Cz3Vkwq/QfMGhy5akIzsrRYOfN84EAkVRmAR/k/JQQ69XN7G0J9+ReJ3iv8dukDBQDXzPqvC4ZFoAQpLUIjUfUgSVf2imL9IRpcEeBXQM3wCO02lOjg1mrBctRogJ0S0Y5GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721277460; c=relaxed/simple;
	bh=fruRKD5FIRpJGD9crZRAs+6zZdNa9Z92odjeD63tNoQ=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=TvcZvOgPmF0kcTWtebPTe6Xzstn7IKfFnfpg2zzGEGFYs7PX3HdcS5aus0VTjgkWDwGv5tinTSaesMWFK5lnpOuoneHoChPwHI3z8Lgj/Ri75JhKYxVFP5VNkeDJY99QiI3ln79cMseE5JVS/aeEiz9VNtMhwBLcjcUmEW4DcYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=Yl0uxddX; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1721277455;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nrCxOp3IGCnVPdUrZxg8jNlvDGY+1G8rh4drIgGqRa8=;
	b=Yl0uxddX3D9zcsJGPIuI807jFI+MlGmLiTz/r+T9OMG8AMx9gMN0Js2Zjh4xVpVI5ecNEt
	6OTT063ysiQef1FWEtbkJ1KK3kCQvW09l+f2bICoqxDZ+MQJJUlIHIyFDAOsCsmWERbw2s
	SVXquD9EhwfdfHZqQIe94gYP7RRMAu3LYo3e1HQnJNIYVRjGFvrpCIYJ7ddnhL1BLk0Uwp
	JjughxC8bT+CCgo5H4z4h7WEkU49mHa1OOGqovjP/vAUCPjcDapSCBAMXng2dCWNp6Wj67
	CPdvlJQGKHvs96xmmCNzJ4ginOya3Uv6MFUbOG0Otxm6UXwWTuZGgGv5b9sixQ==
Date: Thu, 18 Jul 2024 06:37:35 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Christopher Obbard <chris.obbard@collabora.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, Kever Yang
 <kever.yang@rock-chips.com>, Collabora Kernel Mailing List
 <kernel@collabora.com>
Subject: Re: [PATCH v2 3/3] arm64: dts: rockchip: add Firefly JD4 baseboard
 with Core-PX30-JD4 SoM
In-Reply-To: <20240717-rockchip-px30-firefly-v2-3-06541a5a5946@collabora.com>
References: <20240717-rockchip-px30-firefly-v2-0-06541a5a5946@collabora.com>
 <20240717-rockchip-px30-firefly-v2-3-06541a5a5946@collabora.com>
Message-ID: <6a19985040fb65d5c73178d4d3695a46@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Christopher,

On 2024-07-17 18:47, Christopher Obbard wrote:
> The Firefly MB-PX30-JD4 is a baseboard for the Core-PX30-JD4 SoM.
> 
> Signed-off-by: Christopher Obbard <chris.obbard@collabora.com>
> ---
>  arch/arm64/boot/dts/rockchip/Makefile             |   1 +
>  arch/arm64/boot/dts/rockchip/px30-firefly-jd4.dts | 178 
> ++++++++++++++++++++++
>  2 files changed, 179 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/Makefile
> b/arch/arm64/boot/dts/rockchip/Makefile
> index fda1b980eb4bc..24e1e5b606876 100644
> --- a/arch/arm64/boot/dts/rockchip/Makefile
> +++ b/arch/arm64/boot/dts/rockchip/Makefile
> @@ -3,6 +3,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += px30-evb.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += px30-engicam-px30-core-ctouch2.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += px30-engicam-px30-core-ctouch2-of10.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += px30-engicam-px30-core-edimm2.2.dtb
> +dtb-$(CONFIG_ARCH_ROCKCHIP) += px30-firefly-jd4.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += px30-ringneck-haikou.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3308-evb.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3308-roc-cc.dtb
> diff --git a/arch/arm64/boot/dts/rockchip/px30-firefly-jd4.dts
> b/arch/arm64/boot/dts/rockchip/px30-firefly-jd4.dts
> new file mode 100644
> index 0000000000000..bb79a7eb9f028
> --- /dev/null
> +++ b/arch/arm64/boot/dts/rockchip/px30-firefly-jd4.dts
> @@ -0,0 +1,178 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (c) 2019 Fuzhou Rockchip Electronics Co., Ltd
> + */
> +
> +/dts-v1/;
> +#include <dt-bindings/input/input.h>
> +#include <dt-bindings/leds/common.h>
> +#include "px30-firefly-jd4-core.dtsi"
> +
> +/ {
> +	model = "Firefly Core-PX30-JD4 with MB-JD4-PX30 baseboard";

Technically, it's s/with/on/

> +	compatible = "firefly,px30-mb-jd4", "firefly,px30-core-jd4", 
> "rockchip,px30";
> +
> +	aliases {
> +		ethernet0 = &gmac;
> +		mmc0 = &sdmmc;
> +		mmc1 = &sdio;
> +		mmc2 = &emmc;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial2:115200n8";
> +	};
> +
> +	dc_12v: dc-12v-regulator {
> +		compatible = "regulator-fixed";
> +		regulator-name = "dc_12v";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <12000000>;
> +		regulator-max-microvolt = <12000000>;
> +	};
> +
> +	adc-keys {
> +		compatible = "adc-keys";
> +		io-channels = <&saradc 2>;
> +		io-channel-names = "buttons";
> +		keyup-threshold-microvolt = <1500000>;
> +		poll-interval = <100>;
> +
> +		button-recovery {
> +			label = "Recovery";
> +			linux,code = <KEY_VENDOR>;
> +			press-threshold-microvolt = <18000>;
> +		};
> +	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&blue_led>, <&green_led>;
> +
> +		blue-led {
> +			color = <LED_COLOR_ID_BLUE>;
> +			default-state = "on";
> +			function = LED_FUNCTION_HEARTBEAT;
> +			gpios = <&gpio1 RK_PB5 GPIO_ACTIVE_HIGH>;
> +			label = "px30-mb-jd4:blue:work";
> +			linux,default-trigger = "heartbeat";
> +		};
> +
> +		green-led {
> +			color = <LED_COLOR_ID_GREEN>;
> +			default-state = "on";
> +			function = LED_FUNCTION_POWER;
> +			gpios = <&gpio1 RK_PB4 GPIO_ACTIVE_HIGH>;
> +			label = "px30-mb-jd4:blue:diy";
> +			linux,default-trigger = "default-on";
> +		};
> +	};
> +
> +	sdio_pwrseq: sdio-pwrseq {
> +		compatible = "mmc-pwrseq-simple";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&wifi_enable_h>;
> +
> +		/*
> +		 * On the module itself this is one of these (depending
> +		 * on the actual card populated):
> +		 * - SDIO_RESET_L_WL_REG_ON
> +		 * - PDN (power down when low)
> +		 */
> +		reset-gpios = <&gpio0 RK_PA2 GPIO_ACTIVE_LOW>; /* GPIO3_A4 */
> +	};
> +
> +	vcc5v0_baseboard: vcc5v0-baseboard-regulator {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc5v0_baseboard";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		vin-supply = <&dc_12v>;
> +	};
> +};
> +
> +&gmac {
> +	clock_in_out = "output";
> +	phy-supply = <&vcc_rmii>;
> +	snps,reset-gpio = <&gpio2 13 GPIO_ACTIVE_LOW>;
> +	snps,reset-active-low;
> +	snps,reset-delays-us = <0 50000 50000>;
> +	status = "okay";
> +};
> +
> +&pinctrl {
> +	leds {
> +		blue_led: blue-led {
> +			rockchip,pins = <1 RK_PB5 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +
> +		green_led: green-led {
> +			rockchip,pins = <1 RK_PB4 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +	};
> +
> +	sdio-pwrseq {
> +		wifi_enable_h: wifi-enable-h {
> +			rockchip,pins =
> +				<0 RK_PA2 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +	};
> +};
> +
> +&sdmmc {
> +	bus-width = <4>;
> +	cap-mmc-highspeed;
> +	cap-sd-highspeed;
> +	card-detect-delay = <800>;
> +	sd-uhs-sdr12;
> +	sd-uhs-sdr25;
> +	sd-uhs-sdr50;
> +	sd-uhs-sdr104;
> +	vmmc-supply = <&vcc_sd>;
> +	vqmmc-supply = <&vccio_sd>;
> +	status = "okay";
> +};
> +
> +&sdio {
> +	bus-width = <4>;
> +	cap-sd-highspeed;
> +	keep-power-in-suspend;
> +	non-removable;
> +	mmc-pwrseq = <&sdio_pwrseq>;
> +	sd-uhs-sdr104;
> +	status = "okay";
> +};
> +
> +&u2phy {
> +	status = "okay";
> +
> +	u2phy_host: host-port {
> +		status = "okay";
> +	};
> +
> +	u2phy_otg: otg-port {
> +		status = "okay";
> +	};
> +};
> +
> +&uart2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&uart2m1_xfer>;
> +	status = "okay";
> +};
> +
> +&usb20_otg {
> +	status = "okay";
> +};
> +
> +&usb_host0_ehci {
> +	status = "okay";
> +};
> +
> +&usb_host0_ohci {
> +	status = "okay";
> +};

