Return-Path: <linux-kernel+bounces-286501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84B4E951BBF
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 15:22:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 406742840B1
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 13:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B460F1B1432;
	Wed, 14 Aug 2024 13:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lLpoHZB+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAEA61AE867;
	Wed, 14 Aug 2024 13:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723641761; cv=none; b=F4tCo/ptj/ovaAlcbAEWz97/CUFqJg0wGrgoUbGLK23EuhoEU74NL+Qa4kqZiioKTgA1w5HRjZbgQ1FnCSuWrH6RBTTbA/mapSrcNLVm65s5F4v64AE2+++wMB2FuYCKBg5zZvMYmua71iUNssZ+0yl8oFsnJZj+EexMOd8u968=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723641761; c=relaxed/simple;
	bh=lCyefVEk1UgcqnD+KmVG48WLG/feRn1Jw6ZCOpurnYs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JVekiAT5XVb0mEzwkELt6Sg/+mRicEAEo6F6zV84hPVlAwYPJ1a8lSIUylBFXx4tVXVo+GnX1BDaEe7VrWNeqPULIfeHJBRV8YlCRHC4j0Cnlslr30mF0o4GL1NV3BiBs8/cQ5NSyaO1cgV7JFnAAlN45qccJoUdozVAyGjeIY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lLpoHZB+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B39D8C32786;
	Wed, 14 Aug 2024 13:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723641760;
	bh=lCyefVEk1UgcqnD+KmVG48WLG/feRn1Jw6ZCOpurnYs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=lLpoHZB+iy6ffmAMJfppczjKToLYCp8pjw+p+nk2ZzcJtIeub4nUnyClCZAulbwNS
	 2+v0wfzbGJwi6KA+Zau9hsJ5YgkiNWTthXQXte1Q+l5j6eEAH4BP3r9K401MMhdeyY
	 t7nO+FkkPHNcYKm6cVqpQTFYlxZ1OvboIYRXAqzklcU4jpkB5CHeJou5sQJNTosjVr
	 k/k2ntQRz+TNEmEA6v1HeCRH/Gbk3GMKDGVb3cSZjMU846PvsDv+nfPbDthBtdwXA3
	 6MWxGNeaYPneOddKg70OKlBIXHtzbdugVn4qzleVI/jBheseHNblcsMmnyJ8nS8xDn
	 jDiXL5M7OKNQQ==
Message-ID: <29e5fada-8f8a-4cc0-b1d0-14396f6736a6@kernel.org>
Date: Wed, 14 Aug 2024 15:22:34 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] ARM: dts: microchip: Rename the usb node
To: Andrei Simion <andrei.simion@microchip.com>, claudiu.beznea@tuxon.dev,
 nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, peda@axentia.se
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, cristian.birsan@microchip.com
References: <20240814122633.198562-1-andrei.simion@microchip.com>
 <20240814122633.198562-5-andrei.simion@microchip.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20240814122633.198562-5-andrei.simion@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 14/08/2024 14:26, Andrei Simion wrote:
> Rename the usb node according to devicetree
> specification and update the label according
> with the node-specific standard as: ohci, ehci
> or gadget.

Please wrap commit message according to Linux coding style / submission
process (neither too early nor over the limit):
https://elixir.bootlin.com/linux/v6.4-rc1/source/Documentation/process/submitting-patches.rst#L597

...


> 
> diff --git a/arch/arm/boot/dts/microchip/aks-cdu.dts b/arch/arm/boot/dts/microchip/aks-cdu.dts
> index 742fcf525e1b..52e166c8a365 100644
> --- a/arch/arm/boot/dts/microchip/aks-cdu.dts
> +++ b/arch/arm/boot/dts/microchip/aks-cdu.dts
> @@ -50,13 +50,13 @@ macb0: ethernet@fffc4000 {
>  				status = "okay";
>  			};
>  
> -			usb1: gadget@fffa4000 {
> +			gadget: usb@fffa4000 {
>  				atmel,vbus-gpio = <&pioC 15 GPIO_ACTIVE_HIGH>;
>  				status = "okay";
>  			};
>  		};
>  
> -		usb0: ohci@500000 {
> +		ohci: usb@500000 {

I don't think that these label renames are correct.

>  			num-ports = <2>;
>  			status = "okay";
>  		};
> diff --git a/arch/arm/boot/dts/microchip/animeo_ip.dts b/arch/arm/boot/dts/microchip/animeo_ip.dts
> index 29936bfbeeb7..911c8d9ee013 100644
> --- a/arch/arm/boot/dts/microchip/animeo_ip.dts
> +++ b/arch/arm/boot/dts/microchip/animeo_ip.dts
> @@ -136,7 +136,7 @@ ubi@60000 {
>  			};
>  		};
>  
> -		usb0: ohci@500000 {
> +		ohci: usb@500000 {
>  			num-ports = <2>;
>  			atmel,vbus-gpio = <&pioB 15 GPIO_ACTIVE_LOW>;
>  			status = "okay";
> diff --git a/arch/arm/boot/dts/microchip/at91-ariag25.dts b/arch/arm/boot/dts/microchip/at91-ariag25.dts
> index 713d18f80356..fedcf30a924e 100644
> --- a/arch/arm/boot/dts/microchip/at91-ariag25.dts
> +++ b/arch/arm/boot/dts/microchip/at91-ariag25.dts
> @@ -173,11 +173,11 @@ &usart3 {
>  	status = "okay";
>  };
>  
> -&usb0 {
> +&ohci {
>  	status = "okay";
>  	num-ports = <3>;
>  };
>  
> -&usb1 {
> +&ehci {
>  	status = "okay";
>  };

And how now the sorting works? I don't get the point of it. What is
exactly wrong in the label that justifies the code reshuffling.

BTW, is this some sort of v2? If so, provide changelog and properly
version your patches.

Best regards,
Krzysztof


