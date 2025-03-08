Return-Path: <linux-kernel+bounces-552608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5757DA57BFB
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 17:34:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA8091890B94
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 16:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D28001E5217;
	Sat,  8 Mar 2025 16:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="rIPGoYzu"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4DFD14A8B
	for <linux-kernel@vger.kernel.org>; Sat,  8 Mar 2025 16:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=121.127.44.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741451681; cv=none; b=VbXBePdia1z3YVKiCQs81i7ZmG48VEXTuLW1A1CrMFz2TL0hAPom18ssW/x05Ha+P8zeigEJz9Zj1jasz1EzXEN4Pw3zTis3O5G4p6eDZyXJYjiW8cQaK1nhpwMk8rAke2kWON5a9LV0AG2vRKrvFsfqr1wB4rBhS04cTEZyPqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741451681; c=relaxed/simple;
	bh=QGLh/6JQgeudjVxuHIxfA33KxLX+oZAVVM/slJ0bCEU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PWTsbCJ8ugEcMDoCasDKynJq619MWnH0YWT0Jzf5lpvuJYSNovPjURSu42c9J8qIw/vwD767yGNVLyv4OYjdVxVECmiP4Eiahg+EGPSOn/PqF33Pgq1zDqblHnZ/jGW+9e9NYGKoOtSv6e765gEPdN1kFQNV+BT7aKARuZozYWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=rIPGoYzu; arc=none smtp.client-ip=121.127.44.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1741451677;
 bh=XfxZ2EUMtcYRuh5iiI7Ca6IZaZJZ9N99juCripq5x6I=;
 b=rIPGoYzuIXmmVJU4IuQe2o6/daWE+eDF6a6nIfxnr0+hvJIz51MGuzUzRjsmUmuCVfoxOIJ48
 jUSMaxgMjXKLunUXL4/3S7O9yTcfliUrKH/+/HjPbvvrPeJM3D1d6MYBM0z/e47anteV5+AXjZh
 9HSaRTh3JXyUYcU2iau9e9t3Vix0QsjnjX0DpYIeUOf9DP37+u1R2+2j0grjn5WNd//WdW52KgA
 TZB7LRc6fHoGipR1BQq3CMp9+Bi4BqRpgw6WWgBZ+OIXgr9h9vomartD7h8WOsJvt1oHLsqILZJ
 RAceyuHBrybYoNzyDX/gGPkQdCrFLIayEXp20/XkcIeg==
X-Forward-Email-ID: 67cc719a91daabb65c1b40e8
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 0.4.40
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <29739e60-15f5-4361-a57a-2e6b93fba09c@kwiboo.se>
Date: Sat, 8 Mar 2025 17:34:29 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] arm64: dts: rockchip: Add Xunlong Orange Pi 3B
To: Arturas Moskvinas <arturas.moskvinas@gmail.com>
Cc: Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240626230319.1425316-1-jonas@kwiboo.se>
 <20240626230319.1425316-3-jonas@kwiboo.se>
 <d1c600f1-a874-4bb8-8b9f-22a3414edfcc@gmail.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <d1c600f1-a874-4bb8-8b9f-22a3414edfcc@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Arturas,

On 2025-03-08 15:53, Arturas Moskvinas wrote:
> On 6/27/24 2:03 AM, Jonas Karlman wrote:
> 
>> The Xunlong Orange Pi 3B is a single-board computer based on the
>> Rockchip RK3566 SoC.
> ...> +
>> +&gmac1 {
>> +	phy-handle = <&rgmii_phy1>;
>> +	status = "okay";
>> +};
>> +
>> +&mdio1 {
>> +	rgmii_phy1: ethernet-phy@1 {
>> +		compatible = "ethernet-phy-ieee802.3-c22";
>> +		reg = <1>;
> 
> Jonas, were you able to test V1.1 board's Ethernet?

Yes, I have both a v1.1.1 and v2.1 hw revision of this board and
Ethernet should be working on both hw revisions.

> 
> Whenever I start the board - Ethernet initialization fails with:
> ```
> [   21.140055] rk_gmac-dwmac fe010000.ethernet eth0: __stmmac_open: 
> Cannot attach to PHY (error: -19)
> ```

This is because of a reset issue with Ethernet PHYs in Linux, see [1].

Two workarounds:
1. Let boot firmware reset the PHY before Linux, i.e. use U-Boot
   v2024.10 or newer.
2. Use a ethernet-phy-id compatible with correct phy-id to force Linux
   to attach the PHY.

I suggest you try to wipe U-Boot from SPI flash on your board and update
to use U-Boot v2025.01 and try again.

> 
> But if reset is performed inside gmac - initialization succeeds.

Use of deprecated snps,reset- props is not a proper fix for this issue,
instead Linux could use an improve Ethernet PHY initialization handling
and ensuring the PHY is reset before it tries to read a phy-id from it.

[1] https://lore.kernel.org/r/47d55aca-bee6-810f-379f-9431649fefa6@kwiboo.se/

Regards,
Jonas

> 
> Eg. patch:
> ```
> --- 
> linux-6.12.17.orig/arch/arm64/boot/dts/rockchip/rk3566-orangepi-3b-v1.1.dts
> +++ linux-6.12.17/arch/arm64/boot/dts/rockchip/rk3566-orangepi-3b-v1.1.dts
> @@ -16,14 +16,14 @@
>   &gmac1 {
>   	phy-handle = <&rgmii_phy1>;
>   	status = "okay";
> +	snps,reset-gpio = <&gpio3 RK_PC2 GPIO_ACTIVE_LOW>;
> +	snps,reset-active-low;
> +	snps,reset-delays-us = <0 50000 200000>;
>   };
> 
>   &mdio1 {
>   	rgmii_phy1: ethernet-phy@1 {
>   		compatible = "ethernet-phy-ieee802.3-c22";
>   		reg = <1>;
> -		reset-assert-us = <20000>;
> -		reset-deassert-us = <50000>;
> -		reset-gpios = <&gpio3 RK_PC2 GPIO_ACTIVE_LOW>;
>   	};
>   };
> ```
>> +		reset-assert-us = <20000>;
>> +		reset-deassert-us = <50000>;
>> +		reset-gpios = <&gpio3 RK_PC2 GPIO_ACTIVE_LOW>;
>> +	};
>> +};
> 
> 
> Arturas Moskvinas


