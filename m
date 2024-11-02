Return-Path: <linux-kernel+bounces-393175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A50659B9CCE
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 05:52:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A56A1C2103E
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 04:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE115146D7F;
	Sat,  2 Nov 2024 04:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="ey6APnmd"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [1.95.21.16])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15D4833C9;
	Sat,  2 Nov 2024 04:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=1.95.21.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730523167; cv=none; b=cva+kTSIJr/brdlmq/nrojehb2bzIe5kE/NI0yflxe0AYgGVeXf+xOtZjLUI7oWZ8xvdsfRwe2VswC41dS3WZSwlwNrgtiHdRfX/qtK2py9/T5G1mxs1efpOhk2TsZstBXljNIzFhN3yH6MVj48jDnfPbcom+YPfp8I5tuhaFK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730523167; c=relaxed/simple;
	bh=TccovrnP+QnYKz8ZPKpYN9D6Smk22MYVulrI9Jwa9bQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N7vvFQaZ4JPXppC3zB4tWJg6d0Zg50gHWuXFlQutY/zYhf0bQZGcqUL46Jk6oZzunnuZAMS1mVQIbLzuqtcyNwLaVYFaLxl/Kyu0G/WOU1NfTGUfeojWdZgpD1KV8pHrENWoX6qHP7JykjXhsouqt1JuOnZpdhi8O/mvslHkz5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=ey6APnmd; arc=none smtp.client-ip=1.95.21.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=RSva9Fm4DdnQOzRczihH79KDZgo8W27y6ubCk4Wafgs=;
	b=ey6APnmdNnEpy+lrsiNQtnH+4VQ6EJTlGzJ0QAnqGl4jhsxX7TH6fQzKEvXl25
	BPEMeMh4HG8w+rNOLP/AS2bLlZWXO8hNn8zQgGT5D+lD7y56SWqV+SRjZHTKsfzE
	SHAQLTbVTTFUeQlRjDpQfpxFkbugWsUr9VIsWwSOyszi8=
Received: from dragon (unknown [])
	by gzsmtp1 (Coremail) with SMTP id Mc8vCgA3G6z5ryVno2x3AQ--.14482S3;
	Sat, 02 Nov 2024 12:52:10 +0800 (CST)
Date: Sat, 2 Nov 2024 12:52:08 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Stefan Eichenberger <eichest@gmail.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, francesco.dolcini@toradex.com,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Stefan Eichenberger <stefan.eichenberger@toradex.com>
Subject: Re: [PATCH v1 1/2] arm64: dts: imx8mm-verdin: add single-master
 property to all i2c nodes
Message-ID: <ZyWv+BVp91xYr4UZ@dragon>
References: <20241025095915.22313-1-eichest@gmail.com>
 <20241025095915.22313-2-eichest@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241025095915.22313-2-eichest@gmail.com>
X-CM-TRANSID:Mc8vCgA3G6z5ryVno2x3AQ--.14482S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7Ww1DtrWkCFWfGryUArW5ZFb_yoW8ZFWfpa
	1akrs5trnagF4aqF1DXr1xurZak34rArWkCrWjgry093Z8AFy7XF4UGw4fWr4YgrWUXw4S
	kF1rAr109w4fZ3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jc18PUUUUU=
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiAg6LZWclZYuaowAAs3

On Fri, Oct 25, 2024 at 11:58:02AM +0200, Stefan Eichenberger wrote:
> From: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> 
> By default we expect all i2c nodes to be single-master, we do not have
> any module or carrier board that uses multi-master mode on any i2c
> controller. With this property set, we benefit from optimisations made
> exclusively for single-masters.
> 
> Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi
> index 5fa3959141911..95d5d2333ca1e 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi
> @@ -367,6 +367,7 @@ &i2c1 {
>  	pinctrl-1 = <&pinctrl_i2c1_gpio>;
>  	scl-gpios = <&gpio5 14 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
>  	sda-gpios = <&gpio5 15 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
> +	single-master;

Hmm, I do not see this property is documented in i2c-imx bindings.

Shawn

>  	status = "okay";
>  
>  	pca9450: pmic@25 {
> @@ -561,6 +562,7 @@ &i2c2 {
>  	pinctrl-1 = <&pinctrl_i2c2_gpio>;
>  	scl-gpios = <&gpio5 16 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
>  	sda-gpios = <&gpio5 17 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
> +	single-master;
>  	status = "disabled";
>  };
>  
> @@ -574,6 +576,7 @@ &i2c3 {
>  	pinctrl-1 = <&pinctrl_i2c3_gpio>;
>  	scl-gpios = <&gpio5 18 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
>  	sda-gpios = <&gpio5 19 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
> +	single-master;
>  };
>  
>  /* Verdin I2C_1 */
> @@ -584,6 +587,7 @@ &i2c4 {
>  	pinctrl-1 = <&pinctrl_i2c4_gpio>;
>  	scl-gpios = <&gpio5 20 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
>  	sda-gpios = <&gpio5 21 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
> +	single-master;
>  
>  	gpio_expander_21: gpio-expander@21 {
>  		compatible = "nxp,pcal6416";
> -- 
> 2.43.0
> 


