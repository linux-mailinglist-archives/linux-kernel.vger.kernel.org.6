Return-Path: <linux-kernel+bounces-216637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBC9A90A278
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 04:34:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 397D8282D9A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 02:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDDE1176FD3;
	Mon, 17 Jun 2024 02:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="S6oB/Ba/"
Received: from mail-177131.yeah.net (mail-177131.yeah.net [123.58.177.131])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8705C1D688;
	Mon, 17 Jun 2024 02:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=123.58.177.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718591653; cv=none; b=Fnvn+ZlxreH5Bjl2y0DYtk8TPRY62iKOirFzWiX6KWNoq3lSe4Hx4X3a8ZHK/P6zRGyhzdmDWP6OQW+RHs9lOk6c5ktJGKMPhRD/sIFFaPNRR2PK3TvV2li3aXOBUhbwgWWxGWbzEvfETjfPZcH4E2h7o8ycvkb/b+kHG7Xno3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718591653; c=relaxed/simple;
	bh=V9HM6dzQX7H+Ch5Ka4DKnWGx6zwlGBrxAc3WbBQ3iGA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eL00CBRA1nkzLPCXMCi95OZMkl5HdsDBhjF3FeHrhtXhb9MzGVFxX2izb5RtbLEwGC4XS1AUAmRhr+KH2Q2Ac4Dcfoae9d/ULGfnx7CvbASQ2wGMUFqSH4+gngGBwEGT2ASrtHSd/t07nZP3fTp5Rul6C52aCdfQTZpsGX8rm/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=S6oB/Ba/; arc=none smtp.client-ip=123.58.177.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=1bnS+76fC/UzI8nw/5kJgwkqUFPO4HRprSEy7Ho7F/g=;
	b=S6oB/Ba/FEoSo+pU5S4OhFaa00pPADNzYc+n1Lcpcg6UbR9tjFqCaK8QrC7B+2
	wQUciZjocIcmHrlvaZOL1GREUjVwcD5LqrIy9G6yrj+hqHzeF3LgcaIRU1/HGfu5
	sSkqsEE757xiNAnM5aevUJVssbu9tsgTR2lyf9zBjs2qI=
Received: from dragon (unknown [114.216.76.201])
	by smtp1 (Coremail) with SMTP id ClUQrAC3_yCOoG9mB1sMCA--.58507S3;
	Mon, 17 Jun 2024 10:33:52 +0800 (CST)
Date: Mon, 17 Jun 2024 10:33:50 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Vitor Soares <ivitro@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Vitor Soares <vitor.soares@toradex.com>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] arm64: dts: imx8mm-verdin: add TPM device
Message-ID: <Zm+gjpsGhzjbEgP8@dragon>
References: <20240613134150.318755-1-ivitro@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240613134150.318755-1-ivitro@gmail.com>
X-CM-TRANSID:ClUQrAC3_yCOoG9mB1sMCA--.58507S3
X-Coremail-Antispam: 1Uf129KBjvJXoWxJrW7Ww1UCFyktw48JF43ZFb_yoW8ZF4Dpr
	s3Crs5Jr4xXFsxAa90qr17Cr9I9an3Ar4q9wnIkry8tw1rXFy0qr17Gr1fur4q9F4rAw4S
	gF18AFy093Z8Aw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jo89_UUUUU=
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiDhABZVszYrukEQAAs+

On Thu, Jun 13, 2024 at 02:41:50PM +0100, Vitor Soares wrote:
> From: Vitor Soares <vitor.soares@toradex.com>
> 
> Add TPM device found on Verdin iMX8M Mini PID4 0090 variant.
> 
> Signed-off-by: Vitor Soares <vitor.soares@toradex.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi
> index 4768b05fd765..c9ae5f0bb526 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi
> @@ -227,15 +227,16 @@ &ecspi2 {
>  	pinctrl-0 = <&pinctrl_ecspi2>;
>  };
>  
> -/* Verdin CAN_1 (On-module) */
> +/* On-module SPI */
>  &ecspi3 {
>  	#address-cells = <1>;
>  	#size-cells = <0>;
> -	cs-gpios = <&gpio5 25 GPIO_ACTIVE_LOW>;
> +	cs-gpios = <&gpio5 25 GPIO_ACTIVE_LOW>, <&gpio4 19 GPIO_ACTIVE_LOW>;
>  	pinctrl-names = "default";
> -	pinctrl-0 = <&pinctrl_ecspi3>;
> +	pinctrl-0 = <&pinctrl_ecspi3>, <&pinctrl_pmic_tpm_ena>;

Would it make more sense to have tpm pinctrl in node tpm@1 below?

Shawn

>  	status = "okay";
>  
> +	/* Verdin CAN_1 */
>  	can1: can@0 {
>  		compatible = "microchip,mcp251xfd";
>  		clocks = <&clk40m>;
> @@ -245,6 +246,12 @@ can1: can@0 {
>  		reg = <0>;
>  		spi-max-frequency = <8500000>;
>  	};
> +
> +	verdin_som_tpm: tpm@1 {
> +		compatible = "atmel,attpm20p", "tcg,tpm_tis-spi";
> +		reg = <0x1>;
> +		spi-max-frequency = <36000000>;
> +	};
>  };
>  
>  /* Verdin ETH_1 (On-module PHY) */
> @@ -807,8 +814,7 @@ &iomuxc {
>  	pinctrl-0 = <&pinctrl_gpio1>, <&pinctrl_gpio2>,
>  		    <&pinctrl_gpio3>, <&pinctrl_gpio4>,
>  		    <&pinctrl_gpio7>, <&pinctrl_gpio8>,
> -		    <&pinctrl_gpio_hog1>, <&pinctrl_gpio_hog2>, <&pinctrl_gpio_hog3>,
> -		    <&pinctrl_pmic_tpm_ena>;
> +		    <&pinctrl_gpio_hog1>, <&pinctrl_gpio_hog2>, <&pinctrl_gpio_hog3>;
>  
>  	pinctrl_can1_int: can1intgrp {
>  		fsl,pins =
> -- 
> 2.34.1
> 


