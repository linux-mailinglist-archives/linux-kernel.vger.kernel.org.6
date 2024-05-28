Return-Path: <linux-kernel+bounces-192274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 019BF8D1AEE
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 14:18:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8CCB3B2361E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 12:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9286E16D4C5;
	Tue, 28 May 2024 12:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dKeJ4/lG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB2273518;
	Tue, 28 May 2024 12:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716898712; cv=none; b=X9QQmdRO30Gbg0ZBzwo6DAStUA5uYdnJK8qiqm94HIcXoWJwdneh4XYniU4v3I+Mtxfe+IhJjOw2HpSdYVGmdr4dNLe8eve/A5TqDVwnHLbHsXoBH+Yto1HpTHRJr9t/xj014ndrEExYb0M+TczQMA4UW/c/NiQWNO0i6vsrXUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716898712; c=relaxed/simple;
	bh=31hupY2Vf75zLIZ0a57jYb6eZzS8/M/a9nA5admvZy8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kUnz37uSN1Qo0ToLGpCt2+/lUJXw9iGr1UTNHp+PEULyo+qN5W0XxFNByD+y871MF6CbhOcTW+a1blZlj4TI5Nfp9b+2+x7pjrvoZTU3eccxdfoMhtXhNOBp1fyohs+3QnbvPDHBfuqLxnj+gQ3U93UFiYBbvhfnLnAwlId1AW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dKeJ4/lG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD917C3277B;
	Tue, 28 May 2024 12:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716898711;
	bh=31hupY2Vf75zLIZ0a57jYb6eZzS8/M/a9nA5admvZy8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=dKeJ4/lGsfqPgcLeZR4yds3njJ9bOMat+HdNZfEMwqX7fVte4Oir7WgD0g9pot2VZ
	 jGOzqXE9zIOU5pckpffojahLzYePNhDw9J00ppoVHJ6n7LmERY3ZFGKCQ9KF+8RCrk
	 uWH5bJWG3vivK3a62P+KsPNkHpG6GpteLJJe/iUvXTGCj7lRPSRZRaOOVfK+d35cMg
	 8J7H29bLgefQA5kwTgjQvk1AXUavmcP8T/pWoBbar8nnm5imMR79KlPa5NfdSncp1W
	 hd9fYkcGE7EB8Halav5Rek3eU2hbibTKHUPflTPg/XfircFyKhJt0dOPp73wO+CKvd
	 x7EkD4WwmO7dA==
Message-ID: <db1a0b2d-1bf9-4bd4-98f5-8a38f46d6749@kernel.org>
Date: Tue, 28 May 2024 15:18:25 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/7] arm64: dts: ti: k3-j722s-evm: Update USB0 and USB1
To: Siddharth Vadapalli <s-vadapalli@ti.com>, nm@ti.com, vigneshr@ti.com,
 afd@ti.com, kristo@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, u-kumar1@ti.com, danishanwar@ti.com,
 srk@ti.com
References: <20240524090514.152727-1-s-vadapalli@ti.com>
 <20240524090514.152727-4-s-vadapalli@ti.com>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20240524090514.152727-4-s-vadapalli@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 24/05/2024 12:05, Siddharth Vadapalli wrote:
