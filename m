Return-Path: <linux-kernel+bounces-375520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63EEF9A96F4
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 05:24:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D100F1F27058
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 03:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1E97155A21;
	Tue, 22 Oct 2024 03:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="F5B9PhNq"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [1.95.21.14])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DED1154C0D;
	Tue, 22 Oct 2024 03:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=1.95.21.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729567139; cv=none; b=Sf2Dwcp67p+W4P5dm4h4HA2noos0T0wrr2j1X1pNMgmKABA2WMu4z5XNiqvjvheTyLHGgbHQ53pIAx352TMy4Og2A/V3wS9KjPZccN/Wen8U/SB4klHuEpF/ySO6Ihavg3rQulpXcPvRjBH5UmWh3FWPDbLtq8noMp6O9HCoMJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729567139; c=relaxed/simple;
	bh=nW4xnEnEyYTHEkKUHwczimAvTdHtP5AkiqGVzPHfhuU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uB79Xudp8rZ9dZ9Y2BwhHAONQqgWY8Sx4iIhQH7+xbGbDJh+KXscg0vnYq5pHHJIF0Ikjp28QD8iWon6/B6Djlcxac24wcL/l7ybRXh/15ZSgLr2a3zuh4lmxQI7xtif3318uJksltfv8CaPCKUt1O+jtQ1gnnUvsgOe6zNHEe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=F5B9PhNq; arc=none smtp.client-ip=1.95.21.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=oB/fHC+aiXn3WeNwFrHrgGUyYmbLHSkjwrpCisCyaGo=;
	b=F5B9PhNqs62fumY0yFnFzSIVr9xLIIbT63HBF0NvxvSS0wedDA4/lw4+zKin2p
	tE+iP861jBluqOcxYP+8IDBlG05JwxrqME9ZA3QhnMAfsyNjpsrTXRQvoWAxoNUT
	FIsAy0OByRPnEnuK5nt/zvy4uL2B9nkunZejK5VoSzq3w=
Received: from dragon (unknown [])
	by gzsmtp2 (Coremail) with SMTP id Ms8vCgBnosh4GRdniMyWAA--.5638S3;
	Tue, 22 Oct 2024 11:18:18 +0800 (CST)
Date: Tue, 22 Oct 2024 11:18:16 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	shengjiu.wang@gmail.com
Subject: Re: [PATCH 1/3] arm64: dts: imx8ulp: Add audio device nodes
Message-ID: <ZxcZeC8cZqG2rIxB@dragon>
References: <1729072591-10439-1-git-send-email-shengjiu.wang@nxp.com>
 <1729072591-10439-2-git-send-email-shengjiu.wang@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1729072591-10439-2-git-send-email-shengjiu.wang@nxp.com>
X-CM-TRANSID:Ms8vCgBnosh4GRdniMyWAA--.5638S3
X-Coremail-Antispam: 1Uf129KBjvJXoW3ZFW8Zr17GF4kXr1Uuw4rZrb_yoWDCF48pw
	1UCrW3Wrnagr9Fka12gF4kCF1rJ34vkryq93ZFkrW0yFZFgrnIvr47KwnYgF13Krs7XFyf
	Jr129ryfJFnxWaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j40PfUUUUU=
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiBAmAZWcXEdodTAAAsC

