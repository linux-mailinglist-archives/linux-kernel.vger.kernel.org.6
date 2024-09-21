Return-Path: <linux-kernel+bounces-334876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D5C997DDC4
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 18:03:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CC541C20D7F
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 16:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC551174EE4;
	Sat, 21 Sep 2024 16:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="mqkFMHEv"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12DDF155CAC
	for <linux-kernel@vger.kernel.org>; Sat, 21 Sep 2024 16:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.215.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726934618; cv=none; b=T0sGMdJ2aN9El5ynTm/Gx8eacmM/7n0jGfoLXVTwPMJxdBarP+bInBG6KMbQKhjdvxFR9jJ6N0KShJoELdQjZP/tGFpKCWLiMC+JFqgnXixm0vZY2OuOhTNOA0i4MqNsOYuWcIMZxLle96r3PyrLSha8DkVov/K7Qq8PT3XiLlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726934618; c=relaxed/simple;
	bh=qUXTGgvJMyDqyDBKBg/8KxkY4g1jrvTNP7KLvgOX8Gg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hk+AZlefVnRJFZJeAOtild7fsOlcZdh2XAff3ikGXUJ6dW1KyC3Lw3fyyEdroUla00IYMAxVa7xHeMU8Bi9ep3qkV+wLkLMDi5OEkodFBay2r6lf7XeFpstFeh8vjM1lfzOXrMaMH0yIF+k/AG9vUgELPbcp/JzfH+R1S6K0rbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=mqkFMHEv; arc=none smtp.client-ip=149.28.215.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1726934608;
 bh=U15UlxtVirdcxoZ2GLNfrhYoIw4f5P0chaeu+zHCYu0=;
 b=mqkFMHEvzd93WPyInivjp9pz1QLJYTOJJlnMWqgUPIZZqZG0YFciaSmnrhjEtlWeN46xOaPXl
 k7da1L7m1Vfqf2Az7rDPoGDbnOQKxPOB3hrOXfQJ7nrXgf6PDo1lfmKXantCOvmD7jGSQiJuZbW
 XjHTgCFfay/HfXh8kMg/I7utQJ6p3Ox4VVALwtrXoROH7ONhE+JPnAmkFQtGmNvJYIW/K0mvbd3
 PtZ/ftJVyGeeCkEkxgzsbsjRW0kOqtsvp2qHRni+Kt/dj+4yIkJcJDEae+eHvYwXt6VF3PyXT+Z
 TyrMb78oxQHT+nMz17wRz9Ue9JXDeZHiDjkMmVWdspjA==
Message-ID: <7d8fa397-7070-42ae-a8df-eb8a532cb0ad@kwiboo.se>
Date: Sat, 21 Sep 2024 18:03:19 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] arm64: dts: rockchip: add dts for Ariaboard
 Photonicat RK3568
To: Junhao Xie <bigfoot@classfun.cn>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Chukun Pan <amadeus@jmu.edu.cn>, FUKAUMI Naoki <naoki@radxa.com>,
 Dragan Simic <dsimic@manjaro.org>,
 "linux-rockchip@lists.infradead.org" <linux-rockchip@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20240914145549.879936-1-bigfoot@classfun.cn>
 <20240914145549.879936-4-bigfoot@classfun.cn>
 <8c86229a-8cec-4d65-8194-ee8cdc6931dd@kwiboo.se>
 <ea7da1f8-5a0e-45ea-a1bb-977a19f8b8b7@classfun.cn>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <ea7da1f8-5a0e-45ea-a1bb-977a19f8b8b7@classfun.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 66eeee4e8fdd19df3796bdb0

