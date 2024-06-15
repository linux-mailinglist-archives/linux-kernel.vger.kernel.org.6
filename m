Return-Path: <linux-kernel+bounces-215744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A8EC90968F
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 09:35:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7714D1F2301A
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 07:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2B6E17BA9;
	Sat, 15 Jun 2024 07:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="ItY4KuKs"
Received: from mail-177131.yeah.net (mail-177131.yeah.net [123.58.177.131])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C042A13FEE;
	Sat, 15 Jun 2024 07:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=123.58.177.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718436891; cv=none; b=m6pOxBf+BFhOoA0qOaUejDkxq3xjEX0U1LQijvyZmGj6QOxa7INrEhvUXOLtdzEoFSnGQ4JGMauiRXFueQdyC2+5K3V7deMn45YllajpWDkVccHRd8ieSJYlt3eht4XEM1MAwjxICvTq2WHxFca5sD6oS9EOTCH/2S5/Wn6XHhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718436891; c=relaxed/simple;
	bh=traNFPsD0OSWdhWhNH+YM/+QHoruzMtRAGom3oFUD3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dCVdbuApapIVea8bLeXv5/dVbSDtgvS1CeCZG0lPd5KLy1A8EOWbej8P1M8dJqOzY7hD0u6r1H7v7Kgg3+PdTQ27BMZZ9Nfz3izzM2pvZQVR4Nw3ekWnhA/dDSdcjvlBAe4tLzbpRoqR+q8YVTey01K/M9Pi6gAEDeBTHseo8EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=ItY4KuKs; arc=none smtp.client-ip=123.58.177.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=Qf3RN1WnE/NE5Lv+4iMkt0dPuEaZVm2V5AuMT5u6lrU=;
	b=ItY4KuKs/IbXYaZavq516eIkeIsI5rRIXzbm4oZqdudx8s/6oeRUwJlFY57aM1
	Q2JXnLyGiEu99icyCiyjmCgAjegGc/Z/7AKTuTe2g1hCOJW90JgzvOHxE0ZoDn5x
	0WwE/YxX0h1wnQXCZCPjF40tqHCW18TU5vfsq+Qh6tuVM=
Received: from dragon (unknown [114.216.76.201])
	by smtp1 (Coremail) with SMTP id ClUQrAD3f3XwQ21mf6HxBw--.62088S3;
	Sat, 15 Jun 2024 15:34:11 +0800 (CST)
Date: Sat, 15 Jun 2024 15:34:08 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Joy Zou <joy.zou@nxp.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	"open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <imx@lists.linux.dev>,
	"moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: dts: imx93-11x11-evk: reoder lpi2c2 and lpi2c3
 label
Message-ID: <Zm1D8CsF/ggZtQzs@dragon>
References: <20240509015709.3668405-1-joy.zou@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240509015709.3668405-1-joy.zou@nxp.com>
X-CM-TRANSID:ClUQrAD3f3XwQ21mf6HxBw--.62088S3
X-Coremail-Antispam: 1Uf129KBjvJXoW3Gw4UWw4kAFyfKF4rGw4DJwb_yoWxGryrpa
	9xZrsrCrs3AFyfJw45Ga1ak3Z8WrnYkasxuwn5ZFWFyrWUt3ZrJrnFkr4rA3WrJwn7Zw4Y
	vFWI9ryxKFnFg3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j5739UUUUU=
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiDhP+ZVszYrcxsQAAs7

