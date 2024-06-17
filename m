Return-Path: <linux-kernel+bounces-216585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C7B0290A1D7
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 03:40:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 571E9B20BDA
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 01:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 349F6DDD7;
	Mon, 17 Jun 2024 01:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="Y128m9J6"
Received: from mail-177131.yeah.net (mail-177131.yeah.net [123.58.177.131])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE4CBDDC9;
	Mon, 17 Jun 2024 01:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=123.58.177.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718588415; cv=none; b=nyGsCcjuZxw7QnIjve3IAYt3GDET/SxqtemT6VrZd0FQsARIIQ15x3XzfrNd9WKTML+QlXZD/J5bMgYUwO48HOeEF4985docB6qrgRGEc5+okyur4tl8BCFKOeHfYfAj5VSBfArgyxiEtGXZuklSLLcJMlMReI0eOtqIqc4azvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718588415; c=relaxed/simple;
	bh=mo8NWK3LI3GXB4iLfKumtvUmyOfdC4/z2Lb7YlIRRVw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=puz8StY26mOHFsY+Ml9wDoiszJl7Prz0QuYfDS1U44Q9jiPYko/uWQqzQHJLbMfePiS7yxJorD6XF+Fd68hyDjLsNA/IcqXb/+aF8WOaKtyryRo75TT2ktvhGJ7rcDgYjnccnzofSV/cw+5tO8GJvhRgHppgLY5pgmSiyWekwW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=Y128m9J6; arc=none smtp.client-ip=123.58.177.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=IXF2+kt4sMYsgVH9+6vqWl/YEN2B7sy0KnI7bohQIKQ=;
	b=Y128m9J6DK0Vl9LT1TzhYeyzO3s+UAeXo7CdHU1G40j4PUp5rLRqxlQWfToiIC
	mNCs+I7yj0X7DdRDtIH7tygB56D/od6l53yl2XPH5KQZAT+NlxaMlDrGLzI2svb3
	n3C9Vmf9DAq6r/Z1KNuhuOWMsXYo6NdM9FmaKNJK42RoM=
Received: from dragon (unknown [114.216.76.201])
	by smtp1 (Coremail) with SMTP id ClUQrAD3X0_ok29mcJ8LCA--.791S3;
	Mon, 17 Jun 2024 09:39:53 +0800 (CST)
Date: Mon, 17 Jun 2024 09:39:52 +0800
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
Subject: Re: [PATCH v2 03/13] ARM: dts: imx6qdl-kontron-samx6i: fix board
 reset
Message-ID: <Zm+T6HI/ovXq+YjD@dragon>
References: <20240606090206.2021237-1-mwalle@kernel.org>
 <20240606090206.2021237-4-mwalle@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240606090206.2021237-4-mwalle@kernel.org>
X-CM-TRANSID:ClUQrAD3X0_ok29mcJ8LCA--.791S3
X-Coremail-Antispam: 1Uf129KBjvdXoW7GFyUGw45Xw1fAw1kWw15Arb_yoWDKwb_ua
	1xWan5CanYqFyDXryUJr48Gr1akw17XF97t34YvF97GFyavwn3Wa9xKrW0y345Cay5Kr9r
	Aa9xZr4ayFs5CjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU89SdDUUUUU==
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiDg8BZVszYrtxowABsH

On Thu, Jun 06, 2024 at 11:01:56AM +0200, Michael Walle wrote:
> On iMX.6 the board is reset by the watchdog. But in turn to do a

s/iMX.6/i.MX6

Shawn

> complete board reset, we have to assert the WDOG_B output which is
> routed also to the CPLD which then do a complete power-cycle of the
> board.
> 
> Fixes: 2125212785c9 ("ARM: dts: imx6qdl-kontron-samx6i: add Kontron SMARC SoM Support")
> Signed-off-by: Michael Walle <mwalle@kernel.org>
> ---
>  arch/arm/boot/dts/nxp/imx/imx6qdl-kontron-samx6i.dtsi | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-kontron-samx6i.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-kontron-samx6i.dtsi
> index d6c049b9a9c6..700780bf64f5 100644
> --- a/arch/arm/boot/dts/nxp/imx/imx6qdl-kontron-samx6i.dtsi
> +++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-kontron-samx6i.dtsi
> @@ -817,5 +817,6 @@ &wdog1 {
>  	/* CPLD is feeded by watchdog (hardwired) */
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_wdog1>;
> +	fsl,ext-reset-output;
>  	status = "okay";
>  };
> -- 
> 2.39.2
> 


