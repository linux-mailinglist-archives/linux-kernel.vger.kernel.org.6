Return-Path: <linux-kernel+bounces-568957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BD84A69CB4
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 00:26:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBD24169DB0
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 23:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC45022371F;
	Wed, 19 Mar 2025 23:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="Htlfh8nd"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 517242236F7
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 23:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=121.127.44.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742426785; cv=none; b=PZLA4GnS3OunyH+iIdntmxaDcPwAZNmw35QV9xmMBXrIsq9LUhYoZvxiriquypIKjvkz0sjMLeFXRlYqoIE6wbO5ab96kexRXBg7KpqZUsUKuukA+LXMTJU9CIQkLCoCs8yNiAoTo68Hf4p4s+cxT4KewqN1ctaUkQgtU0/x7dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742426785; c=relaxed/simple;
	bh=33jElZxx++BSLK9kCZCdybHECKDTzS8bmhZ4fwRbBnU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=olKE6hF6GebfxT17JUfWGRtshdf1Nm6S/HltwQhrIzEqMJEVFjm0OhCodJiFbTlzV7OIq/Z66gvD3o4sR3V1vwUVEAocT+/+ZEzmhAM9UBsK7PV7zmRiC4m0VNwTuJ8OpnN+PCNNXwBLb1BkBfehevLE/WJ6Glkww6f3yo6GS30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=Htlfh8nd; arc=none smtp.client-ip=121.127.44.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1742426781;
 bh=YrgmGOqT4SYp6oYqC9q8SeHubNvt4veSSI8b49RyuaU=;
 b=Htlfh8ndxv72DrbXARpyX/+zi/yA9S7LZSJ16/rEFpr5aRG+7PBo+Uz63JFhdm+uJFOM42hzI
 qbHNwIktllZzFsGUFCDCoqW4canshAJzqxTHl/HrouBjNWXfOeJ+kqvgrejdf/+igSig34lpJZC
 DY28/iSmQaxOw6AMvA9ZBH/7kh6aZ1Sv88w1EnRrd4WMx1aoZMXbt1/FGNwoUhzJxsrzjX5cApo
 81DczL2nR3VaSIGooiNeEZR3/xs3DVxVwMJtNjhpFF1e8oeDKq2CwNZOidCoI0vdEFkNZxjD4a3
 KQlZoRUQObHBBCI8wYWSyFFhrnaBcZ/BOCffzt7Y1/rg==
X-Forward-Email-ID: 67db529a27ee59b783a86f48
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 0.4.40
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <0d638134-0c0d-4918-af47-e23d2ead3bf3@kwiboo.se>
Date: Thu, 20 Mar 2025 00:26:14 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] arm64: dts: rockchip: Add pwm nodes for RK3528
To: Chukun Pan <amadeus@jmu.edu.cn>, Heiko Stuebner <heiko@sntech.de>
Cc: Yao Zi <ziyao@disroot.org>, Rob Herring <robh@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20250318120003.2340652-1-amadeus@jmu.edu.cn>
 <20250318120003.2340652-2-amadeus@jmu.edu.cn>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20250318120003.2340652-2-amadeus@jmu.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Chukun,

On 2025-03-18 13:00, Chukun Pan wrote:
> Add pwm nodes for RK3528. The PWM core on RK3528 is the same as
> RK3328, but the driver does not support interrupts yet.

The device tree should describe the hardware, not what the driver
support, so interrupts should probably be included.

However, looking closer at TRM for i.e. RK3328, RK3568 and RK3588 it
look like the following description is not a true description of the
hardware.

Each PWM controller seem to support 4 channels, here (and for older RK
SoCs) we instead describe each channel and not the controller.

Maybe something like following would better represent the hardware:

	pwm0: pwm@ffa90000 {
		compatible = "rockchip,rk3528-pwm";
		reg = <0x0 0xffa90000 0x0 0x10000>;
		clocks = <&cru CLK_PWM0>, <&cru PCLK_PWM0>;
		clock-names = "pwm", "pclk";
		interrupts = <GIC_SPI 53 IRQ_TYPE_LEVEL_HIGH>,
			     <GIC_SPI 54 IRQ_TYPE_LEVEL_HIGH>;
	};

	pwm1: pwm@ffa98000 {
		compatible = "rockchip,rk3528-pwm";
		reg = <0x0 0xffa98000 0x0 0x10000>;
		clocks = <&cru CLK_PWM1>, <&cru PCLK_PWM1>;
		clock-names = "pwm", "pclk";
		interrupts = <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>,
			     <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>;
	};