On 2024-09-21 15:27, Junhao Xie wrote:
> On 2024/9/19 22:52, Jonas Karlman wrote:
>> Hi Junhao,
>>>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-orangepi-5-plus.dtb
>>> +dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-photonicat.dtb
>>
>> This should probably be added where the rest of rk3568 dtb is located,
>> not with the rk3588 ones.
> 
> Thanks for your reminder, I made a mistake in the order when renaming dts, I will fix it
> 
>>>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-quartzpro64.dtb
>>>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-rock-5-itx.dtb
>>>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-rock-5b.dtb
> [...]
>>> +
>>> +&gmac0 {
>>> +	status = "disabled";
>>> +	/* Motorcomm YT8521SC LAN port (require SGMII) */
>>
>> nit: Please be consistent where comments is added, for recgulators above
>> the comments is above the node, suggest you move the comment above the
>> "&gmac0 {" line, and same for similar comments.
> 
> I will edit it. This looks better:
> 
> /* Motorcomm YT8521SC LAN port (require SGMII) */
> &gmac0 {
> 	status = "disabled";
> };
> 
>>> +};
>>> +
>>> +&gmac1 {
>>> +	assigned-clocks = <&cru SCLK_GMAC1_RX_TX>, <&cru SCLK_GMAC1>;
>>> +	assigned-clock-parents = <&cru SCLK_GMAC1_RGMII_SPEED>;
>>> +	assigned-clock-rates = <0>, <125000000>;
>>> +	clock_in_out = "output";
>>> +	phy-handle = <&rgmii_phy1>;
>>> +	phy-mode = "rgmii-id";
>>> +	phy-supply = <&vcc_3v3>;
>>> +	pinctrl-names = "default";
>>> +	pinctrl-0 = <&gmac1m1_miim
>>> +		     &gmac1m1_tx_bus2
>>> +		     &gmac1m1_rx_bus2
>>> +		     &gmac1m1_rgmii_clk
>>> +		     &gmac1m1_rgmii_bus>;
>>> +	snps,reset-gpio = <&gpio4 RK_PC0 GPIO_ACTIVE_LOW>;
>>> +	snps,reset-active-low;
>>> +	snps,reset-delays-us = <0 20000 100000>;
>>
>> The snps,reset props is deprecated use resets props in phy node instad.
> 
> I edited it and it works fine, is the following correct to write?

Looks like below props in phy node should match the deprecated
snps,reset props.

> 
> /* Motorcomm YT8521SC WAN port */
> &gmac1 {
> 	assigned-clocks = <&cru SCLK_GMAC1_RX_TX>, <&cru SCLK_GMAC1>;
> 	assigned-clock-parents = <&cru SCLK_GMAC1_RGMII_SPEED>;
> 	assigned-clock-rates = <0>, <125000000>;
> 	clock_in_out = "output";
> 	phy-handle = <&rgmii_phy1>;
> 	phy-mode = "rgmii-id";
> 	phy-supply = <&vcc_3v3>;
> 	pinctrl-names = "default";
> 	pinctrl-0 = <&gmac1m1_miim
> 		     &gmac1m1_tx_bus2
> 		     &gmac1m1_rx_bus2
> 		     &gmac1m1_rgmii_clk
> 		     &gmac1m1_rgmii_bus>;
> 	tx_delay = <0>;
> 	rx_delay = <0>;
> 	status = "okay";
> };
> 
> &mdio1 {
> 	rgmii_phy1: ethernet-phy@0 {
> 		compatible = "ethernet-phy-ieee802.3-c22";
> 		reg = <0x0>;
> 		pinctrl-names = "default";
> 		pinctrl-0 = <&eth1_phy_rst>;
> 		reset-assert-us = <20000>;
> 		reset-deassert-us = <100000>;
> 		reset-gpios = <&gpio4 RK_PC0 GPIO_ACTIVE_LOW>;
> 		rx-internal-delay-ps = <1500>;
> 		tx-internal-delay-ps = <1500>;
> 	};
> };
> 
> &pinctrl {
> 	[...]
> 	ethernet {
> 		eth1_phy_rst: eth1_phy_rst {
> 			rockchip,pins = <4 RK_PC0 RK_FUNC_GPIO &pcfg_pull_none>;
> 		};
> 	};
> 	[...]
> };
> 
>>
>>> +	status = "okay";
>>> +	/* Motorcomm YT8521SC WAN port */
>>> +};
> [...]
>>> +&sdhci {
>>> +	bus-width = <8>;
>>> +	max-frequency = <200000000>;
>>
>> Can be dropped, already in base dtsi.
> 
> max-frequency is not in sdhci node of rk356x.dtsi and rk3568.dtsi.
> I simply removed the max-frequency and it worked fine.
> Can it really be removed?

Ahh, sorry, I looked in rk3588 sdhci node, please ignore my comment
regarding max-frequency prop :-)

Regards,
Jonas

> 
>>> +	mmc-hs200-1_8v;
>>> +	non-removable;
>>> +	pinctrl-names = "default";
>>> +	pinctrl-0 = <&emmc_bus8 &emmc_clk &emmc_cmd>;
>>> +	vmmc-supply = <&vcc_3v3>;
>>> +	vqmmc-supply = <&vcc_1v8>;
>>> +	status = "okay";
>>> +	/* eMMC */
>>> +};
> 
> Thanks for your review, I will fix all problems in next version!
> 
> Best regards,
> Junhao
> 


