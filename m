Return-Path: <linux-kernel+bounces-216588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03D6090A1DE
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 03:42:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E24B2823D3
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 01:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C948615666C;
	Mon, 17 Jun 2024 01:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="fdHiG8UH"
Received: from mail-177132.yeah.net (mail-177132.yeah.net [123.58.177.132])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7B75155C98;
	Mon, 17 Jun 2024 01:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=123.58.177.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718588519; cv=none; b=EvsoUAg9emuHohK9vwBqGjvT+eVJUO56aKUIui12WDx6TsmtNqliUyMgPmDVkgDSdR9kUejIRh28AQr7vir8hKf4bXgoIQ4PxHLttUDjTz2SoDiolktMuUeEur7ofkft9U4s7r7Oniq7aFiwZOLAG56Zw+AWR2Ko7Yy8KQWb6/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718588519; c=relaxed/simple;
	bh=edcXCVjo8+FbsfYeJoQxXIcc+2zMG60j3dMm58sn1Bc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uynHuZ/kFhxtLNPloEj9ZHixPZduOZFWKZ0iM3b/PFGxd7fbGDfJOtiijxOGqApLk5lrA/3r2BEULeAn3cFx7w8ZLckPKyrDc63SHZTtCUjDQGeS0lo9e9carSBmGZH2KyEJXrzc21AFSv4gpM9N/oiao8TuzIX7GG5DJTLXiUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=fdHiG8UH; arc=none smtp.client-ip=123.58.177.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=WjkdTnC3fHUX/SExvSttwBjUZ2gM29MjAUpc7gFJ48E=;
	b=fdHiG8UHLaVN2hNgMiwMMaCuiAWkhhyVEk5puJMecj2C/X5qeEbUdues7sifWv
	dj475Pg9rjZhbkSPB677NwTJUxfbhMnvvVtmiumyEKD2a9BUHmrYiI52Xa9qKynG
	AphbkMQfgqbZnDEsLWlNW0o8zWzo8S3Bus9CyZRcYTOzg=
Received: from dragon (unknown [114.216.76.201])
	by smtp2 (Coremail) with SMTP id C1UQrAD3f2pNlG9mMIXNCA--.15615S3;
	Mon, 17 Jun 2024 09:41:35 +0800 (CST)
Date: Mon, 17 Jun 2024 09:41:33 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Michael Walle <mwalle@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>, Li Yang <leoyang.li@nxp.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Priit Laes <plaes@plaes.org>,
	Michael Grzeschik <m.grzeschik@pengutronix.de>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Marco Felsch <m.felsch@pengutronix.de>, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 09/13] ARM: dts: imx6qdl-kontron-samx6i: fix node names
Message-ID: <Zm+UTbGEhzbCgy1S@dragon>
References: <20240606090206.2021237-1-mwalle@kernel.org>
 <20240606090206.2021237-10-mwalle@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240606090206.2021237-10-mwalle@kernel.org>
X-CM-TRANSID:C1UQrAD3f2pNlG9mMIXNCA--.15615S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7Zw1UJr17WFW7uFWDuFykKrg_yoW5JryxpF
	WfWr9YgFs7Wa1aqa45JFyUCF93Ca1xK39IgwnrGF1UKr13ZF17Zry0k34fWrnFqFs8J3yY
	yFnIvryxJ3W8ZrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jz1v3UUUUU=
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiGA8BZV6Nn450dAAAsx

On Thu, Jun 06, 2024 at 11:02:02AM +0200, Michael Walle wrote:
> Rename the nodes according to the schema. In particular, renamae the bit

s/renamae/rename

Shawn

> bang I2C controller to "i2c-N" and the mux nodes of the audmux to
> "mux-*". While at it, fix the typo "adu", which should have been "aud".
> 
> Signed-off-by: Michael Walle <mwalle@kernel.org>
> ---
>  .../boot/dts/nxp/imx/imx6qdl-kontron-samx6i.dtsi   | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-kontron-samx6i.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-kontron-samx6i.dtsi
> index d36743e47552..85e5adac6ee9 100644
> --- a/arch/arm/boot/dts/nxp/imx/imx6qdl-kontron-samx6i.dtsi
> +++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-kontron-samx6i.dtsi
> @@ -149,7 +149,7 @@ lcd_backlight: lcd-backlight {
>  		status = "disabled";
>  	};
>  
> -	i2c_intern: i2c-gpio-intern {
> +	i2c_intern: i2c-0 {
>  		compatible = "i2c-gpio";
>  		pinctrl-names = "default";
>  		pinctrl-0 = <&pinctrl_i2c_gpio_intern>;
> @@ -160,7 +160,7 @@ i2c_intern: i2c-gpio-intern {
>  		#size-cells = <0>;
>  	};
>  
> -	i2c_lcd: i2c-gpio-lcd {
> +	i2c_lcd: i2c-1 {
>  		compatible = "i2c-gpio";
>  		pinctrl-names = "default";
>  		pinctrl-0 = <&pinctrl_i2c_gpio_lcd>;
> @@ -172,7 +172,7 @@ i2c_lcd: i2c-gpio-lcd {
>  		status = "disabled";
>  	};
>  
> -	i2c_cam: i2c-gpio-cam {
> +	i2c_cam: i2c-2 {
>  		compatible = "i2c-gpio";
>  		pinctrl-names = "default";
>  		pinctrl-0 = <&pinctrl_i2c_gpio_cam>;
> @@ -190,7 +190,7 @@ &audmux {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_audmux>;
>  
> -	audmux_ssi1 {
> +	mux-ssi1 {
>  		fsl,audmux-port = <MX51_AUDMUX_PORT1_SSI0>;
>  		fsl,port-config = <
>  			(IMX_AUDMUX_V2_PTCR_TFSEL(MX51_AUDMUX_PORT3) |
> @@ -202,7 +202,7 @@ IMX_AUDMUX_V2_PDCR_RXDSEL(MX51_AUDMUX_PORT3)
>  		>;
>  	};
>  
> -	audmux_adu3 {
> +	mux-aud3 {
>  		fsl,audmux-port = <MX51_AUDMUX_PORT3>;
>  		fsl,port-config = <
>  			IMX_AUDMUX_V2_PTCR_SYN
> @@ -210,7 +210,7 @@ IMX_AUDMUX_V2_PDCR_RXDSEL(MX51_AUDMUX_PORT1_SSI0)
>  		>;
>  	};
>  
> -	audmux_ssi2 {
> +	mux-ssi2 {
>  		fsl,audmux-port = <MX51_AUDMUX_PORT2_SSI1>;
>  		fsl,port-config = <
>  			(IMX_AUDMUX_V2_PTCR_TFSEL(MX51_AUDMUX_PORT4) |
> @@ -222,7 +222,7 @@ IMX_AUDMUX_V2_PDCR_RXDSEL(MX51_AUDMUX_PORT4)
>  		>;
>  	};
>  
> -	audmux_adu4 {
> +	mux-aud4 {
>  		fsl,audmux-port = <MX51_AUDMUX_PORT4>;
>  		fsl,port-config = <
>  			IMX_AUDMUX_V2_PTCR_SYN
> -- 
> 2.39.2
> 