Regards,
Jonas

> 
> Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>
> ---
>  arch/arm64/boot/dts/rockchip/rk3528.dtsi | 80 ++++++++++++++++++++++++
>  1 file changed, 80 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3528.dtsi b/arch/arm64/boot/dts/rockchip/rk3528.dtsi
> index 1af0d036cf32..621fc19ac0b3 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3528.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3528.dtsi
> @@ -465,6 +465,86 @@ uart7: serial@ffa28000 {
>  			status = "disabled";
>  		};
>  
> +		pwm0: pwm@ffa90000 {
> +			compatible = "rockchip,rk3528-pwm",
> +				     "rockchip,rk3328-pwm";
> +			reg = <0x0 0xffa90000 0x0 0x10>;
> +			clocks = <&cru CLK_PWM0>, <&cru PCLK_PWM0>;
> +			clock-names = "pwm", "pclk";
> +			#pwm-cells = <3>;
> +			status = "disabled";
> +		};
> +
> +		pwm1: pwm@ffa90010 {
> +			compatible = "rockchip,rk3528-pwm",
> +				     "rockchip,rk3328-pwm";
> +			reg = <0x0 0xffa90010 0x0 0x10>;
> +			clocks = <&cru CLK_PWM0>, <&cru PCLK_PWM0>;
> +			clock-names = "pwm", "pclk";
> +			#pwm-cells = <3>;
> +			status = "disabled";
> +		};
> +
> +		pwm2: pwm@ffa90020 {
> +			compatible = "rockchip,rk3528-pwm",
> +				     "rockchip,rk3328-pwm";
> +			reg = <0x0 0xffa90020 0x0 0x10>;
> +			clocks = <&cru CLK_PWM0>, <&cru PCLK_PWM0>;
> +			clock-names = "pwm", "pclk";
> +			#pwm-cells = <3>;
> +			status = "disabled";
> +		};
> +
> +		pwm3: pwm@ffa90030 {
> +			compatible = "rockchip,rk3528-pwm",
> +				     "rockchip,rk3328-pwm";
> +			reg = <0x0 0xffa90030 0x0 0x10>;
> +			clocks = <&cru CLK_PWM0>, <&cru PCLK_PWM0>;
> +			clock-names = "pwm", "pclk";
> +			#pwm-cells = <3>;
> +			status = "disabled";
> +		};
> +
> +		pwm4: pwm@ffa98000 {
> +			compatible = "rockchip,rk3528-pwm",
> +				     "rockchip,rk3328-pwm";
> +			reg = <0x0 0xffa98000 0x0 0x10>;
> +			clocks = <&cru CLK_PWM1>, <&cru PCLK_PWM1>;
> +			clock-names = "pwm", "pclk";
> +			#pwm-cells = <3>;
> +			status = "disabled";
> +		};
> +
> +		pwm5: pwm@ffa98010 {
> +			compatible = "rockchip,rk3528-pwm",
> +				     "rockchip,rk3328-pwm";
> +			reg = <0x0 0xffa98010 0x0 0x10>;
> +			clocks = <&cru CLK_PWM1>, <&cru PCLK_PWM1>;
> +			clock-names = "pwm", "pclk";
> +			#pwm-cells = <3>;
> +			status = "disabled";
> +		};
> +
> +		pwm6: pwm@ffa98020 {
> +			compatible = "rockchip,rk3528-pwm",
> +				     "rockchip,rk3328-pwm";
> +			reg = <0x0 0xffa98020 0x0 0x10>;
> +			clocks = <&cru CLK_PWM1>, <&cru PCLK_PWM1>;
> +			clock-names = "pwm", "pclk";
> +			#pwm-cells = <3>;
> +			status = "disabled";
> +		};
> +
> +		pwm7: pwm@ffa98030 {
> +			compatible = "rockchip,rk3528-pwm",
> +				     "rockchip,rk3328-pwm";
> +			reg = <0x0 0xffa98030 0x0 0x10>;
> +			clocks = <&cru CLK_PWM1>, <&cru PCLK_PWM1>;
> +			clock-names = "pwm", "pclk";
> +			#pwm-cells = <3>;
> +			status = "disabled";
> +		};
> +
>  		saradc: adc@ffae0000 {
>  			compatible = "rockchip,rk3528-saradc";
>  			reg = <0x0 0xffae0000 0x0 0x10000>;


