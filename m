Return-Path: <linux-kernel+bounces-198526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A24598D79C5
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 03:26:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10AC0B20E09
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 01:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEEAF3C39;
	Mon,  3 Jun 2024 01:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="IwCaBUTE"
Received: from mail-177131.yeah.net (mail-177131.yeah.net [123.58.177.131])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B08C15C9;
	Mon,  3 Jun 2024 01:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=123.58.177.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717378008; cv=none; b=Z9SgC7o5UzZL2HEJLYcjCZsH4YOTNzegXH3IIpqeKRhgddY9MA4Q76bBERZihQtoNkDsjLv4q4BqWmSKngaEEp0u4z76WJe2nR5uFIxHesaTOvDSfQmn6QvQ4us5xL7KFTAdlW4AHxuPB1Jj6WEzvknofSj4k9TjQj4z3UJ1uek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717378008; c=relaxed/simple;
	bh=oAQOZjN1721oBLN2kzZO4czYq9fxyDyW0Jjo/2sRptk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LXCku/kWz0AgqcH1vLvfk4rMF4o5UZNYspmiGZmfSum2fOitADLr8gCeIpwsJ48xrctOtUpBMqwf2rzkSa33Ve0+9eDjdwMFiYdIl7FE59+q4imQB1+THJ+9DZ05MSgNNKD5NekILgLIKOjUP/Xrt3yNgFQKqTXtg8HwkpqDjPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=IwCaBUTE; arc=none smtp.client-ip=123.58.177.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=3p6a2mmLr0Ufp2i4ny3irKify+zLyTsncj6P14Ac/iU=;
	b=IwCaBUTEybs0WF6dGPqFs0SaMMm4FEVjTMlsjQ1kFAf8f6SUn7scBNTY7MgreY
	Cn+WiHIMNYXfl6aN78z7gSBRjCMw2NeWZAce6dAfTj48ZZZ1lyb40C5Aqoq1w2CF
	7EavP6BpwckQ/5IEi3iqrCh/TmyuQmUHO7euHDR6K4BX8=
Received: from dragon (unknown [114.216.76.201])
	by smtp1 (Coremail) with SMTP id ClUQrADHL_y1G11mea8wBw--.37273S3;
	Mon, 03 Jun 2024 09:26:15 +0800 (CST)
Date: Mon, 3 Jun 2024 09:26:13 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Fabio Aiuto <fabio.aiuto@engicam.com>
Cc: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Matteo Lisi <matteo.lisi@engicam.com>,
	Mirko Ardinghi <mirko.ardinghi@engicam.com>,
	Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH v8 2/3] arm64: dts: imx93: add Engicam i.Core MX93 SoM
Message-ID: <Zl0btePThZM7yqZ6@dragon>
References: <20240429093116.9346-1-fabio.aiuto@engicam.com>
 <20240429093116.9346-3-fabio.aiuto@engicam.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240429093116.9346-3-fabio.aiuto@engicam.com>
X-CM-TRANSID:ClUQrADHL_y1G11mea8wBw--.37273S3
X-Coremail-Antispam: 1Uf129KBjvJXoW3XF4kXFyxGFW5GF4UArWxtFb_yoWfXrW3pr
	ZxZ39rurs7uFyfJa15W3WakF43Gw1jk3s7ur9xXFWrAa4Uu3ZrKr90kr15J3ykAr4DJw1a
	yFWjvF13K3ZrK3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j1KZXUUUUU=
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiFRjyZV6NnNH-SQAAsy

