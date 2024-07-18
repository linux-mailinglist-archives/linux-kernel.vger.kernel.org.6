Return-Path: <linux-kernel+bounces-255964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CEC893471E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 06:20:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 750081C2129A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 04:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93B1A3E467;
	Thu, 18 Jul 2024 04:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="OCODp+DE"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B72D1E520;
	Thu, 18 Jul 2024 04:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721276436; cv=none; b=l7rmjQD9Wa8dwnHt0dxE43PU4KGMnqrCQ3dn5Uf+L6StH7uwHsSFAdVP9TXC3OtDR5bTulhomloh1M8ZB+sDspIlTbJ5RcMjK7kvSJGwDYDsGjolFdPuy2sncH61INT1cZB9ta3QrEob7R28x2swzzfk/nULjL38ONjIHpWdijI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721276436; c=relaxed/simple;
	bh=y7s7HtOs/RagBLkoEqIoxs7z0oD8QGP3f29oNhxjEuI=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=Bznwv9CFzlrXCl3m9t4yhaGdbvd+9J+LymBa0NGQx2c8m8CYLPTTbC5mjDKV4AoYXm4XyQFklJDN6bEWavnBLewX5+6vg9wQnZdZ31bpppOpJBis26kJvdBIvVisfyzzi6wRALS4OgrAbsi6cn9sRFS5LjfWW18m5bno7petGGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=OCODp+DE; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1721276423;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CD7dNLN6zqi6YcYtZcfrfWnkDlKeK6NkwYpMRxN/J/U=;
	b=OCODp+DEr140wZQqm5OccISLNFJY2LIydXCsOWwb+jJYkMgG4/uJpvoJLdoHB/Xbn9XXPI
	ZJtiYH8B173JQEEacV7rd3WzMCpbAikkA6F1vJATASxpV/zCyu2nic68gSMU9MRKSJODzT
	29CDEER82Z0y/eqWd5JBDDaMxskov7gR3FozoPosBqmE9V8I6uWTjY3yg8TCOK4GpY913I
	H45G8orfLJhsxW7UHH5UlW0BeEoLKYHTYQaRPK7y6mSSwXVGEcKtXw82cfCZlxZcNLb9M1
	1+dmsD0HcCGwN4C3FwKPQSDmgLh+rMNnXwgY+VfigzgPhUwJyofjJ3SiLcqjaw==
Date: Thu, 18 Jul 2024 06:20:21 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Conor Dooley <conor@kernel.org>
Cc: linux-kernel@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>,
 Dinh Nguyen <dinguyen@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Heiko
 Stuebner <heiko@sntech.de>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer
 <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Huacai Chen <chenhuacai@kernel.org>,
 WANG Xuerui <kernel@xen0n.name>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 imx@lists.linux.dev, loongarch@lists.linux.dev
Subject: Re: [PATCH v1 2/4] ARM: dts: rockchip: remove unlikly-to-exist DAC
 from elgin-r1
In-Reply-To: <20240717-parrot-malt-83cc04bf6b36@spud>
References: <20240717-anvil-ashy-544e80a1317c@spud>
 <20240717-parrot-malt-83cc04bf6b36@spud>
Message-ID: <9a492f785e0851a828e0864c33204920@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Conor,

On 2024-07-17 11:37, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> The Rohm dh2228fv (really the bh2228fv, the compatible in the kernel 
> has
> a typo) does not support frequencies above 10 MHz, nor per the
> datasheet appear to use either CPOL or CPHA. I suspect that this
> devicetree is abusing the compatible in order to bind the spidev driver
> in Linux. Pretending to have devices on a board for this purpose is not
> acceptable, so remove it.
> 
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>

There's a small typo in the patch subject:
s/unlikly/unlikely/

> ---
> I could not find any documentation for this board online, and it does
> not blatantly say that the device is a "spidev" like other [ab]users, 
> so
> it is possible there's actually a DAC here - but I doubt it is a
> bh2228fv given the other incompatibilities.
> ---
>  arch/arm/boot/dts/rockchip/rv1108-elgin-r1.dts | 8 --------
>  1 file changed, 8 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/rockchip/rv1108-elgin-r1.dts
> b/arch/arm/boot/dts/rockchip/rv1108-elgin-r1.dts
> index 2d9994379eb2..9df1cef406c5 100644
> --- a/arch/arm/boot/dts/rockchip/rv1108-elgin-r1.dts
> +++ b/arch/arm/boot/dts/rockchip/rv1108-elgin-r1.dts
> @@ -167,14 +167,6 @@ &spi {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&spim1_clk &spim1_cs0 &spim1_tx &spim1_rx>;
>  	status = "okay";
> -
> -	dh2228fv: dac@0 {
> -		compatible = "rohm,dh2228fv";
> -		reg = <0>;
> -		spi-max-frequency = <24000000>;
> -		spi-cpha;
> -		spi-cpol;
> -	};
>  };
> 
>  &u2phy {

