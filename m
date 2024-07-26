Return-Path: <linux-kernel+bounces-263173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 417E793D221
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 13:20:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2D0D1F23BAF
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 11:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAD4217A592;
	Fri, 26 Jul 2024 11:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HOpz+coo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B687017A588;
	Fri, 26 Jul 2024 11:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721992801; cv=none; b=SL3zmTW+t4x7SLzoPqiOU1HOv6R/YF9Vch+XkFAM8zjnjZ8rQVTwk69iZY2WTIRMCAJyB+N7Ly1XKZeiqon42ee3PXBnH5K2rSWFhQZPKTV0HP/MpEj2DEOR6zbYzrbW+qSFL5L5OveNj/TpJVpTtAMnrUFdZHXKwVf8S1noi0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721992801; c=relaxed/simple;
	bh=JSPYffs55xXRqX4bf9t+uyKOhPgSMTwYlz+FFIt/4v8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=YL42ZhwBvYuo92Mkf3zUs4KEutoIt6ijvMC/lWgiLibzv4iBeH5VzzkHU6UiHDEttffOOPIkhub1vxgXRclr8+ol12xCkxAzgBAaPXRG/gHj2XkyVsUXyz99YnflobpmdCFRdNVww8kGFEsC/rMwqBwntAkNt0STUSbgUbIIS0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HOpz+coo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F9DBC4AF07;
	Fri, 26 Jul 2024 11:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721992801;
	bh=JSPYffs55xXRqX4bf9t+uyKOhPgSMTwYlz+FFIt/4v8=;
	h=Date:Subject:List-Id:To:References:From:In-Reply-To:From;
	b=HOpz+cooQJHu8PFlXEjzy1VcLfdxSQZeESqN2hlEtpO6OY5ONBtss55HbKRfH9NOA
	 YyicSxeqwzVz5ZX/mrbbhH6oOg2MizKmRCNEwQfU30DeZRzJELW+wJpzNn+cse22w/
	 i8PIfUiNFoBJsn/kKtTQMcqscchv1QUbil+qZ1afEtc2U+pYW5lR4vM165I7D0OiX2
	 dtl+bgz9zK6TGCsWPkYf7YvldK8TpeVYfzjWZvx/Cq4KnNVwi6RabJTGFlkRtCBvOz
	 1hkiu9HefIaecs2tIrc+yVEFEeeUpEaH35aFuAM+yd6PBX20GSe4Twjb5NTTucvdkd
	 yfTyG1XC+mx9g==
Message-ID: <b6be1531-d8e2-44d1-a81a-6db8f9ae4ad4@kernel.org>
Date: Fri, 26 Jul 2024 13:19:50 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 08/10] arm64: dts: aspeed: Add initial AST27XX device
 tree
To: Kevin Chen <kevin_chen@aspeedtech.com>, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, joel@jms.id.au,
 andrew@codeconstruct.com.au, lee@kernel.org, catalin.marinas@arm.com,
 will@kernel.org, arnd@arndb.de, olof@lixom.net, soc@kernel.org,
 mturquette@baylibre.com, sboyd@kernel.org, p.zabel@pengutronix.de,
 quic_bjorande@quicinc.com, geert+renesas@glider.be,
 dmitry.baryshkov@linaro.org, shawnguo@kernel.org, neil.armstrong@linaro.org,
 m.szyprowski@samsung.com, nfraprado@collabora.com, u-kumar1@ti.com,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-clk@vger.kernel.org
References: <20240726110355.2181563-1-kevin_chen@aspeedtech.com>
 <20240726110355.2181563-9-kevin_chen@aspeedtech.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20240726110355.2181563-9-kevin_chen@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26/07/2024 13:03, Kevin Chen wrote:
