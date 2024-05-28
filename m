Return-Path: <linux-kernel+bounces-192255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E94F8D1ABA
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 14:09:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0727C1F24388
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 12:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3876A16D325;
	Tue, 28 May 2024 12:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GPZENJsp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 788DA71753;
	Tue, 28 May 2024 12:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716898188; cv=none; b=WpGGRNY0Q1/YeokMwVFVJPoQ04tOud82yhL7OgN0wiDRGb2iMXjBIVuehGjUf7mdfV4tsuYMNBXM7q6qx0FVYlazFrzAptUjoYhA5UhlUYphwXvE/AG2x7Epm4XYd6vPLSAkSzI+dpsfacYgxuwyB8rIXab4AJXkYxHJDM7LyMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716898188; c=relaxed/simple;
	bh=fo/eQlCwe1cy2Moyf0G+7NTSc2277UXsnpEILM0Ot2Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Or0HPXvJuT6EM8WK5zx3JO38J2RwO8wHrZfO9r4Nl5Dqfko5ZnAFLIUkVy1Fkc7ZFvYqWDkiF/3/WWu0v15wS9lmTpEhG4IICmTWe4n/HBXdCOa+p9rXESeBUPUYQV88PwPdEveNHlRzdrAULqQZexKQwLnJSXUIUekiB2g+vnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GPZENJsp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 852DEC3277B;
	Tue, 28 May 2024 12:09:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716898188;
	bh=fo/eQlCwe1cy2Moyf0G+7NTSc2277UXsnpEILM0Ot2Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=GPZENJspXF1cekh0/6zssWOaKbbXcox0NfLSFBCBcIxK/1wgrUNW6+B5TpPAQGX37
	 WmbbnwrZFVxHBJh45ajSlXgGdU3MWsYso4WSjnpHInKPd6oslP4kpN9deRlVcT7I7D
	 hbt3c6viLR8Q9E06XPBjB4I5j87pm9iMVEs1gyFL8iaMxqN2qtfAFkHQ8q45NFRDf9
	 vF5i5RKCwx/e9UQ3J1WbZesEsJ6tKhUro9zDP2G+7TuUUfFn1XsivWGii5OJ3RT3AG
	 j/g5fWfnxncasF1FCrGoeEIbGLyuFFPx6ZMblae/jA1hRTca0+EZ2iSauMu71ACdU5
	 2Zm1hHNhcM5NA==
Message-ID: <4774e4c9-55f5-4ce9-9433-86f9ae1bc610@kernel.org>
Date: Tue, 28 May 2024 15:09:41 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/7] arm64: dts: ti: k3-j722s-main: Add support for
 SERDES0
To: Siddharth Vadapalli <s-vadapalli@ti.com>, nm@ti.com, vigneshr@ti.com,
 afd@ti.com, kristo@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, u-kumar1@ti.com, danishanwar@ti.com,
 srk@ti.com
References: <20240524090514.152727-1-s-vadapalli@ti.com>
 <20240524090514.152727-2-s-vadapalli@ti.com>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20240524090514.152727-2-s-vadapalli@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 24/05/2024 12:05, Siddharth Vadapalli wrote:
> From: Ravi Gunasekaran <r-gunasekaran@ti.com>
> 
> AM62P's DT source files are reused for J722S inorder to

inorder/in order

> avoid duplication of nodes. But J722S has additional
> peripherals that are not present in AM62P.
> 
> Introduce a -main.dtsi to define such additional main
> domain peripherals and define the SERDES0 node.
> 
> Signed-off-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> ---
> v2:
> https://lore.kernel.org/r/20240513114443.16350-2-r-gunasekaran@ti.com/
> Changes since v2:
> - Renamed serdes0_ln_ctrl to serdes_ln_ctrl to keep the format
>   consistent across SoCs where a single node is sufficient to
>   represent the Lane-Muxing for all instances of the Serdes.
> 
> v1:
> https://lore.kernel.org/r/20240429120932.11456-2-r-gunasekaran@ti.com/
> Changes since v1:
> - Newly introduced k3-j722s-main.dtsi to add main domain peripherals
>   that are additionally present in J722S.
> - Used generic node names - renamed "clock-cmnrefclk" to "clk-0",
>   "wiz@f000000" to "phy@f000000"
> 
>  arch/arm64/boot/dts/ti/k3-j722s-main.dtsi | 64 +++++++++++++++++++++++
>  1 file changed, 64 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/ti/k3-j722s-main.dtsi
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j722s-main.dtsi b/arch/arm64/boot/dts/ti/k3-j722s-main.dtsi
> new file mode 100644
> index 000000000000..0dac8f1e1291
> --- /dev/null
> +++ b/arch/arm64/boot/dts/ti/k3-j722s-main.dtsi
> @@ -0,0 +1,64 @@
> +// SPDX-License-Identifier: GPL-2.0-only OR MIT
> +/*
> + * Device Tree file for the J722S main domain peripherals
> + * Copyright (C) 2023-2024 Texas Instruments Incorporated - https://www.ti.com/
> + */
> +
> +#include <dt-bindings/phy/phy-ti.h>
> +
> +/ {
> +	serdes_refclk: clk-0 {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <0>;
> +	};
> +};
> +
> +&cbass_main {
> +	serdes_wiz0: phy@f000000 {
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
> +};
> +
> +&main_conf {
> +	serdes_ln_ctrl: mux-controller@4080 {
> +		compatible = "reg-mux";
> +		reg = <0x4080 0x4>;
> +		#mux-control-cells = <1>;
> +		mux-reg-masks = <0x0 0x3>; /* SERDES0 lane0 select */
> +	};
> +};

-- 
cheers,
-roger

