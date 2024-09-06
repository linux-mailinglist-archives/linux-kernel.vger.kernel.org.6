Return-Path: <linux-kernel+bounces-319001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97B6496F65F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 16:11:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 420261F25111
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 14:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62CC91D0143;
	Fri,  6 Sep 2024 14:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=classfun.cn header.i=@classfun.cn header.b="Xk0YC814"
Received: from classfun.cn (unknown [129.204.178.38])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 964BE1D1741;
	Fri,  6 Sep 2024 14:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.204.178.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725631882; cv=none; b=hpY9JEA3GlLL4IIIj9gER+5l13m0IpIVb7KdzG0sLBlnis1diWKRtaRcNMc/5ML6YggBXoc1VAi5/rgnFAPJp1xQZEcnKce5T+KvVVfZzEnTUs3jukVbSF37jI2ApeGXoipwOxGtQi6bmAVIoDTb21qyjyhUjcx65srUplqdLnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725631882; c=relaxed/simple;
	bh=41LSjH9fL1APCWgZDuap4GRdxIJs/YJdpe2tR3ss5+g=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=SeUe8OH3PWypcwN++zHdcIkoQWOkyciLBjd85mQSviFDVXWlxVfr1TbKjhMqk3kcOgvQNyAGyZWJOHaZtFLsVycmuJj+k3WXNMx8IZL/6GRkgGZfEnueH79AHinzB1HbAHDzVq+WxwGusOGv8sfyYfgiKYrjgNjlA3I6gm3PXz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=classfun.cn; spf=pass smtp.mailfrom=classfun.cn; dkim=pass (1024-bit key) header.d=classfun.cn header.i=@classfun.cn header.b=Xk0YC814; arc=none smtp.client-ip=129.204.178.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=classfun.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=classfun.cn
Received: from [192.168.0.160] (unknown [14.155.100.110])
	(Authenticated sender: bigfoot)
	by classfun.cn (Postfix) with ESMTPSA id BE252789F5;
	Fri,  6 Sep 2024 22:11:15 +0800 (CST)
DKIM-Filter: OpenDKIM Filter v2.11.0 classfun.cn BE252789F5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=classfun.cn;
	s=default; t=1725631877;
	bh=k0VLcrFTCAtKxfm0iaob131MuzN5vsg7K8XcHnszFKg=;
	h=Date:Subject:To:References:From:Cc:In-Reply-To:From;
	b=Xk0YC8148UlSEJD35KJNHCvQUpDUCFvmWY6AdrJJlKZZW+Kd3pHAG4dNyArU7FAkB
	 EEyQn/yWr1arab7gSL3iYHHTUnulcBhY3ZJQgkKY9OKdLMGYhd9UYpkDcEGdocWnGs
	 9hYQFu9vNEOVt4xfb4eAgydZPuX7ES5uJGIzDuGI=
Message-ID: <53784a02-087b-4912-94a9-aead49d7abea@classfun.cn>
Date: Fri, 6 Sep 2024 22:12:43 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] arm64: dts: rockchip: add dts for Ariaboard
 Photonicat RK3568
To: Chukun Pan <amadeus@jmu.edu.cn>
References: <20240906045706.1004813-4-bigfoot@classfun.cn>
 <20240906081005.69334-1-amadeus@jmu.edu.cn>
Content-Language: en-US
From: Junhao Xie <bigfoot@classfun.cn>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Jonas Karlman <jonas@kwiboo.se>, Chukun Pan <amadeus@jmu.edu.cn>,
 FUKAUMI Naoki <naoki@radxa.com>, Dragan Simic <dsimic@manjaro.org>,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 Junhao Xie <bigfoot@classfun.cn>
In-Reply-To: <20240906081005.69334-1-amadeus@jmu.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/9/6 16:10, Chukun Pan wrote:
> Hi Junhao,
> 
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/rockchip/rk3568-photonicat.dts
>> @@ -0,0 +1,595 @@
>> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>> +
>> +/dts-v1/;
>> +
>> +#include <dt-bindings/gpio/gpio.h>
>> +#include <dt-bindings/input/input.h>
>> +#include <dt-bindings/leds/common.h>
>> +#include <dt-bindings/pinctrl/rockchip.h>
>> +#include <dt-bindings/soc/rockchip,vop2.h>
>> +#include <dt-bindings/soc/rockchip,boot-mode.h>
> 
> No need for input.h, leds/common.h and boot-mode.h.

