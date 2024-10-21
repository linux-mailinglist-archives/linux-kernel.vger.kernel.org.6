Return-Path: <linux-kernel+bounces-373585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 339099A5915
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 05:03:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ACFCDB222AB
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 03:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACDDD1CF294;
	Mon, 21 Oct 2024 03:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="Ixuoz/Mc"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [1.95.21.16])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6838A1CF5FF;
	Mon, 21 Oct 2024 03:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=1.95.21.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729479747; cv=none; b=hp56gIlCq0GlYr2KCkQrW0/bu53vWlsvV4DBQ7wAiNIykg7SG1fZagT0ly3qhJ5K0DFYhnujxmFyGvTcAUMiTTR+rBTUTJRx12Q17+WwMfOhYpZ8kjrkdN3PJTpjE5svezMDdXCuHhaVpHa1XpxSm6UfxprQYnBuIRPN7I3TDTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729479747; c=relaxed/simple;
	bh=kSGITymX8G5UYC2kkCP3RnP5xxdpboux5e0YSduEr6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KdYpb1vCtbz4p2PbAEvZX+q6pD6kRMtwjegn6rU/86wbRisjXzs3d6m/LE2T87I2LJPEO6F1YXvrot6jSndIdnCTPwL1HQkdgCWXkxfA4NBQ9liphE8C4jCBV3ELKgQ9xLSatKdMMv2dU3C5FL0CJbbZoBqnVD8YKdI0ijz3HhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=Ixuoz/Mc; arc=none smtp.client-ip=1.95.21.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=lCfnNg7FzLSSkzFpo65zrxn7J41VejPEALY0vkiWc9s=;
	b=Ixuoz/MclYUvAWnD/zNzreHikRMBa9KIZcM8Fdku7+zymsnRCgcRVlduZhjE6W
	HRm7xFDaBb2/6jkJeCaKQEI4B8o9NJlFVdHAu5mj3NpwckKe40wzAoiRMXQxNMb7
	rmaWTMY3UvXepYV0lUI+AIJ9rImzLz4Vyf+oE3S/iL+vI=
Received: from dragon (unknown [])
	by gzsmtp2 (Coremail) with SMTP id Ms8vCgDXH_kDxBVnEZaAAA--.4531S3;
	Mon, 21 Oct 2024 11:01:25 +0800 (CST)
Date: Mon, 21 Oct 2024 11:01:23 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Frank Li <Frank.Li@nxp.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	"open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <imx@lists.linux.dev>,
	"moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/6] arm64: dts: imx8qxp-mek: add esai, cs42888 and
 related node
Message-ID: <ZxXEA9TdHX5sEoEt@dragon>
References: <20240930212604.118756-1-Frank.Li@nxp.com>
 <20240930212604.118756-2-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240930212604.118756-2-Frank.Li@nxp.com>
X-CM-TRANSID:Ms8vCgDXH_kDxBVnEZaAAA--.4531S3
X-Coremail-Antispam: 1Uf129KBjvJXoWxWFW5uw47Xw1fZrykZr1rtFb_yoWrZF1rp3
	s7JFsakr4ftFW0yw1rtr9xKrWfWws5GF1Duwn3ur10kF92q3saqF1jkwnxurWDtrn5Gw42
	qF9xXry2ka1Dt3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jho7tUUUUU=
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiERd-ZWcVuw0gAAAAs4

