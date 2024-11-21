Return-Path: <linux-kernel+bounces-417494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3CFF9D54B9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 22:31:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84F90282C31
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 21:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58EC81D9324;
	Thu, 21 Nov 2024 21:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="R5qOQcwo"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [207.246.76.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1CFF199FC9
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 21:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.246.76.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732224663; cv=none; b=hRbsezb30rLoz6QR8q85vSpCSx2Omf3MiVGlLDO5SXvlW0a4ZBD1qEjZyeM/6ukPaZxVnoqBIAgbswV6vcNoDZNQ0te12pwIwu6USK5RYPF+qBZxDNuMy2Ene7IshDFNcGflWj+r8NThoFlSe1z9SWBgQJsBdsu0fbfMqvTeZIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732224663; c=relaxed/simple;
	bh=qO7jHExuYcIgIYqrF4r8nZrjDIet3PoxWTcbM/rE454=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IzdAI9+Yuydt1foJESXX+EoJ2hQ2FUASf4cenUcNjkdwZTVzGdtpPaxNYfj4jXJrfspSxF7/9Ni/SRyQTk8Hz4kh8xWWb+5YZfhr/Wgb9lTeJxTdoQoJl15hxigKuLYYd6ZuAVqcosUE3Oq6dtErZB0NzvkcLQI8x445qFRR7xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=R5qOQcwo; arc=none smtp.client-ip=207.246.76.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1732224639;
 bh=BQUk7DU+3nfuaIMMujloLFuySh3vk/1W7HzQ+FogHsw=;
 b=R5qOQcwoaJySMsCk8OgR3U8lacFEmvV2H2Hb96lVDaIKdlCI5Y7QjTLIx1Q2+RShsRj0vh2H6
 O6fQOIxTa1KFqQ1jiF3mza7pTEdm57D/z3WLcbeTURa0Uo+sVdpzRvyuK2DI69EaMsNL0ls4mvh
 y94EOOU7pGK3sF0Bj0ofYyAYCfvFv2iZ/oas2PrF1nFSiE0xEocIWioUl0QTbSeTVGdXA6Qd5bS
 xB03o0C04aU3EA99t4f0/T3JyGzPeg5YCSGbW04j27PfWxxXDCFVtoxTYxC9us86n7BAkpNMT+q
 3ZivDca3kNp0qRx94JK6kcdnO3009+f7YiGYgYm9c+JA==
Message-ID: <6c7ad585-2743-4f6d-919b-ab7c1eddfb01@kwiboo.se>
Date: Thu, 21 Nov 2024 22:30:30 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: dts: rockchip: Add devicetree for the
 ROC-RK3576-PC
To: Heiko Stuebner <heiko@sntech.de>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20241117201855.789945-1-heiko@sntech.de>
 <20241117201855.789945-3-heiko@sntech.de>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20241117201855.789945-3-heiko@sntech.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 207.246.76.47
X-ForwardEmail-ID: 673fa67c7c98f709b83ac8b9

Hi Heiko,

On 2024-11-17 21:18, Heiko Stuebner wrote:
> As the name implies, it is built around the RK3576 SoC with 4x Cortex-A72
> cores, four Cortex-A53 cores and Mali-G52 MC3 GPU.
> 
> Storage options are EMMC, SD-Card, a 2242 M.2 slot and the possibility to
> use UFS 2.0 storage.
> 
> Video Output options are a HDMI port, a DSI connector as well as Display-
> Port via the TypeC connector (all of them not yet supported).
> 
> Networking options are a Low-profile Gigabit Ethernet RJ45 port with
> Motorcomm YT8531 PHY as well as WiFi via an AMPAK AP6256 module.
> 
> USB ports on the board are 1x USB 3.0 port, 1x USB 2.0 port, 1x USB Type-C
> and it comes with 40-pin GPIO header
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  arch/arm64/boot/dts/rockchip/Makefile         |   1 +
>  .../arm64/boot/dts/rockchip/rk3576-roc-pc.dts | 745 ++++++++++++++++++
>  2 files changed, 746 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/rockchip/rk3576-roc-pc.dts
> 
> diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
> index ac7574bfbf94..3562d6e64b2e 100644
> --- a/arch/arm64/boot/dts/rockchip/Makefile
> +++ b/arch/arm64/boot/dts/rockchip/Makefile
> @@ -130,6 +130,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-wolfvision-pf5.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-wolfvision-pf5-display-vz.dtbo
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-wolfvision-pf5-io-expander.dtbo
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3576-armsom-sige5.dtb
> +dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3576-roc-pc.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-armsom-sige7.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-coolpi-cm5-evb.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-coolpi-cm5-genbook.dtb
> diff --git a/arch/arm64/boot/dts/rockchip/rk3576-roc-pc.dts b/arch/arm64/boot/dts/rockchip/rk3576-roc-pc.dts
> new file mode 100644
> index 000000000000..75ee18ef3817
> --- /dev/null
> +++ b/arch/arm64/boot/dts/rockchip/rk3576-roc-pc.dts

[snip]

> +&gmac0 {
> +	/* Use rgmii-rxid mode to disable rx delay inside Soc */
> +	phy-mode = "rgmii-rxid";
> +	clock_in_out = "output";
> +
> +	snps,reset-gpio = <&gpio2 RK_PB5 GPIO_ACTIVE_LOW>;
> +	snps,reset-active-low;
> +	/* Reset time is 20ms, 100ms for rtl8211f */
> +	snps,reset-delays-us = <0 20000 100000>;

The snps,reset- props are deprecated, reset- props should probably be
added to the rgmii_phy0 node.

> +
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&eth0m0_miim
> +		     &eth0m0_tx_bus2
> +		     &eth0m0_rx_bus2
> +		     &eth0m0_rgmii_clk
> +		     &eth0m0_rgmii_bus
> +		     &ethm0_clk0_25m_out>;
> +
> +	tx_delay = <0x21>;
> +	/* rx_delay = <0x3f>; */
> +
> +	phy-handle = <&rgmii_phy0>;
> +	status = "okay";
> +};
> +
> +&mdio0 {
> +	status = "okay";
> +
> +	rgmii_phy0: phy@1 {
> +		compatible = "ethernet-phy-ieee802.3-c22";

This could possible be changed to ethernet-phy-id001c.c916 if moving
reset- props cause Ethernet phy detection issues and phy was not reset
by bootloader.

Regards,
Jonas

> +		reg = <0x1>;
> +		clocks = <&cru REFCLKO25M_GMAC0_OUT>;
> +	};
> +};
> +

[snip]


