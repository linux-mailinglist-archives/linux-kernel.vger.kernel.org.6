Return-Path: <linux-kernel+bounces-192297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38E9E8D1B3E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 14:27:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B999E1F2119B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 12:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BF2D16EBF3;
	Tue, 28 May 2024 12:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="he62I3Ms"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B3F716D4C8;
	Tue, 28 May 2024 12:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716899177; cv=none; b=TeYJ4ZfZU94rdUKQPMYHSxBTqkdIxBwpFrQXGOdtgQH+hnv8Mcn0M1/+LjJIA9HT1V1Lv/kObohWoVApf6ef0B2hVJGBEB/8rc7K7ZzcaT1w/HDqm9iMqja+R+BPGwCljIgbSqe9F+rdl01eC+0lYsw6gQP2v3KmsvRwcM3TO2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716899177; c=relaxed/simple;
	bh=pFz/z+f/rVhs3WRovPmI3LChJp6uQxijM+hhiocDzeQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B3DKz6GITLeME6ZbHhSJh9qpvVm2XCZXb8N7ukGxhw0hW5oggb3wfJz9S6qaz/Arqn3P5mPkpuJFv1QeeCTy2Nz9tV4VYI1jup0CV87EMr0vLpJoYUj165U560P7mWF1v1u4GaULHcFkQfvm6eSCbtp5KNcv9Ipe8eJeti0Farg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=he62I3Ms; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD362C3277B;
	Tue, 28 May 2024 12:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716899177;
	bh=pFz/z+f/rVhs3WRovPmI3LChJp6uQxijM+hhiocDzeQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=he62I3MsHJZldqPro55Y1qUEP6nTT6IFXWzHd3uyT7RZ2essiGre2cEg6RcIOHGMQ
	 +uVjnc+x1awPcHUGRp579KTV6lE5wuhUH8XmuQ3N8vvRxYt7dojtEjnQzMk4mNwHrZ
	 BZJ+4hm+0boqVutAzAgaD0ZJDokErkwRPb0Sc4PisqmfIN15iN7lRkZZ2kuzqzOFh5
	 afYqzUE5D1F0PD9EjlgzOYQzMulMPyPkBtpJqeflCM1Qtn9gK61rDsFiM1kW9Ecjde
	 rgq/869bO8n6ZwzV6fakfUJVK2t2scsSxbcubB1/qEVzXxkur7y5GglFUfHr24qvj+
	 nvJTGiSZK9BZQ==
Message-ID: <a6fe1fbe-681d-429b-99cc-a5f07af1cd15@kernel.org>
Date: Tue, 28 May 2024 15:26:11 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/7] arm64: dts: ti: k3-j722s: Add support for PCIe0
To: Siddharth Vadapalli <s-vadapalli@ti.com>, nm@ti.com, vigneshr@ti.com,
 afd@ti.com, kristo@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, u-kumar1@ti.com, danishanwar@ti.com,
 srk@ti.com
References: <20240524090514.152727-1-s-vadapalli@ti.com>
 <20240524090514.152727-8-s-vadapalli@ti.com>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20240524090514.152727-8-s-vadapalli@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 24/05/2024 12:05, Siddharth Vadapalli wrote:
> The PCIe0 instance of PCIe on TI's J722S SoC is a Gen3 single lane PCIe
> controller. Add the device-tree nodes for it and enable it in Root Complex
> mode of operation using Lane 0 of the Serdes1 instance of Serdes.
> 
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> ---
> Current patch is v1. No changelog.
> 
>  arch/arm64/boot/dts/ti/k3-j722s-evm.dts   | 17 +++++++++++
>  arch/arm64/boot/dts/ti/k3-j722s-main.dtsi | 37 +++++++++++++++++++++++
>  2 files changed, 54 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j722s-evm.dts b/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
> index 16c6ab8ee07e..d2d7de5cfe27 100644
> --- a/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
> +++ b/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
> @@ -416,6 +416,16 @@ serdes0_usb_link: phy@0 {
>  	};
>  };
>  
> +&serdes1 {
> +	serdes1_pcie_link: phy@0 {
> +		reg = <0>;
> +		cdns,num-lanes = <1>;
> +		#phy-cells = <0>;
> +		cdns,phy-type = <PHY_TYPE_PCIE>;
> +		resets = <&serdes_wiz1 1>;
> +	};
> +};
> +
>  &usbss0 {
>  	ti,vbus-divider;
>  	status = "okay";
> @@ -439,3 +449,10 @@ &usb1 {
>  	phys = <&serdes0_usb_link>;
>  	phy-names = "cdns3,usb3-phy";
>  };
> +
> +&pcie0_rc {
> +	status = "okay";
> +	reset-gpios = <&exp1 18 GPIO_ACTIVE_HIGH>;
> +	phys = <&serdes1_pcie_link>;
> +	phy-names = "pcie-phy";
> +};
> diff --git a/arch/arm64/boot/dts/ti/k3-j722s-main.dtsi b/arch/arm64/boot/dts/ti/k3-j722s-main.dtsi
> index 19a7e8413ad2..0b32893eb75e 100644
> --- a/arch/arm64/boot/dts/ti/k3-j722s-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j722s-main.dtsi
> @@ -4,6 +4,7 @@
>   * Copyright (C) 2023-2024 Texas Instruments Incorporated - https://www.ti.com/
>   */
>  
> +#include <dt-bindings/phy/phy-cadence.h>
>  #include <dt-bindings/phy/phy-ti.h>
>  
>  /*
> @@ -96,6 +97,35 @@ serdes1: serdes@f010000 {
>  		};
>  	};
>  
> +	pcie0_rc: pcie@f102000 {

Please split PCIe node addition in  to separate patch. hopefully you can squash it with patches that
add USB, SERDES0 and SERDES1 to k3-j722s-main.dtsi.


> +		compatible = "ti,j722s-pcie-host", "ti,j721e-pcie-host";
> +		reg = <0x00 0x0f102000 0x00 0x1000>,
> +		      <0x00 0x0f100000 0x00 0x400>,
> +		      <0x00 0x0d000000 0x00 0x00800000>,
> +		      <0x00 0x68000000 0x00 0x00001000>;
> +		reg-names = "intd_cfg", "user_cfg", "reg", "cfg";
> +		ranges = <0x01000000 0x00 0x68001000  0x00 0x68001000  0x00 0x0010000>,
> +			 <0x02000000 0x00 0x68011000  0x00 0x68011000  0x00 0x7fef000>;
> +		dma-ranges = <0x02000000 0x0 0x0 0x0 0x0 0x10000 0x0>;
> +		interrupt-names = "link_state";
> +		interrupts = <GIC_SPI 99 IRQ_TYPE_EDGE_RISING>;
> +		device_type = "pci";
> +		max-link-speed = <3>;
> +		num-lanes = <1>;
> +		power-domains = <&k3_pds 259 TI_SCI_PD_EXCLUSIVE>;
> +		clocks = <&k3_clks 259 0>, <&serdes1 CDNS_TORRENT_REFCLK_DRIVER>;
> +		clock-names = "fck", "pcie_refclk";
> +		#address-cells = <3>;
> +		#size-cells = <2>;
> +		bus-range = <0x0 0xff>;
> +		vendor-id = <0x104c>;
> +		device-id = <0xb010>;
> +		cdns,no-bar-match-nbits = <64>;
> +		ti,syscon-pcie-ctrl = <&pcie0_ctrl 0x0>;
> +		msi-map = <0x0 &gic_its 0x0 0x10000>;
> +		status = "disabled";
> +	};
> +
>  	usbss1: usb@f920000 {
>  		compatible = "ti,j721e-usb";
>  		reg = <0x00 0x0f920000 0x00 0x100>;
> @@ -138,3 +168,10 @@ serdes_ln_ctrl: mux-controller@4080 {
>  				<0x10 0x3>; /* SERDES1 lane0 select */
>  	};
>  };
> +
> +&wkup_conf {
> +	pcie0_ctrl: pcie0-ctrl@4070 {
> +		compatible = "ti,j784s4-pcie-ctrl", "syscon";
> +		reg = <0x4070 0x4>;
> +	};
> +};

-- 
cheers,
-roger