On Mon, Sep 30, 2024 at 05:25:59PM -0400, Frank Li wrote:
> Add audio codec cs42888 and related node.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> arch/arm64/boot/dts/freescale/imx8qxp-mek.dtb: esai@59010000: Unevaluated properties are not allowed ('power-domains' was unexpected)
> update binding patch already sent
> https://lore.kernel.org/linux-devicetree/20240927205618.4093591-1-Frank.Li@nxp.com/#R
> ---
>  arch/arm64/boot/dts/freescale/imx8qxp-mek.dts | 84 +++++++++++++++++++
>  1 file changed, 84 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts b/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
> index d8d9e2883caf7..9b9ad389a807a 100644
> --- a/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
> @@ -50,6 +50,13 @@ usb3_data_ss: endpoint {
>  		};
>  	};
>  
> +	reg_audio: regulator-audio {
> +		compatible = "regulator-fixed";
> +		regulator-max-microvolt = <3300000>;
> +		regulator-min-microvolt = <3300000>;
> +		regulator-name = "cs42888_supply";
> +	};
> +
>  	sound-bt-sco {
>  		compatible = "simple-audio-card";
>  		simple-audio-card,bitclock-inversion;
> @@ -69,6 +76,28 @@ btcpu: simple-audio-card,cpu {
>  		};
>  	};
>  
> +	sound-cs42888 {
> +		compatible = "fsl,imx-audio-cs42888";
> +		audio-asrc = <&asrc0>;
> +		audio-codec = <&cs42888>;
> +		audio-cpu = <&esai0>;
> +		audio-routing =
> +			"Line Out Jack", "AOUT1L",
> +			"Line Out Jack", "AOUT1R",
> +			"Line Out Jack", "AOUT2L",
> +			"Line Out Jack", "AOUT2R",
> +			"Line Out Jack", "AOUT3L",
> +			"Line Out Jack", "AOUT3R",
> +			"Line Out Jack", "AOUT4L",
> +			"Line Out Jack", "AOUT4R",
> +			"AIN1L", "Line In Jack",
> +			"AIN1R", "Line In Jack",
> +			"AIN2L", "Line In Jack",
> +			"AIN2R", "Line In Jack";
> +		model = "imx-cs42888";
> +		status = "okay";

Unneeded "okay" status.

> +	};
> +
>  	sound-wm8960 {
>  		compatible = "fsl,imx-audio-wm8960";
>  		model = "wm8960-audio";
> @@ -86,6 +115,15 @@ sound-wm8960 {
>  	};
>  };
>  
> +&amix {
> +	status = "okay";
> +};
> +
> +&asrc0 {
> +	fsl,asrc-rate  = <48000>;

Double space before =

Shawn

> +	status = "okay";
> +};
> +
>  &dsp {
>  	memory-region = <&dsp_reserved>;
>  	status = "okay";
> @@ -95,6 +133,19 @@ &dsp_reserved {
>  	status = "okay";
>  };
>  
> +&esai0 {
> +	assigned-clocks = <&acm IMX_ADMA_ACM_ESAI0_MCLK_SEL>,
> +			<&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_PLL>,
> +			<&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_SLV_BUS>,
> +			<&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_MST_BUS>,
> +			<&esai0_lpcg 0>;
> +	assigned-clock-parents = <&aud_pll_div0_lpcg 0>;
> +	assigned-clock-rates = <0>, <786432000>, <49152000>, <12288000>, <49152000>;
> +	pinctrl-0 = <&pinctrl_esai0>;
> +	pinctrl-names = "default";
> +	status = "okay";
> +};
> +
>  &fec1 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_fec1>;
> @@ -264,6 +315,24 @@ pca6416: gpio@20 {
>  		gpio-controller;
>  		#gpio-cells = <2>;
>  	};
> +
> +	cs42888: audio-codec@48 {
> +		compatible = "cirrus,cs42888";
> +		reg = <0x48>;
> +		clocks = <&mclkout0_lpcg 0>;
> +		clock-names = "mclk";
> +		assigned-clocks = <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_PLL>,
> +				<&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_SLV_BUS>,
> +				<&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_MST_BUS>,
> +				<&mclkout0_lpcg 0>;
> +		assigned-clock-rates = <786432000>, <49152000>, <12288000>, <12288000>;
> +		reset-gpios = <&pca9557_b 1 GPIO_ACTIVE_LOW>;
> +		VA-supply = <&reg_audio>;
> +		VD-supply = <&reg_audio>;
> +		VLC-supply = <&reg_audio>;
> +		VLS-supply = <&reg_audio>;
> +
> +	};
>  };
>  
>  &cm40_intmux {
> @@ -458,6 +527,21 @@ IMX8QXP_ADC_IN0_LSIO_GPIO1_IO10				0xc600004c
>  		>;
>  	};
>  
> +	pinctrl_esai0: esai0grp {
> +		fsl,pins = <
> +			IMX8QXP_ESAI0_FSR_ADMA_ESAI0_FSR           0xc6000040
> +			IMX8QXP_ESAI0_FST_ADMA_ESAI0_FST           0xc6000040
> +			IMX8QXP_ESAI0_SCKR_ADMA_ESAI0_SCKR         0xc6000040
> +			IMX8QXP_ESAI0_SCKT_ADMA_ESAI0_SCKT         0xc6000040
> +			IMX8QXP_ESAI0_TX0_ADMA_ESAI0_TX0           0xc6000040
> +			IMX8QXP_ESAI0_TX1_ADMA_ESAI0_TX1           0xc6000040
> +			IMX8QXP_ESAI0_TX2_RX3_ADMA_ESAI0_TX2_RX3   0xc6000040
> +			IMX8QXP_ESAI0_TX3_RX2_ADMA_ESAI0_TX3_RX2   0xc6000040
> +			IMX8QXP_ESAI0_TX4_RX1_ADMA_ESAI0_TX4_RX1   0xc6000040
> +			IMX8QXP_ESAI0_TX5_RX0_ADMA_ESAI0_TX5_RX0   0xc6000040
> +		>;
> +	};
> +
>  	pinctrl_fec1: fec1grp {
>  		fsl,pins = <
>  			IMX8QXP_ENET0_MDC_CONN_ENET0_MDC			0x06000020
> -- 
> 2.34.1
> 


