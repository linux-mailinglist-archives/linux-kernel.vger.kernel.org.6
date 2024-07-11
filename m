Return-Path: <linux-kernel+bounces-249891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34EEA92F139
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 23:39:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3EA4283632
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 21:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3305819F462;
	Thu, 11 Jul 2024 21:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bt8wYhhR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6633612F385;
	Thu, 11 Jul 2024 21:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720733928; cv=none; b=Cr01HC3t3ogOaa7lKV63gG6blDZMkejYJVikftjPlKBr0GwY/O+Dx1HferHy5UvIZJRbeujTTURUi2AY97FrSasgfPNE5OUnjNM69g25zLNDJ/m+4IHC2YgO6eJ09pDTKwOZITyAfFifOe29XLaSGwC/XURKoKbCMKSrbO7eGK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720733928; c=relaxed/simple;
	bh=mSHQDPosDfKU1D8H0/EEVCf/SnYHDoua5Vn7yYsQoaI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mcuKUIkkqzXeqEXJba4B/pilISja2++KQ/WsbPrmwbSpj0mi26x88gb63HA7FZYL8V4k4B0G+sfeMcxvaPE82W1agYCf3TL4u63Ff4j2h0utEMNiXujki/E/0KF0p9FDzTyvaGRZuhN14HqUBEX/A3oQg8k2gtmhdRdfvvzNq10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bt8wYhhR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6A68C116B1;
	Thu, 11 Jul 2024 21:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720733928;
	bh=mSHQDPosDfKU1D8H0/EEVCf/SnYHDoua5Vn7yYsQoaI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Bt8wYhhRbsosxOUHAr4wDJBsjg3BaM5IZoZjxxYP8i0a4X2nFfm9xppaKEZGRXy3a
	 yNpyUZb53OjU6IIlVGvz9LXD0F59CkCDsvVFl+7RNVwvx2/h9kFzSuXMYnfiaNJYpH
	 lEcEJEzY9RiWHksrSEcs8TGrw5/DhkAYXBWlsPzW9KMIA4jdfm1kVvrO38FxKNkZvk
	 oKiSPNucdCf31BR5MqSSV4+D0bqf/DYnDk9YPFKA7J7kvKO6mua7QM7MTOK/MDjUqN
	 eDFG/jpcnVLMy7awKcKZQ1HdPrqqp2q9eJRjKZnIKqgGQhrA2b1ALt3URP78rCnlHi
	 A3YHVLJ7jPfpQ==
Date: Thu, 11 Jul 2024 15:38:46 -0600
From: Rob Herring <robh@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	Shawn Guo <shawnguo@kernel.org>, linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev
Subject: Re: [PATCH 3/3] arm64: dts: layerscape: move dwc3 usb under glue
 layer node
Message-ID: <20240711213846.GA3049961-robh@kernel.org>
References: <20240710-ls-dwc-v1-0-62f8cbed31d7@nxp.com>
 <20240710-ls-dwc-v1-3-62f8cbed31d7@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240710-ls-dwc-v1-3-62f8cbed31d7@nxp.com>

On Wed, Jul 10, 2024 at 07:02:24PM -0400, Frank Li wrote:
> New usb glue layer driver support enable dma-coherent. So put dwc3 usb node
> under glue layer node and enable dma-coherent.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi | 43 ++++++++++++++++----------
>  1 file changed, 26 insertions(+), 17 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> index 70b8731029c4e..24b937032480f 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> @@ -615,24 +615,33 @@ gpio3: gpio@2320000 {
>  			little-endian;
>  		};
>  
> -		usb0: usb@3100000 {
> -			compatible = "fsl,ls1028a-dwc3", "snps,dwc3";
> -			reg = <0x0 0x3100000 0x0 0x10000>;
> -			interrupts = <GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>;
> -			snps,dis_rxdet_inp3_quirk;
> -			snps,quirk-frame-length-adjustment = <0x20>;
> -			snps,incr-burst-type-adjustment = <1>, <4>, <8>, <16>;
> -			status = "disabled";
> -		};
> +		usb {
> +			compatible = "fsl,ls1028a-dwc3";
> +			#address-cells = <2>;
> +			#size-cells = <2>;
> +			ranges;

No, the existing way is preferred unless you have actual glue/wrapper 
registers. Plus this breaks compatibility.

> +
> +			usb0: usb@3100000 {
> +				compatible = "snps,dwc3";
> +				reg = <0x0 0x3100000 0x0 0x10000>;
> +				interrupts = <GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>;
> +				dma-coherent;
> +				snps,dis_rxdet_inp3_quirk;
> +				snps,quirk-frame-length-adjustment = <0x20>;
> +				snps,incr-burst-type-adjustment = <1>, <4>, <8>, <16>;
> +				status = "disabled";
> +			};

