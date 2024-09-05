Return-Path: <linux-kernel+bounces-316705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 772C196D2F0
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 11:16:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D9C21F24040
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 09:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B02119750B;
	Thu,  5 Sep 2024 09:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=classfun.cn header.i=@classfun.cn header.b="QFXaWlQP"
Received: from classfun.cn (unknown [129.204.178.38])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12BB6194AE8;
	Thu,  5 Sep 2024 09:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.204.178.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725527788; cv=none; b=jPkUtxbOjBmn7iTkZk3pbXCZ5BkKvvekQYZalz6ZXBr6qEFKJIQp6LyTYU2ghqa7pmKBZ4YdxWckoqqM2AlTU34p7IM6qDLtNSwTqSW51TGjofGOXRBZPo2gIsg6nOTSDBrmjZpOsgYBCm/B/a6Cu3EdC5FSAByqO1hQdyE+Sf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725527788; c=relaxed/simple;
	bh=bW18jNOC6wDN7uQsEQY3l359bMLCFUVAAihKgW5biJk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=miwE7zLYt99JITGs1w9azZaUmk8xDnGYihVqjA8CV1l2pRhrQzN0/KiIrmw3TbyzQZvr5o+3kSE8aMd11EXup+6skPjaG5hvHXzBXo6NwK5DSXh7MFuoxdPBi5h+dGGy04AGNTHKUVuzuDMCl1Hkp+p49k32sWZMKbETOAkR6qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=classfun.cn; spf=pass smtp.mailfrom=classfun.cn; dkim=pass (1024-bit key) header.d=classfun.cn header.i=@classfun.cn header.b=QFXaWlQP; arc=none smtp.client-ip=129.204.178.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=classfun.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=classfun.cn
Received: from [192.168.0.160] (unknown [14.155.100.110])
	(Authenticated sender: bigfoot)
	by classfun.cn (Postfix) with ESMTPSA id 09625789EC;
	Thu,  5 Sep 2024 17:16:21 +0800 (CST)
DKIM-Filter: OpenDKIM Filter v2.11.0 classfun.cn 09625789EC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=classfun.cn;
	s=default; t=1725527783;
	bh=ke2XF0xsg9GelOC16/EoyH6BBkHyFP+ObV61vAzVb0M=;
	h=Date:Subject:To:References:From:Cc:In-Reply-To:From;
	b=QFXaWlQPLabeJN60N9sDnMULE/Coewl/FV37MFmAZ/QeQPP6cbklBCVj+lPZMFqJT
	 HDOLH8TjYU2pczhX0UFluoJWaV/AmBd13GssEfIZG0X8Ne9IhgxQ2ArTP9weinqyLr
	 ZgaOr4tD9SPcJ8NYenbd0cVWmXP8AgyzR+iKX1tc=
Message-ID: <010a9c5e-205b-40b9-9655-9e168b2def97@classfun.cn>
Date: Thu, 5 Sep 2024 17:17:38 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] arm64: dts: rockchip: add dts for Ariaboard
 Photonicat RK3568
To: Chukun Pan <amadeus@jmu.edu.cn>
References: <20240904111456.87089-4-bigfoot@classfun.cn>
 <20240905034009.28124-1-amadeus@jmu.edu.cn>
Content-Language: en-US
From: Junhao Xie <bigfoot@classfun.cn>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Jonas Karlman <jonas@kwiboo.se>, Chukun Pan <amadeus@jmu.edu.cn>,
 FUKAUMI Naoki <naoki@radxa.com>, Dragan Simic <dsimic@manjaro.org>,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 Junhao Xie <bigfoot@classfun.cn>
In-Reply-To: <20240905034009.28124-1-amadeus@jmu.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/9/5 11:40, Chukun Pan wrote:
> Hi Junhao,
> 
>> ...
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/rockchip/rk3568-ariaboard-photonicat.dts
> 
> This should be 'rk3568-photonicat.dts',
> e.g. "Radxa ROCK 3A" -> rk3568-rock-3a.dts
> 
>> ...
>> +	model = "Ariaboard Photonicat RK3568";
>> +	compatible = "ariaboard,photonicat", "rockchip,rk3568";
> 
> The official model name does not include 'RK3568'.

I will rename it.

> 
>> ...
>> +	firmware {
>> +		optee: optee {
>> +			compatible = "linaro,optee-tz";
>> +			method = "smc";
>> +		};
>> +	};
>> +
>> ...
>> +	reserved-memory {
>> +		#address-cells = <2>;
>> +		#size-cells = <2>;
>> +		ranges;
>> +
>> +		ramoops: ramoops@110000 {
>> +			compatible = "ramoops";
>> +			reg = <0 0x110000 0 0xf0000>;
>> +			console-size = <0x80000>;
>> +			ftrace-size = <0x00000>;
>> +			pmsg-size = <0x50000>;
>> +			record-size = <0x20000>;
>> +		};
>> +	};
> 
> Maybe these can be moved to rk356x.dtsi?

