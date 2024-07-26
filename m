Return-Path: <linux-kernel+bounces-263709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC93893D98C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 22:07:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 093CC1C22F4A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 20:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A21D05FEE6;
	Fri, 26 Jul 2024 20:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="aPmx/nvj"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B2891F5E6
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 20:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.215.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722024468; cv=none; b=g5Bpr1k9FWo65P5+20/k79T9ACuJxG6TLerY4Jjq4B6ZoNtwpFnRaxRUb/7HjTl/zFfBxrBmG+Gx7b4NwlX489sfAUrNo6bOUtHmkwpgFZt/32aeXUiZgOwD6fVF+SQbd4lhSzuX3fepmvuyOZK86+uStoFMOxvmE0c2KD5mXPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722024468; c=relaxed/simple;
	bh=58gUSjR2oZ3e9/+TRUa+FGH0LiI6njflqc3/YAzgkFE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c9y4RSt9CiCBthM2bKBepxnTGJRqOFKbrVaPqgrRljuJeY8Evxfo0SIjSe5wCjs7FBorobeUUZ8QGxRNPZGNfbsdO2gpK60y0uuzmgJ5z1vczRGOP8enGRB5D2Yt46QCQov3iCp2EPa/3zZU/YFSrYtex6H971ea+7rDmjXQBKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=aPmx/nvj; arc=none smtp.client-ip=149.28.215.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1722024451;
 bh=fAviikwkH6hmnA7E9iefdvMIdw7782gxRltc2GxmQDc=;
 b=aPmx/nvjUc6Ds/VQ6rvjbXG8MVn/pmbmutUzsblMA2BsogyDOKfY4HM71rcxE8sjRCZKOST71
 suxcrxW9acf8khMH5VHXKSSALRgmB1OcJjvDQRVw/plLXTS65MruhFx3fN61lDZOcUtmixLgE9l
 LKo/A+5bzdwXRBLAfVhBLkfd3+tJh6HaZg3DOl4dan1XGrCqdzFJlgBmqEAW0ERRcuY8I1G76B7
 gAcUqpWNoH7Fb0+Eq6aRm6TUsEB8sh54eOBbAxkMxc4Yp6vfUzzBJrc5Gy81MHTQI0eSklA3bnd
 Q3IAaySCiEnZUQ7fskBOQXR4d8w3OkOFAU1Vz1bdL0cQ==
Message-ID: <880603a5-35c5-4968-8cd0-81ebd2958bce@kwiboo.se>
Date: Fri, 26 Jul 2024 22:07:26 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] arm64: dts: rockchip: Add missing pinctrl for
 PCIe30x4 node
To: Anand Moon <linux.amoon@gmail.com>, Heiko Stuebner <heiko@sntech.de>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240726110050.3664-1-linux.amoon@gmail.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20240726110050.3664-1-linux.amoon@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 66a40201df62d509e165a98b

Hi Anand,

Sorry for no reply to your v3.

On 2024-07-26 13:00, Anand Moon wrote:
> Add missing pinctrl settings for PCIe 3.0 x4 clock request and wake
> signals. Each component of PCIe communication have the following control
> signals: PERST, WAKE, CLKREQ, and REFCLK. These signals work to generate
> high-speed signals and communicate with other PCIe devices.
> Used by root complex to endpoint depending on the power state.
> 
> PERST is referred to as a fundamental reset. PERST should be held low
> until all the power rails in the system and the reference clock are stable.
> A transition from low to high in this signal usually indicates the
> beginning of link initialization.
> 
> WAKE signal is an active-low signal that is used to return the PCIe
> interface to an active state when in a low-power state.
> 
> CLKREQ signal is also an active-low signal and is used to request the
> reference clock.
> 
> Rename node from 'pcie3' to 'pcie30x4' to align with schematic
> nomenclature.
> 
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
> v4: rebase on master, used RK_FUNC_GPIO GPIO function instead of PIN
> number.

Why this change? Only reset should use gpio function, if I am not
mistaken. Also how come you change the internal pull-up/down on these
pins?, and why do they differ for each pcie node in this series?

Please see [1] for some discussion related to these pins.

"""
The PERST is for sure should work as GPIO, and the same as WAKE;

for CLKREQ, only those board want to support L1SS need to work as 
function IO,
"""

As stated earlier only the reset pin need to be muxed to GPIO function,
and that should also matches the only pin controlled with gpio in the
driver, if I am not mistaken.

[1] https://lore.kernel.org/u-boot/6de0ee14-3d85-4fda-af9d-9be7e0057dc8@rock-chips.com/

Regards,
Jonas

> V3: use pinctrl local to board
> V2: Update the commit messge to describe the changs.
>     use pinctl group as its pre define in pinctrl dtsi
> ---
>  .../arm64/boot/dts/rockchip/rk3588-rock-5b.dts | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
> index 966bbc582d89..1c7080cca11f 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
> @@ -338,7 +338,7 @@ &pcie30phy {
>  
>  &pcie3x4 {
>  	pinctrl-names = "default";
> -	pinctrl-0 = <&pcie3_rst>;
> +	pinctrl-0 = <&pcie30x4_pins>;
>  	reset-gpios = <&gpio4 RK_PB6 GPIO_ACTIVE_HIGH>;
>  	vpcie3v3-supply = <&vcc3v3_pcie30>;
>  	status = "okay";
> @@ -377,14 +377,20 @@ pcie2_2_rst: pcie2-2-rst {
>  		};
>  	};
>  
> -	pcie3 {
> -		pcie3_rst: pcie3-rst {
> -			rockchip,pins = <4 RK_PB6 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -
> +	pcie30x4 {
>  		pcie3_vcc3v3_en: pcie3-vcc3v3-en {
>  			rockchip,pins = <1 RK_PA4 RK_FUNC_GPIO &pcfg_pull_none>;
>  		};
> +
> +		pcie30x4_pins: pcie30x4-pins {
> +			rockchip,pins =
> +				/* PCIE30X4_CLKREQn_M1_L */
> +				<4 RK_PB4 RK_FUNC_GPIO &pcfg_pull_up>,
> +				/* PCIE30X4_PERSTn_M1_L */
> +				<4 RK_PB6 RK_FUNC_GPIO &pcfg_pull_down>,
> +				/* PCIE30X4_WAKEn_M1_L */
> +				<4 RK_PB5 RK_FUNC_GPIO &pcfg_pull_down>;
> +		};
>  	};
>  
>  	usb {
> 
> base-commit: 1722389b0d863056d78287a120a1d6cadb8d4f7b