I will remove them.

> 
>> +#include "rk3568.dtsi"
>> ...
>> +	vcc3v3_sd: regulator-3v3-vcc-sd {
>> +		pinctrl-0 = <&vcc_sd_h>;
> 
> schematics: sdmmc0_pwren

I will rename vcc_sd_h to sdmmc0_pwren.

> 
>> ...
>> +	vcc3v3_rf: regulator-3v3-vcc-rf {
> 
> schematics: VCC3V4_RF

I will change it to "vcc3v4_rf: regulator-3v4-vcc-rf {"

> VCCIN_5V -> VCC3V4_RF

Is vccin_5v a new regulator or is it actually vcc_sysin?

> 
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = <&vcc3v3_rf_pwren_en>;
> 
> schematics: RF_PWR_EN
> 
>> ...
>> +	vcc5v0_sysin: regulator-5v0-vcc-sysin {
> 
> schematics: VCC_SYSIN
> 
>> ...
>> +	vcc5v0_syson: regulator-5v0-vcc-syson {
> 
> schematics: VCC_SYSON

I will rename them.

> 
>> ...
>> +	vcc5v0_usb30_otg0: regulator-5v0-vcc-usb-host {
>> ...
>> +		vin-supply = <&vcc5v0_syson>;
> 
> VCCIN_5V -> VCC5V0_USB30_OTG0
> 
>> ...
>> +&gmac1 {
>> ...
>> +	tx_delay = <0x0>;
>> +	rx_delay = <0x0>;
> 
> Please remove the tx_delay and rx_delay, it's useless.
> I know there is an error log, but please ignore it first.

OK, I will remove them.

> 
>> ...
>> +&pinctrl {
>> ...
>> +		bt_reg_on_h: bt-enable-h {
>> +		pcie_pwren_h: pcie-enable-h {
>> +		wifi_reg_on_h: wifi-enable-h {
>> +		vcc3v3_rf_pwren_en: vcc5v0-modem-en {
>> +		usb_host_pwren_h: vcc5v0-host-en {
> 
> obviously (

Yes, I forgot to modify them, it looks better like this:
bt_reg_on_h: bt-reg-on-h {
pcie_pwren_h: pcie-pwren-h {
wifi_reg_on_h: wifi-reg-on-h {
sdmmc0_pwren: sdmmc0-pwren {
rf_pwren_en: rf-pwren-en {
usb_host_pwren_h: usb-host-pwren-h {

> 
>> +	wifi_pwrseq: wifi-pwrseq {
>> +		compatible = "mmc-pwrseq-simple";
>> ...
>> +&pinctrl {
>> ...
>> +	sdio-pwrseq {
> 
> I tend to write like this:

I will rename them.

> 
> ```
> &pinctrl {
> 	wifi {
> 		wifi_reg_on_h: wifi-reg-on-h {
> ```
> 
>> +	vcc_sd {
>> +		vcc_sd_h: vcc-sd-h {
> 
> Overwrite original to match `sdmmc0_pwren`
> 
> sdmmc0 {
> 	sdmmc0_pwren: sdmmc0-pwren {
> 
>> +			rockchip,pins = <0 RK_PB6 RK_FUNC_GPIO &pcfg_pull_none>;
>> +		};
>> +	};
>> +
> 
> Extra blank lines.
> 
>> +};
>> ...
>> &sdmmc1 {
>> ...
>> 	max-frequency = <150000000>;
> 
> `max-frequency = <150000000>;` already defined in rk356x.dtsi

Yes, I will remove them.

> 
>> ...
>> +&usb_host0_ohci {
>> ...
>> +&usb_host0_ehci {
> 
> &usb_host0_ehci {
> &usb_host0_ohci {
> 
> Same for usb_host1
> 
>> ...
>> &usb2phy1_host {
>> 	phy-supply = <&vcc3v3_rf>;
>> 	status = "okay";
>> };
> 
> Is usb2phy1_host connected?

It looks like usb_host1_ehci, usb_host1_ohci, usb2phy1_host
are not used by any device.
I removed them and it still works fine.

> 
Thanks for your review, I will fix all problems in next version!

Best regards,
Junhao

