Return-Path: <linux-kernel+bounces-367530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E36C9A037A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 10:02:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25763280D80
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 08:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A13C1D1E8A;
	Wed, 16 Oct 2024 08:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="N12qOrVn"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [220.197.32.16])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1ABF1C4A2B;
	Wed, 16 Oct 2024 08:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729065751; cv=none; b=eN4NEXTvj2Unrxhxg5UJTzscPnPzh6zodVnYBROKpXK/wjZJ0TBCqc6aW4K0CzimLgeZWwrjJYSl2NiFVVdB73fF5HXHihK+KjlI/QDtoA4Fix4fIErQSRVsYo6YcE+EcC7Xknez0Am5hbTU3LYBOU9WLRDv6jKqMlebTHtdZlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729065751; c=relaxed/simple;
	bh=/8EZ5d33aVstxkBsP37ajT8/LEvDSLg38YMUJYuEIJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R3qjd+5HM8k21G2tQTFS6jSsygDFt3PwrcQ/9BGgfVhD+JCOe2Vusjh+CakI94+pbIZUMQyW254JI6s5hojnZnBtvq5AlyRDGPQX8Eosms5QiHYyxf064WdYeFqrntTaTk/1op+cY5O/QyfBADYb+lF8w/BcWSjR/JV6aR//gOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=N12qOrVn; arc=none smtp.client-ip=220.197.32.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=+kd8E0tUUE88A8KHdSiWw5mBRqTS3PtOuVObV/42bZ8=;
	b=N12qOrVn0038JMV9Qb1PvaHdg0P2yezMX9lp1KGUqX9tiLyBg35+FjqqBZJ5NU
	YW+3Nf8Q1aDGshlhg+CZl4f1DAy7tWuUluHiJJo5mUtpsn4ot2ulQXreTNxmfWlr
	Y8eH+DCQz03UhUJ6J+gZZmjpSIQTUFy5NxwA5xyTp1Hdg=
Received: from dragon (unknown [])
	by gzsmtp1 (Coremail) with SMTP id Mc8vCgDHxAP0cg9n8ngZAA--.391S3;
	Wed, 16 Oct 2024 16:01:58 +0800 (CST)
Date: Wed, 16 Oct 2024 16:01:55 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	shengjiu.wang@gmail.com
Subject: Re: [PATCH v2 1/3] arm64: dts: imx93-9x9-qsb: Enable sound-wm8962
 sound card
Message-ID: <Zw9y84AzNwUhUAhJ@dragon>
References: <1726106381-1138-1-git-send-email-shengjiu.wang@nxp.com>
 <1726106381-1138-2-git-send-email-shengjiu.wang@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1726106381-1138-2-git-send-email-shengjiu.wang@nxp.com>
X-CM-TRANSID:Mc8vCgDHxAP0cg9n8ngZAA--.391S3
X-Coremail-Antispam: 1Uf129KBjvJXoWxGw4kJFWkurWktw18AFW7CFg_yoWrJF1xpr
	9xursagr1FgFyxt3sxX3ZIkrW3Gw4kKr9I9r12vrW8ArsFvasFq345Kr1ruryrGrn5Zw4Y
	yFy5Xry7C3ZIqw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jzc_fUUUUU=
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiCQZ6ZWcPLG3NiQABs8

