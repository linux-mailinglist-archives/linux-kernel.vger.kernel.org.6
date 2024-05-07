Return-Path: <linux-kernel+bounces-171643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7D678BE6CE
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 17:01:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58BDC1F23DA5
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 15:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D011161301;
	Tue,  7 May 2024 15:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fKGgycyo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4F115F311;
	Tue,  7 May 2024 15:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715094085; cv=none; b=t+2tcbHACeiDEHWcLJAkWxunU03KQpw0V2VvePF364yHxbJR4+OWP7Eo7VvRLyQoaqAOQFxNj6DwriTThrqs6orXeTy6igfiJ/BhRGIXLaY9sTY043NTn3XLQGnZCaJ7g02vfVW3Q/P56jPrVx/079LuObAHydPd48qTbEtaheY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715094085; c=relaxed/simple;
	bh=k/GIOzSRD0t9yd2KLhhqA2JOci2Tu6txRXl2CqfM/o4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h1uc3ml2yxKvzJL59nMqpWvlHs0oVMirJCWxO7TugBmj9IOcuc79mhgLjxueiAPmlQNPgss3KdCvjFcCceq2tIza+uxgHcbwy3UIEQVdBpgphkNOZwzK//pu/DCUOkioipQGcObhacR39F/FQ806jS9zisBZ/SAsMPV6v4m+jqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fKGgycyo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02064C2BBFC;
	Tue,  7 May 2024 15:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715094085;
	bh=k/GIOzSRD0t9yd2KLhhqA2JOci2Tu6txRXl2CqfM/o4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fKGgycyoEVyXOCvU7yTlRs15Yg50Nh/0yYuCZYPyuyHfRFx+6u80SU1RA4OM7oXf/
	 8njbtgcxYLEpEhwMJ7GPdW+ofcpsLI9erS9bpIoP63boRjizkxQNJTkph19MlTgPgH
	 PyNJsfGfveY4CfztKiHMhQ+n9kk3mTApRDm2ZO+N2SMoDPFgMAdWDNe2jWSsDCX64F
	 0q2w3nohIT/rH+Rclfb3B8qjd47gmftOWLvlUAcL45eXgjeUSWlzXwzaTXDymh7RE7
	 cNf0aex6XMd1ceMpQnv1+9VUOwz/fS5SQEjwePrej7xL9BZT0QPmkra0VOqrgh/Zyv
	 p6tVHPR91+VOQ==
Date: Tue, 7 May 2024 10:01:23 -0500
From: Rob Herring <robh@kernel.org>
To: Ravi Gunasekaran <r-gunasekaran@ti.com>
Cc: nm@ti.com, vigneshr@ti.com, kristo@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, srk@ti.com, rogerq@kernel.org,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] arm64: dts: ti: k3-j722s-evm: Update USB0 and USB1
 configuration for EVM
Message-ID: <20240507150123.GA471367-robh@kernel.org>
References: <20240429120932.11456-1-r-gunasekaran@ti.com>
 <20240429120932.11456-4-r-gunasekaran@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240429120932.11456-4-r-gunasekaran@ti.com>

On Mon, Apr 29, 2024 at 05:39:32PM +0530, Ravi Gunasekaran wrote:
> The GPIO expander on the EVM allows the USB selection for Type-C
> port to either USB0 or USB1 via USB hub. By default, let the Type-C
> port select USB0 via the GPIO expander port P05.
> 
> Enable super-speed on USB1 by updating SerDes0 lane configuration.
> 
> Signed-off-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
> ---
>  arch/arm64/boot/dts/ti/k3-j722s-evm.dts | 58 +++++++++++++++++++++++++
>  arch/arm64/boot/dts/ti/k3-serdes.h      |  7 +++
>  2 files changed, 65 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j722s-evm.dts b/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
> index bf3c246d13d1..ddb4f1f0d92d 100644
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
> @@ -20,6 +22,8 @@
>  		serial2 = &main_uart0;
>  		mmc0 = &sdhci0;
>  		mmc1 = &sdhci1;
> +		usb0 = &usb0;
> +		usb1 = &usb1;

Why is this needed? Doesn't look related?

>  	};
>  
>  	chosen {
> @@ -202,6 +206,12 @@
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
> @@ -301,6 +311,14 @@
>  				  "PCIe0_1L_RC_RSTz", "PCIe0_1L_PRSNT#",
>  				  "ENET1_EXP_SPARE2", "ENET1_EXP_PWRDN",
>  				  "PD_I2ENET1_I2CMUX_SELC_IRQ", "ENET1_EXP_RESETZ";
> +
> +		p05-hog {
> +			/* P05 - USB2.0_MUX_SEL */
> +			gpio-hog;
> +			gpios = <5 GPIO_ACTIVE_LOW>;
> +			output-high;
> +			line-name = "USB2.0_MUX_SEL";
> +		};
>  	};
>  };
>  
> @@ -384,3 +402,43 @@
>  	status = "okay";
>  	bootph-all;
>  };
> +
> +&serdes0_ln_ctrl {
> +	idle-states = <J722S_SERDES0_LANE0_USB>,
> +		      <J722S_SERDES1_LANE0_PCIE0_LANE0>;
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
> diff --git a/arch/arm64/boot/dts/ti/k3-serdes.h b/arch/arm64/boot/dts/ti/k3-serdes.h
> index a011ad893b44..9082abeddcb1 100644
> --- a/arch/arm64/boot/dts/ti/k3-serdes.h
> +++ b/arch/arm64/boot/dts/ti/k3-serdes.h
> @@ -201,4 +201,11 @@
>  #define J784S4_SERDES4_LANE3_USB		0x2
>  #define J784S4_SERDES4_LANE3_IP4_UNUSED		0x3
>  
> +/* J722S */
> +#define J722S_SERDES0_LANE0_USB			0x0
> +#define J722S_SERDES0_LANE0_QSGMII_LANE2	0x1
> +
> +#define J722S_SERDES1_LANE0_PCIE0_LANE0		0x0
> +#define J722S_SERDES1_LANE0_QSGMII_LANE1	0x1
> +
>  #endif /* DTS_ARM64_TI_K3_SERDES_H */
> -- 
> 2.17.1
> 