Yes, I will split them.

> 
>> ...
>> +	vcca1v8: regulator-1v8-vcca {
> 
> schematics: VCCA_1V8
> 
>> ...
> +	vcc3v3_pcie: regulator-3v3-vcc-pcie {
> +		compatible = "regulator-fixed";
> +		enable-active-high;
> +		gpios = <&gpio0 RK_PA6 GPIO_ACTIVE_HIGH>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pcie_enable_h>;
> 
> schematics: pcie_pwren_h
> vcc_syson -> vcc3v3_pi6c
> vcc_syson -> vcc3v3_pcie
> 
>> +		regulator-always-on;
>> +		regulator-boot-on;
> 
> No need.
> 
>> ...
>> +	vcc5v0_sys: regulator-5v0-vcc-sys {
> 
> There is no vcc5v0_sys, but vcc_syson.
> 
> vcc_syson (5v) -> vcc3v3_sys
> vcc_sysin (5v) - (mcu) -> vcc_syson
> vccin_5v -> vcc_sysin
> 
>> ...
>> +	vcc5v0_usb_host: regulator-5v0-vcc-usb-host {
> 
> schematics: VCC5V0_USB30_OTG0 and usb_host_pwren_h
> It's a little weird, but that's what they're calling it.
> Also: VCCIN_5V -> VCC5V0_USB30_OTG0
> 
>> ...
>> +	vcc5v0_usb_modem: regulator-5v0-vcc-usb-modem {
> 
> Are you sure this regulator is 5v?
> 

It should actually be 3.3V, I will fix it and rename to vcc3v3_usb_modem

> 
>> ...
>> +	vdda0v9: regulator-0v9-vdda {
> 
> schematics: VDDA_0V9
> 
>> +	wifi_pwrseq: wifi-pwrseq {
>> +		compatible = "mmc-pwrseq-simple";
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = <&wifi_enable_h>;
> 
> schematics: wifi_reg_on_h
> Also you need to enable the clk:
> 
> 		clocks = <&pmucru CLK_RTC_32K>;
> 		clock-names = "ext_clock";
> 		pinctrl-names = "default";
> 		pinctrl-0 = <&wifi_reg_on_h &clk32k_out1>;
> 
>> +		post-power-on-delay-ms = <200>;
>> +		reset-gpios = <&gpio2 RK_PB1 GPIO_ACTIVE_LOW>;
>> +	};
> 
>> ...
>> +&pcie30phy {
>> +	phy-supply = <&vcc3v3_pcie>;
> 
> phy-supply = <&vcc3v3_pi6c>;

I will change it to vcc3v3_pi6c.
But there seems to be a warning here, maybe phy-supply is missing in rockchip,pcie3-phy.yaml?

/tmp/build/arch/arm64/boot/dts/rockchip/rk3568-photonicat.dtb: phy@fe8c0000: 'phy-supply' does not match any of the regexes: 'pinctrl-[0-9]+'
        from schema $id: http://devicetree.org/schemas/phy/rockchip,pcie3-phy.yaml#

> 
>> ...
>> +&pcie3x2 {
>> +	max-link-speed = <1>;
>> +	num-lanes = <1>;
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&pcie30x2m1_pins>;
> 
> These are actually pcie30x1m0_pins.

pcie30x1m0_pins seems to conflict with sdmmc0, I changed it to pcie30x1m1_pins

> 
>> ...
>> +&pmugrf {
>> +	reboot-mode {
> 
> Maybe these can be moved to rk356x.dtsi?
> 
>> ...
>> +&sdhci {
> 
> Missing mmc-hs200-1_8v;
> 
[...]> 
> ath10k does not need compatible.

I will remove them

> 
>> ...
>> +&uart1 {
>> ...
>> +		clocks = <&pmucru CLK_RTC_32K>;
>> +		enable-gpios = <&gpio2 RK_PB7 GPIO_ACTIVE_HIGH>;
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = <&bt_enable_h>;
> 
> schematics: bt_reg_on_h
> Missing clock-names = "lpo";

When I add clocks-name, check_dtbs gives me a warning

/tmp/build/arch/arm64/boot/dts/rockchip/rk3568-photonicat.dtb: bluetooth: 'clock-names' does not match any of the regexes: 'pinctrl-[0-9]+'
        from schema $id: http://devicetree.org/schemas/net/bluetooth/qualcomm-bluetooth.yaml#

Maybe clock-name is missing in qualcomm-bluetooth.yaml?

> 

Thanks for your review, I will fix all problems in PATCH v2.

Best regards,
Junhao

