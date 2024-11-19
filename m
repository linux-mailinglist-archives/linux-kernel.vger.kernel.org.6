Return-Path: <linux-kernel+bounces-414152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F3169D23C3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 11:47:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D30061F22BD6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 10:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8B161C2420;
	Tue, 19 Nov 2024 10:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V9HzU9CY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1243519D890;
	Tue, 19 Nov 2024 10:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732013229; cv=none; b=gYbmiJ7YdhF1p5Ft5RAJjL6IONFBqVgl/DmIH/f9/jDtEYS+1E3i/WLtP1QWbcWQA8MX9T9xkImZv46T/tLGdmcjuN/NaoQP/WDw8p9IbRFauk/zaEO2TKc14rF3a63giYPSNcc5InYZotvfZuUpsPQ/zVTDNdYwB+TdKsX+oSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732013229; c=relaxed/simple;
	bh=h/pAvMzZtkBoYJwCP66IOV31rdv0Z6Es+G+aCCMOw64=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TAz0O0Xc2BztMVO/SXBVC9iN48U5sIYoOWbvU2ZUGyq8SenXMpwVBWX3ib+JbUgvIJ28dv8MGcoDvxw7l97I47+KWXGY+jBTr3xCZNTh8jgk2lCZKJvzMGOH9S9oAueTb4xGMPOXxwOb8jynC+Jo168MvJ5lUqoQRXRA6MDIO+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V9HzU9CY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98183C4CECF;
	Tue, 19 Nov 2024 10:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732013228;
	bh=h/pAvMzZtkBoYJwCP66IOV31rdv0Z6Es+G+aCCMOw64=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=V9HzU9CYql7KGeSek7R11mSaEv0hjU9jRp/299ieLXWFJlzaOZ/phdpLxdebviHBB
	 iwH314vBqtsnyrMwhTuyBks5wS0y2MxUAf6c9/KXqjfjD7MjY1O51hDr78UBlpkoxJ
	 yiMTjSNhyFgH68IMgL64apIpbbrkvG1fdRRbPU3LK+gr3N3AI00TxXXnkKbgxzWAdi
	 bkqPGLzJ/qM/PiG3eo8q0GdBrwPBfN3+eKJwIjAgA9fszmLCXpUZ7FF5/nkxzgfZfO
	 /vpGKC4qRp13Dxn2ObpOcznoN7HJqqpkYjrpqzixwRCd9jsASBJmgLvM3lgQGkzLdM
	 R0TVW+m2trUGg==
Message-ID: <8f3f0fac-d6f7-4962-b2ca-1b3186a74ebe@kernel.org>
Date: Tue, 19 Nov 2024 12:47:03 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] arm64: dts: ti: k3-am64-main: Switch ICSSG clock
 to core clock
To: MD Danish Anwar <danishanwar@ti.com>, conor+dt@kernel.org,
 krzk+dt@kernel.org, robh@kernel.org, ssantosh@kernel.org, nm@ti.com,
 Vignesh Raghavendra <vigneshr@ti.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, s-anna@ti.com, kristo@kernel.org, srk@ti.com
References: <20241113110955.3876045-1-danishanwar@ti.com>
 <20241113110955.3876045-3-danishanwar@ti.com>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20241113110955.3876045-3-danishanwar@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 13/11/2024 13:09, MD Danish Anwar wrote:
> ICSSG has 7 available clocks per instance. Add all the cloks to ICSSG
> nodes. ICSSG currently uses ICSSG_ICLK (clk id 20) which operates at
> 250MHz. Switch ICSSG clock to ICSSG_CORE clock (clk id 0) which operates at
> 333MHz.
> 
> ICSSG_CORE clock will help get the most out of ICSSG as more cycles are
> needed to fully support all ICSSG features.
> 
> This commit also changes assigned-clock-parents of coreclk-mux to
> ICSSG_CORE clock from ICSSG_ICLK.
> 
> Performance update in dual mac mode
>   With ICSSG_CORE Clk @ 333MHz
>     Tx throughput - 934 Mbps
>     Rx throughput - 914 Mbps,
> 
>   With ICSSG_ICLK clk @ 250MHz,
>     Tx throughput - 920 Mbps
>     Rx throughput - 706 Mbps
> 
> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
> ---
>  arch/arm64/boot/dts/ti/k3-am64-main.dtsi | 22 ++++++++++++++++++++--

