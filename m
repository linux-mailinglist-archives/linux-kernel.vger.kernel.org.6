Return-Path: <linux-kernel+bounces-526772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D4366A402FA
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 23:47:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC07519C2EDF
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 22:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96222209696;
	Fri, 21 Feb 2025 22:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PGkQXt1/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3BC11F03DC;
	Fri, 21 Feb 2025 22:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740178014; cv=none; b=OxmS3o+jLgxIFtlyuJIb4aj6riogq3NVNZbAZnYEftuincOmOb2poDOdPSoyK5Ri03QVfqtBoxobUzmIg2e3J3t3t9BDV/74PRCcgE8hC88tkaSdnHwAmoSf/GihgKqzZGdsKUWgNWoixsqViLLeKvbUl0nvAVapyQqs2H50ol4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740178014; c=relaxed/simple;
	bh=Bj5XeMMlWNoOQqinEQeMbQ7s90ZmJ+tHoedMx1SjyTw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Plljk4nttbn5WBDBPa4JqYK3MoRWlvdEa0H++oMfPxchSZ2zrP043miQJDRF+F1NTMwTXis/U1YA9I2OEvczAGBg5MS0SwU4TwUHZrJofwdVjpD0v5qoxHSmm58S9j2wKBjAFT0oSxtmQbjSDqwlYb3/1hXbVOJaxp8+5M8HMzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PGkQXt1/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28C00C4CED6;
	Fri, 21 Feb 2025 22:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740178013;
	bh=Bj5XeMMlWNoOQqinEQeMbQ7s90ZmJ+tHoedMx1SjyTw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PGkQXt1/qiDU9PqRG/31BKqsYquB3kRz/AgzXjg0qHJf4pf6V+4nenrvojOZp1+N6
	 Ku2CohG2BCz/UqFF3eGk+B4Sxm4/1EIUECT94Ns6zb+ony1CY3viqGwiN6nRK+Ft2a
	 MkA8l7mUu27JpcFb3f+lunbDBRCQZNpBXpG5QFN+SZLOvkPyDKGmIY/Zk69d6QO8Fe
	 9S2F3CLRQKP3N0G60tztoim059YpcJxNzFW+qDsG7xxYKHjCxppp23eSctNs1tua2G
	 AjQumYwweVBfcSLz/zv/mjfZZEfBUVullfyOQ/TC19hIr3jskScFzdxiiGnzyKGVmQ
	 ZH5vuhtG0A+xA==
Date: Fri, 21 Feb 2025 16:46:51 -0600
From: Rob Herring <robh@kernel.org>
To: Peter Chen <peter.chen@cixtech.com>
Cc: krzk+dt@kernel.org, conor+dt@kernel.org, catalin.marinas@arm.com,
	will@kernel.org, arnd@arndb.de,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, cix-kernel-upstream@cixtech.com,
	"Fugang . duan" <fugang.duan@cixtech.com>
Subject: Re: [PATCH 6/6] arm64: dts: cix: add initial CIX P1(SKY1) dts support
Message-ID: <20250221224651.GA195444-robh@kernel.org>
References: <20250220084020.628704-1-peter.chen@cixtech.com>
 <20250220084020.628704-7-peter.chen@cixtech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250220084020.628704-7-peter.chen@cixtech.com>

