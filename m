Return-Path: <linux-kernel+bounces-300992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71F7B95EB53
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 10:05:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F63A282387
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 08:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5812C13D61A;
	Mon, 26 Aug 2024 08:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=classfun.cn header.i=@classfun.cn header.b="iGxqgMrn"
Received: from classfun.cn (unknown [129.204.178.38])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB5047407A;
	Mon, 26 Aug 2024 08:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.204.178.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724659316; cv=none; b=rKI2oVFSGpt9ZogB6eAbtgwTKtQfMQLM3aK8PMa0NFjL2PwPhyh8e50gmP3WuNOF42ASHuX9uselvPvpC8f1xmobBK+VeFY1WMlqpV/sILCRjxd/sBy5wMveXALbsmSAaujbcwC0IBxY82bmR5dUZcpwvL0+Y4mhfliFWeQUwcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724659316; c=relaxed/simple;
	bh=6h1G/HE25i8L3yL4WxgPw8whKETtTIgGES73nyn1vYE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=LRqm1HsV15Car303CjX/vMbXpIm4ePXUb6koUteggdkqFAf//BZebzwGwoCQwd981zvUp995OH/0oOcm8rELJ3YHTXHCf9+ja1FRtD9gDgy5yDm41uzJQ1NmlMgctRTkJOImGRYciUc2dI/Jl17eA+zFk76wibVwbABpU8GWnhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=classfun.cn; spf=pass smtp.mailfrom=classfun.cn; dkim=pass (1024-bit key) header.d=classfun.cn header.i=@classfun.cn header.b=iGxqgMrn; arc=none smtp.client-ip=129.204.178.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=classfun.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=classfun.cn
Received: from [192.168.0.160] (unknown [14.153.79.170])
	(Authenticated sender: bigfoot)
	by classfun.cn (Postfix) with ESMTPSA id 2B0C4789E4;
	Mon, 26 Aug 2024 16:01:50 +0800 (CST)
DKIM-Filter: OpenDKIM Filter v2.11.0 classfun.cn 2B0C4789E4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=classfun.cn;
	s=default; t=1724659310;
	bh=vEQbp8JhlcjDWWseCz9sjPI3YL2zLcYOUsfYIw62S8M=;
	h=Date:Subject:To:References:From:Cc:In-Reply-To:From;
	b=iGxqgMrnw4ByjCHyOS5757fQe+SlPABwwEgFFPOSpcpikJgfMIa+KIqKgMvUS+27J
	 4PgZ+m4qFm57s7lc5X0rw2NppRLvo1agiI/7T074Zv94Ikl2dhbk3VVU1N7SpYxjWP
	 eYqIpjrRnx+DRc/zvzYqf+24BZ2dApnMmqSU2fZI=
Message-ID: <6edb8443-6bb4-4174-8fe0-906208757cef@classfun.cn>
Date: Mon, 26 Aug 2024 16:03:01 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] arm64: dts: rockchip: add dts for LCKFB Taishan Pi
 RK3566
To: Chukun Pan <amadeus@jmu.edu.cn>
References: <20240826044530.726458-4-bigfoot@classfun.cn>
 <20240826070109.55659-1-amadeus@jmu.edu.cn>
Content-Language: en-US
From: Junhao Xie <bigfoot@classfun.cn>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Jonas Karlman <jonas@kwiboo.se>, Chukun Pan <amadeus@jmu.edu.cn>,
 FUKAUMI Naoki <naoki@radxa.com>, Dragan Simic <dsimic@manjaro.org>,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 Junhao Xie <bigfoot@classfun.cn>
In-Reply-To: <20240826070109.55659-1-amadeus@jmu.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/8/26 15:01, Chukun Pan wrote:
> Hi Junhao,
> 
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/rockchip/rk3566-lckfb-tspi.dts
>> ...
>> +	aliases {
>> +		mmc0 = &sdmmc0;
>> +		mmc1 = &sdhci;
>> +		mmc2 = &sdmmc1;
>> +		wifi = &brcmf;
>> +		bluetooth = &bluetooth;
>> +	};
> 
> WiFi and Bluetooth do not need aliases.
> 
>> ...
>> +	vcc5v0_host: vcc5v0-host-regulator {
>> +		compatible = "regulator-fixed";
>> +		regulator-name = "vcc5v0_host";
>> +		regulator-boot-on;
>> +		regulator-always-on;
> 
> This regulator does not need always-on and boot-on.
> 

I will remove them.

> 
>> ...
>> +	vccio_flash: vccio-flash {
>> +		compatible = "regulator-fixed";
>> +		regulator-name = "vccio_flash";
>> +		regulator-min-microvolt = <1800000>;
>> +		regulator-max-microvolt = <1800000>;
>> +		vin-supply = <&vcc_1v8>;
>> +	};
> 
> Generally speaking, vccio_flash is not a DCDC regulator,
> it is directly connected to vcc_1v8. Maybe you need to
> confirm the schematics.
> 

Yes, vccio_flash and vccio_wl are not DCDC regulator, they are connected to vcc_1v8 and vcc_3v3 through voltage selection resistors.

> 
>> +
>> +	vccio_wl: vccio-wl {
>> +		compatible = "regulator-fixed";
>> +		regulator-name = "vccio_wl";
>> +		regulator-min-microvolt = <3300000>;
>> +		regulator-max-microvolt = <3300000>;
>> +		vin-supply = <&vcc_3v3>;
>> +	};
> 
> Same as above, usually like this:
> VCC_1V8 or VCCA1V8_PMU - 0R - VCCIO_WL
> `sd-uhs-sdr104` requires 1.8v io voltage,
> you need to confirm the schematics.
> 

It is actually connected to vcc_1v8, I will fix it.

> 
>> ...
>> +&pinctrl {
>> ...
>> pmic {
>> +	pmic {
>> +		pmic_int: pmic_int {
> 
> Only the pmic_int is needed.
> Also `pmic_int: pmic-int {`
> 
>> ...
>> +&sdhci {
>> +	bus-width = <8>;
>> +	max-frequency = <200000000>;
>> +	non-removable;
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&emmc_bus8 &emmc_clk &emmc_cmd &emmc_datastrobe &emmc_rstnout>;
>> +	status = "okay";
>> +	vmmc-supply = <&vccio_flash>;
>> +	vqmmc-supply = <&vccio_flash>;
>> +};
> 
> The vmmc requires 3.3V supply (on rk356x).
> 

Yes, the vmmc of eMMC is actually connected to vcc_3v3, I will fix it.

> 
>> ...
>> +&sdmmc1 {
>> ...
>> +	sd-uhs-sdr104;
>> +	vmmc-supply = <&vccio_wl>;
>> +	vqmmc-supply = <&vccio_wl>;
> 
> Same as above.
> 
>> ...
> +&uart1 {
>> ...
> +		vbat-supply = <&vcc3v3_sys>;
> +		vddio-supply = <&vccio_wl>;
> 
> Here corresponds to sdmmc1.
> 
> Thanks,
> Chukun
> 

Thanks for your review, I will fix all problems and post patch v2!