What about other platforms that have ICSSG?
e.g. k3-am65-main.dtsi and k3-j721e-main.dtsi

>  1 file changed, 20 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
> index c66289a4362b..324eb44c258d 100644
> --- a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
> @@ -1227,6 +1227,15 @@ icssg0: icssg@30000000 {
>  		#address-cells = <1>;
>  		#size-cells = <1>;
>  		ranges = <0x0 0x00 0x30000000 0x80000>;
> +		clocks = <&k3_clks 81 0>,  /* icssg0_core_clk */
> +			 <&k3_clks 81 3>,  /* icssg0_iep_clk */
> +			 <&k3_clks 81 16>, /* icssg0_rgmii_mhz_250_clk */
> +			 <&k3_clks 81 17>, /* icssg0_rgmii_mhz_50_clk */
> +			 <&k3_clks 81 18>, /* icssg0_rgmii_mhz_5_clk */
> +			 <&k3_clks 81 19>, /* icssg0_uart_clk */
> +			 <&k3_clks 81 20>; /* icssg0_iclk */
> +		assigned-clocks = <&k3_clks 81 0>;
> +		assigned-clock-parents = <&k3_clks 81 2>;
>  
>  		icssg0_mem: memories@0 {
>  			reg = <0x0 0x2000>,
> @@ -1252,7 +1261,7 @@ icssg0_coreclk_mux: coreclk-mux@3c {
>  					clocks = <&k3_clks 81 0>,  /* icssg0_core_clk */
>  						 <&k3_clks 81 20>; /* icssg0_iclk */
>  					assigned-clocks = <&icssg0_coreclk_mux>;
> -					assigned-clock-parents = <&k3_clks 81 20>;
> +					assigned-clock-parents = <&k3_clks 81 0>;
>  				};
>  
>  				icssg0_iepclk_mux: iepclk-mux@30 {
> @@ -1397,6 +1406,15 @@ icssg1: icssg@30080000 {
>  		#address-cells = <1>;
>  		#size-cells = <1>;
>  		ranges = <0x0 0x00 0x30080000 0x80000>;
> +		clocks = <&k3_clks 82 0>,  /* icssg1_core_clk */
> +			 <&k3_clks 82 3>,  /* icssg1_iep_clk */
> +			 <&k3_clks 82 16>, /* icssg1_rgmii_mhz_250_clk */
> +			 <&k3_clks 82 17>, /* icssg1_rgmii_mhz_50_clk */
> +			 <&k3_clks 82 18>, /* icssg1_rgmii_mhz_5_clk */
> +			 <&k3_clks 82 19>, /* icssg1_uart_clk */
> +			 <&k3_clks 82 20>; /* icssg1_iclk */
> +		assigned-clocks = <&k3_clks 82 0>;
> +		assigned-clock-parents = <&k3_clks 82 2>;
>  
>  		icssg1_mem: memories@0 {
>  			reg = <0x0 0x2000>,
> @@ -1422,7 +1440,7 @@ icssg1_coreclk_mux: coreclk-mux@3c {
>  					clocks = <&k3_clks 82 0>,   /* icssg1_core_clk */
>  						 <&k3_clks 82 20>;  /* icssg1_iclk */
>  					assigned-clocks = <&icssg1_coreclk_mux>;
> -					assigned-clock-parents = <&k3_clks 82 20>;
> +					assigned-clock-parents = <&k3_clks 82 0>;
>  				};
>  
>  				icssg1_iepclk_mux: iepclk-mux@30 {

-- 
cheers,
-roger


