Return-Path: <linux-kernel+bounces-247788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D29592D48D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 16:52:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEF1A1C2190C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 14:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C229B194088;
	Wed, 10 Jul 2024 14:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="ijfqrO40"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [167.172.40.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10EBB19309E
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 14:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.172.40.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720623161; cv=none; b=cebceyb8qMNG6LDbh4+Pli88OuW+Vsy49aJGDm6/NqfyOrK4Dhib7EVsH7sANdJs95TIWNJhcJ9TOZO1597R8f3btnn5cCNU8QEMP/PBm5WWd376I+2x/PGnWr/b+ZVrZAg809R6whzw3uEOoqVNkdenLBNejZ8WjP1ouoJ0WuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720623161; c=relaxed/simple;
	bh=QCXEave5NU6o2HSHySwi+llu0gALOnXIFYCrr4kwS9s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kAzwjBiNSw6amV0Qd+8P6Tk5FJR5kcJjUmba4NQTQH4Fkwg5dCFF6V/pTOL2dlsQhae/0HqniN41VhYIcOQigxIQzmNHrjFosmF+uiY/Kcp5qoVGfc/+clomWqcVWpTKXDHHzt+nQgzJdYTEoECpfUN5KSbiu2BPo2GUFdyk4eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=ijfqrO40; arc=none smtp.client-ip=167.172.40.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1720623139;
 bh=NXPTGPBY0179P6BWZHx7/WS3Plscrxo5swZEML9bMlE=;
 b=ijfqrO40nuxnI/qbViZ+LHX0tLwo6k/Xp4ZB7fY8G+jJDLf/4CTFZVkM1mW0YaWzM+Glf6Ch4
 pkQsO6kaxUNNX0D1Ew6VMM1XYinMv2fcilMyKcE3i3bzsSnbfa+Cx3RUr3O08oQdLa3zG0P1lE7
 NKM30lsN7b1WELE7kMtsb1KRiaKJC/iG5/dMaUU6PHJOHOGnF+yU5HFqAkcW6PV5wWpEX7pU0tf
 QVXMD8Je6eLFzOtLvhRR1LsgIdp9E+pj6ZLNLwaWtSD9uPD6Ba72asqUbEap5DjR1tnKarNE/hN
 1zYGpasGHy5R8mV9cbUovv89wvvCQNhEeytEnn56IIIA==
Message-ID: <84dc40f4-1948-4eb7-b16e-8a79357c2622@kwiboo.se>
Date: Wed, 10 Jul 2024 16:41:23 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] arm64: dts: rockchip: Add missing pinctrl for PCIe30x4
 node
To: Anand Moon <linux.amoon@gmail.com>, Heiko Stuebner <heiko@sntech.de>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240710142001.7234-1-linux.amoon@gmail.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20240710142001.7234-1-linux.amoon@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 167.172.40.54
X-ForwardEmail-ID: 668e9d98fc7608dd27c22368

Hi Anand,

On 2024-07-10 16:19, Anand Moon wrote:
> Add missing pinctrl settings for PCIe 3.0 x4 clock request and wake
> signals. Rename node from 'pcie3' to 'pcie30x4' to align with schematic
> nomenclature.
> 
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
>  .../boot/dts/rockchip/rk3588-rock-5b.dts      | 20 +++++++++++++------
>  1 file changed, 14 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
> index 2e7512676b7e..a9b55b7996cf 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
> @@ -301,7 +301,7 @@ &pcie30phy {
>  
>  &pcie3x4 {
>  	pinctrl-names = "default";
> -	pinctrl-0 = <&pcie3_rst>;
> +	pinctrl-0 = <&pcie30x4_perstn_m1 &pcie30x4_clkreqn_m1 &pcie30x4_waken_m1>;
>  	reset-gpios = <&gpio4 RK_PB6 GPIO_ACTIVE_HIGH>;
>  	vpcie3v3-supply = <&vcc3v3_pcie30>;
>  	status = "okay";
> @@ -340,14 +340,22 @@ pcie2_2_rst: pcie2-2-rst {
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
> +		pcie30x4_clkreqn_m1: pcie30x4-clkreqn-m1 {
> +			rockchip,pins = <4 RK_PB4 RK_FUNC_GPIO &pcfg_pull_up>;
> +		};
> +
> +		pcie30x4_waken_m1: pcie30x4-waken-m1 {
> +			rockchip,pins = <4 RK_PB5 RK_FUNC_GPIO &pcfg_pull_down>;
> +		};

Should these not be routed to the clkreqn_m1 and waken_m1 function
instead of gpio function?

E.g. something like:

		pcie30x4m1_pins: pcie30x4m1-pins {
			rockchip,pins =
				<4 RK_PB4 4 &pcfg_pull_none>,
				<4 RK_PB6 RK_FUNC_GPIO &pcfg_pull_none>,
				<4 RK_PB5 4 &pcfg_pull_none>;
		};

There are other rk35xx boards where only the perstn pin is configured
and could use a similar fix.

Regards,
Jonas

> +
> +		pcie30x4_perstn_m1: pcie30x4-perstn-m1 {
> +			rockchip,pins = <4 RK_PB6 RK_FUNC_GPIO &pcfg_pull_down>;
> +		};
>  	};
>  
>  	usb {
> 
> base-commit: 34afb82a3c67f869267a26f593b6f8fc6bf35905


