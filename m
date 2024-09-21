Return-Path: <linux-kernel+bounces-334848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A44E97DD5A
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 15:27:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AAAD1C20D65
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 13:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 547FC16F27E;
	Sat, 21 Sep 2024 13:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=classfun.cn header.i=@classfun.cn header.b="qCNPPIGk"
Received: from classfun.cn (unknown [129.204.178.38])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E298F9F8;
	Sat, 21 Sep 2024 13:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.204.178.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726925262; cv=none; b=J6WxjGgvwRbsmCpF2melM8N9VzDoH+B0F3cPhG9lyaNw8se+S0J4b6124MMxwGnxO2zBw2NbRYfG3mGZCbIx0Tq0qb7Ja664B2X6SvoMxJZ1CExGUGWZBKjbZ8TuZAXgB2P/fuIrrI+BaBrPIbgGeBAhvznnbS/KnWrkY2p3R5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726925262; c=relaxed/simple;
	bh=Xp7yxHie0MlN4F0JUfr2BteFjyQZyFZRlWQuDPLuDk8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bf9B06TZ7NcS+Lz/IK9j1v+HT8KC/hBfmVZ6hTNjoNHAADTKxv3zqzleFXFL0sjLMDlrMQfxSEmFTFSlFhgsC64RipP8yKkfFwN/IOJDdWItlw5eHTitUb1twhwSHvXi6akpxhQcC4r4DjbGN1cJsiL8DF3t6YwpDbgGzxIGnSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=classfun.cn; spf=pass smtp.mailfrom=classfun.cn; dkim=pass (1024-bit key) header.d=classfun.cn header.i=@classfun.cn header.b=qCNPPIGk; arc=none smtp.client-ip=129.204.178.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=classfun.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=classfun.cn
Received: from [192.168.0.160] (unknown [120.40.111.43])
	(Authenticated sender: bigfoot)
	by classfun.cn (Postfix) with ESMTPSA id 331577890F;
	Sat, 21 Sep 2024 21:27:35 +0800 (CST)
DKIM-Filter: OpenDKIM Filter v2.11.0 classfun.cn 331577890F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=classfun.cn;
	s=default; t=1726925256;
	bh=gXttLbForN4sVPU1L8p0lWk2b2Cu1E5xBRiFWAjrSCw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qCNPPIGkqjsqQ8WpcTW6usy/avVL9dLJdtKu5geOUfRC7n9rpqXcB0apjOc/po0R7
	 FLzzEHJVOEflnHJTh4qektJP45K9fYv9N++FSZxiyyrirxToLaIzwQeArg6BrEc/jV
	 il1Ad1aO/lc0S2Y7vyZIckzhJfTP+dl5STCCU2mk=
Message-ID: <ea7da1f8-5a0e-45ea-a1bb-977a19f8b8b7@classfun.cn>
Date: Sat, 21 Sep 2024 21:27:35 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] arm64: dts: rockchip: add dts for Ariaboard
 Photonicat RK3568
To: Jonas Karlman <jonas@kwiboo.se>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Chukun Pan <amadeus@jmu.edu.cn>, FUKAUMI Naoki <naoki@radxa.com>,
 Dragan Simic <dsimic@manjaro.org>, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, Junhao Xie <bigfoot@classfun.cn>
References: <20240914145549.879936-1-bigfoot@classfun.cn>
 <20240914145549.879936-4-bigfoot@classfun.cn>
 <8c86229a-8cec-4d65-8194-ee8cdc6931dd@kwiboo.se>
Content-Language: en-US
From: Junhao Xie <bigfoot@classfun.cn>
In-Reply-To: <8c86229a-8cec-4d65-8194-ee8cdc6931dd@kwiboo.se>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/9/19 22:52, Jonas Karlman wrote:
> Hi Junhao,
>>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-orangepi-5-plus.dtb
>> +dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-photonicat.dtb
> 
> This should probably be added where the rest of rk3568 dtb is located,
> not with the rk3588 ones.

Thanks for your reminder, I made a mistake in the order when renaming dts, I will fix it