On Thu, May 09, 2024 at 09:57:08AM +0800, Joy Zou wrote:
> Reorder lpi2c2 and lpi2c3 label in alphabetical order.
> 
> Signed-off-by: Joy Zou <joy.zou@nxp.com>
> ---
>  .../boot/dts/freescale/imx93-11x11-evk.dts    | 217 +++++++++---------
>  1 file changed, 105 insertions(+), 112 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
> index d400d85f42a9..6be1eb920c02 100644
> --- a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
> +++ b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
> @@ -105,6 +105,104 @@ &mu2 {
>  	status = "okay";
>  };
>  
> +&lpi2c2 {
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +	clock-frequency = <400000>;
> +	pinctrl-names = "default", "sleep";
> +	pinctrl-0 = <&pinctrl_lpi2c2>;
> +	pinctrl-1 = <&pinctrl_lpi2c2>;
> +	status = "okay";
> +
> +	pcal6524: gpio@22 {
> +		compatible = "nxp,pcal6524";
> +		reg = <0x22>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_pcal6524>;
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +		interrupt-controller;
> +		#interrupt-cells = <2>;
> +		interrupt-parent = <&gpio3>;
> +		interrupts = <27 IRQ_TYPE_LEVEL_LOW>;
> +	};
> +
> +	pmic@25 {
> +		compatible = "nxp,pca9451a";
> +		reg = <0x25>;
> +		interrupt-parent = <&pcal6524>;
> +		interrupts = <11 IRQ_TYPE_EDGE_FALLING>;
> +
> +		regulators {
> +			buck1: BUCK1 {
> +				regulator-name = "BUCK1";
> +				regulator-min-microvolt = <610000>;
> +				regulator-max-microvolt = <950000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +				regulator-ramp-delay = <3125>;
> +			};
> +
> +			buck2: BUCK2 {
> +				regulator-name = "BUCK2";
> +				regulator-min-microvolt = <600000>;
> +				regulator-max-microvolt = <670000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +				regulator-ramp-delay = <3125>;
> +			};
> +
> +			buck4: BUCK4{
> +				regulator-name = "BUCK4";
> +				regulator-min-microvolt = <1620000>;
> +				regulator-max-microvolt = <3400000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			buck5: BUCK5{
> +				regulator-name = "BUCK5";
> +				regulator-min-microvolt = <1620000>;
> +				regulator-max-microvolt = <3400000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			buck6: BUCK6 {
> +				regulator-name = "BUCK6";
> +				regulator-min-microvolt = <1060000>;
> +				regulator-max-microvolt = <1140000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			ldo1: LDO1 {
> +				regulator-name = "LDO1";
> +				regulator-min-microvolt = <1620000>;
> +				regulator-max-microvolt = <1980000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			ldo4: LDO4 {
> +				regulator-name = "LDO4";
> +				regulator-min-microvolt = <800000>;
> +				regulator-max-microvolt = <840000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			ldo5: LDO5 {
> +				regulator-name = "LDO5";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +		};
> +	};
> +};
> +
>  &lpi2c3 {
>  	#address-cells = <1>;
>  	#size-cells = <0>;
> @@ -113,6 +211,13 @@ &lpi2c3 {
>  	pinctrl-0 = <&pinctrl_lpi2c3>;
>  	status = "okay";
>  
> +	pcf2131: rtc@53 {
> +		compatible = "nxp,pcf2131";
> +		reg = <0x53>;
> +		interrupt-parent = <&pcal6524>;
> +		interrupts = <1 IRQ_TYPE_EDGE_FALLING>;
> +	};
> +
>  	ptn5110: tcpc@50 {

The child devices with @unit-address should be order in the
unit-address.

Shawn

>  		compatible = "nxp,ptn5110", "tcpci";
>  		reg = <0x50>;
> @@ -304,118 +409,6 @@ &wdog3 {
>  	status = "okay";
>  };
>  
> -&lpi2c2 {
> -	#address-cells = <1>;
> -	#size-cells = <0>;
> -	clock-frequency = <400000>;
> -	pinctrl-names = "default", "sleep";
> -	pinctrl-0 = <&pinctrl_lpi2c2>;
> -	pinctrl-1 = <&pinctrl_lpi2c2>;
> -	status = "okay";
> -
> -	pcal6524: gpio@22 {
> -		compatible = "nxp,pcal6524";
> -		reg = <0x22>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&pinctrl_pcal6524>;
> -		gpio-controller;
> -		#gpio-cells = <2>;
> -		interrupt-controller;
> -		#interrupt-cells = <2>;
> -		interrupt-parent = <&gpio3>;
> -		interrupts = <27 IRQ_TYPE_LEVEL_LOW>;
> -	};
> -
> -	pmic@25 {
> -		compatible = "nxp,pca9451a";
> -		reg = <0x25>;
> -		interrupt-parent = <&pcal6524>;
> -		interrupts = <11 IRQ_TYPE_EDGE_FALLING>;
> -
> -		regulators {
> -			buck1: BUCK1 {
> -				regulator-name = "BUCK1";
> -				regulator-min-microvolt = <610000>;
> -				regulator-max-microvolt = <950000>;
> -				regulator-boot-on;
> -				regulator-always-on;
> -				regulator-ramp-delay = <3125>;
> -			};
> -
> -			buck2: BUCK2 {
> -				regulator-name = "BUCK2";
> -				regulator-min-microvolt = <600000>;
> -				regulator-max-microvolt = <670000>;
> -				regulator-boot-on;
> -				regulator-always-on;
> -				regulator-ramp-delay = <3125>;
> -			};
> -
> -			buck4: BUCK4{
> -				regulator-name = "BUCK4";
> -				regulator-min-microvolt = <1620000>;
> -				regulator-max-microvolt = <3400000>;
> -				regulator-boot-on;
> -				regulator-always-on;
> -			};
> -
> -			buck5: BUCK5{
> -				regulator-name = "BUCK5";
> -				regulator-min-microvolt = <1620000>;
> -				regulator-max-microvolt = <3400000>;
> -				regulator-boot-on;
> -				regulator-always-on;
> -			};
> -
> -			buck6: BUCK6 {
> -				regulator-name = "BUCK6";
> -				regulator-min-microvolt = <1060000>;
> -				regulator-max-microvolt = <1140000>;
> -				regulator-boot-on;
> -				regulator-always-on;
> -			};
> -
> -			ldo1: LDO1 {
> -				regulator-name = "LDO1";
> -				regulator-min-microvolt = <1620000>;
> -				regulator-max-microvolt = <1980000>;
> -				regulator-boot-on;
> -				regulator-always-on;
> -			};
> -
> -			ldo4: LDO4 {
> -				regulator-name = "LDO4";
> -				regulator-min-microvolt = <800000>;
> -				regulator-max-microvolt = <840000>;
> -				regulator-boot-on;
> -				regulator-always-on;
> -			};
> -
> -			ldo5: LDO5 {
> -				regulator-name = "LDO5";
> -				regulator-min-microvolt = <1800000>;
> -				regulator-max-microvolt = <3300000>;
> -				regulator-boot-on;
> -				regulator-always-on;
> -			};
> -		};
> -	};
> -};
> -
> -&lpi2c3 {
> -	clock-frequency = <400000>;
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&pinctrl_lpi2c3>;
> -	status = "okay";
> -
> -	pcf2131: rtc@53 {
> -		compatible = "nxp,pcf2131";
> -		reg = <0x53>;
> -		interrupt-parent = <&pcal6524>;
> -		interrupts = <1 IRQ_TYPE_EDGE_FALLING>;
> -	};
> -};
> -
>  &iomuxc {
>  	pinctrl_eqos: eqosgrp {
>  		fsl,pins = <
> -- 
> 2.37.1
> 


