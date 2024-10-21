Return-Path: <linux-kernel+bounces-373957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E91BC9A5FD3
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 11:19:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51F7FB21737
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 09:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B28B81E25EB;
	Mon, 21 Oct 2024 09:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="bCu7cmyF"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [220.197.32.18])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA73D4437;
	Mon, 21 Oct 2024 09:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729502348; cv=none; b=YH9rwNaRALzAAiblmUU1+NfNQkYbv/a7R6ct0/dMTtdcIIlQXt/hqLNrdgJ8ohbd2bwktUjU4jtgynuXTHRPfn13+1CMVb/eJfaje2OHMZYeng0C3URDbnGZqelbgHdns/k8sCA7q9eqgjcGhsmTKAK0u5HQshK6glo4XSYyFhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729502348; c=relaxed/simple;
	bh=tlNcEfMx2mxqqz+owtGWrbX7RzLW5m8WtNpwxUrH5O8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZyX343m0uQLlLje7W2yWUG+dyoMQVE1E2AWj3BeiVou6Zpt4icKg0icE/Ycio59qZD96YlW8jqA5Q+2haCCJ6lF3ZBUsM4O/IU++6JDaxDKvMtOdTmG3t+vPe9bDMvnX9aY+OeuIr8Hmez9643Cv3bVLhzIsUFnYHIw848VW8lA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=bCu7cmyF; arc=none smtp.client-ip=220.197.32.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=ckWzUasrO1JzMF2EH9ywy0bnS99kqsmtx5letIJroIQ=;
	b=bCu7cmyF9jc3Y3CIJcG/313J2oiINJsCNlqsjdWvVvgPiD/6Ql8YZiNIYDMoZP
	5DjMlHT/H3pgZpqJdmmSOzGxNVnV2KvDALJDBtmMDEy6AtT7xc+vNZ1GmwOmJgy8
	1F7I9cOjYSMdILRPzyud82aJ9WhN89QqlcIJhTSvjXGbk=
Received: from dragon (unknown [])
	by gzsmtp1 (Coremail) with SMTP id Mc8vCgAHzNBGHBZnGs6EAA--.4852S3;
	Mon, 21 Oct 2024 17:18:00 +0800 (CST)
Date: Mon, 21 Oct 2024 17:17:58 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Frank Li <Frank.Li@nxp.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	"open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <imx@lists.linux.dev>,
	"moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/4] arm64: dts: imx8-ss-hsio: Add PCIe support
Message-ID: <ZxYcRgnaskQxXT14@dragon>
References: <20241003181542.620461-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241003181542.620461-1-Frank.Li@nxp.com>
X-CM-TRANSID:Mc8vCgAHzNBGHBZnGs6EAA--.4852S3
X-Coremail-Antispam: 1Uf129KBjvAXoWfGr45tF1rXw4rZryxKw13CFg_yoW8Aw47uo
	Wayrs3GrW8Cw17Cay8X3y7Gr42gFsYqa17GayDZr4fG3Wjv34Yyw4xGr48KrW3Gry8CF95
	J3429ryUG3Wqva93n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUVgAwUUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiCRN-ZWcV7NltagACsC