On Thu, Sep 12, 2024 at 09:59:39AM +0800, Shengjiu Wang wrote:
> Add wm8962 sound card which connects to sai3. The connection
> of SAI3 and wm8962 is controlled by PCAL6524HEAZ module, add
> gpio-hog for it.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
>  .../boot/dts/freescale/imx93-9x9-qsb.dts      | 74 +++++++++++++++++++
>  1 file changed, 74 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx93-9x9-qsb.dts b/arch/arm64/boot/dts/freescale/imx93-9x9-qsb.dts
> index f8a73612fa05..10f3366b8253 100644
> --- a/arch/arm64/boot/dts/freescale/imx93-9x9-qsb.dts
> +++ b/arch/arm64/boot/dts/freescale/imx93-9x9-qsb.dts
> @@ -68,6 +68,15 @@ reg_vref_1v8: regulator-adc-vref {
>  		regulator-max-microvolt = <1800000>;
>  	};
>  
> +	reg_audio_pwr: regulator-audio-pwr {
> +		compatible = "regulator-fixed";
> +		regulator-name = "audio-pwr";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		gpio = <&pcal6524 16 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +	};
> +
>  	reg_rpi_3v3: regulator-rpi {
>  		compatible = "regulator-fixed";
>  		regulator-name = "VDD_RPI_3V3";
> @@ -88,6 +97,22 @@ reg_usdhc2_vmmc: regulator-usdhc2 {
>  		enable-active-high;
>  		off-on-delay-us = <12000>;
>  	};
> +
> +	sound-wm8962 {
> +		compatible = "fsl,imx-audio-wm8962";
> +		model = "wm8962-audio";
> +		audio-cpu = <&sai3>;
> +		audio-codec = <&wm8962>;
> +		hp-det-gpio = <&pcal6524 4 GPIO_ACTIVE_HIGH>;
> +		audio-routing =
> +			"Headphone Jack", "HPOUTL",
> +			"Headphone Jack", "HPOUTR",
> +			"Ext Spk", "SPKOUTL",
> +			"Ext Spk", "SPKOUTR",
> +			"AMIC", "MICBIAS",
> +			"IN3R", "AMIC",
> +			"IN1R", "AMIC";
> +	};
>  };
>  
>  &adc1 {
> @@ -136,6 +161,28 @@ &lpi2c1 {
>  	pinctrl-0 = <&pinctrl_lpi2c1>;
>  	status = "okay";
>  
> +	wm8962: codec@1a {

Can we use audio-codec for node name?

Shawn

> +		compatible = "wlf,wm8962";
> +		reg = <0x1a>;
> +		clocks = <&clk IMX93_CLK_SAI3_GATE>;
> +		DCVDD-supply = <&reg_audio_pwr>;
> +		DBVDD-supply = <&reg_audio_pwr>;
> +		AVDD-supply = <&reg_audio_pwr>;
> +		CPVDD-supply = <&reg_audio_pwr>;
> +		MICVDD-supply = <&reg_audio_pwr>;
> +		PLLVDD-supply = <&reg_audio_pwr>;
> +		SPKVDD1-supply = <&reg_audio_pwr>;
> +		SPKVDD2-supply = <&reg_audio_pwr>;
> +		gpio-cfg = <
> +			0x0000 /* 0:Default */
> +			0x0000 /* 1:Default */
> +			0x0000 /* 2:FN_DMICCLK */
> +			0x0000 /* 3:Default */
> +			0x0000 /* 4:FN_DMICCDAT */
> +			0x0000 /* 5:Default */
> +		>;
> +	};
> +
>  	ptn5110: tcpc@50 {
>  		compatible = "nxp,ptn5110", "tcpci";
>  		reg = <0x50>;
> @@ -194,6 +241,12 @@ pcal6524: gpio@22 {
>  		interrupts = <26 IRQ_TYPE_LEVEL_LOW>;
>  		pinctrl-names = "default";
>  		pinctrl-0 = <&pinctrl_pcal6524>;
> +
> +		exp-sel-hog {
> +			gpio-hog;
> +			gpios = <22 GPIO_ACTIVE_HIGH>;
> +			output-low;
> +		};
>  	};
>  
>  	pmic@25 {
> @@ -286,6 +339,17 @@ &mu2 {
>  	status = "okay";
>  };
>  
> +&sai3 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_sai3>;
> +	assigned-clocks = <&clk IMX93_CLK_SAI3>;
> +	assigned-clock-parents = <&clk IMX93_CLK_AUDIO_PLL>;
> +	assigned-clock-rates = <12288000>;
> +	fsl,sai-mclk-direction-output;
> +	fsl,sai-synchronous-rx;
> +	status = "okay";
> +};
> +
>  &usbotg1 {
>  	dr_mode = "otg";
>  	hnp-disable;
> @@ -443,6 +507,16 @@ MX93_PAD_SD2_RESET_B__GPIO3_IO07	0x31e
>  		>;
>  	};
>  
> +	pinctrl_sai3: sai3grp {
> +		fsl,pins = <
> +			MX93_PAD_GPIO_IO12__SAI3_RX_SYNC		0x31e
> +			MX93_PAD_GPIO_IO18__SAI3_RX_BCLK		0x31e
> +			MX93_PAD_GPIO_IO17__SAI3_MCLK			0x31e
> +			MX93_PAD_GPIO_IO19__SAI3_TX_DATA00		0x31e
> +			MX93_PAD_GPIO_IO20__SAI3_RX_DATA00		0x31e
> +		>;
> +	};
> +
>  	pinctrl_usdhc2_gpio: usdhc2gpiogrp {
>  		fsl,pins = <
>  			MX93_PAD_SD2_CD_B__GPIO3_IO00		0x31e
> -- 
> 2.34.1
> 


