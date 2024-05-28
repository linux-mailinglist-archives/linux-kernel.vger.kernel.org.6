Return-Path: <linux-kernel+bounces-192295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F9B48D1B31
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 14:26:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A75C282F78
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 12:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61A1616D9C2;
	Tue, 28 May 2024 12:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OeGB3RCI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC5416ABF8;
	Tue, 28 May 2024 12:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716899090; cv=none; b=TyWFJ6/42E1Kj7oeIEOOyYS8ibJ9vM53rvfEh3eAhNucXVoo29JR0Kl1F0wx4yGOEAST04zpbqB8IwLOLYVNFgXZGVbZmOr/zm4mUOP1TZQGdRFpC3/T299A2NaAe5bZIYvH5VZ41q2Pvw/rMfdtJTHEIg6mgGJ2UFEx2GNYN8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716899090; c=relaxed/simple;
	bh=bGw8KMKHVRmOapFybkAxexhS0Pa1gqzL2Blq6dANFuM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GPvMU8U6LaIqMujhUm2IriHW9lFvtlbFEErgQ+zusNSzD5oXIoZBB/lgIfcyl1tPbQf5LRdeKeYyShA2lBB8MqC3YPvPLX/SMbrJfstWJONEAOdR0UQWA1sSABtHW+MW5KEM2PGXErIVrmDwkXSM0g6ervbIHMB9hzloJxPcyj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OeGB3RCI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9B0AC32782;
	Tue, 28 May 2024 12:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716899090;
	bh=bGw8KMKHVRmOapFybkAxexhS0Pa1gqzL2Blq6dANFuM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=OeGB3RCILMPCCCkZYVCYyvdRg6DXioRAXLIhCnT877mHGADTkY2go73JsyOcYoXCQ
	 Yqz8B0q9YiWqTU+x3KKK4WejZRxwY32/j0OynknWYGo2i1D4fJb0zcsoNYUWLO/7A1
	 FC96v0TTnkZIwwEjXrNlhICi4yDqykq83n67+r5rBq2oj/Ds308ThnGPG0QgELVNev
	 uwVFQYhhuEhciba42HkO1BSsb2j4mx4puOFhYbXKbyI4UwIejRxhgH6UQbTufo5XnF
	 Bg1kt4txEZSHp68CqP0HumoCkmrVYHsim/HIOKsu41DwDfHUArnQdcatzEx7JiP73h
	 cSBxcRSeb5zVA==
Message-ID: <c384efac-cca1-4822-a231-1ddb8019c800@kernel.org>
Date: Tue, 28 May 2024 15:24:44 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/7] arm64: dts: ti: k3-j722s-main: Add WIZ1 and
 Serdes1 nodes
To: Siddharth Vadapalli <s-vadapalli@ti.com>, nm@ti.com, vigneshr@ti.com,
 afd@ti.com, kristo@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, u-kumar1@ti.com, danishanwar@ti.com,
 srk@ti.com
References: <20240524090514.152727-1-s-vadapalli@ti.com>
 <20240524090514.152727-7-s-vadapalli@ti.com>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20240524090514.152727-7-s-vadapalli@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 24/05/2024 12:05, Siddharth Vadapalli wrote:
> The Serdes1 instance of Serdes on TI's J722S SoC is a 1 Lane Serdes with
> the WIZ1 instance of the WIZ wrapper used for configuring the Serdes.
> 
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> ---
> Current patch is v1. No changelog.
> 
>  arch/arm64/boot/dts/ti/k3-j722s-main.dtsi | 36 +++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j722s-main.dtsi b/arch/arm64/boot/dts/ti/k3-j722s-main.dtsi
> index 48b77e476c77..19a7e8413ad2 100644
> --- a/arch/arm64/boot/dts/ti/k3-j722s-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j722s-main.dtsi
> @@ -60,6 +60,42 @@ serdes0: serdes@f000000 {
>  		};
>  	};
>  
> +	serdes_wiz1: phy@f010000 {
> +		compatible = "ti,am64-wiz-10g";
> +		ranges = <0x0f010000 0x0 0x0f010000 0x00010000>;
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		power-domains = <&k3_pds 280 TI_SCI_PD_EXCLUSIVE>;
> +		clocks = <&k3_clks 280 0>, <&k3_clks 280 1>, <&serdes_refclk>;
> +		clock-names = "fck", "core_ref_clk", "ext_ref_clk";
> +		num-lanes = <1>;
> +		#reset-cells = <1>;
> +		#clock-cells = <1>;
> +
> +		assigned-clocks = <&k3_clks 280 1>;
> +		assigned-clock-parents = <&k3_clks 280 5>;
> +
> +		serdes1: serdes@f010000 {
> +			compatible = "ti,j721e-serdes-10g";
> +			reg = <0x0f010000 0x00010000>;
> +			reg-names = "torrent_phy";
> +			resets = <&serdes_wiz1 0>;
> +			reset-names = "torrent_reset";
> +			clocks = <&serdes_wiz1 TI_WIZ_PLL0_REFCLK>,
> +				 <&serdes_wiz1 TI_WIZ_PHY_EN_REFCLK>;
> +			clock-names = "refclk", "phy_en_refclk";
> +			assigned-clocks = <&serdes_wiz1 TI_WIZ_PLL0_REFCLK>,
> +					  <&serdes_wiz1 TI_WIZ_PLL1_REFCLK>,
> +					  <&serdes_wiz1 TI_WIZ_REFCLK_DIG>;
> +			assigned-clock-parents = <&k3_clks 280 1>,
> +						 <&k3_clks 280 1>,
> +						 <&k3_clks 280 1>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			#clock-cells = <1>;
> +		};
> +	};
> +

Any particular reason to split addition of various nodes in the k3-j722s-main file?
I think all k3-j722s-main.dtsi additions can be in one patch.

>  	usbss1: usb@f920000 {
>  		compatible = "ti,j721e-usb";
>  		reg = <0x00 0x0f920000 0x00 0x100>;

-- 
cheers,
-roger