On Mon, Apr 29, 2024 at 11:31:15AM +0200, Fabio Aiuto wrote:
> i.Core MX93 is a NXP i.MX93 based EDIMM SoM by Engicam.
> 
> Main features:
> 
> CPU:   NXP i.MX 93
> MEMORY: Up to 2GB LPDDR4
> NETWORKING: 2x Gb Ethernet
> USB: USB OTG 2.0, USB HOST 2.0
> STORAGE: eMMC starting from 4GB
> PERIPHERALS: UART, I2C, SPI, CAN, SDIO, GPIO
> 
> The i.Core MX93 needs to be mounted on top of
> Engicam baseboards to work.
> 
> Add devicetree include file.
> 
> Cc: Matteo Lisi <matteo.lisi@engicam.com>
> Cc: Mirko Ardinghi <mirko.ardinghi@engicam.com>
> Reviewed-by: Peng Fan <peng.fan@nxp.com>
> Signed-off-by: Fabio Aiuto <fabio.aiuto@engicam.com>
> ---
> v5 ---> v8:
>         - no changes
> v4 ---> v5:
>         - added Reviewed-by tag
>         - fixed line wrapping in commit msg
>         - fixed indentation, dropped newlines, reordered property
> v3 ---> v4:
>         - no changes
> v2 ---> v3:
>         - added wdog_b-warm-reset property in pmic
> v1 ---> v2:
>         - remove unneeded include
> 
>  .../boot/dts/freescale/imx93-icore-mx93.dtsi  | 269 ++++++++++++++++++
>  1 file changed, 269 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/freescale/imx93-icore-mx93.dtsi
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx93-icore-mx93.dtsi b/arch/arm64/boot/dts/freescale/imx93-icore-mx93.dtsi
> new file mode 100644
> index 000000000000..9c97b620ccfc
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx93-icore-mx93.dtsi
> @@ -0,0 +1,269 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright 2022 NXP
> + * Copyright 2024 Engicam s.r.l.
> + */
> +
> +/dts-v1/;
> +
> +#include "imx93.dtsi"
> +
> +/ {
> +	model = "Engicam i.Core MX93 SoM";
> +	compatible = "engicam,icore-mx93", "fsl,imx93";
> +
> +	reg_vref_1v8: regulator-adc-vref {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vref_1v8";
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <1800000>;
> +	};
> +};
> +
> +&adc1 {
> +	vref-supply = <&reg_vref_1v8>;
> +	status = "okay";
> +};
> +
> +&eqos {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_eqos>;
> +	phy-mode = "rgmii-id";
> +	phy-handle = <&ethphy1>;
> +	status = "okay";
> +
> +	mdio {
> +		compatible = "snps,dwmac-mdio";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		ethphy1: ethernet-phy@7 {
> +			compatible = "ethernet-phy-ieee802.3-c22";
> +			reg = <7>;
> +		};
> +	};
> +};
> +
> +&fec {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_fec>;
> +	phy-mode = "rgmii-id";
> +	phy-handle = <&ethphy2>;
> +	fsl,magic-packet;
> +	status = "okay";
> +
> +	mdio {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		ethphy2: ethernet-phy@7 {
> +			compatible = "ethernet-phy-ieee802.3-c22";
> +			reg = <7>;
> +		};
> +	};
> +};
> +
> +&lpi2c2 {
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +	clock-frequency = <400000>;
> +	pinctrl-names = "default", "sleep";
> +	pinctrl-0 = <&pinctrl_lpi2c2>;
> +	pinctrl-1 = <&pinctrl_lpi2c2>;

Why do you have two identical pinctrl state for default and sleep?

> +	status = "okay";
> +
> +	pmic@25 {
> +		compatible = "nxp,pca9451a";
> +		reg = <0x25>;
> +		interrupt-parent = <&gpio2>;
> +		interrupts = <15 IRQ_TYPE_LEVEL_LOW>;
> +		nxp,wdog_b-warm-reset;
> +
> +		regulators {
> +			buck1: BUCK1 {
> +				regulator-name = "BUCK1";
> +				regulator-min-microvolt = <600000>;
> +				regulator-max-microvolt = <2187500>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +				regulator-ramp-delay = <3125>;
> +			};
> +
> +			buck2: BUCK2 {
> +				regulator-name = "BUCK2";
> +				regulator-min-microvolt = <600000>;
> +				regulator-max-microvolt = <2187500>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +				regulator-ramp-delay = <3125>;
> +			};
> +
> +			buck4: BUCK4{
> +				regulator-name = "BUCK4";
> +				regulator-min-microvolt = <600000>;
> +				regulator-max-microvolt = <3400000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			buck5: BUCK5{
> +				regulator-name = "BUCK5";
> +				regulator-min-microvolt = <600000>;
> +				regulator-max-microvolt = <3400000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			buck6: BUCK6 {
> +				regulator-name = "BUCK6";
> +				regulator-min-microvolt = <600000>;
> +				regulator-max-microvolt = <3400000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			ldo1: LDO1 {
> +				regulator-name = "LDO1";
> +				regulator-min-microvolt = <1600000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			ldo2: LDO2 {
> +				regulator-name = "LDO2";
> +				regulator-min-microvolt = <800000>;
> +				regulator-max-microvolt = <1150000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			ldo3: LDO3 {
> +				regulator-name = "LDO3";
> +				regulator-min-microvolt = <800000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			ldo4: LDO4 {
> +				regulator-name = "LDO4";
> +				regulator-min-microvolt = <800000>;
> +				regulator-max-microvolt = <3300000>;
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
> +&usdhc1 {
> +	pinctrl-names = "default", "state_100mhz", "state_200mhz";
> +	pinctrl-0 = <&pinctrl_usdhc1>;
> +	pinctrl-1 = <&pinctrl_usdhc1>;
> +	pinctrl-2 = <&pinctrl_usdhc1>;
> +	bus-width = <8>;
> +	non-removable;
> +	status = "okay";
> +};
> +
> +&usdhc2 {/*SD Card*/

Nit: &usdhc2 { /* SD Card */

Shawn

> +	pinctrl-names = "default", "state_100mhz", "state_200mhz";
> +	pinctrl-0 = <&pinctrl_usdhc2>, <&pinctrl_usdhc2_gpio>;
> +	pinctrl-1 = <&pinctrl_usdhc2>, <&pinctrl_usdhc2_gpio>;
> +	pinctrl-2 = <&pinctrl_usdhc2>, <&pinctrl_usdhc2_gpio>;
> +	cd-gpios = <&gpio3 00 GPIO_ACTIVE_LOW>;
> +	bus-width = <4>;
> +	no-1-8-v;
> +	max-frequency = <25000000>;
> +	status = "okay";
> +};
> +
> +&iomuxc {
> +	pinctrl_eqos: eqosgrp {
> +		fsl,pins = <
> +			MX93_PAD_ENET1_MDC__ENET_QOS_MDC                        0x53e
> +			MX93_PAD_ENET1_MDIO__ENET_QOS_MDIO                      0x53e
> +			MX93_PAD_ENET1_RD0__ENET_QOS_RGMII_RD0                  0x53e
> +			MX93_PAD_ENET1_RD1__ENET_QOS_RGMII_RD1                  0x53e
> +			MX93_PAD_ENET1_RD2__ENET_QOS_RGMII_RD2                  0x53e
> +			MX93_PAD_ENET1_RD3__ENET_QOS_RGMII_RD3                  0x53e
> +			MX93_PAD_ENET1_RXC__CCM_ENET_QOS_CLOCK_GENERATE_RX_CLK  0x53e
> +			MX93_PAD_ENET1_RX_CTL__ENET_QOS_RGMII_RX_CTL            0x53e
> +			MX93_PAD_ENET1_TD0__ENET_QOS_RGMII_TD0                  0x53e
> +			MX93_PAD_ENET1_TD1__ENET_QOS_RGMII_TD1                  0x53e
> +			MX93_PAD_ENET1_TD2__ENET_QOS_RGMII_TD2                  0x53e
> +			MX93_PAD_ENET1_TD3__ENET_QOS_RGMII_TD3                  0x53e
> +			MX93_PAD_ENET1_TXC__CCM_ENET_QOS_CLOCK_GENERATE_TX_CLK  0x53e
> +			MX93_PAD_ENET1_TX_CTL__ENET_QOS_RGMII_TX_CTL            0x53e
> +		>;
> +	};
> +
> +	pinctrl_fec: fecgrp {
> +		fsl,pins = <
> +			MX93_PAD_ENET2_MDC__ENET1_MDC                   0x57e
> +			MX93_PAD_ENET2_MDIO__ENET1_MDIO                 0x57e
> +			MX93_PAD_ENET2_RD0__ENET1_RGMII_RD0             0x57e
> +			MX93_PAD_ENET2_RD1__ENET1_RGMII_RD1             0x57e
> +			MX93_PAD_ENET2_RD2__ENET1_RGMII_RD2             0x57e
> +			MX93_PAD_ENET2_RD3__ENET1_RGMII_RD3             0x57e
> +			MX93_PAD_ENET2_RXC__ENET1_RGMII_RXC             0x5fe
> +			MX93_PAD_ENET2_RX_CTL__ENET1_RGMII_RX_CTL       0x57e
> +			MX93_PAD_ENET2_TD0__ENET1_RGMII_TD0             0x57e
> +			MX93_PAD_ENET2_TD1__ENET1_RGMII_TD1             0x57e
> +			MX93_PAD_ENET2_TD2__ENET1_RGMII_TD2             0x57e
> +			MX93_PAD_ENET2_TD3__ENET1_RGMII_TD3             0x57e
> +			MX93_PAD_ENET2_TXC__ENET1_RGMII_TXC             0x5fe
> +			MX93_PAD_ENET2_TX_CTL__ENET1_RGMII_TX_CTL       0x57e
> +		>;
> +	};
> +
> +	pinctrl_lpi2c2: lpi2c2grp {
> +		fsl,pins = <
> +			MX93_PAD_I2C2_SCL__LPI2C2_SCL		0x40000b9e
> +			MX93_PAD_I2C2_SDA__LPI2C2_SDA		0x40000b9e
> +		>;
> +	};
> +
> +	pinctrl_usdhc1: usdhc1grp {
> +		fsl,pins = <
> +			MX93_PAD_SD1_CLK__USDHC1_CLK		0x15fe
> +			MX93_PAD_SD1_CMD__USDHC1_CMD		0x13fe
> +			MX93_PAD_SD1_DATA0__USDHC1_DATA0	0x13fe
> +			MX93_PAD_SD1_DATA1__USDHC1_DATA1	0x13fe
> +			MX93_PAD_SD1_DATA2__USDHC1_DATA2	0x13fe
> +			MX93_PAD_SD1_DATA3__USDHC1_DATA3	0x13fe
> +			MX93_PAD_SD1_DATA4__USDHC1_DATA4	0x13fe
> +			MX93_PAD_SD1_DATA5__USDHC1_DATA5	0x13fe
> +			MX93_PAD_SD1_DATA6__USDHC1_DATA6	0x13fe
> +			MX93_PAD_SD1_DATA7__USDHC1_DATA7	0x13fe
> +			MX93_PAD_SD1_STROBE__USDHC1_STROBE	0x15fe
> +		>;
> +	};
> +
> +	pinctrl_usdhc2: usdhc2grp {
> +		fsl,pins = <
> +			MX93_PAD_SD2_CLK__USDHC2_CLK		0x170e
> +			MX93_PAD_SD2_CMD__USDHC2_CMD		0x130e
> +			MX93_PAD_SD2_DATA0__USDHC2_DATA0	0x130e
> +			MX93_PAD_SD2_DATA1__USDHC2_DATA1        0x130e
> +			MX93_PAD_SD2_DATA2__USDHC2_DATA2        0x130e
> +			MX93_PAD_SD2_DATA3__USDHC2_DATA3        0x130e
> +			MX93_PAD_SD2_VSELECT__USDHC2_VSELECT	0x51e
> +		>;
> +	};
> +
> +	pinctrl_usdhc2_gpio: usdhc2gpiogrp {
> +		fsl,pins = <
> +			MX93_PAD_SD2_CD_B__GPIO3_IO00		0x31e
> +		>;
> +	};
> +};
> -- 
> 2.34.1
> 


