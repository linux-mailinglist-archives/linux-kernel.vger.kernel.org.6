Return-Path: <linux-kernel+bounces-264191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54F4493E004
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 17:53:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1035F28214A
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 15:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D095181D0C;
	Sat, 27 Jul 2024 15:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="lILBN6Is"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECBBB181CFA;
	Sat, 27 Jul 2024 15:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722095591; cv=none; b=AuYfqHjpYSGKvH3P5wkD6fyBDvUcUGpkuS7v8Z1ZH9OK0XHHogbDm20jdPfg7ea3o201dFyrUjmD/g+dd1vnZClUsdynqX03aGXropH/DRgZNe5QYXP1ce3EadmTaxHnyB++CRtQIl+ca+mExulANK9N9O/n70NCs9TlMooIj9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722095591; c=relaxed/simple;
	bh=NtUN/2hPv0Hx4nQy4FckIJQjyRrcg8tDhTqw2ddKKBc=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=PCamOFBqcB8ekAvw9kQ0Vt4tZg5GozZMtyj3Mw74ne66FFquBEZs/4nZTd7PY1R04zqvpAVppoAPX3CYDaQnFXeYDyrJAw03gX0OPtvAYttrliyHH3VcgLQhOxbIgi2sk2fvh4p8I/8dKhtqYCYbHUeq6ca+x4eqT9W2/T2BCC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=lILBN6Is; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1722095580;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ey6TLlvsh7W76LTwNBcAOelGm+P+oLYiI/XxNUy/ajs=;
	b=lILBN6Is22+9nU3ZLKmZZFQGypsmiPkSNwHkNaelTVENPDXy9VcT7CBsOKOm7g4UAX7wpd
	cALDfvIgXMszyl8NUSwXidsZjg59Z8ozIFbvx/Vf776+EIGSlapfqH0gRaFwhPRk9YE78U
	LdgsFH3GPhJSc5At98CCtCO6OdYLHKEM3dZVB8CYZH6lM/ErBFbiwD/ZbL/inx5zIrpUf8
	5j8OUmJ3wRLiz+42XPV408rtMmAmwsfNCWzU2akorIG8h7Zxy0YRyNcT1oGLSuO/mgUR8N
	Njz7W0Kj3n41hd8PkmGaww5lVfVbjw4sF1SvsnbhvZ09iqzH3/sLIsEgzIlgyQ==
Date: Sat, 27 Jul 2024 17:52:59 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Anand Moon <linux.amoon@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, Jonas
 Karlman <jonas@kwiboo.se>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/3] arm64: dts: rockchip: Add missing pinctrl for
 PCIe30x4 node
In-Reply-To: <20240726110050.3664-1-linux.amoon@gmail.com>
References: <20240726110050.3664-1-linux.amoon@gmail.com>
Message-ID: <af63314cbac4cae4ffc84606024f9795@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Anand,

On 2024-07-26 13:00, Anand Moon wrote:
> Add missing pinctrl settings for PCIe 3.0 x4 clock request and wake
> signals. Each component of PCIe communication have the following 
> control
> signals: PERST, WAKE, CLKREQ, and REFCLK. These signals work to 
> generate
> high-speed signals and communicate with other PCIe devices.
> Used by root complex to endpoint depending on the power state.
> 
> PERST is referred to as a fundamental reset. PERST should be held low
> until all the power rails in the system and the reference clock are 
> stable.
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

I wonder why the three patches in this series cannot be squashed into
a single patch, because they target the same thing for the same board
dts file?  I don't think that having these three separate patches may
help with possible regression tracking in the future, for example.

> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
> v4: rebase on master, used RK_FUNC_GPIO GPIO function instead of PIN
> number.
> V3: use pinctrl local to board
> V2: Update the commit messge to describe the changs.
>     use pinctl group as its pre define in pinctrl dtsi
> ---
>  .../arm64/boot/dts/rockchip/rk3588-rock-5b.dts | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
> b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
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

