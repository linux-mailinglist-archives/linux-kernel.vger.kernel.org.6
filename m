Return-Path: <linux-kernel+bounces-513339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 064CFA3493B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 17:11:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3D04188EFB7
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 16:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EA7A1FC118;
	Thu, 13 Feb 2025 16:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="hFRbf5mp"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB15155326
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 16:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.215.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739462997; cv=none; b=rqhTgEuTHi3ZLBphWwB3lfakAwS2ZTDXIyRQiXqk+uAVHYoM2QUZhw1iMZ9e/GNgIdHHNazvpwgA8egcp4r/ieSB2ZQHbI2FwNKIC6pusRKIhgC1LYpBKkwvbjDm38cqqI0UYbTejd2bENx/k4m5KdyPeoUR0OA5f3dmEQzDswY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739462997; c=relaxed/simple;
	bh=aZFJkkj4PtEl8L9lHvWWk+I1PNHQuKnT37w57jFX4/0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lndKsEaxbU7W9FTQhaDW+YV7pYRbl0IDJEDqrXYd/aSf8CToCxQgqwHd0mDEB/InyHJKj828QIH5B9u2wo0Bjdeg6PnszlgAu02tz8BTCw2thIwCe6VnE7adTQJsCCM4RItes+jBrZTfpLHG6hNP1z0Nd5NNLfi8XmPRXe03kaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=hFRbf5mp; arc=none smtp.client-ip=149.28.215.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1739462994;
 bh=OSqEFJEPXbKrFf4UCRw4Rj9UNsiFiIqusumOACEFv68=;
 b=hFRbf5mpafQtW6BFE17ed7yRnJx4vHhqlaFKf80aE9kOhz4kV81vFQRCPnwt+eVpQ4ydruotT
 Ia4HIRtsKKiBAmXB9nmnMmqXQL1PM04lTIqPSZSpvw3pAOIdl4iHpzvNgyZ4jtgyuVE0F2t8lld
 WYMzlWVYhOLAQ72Xnv93RlJpnIkLovva4WL8ELMdn1PBVR9nJDUNTQ0ihWAI6toXuMhtEPjnsJi
 kmODbQEcWDZSzJfOZ9vXqnZTSZrWXrSza8Npu1FumWuTXMNya7btNH2/IP2kVTq/YEqlnqE1qY2
 cyvSqGPJ74Q6bcJZj6boMxwYBotnNSwV6IJgIoOTe5Bw==
X-Forward-Email-ID: 67ae1441eeea92be259cebf3
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 0.4.40
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <b5977d21-aa39-4e91-863b-cc7f9dc6938c@kwiboo.se>
Date: Thu, 13 Feb 2025 16:48:10 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] arm64: dts: rockchip: Add Radxa ROCK 4D device
 tree
To: Detlev Casanova <detlev.casanova@collabora.com>
Cc: linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Dragan Simic <dsimic@manjaro.org>, Chris Morgan <macromorgan@hotmail.com>,
 Kever Yang <kever.yang@rock-chips.com>, Tim Lunn <tim@feathertop.org>,
 FUKAUMI Naoki <naoki@radxa.com>,
 Michael Riesch <michael.riesch@wolfvision.net>,
 Weizhao Ouyang <weizhao.ouyang@arm.com>, Elon Zhang
 <zhangzj@rock-chips.com>, Alexey Charkov <alchark@gmail.com>,
 Stephen Chen <stephen@radxa.com>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 kernel@collabora.com
References: <20250213145921.133412-1-detlev.casanova@collabora.com>
 <20250213145921.133412-3-detlev.casanova@collabora.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20250213145921.133412-3-detlev.casanova@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Detlev,

On 2025-02-13 15:57, Detlev Casanova wrote:
> From: Stephen Chen <stephen@radxa.com>
> 
> The Radxa ROCK 4D board is based on the Rockchip rk3576 SoC.
> 
> The device tree adds support for basic devices:
>  - UART
>  - SD Card
>  - Ethernet
>  - USB
>  - RTC
> 
> It has 4 USB ports but only 3 are usable as the top left one is used
> for maskrom.
> 
> It has a USB-C port that is only used for powering the board.
> 
> Signed-off-by: Stephen Chen <stephen@radxa.com>
> Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
> ---
>  arch/arm64/boot/dts/rockchip/Makefile         |   1 +
>  .../boot/dts/rockchip/rk3576-rock-4d.dts      | 651 ++++++++++++++++++
>  2 files changed, 652 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/rockchip/rk3576-rock-4d.dts
> 
> diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
> index def1222c1907e..a112aeb37948a 100644
> --- a/arch/arm64/boot/dts/rockchip/Makefile
> +++ b/arch/arm64/boot/dts/rockchip/Makefile
> @@ -132,6 +132,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-wolfvision-pf5-display-vz.dtbo
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-wolfvision-pf5-io-expander.dtbo
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3576-armsom-sige5.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3576-evb1-v10.dtb
> +dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3576-rock-4d.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3582-radxa-e52c.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-armsom-sige7.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-armsom-w3.dtb
> diff --git a/arch/arm64/boot/dts/rockchip/rk3576-rock-4d.dts b/arch/arm64/boot/dts/rockchip/rk3576-rock-4d.dts
> new file mode 100644
> index 0000000000000..f356742f9d643
> --- /dev/null
> +++ b/arch/arm64/boot/dts/rockchip/rk3576-rock-4d.dts
> @@ -0,0 +1,651 @@

[snip]

> +&gmac0 {
> +	phy-mode = "rgmii-id";
> +	clock_in_out = "output";
> +
> +	snps,reset-gpio = <&gpio2 RK_PB5 GPIO_ACTIVE_LOW>;
> +	snps,reset-active-low;
> +	snps,reset-delays-us = <0 20000 100000>;

The snps,reset- props are deprecated and should be changed to reset-
props in the phy node.

> +
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&eth0m0_miim
> +		     &eth0m0_tx_bus2
> +		     &eth0m0_rx_bus2
> +		     &eth0m0_rgmii_clk
> +		     &eth0m0_rgmii_bus
> +		     &ethm0_clk0_25m_out>;
> +
> +	phy-handle = <&rgmii_phy0>;
> +	status = "okay";
> +};

[snip]

> +&mdio0 {
> +	rgmii_phy0: phy@1 {

Maybe ethernet-phy@1 ?

> +		compatible = "ethernet-phy-ieee802.3-c22";
> +		reg = <0x1>;
> +		clocks = <&cru REFCLKO25M_GMAC0_OUT>;

Please add reset- props here.

Changing to use reset- props may cause issue if a RTL8211F PHY is used
on the board. Use a ethernet-phy-id compatible or mainline U-Boot to
ensure the Ethernet PHY can be discovered during probe.

Regards,
Jonas

> +	};
> +};
> +

[snip]