> ---
>  arch/arm64/boot/dts/Makefile              |   1 +
>  arch/arm64/boot/dts/aspeed/aspeed-g7.dtsi | 217 ++++++++++++++++++++++
>  2 files changed, 218 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/aspeed/aspeed-g7.dtsi
> 
> diff --git a/arch/arm64/boot/dts/Makefile b/arch/arm64/boot/dts/Makefile
> index 21cd3a87f385..c909c19dc5dd 100644
> --- a/arch/arm64/boot/dts/Makefile
> +++ b/arch/arm64/boot/dts/Makefile
> @@ -34,3 +34,4 @@ subdir-y += tesla
>  subdir-y += ti
>  subdir-y += toshiba
>  subdir-y += xilinx
> +subdir-y += aspeed
> diff --git a/arch/arm64/boot/dts/aspeed/aspeed-g7.dtsi b/arch/arm64/boot/dts/aspeed/aspeed-g7.dtsi
> new file mode 100644
> index 000000000000..858ab95251e4
> --- /dev/null
> +++ b/arch/arm64/boot/dts/aspeed/aspeed-g7.dtsi
> @@ -0,0 +1,217 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +#include <dt-bindings/clock/aspeed,ast2700-clk.h>
> +#include <dt-bindings/reset/aspeed,ast2700-reset.h>
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/interrupt-controller/aspeed-scu-ic.h>
> +
> +/ {
> +	model = "Aspeed BMC";

Model of what? No, drop.

> +	compatible = "aspeed,ast2700";

Please run scripts/checkpatch.pl and fix reported warnings. Then please
run `scripts/checkpatch.pl --strict` and (probably) fix more warnings.
Some warnings can be ignored, especially from --strict run, but the code
here looks like it needs a fix. Feel free to get in touch if the warning
is not clear.


> +	#address-cells = <2>;
> +	#size-cells = <2>;
> +	interrupt-parent = <&gic>;
> +
> +	aliases {
> +		serial12 = &uart12;

Nope. Such aliases are board specific.

> +	};
> +
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		cpu@0 {
> +			compatible = "arm,cortex-a35";
> +			enable-method = "psci";
> +			device_type = "cpu";
> +			reg = <0>;
> +			d-cache-size = <0x8000>;
> +			d-cache-line-size = <64>;
> +			d-cache-sets = <128>;
> +			i-cache-size = <0x8000>;
> +			i-cache-line-size = <64>;
> +			i-cache-sets = <256>;
> +			next-level-cache = <&l2>;
> +		};
> +
> +		cpu@1 {
> +			compatible = "arm,cortex-a35";
> +			enable-method = "psci";
> +			device_type = "cpu";
> +			reg = <1>;
> +			d-cache-size = <0x8000>;
> +			d-cache-line-size = <64>;
> +			d-cache-sets = <128>;
> +			i-cache-size = <0x8000>;
> +			i-cache-line-size = <64>;
> +			i-cache-sets = <256>;
> +			next-level-cache = <&l2>;
> +		};
> +
> +		cpu@2 {
> +			compatible = "arm,cortex-a35";
> +			enable-method = "psci";
> +			device_type = "cpu";
> +			reg = <2>;
> +			d-cache-size = <0x8000>;
> +			d-cache-line-size = <64>;
> +			d-cache-sets = <128>;
> +			i-cache-size = <0x8000>;
> +			i-cache-line-size = <64>;
> +			i-cache-sets = <256>;
> +			next-level-cache = <&l2>;
> +		};
> +
> +		cpu@3 {
> +			compatible = "arm,cortex-a35";
> +			enable-method = "psci";
> +			device_type = "cpu";
> +			reg = <3>;
> +			d-cache-size = <0x8000>;
> +			d-cache-line-size = <64>;
> +			d-cache-sets = <128>;
> +			i-cache-size = <0x8000>;
> +			i-cache-line-size = <64>;
> +			i-cache-sets = <256>;
> +			next-level-cache = <&l2>;
> +		};
> +
> +		l2: l2-cache0 {
> +			compatible = "cache";
> +			cache-size = <0x80000>;
> +			cache-line-size = <64>;
> +			cache-sets = <1024>;
> +			cache-level = <2>;
> +		};
> +	};
> +
> +	pmu {
> +		compatible = "arm,cortex-a35-pmu";
> +		interrupt-parent = <&gic>;
> +		interrupts = <GIC_PPI 7 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_HIGH)>;
> +	};
> +
> +	psci {

Order the nodes according to DTS coding style.

Fix all your patches:
1. To pass flawlessly checkpatch (you did not run it)
2. To pass dt_binding_check and dtbs_check (you did not run these)
3. To adhere to kernel coding style
4. To adhere to DTS coding style

> +		compatible = "arm,psci-1.0";
> +		method = "smc";
> +	};
> +
> +	gic: interrupt-controller@12200000 {

Nope, this cannot be outside of SoC.

> +		compatible = "arm,gic-v3";
> +		interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_HIGH)>;
> +		#interrupt-cells = <3>;
> +		interrupt-controller;
> +		interrupt-parent = <&gic>;
> +		#redistributor-regions = <1>;
> +		reg =	<0 0x12200000 0 0x10000>,		//GICD
> +			<0 0x12280000 0 0x80000>,		//GICR
> +			<0 0x40440000 0 0x1000>;		//GICC

