Return-Path: <linux-kernel+bounces-237452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12CB19238DF
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 10:52:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5BAE2863EB
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 08:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A02F414F9ED;
	Tue,  2 Jul 2024 08:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b="nobj0K6o"
Received: from mail.thorsis.com (mail.thorsis.com [217.92.40.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 939D284D39;
	Tue,  2 Jul 2024 08:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.92.40.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719910333; cv=none; b=qVJUYN8h2Bl+GFvyKAZTCkrC9ceioK/DrONnHzbGgqOsZiOFhk+ekeg30l9uijd8MYofyeEEWYWqo8C5fxkvHsoBnb2hx0uDOK25YhshW2Kd/MFYL+BYlX9JP7Bi+PBvy5v8iahIqiRJfNsBgCl79kNsxvrX77ofcvHddYZsn78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719910333; c=relaxed/simple;
	bh=BH2CWTwSOhfW5vCvhd8tT4OjEdGCVOIRmEO7y0iID3g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GlCkRYlYgnCI5xkf49p69ua7OtT8K4aYECMvPqNpIdvpul6N8uih/lyeXSJ6k0wfk5F+T7ZBeMrxeRqKMrz9G689ffI6NK8kB3zM9xMyzc0cbzjKF6WaeRIFWZ5QNFsGBF3jzGjj1EG0Hk1xY46/C/jeeNnxmVCNFsJ5l3Y/Voc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com; spf=pass smtp.mailfrom=thorsis.com; dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b=nobj0K6o; arc=none smtp.client-ip=217.92.40.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thorsis.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 66517148180A;
	Tue,  2 Jul 2024 10:51:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=dkim;
	t=1719910321; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=rnPvl+gvjVB+JnMYogxg+hXwl+8kf0wMBfY9XNxoeZw=;
	b=nobj0K6o+gqjwCuo1I6LFAxMjoT7Yj9H6oOshtkkVqyxorSDr/JFof/fC4CknN0aB7gp9K
	Ag1ozYNlnfOJBPyrdOyI8oMJ8yofGmK1IfR1zROOb5Yu9+/ye36Ebrd7aMuyvRJ3LJ+WHc
	QRrcpv88RaLw5zYOwhvYyHd8sCnrvOQADomYhtwtidMtc4LwEmEZldGGnTDxiL0ZKP//9j
	NWASOi6HFPwJDauPGR9hKfdQIpjCL0TYVVMvikkNrzRLVoxuseErIvc4HfpJBM6VFN2L9Y
	nQJtGa9gE2gRQbhAsBdnbEZtssS6Tvx48i6jgFcMo3giUhFFxzYUqqgCH88l/g==
Date: Tue, 2 Jul 2024 10:51:53 +0200
From: Alexander Dahl <ada@thorsis.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: microchip: at91: align LED node name with
 bindings
Message-ID: <20240702-expel-unflawed-b174e82e27c7@thorsis.com>
Mail-Followup-To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
References: <20240701164952.577277-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240701164952.577277-1-krzysztof.kozlowski@linaro.org>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Last-TLS-Session-Version: TLSv1.3

Hello Krzysztof,

Am Mon, Jul 01, 2024 at 06:49:52PM +0200 schrieb Krzysztof Kozlowski:
> Bindings expect the LED node names to follow certain pattern, see
> dtbs_check warnings:
> 
>   at91sam9g15ek.dtb: leds: 'pb18', 'pd21' do not match any of the regexes: '(^led-[0-9a-f]$|led)', 'pinctrl-[0-9]+'
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../boot/dts/microchip/at91sam9g20ek_2mmc.dts |  4 ++--
>  .../at91sam9g25-gardena-smart-gateway.dts     | 24 +++++++++----------
>  arch/arm/boot/dts/microchip/at91sam9n12ek.dts |  6 ++---
>  arch/arm/boot/dts/microchip/at91sam9x5cm.dtsi |  4 ++--
>  4 files changed, 19 insertions(+), 19 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/microchip/at91sam9g20ek_2mmc.dts b/arch/arm/boot/dts/microchip/at91sam9g20ek_2mmc.dts
> index 172af6ff4b18..3e5eab57d1a5 100644
> --- a/arch/arm/boot/dts/microchip/at91sam9g20ek_2mmc.dts
> +++ b/arch/arm/boot/dts/microchip/at91sam9g20ek_2mmc.dts
> @@ -40,13 +40,13 @@ pinctrl_board_mmc0_slot0: mmc0_slot0-board {
>  	leds {
>  		compatible = "gpio-leds";
>  
> -		ds1 {
> +		led-ds1 {
>  			label = "ds1";
>  			gpios = <&pioB 9 GPIO_ACTIVE_HIGH>;
>  			linux,default-trigger = "heartbeat";
>  		};
>  
> -		ds5 {
> +		led-ds5 {
>  			label = "ds5";
>  			gpios = <&pioB 8 GPIO_ACTIVE_LOW>;
>  		};
> diff --git a/arch/arm/boot/dts/microchip/at91sam9g25-gardena-smart-gateway.dts b/arch/arm/boot/dts/microchip/at91sam9g25-gardena-smart-gateway.dts
> index af70eb8a3a02..e0c1e8df81b1 100644
> --- a/arch/arm/boot/dts/microchip/at91sam9g25-gardena-smart-gateway.dts
> +++ b/arch/arm/boot/dts/microchip/at91sam9g25-gardena-smart-gateway.dts
> @@ -37,71 +37,71 @@ button {
>  	leds {
>  		compatible = "gpio-leds";
>  
> -		power_blue {
> +		led-power-blue {
>  			label = "smartgw:power:blue";
>  			gpios = <&pioC 21 GPIO_ACTIVE_HIGH>;
>  			default-state = "off";
>  		};
>  
> -		power_green {
> +		led-power-green {
>  			label = "smartgw:power:green";
>  			gpios = <&pioC 20 GPIO_ACTIVE_HIGH>;
>  			default-state = "on";
>  		};
>  
> -		power_red {
> +		led-power-red {
>  			label = "smartgw:power:red";
>  			gpios = <&pioC 19 GPIO_ACTIVE_HIGH>;
>  			default-state = "off";
>  		};
>  
> -		radio_blue {
> +		led-radio-blue {
>  			label = "smartgw:radio:blue";
>  			gpios = <&pioC 18 GPIO_ACTIVE_HIGH>;
>  			default-state = "off";
>  		};
>  
> -		radio_green {
> +		led-radio-green {
>  			label = "smartgw:radio:green";
>  			gpios = <&pioC 17 GPIO_ACTIVE_HIGH>;
>  			default-state = "off";
>  		};
>  
> -		radio_red {
> +		led-radio-red {
>  			label = "smartgw:radio:red";
>  			gpios = <&pioC 16 GPIO_ACTIVE_HIGH>;
>  			default-state = "off";
>  		};
>  
> -		internet_blue {
> +		led-internet-blue {
>  			label = "smartgw:internet:blue";
>  			gpios = <&pioC 15 GPIO_ACTIVE_HIGH>;
>  			default-state = "off";
>  		};
>  
> -		internet_green {
> +		led-internet-green {
>  			label = "smartgw:internet:green";
>  			gpios = <&pioC 14 GPIO_ACTIVE_HIGH>;
>  			default-state = "off";
>  		};
>  
> -		internet_red {
> +		led-internet-red {
>  			label = "smartgw:internet:red";
>  			gpios = <&pioC 13 GPIO_ACTIVE_HIGH>;
>  			default-state = "off";
>  		};
>  
> -		heartbeat {
> +		led-heartbeat {
>  			label = "smartgw:heartbeat";
>  			gpios = <&pioB 8 GPIO_ACTIVE_HIGH>;
>  			linux,default-trigger = "heartbeat";
>  		};
>  
> -		pb18 {
> +		led-pb18 {
>  			status = "disabled";
>  		};
>  
> -		pd21 {
> +		led-pd21 {
>  			status = "disabled";
>  		};
>  	};
> diff --git a/arch/arm/boot/dts/microchip/at91sam9n12ek.dts b/arch/arm/boot/dts/microchip/at91sam9n12ek.dts
> index 4c644d4c6be7..643c3b2ab97e 100644
> --- a/arch/arm/boot/dts/microchip/at91sam9n12ek.dts
> +++ b/arch/arm/boot/dts/microchip/at91sam9n12ek.dts
> @@ -207,19 +207,19 @@ bl_reg: backlight_regulator {
>  	leds {
>  		compatible = "gpio-leds";
>  
> -		d8 {
> +		led-d8 {
>  			label = "d8";
>  			gpios = <&pioB 4 GPIO_ACTIVE_LOW>;
>  			linux,default-trigger = "mmc0";
>  		};
>  
> -		d9 {
> +		led-d9 {
>  			label = "d9";
>  			gpios = <&pioB 5 GPIO_ACTIVE_LOW>;
>  			linux,default-trigger = "nand-disk";
>  		};
>  
> -		d10 {
> +		led-d10 {
>  			label = "d10";
>  			gpios = <&pioB 6 GPIO_ACTIVE_HIGH>;
>  			linux,default-trigger = "heartbeat";
> diff --git a/arch/arm/boot/dts/microchip/at91sam9x5cm.dtsi b/arch/arm/boot/dts/microchip/at91sam9x5cm.dtsi
> index cdd37f67280b..fb3c19bdfcb6 100644
> --- a/arch/arm/boot/dts/microchip/at91sam9x5cm.dtsi
> +++ b/arch/arm/boot/dts/microchip/at91sam9x5cm.dtsi
> @@ -120,13 +120,13 @@ rootfs@800000 {
>  	leds {
>  		compatible = "gpio-leds";
>  
> -		pb18 {
> +		led-pb18 {
>  			label = "pb18";
>  			gpios = <&pioB 18 GPIO_ACTIVE_LOW>;
>  			linux,default-trigger = "heartbeat";
>  		};
>  
> -		pd21 {
> +		led-pd21 {
>  			label = "pd21";
>  			gpios = <&pioD 21 GPIO_ACTIVE_HIGH>;
>  		};

In this case these are all gpio-leds and the pattern is in the
leds-gpio gpio binding.  I'm wondering however why you chose the very
generic 'led' match over the more strict one requiring the names to
look like 'led-0', 'led-1' an so forth?  The generic match would also
match names like 'knowledge' or 'controlled'.  But besides that:

Reviewed-by: Alexander Dahl <ada@thorsis.com>

Greets
Alex


> -- 
> 2.43.0
> 
> 

