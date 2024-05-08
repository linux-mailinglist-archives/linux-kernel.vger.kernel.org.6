Return-Path: <linux-kernel+bounces-173194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D8758BFCCF
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 14:03:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EAFA1C20D75
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 12:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1C59839E3;
	Wed,  8 May 2024 12:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BZWx2BDN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E776763EE;
	Wed,  8 May 2024 12:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715169812; cv=none; b=oiOyXpCQ9nMoatRHR95rVrQqf9hSxC3gbOpFN2GEZ61f0MBb0pVlR8saTHWUjIohgO7jqwK7fhnxTZJ00fANwe+lkU5WPVeHSuN2hipYEtmiXy+1v8BwvMqSbjgIrI1SMaMNqJyq4HX9Ou5IKAfNLd2EnBBX1ypKuWZls3w0gA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715169812; c=relaxed/simple;
	bh=G9vm+y/3FxBulEcuUPrj6ofZoJWbJ5SV0hHmxRZA87U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J95JzmAW4BbrBNDdhbX1bv9lHEkgfBifNIlK9Gd3mpvuU+J1dfwG9/wbOArok49nmBGbCjLX5HVrYKwsW1tjiCJM0H2FquTdCQrcIRjUvnG9P5A+HpX+Bjc+PY5DWJXgjdxbGqAVa8HEfmpIOTEj8x+3pABcnzy9pQqAqY0T1F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BZWx2BDN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA8F5C113CC;
	Wed,  8 May 2024 12:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715169811;
	bh=G9vm+y/3FxBulEcuUPrj6ofZoJWbJ5SV0hHmxRZA87U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=BZWx2BDNuhSR9OsO+3SJcTV7pV9P1fO+kinZHWICmTNRtmAYWq73ovjdA4bIb21NH
	 s5GySs2J0tEgS3Wf439eEtu1p6eFNdiOO6Hp8OcYPhlf2ZkGyOBxRxLzGwNPj404Se
	 S8Uq9Rd2XcsVwYKcOJ06zaGuCQDvK6x+m/BApNJ0+c/7hrksq3ic7e7Hs4qO9pPLeX
	 LOsePl2BZLvArEHnBf45Kooh2eI4+y4Y750ZgSUYzm3Pz2uNDtwxvj8bjVnC+A1OsU
	 tWZiQgkRFqL/2UwRKrDHF1AVCoo1paaogKzAeeL+vuOsmxUFwtoyHUmBsqQF5bYoHZ
	 81NKfvs7GfP3Q==
Message-ID: <2e19a254-58d2-4c27-9c34-2662827ea505@kernel.org>
Date: Wed, 8 May 2024 15:03:26 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] arm64: dts: ti: k3-j722s-evm: Update USB0 and USB1
 configuration for EVM
To: Ravi Gunasekaran <r-gunasekaran@ti.com>, nm@ti.com, vigneshr@ti.com
Cc: kristo@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, srk@ti.com, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240429120932.11456-1-r-gunasekaran@ti.com>
 <20240429120932.11456-4-r-gunasekaran@ti.com>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20240429120932.11456-4-r-gunasekaran@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 29/04/2024 15:09, Ravi Gunasekaran wrote:
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

This line-name is already added in gpio-line-names property above.
Do we really need to add it again?

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

-- 
cheers,
-roger

