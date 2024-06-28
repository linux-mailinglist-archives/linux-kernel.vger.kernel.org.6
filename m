Return-Path: <linux-kernel+bounces-233278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E3E2691B521
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 04:40:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81B92B21DF9
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 02:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A9D21AACA;
	Fri, 28 Jun 2024 02:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="fGJNLona"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [220.197.32.16])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AFFE17F8;
	Fri, 28 Jun 2024 02:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719542438; cv=none; b=hHVcOMMnDK71xbBshhDpyZBX8BIESBfoLOl0/GV8CMwKSTApONncpwk7Ejj0djVyG5geFvKm+r5SQapKGH7V71iuGub00eFxEqwhhBYOlh+3R4uo3+kSQrEuUdc6Dz/O7OymGE1ilI/T1dDLE4znOVsWWMYd6pSLVVDPyX38UoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719542438; c=relaxed/simple;
	bh=74dj5OWeDe2N1LLXBqrERSuPwGSNMZQpqkVO1KRNPrQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BwEjqsTfzY2IuQmdURyqDePvx9GnXI1SySRWPKc360wGrMgia0XlHpg8D/raU49viYStJ7GuuFA0xqe10CYxK60cq79smtUQ9HoVe+aqppncqPJdxH4QLpanq5uBjkK44yqro7u6m/O9h+/jttfagSYXgxCjpjDTpOfgvfhVJA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=fGJNLona; arc=none smtp.client-ip=220.197.32.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=0GEOf0v7br4hfLswkDuL3KNYPqNgLFgdWMvq96UChp4=;
	b=fGJNLonaHFhaASh0ziDtDROZK0xCloH2/0f63CsFqireU3V/9qfesLyghBDmPy
	6IbXqOsD3X9nhGv1PzLv5cSDzMv3vcA4+zTZO7k1D7dpJEg7nitY5RN12iaNKay5
	Ym5AwMY/e5/0tfO0gyyeyB67adjZOastufCVYJpQuNYIg=
Received: from dragon (unknown [114.218.218.47])
	by gzsmtp1 (Coremail) with SMTP id Mc8vCgD3X4h+In5mbCofAA--.55796S3;
	Fri, 28 Jun 2024 10:40:00 +0800 (CST)
Date: Fri, 28 Jun 2024 10:39:58 +0800
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
Subject: Re: [PATCH v2] arm64: dts: imx8mm-verdin: add TPM device
Message-ID: <Zn4ifj63+OwQPXx7@dragon>
References: <20240627104839.645778-1-ivitro@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240627104839.645778-1-ivitro@gmail.com>
X-CM-TRANSID:Mc8vCgD3X4h+In5mbCofAA--.55796S3
X-Coremail-Antispam: 1Uf129KBjvJXoWxJrW7WFWkJryftw4fWr4Uurg_yoW5Jr4fpr
	sxAr4rJr4xJrsxJ3s0qr47Cr9I9an7ArsF9w1akry8tr1FqFy8tF17Gr4fur4q9FZ5Aw4S
	qF17ZFy8uFnxAw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j1KZXUUUUU=
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiBAAMZWZqryPkjwAAsG

On Thu, Jun 27, 2024 at 11:48:39AM +0100, Vitor Soares wrote:
> From: Vitor Soares <vitor.soares@toradex.com>
> 
> Add TPM device found on Verdin iMX8M Mini PID4 0090 variant.
> 
> While adding the node, rename `pinctrl_pmic_tpm_ena` to
> `pinctrl_tpm_spi_cs`.
> 
> Signed-off-by: Vitor Soares <vitor.soares@toradex.com>
> ---
> v1->v2
>   - rename `pinctrl_pmic_tpm_ena` to `pinctrl_tpm_spi_cs`.
> 
>  .../boot/dts/freescale/imx8mm-verdin.dtsi      | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi
> index 98544741ce17..6e066bd5d982 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi
> @@ -228,15 +228,16 @@ &ecspi2 {
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
> +	pinctrl-0 = <&pinctrl_ecspi3>, <&pinctrl_tpm_spi_cs>;
>  	status = "okay";
>  
> +	/* Verdin CAN_1 */
>  	can1: can@0 {
>  		compatible = "microchip,mcp251xfd";
>  		clocks = <&clk40m>;
> @@ -246,6 +247,12 @@ can1: can@0 {
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
> @@ -808,8 +815,7 @@ &iomuxc {
>  	pinctrl-0 = <&pinctrl_gpio1>, <&pinctrl_gpio2>,
>  		    <&pinctrl_gpio3>, <&pinctrl_gpio4>,
>  		    <&pinctrl_gpio7>, <&pinctrl_gpio8>,
> -		    <&pinctrl_gpio_hog1>, <&pinctrl_gpio_hog2>, <&pinctrl_gpio_hog3>,
> -		    <&pinctrl_pmic_tpm_ena>;
> +		    <&pinctrl_gpio_hog1>, <&pinctrl_gpio_hog2>, <&pinctrl_gpio_hog3>;
>  
>  	pinctrl_can1_int: can1intgrp {
>  		fsl,pins =
> @@ -1111,7 +1117,7 @@ pinctrl_sai5: sai5grp {
>  	};
>  
>  	/* control signal for optional ATTPM20P or SE050 */
> -	pinctrl_pmic_tpm_ena: pmictpmenagrp {
> +	pinctrl_tpm_spi_cs: pmictpmenagrp {

The node name should probably be updated to match pinctrl label?

Shawn

>  		fsl,pins =
>  			<MX8MM_IOMUXC_SAI1_TXD7_GPIO4_IO19		0x106>;	/* PMIC_TPM_ENA */
>  	};
> -- 
> 2.34.1
> 


