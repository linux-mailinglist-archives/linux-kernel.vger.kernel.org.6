Return-Path: <linux-kernel+bounces-242488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CA169288C7
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 14:38:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E7B4B236B2
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 12:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 579F114A617;
	Fri,  5 Jul 2024 12:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="TIpYwtrx"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C27146D76;
	Fri,  5 Jul 2024 12:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720183083; cv=none; b=Uq+tG4UTZcIHT3LiPpUjmGhdrofiPNXibH7Nrwl0M4/Scb9l7nTDOK2rV+gDeCxUgg64jxmgKqKFUW6yhImv8eTGuk8NH3kD7CNu2JabI67Su6d1KX0chINZUAeQpPahNRyCUVlsIcBEa7hip8UF1xJwgeZC/D9jXimr7Q8OImI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720183083; c=relaxed/simple;
	bh=3HsTbsDKm/NLPUYW8jCyPrQiNP4MJEpDQo2aw2DgUnQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=U1oyg8+YL0QSj7/LGqhgQRqAxamQ7BignuLygFHvn3PQgxgkOkcwHUAT2NdL6gk+d+NKmhtiuEjBHXmU7Ulvi7twckoUOQTkuC5FDRAnLqABeOl23PfYgJoq/1qzb7awXjc2NWVx9XX/n+ZHG3ipxeeHgUwLs2pZ8nv5WcGAVqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=TIpYwtrx; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 76E5220008;
	Fri,  5 Jul 2024 12:37:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1720183079;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VouKlLx9uRbG/3DbSVlCs8lvpC20KVHIWouvaxdon2Q=;
	b=TIpYwtrxmkTM1GtSK2YRQWj9lpXL72qz1Aq9KmZdZpgzCP5PqNocWPox60UN1UGziAa2xv
	fNkuwx/fxwvEE/HyC41bML7s9ktMH6A85Av08qbz5l8Mj94ht8HCMLwTjj4r6kT3gN9hMb
	SReFh/iiBDqmbTwrzjwuUnLzVc0GXsk70hoXw24csX4tErE2CeaftBGSPf+hDE+h1vGOyI
	AHtpGWtD4DlXiJMNweQFrsPCbjgkM3c1FgCnTcKJQMZZ0/EYAIo7XPLp1Mb+DxzNuU8Hu5
	leD0q4kzrlm+6NEMGdeWrHAo0s4xATDKItyBTgrKVfYPh3DHrklL4vv1D0xByA==
From: Gregory CLEMENT <gregory.clement@bootlin.com>
To: Chris Packham <chris.packham@alliedtelesis.co.nz>, andrew@lunn.ch,
 sebastian.hesselbarth@gmail.com
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Chris Packham
 <chris.packham@alliedtelesis.co.nz>
Subject: Re: [PATCH] ARM: dts: marvell: Add 7-segment LED display on x530
In-Reply-To: <20240530231608.3557782-1-chris.packham@alliedtelesis.co.nz>
References: <20240530231608.3557782-1-chris.packham@alliedtelesis.co.nz>
Date: Fri, 05 Jul 2024 14:37:58 +0200
Message-ID: <87o77cj9p5.fsf@BLaptop.bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: gregory.clement@bootlin.com

Chris Packham <chris.packham@alliedtelesis.co.nz> writes:

> The Allied Telesis x530 products have a 7-segment LED display which is
> used for node identification when the devices are stacked. Represent
> this as a gpio-7-segment device.
>
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>

Applied on mvebu/dt

Thanks,

Gregory
> ---
> This was originally sent as part of the series that added the seg-led-gpio
> driver but wasn't applied with those changes. At the time I said I'd submit
> this separately but I forgot about it until now.
>
>  arch/arm/boot/dts/marvell/armada-385-atl-x530.dts | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/marvell/armada-385-atl-x530.dts b/arch/arm/boot/dts/marvell/armada-385-atl-x530.dts
> index 5a9ab8410b7b..2fb7304039be 100644
> --- a/arch/arm/boot/dts/marvell/armada-385-atl-x530.dts
> +++ b/arch/arm/boot/dts/marvell/armada-385-atl-x530.dts
> @@ -43,6 +43,17 @@ uart0: serial@12000 {
>  			};
>  		};
>  	};
> +
> +	led-7seg {
> +		compatible = "gpio-7-segment";
> +		segment-gpios = <&led_7seg_gpio 0 GPIO_ACTIVE_LOW>,
> +				<&led_7seg_gpio 1 GPIO_ACTIVE_LOW>,
> +				<&led_7seg_gpio 2 GPIO_ACTIVE_LOW>,
> +				<&led_7seg_gpio 3 GPIO_ACTIVE_LOW>,
> +				<&led_7seg_gpio 4 GPIO_ACTIVE_LOW>,
> +				<&led_7seg_gpio 5 GPIO_ACTIVE_LOW>,
> +				<&led_7seg_gpio 6 GPIO_ACTIVE_LOW>;
> +	};
>  };
>  
>  &pciec {
> @@ -149,7 +160,7 @@ i2c@3 {
>  			#size-cells = <0>;
>  			reg = <3>;
>  
> -			gpio@20 {
> +			led_7seg_gpio: gpio@20 {
>  				compatible = "nxp,pca9554";
>  				gpio-controller;
>  				#gpio-cells = <2>;
> -- 
> 2.45.1