> From: Ravi Gunasekaran <r-gunasekaran@ti.com>
> 
> The GPIO expander on the EVM allows the USB selection for Type-C
> port to either USB0 or USB1 via USB hub. By default, let the Type-C
> port select USB0 via the GPIO expander port P05.
> 
> Enable super-speed on USB1 by updating SerDes0 lane configuration.
> 
> Signed-off-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> ---
> v2:
> https://lore.kernel.org/r/20240513114443.16350-4-r-gunasekaran@ti.com/
> Changes since v2:
> - Renamed serdes0_ln_ctrl to serdes_ln_ctrl corresponding to the change
>   made in patch 1.
> - Dropped Serdes1 idle-states since it has not yet been added in the
>   serdes_ln_ctrl node.
> - Dropped Serdes1 specific Lane-Muxing macros in "k3-serdes.h".
> - Added newline after /* J722S */ in "k3-serdes.h" following the file
>   convention.
> 
> v1:
> https://lore.kernel.org/r/20240429120932.11456-4-r-gunasekaran@ti.com/
> Changes since v1:
> - Removed USB aliases, line-name property for p05 GPIO hog.
> - Included k3-j722s-main.dtsi.
> 
>  arch/arm64/boot/dts/ti/k3-j722s-evm.dts | 54 +++++++++++++++++++++++++
>  arch/arm64/boot/dts/ti/k3-j722s.dtsi    |  5 +++
>  arch/arm64/boot/dts/ti/k3-serdes.h      |  5 +++
>  3 files changed, 64 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j722s-evm.dts b/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
> index bf3c246d13d1..a3bda39cc223 100644
> --- a/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
> +++ b/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
> @@ -9,7 +9,9 @@
>  /dts-v1/;
>  
>  #include <dt-bindings/net/ti-dp83867.h>
> +#include <dt-bindings/phy/phy.h>
>  #include "k3-j722s.dtsi"
> +#include "k3-serdes.h"
>  
>  / {
>  	compatible = "ti,j722s-evm", "ti,j722s";
> @@ -202,6 +204,12 @@ J722S_IOPAD(0x0130, PIN_OUTPUT, 0) /* (AG26) RGMII1_TXC */
>  			J722S_IOPAD(0x012c, PIN_OUTPUT, 0) /* (AF25) RGMII1_TX_CTL */
>  		>;
>  	};
> +
> +	main_usb1_pins_default: main-usb1-default-pins {
> +		pinctrl-single,pins = <
> +			J722S_IOPAD(0x0258, PIN_INPUT, 0) /* (B27) USB1_DRVVBUS */
> +		>;
> +	};
>  };
>  
>  &cpsw3g {
> @@ -301,6 +309,13 @@ exp1: gpio@23 {
>  				  "PCIe0_1L_RC_RSTz", "PCIe0_1L_PRSNT#",
>  				  "ENET1_EXP_SPARE2", "ENET1_EXP_PWRDN",
>  				  "PD_I2ENET1_I2CMUX_SELC_IRQ", "ENET1_EXP_RESETZ";
> +
> +		p05-hog {
> +			/* P05 - USB2.0_MUX_SEL */
> +			gpio-hog;
> +			gpios = <5 GPIO_ACTIVE_LOW>;
> +			output-high;
> +		};
>  	};
>  };
>  
> @@ -384,3 +399,42 @@ &sdhci1 {
>  	status = "okay";
>  	bootph-all;
>  };
> +
> +&serdes_ln_ctrl {
> +	idle-states = <J722S_SERDES0_LANE0_USB>;
> +};
> +
> +&serdes0 {
> +	status = "okay";
> +	serdes0_usb_link: phy@0 {
> +		reg = <0>;
> +		cdns,num-lanes = <1>;
> +		#phy-cells = <0>;
> +		cdns,phy-type = <PHY_TYPE_USB3>;
> +		resets = <&serdes_wiz0 1>;
> +	};
> +};
> +
> +&usbss0 {
> +	ti,vbus-divider;
> +	status = "okay";
> +};
> +
> +&usb0 {
> +	dr_mode = "otg";
> +	usb-role-switch;
> +};
> +
> +&usbss1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&main_usb1_pins_default>;
> +	ti,vbus-divider;
> +	status = "okay";
> +};
> +
> +&usb1 {
> +	dr_mode = "host";
> +	maximum-speed = "super-speed";
> +	phys = <&serdes0_usb_link>;
> +	phy-names = "cdns3,usb3-phy";
> +};
> diff --git a/arch/arm64/boot/dts/ti/k3-j722s.dtsi b/arch/arm64/boot/dts/ti/k3-j722s.dtsi
> index c75744edb143..61b64fae1bf4 100644
> --- a/arch/arm64/boot/dts/ti/k3-j722s.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j722s.dtsi
> @@ -87,3 +87,8 @@ &oc_sram {
>  	reg = <0x00 0x70000000 0x00 0x40000>;
>  	ranges = <0x00 0x00 0x70000000 0x40000>;
>  };
> +
> +/* Include bus peripherals that are additionally
> + * present in J722S
> + */
> + #include "k3-j722s-main.dtsi"
> diff --git a/arch/arm64/boot/dts/ti/k3-serdes.h b/arch/arm64/boot/dts/ti/k3-serdes.h

The k3-serdes.h changes should be in a separate independent patch.

> index a011ad893b44..e6a036a4e70b 100644
> --- a/arch/arm64/boot/dts/ti/k3-serdes.h
> +++ b/arch/arm64/boot/dts/ti/k3-serdes.h
> @@ -201,4 +201,9 @@
>  #define J784S4_SERDES4_LANE3_USB		0x2
>  #define J784S4_SERDES4_LANE3_IP4_UNUSED		0x3
>  
> +/* J722S */
> +
> +#define J722S_SERDES0_LANE0_USB			0x0
> +#define J722S_SERDES0_LANE0_QSGMII_LANE2	0x1
> +
>  #endif /* DTS_ARM64_TI_K3_SERDES_H */

-- 
cheers,
-roger

