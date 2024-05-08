Return-Path: <linux-kernel+bounces-173191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA14D8BFCC4
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 13:59:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 186D51C21E7C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 11:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF77C82D9F;
	Wed,  8 May 2024 11:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WavizOkh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD87763EE;
	Wed,  8 May 2024 11:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715169567; cv=none; b=jQj6NmruUkRpZwD2ARd430IRp1U6Uh6HfXiUGQpCwdSKBEs3e0jmrfLGX04rZtXpFHYZFj74Au9jE076+mO+g6wyPZE9qgn81V8G2q///V8yCCxvGJg6ruBg6u9R/PWs+8u11369U4qMnbQlTcYDv6WX/ObYmUkdfhO3eHpoHb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715169567; c=relaxed/simple;
	bh=f5KLwZFAJed67Isnwjb2g/lcj37+mpliFwNUVN/9dnw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jMpoTEJawKZfPgPuczZBp/9B55URWaV7skezw2BiGhy2so044FaFFmkkoLtrkYFW4tyPWai6VsqgOMi0NQn79isnQGi2Pi1sY3ucwX0PHd3Dt4PoGl02YM7eaZYXpVMKzeyRRcrLitELryrTUJXOjThdizBdEGy0BeDvr6abtGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WavizOkh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 269D9C113CC;
	Wed,  8 May 2024 11:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715169566;
	bh=f5KLwZFAJed67Isnwjb2g/lcj37+mpliFwNUVN/9dnw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WavizOkhUlsZCIp/Fl5fySFp851j2TxMT6qDySzlkzMSZfLh8+NbdjJNT05b4PnQs
	 VR5yOzH8xbA+pcRRZRiFMsr57XNVYFH8bdvPsl58ODeNIfiPe3Y6rknh2uTwpi5Au9
	 28rWrXXxqfV/gjQf9yKc34jrSsykfV5iB4rtjN3RjKrFSywRSKkwABRX/9umRu9ykl
	 4tsO67eO7ekehpoflTjCFmJKLcCvern4ouMDq44rHIXlONK8dajsLOD0sYgfqooouq
	 i+YBLgmJft2l33TLbFeNx4ube7hk8/3dAiGFktmD2Q5I3XIqHZnS+zBbTH2cEE1CIy
	 njjRzJhC0rCcA==
Message-ID: <41047a89-2787-422f-a643-3e2d850da6dd@kernel.org>
Date: Wed, 8 May 2024 14:59:21 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] arm64: dts: ti: k3-j722s: Add support for SERDES0
To: Ravi Gunasekaran <r-gunasekaran@ti.com>, nm@ti.com, vigneshr@ti.com
Cc: kristo@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, srk@ti.com, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240429120932.11456-1-r-gunasekaran@ti.com>
 <20240429120932.11456-2-r-gunasekaran@ti.com>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20240429120932.11456-2-r-gunasekaran@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 29/04/2024 15:09, Ravi Gunasekaran wrote:
> Add SERDES0 and its wrapper description to support USB3
> and SGMII interfaces.
> 
> Signed-off-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
> ---
>  arch/arm64/boot/dts/ti/k3-j722s.dtsi | 54 ++++++++++++++++++++++++++++
>  1 file changed, 54 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j722s.dtsi b/arch/arm64/boot/dts/ti/k3-j722s.dtsi
> index c75744edb143..beba5a3ea6cc 100644
> --- a/arch/arm64/boot/dts/ti/k3-j722s.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j722s.dtsi
> @@ -9,6 +9,7 @@
>  #include <dt-bindings/interrupt-controller/irq.h>
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>  #include <dt-bindings/soc/ti,sci_pm_domain.h>
> +#include <dt-bindings/phy/phy-ti.h>
>  
>  #include "k3-am62p5.dtsi"
>  
> @@ -75,6 +76,50 @@
>  			 <0x00 0x78000000 0x00 0x78000000 0x00 0x00008000>,
>  			 <0x00 0x78100000 0x00 0x78100000 0x00 0x00008000>;
>  	};
> +
> +	serdes_refclk: clock-cmnrefclk {

What could be the generic name here?

> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <0>;
> +	};
> +
> +	serdes_wiz0: wiz@f000000 {

Should generic name be phy?

> +		compatible = "ti,am64-wiz-10g";
> +		ranges = <0x0f000000 0x0 0x0f000000 0x00010000>;
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		power-domains = <&k3_pds 279 TI_SCI_PD_EXCLUSIVE>;
> +		clocks = <&k3_clks 279 0>, <&k3_clks 279 1>, <&serdes_refclk>;
> +		clock-names = "fck", "core_ref_clk", "ext_ref_clk";
> +		num-lanes = <1>;
> +		#reset-cells = <1>;
> +		#clock-cells = <1>;
> +
> +		assigned-clocks = <&k3_clks 279 1>;
> +		assigned-clock-parents = <&k3_clks 279 5>;
> +
> +		serdes0: serdes@f000000 {

here too?

> +			compatible = "ti,j721e-serdes-10g";
> +			reg = <0x0f000000 0x00010000>;
> +			reg-names = "torrent_phy";
> +			resets = <&serdes_wiz0 0>;
> +			reset-names = "torrent_reset";
> +			clocks = <&serdes_wiz0 TI_WIZ_PLL0_REFCLK>,
> +				 <&serdes_wiz0 TI_WIZ_PHY_EN_REFCLK>;
> +			clock-names = "refclk", "phy_en_refclk";
> +			assigned-clocks = <&serdes_wiz0 TI_WIZ_PLL0_REFCLK>,
> +					  <&serdes_wiz0 TI_WIZ_PLL1_REFCLK>,
> +					  <&serdes_wiz0 TI_WIZ_REFCLK_DIG>;
> +			assigned-clock-parents = <&k3_clks 279 1>,
> +						 <&k3_clks 279 1>,
> +						 <&k3_clks 279 1>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			#clock-cells = <1>;
> +
> +			status = "disabled"; /* Needs lane config */
> +		};
> +	};
>  };
>  
>  /* Main domain overrides */
> @@ -83,6 +128,15 @@
>  	ti,interrupt-ranges = <7 71 21>;
>  };
>  
> +&main_conf {
> +	serdes0_ln_ctrl: mux-controller@4080 {
> +		compatible = "reg-mux";
> +		reg = <0x4080 0x4>;
> +		#mux-control-cells = <1>;
> +		mux-reg-masks = <0x0 0x3>; /* SERDES0 lane0 select */
> +	};
> +};
> +
>  &oc_sram {
>  	reg = <0x00 0x70000000 0x00 0x40000>;
>  	ranges = <0x00 0x00 0x70000000 0x40000>;

-- 
cheers,
-roger

