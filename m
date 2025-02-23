Return-Path: <linux-kernel+bounces-527568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43B2FA40CAC
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 05:03:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6A2B7A7B21
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 04:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1F8E1D6DB4;
	Sun, 23 Feb 2025 04:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="ZEx5XNFT"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [1.95.21.14])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8F861F5EA;
	Sun, 23 Feb 2025 04:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=1.95.21.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740283416; cv=none; b=PZZk/yhAgPGKRGd/GIknptJGPwnrCZNiF4tpqXI0se53K0VV40+Zqu4Lu+168mD9Z22GS5jfiQk6l92Z245DK9hvUlIg6eOuM2iIOrX2huFm+ujlDsMlVh2ZJL+jEU4lDZZL8UGc6Qvc6oke9doTxKNnyTKkrPKuHyhPmCsylyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740283416; c=relaxed/simple;
	bh=nfWXgAqEYJpJZrZYKtP2v1+tL0HqoQwQS+EghXX7mHs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ApPkEVXP3Yg0Tv3jrrpWb+MfT9JDqa33gIEqy60hsH+hMumD8rBfL+zw6jVp9eJlbVPti1ux4GYl4u5FpbFmnpwbOb841d2de5X3lHLYrPx81VA2InP1HALI35aynXRu2hhF73OGNzznyaiZrivlZN8QxleXRwXR4Rjo/cqqKQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=ZEx5XNFT; arc=none smtp.client-ip=1.95.21.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=JIgRN+3XWpbCfDnE3nN0Ey2Rm2UwEB6WW3O8E2/greM=;
	b=ZEx5XNFTiFbr2pRhIM56TXOExKvgiNVvoa9/oTHwGTqtXcxtydYDRufHTk9p+1
	K8/+114z56brO9VRWxiou3kcDvtHJBpgyNA83/HvdBdysTotDNrtm2cYFDO8zRLG
	O7g5v61Mwp4PcQZuRXoffIT1hcQkIU6n54GdxFmZ3ZYv0=
Received: from dragon (unknown [])
	by gzsmtp2 (Coremail) with SMTP id Ms8vCgAHj_D0nbpnJRTGCQ--.24347S3;
	Sun, 23 Feb 2025 12:03:01 +0800 (CST)
Date: Sun, 23 Feb 2025 12:03:00 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Mathew McBride <matt@traverse.com.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>
Subject: Re: [PATCH] arm64: dts: freescale: ten64: add usb hub definition
Message-ID: <Z7qd9GPGM8+NBioH@dragon>
References: <20250129045352.10728-1-matt@traverse.com.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250129045352.10728-1-matt@traverse.com.au>
X-CM-TRANSID:Ms8vCgAHj_D0nbpnJRTGCQ--.24347S3
X-Coremail-Antispam: 1Uf129KBjvJXoWxGFyUGr45JF1rCr1DKr4fuFg_yoW5XF4kp3
	Z8ursrCrs5XFy7t3W2gF1xtFZ8Ww4rKF93Zr98Jr4UAryDuasrKrnFkr43uF1UXF18Cw4a
	vF4DZry2kFnIg3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UoMKZUUUUU=
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiBBX7ZWe5p-zUGwABsE

On Wed, Jan 29, 2025 at 03:53:52PM +1100, Mathew McBride wrote:
> A device tree binding for the Microchip USB5744 hub controller
> was added in commit 02be19e914b8 ("dt-bindings: usb: Add support
> for Microchip usb5744 hub controller").
> 
> U-Boot will consume this binding in order to perform the
> necessary actions to enable the USB hub ports over I2C.
> (We previously used our own out-of-tree driver for
> this task)
> 
> The Ten64 board does not have any switchable supplies
> for the voltage rails utilized by the USB5744, so a
> pair of dummy supplies have been added to facilitate
> operation with U-Boot's hub driver.
> 
> Signed-off-by: Mathew McBride <matt@traverse.com.au>
> ---
>  .../boot/dts/freescale/fsl-ls1088a-ten64.dts  | 45 +++++++++++++++++++
>  1 file changed, 45 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a-ten64.dts b/arch/arm64/boot/dts/freescale/fsl-ls1088a-ten64.dts
> index bc0d89427fbe5..fc15c83d222f6 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1088a-ten64.dts
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a-ten64.dts
> @@ -87,6 +87,22 @@ sfp_xg1: dpmac1-sfp {
>  		los-gpios = <&sfpgpio 7 GPIO_ACTIVE_HIGH>;
>  		maximum-power-milliwatt = <2000>;
>  	};
> +
> +	usb1v2_supply: regulator {
> +		compatible = "regulator-fixed";
> +		regulator-name = "usbhub_1v2";
> +		regulator-min-microvolt = <1200000>;
> +		regulator-max-microvolt = <1200000>;
> +		regulator-always-on;
> +	};
> +
> +	system3v3_supply: regulator {

Same node name for two regulators above?  Won't kernel complain?

> +		compatible = "regulator-fixed";
> +		regulator-name = "system_3v3";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		regulator-always-on;
> +	};
>  };
>  
>  /* XG1 - Upper SFP */
> @@ -231,6 +247,12 @@ at97sc: tpm@29 {
>  		compatible = "atmel,at97sc3204t";
>  		reg = <0x29>;
>  	};
> +
> +	usbhub: usb-hub@2d {
> +		compatible = "microchip,usb5744";
> +		reg = <0x2d>;
> +	};
> +
>  };
>  
>  &i2c2 {
> @@ -378,10 +400,33 @@ partition@9400000 {
>  	};
>  };
>  
> +/* LS1088A USB Port 0 - direct to bottom USB-A port */
>  &usb0 {
>  	status = "okay";
>  };
>  
> +/* LS1088A USB Port 1 - to Microchip USB5744 USB Hub */
>  &usb1 {
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +

Nit: unnecessary newline

Shawn

>  	status = "okay";
> +
> +	hub_2_0: hub@1 {
> +		compatible = "usb424,2744";
> +		reg = <1>;
> +		peer-hub = <&hub_3_0>;
> +		i2c-bus = <&usbhub>;
> +		vdd-supply = <&system3v3_supply>;
> +		vdd2-supply = <&usb1v2_supply>;
> +	};
> +
> +	hub_3_0: hub@2 {
> +		compatible = "usb424,5744";
> +		reg = <2>;
> +		peer-hub = <&hub_2_0>;
> +		i2c-bus = <&usbhub>;
> +		vdd-supply = <&system3v3_supply>;
> +		vdd2-supply = <&usb1v2_supply>;
> +	};
>  };
> -- 
> 2.45.1
> 


