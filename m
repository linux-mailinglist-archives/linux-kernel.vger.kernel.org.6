Return-Path: <linux-kernel+bounces-445817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FBA29F1BD8
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 02:17:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45480168379
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 01:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2043ADF49;
	Sat, 14 Dec 2024 01:16:59 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 600F7BE65;
	Sat, 14 Dec 2024 01:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734139018; cv=none; b=MjZ6WZCcFxh/zdegpMSTw/y9eWov07NoDy0Tvmq6wRSsnJiViH9MaG4OB53Q0xLllgQFb0v8ipCvWY/TNVuF8yo4y7HpkYLYUwE0uelAgBa1I3lQReLfXhiSkHYedvSPn6Er5R7i+vkdIRVGcujN5+gsZhGRcIA8zTLLNsis9qM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734139018; c=relaxed/simple;
	bh=gRyC+xG/KQ4DuOiTjuRdGZ1O0rJSxm4vq7H0bY1j6jk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YAVkkSIwQi8BuIkr1tfsuHG0WFiYzhMppQqjW/Jzs+5ysKwXX/ItuMAe/uDl75cLOYnLhimsCvic/y1Gc7UIU7iw/hctAVR7JOMAit4IndnDBloBg7JPJ4g02NEQl1dLLSdDJ4EZcDwK4gx2yEBLVDaDbbG5WYTa5ht6jDyAiuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B7EDE11FB;
	Fri, 13 Dec 2024 17:17:23 -0800 (PST)
Received: from minigeek.lan (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 20AD63F5A1;
	Fri, 13 Dec 2024 17:16:54 -0800 (PST)
Date: Sat, 14 Dec 2024 01:16:12 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: Hermann.Lauer@uni-heidelberg.de
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, Jernej
 Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, Icenowy Zheng
 <uwu@icenowy.me>
Subject: Re: [PATCH v2] ARM: dts: sun8i-r40: remove unused GPIO regulator
Message-ID: <20241214011612.4fd9e4bf@minigeek.lan>
In-Reply-To: <20241213195433.GA1568@lemon.iwr.uni-heidelberg.de>
References: <20241213195433.GA1568@lemon.iwr.uni-heidelberg.de>
Organization: Arm Ltd.
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.31; x86_64-slackware-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 13 Dec 2024 20:54:33 +0100
Hermann.Lauer@uni-heidelberg.de wrote:

Hi,

CC:ing Icenowy, who added the regulator originally, with commit
0ca12c1ee43c ("ARM: sun8i: r40: add 5V regulator for Banana Pi M2
Ultra").

Icenowy: can you clarify what "newer" version this was referring to in
that commit message? That commit in itself doesn't seem to do anything,
as the regulator isn't referenced, and it's not always-on. It's only
later when the USB nodes were added that it got used?
So was PH23 really necessary? As Hermann reports, setting PH23 on a v1.1
makes it reboot.

> Subject: [PATCH v2] ARM: dts: sun8i-r40: remove unused GPIO regulator

Hermann, this looks like an extra subject line here?

> Banana Pi M2 Ultra V1.1 board resets immediately when the usb core tries
> to setup PH23 GPIO. It turned out that the V1.0 board USB-A ports are
> always power supplied and according to the board scheme PH23 is simply
> not connected.
> 
> So remove the PH23 setup: Doesn't harm V1.0 (with R40) and let V1.1
> (with A40i) start.
> 
> Signed-off-by: Hermann Lauer <Hermann.Lauer@uni-heidelberg.de>

The patch itself looks good to me, but it would be good to clarify the
situation with the "older newer" version.

Just in case:
Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Cheers,
Andre
 
> ---
> V2: shorten subject, rm dangerous PH23 regulator completely
> 
> diff --git a/arch/arm/boot/dts/allwinner/sun8i-r40-bananapi-m2-ultra.dts b/arch/arm/boot/dts/allwinner/sun8i-r40-bananapi-m2-ultra.dts
> --- a/arch/arm/boot/dts/allwinner/sun8i-r40-bananapi-m2-ultra.dts
> +++ b/arch/arm/boot/dts/allwinner/sun8i-r40-bananapi-m2-ultra.dts
> @@ -91,15 +91,6 @@
>  		};
>  	};
>  
> -	reg_vcc5v0: vcc5v0 {
> -		compatible = "regulator-fixed";
> -		regulator-name = "vcc5v0";
> -		regulator-min-microvolt = <5000000>;
> -		regulator-max-microvolt = <5000000>;
> -		gpio = <&pio 7 23 GPIO_ACTIVE_HIGH>; /* PH23 */
> -		enable-active-high;
> -	};
> -
>  	wifi_pwrseq: pwrseq {
>  		compatible = "mmc-pwrseq-simple";
>  		reset-gpios = <&pio 6 10 GPIO_ACTIVE_LOW>; /* PG10 WIFI_EN */
> @@ -347,7 +338,5 @@
>  };
>  
>  &usbphy {
> -	usb1_vbus-supply = <&reg_vcc5v0>;
> -	usb2_vbus-supply = <&reg_vcc5v0>;
>  	status = "okay";
>  };
> 