On Thu, Feb 20, 2025 at 04:40:20PM +0800, Peter Chen wrote:
> CIX SKY1 SoC is high performance Armv9 SoC designed by Cixtech,
> and Orion O6 is open source motherboard launched by Radxa.
> See below for detail:
> https://docs.radxa.com/en/orion/o6/getting-started/introduction
> 
> In this commit, it only adds limited components for running initramfs
> at Orion O6.
> 
> Acked-by: Fugang.duan <fugang.duan@cixtech.com>
> Signed-off-by: Peter Chen <peter.chen@cixtech.com>
> ---
>  arch/arm64/boot/dts/Makefile              |   1 +
>  arch/arm64/boot/dts/cix/Makefile          |   2 +
>  arch/arm64/boot/dts/cix/sky1-orion-o6.dts |  21 ++
>  arch/arm64/boot/dts/cix/sky1.dtsi         | 264 ++++++++++++++++++++++
>  4 files changed, 288 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/cix/Makefile
>  create mode 100644 arch/arm64/boot/dts/cix/sky1-orion-o6.dts
>  create mode 100644 arch/arm64/boot/dts/cix/sky1.dtsi
> 
> diff --git a/arch/arm64/boot/dts/Makefile b/arch/arm64/boot/dts/Makefile
> index 79b73a21ddc2..8e7ccd0027bd 100644
> --- a/arch/arm64/boot/dts/Makefile
> +++ b/arch/arm64/boot/dts/Makefile
> @@ -13,6 +13,7 @@ subdir-y += bitmain
>  subdir-y += blaize
>  subdir-y += broadcom
>  subdir-y += cavium
> +subdir-y += cix
>  subdir-y += exynos
>  subdir-y += freescale
>  subdir-y += hisilicon
> diff --git a/arch/arm64/boot/dts/cix/Makefile b/arch/arm64/boot/dts/cix/Makefile
> new file mode 100644
> index 000000000000..ed3713982012
> --- /dev/null
> +++ b/arch/arm64/boot/dts/cix/Makefile
> @@ -0,0 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0
> +dtb-$(CONFIG_ARCH_CIX) += sky1-orion-o6.dtb
> diff --git a/arch/arm64/boot/dts/cix/sky1-orion-o6.dts b/arch/arm64/boot/dts/cix/sky1-orion-o6.dts
> new file mode 100644
> index 000000000000..dbee1616076d
> --- /dev/null
> +++ b/arch/arm64/boot/dts/cix/sky1-orion-o6.dts
> @@ -0,0 +1,21 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * Copyright 2025 Cix Technology Group Co., Ltd.
> + *
> + */
> +
> +/dts-v1/;
> +
> +#include "sky1.dtsi"
> +/ {
> +	model = "Radxa Orion O6";
> +	compatible = "radxa,orion-o6";
> +
> +	chosen {
> +		stdout-path = &uart2;
> +	};
> +};
> +
> +&uart2 {
> +	status = "okay";
> +};
> diff --git a/arch/arm64/boot/dts/cix/sky1.dtsi b/arch/arm64/boot/dts/cix/sky1.dtsi
> new file mode 100644
> index 000000000000..d98735f782e0
> --- /dev/null
> +++ b/arch/arm64/boot/dts/cix/sky1.dtsi
> @@ -0,0 +1,264 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * Copyright 2025 Cix Technology Group Co., Ltd.
> + *
> + */
> +
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +/ {
> +	interrupt-parent = <&gic>;
> +	#address-cells = <2>;
> +	#size-cells = <2>;
> +
> +	aliases {
> +		serial2 = &uart2;
> +	};
> +
> +	cpus {
> +		#address-cells = <2>;
> +		#size-cells = <0>;
> +
> +		cpu-map {
> +			cluster0 {
> +				core0 {
> +					cpu = <&CPU0>;
> +				};
> +				core1 {
> +					cpu = <&CPU1>;
> +				};
> +				core2 {
> +					cpu = <&CPU2>;
> +				};
> +				core3 {
> +					cpu = <&CPU3>;
> +				};
> +				core4 {
> +					cpu = <&CPU4>;
> +				};
> +				core5 {
> +					cpu = <&CPU5>;
> +				};
> +				core6 {
> +					cpu = <&CPU6>;
> +				};
> +				core7 {
> +					cpu = <&CPU7>;
> +				};
> +				core8 {
> +					cpu = <&CPU8>;
> +				};
> +				core9 {
> +					cpu = <&CPU9>;
> +				};
> +				core10 {
> +					cpu = <&CPU10>;
> +				};
> +				core11 {
> +					cpu = <&CPU11>;
> +				};
> +			};
> +		};
> +
> +		CPU0: cpu0@0 {
> +			compatible = "arm,armv8";
> +			enable-method = "psci";
> +			reg = <0x0 0x0>;
> +			device_type = "cpu";
> +			capacity-dmips-mhz = <403>;
> +		};
> +
> +		CPU1: cpu1@100 {
> +			compatible = "arm,armv8";
> +			enable-method = "psci";
> +			reg = <0x0 0x100>;
> +			device_type = "cpu";
> +			capacity-dmips-mhz = <403>;
> +		};
> +
> +		CPU2: cpu2@200 {
> +			compatible = "arm,armv8";
> +			enable-method = "psci";
> +			reg = <0x0 0x200>;
> +			device_type = "cpu";
> +			capacity-dmips-mhz = <403>;
> +		};
> +
> +		CPU3: cpu3@300 {
> +			compatible = "arm,armv8";
> +			enable-method = "psci";
> +			reg = <0x0 0x300>;
> +			device_type = "cpu";
> +			capacity-dmips-mhz = <403>;
> +		};
> +
> +		CPU4: cpu4@400 {
> +			compatible = "arm,armv8";
> +			enable-method = "psci";
> +			reg = <0x0 0x400>;
> +			device_type = "cpu";
> +			capacity-dmips-mhz = <1024>;
> +		};
> +
> +		CPU5: cpu5@500 {
> +			compatible = "arm,armv8";
> +			enable-method = "psci";
> +			reg = <0x0 0x500>;
> +			device_type = "cpu";
> +			capacity-dmips-mhz = <1024>;
> +		};
> +
> +		CPU6: cpu6@600 {
> +			compatible = "arm,armv8";
> +			enable-method = "psci";
> +			reg = <0x0 0x600>;
> +			device_type = "cpu";
> +			capacity-dmips-mhz = <1024>;
> +		};
> +
> +		CPU7: cpu7@700 {
> +			compatible = "arm,armv8";
> +			enable-method = "psci";
> +			reg = <0x0 0x700>;
> +			device_type = "cpu";
> +			capacity-dmips-mhz = <1024>;
> +		};
> +
> +		CPU8: cpu8@800 {
> +			compatible = "arm,armv8";
> +			enable-method = "psci";
> +			reg = <0x0 0x800>;
> +			device_type = "cpu";
> +			capacity-dmips-mhz = <1024>;
> +		};
> +
> +		CPU9: cpu9@900 {
> +			compatible = "arm,armv8";
> +			enable-method = "psci";
> +			reg = <0x0 0x900>;
> +			device_type = "cpu";
> +			capacity-dmips-mhz = <1024>;
> +		};
> +
> +		CPU10: cpu10@a00 {
> +			compatible = "arm,armv8";
> +			enable-method = "psci";
> +			reg = <0x0 0xa00>;
> +			device_type = "cpu";
> +			capacity-dmips-mhz = <1024>;
> +		};
> +
> +		CPU11: cpu11@b00 {
> +			compatible = "arm,armv8";
> +			enable-method = "psci";
> +			reg = <0x0 0xb00>;
> +			device_type = "cpu";
> +			capacity-dmips-mhz = <1024>;
> +		};
> +	};
> +
> +	arch_timer: timer {
> +		compatible = "arm,armv8-timer";
> +		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>,
> +			     <GIC_PPI 14 IRQ_TYPE_LEVEL_LOW>,
> +			     <GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>,
> +			     <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>;
> +		clock-frequency = <1000000000>;
> +		interrupt-parent = <&gic>;
> +		arm,no-tick-in-suspend;
> +	};
> +
> +	memory@80000000 {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		device_type = "memory";
> +		reg = <0x00000000 0x80000000 0x1 0x00000000>;
> +	};
> +
> +	psci {
> +		compatible = "arm,psci-1.0";
> +		method = "smc";
> +	};
> +
> +	pmu: pmu {
> +		compatible = "arm,armv8-pmuv3";

Also needs the CPU model specific compatible string.

> +		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_LOW>;
> +		interrupt-parent = <&gic>;
> +		status = "okay";

okay is the default, don't need status.

> +	};
> +
> +	pmu_spe: pmu_spe {
> +		compatible = "arm,statistical-profiling-extension-v1";
> +		interrupts = <GIC_PPI 5 IRQ_TYPE_LEVEL_LOW>;
> +		interrupt-parent = <&gic>;
> +		status = "okay";
> +	};
> +
> +	reserved-memory {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		linux,cma {
> +			compatible = "shared-dma-pool";
> +			reusable;
> +			size = <0x0 0x28000000>;
> +			linux,cma-default;
> +		};
> +
> +	};
> +
> +	sky1_fixed_clocks: fixed-clocks {

Drop this container node.

> +		uartclk: uartclk {

clock-100000000 for the node name.

> +			compatible = "fixed-clock";
> +			#clock-cells = <0>;
> +			clock-frequency = <100000000>;
> +			clock-output-names = "uartclk";
> +		};
> +
> +		uart_apb_pclk: uart_apb_pclk {

Similar here.

> +			compatible = "fixed-clock";
> +			#clock-cells = <0>;
> +			clock-frequency = <200000000>;
> +			clock-output-names = "apb_pclk";
> +		};
> +	};
> +
> +	soc@0 {
> +		compatible = "simple-bus";
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +		dma-ranges;
> +
> +		uart2: uart@040d0000 {

serial@...

> +			compatible = "arm,pl011", "arm,primecell";
> +			reg = <0x0 0x040d0000 0x0 0x1000>;
> +			interrupts = <GIC_SPI 298 IRQ_TYPE_LEVEL_HIGH>;
> +			clock-names = "uartclk", "apb_pclk";
> +			clocks = <&uartclk>, <&uart_apb_pclk>;
> +			status = "disabled";
> +		};
> +
> +		gic: interrupt-controller@0e001000 {
> +			compatible = "arm,gic-v3";
> +			#address-cells = <2>;
> +			#interrupt-cells = <3>;
> +			#size-cells = <2>;
> +			ranges;
> +			interrupt-controller;
> +			#redistributor-regions = <1>;
> +			reg = <0x0 0x0e010000 0 0x10000>,	/* GICD */
> +			      <0x0 0x0e090000 0 0x300000>;       /* GICR * 12 */
> +			redistributor-stride = <0x40000>;
> +			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_LOW>;
> +			interrupt-parent = <&gic>;
> +
> +			its_pcie: its@e050000 {

msi-controller@...

> +				compatible = "arm,gic-v3-its";
> +				msi-controller;
> +				reg = <0x0 0x0e050000 0x0 0x30000>;
> +			};
> +		};
> +	};
> +};
> -- 
> 2.25.1
> 