Read DTS coding style and order this correctly.

> +	};
> +
> +	timer {
> +		compatible = "arm,armv8-timer";
> +		interrupt-parent = <&gic>;
> +		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>,
> +				<GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>,
> +				<GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>,
> +				<GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>;
> +		arm,cpu-registers-not-fw-configured;
> +		always-on;
> +	};
> +
> +	soc0: soc@10000000 {
> +		compatible = "simple-bus";
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		soc0_sram: sram@10000000 {
> +			compatible = "mmio-sram";
> +			reg = <0x0 0x10000000 0x0 0x20000>;	/* 128KiB SRAM on soc0 */
> +			ranges = <0x0 0x0 0x0 0x10000000 0x0 0x20000>;
> +			#address-cells = <2>;
> +			#size-cells = <2>;
> +			no-memory-wc;
> +
> +			exported@0 {
> +				reg = <0 0x0 0 0x20000>;
> +				export;
> +			};
> +		};
> +
> +		syscon0: syscon@12c02000 {
> +			compatible = "aspeed,ast2700-scu0", "syscon", "simple-mfd";
> +			reg = <0x0 0x12c02000 0x0 0x1000>;
> +			ranges = <0x0 0x0 0 0x12c02000 0 0x1000>;
> +			#address-cells = <2>;
> +			#size-cells = <2>;
> +			#clock-cells = <1>;
> +			#reset-cells = <1>;
> +
> +			silicon-id@0 {
> +				compatible = "aspeed,ast2700-silicon-id", "aspeed,silicon-id";
> +				reg = <0 0x0 0 0x4>;
> +			};
> +
> +			scu_ic0: interrupt-controller@1D0 {

DTS coding style...

> +				#interrupt-cells = <1>;
> +				compatible = "aspeed,ast2700-scu-ic0";
> +				reg = <0 0x1d0 0 0xc>;
> +				interrupts = <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>;
> +				interrupt-controller;
> +			};
> +
> +			scu_ic1: interrupt-controller@1E0 {
> +				#interrupt-cells = <1>;
> +				compatible = "aspeed,ast2700-scu-ic1";
> +				reg = <0 0x1e0 0 0xc>;
> +				interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
> +				interrupt-controller;
> +			};
> +
> +			soc0_rst: reset-controller@200 {
> +				reg = <0 0x200 0 0x40>;
> +			};
> +
> +			soc0_clk: clock-controller@240 {
> +				reg = <0 0x240 0 0x1c0>;
> +			};
> +		};
> +
> +	};
> +
> +	soc1: soc@14000000 {

Wait, what, to socs?

> +		compatible = "simple-bus";
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		syscon1: syscon@14c02000 {
> +			compatible = "aspeed,ast2700-scu1", "syscon", "simple-mfd";
> +			reg = <0x0 0x14c02000 0x0 0x1000>;
> +			ranges = <0x0 0x0 0x0 0x14c02000 0x0 0x1000>;
> +			#address-cells = <2>;
> +			#size-cells = <2>;
> +			#clock-cells = <1>;
> +			#reset-cells = <1>;
> +
> +			soc1_rst: reset-controller@200 {
> +				#reset-cells = <1>;
> +			};
> +
> +			soc1_clk: clock-controller@240 {
> +				reg = <0 0x240 0 0x1c0>;
> +			};
> +		};
> +
> +		uart12: serial@14c33b00 {
> +			compatible = "ns16550a";
> +			reg = <0x0 0x14c33b00 0x0 0x100>;
> +			reg-shift = <2>;
> +			reg-io-width = <4>;
> +			clocks = <&syscon1 SCU1_CLK_GATE_UART12CLK>;
> +			no-loopback-test;
> +			pinctrl-names = "default";

What is this?

> +		};
> +	};
> +};
> +

Best regards,
Krzysztof