On Thu, Oct 03, 2024 at 02:15:37PM -0400, Frank Li wrote:
> From: Richard Zhu <hongxing.zhu@nxp.com>
> 
> Add PCIe support for i.MX8QXP, i.MX8QM and i.MX8DXL.
> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> Change from v1 to v2
> - none
> 
> On going discussion:
> https://lore.kernel.org/imx/20240930-pci_fixup_addr-v3-2-80ee70352fc7@nxp.com/
> don't affect this dts.
> This work for with/without above patches.
> ---
>  .../boot/dts/freescale/imx8-ss-hsio.dtsi      | 123 +++++++++++
>  .../boot/dts/freescale/imx8dxl-ss-hsio.dtsi   |  52 +++++
>  arch/arm64/boot/dts/freescale/imx8dxl.dtsi    |   2 +
>  .../boot/dts/freescale/imx8qm-ss-hsio.dtsi    | 209 ++++++++++++++++++
>  arch/arm64/boot/dts/freescale/imx8qm.dtsi     |   2 +
>  .../boot/dts/freescale/imx8qxp-ss-hsio.dtsi   |  41 ++++
>  arch/arm64/boot/dts/freescale/imx8qxp.dtsi    |   2 +
>  7 files changed, 431 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8-ss-hsio.dtsi
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8dxl-ss-hsio.dtsi
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8qm-ss-hsio.dtsi
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8qxp-ss-hsio.dtsi
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-hsio.dtsi b/arch/arm64/boot/dts/freescale/imx8-ss-hsio.dtsi
> new file mode 100644
> index 0000000000000..bf05cae05d27a
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx8-ss-hsio.dtsi
> @@ -0,0 +1,123 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright 2024 NXP
> + *
> + * Richard Zhu <hongxing.zhu@nxp.com>
> + */
> +#include <dt-bindings/phy/phy.h>
> +
> +hsio_axi_clk: clock-hsio-axi {
> +	compatible = "fixed-clock";
> +	#clock-cells = <0>;
> +	clock-frequency = <400000000>;
> +	clock-output-names = "hsio_axi_clk";
> +};
> +
> +hsio_per_clk: clock-hsio-per {
> +	compatible = "fixed-clock";
> +	#clock-cells = <0>;
> +	clock-frequency = <133333333>;
> +	clock-output-names = "hsio_per_clk";
> +};
> +
> +hsio_refa_clk: clock-hsio-refa {
> +	compatible = "gpio-gate-clock";
> +	clocks = <&xtal100m>;
> +	#clock-cells = <0>;
> +	enable-gpios = <&lsio_gpio4 27 GPIO_ACTIVE_LOW>;
> +};
> +
> +hsio_refb_clk: clock-hsio-refb {
> +	compatible = "gpio-gate-clock";
> +	clocks = <&xtal100m>;
> +	#clock-cells = <0>;
> +	enable-gpios = <&lsio_gpio4 1 GPIO_ACTIVE_LOW>;
> +};
> +
> +xtal100m: clock-xtal100m {
> +	compatible = "fixed-clock";
> +	#clock-cells = <0>;
> +	clock-frequency = <100000000>;
> +	clock-output-names = "xtal_100MHz";
> +};
> +
> +hsio_subsys: bus@5f000000 {
> +	compatible = "simple-bus";
> +	ranges = <0x5f000000 0x0 0x5f000000 0x21000000>,
> +		 <0x80000000 0x0 0x70000000 0x10000000>;
> +	#address-cells = <1>;
> +	#size-cells = <1>;
> +	dma-ranges = <0x80000000 0 0x80000000 0x80000000>;
> +
> +	pcieb: pcie@5f010000 {
> +		compatible = "fsl,imx8q-pcie";
> +		reg = <0x5f010000 0x10000>,
> +		      <0x8ff00000 0x80000>;
> +		reg-names = "dbi", "config";
> +		ranges = <0x81000000 0 0x00000000 0x8ff80000 0 0x00010000>,
> +			 <0x82000000 0 0x80000000 0x80000000 0 0x0ff00000>;
> +		#interrupt-cells = <1>;
> +		interrupts = <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>;
> +		interrupt-names = "msi";
> +		#address-cells = <3>;
> +		#size-cells = <2>;
> +		clocks = <&pcieb_lpcg IMX_LPCG_CLK_6>,
> +			 <&pcieb_lpcg IMX_LPCG_CLK_4>,
> +			 <&pcieb_lpcg IMX_LPCG_CLK_5>;
> +		clock-names = "dbi", "mstr", "slv";
> +		bus-range = <0x00 0xff>;
> +		device_type = "pci";
> +		fsl,max-link-speed = <3>;

Can we put vendor property after generic ones?

> +		interrupt-map = <0 0 0 1 &gic 0 105 4>,
> +				 <0 0 0 2 &gic 0 106 4>,
> +				 <0 0 0 3 &gic 0 107 4>,
> +				 <0 0 0 4 &gic 0 108 4>;
> +		interrupt-map-mask = <0 0 0 0x7>;
> +		num-lanes = <1>;
> +		num-viewport = <4>;
> +		power-domains = <&pd IMX_SC_R_PCIE_B>;
> +		status = "disabled";
> +	};
> +
> +	pcieb_lpcg: clock-controller@5f060000 {
> +		compatible = "fsl,imx8qxp-lpcg";
> +		reg = <0x5f060000 0x10000>;
> +		clocks = <&hsio_axi_clk>, <&hsio_axi_clk>, <&hsio_axi_clk>;
> +		#clock-cells = <1>;
> +		clock-indices = <IMX_LPCG_CLK_4>, <IMX_LPCG_CLK_5>, <IMX_LPCG_CLK_6>;
> +		clock-output-names = "hsio_pcieb_mstr_axi_clk",
> +				     "hsio_pcieb_slv_axi_clk",
> +				     "hsio_pcieb_dbi_axi_clk";
> +		power-domains = <&pd IMX_SC_R_PCIE_B>;
> +	};
> +
> +	phyx1_crr1_lpcg: clock-controller@5f0b0000 {
> +		compatible = "fsl,imx8qxp-lpcg";
> +		reg = <0x5f0b0000 0x10000>;
> +		clocks = <&hsio_per_clk>;
> +		#clock-cells = <1>;
> +		clock-indices = <IMX_LPCG_CLK_4>;
> +		clock-output-names = "hsio_phyx1_per_clk";
> +		power-domains = <&pd IMX_SC_R_SERDES_1>;
> +	};
> +
> +	pcieb_crr3_lpcg: clock-controller@5f0d0000 {
> +		compatible = "fsl,imx8qxp-lpcg";
> +		reg = <0x5f0d0000 0x10000>;
> +		clocks = <&hsio_per_clk>;
> +		#clock-cells = <1>;
> +		clock-indices = <IMX_LPCG_CLK_4>;
> +		clock-output-names = "hsio_pcieb_per_clk";
> +		power-domains = <&pd IMX_SC_R_PCIE_B>;
> +	};
> +
> +	misc_crr5_lpcg: clock-controller@5f0f0000 {
> +		compatible = "fsl,imx8qxp-lpcg";
> +		reg = <0x5f0f0000 0x10000>;
> +		clocks = <&hsio_per_clk>;
> +		#clock-cells = <1>;
> +		clock-indices = <IMX_LPCG_CLK_4>;
> +		clock-output-names = "hsio_misc_per_clk";
> +		power-domains = <&pd IMX_SC_R_HSIO_GPIO>;
> +	};
> +};
> diff --git a/arch/arm64/boot/dts/freescale/imx8dxl-ss-hsio.dtsi b/arch/arm64/boot/dts/freescale/imx8dxl-ss-hsio.dtsi
> new file mode 100644
> index 0000000000000..f3104e205ae89
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx8dxl-ss-hsio.dtsi
> @@ -0,0 +1,52 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright 2024 NXP
> + */
> +
> +&hsio_subsys {
> +	phyx1_lpcg: clock-controller@5f090000 {
> +		compatible = "fsl,imx8qxp-lpcg";
> +		reg = <0x5f090000 0x10000>;
> +		clocks = <&hsio_refb_clk>, <&hsio_per_clk>,
> +			 <&hsio_per_clk>, <&hsio_per_clk>;
> +		#clock-cells = <1>;
> +		clock-indices = <IMX_LPCG_CLK_0>, <IMX_LPCG_CLK_1>,
> +				<IMX_LPCG_CLK_2>, <IMX_LPCG_CLK_4>;
> +		clock-output-names = "hsio_phyx1_pclk",
> +				     "hsio_phyx1_epcs_tx_clk",
> +				     "hsio_phyx1_epcs_rx_clk",
> +				     "hsio_phyx1_apb_clk";
> +		power-domains = <&pd IMX_SC_R_SERDES_1>;
> +	};
> +
> +	hsio_phy: phy@5f1a0000 {
> +		compatible = "fsl,imx8qxp-hsio";
> +		reg = <0x5f1a0000 0x10000>,
> +		      <0x5f120000 0x10000>,
> +		      <0x5f140000 0x10000>,
> +		      <0x5f160000 0x10000>;
> +		reg-names = "reg", "phy", "ctrl", "misc";
> +		clocks = <&phyx1_lpcg IMX_LPCG_CLK_0>,
> +			 <&phyx1_lpcg IMX_LPCG_CLK_4>,
> +			 <&phyx1_crr1_lpcg IMX_LPCG_CLK_4>,
> +			 <&pcieb_crr3_lpcg IMX_LPCG_CLK_4>,
> +			 <&misc_crr5_lpcg IMX_LPCG_CLK_4>;
> +		clock-names = "pclk0", "apb_pclk0", "phy0_crr", "ctl0_crr",
> +			      "misc_crr";
> +		#phy-cells = <3>;
> +		power-domains = <&pd IMX_SC_R_SERDES_1>;
> +		status = "disabled";
> +	};
> +};
> +
> +&pcieb {
> +	#interrupt-cells = <1>;
> +	interrupts = <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>;
> +	interrupt-names = "msi";
> +	interrupt-map = <0 0 0 1 &gic 0 47 4>,
> +			 <0 0 0 2 &gic 0 48 4>,
> +			 <0 0 0 3 &gic 0 49 4>,
> +			 <0 0 0 4 &gic 0 50 4>;
> +	interrupt-map-mask = <0 0 0 0x7>;
> +};
> +
> diff --git a/arch/arm64/boot/dts/freescale/imx8dxl.dtsi b/arch/arm64/boot/dts/freescale/imx8dxl.dtsi
> index 7e54cf2028580..76de3db8b9423 100644
> --- a/arch/arm64/boot/dts/freescale/imx8dxl.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8dxl.dtsi
> @@ -237,12 +237,14 @@ xtal24m: clock-xtal24m {
>  	#include "imx8-ss-conn.dtsi"
>  	#include "imx8-ss-ddr.dtsi"
>  	#include "imx8-ss-lsio.dtsi"
> +	#include "imx8-ss-hsio.dtsi"
>  };
>  
>  #include "imx8dxl-ss-adma.dtsi"
>  #include "imx8dxl-ss-conn.dtsi"
>  #include "imx8dxl-ss-lsio.dtsi"
>  #include "imx8dxl-ss-ddr.dtsi"
> +#include "imx8dxl-ss-hsio.dtsi"
>  
>  &cm40_intmux {
>  	interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
> diff --git a/arch/arm64/boot/dts/freescale/imx8qm-ss-hsio.dtsi b/arch/arm64/boot/dts/freescale/imx8qm-ss-hsio.dtsi
> new file mode 100644
> index 0000000000000..6494f55d33f85
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx8qm-ss-hsio.dtsi
> @@ -0,0 +1,209 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright 2024 NXP
> + *	Richard Zhu <hongxing.zhu@nxp.com>
> + */
> +
> +&hsio_subsys {
> +	compatible = "simple-bus";
> +	ranges = <0x5f000000 0x0 0x5f000000 0x21000000>,
> +		 <0x40000000 0x0 0x60000000 0x10000000>,
> +		 <0x80000000 0x0 0x70000000 0x10000000>;
> +	#address-cells = <1>;
> +	#size-cells = <1>;
> +
> +	pciea: pcie@5f000000 {
> +		compatible = "fsl,imx8q-pcie";
> +		reg = <0x5f000000 0x10000>,
> +		      <0x4ff00000 0x80000>;
> +		reg-names = "dbi", "config";
> +		ranges = <0x81000000 0 0x00000000 0x4ff80000 0 0x00010000>,
> +			 <0x82000000 0 0x40000000 0x40000000 0 0x0ff00000>;
> +		#interrupt-cells = <1>;
> +		interrupts = <GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>;
> +		interrupt-names = "msi";
> +		#address-cells = <3>;
> +		#size-cells = <2>;
> +		clocks = <&pciea_lpcg 2>,
> +			 <&pciea_lpcg 0>,
> +			 <&pciea_lpcg 1>;
> +		clock-names = "dbi", "mstr", "slv";
> +		bus-range = <0x00 0xff>;
> +		device_type = "pci";
> +		fsl,max-link-speed = <3>;
> +		interrupt-map = <0 0 0 1 &gic 0 73 4>,
> +				 <0 0 0 2 &gic 0 74 4>,
> +				 <0 0 0 3 &gic 0 75 4>,
> +				 <0 0 0 4 &gic 0 76 4>;
> +		interrupt-map-mask = <0 0 0 0x7>;
> +		num-lanes = <1>;
> +		num-viewport = <4>;
> +		power-domains = <&pd IMX_SC_R_PCIE_A>;
> +		status = "disabled";
> +	};
> +
> +	pcieb: pcie@5f010000 {
> +		compatible = "fsl,imx8q-pcie";
> +		reg = <0x5f010000 0x10000>,
> +		      <0x8ff00000 0x80000>;
> +		reg-names = "dbi", "config";
> +		ranges = <0x81000000 0 0x00000000 0x8ff80000 0 0x00010000>,
> +			 <0x82000000 0 0x80000000 0x80000000 0 0x0ff00000>;
> +		#interrupt-cells = <1>;
> +		interrupts = <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>;
> +		interrupt-names = "msi";
> +		#address-cells = <3>;
> +		#size-cells = <2>;
> +		clocks = <&pcieb_lpcg 2>,
> +			 <&pcieb_lpcg 0>,
> +			 <&pcieb_lpcg 1>;
> +		clock-names = "dbi", "mstr", "slv";
> +		bus-range = <0x00 0xff>;
> +		device_type = "pci";
> +		fsl,max-link-speed = <3>;
> +		interrupt-map = <0 0 0 1 &gic 0 105 4>,
> +				 <0 0 0 2 &gic 0 106 4>,
> +				 <0 0 0 3 &gic 0 107 4>,
> +				 <0 0 0 4 &gic 0 108 4>;
> +		interrupt-map-mask = <0 0 0 0x7>;
> +		num-lanes = <1>;
> +		num-viewport = <4>;
> +		power-domains = <&pd IMX_SC_R_PCIE_B>;
> +		status = "disabled";
> +	};
> +
> +	sata: sata@5f020000 {

Not sure why SATA is included in a PCIe change.  If it's been done for
some reason, we should probably mention that in commit log.

Shawn

> +		compatible = "fsl,imx8qm-ahci";
> +		reg = <0x5f020000 0x10000>;
> +		interrupts = <GIC_SPI 88 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&sata_lpcg 0>,
> +			 <&sata_crr4_lpcg 0>;
> +		clock-names = "sata", "sata_ref";
> +		/*
> +		 * Since "REXT" pin is only present for first lane PHY
> +		 * and its calibration result will be stored, and shared
> +		 * by the PHY used by SATA.
> +		 *
> +		 * Add the calibration PHYs for SATA here, although only
> +		 * the third lane PHY is used by SATA.
> +		 */
> +		phys = <&hsio_phy 2 PHY_TYPE_SATA 0>,
> +		       <&hsio_phy 0 PHY_TYPE_PCIE 0>,
> +		       <&hsio_phy 1 PHY_TYPE_PCIE 1>;
> +		phy-names = "sata-phy", "cali-phy0", "cali-phy1";
> +		power-domains = <&pd IMX_SC_R_SATA_0>;
> +		status = "disabled";
> +	};
> +
> +	pciea_lpcg: clock-controller@5f050000 {
> +		compatible = "fsl,imx8qxp-lpcg";
> +		reg = <0x5f050000 0x10000>;
> +		clocks = <&hsio_axi_clk>, <&hsio_axi_clk>, <&hsio_axi_clk>;
> +		#clock-cells = <1>;
> +		clock-indices = <IMX_LPCG_CLK_4>, <IMX_LPCG_CLK_5>, <IMX_LPCG_CLK_6>;
> +		clock-output-names = "hsio_pciea_mstr_axi_clk",
> +				     "hsio_pciea_slv_axi_clk",
> +				     "hsio_pciea_dbi_axi_clk";
> +		power-domains = <&pd IMX_SC_R_PCIE_A>;
> +	};
> +
> +	sata_lpcg: clock-controller@5f070000 {
> +		compatible = "fsl,imx8qxp-lpcg";
> +		reg = <0x5f070000 0x10000>;
> +		clocks = <&hsio_axi_clk>;
> +		#clock-cells = <1>;
> +		clock-indices = <IMX_LPCG_CLK_4>;
> +		clock-output-names = "hsio_sata_clk";
> +		power-domains = <&pd IMX_SC_R_SATA_0>;
> +	};
> +
> +	phyx2_lpcg: clock-controller@5f080000 {
> +		compatible = "fsl,imx8qxp-lpcg";
> +		reg = <0x5f080000 0x10000>;
> +		clocks = <&hsio_refa_clk>, <&hsio_per_clk>,
> +			 <&hsio_refa_clk>, <&hsio_per_clk>;
> +		#clock-cells = <1>;
> +		clock-indices = <IMX_LPCG_CLK_0>, <IMX_LPCG_CLK_1>,
> +				<IMX_LPCG_CLK_4>, <IMX_LPCG_CLK_5>;
> +		clock-output-names = "hsio_phyx2_pclk_0",
> +				     "hsio_phyx2_pclk_1",
> +				     "hsio_phyx2_apbclk_0",
> +				     "hsio_phyx2_apbclk_1";
> +		power-domains = <&pd IMX_SC_R_SERDES_0>;
> +	};
> +
> +	phyx1_lpcg: clock-controller@5f090000 {
> +		compatible = "fsl,imx8qxp-lpcg";
> +		reg = <0x5f090000 0x10000>;
> +		clocks = <&hsio_refa_clk>, <&hsio_per_clk>,
> +			 <&hsio_per_clk>, <&hsio_per_clk>;
> +		#clock-cells = <1>;
> +		clock-indices = <IMX_LPCG_CLK_0>, <IMX_LPCG_CLK_1>,
> +				<IMX_LPCG_CLK_2>, <IMX_LPCG_CLK_4>;
> +		clock-output-names = "hsio_phyx1_pclk",
> +				     "hsio_phyx1_epcs_tx_clk",
> +				     "hsio_phyx1_epcs_rx_clk",
> +				     "hsio_phyx1_apb_clk";
> +		power-domains = <&pd IMX_SC_R_SERDES_1>;
> +	};
> +
> +	phyx2_crr0_lpcg: clock-controller@5f0a0000 {
> +		compatible = "fsl,imx8qxp-lpcg";
> +		reg = <0x5f0a0000 0x10000>;
> +		clocks = <&hsio_per_clk>;
> +		#clock-cells = <1>;
> +		clock-indices = <IMX_LPCG_CLK_4>;
> +		clock-output-names = "hsio_phyx2_per_clk";
> +		power-domains = <&pd IMX_SC_R_SERDES_0>;
> +	};
> +
> +	pciea_crr2_lpcg: clock-controller@5f0c0000 {
> +		compatible = "fsl,imx8qxp-lpcg";
> +		reg = <0x5f0c0000 0x10000>;
> +		clocks = <&hsio_per_clk>;
> +		#clock-cells = <1>;
> +		clock-indices = <IMX_LPCG_CLK_4>;
> +		clock-output-names = "hsio_pciea_per_clk";
> +		power-domains = <&pd IMX_SC_R_PCIE_A>;
> +	};
> +
> +	sata_crr4_lpcg: clock-controller@5f0e0000 {
> +		compatible = "fsl,imx8qxp-lpcg";
> +		reg = <0x5f0e0000 0x10000>;
> +		clocks = <&hsio_per_clk>;
> +		#clock-cells = <1>;
> +		clock-indices = <IMX_LPCG_CLK_4>;
> +		clock-output-names = "hsio_sata_per_clk";
> +		power-domains = <&pd IMX_SC_R_SATA_0>;
> +	};
> +
> +	hsio_phy: phy@5f180000 {
> +		compatible = "fsl,imx8qm-hsio";
> +		reg = <0x5f180000 0x30000>,
> +		      <0x5f110000 0x20000>,
> +		      <0x5f130000 0x30000>,
> +		      <0x5f160000 0x10000>;
> +		reg-names = "reg", "phy", "ctrl", "misc";
> +		clocks = <&phyx2_lpcg IMX_LPCG_CLK_0>,
> +			 <&phyx2_lpcg IMX_LPCG_CLK_1>,
> +			 <&phyx2_lpcg IMX_LPCG_CLK_4>,
> +			 <&phyx2_lpcg IMX_LPCG_CLK_5>,
> +			 <&phyx1_lpcg IMX_LPCG_CLK_0>,
> +			 <&phyx1_lpcg IMX_LPCG_CLK_1>,
> +			 <&phyx1_lpcg IMX_LPCG_CLK_2>,
> +			 <&phyx1_lpcg IMX_LPCG_CLK_4>,
> +			 <&phyx2_crr0_lpcg IMX_LPCG_CLK_4>,
> +			 <&phyx1_crr1_lpcg IMX_LPCG_CLK_4>,
> +			 <&pciea_crr2_lpcg IMX_LPCG_CLK_4>,
> +			 <&pcieb_crr3_lpcg IMX_LPCG_CLK_4>,
> +			 <&sata_crr4_lpcg IMX_LPCG_CLK_4>,
> +			 <&misc_crr5_lpcg IMX_LPCG_CLK_4>;
> +		clock-names = "pclk0", "pclk1", "apb_pclk0", "apb_pclk1",
> +			      "pclk2", "epcs_tx", "epcs_rx", "apb_pclk2",
> +			      "phy0_crr", "phy1_crr", "ctl0_crr",
> +			      "ctl1_crr", "ctl2_crr", "misc_crr";
> +		#phy-cells = <3>;
> +		power-domains = <&pd IMX_SC_R_SERDES_0>, <&pd IMX_SC_R_SERDES_1>;
> +		status = "disabled";
> +	};
> +};
> diff --git a/arch/arm64/boot/dts/freescale/imx8qm.dtsi b/arch/arm64/boot/dts/freescale/imx8qm.dtsi
> index 3ee6e2869e3cf..ac9064a949d82 100644
> --- a/arch/arm64/boot/dts/freescale/imx8qm.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8qm.dtsi
> @@ -594,6 +594,7 @@ mipi_pll_div2_clk: clock-controller-mipi-div2-pll {
>  	#include "imx8-ss-dma.dtsi"
>  	#include "imx8-ss-conn.dtsi"
>  	#include "imx8-ss-lsio.dtsi"
> +	#include "imx8-ss-hsio.dtsi"
>  };
>  
>  #include "imx8qm-ss-img.dtsi"
> @@ -603,3 +604,4 @@ mipi_pll_div2_clk: clock-controller-mipi-div2-pll {
>  #include "imx8qm-ss-audio.dtsi"
>  #include "imx8qm-ss-lvds.dtsi"
>  #include "imx8qm-ss-mipi.dtsi"
> +#include "imx8qm-ss-hsio.dtsi"
> diff --git a/arch/arm64/boot/dts/freescale/imx8qxp-ss-hsio.dtsi b/arch/arm64/boot/dts/freescale/imx8qxp-ss-hsio.dtsi
> new file mode 100644
> index 0000000000000..47fc6e0cff4a1
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx8qxp-ss-hsio.dtsi
> @@ -0,0 +1,41 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright 2024 NXP
> + *	Richard Zhu <hongxing.zhu@nxp.com>
> + */
> +
> +&hsio_subsys {
> +	phyx1_lpcg: clock-controller@5f090000 {
> +		compatible = "fsl,imx8qxp-lpcg";
> +		reg = <0x5f090000 0x10000>;
> +		clocks = <&hsio_refb_clk>, <&hsio_per_clk>,
> +			 <&hsio_per_clk>, <&hsio_per_clk>;
> +		#clock-cells = <1>;
> +		clock-indices = <IMX_LPCG_CLK_0>, <IMX_LPCG_CLK_1>,
> +				<IMX_LPCG_CLK_2>, <IMX_LPCG_CLK_4>;
> +		clock-output-names = "hsio_phyx1_pclk",
> +				     "hsio_phyx1_epcs_tx_clk",
> +				     "hsio_phyx1_epcs_rx_clk",
> +				     "hsio_phyx1_apb_clk";
> +		power-domains = <&pd IMX_SC_R_SERDES_1>;
> +	};
> +
> +	hsio_phy: phy@5f1a0000 {
> +		compatible = "fsl,imx8qxp-hsio";
> +		reg = <0x5f1a0000 0x10000>,
> +		      <0x5f120000 0x10000>,
> +		      <0x5f140000 0x10000>,
> +		      <0x5f160000 0x10000>;
> +		reg-names = "reg", "phy", "ctrl", "misc";
> +		clocks = <&phyx1_lpcg IMX_LPCG_CLK_0>,
> +			 <&phyx1_lpcg IMX_LPCG_CLK_1>,
> +			 <&phyx1_crr1_lpcg IMX_LPCG_CLK_4>,
> +			 <&pcieb_crr3_lpcg IMX_LPCG_CLK_4>,
> +			 <&misc_crr5_lpcg IMX_LPCG_CLK_4>;
> +		clock-names = "pclk0", "apb_pclk0", "phy0_crr", "ctl0_crr",
> +			      "misc_crr";
> +		#phy-cells = <3>;
> +		power-domains = <&pd IMX_SC_R_SERDES_1>;
> +		status = "disabled";
> +	};
> +};
> diff --git a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
> index 0313f295de2e9..db21c6d64f24d 100644
> --- a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
> @@ -323,6 +323,7 @@ map0 {
>  	#include "imx8-ss-conn.dtsi"
>  	#include "imx8-ss-ddr.dtsi"
>  	#include "imx8-ss-lsio.dtsi"
> +	#include "imx8-ss-hsio.dtsi"
>  };
>  
>  #include "imx8qxp-ss-img.dtsi"
> @@ -330,3 +331,4 @@ map0 {
>  #include "imx8qxp-ss-adma.dtsi"
>  #include "imx8qxp-ss-conn.dtsi"
>  #include "imx8qxp-ss-lsio.dtsi"
> +#include "imx8qxp-ss-hsio.dtsi"
> -- 
> 2.34.1
> 