On Wed, Oct 16, 2024 at 05:56:29PM +0800, Shengjiu Wang wrote:
> Add edma1, sai4, sai5 device nodes bus of in per_bridge3.
> Add edma2, sai6, sai7, spdif device nodes in bus of
> per_bridge5.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8ulp.dtsi | 214 +++++++++++++++++++++
>  1 file changed, 214 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi b/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
> index e32d5afcf4a9..3223f1ac2051 100644
> --- a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
> @@ -212,6 +212,71 @@ per_bridge3: bus@29000000 {
>  			#size-cells = <1>;
>  			ranges;
>  
> +			edma1: dma-controller@29010000 {
> +				compatible = "fsl,imx8ulp-edma";
> +				reg = <0x29010000 0x210000>;
> +				#dma-cells = <3>;
> +				dma-channels = <32>;
> +				interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
> +					     <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>,
> +					     <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>,
> +					     <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
> +					     <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
> +					     <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>,
> +					     <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
> +					     <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>,
> +					     <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
> +					     <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>,
> +					     <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>,
> +					     <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>,
> +					     <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>,
> +					     <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>,
> +					     <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>,
> +					     <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>,
> +					     <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>,
> +					     <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>,
> +					     <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>,
> +					     <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>,
> +					     <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>,
> +					     <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>,
> +					     <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>,
> +					     <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>,
> +					     <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>,
> +					     <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>,
> +					     <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>,
> +					     <GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH>,
> +					     <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>,
> +					     <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>,
> +					     <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>,
> +					     <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&pcc3 IMX8ULP_CLK_DMA1_MP>,
> +					<&pcc3 IMX8ULP_CLK_DMA1_CH0>, <&pcc3 IMX8ULP_CLK_DMA1_CH1>,
> +					<&pcc3 IMX8ULP_CLK_DMA1_CH2>, <&pcc3 IMX8ULP_CLK_DMA1_CH3>,
> +					<&pcc3 IMX8ULP_CLK_DMA1_CH4>, <&pcc3 IMX8ULP_CLK_DMA1_CH5>,
> +					<&pcc3 IMX8ULP_CLK_DMA1_CH6>, <&pcc3 IMX8ULP_CLK_DMA1_CH7>,
> +					<&pcc3 IMX8ULP_CLK_DMA1_CH8>, <&pcc3 IMX8ULP_CLK_DMA1_CH9>,
> +					<&pcc3 IMX8ULP_CLK_DMA1_CH10>, <&pcc3 IMX8ULP_CLK_DMA1_CH11>,
> +					<&pcc3 IMX8ULP_CLK_DMA1_CH12>, <&pcc3 IMX8ULP_CLK_DMA1_CH13>,
> +					<&pcc3 IMX8ULP_CLK_DMA1_CH14>, <&pcc3 IMX8ULP_CLK_DMA1_CH15>,
> +					<&pcc3 IMX8ULP_CLK_DMA1_CH16>, <&pcc3 IMX8ULP_CLK_DMA1_CH17>,
> +					<&pcc3 IMX8ULP_CLK_DMA1_CH18>, <&pcc3 IMX8ULP_CLK_DMA1_CH19>,
> +					<&pcc3 IMX8ULP_CLK_DMA1_CH20>, <&pcc3 IMX8ULP_CLK_DMA1_CH21>,
> +					<&pcc3 IMX8ULP_CLK_DMA1_CH22>, <&pcc3 IMX8ULP_CLK_DMA1_CH23>,
> +					<&pcc3 IMX8ULP_CLK_DMA1_CH24>, <&pcc3 IMX8ULP_CLK_DMA1_CH25>,
> +					<&pcc3 IMX8ULP_CLK_DMA1_CH26>, <&pcc3 IMX8ULP_CLK_DMA1_CH27>,
> +					<&pcc3 IMX8ULP_CLK_DMA1_CH28>, <&pcc3 IMX8ULP_CLK_DMA1_CH29>,
> +					<&pcc3 IMX8ULP_CLK_DMA1_CH30>, <&pcc3 IMX8ULP_CLK_DMA1_CH31>;
> +				clock-names = "dma", "ch00","ch01", "ch02", "ch03",
> +						"ch04", "ch05", "ch06", "ch07",
> +						"ch08", "ch09", "ch10", "ch11",
> +						"ch12", "ch13", "ch14", "ch15",
> +						"ch16", "ch17", "ch18", "ch19",
> +						"ch20", "ch21", "ch22", "ch23",
> +						"ch24", "ch25", "ch26", "ch27",
> +						"ch28", "ch29", "ch30", "ch31";
> +				status = "okay";
> +			};
> +
>  			mu: mailbox@29220000 {
>  				compatible = "fsl,imx8ulp-mu";
>  				reg = <0x29220000 0x10000>;
> @@ -442,6 +507,36 @@ lpuart7: serial@29870000 {
>  				status = "disabled";
>  			};
>  
> +			sai4: sai@29880000 {
> +				compatible = "fsl,imx8ulp-sai";
> +				reg = <0x29880000 0x10000>;
> +				interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&pcc4 IMX8ULP_CLK_SAI4>, <&cgc1 IMX8ULP_CLK_DUMMY>,
> +					 <&cgc1 IMX8ULP_CLK_SAI4_SEL>, <&cgc1 IMX8ULP_CLK_DUMMY>,
> +					 <&cgc1 IMX8ULP_CLK_DUMMY>;
> +				clock-names = "bus", "mclk0", "mclk1", "mclk2", "mclk3";
> +				dmas = <&edma1 67 0 1>, <&edma1 68 0 0>;
> +				dma-names = "rx", "tx";
> +				#sound-dai-cells = <0>;
> +				fsl,dataline = <0 0x03 0x03>;
> +				status = "disabled";
> +			};
> +
> +			sai5: sai@29890000 {
> +				compatible = "fsl,imx8ulp-sai";
> +				reg = <0x29890000 0x10000>;
> +				interrupts = <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&pcc4 IMX8ULP_CLK_SAI5>, <&cgc1 IMX8ULP_CLK_DUMMY>,
> +					 <&cgc1 IMX8ULP_CLK_SAI5_SEL>, <&cgc1 IMX8ULP_CLK_DUMMY>,
> +					 <&cgc1 IMX8ULP_CLK_DUMMY>;
> +				clock-names = "bus", "mclk0", "mclk1", "mclk2", "mclk3";
> +				dmas = <&edma1 69 0 1>, <&edma1 70 0 0>;
> +				dma-names = "rx", "tx";
> +				#sound-dai-cells = <0>;
> +				fsl,dataline = <0 0x0f 0x0f>;
> +				status = "disabled";
> +			};
> +
>  			iomuxc1: pinctrl@298c0000 {
>  				compatible = "fsl,imx8ulp-iomuxc1";
>  				reg = <0x298c0000 0x10000>;
> @@ -614,6 +709,71 @@ per_bridge5: bus@2d800000 {
>  			#size-cells = <1>;
>  			ranges;
>  
> +			edma2: dma-controller@2d800000 {
> +				compatible = "fsl,imx8ulp-edma";
> +				reg = <0x2d800000 0x210000>;
> +				#dma-cells = <3>;
> +				dma-channels = <32>;
> +				interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>,
> +					     <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>,
> +					     <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>,
> +					     <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>,
> +					     <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>,
> +					     <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>,
> +					     <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>,
> +					     <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>,
> +					     <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>,
> +					     <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>,
> +					     <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>,
> +					     <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>,
> +					     <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>,
> +					     <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>,
> +					     <GIC_SPI 46 IRQ_TYPE_LEVEL_HIGH>,
> +					     <GIC_SPI 47 IRQ_TYPE_LEVEL_HIGH>,
> +					     <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>,
> +					     <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>,
> +					     <GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH>,
> +					     <GIC_SPI 51 IRQ_TYPE_LEVEL_HIGH>,
> +					     <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>,
> +					     <GIC_SPI 53 IRQ_TYPE_LEVEL_HIGH>,
> +					     <GIC_SPI 54 IRQ_TYPE_LEVEL_HIGH>,
> +					     <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>,
> +					     <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>,
> +					     <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>,
> +					     <GIC_SPI 58 IRQ_TYPE_LEVEL_HIGH>,
> +					     <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>,
> +					     <GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH>,
> +					     <GIC_SPI 61 IRQ_TYPE_LEVEL_HIGH>,
> +					     <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>,
> +					     <GIC_SPI 63 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&pcc5 IMX8ULP_CLK_DMA2_MP>,
> +					<&pcc5 IMX8ULP_CLK_DMA2_CH0>, <&pcc5 IMX8ULP_CLK_DMA2_CH1>,
> +					<&pcc5 IMX8ULP_CLK_DMA2_CH2>, <&pcc5 IMX8ULP_CLK_DMA2_CH3>,
> +					<&pcc5 IMX8ULP_CLK_DMA2_CH4>, <&pcc5 IMX8ULP_CLK_DMA2_CH5>,
> +					<&pcc5 IMX8ULP_CLK_DMA2_CH6>, <&pcc5 IMX8ULP_CLK_DMA2_CH7>,
> +					<&pcc5 IMX8ULP_CLK_DMA2_CH8>, <&pcc5 IMX8ULP_CLK_DMA2_CH9>,
> +					<&pcc5 IMX8ULP_CLK_DMA2_CH10>, <&pcc5 IMX8ULP_CLK_DMA2_CH11>,
> +					<&pcc5 IMX8ULP_CLK_DMA2_CH12>, <&pcc5 IMX8ULP_CLK_DMA2_CH13>,
> +					<&pcc5 IMX8ULP_CLK_DMA2_CH14>, <&pcc5 IMX8ULP_CLK_DMA2_CH15>,
> +					<&pcc5 IMX8ULP_CLK_DMA2_CH16>, <&pcc5 IMX8ULP_CLK_DMA2_CH17>,
> +					<&pcc5 IMX8ULP_CLK_DMA2_CH18>, <&pcc5 IMX8ULP_CLK_DMA2_CH19>,
> +					<&pcc5 IMX8ULP_CLK_DMA2_CH20>, <&pcc5 IMX8ULP_CLK_DMA2_CH21>,
> +					<&pcc5 IMX8ULP_CLK_DMA2_CH22>, <&pcc5 IMX8ULP_CLK_DMA2_CH23>,
> +					<&pcc5 IMX8ULP_CLK_DMA2_CH24>, <&pcc5 IMX8ULP_CLK_DMA2_CH25>,
> +					<&pcc5 IMX8ULP_CLK_DMA2_CH26>, <&pcc5 IMX8ULP_CLK_DMA2_CH27>,
> +					<&pcc5 IMX8ULP_CLK_DMA2_CH28>, <&pcc5 IMX8ULP_CLK_DMA2_CH29>,
> +					<&pcc5 IMX8ULP_CLK_DMA2_CH30>, <&pcc5 IMX8ULP_CLK_DMA2_CH31>;
> +				clock-names = "dma", "ch00","ch01", "ch02", "ch03",
> +						"ch04", "ch05", "ch06", "ch07",
> +						"ch08", "ch09", "ch10", "ch11",
> +						"ch12", "ch13", "ch14", "ch15",
> +						"ch16", "ch17", "ch18", "ch19",
> +						"ch20", "ch21", "ch22", "ch23",
> +						"ch24", "ch25", "ch26", "ch27",
> +						"ch28", "ch29", "ch30", "ch31";
> +				status = "okay";

The "okay" status is usually used to flip "disabled".  It doesn't seem
really needed here?

Shawn

> +			};
> +
>  			cgc2: clock-controller@2da60000 {
>  				compatible = "fsl,imx8ulp-cgc2";
>  				reg = <0x2da60000 0x10000>;
> @@ -626,6 +786,60 @@ pcc5: clock-controller@2da70000 {
>  				#clock-cells = <1>;
>  				#reset-cells = <1>;
>  			};
> +
> +			sai6: sai@2da90000 {
> +				compatible = "fsl,imx8ulp-sai";
> +				reg = <0x2da90000 0x10000>;
> +				interrupts = <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&pcc5 IMX8ULP_CLK_SAI6>, <&cgc1 IMX8ULP_CLK_DUMMY>,
> +					 <&cgc2 IMX8ULP_CLK_SAI6_SEL>, <&cgc1 IMX8ULP_CLK_DUMMY>,
> +					 <&cgc1 IMX8ULP_CLK_DUMMY>;
> +				clock-names = "bus", "mclk0", "mclk1", "mclk2", "mclk3";
> +				dmas = <&edma2 71 0 1>, <&edma2 72 0 0>;
> +				dma-names = "rx", "tx";
> +				#sound-dai-cells = <0>;
> +				fsl,dataline = <0 0x0f 0x0f>;
> +				status = "disabled";
> +			};
> +
> +			sai7: sai@2daa0000 {
> +				compatible = "fsl,imx8ulp-sai";
> +				reg = <0x2daa0000 0x10000>;
> +				interrupts = <GIC_SPI 111 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&pcc5 IMX8ULP_CLK_SAI7>, <&cgc1 IMX8ULP_CLK_DUMMY>,
> +					 <&cgc2 IMX8ULP_CLK_SAI7_SEL>, <&cgc1 IMX8ULP_CLK_DUMMY>,
> +					 <&cgc1 IMX8ULP_CLK_DUMMY>;
> +				clock-names = "bus", "mclk0", "mclk1", "mclk2", "mclk3";
> +				dmas = <&edma2 73 0 1>, <&edma2 74 0 0>;
> +				dma-names = "rx", "tx";
> +				#sound-dai-cells = <0>;
> +				fsl,dataline = <0 0x0f 0x0f>;
> +				status = "disabled";
> +			};
> +
> +			spdif: spdif@2dab0000 {
> +				compatible = "fsl,imx8ulp-spdif";
> +				reg = <0x2dab0000 0x10000>;
> +				interrupts = <GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&pcc5 IMX8ULP_CLK_SPDIF>, /* core */
> +					 <&sosc>, /* 0, extal */
> +					 <&cgc2 IMX8ULP_CLK_SPDIF_SEL>, /* 1, tx */
> +					 <&cgc1 IMX8ULP_CLK_DUMMY>, /* 2, tx1 */
> +					 <&cgc1 IMX8ULP_CLK_DUMMY>, /* 3, tx2 */
> +					 <&cgc1 IMX8ULP_CLK_DUMMY>, /* 4, tx3 */
> +					 <&pcc5 IMX8ULP_CLK_SPDIF>, /* 5, sys */
> +					 <&cgc1 IMX8ULP_CLK_DUMMY>, /* 6, tx4 */
> +					 <&cgc1 IMX8ULP_CLK_DUMMY>, /* 7, tx5 */
> +					 <&cgc1 IMX8ULP_CLK_DUMMY>; /* spba */
> +				clock-names = "core", "rxtx0",
> +					      "rxtx1", "rxtx2",
> +					      "rxtx3", "rxtx4",
> +					      "rxtx5", "rxtx6",
> +					      "rxtx7", "spba";
> +				dmas = <&edma2 75 0 5>, <&edma2 76 0 4>;
> +				dma-names = "rx", "tx";
> +				status = "disabled";
> +			};
>  		};
>  
>  		gpiod: gpio@2e200000 {
> -- 
> 2.34.1
> 