>>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-quartzpro64.dtb
>>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-rock-5-itx.dtb
>>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-rock-5b.dtb
[...]
>> +
>> +&gmac0 {
>> +	status = "disabled";
>> +	/* Motorcomm YT8521SC LAN port (require SGMII) */
> 
> nit: Please be consistent where comments is added, for recgulators above
> the comments is above the node, suggest you move the comment above the
> "&gmac0 {" line, and same for similar comments.

I will edit it. This looks better:

/* Motorcomm YT8521SC LAN port (require SGMII) */
&gmac0 {
	status = "disabled";
};

>> +};
>> +
>> +&gmac1 {
>> +	assigned-clocks = <&cru SCLK_GMAC1_RX_TX>, <&cru SCLK_GMAC1>;
>> +	assigned-clock-parents = <&cru SCLK_GMAC1_RGMII_SPEED>;
>> +	assigned-clock-rates = <0>, <125000000>;
>> +	clock_in_out = "output";
>> +	phy-handle = <&rgmii_phy1>;
>> +	phy-mode = "rgmii-id";
>> +	phy-supply = <&vcc_3v3>;
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&gmac1m1_miim
>> +		     &gmac1m1_tx_bus2
>> +		     &gmac1m1_rx_bus2
>> +		     &gmac1m1_rgmii_clk
>> +		     &gmac1m1_rgmii_bus>;
>> +	snps,reset-gpio = <&gpio4 RK_PC0 GPIO_ACTIVE_LOW>;
>> +	snps,reset-active-low;
>> +	snps,reset-delays-us = <0 20000 100000>;
> 
> The snps,reset props is deprecated use resets props in phy node instad.

I edited it and it works fine, is the following correct to write?

/* Motorcomm YT8521SC WAN port */
&gmac1 {
	assigned-clocks = <&cru SCLK_GMAC1_RX_TX>, <&cru SCLK_GMAC1>;
	assigned-clock-parents = <&cru SCLK_GMAC1_RGMII_SPEED>;
	assigned-clock-rates = <0>, <125000000>;
	clock_in_out = "output";
	phy-handle = <&rgmii_phy1>;
	phy-mode = "rgmii-id";
	phy-supply = <&vcc_3v3>;
	pinctrl-names = "default";
	pinctrl-0 = <&gmac1m1_miim
		     &gmac1m1_tx_bus2
		     &gmac1m1_rx_bus2
		     &gmac1m1_rgmii_clk
		     &gmac1m1_rgmii_bus>;
	tx_delay = <0>;
	rx_delay = <0>;
	status = "okay";
};

&mdio1 {
	rgmii_phy1: ethernet-phy@0 {
		compatible = "ethernet-phy-ieee802.3-c22";
		reg = <0x0>;
		pinctrl-names = "default";
		pinctrl-0 = <&eth1_phy_rst>;
		reset-assert-us = <20000>;
		reset-deassert-us = <100000>;
		reset-gpios = <&gpio4 RK_PC0 GPIO_ACTIVE_LOW>;
		rx-internal-delay-ps = <1500>;
		tx-internal-delay-ps = <1500>;
	};
};

&pinctrl {
	[...]
	ethernet {
		eth1_phy_rst: eth1_phy_rst {
			rockchip,pins = <4 RK_PC0 RK_FUNC_GPIO &pcfg_pull_none>;
		};
	};
	[...]
};

> 
>> +	status = "okay";
>> +	/* Motorcomm YT8521SC WAN port */
>> +};
[...]
>> +&sdhci {
>> +	bus-width = <8>;
>> +	max-frequency = <200000000>;
> 
> Can be dropped, already in base dtsi.

max-frequency is not in sdhci node of rk356x.dtsi and rk3568.dtsi.
I simply removed the max-frequency and it worked fine.
Can it really be removed?

>> +	mmc-hs200-1_8v;
>> +	non-removable;
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&emmc_bus8 &emmc_clk &emmc_cmd>;
>> +	vmmc-supply = <&vcc_3v3>;
>> +	vqmmc-supply = <&vcc_1v8>;
>> +	status = "okay";
>> +	/* eMMC */
>> +};

Thanks for your review, I will fix all problems in next version!

Best regards,
Junhao


