Return-Path: <linux-kernel+bounces-373587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16AE69A591F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 05:07:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 372EA1C20D56
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 03:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52D611CF285;
	Mon, 21 Oct 2024 03:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="cZTB1RRg"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [1.95.21.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 027A8171CD;
	Mon, 21 Oct 2024 03:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=1.95.21.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729480017; cv=none; b=Qn9kUR/xWeAXzzuD7Tquk4sTzDim6LxPbMui5oJxpqFDGEMqO5vjrvPpNauuQYLH6GErJ/17cLQWdqJHfABIkmKJm1BdWZ6FGau+8Zo8yW0eCfufKYdu+6GbiajtRwW9SzQaCjt7uXfxVtXhHOSlXynwjplcQOrjDuUdbUiHmu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729480017; c=relaxed/simple;
	bh=zYtdfZSw5YF4y0QM/96J5dPe0gYsKc6BPs5yQgGZo8A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CRP6A4tHma1ENN331hx6su0VPf55686QJ1qMgbNhu/QR0oPkp/LgtxOeiKQwCA2GD+PEGA1UCo7mrar1uPuBdhN5p5Er3Hq+vckA5P3fYFQaT5ftpkN7kq4uBpOSfvjNpLsYWyA5h50exE1sWExe6ZEGArA97r0TsEbzwkSehwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=cZTB1RRg; arc=none smtp.client-ip=1.95.21.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=Pk4wtwi5gon8tDwXcWXIEkO5i3S6GR/L2MzMD+xWLUc=;
	b=cZTB1RRgY59WMnL4/+gFJ5uS4mUnqrneIhVc7aYz3t8W/eFFf9B2Km5UqjIXMj
	GVGz7uG7/p9emYJqCBrI6hLrP3/6EULueofXzUQYBmbhmD60UmbpvqtbQsI/lkFj
	NczyHyN+pVAsN2rJ+86Z0qZ++V8RadCOO8qoZYrBNqQmo=
Received: from dragon (unknown [])
	by gzsmtp3 (Coremail) with SMTP id M88vCgC33c8gxRVni8x9AA--.4490S3;
	Mon, 21 Oct 2024 11:06:10 +0800 (CST)
Date: Mon, 21 Oct 2024 11:06:08 +0800
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
Subject: Re: [PATCH 6/6] arm64: dts: imx8qxp-mek: add cm4 and related nodes
Message-ID: <ZxXFICl573EOMWQX@dragon>
References: <20240930212604.118756-1-Frank.Li@nxp.com>
 <20240930212604.118756-6-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240930212604.118756-6-Frank.Li@nxp.com>
X-CM-TRANSID:M88vCgC33c8gxRVni8x9AA--.4490S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7KF1fJr1kAr1xtryrJFyrJFb_yoW8Kw1Upr
	yvkayrWFWIkF17G3s8XF1DCr15JanYkFWv9r9rCrWjkrZFyrnxt3WfGw1fur4UXr4UAwsF
	vFn2qFy0kwnrJ3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j55rcUUUUU=
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiERd-ZWcVuw0gAAABs5

On Mon, Sep 30, 2024 at 05:26:03PM -0400, Frank Li wrote:
> Add cm4 and related nodes.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8qxp-mek.dts | 61 +++++++++++++++++++
>  1 file changed, 61 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts b/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
> index bbb94adfd64f0..83e8393a34a0c 100644
> --- a/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
> @@ -21,6 +21,21 @@ chosen {
>  		stdout-path = &lpuart0;
>  	};
>  
> +	imx8x_cm4: imx8x_cm4 {

Hyphen instead of underscore in node name.

> +		compatible = "fsl,imx8qxp-cm4";
> +		mbox-names = "tx", "rx", "rxdb";
> +		mboxes = <&lsio_mu5 0 1
> +			  &lsio_mu5 1 1
> +			  &lsio_mu5 3 1>;
> +		memory-region = <&vdevbuffer>, <&vdev0vring0>, <&vdev0vring1>,
> +				<&vdev1vring0>, <&vdev1vring1>, <&rsc_table>;
> +		power-domains = <&pd IMX_SC_R_M4_0_PID0>,
> +				<&pd IMX_SC_R_M4_0_MU_1A>;
> +		fsl,entry-address = <0x34fe0000>;
> +		fsl,resource-id = <IMX_SC_R_M4_0_PID0>;
> +		status = "okay";
> +	};
> +
>  	memory@80000000 {
>  		device_type = "memory";
>  		reg = <0x00000000 0x80000000 0 0x40000000>;
> @@ -85,6 +100,48 @@ reg_usb_otg1_vbus: regulator-usbotg1-vbus {
>  		enable-active-high;
>  	};
>  
> +	reserved-memory {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		vdev0vring0: memory@90000000 {
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
> +		rsc_table: memory@900ff000 {
> +			reg = <0 0x900ff000 0 0x1000>;
> +			no-map;
> +		};
> +
> +		vdevbuffer: memory@90400000 {
> +                        compatible = "shared-dma-pool";

Use tabs instead of spaces for indent.

> +			reg = <0 0x90400000 0 0x100000>;
> +			no-map;
> +		};
> +
> +		gpu_reserved: gpu_reserved@880000000 {

"memory" for node name?

Shawn

> +			no-map;
> +			reg = <0x8 0x80000000 0 0x10000000>;
> +		};
> +	};
> +
>  	sound-bt-sco {
>  		compatible = "simple-audio-card";
>  		simple-audio-card,bitclock-inversion;
> @@ -407,6 +464,10 @@ &lpuart3 {
>  	status = "okay";
>  };
>  
> +&lsio_mu5 {
> +	status = "okay";
> +};
> +
>  &mu_m0 {
>  	status = "okay";
>  };
> -- 
> 2.34.1
> 


