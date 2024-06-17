Return-Path: <linux-kernel+bounces-216579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 176A490A1BD
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 03:25:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3BFD1F217F6
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 01:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6155134BD;
	Mon, 17 Jun 2024 01:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="lUtLWQRN"
Received: from mail-177132.yeah.net (mail-177132.yeah.net [123.58.177.132])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9553D51D;
	Mon, 17 Jun 2024 01:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=123.58.177.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718587514; cv=none; b=YkcLJ4rAK/MLpSmN9mZLPu3rXePwdoWsgjrLJyKO02JbIdDXdLJtpGifPxF5r/AT5O4zaWSM3Xg0RQNVCwv3znkeW/sk9s4M9VHXCC9OZ1x9b47JtCPKm+4VQOUiEoMHIj2e5Oqg+dppKpJuBClaSPWXGzmg6TZsj4Ck/YLr5J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718587514; c=relaxed/simple;
	bh=v2WyN5hsd/SDOOWKMgtEcNSlCk38BGFecwfqBqSHfyM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RfWaUNAdvpsDMn74oSfiZl19aBXyfAA2hkRaHfU8Omm5Tchif1IfWTrmdEMzhRWs/AuhhTf6yBF8U7x/fIVHFoTAap4UDHZlU+T7ljdkgl4pJFb4YMiL/s5uELsfcVpVy7VtiYcGknUdlksiSYNDdkW7WcLWFDin5M1sTE4bj1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=lUtLWQRN; arc=none smtp.client-ip=123.58.177.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=xGIE5wxMU/VErauUWUxFIqCNjSnwPNhIWMkm5TpYWDc=;
	b=lUtLWQRNvbsKf/kfKMHOPjDpS8FFyE+XPBcffc4fEvxeZg5URJYrIv0HisK2cc
	IXBu2uqdfEW7OQa15QjrxrDNkYFbcv5w29iHGdIQEmO4oPbwdIKdaCSdghE5S7YG
	oltIkvi3HqReuEZlkTIADT1kKJj6/uBVDMgvvo+HuaU/k=
Received: from dragon (unknown [114.216.76.201])
	by smtp2 (Coremail) with SMTP id C1UQrACH7hdikG9mH0nNCA--.3602S3;
	Mon, 17 Jun 2024 09:24:52 +0800 (CST)
Date: Mon, 17 Jun 2024 09:24:50 +0800
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
Subject: Re: [PATCH 1/1] arm64: dts: imx8dxl-evk: add imx8dxl_cm4, lsio mu5,
 related memory region
Message-ID: <Zm+QYpb+FJCGGr2B@dragon>
References: <20240605202703.1220203-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240605202703.1220203-1-Frank.Li@nxp.com>
X-CM-TRANSID:C1UQrACH7hdikG9mH0nNCA--.3602S3
X-Coremail-Antispam: 1Uf129KBjvJXoWxJr4ftw15XryUGF4xJw4fZrb_yoW8tr4fpr
	90ka15WFZ2vF17G3sxJr4DKrn8Jan5CFykury7CrW0krWaqrnrKw13Gr4fGr4DJF4UJwsI
	vFnFvFy2kwnIg3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j1KZXUUUUU=
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiDw0BZVnxc0xPZwACsb

On Wed, Jun 05, 2024 at 04:27:03PM -0400, Frank Li wrote:
> Add imx8dxl_cm4, lsio mu5 and related memory region.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8dxl-evk.dts | 48 +++++++++++++++++++
>  1 file changed, 48 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts b/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
> index 4ac96a0586294..c5e601b98cf8f 100644
> --- a/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
> @@ -24,6 +24,19 @@ chosen {
>  		stdout-path = &lpuart0;
>  	};
>  
> +	imx8dxl-cm4 {
> +		compatible = "fsl,imx8qxp-cm4";
> +		clocks = <&clk_dummy>;
> +		mbox-names = "tx", "rx", "rxdb";
> +		mboxes = <&lsio_mu5 0 1 &lsio_mu5 1 1 &lsio_mu5 3 1>;
> +		memory-region = <&vdevbuffer>, <&vdev0vring0>, <&vdev0vring1>,
> +				<&vdev1vring0>, <&vdev1vring1>, <&rsc_table>;
> +		power-domains = <&pd IMX_SC_R_M4_0_PID0>, <&pd IMX_SC_R_M4_0_MU_1A>;
> +		fsl,resource-id = <IMX_SC_R_M4_0_PID0>;
> +		fsl,entry-address = <0x34fe0000>;
> +	};
> +
> +
>  	memory@80000000 {
>  		device_type = "memory";
>  		reg = <0x00000000 0x80000000 0 0x40000000>;
> @@ -51,6 +64,37 @@ linux,cma {
>  			alloc-ranges = <0 0x98000000 0 0x14000000>;
>  			linux,cma-default;
>  		};
> +
> +		vdev0vring0: memory0@90000000 {
> +			reg = <0 0x90000000 0 0x8000>;
> +			no-map;
> +		};
> +
> +		vdev0vring1: memory@90008000 {
> +			reg = <0 0x90008000 0 0x8000>;
> +			no-map;
> +		};
> +
> +		vdev1vring0: memory@90010000 {
> +			reg = <0 0x90010000 0 0x8000>;
> +			no-map;
> +		};
> +
> +		vdev1vring1: memory@90018000 {
> +			reg = <0 0x90018000 0 0x8000>;
> +			no-map;
> +		};
> +
> +		rsc_table: memory-rsc-table@900ff000 {
> +			reg = <0 0x900ff000 0 0x1000>;
> +			no-map;
> +		};
> +
> +		vdevbuffer: memory-vdevbuffer {

As kernel test robot reported, unit-address is missing here?

Shawn

> +			compatible = "shared-dma-pool";
> +			reg = <0 0x90400000 0 0x100000>;
> +			no-map;
> +		};
>  	};
>  
>  	m2_uart1_sel: regulator-m2uart1sel {
> @@ -505,6 +549,10 @@ &lpuart1 {
>  	status = "okay";
>  };
>  
> +&lsio_mu5 {
> +	status = "okay";
> +};
> +
>  &flexcan2 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_flexcan2>;
> -- 
> 2.34.1
> 


