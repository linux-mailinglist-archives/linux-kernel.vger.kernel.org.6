Return-Path: <linux-kernel+bounces-445967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D5AED9F1DFB
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 11:11:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF9E4163FC6
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 10:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6F58186287;
	Sat, 14 Dec 2024 10:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jDqL92ta"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E025518AE2;
	Sat, 14 Dec 2024 10:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734171091; cv=none; b=fd0SqgpEgbx3emopOqN90D32ueUJZFQdWOz8ij4yvvCSd4z4srs0pZYxbmWLlWqmkpDeYyO/VcE6CbUOe3ikgikUSsWpWI/dG2wNrNUmhl1o6JI78N+iLEu04mNZn0yinuL2wTUXpqO/izMEj+oiz4NEM2yYUTwcBvGDZU8qKYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734171091; c=relaxed/simple;
	bh=JOU2iqgl7WKpQA4lI32KC3eu++YtTiwGr+0raEXsXNY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fZuTQ1vXkKQnK0w9hGmhiT2MOOSKL1EUdw8uTdz+ETtqj4g1LNmsklxJAAO2aYrv9rSLm5oJV95xR3TVSRoNlMtrfuSY6KeTbpk0evlDBdJ6f/2TVWqJP1uW8tgRxdH4jDQzwiG6rCtZ0mVWKmRcGuVirpL12HM6fJmUtdIGv7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jDqL92ta; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAFCBC4CED1;
	Sat, 14 Dec 2024 10:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734171090;
	bh=JOU2iqgl7WKpQA4lI32KC3eu++YtTiwGr+0raEXsXNY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=jDqL92tajiuBW5fL5ZEqIDjJAsFGdr3ki+Yyj0zdQIldGPWS7f5CM4W7qFr4qWhA9
	 QgGh3ydsTIRq8KgTGylv/ECBHgvw1ylKhVfUT0l2LEmco3iz2AYQgoCkgOU3WnKkvb
	 7BtSpUSjI7bGmGF3cXql8NMVAURExqELLsUADU2vlzfUimfiPpu7DwWT06pTZEz4Hf
	 TFJEDzzCI9W2E540XCI4HEfb+cLgTWTlpTKtQZ60b+udEoDc38gcvHvAKJwPH4d5Zd
	 euL7HUrgnAsK11Na2glxS/zcA1akrUV3OWq+/DOdL5jAJXbJG6Y6txXVhin86FTthc
	 PHLPL3G+8XdoQ==
Message-ID: <70119ce4-6d58-40f6-9851-679cf597fe73@kernel.org>
Date: Sat, 14 Dec 2024 11:11:26 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/8] arm64: dts: morello: Add support for common
 functionalities
To: Vincenzo Frascino <vincenzo.frascino@arm.com>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@arm.com>, Rob Herring <robh@kernel.org>
References: <20241213163221.3626261-1-vincenzo.frascino@arm.com>
 <20241213163221.3626261-4-vincenzo.frascino@arm.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 xsFNBFVDQq4BEAC6KeLOfFsAvFMBsrCrJ2bCalhPv5+KQF2PS2+iwZI8BpRZoV+Bd5kWvN79
 cFgcqTTuNHjAvxtUG8pQgGTHAObYs6xeYJtjUH0ZX6ndJ33FJYf5V3yXqqjcZ30FgHzJCFUu
 JMp7PSyMPzpUXfU12yfcRYVEMQrmplNZssmYhiTeVicuOOypWugZKVLGNm0IweVCaZ/DJDIH
 gNbpvVwjcKYrx85m9cBVEBUGaQP6AT7qlVCkrf50v8bofSIyVa2xmubbAwwFA1oxoOusjPIE
 J3iadrwpFvsZjF5uHAKS+7wHLoW9hVzOnLbX6ajk5Hf8Pb1m+VH/E8bPBNNYKkfTtypTDUCj
 NYcd27tjnXfG+SDs/EXNUAIRefCyvaRG7oRYF3Ec+2RgQDRnmmjCjoQNbFrJvJkFHlPeHaeS
 BosGY+XWKydnmsfY7SSnjAzLUGAFhLd/XDVpb1Een2XucPpKvt9ORF+48gy12FA5GduRLhQU
 vK4tU7ojoem/G23PcowM1CwPurC8sAVsQb9KmwTGh7rVz3ks3w/zfGBy3+WmLg++C2Wct6nM
 Pd8/6CBVjEWqD06/RjI2AnjIq5fSEH/BIfXXfC68nMp9BZoy3So4ZsbOlBmtAPvMYX6U8VwD
 TNeBxJu5Ex0Izf1NV9CzC3nNaFUYOY8KfN01X5SExAoVTr09ewARAQABzSVLcnp5c3p0b2Yg
 S296bG93c2tpIDxrcnprQGtlcm5lbC5vcmc+wsGVBBMBCgA/AhsDBgsJCAcDAgYVCAIJCgsE
 FgIDAQIeAQIXgBYhBJvQfg4MUfjVlne3VBuTQ307QWKbBQJgPO8PBQkUX63hAAoJEBuTQ307
 QWKbBn8P+QFxwl7pDsAKR1InemMAmuykCHl+XgC0LDqrsWhAH5TYeTVXGSyDsuZjHvj+FRP+
 gZaEIYSw2Yf0e91U9HXo3RYhEwSmxUQ4Fjhc9qAwGKVPQf6YuQ5yy6pzI8brcKmHHOGrB3tP
 /MODPt81M1zpograAC2WTDzkICfHKj8LpXp45PylD99J9q0Y+gb04CG5/wXs+1hJy/dz0tYy
 iua4nCuSRbxnSHKBS5vvjosWWjWQXsRKd+zzXp6kfRHHpzJkhRwF6ArXi4XnQ+REnoTfM5Fk
 VmVmSQ3yFKKePEzoIriT1b2sXO0g5QXOAvFqB65LZjXG9jGJoVG6ZJrUV1MVK8vamKoVbUEe
 0NlLl/tX96HLowHHoKhxEsbFzGzKiFLh7hyboTpy2whdonkDxpnv/H8wE9M3VW/fPgnL2nPe
 xaBLqyHxy9hA9JrZvxg3IQ61x7rtBWBUQPmEaK0azW+l3ysiNpBhISkZrsW3ZUdknWu87nh6
 eTB7mR7xBcVxnomxWwJI4B0wuMwCPdgbV6YDUKCuSgRMUEiVry10xd9KLypR9Vfyn1AhROrq
 AubRPVeJBf9zR5UW1trJNfwVt3XmbHX50HCcHdEdCKiT9O+FiEcahIaWh9lihvO0ci0TtVGZ
 MCEtaCE80Q3Ma9RdHYB3uVF930jwquplFLNF+IBCn5JRzsFNBFVDXDQBEADNkrQYSREUL4D3
 Gws46JEoZ9HEQOKtkrwjrzlw/tCmqVzERRPvz2Xg8n7+HRCrgqnodIYoUh5WsU84N03KlLue
 MNsWLJBvBaubYN4JuJIdRr4dS4oyF1/fQAQPHh8Thpiz0SAZFx6iWKB7Qrz3OrGCjTPcW6ei
 OMheesVS5hxietSmlin+SilmIAPZHx7n242u6kdHOh+/SyLImKn/dh9RzatVpUKbv34eP1wA
 GldWsRxbf3WP9pFNObSzI/Bo3kA89Xx2rO2roC+Gq4LeHvo7ptzcLcrqaHUAcZ3CgFG88CnA
 6z6lBZn0WyewEcPOPdcUB2Q7D/NiUY+HDiV99rAYPJztjeTrBSTnHeSBPb+qn5ZZGQwIdUW9
 YegxWKvXXHTwB5eMzo/RB6vffwqcnHDoe0q7VgzRRZJwpi6aMIXLfeWZ5Wrwaw2zldFuO4Dt
 91pFzBSOIpeMtfgb/Pfe/a1WJ/GgaIRIBE+NUqckM+3zJHGmVPqJP/h2Iwv6nw8U+7Yyl6gU
 BLHFTg2hYnLFJI4Xjg+AX1hHFVKmvl3VBHIsBv0oDcsQWXqY+NaFahT0lRPjYtrTa1v3tem/
 JoFzZ4B0p27K+qQCF2R96hVvuEyjzBmdq2esyE6zIqftdo4MOJho8uctOiWbwNNq2U9pPWmu
 4vXVFBYIGmpyNPYzRm0QPwARAQABwsF8BBgBCgAmAhsMFiEEm9B+DgxR+NWWd7dUG5NDfTtB
 YpsFAmA872oFCRRflLYACgkQG5NDfTtBYpvScw/9GrqBrVLuJoJ52qBBKUBDo4E+5fU1bjt0
 Gv0nh/hNJuecuRY6aemU6HOPNc2t8QHMSvwbSF+Vp9ZkOvrM36yUOufctoqON+wXrliEY0J4
 ksR89ZILRRAold9Mh0YDqEJc1HmuxYLJ7lnbLYH1oui8bLbMBM8S2Uo9RKqV2GROLi44enVt
 vdrDvo+CxKj2K+d4cleCNiz5qbTxPUW/cgkwG0lJc4I4sso7l4XMDKn95c7JtNsuzqKvhEVS
 oic5by3fbUnuI0cemeizF4QdtX2uQxrP7RwHFBd+YUia7zCcz0//rv6FZmAxWZGy5arNl6Vm
 lQqNo7/Poh8WWfRS+xegBxc6hBXahpyUKphAKYkah+m+I0QToCfnGKnPqyYIMDEHCS/RfqA5
 t8F+O56+oyLBAeWX7XcmyM6TGeVfb+OZVMJnZzK0s2VYAuI0Rl87FBFYgULdgqKV7R7WHzwD
 uZwJCLykjad45hsWcOGk3OcaAGQS6NDlfhM6O9aYNwGL6tGt/6BkRikNOs7VDEa4/HlbaSJo
 7FgndGw1kWmkeL6oQh7wBvYll2buKod4qYntmNKEicoHGU+x91Gcan8mCoqhJkbqrL7+nXG2
 5Q/GS5M9RFWS+nYyJh+c3OcfKqVcZQNANItt7+ULzdNJuhvTRRdC3g9hmCEuNSr+CLMdnRBY fv0=
In-Reply-To: <20241213163221.3626261-4-vincenzo.frascino@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 13/12/2024 17:32, Vincenzo Frascino wrote:
> The Morello architecture is an experimental extension to Armv8.2-A,
> which extends the AArch64 state with the principles proposed in
> version 7 of the Capability Hardware Enhanced RISC Instructions
> (CHERI) ISA.
> 
> The Morello Platform (soc) and the Fixed Virtual Platfom (fvp) share
> some functionalities that have conveniently been included in
> morello.dtsi to avoid duplication.
> 
> Introduce morello.dtsi.
> 
> Note: Morello fvp will be introduced with a future patch series.
> 
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Cc: Rob Herring <robh@kernel.org>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> ---
>  arch/arm64/boot/dts/arm/morello.dtsi | 112 +++++++++++++++++++++++++++
>  1 file changed, 112 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/arm/morello.dtsi
> 
> diff --git a/arch/arm64/boot/dts/arm/morello.dtsi b/arch/arm64/boot/dts/arm/morello.dtsi
> new file mode 100644
> index 000000000000..9d84a0840c5b
> --- /dev/null
> +++ b/arch/arm64/boot/dts/arm/morello.dtsi
> @@ -0,0 +1,112 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
> +/*
> + * Copyright (c) 2020-2024, Arm Limited. All rights reserved.
> + */
> +
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +/ {
> +	compatible = "arm,morello";
> +
> +	interrupt-parent = <&gic>;
> +	#address-cells = <2>;
> +	#size-cells = <2>;
> +
> +	aliases {
> +		serial0 = &soc_uart0;
> +	};
> +
> +	gic: interrupt-controller@2c010000 {
> +		compatible = "arm,gic-v3";
> +		#address-cells = <2>;
> +		#interrupt-cells = <3>;
> +		#size-cells = <2>;
> +		ranges;
> +		interrupt-controller;
> +	};
> +
> +	pmu {
> +		compatible = "arm,armv8-pmuv3";
> +		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_HIGH>;
> +	};
> +
> +	spe-pmu {
> +		compatible = "arm,statistical-profiling-extension-v1";
> +		interrupts = <GIC_PPI 5 IRQ_TYPE_LEVEL_HIGH>;
> +	};
> +
> +	psci {
> +		compatible = "arm,psci-0.2";
> +		method = "smc";
> +	};
> +
> +	timer {
> +		compatible = "arm,armv8-timer";
> +		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>,
> +			     <GIC_PPI 14 IRQ_TYPE_LEVEL_LOW>,
> +			     <GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>,
> +			     <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>;
> +	};
> +
> +	mailbox: mhu@45000000 {


You cannot have MMIO nodes outside of soc.

> +		compatible = "arm,mhu-doorbell", "arm,primecell";
> +		reg = <0x0 0x45000000 0x0 0x1000>;
> +		interrupts = <GIC_SPI 318 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 316 IRQ_TYPE_LEVEL_HIGH>;
> +		interrupt-names = "mhu-lpri-rx",
> +				  "mhu-hpri-rx";
> +		#mbox-cells = <2>;
> +		mbox-name = "ARM-MHU";
> +		clocks = <&soc_refclk50mhz>;
> +		clock-names = "apb_pclk";
> +	};
> +
> +	sram: sram@45200000 {
> +		compatible = "mmio-sram";
> +		reg = <0x0 0x06000000 0x0 0x8000>;
> +
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges = <0 0x0 0x06000000 0x8000>;
> +
> +		cpu_scp_hpri0: scp-sram@0 {
> +			compatible = "arm,scmi-shmem";
> +			reg = <0x0 0x80>;
> +		};
> +
> +		cpu_scp_hpri1: scp-sram@80 {
> +			compatible = "arm,scmi-shmem";
> +			reg = <0x80 0x80>;
> +		};
> +	};
> +
> +	soc_refclk50mhz: refclk50mhz {

Please use name for all fixed clocks which matches current format
recommendation: 'clock-<freq>' (see also the pattern in the binding for
any other options).

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/clock/fixed-clock.yaml?h=v6.11-rc1

> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <50000000>;
> +		clock-output-names = "apb_pclk";
> +	};
> +
> +	soc_refclk85mhz: refclk85mhz {

Please use name for all fixed clocks which matches current format
recommendation: 'clock-<freq>' (see also the pattern in the binding for
any other options).

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/clock/fixed-clock.yaml?h=v6.11-rc1


> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <85000000>;
> +		clock-output-names = "iofpga:aclk";
> +	};
> +
> +	soc_uartclk:  uartclk {


Only one space.

Please use name for all fixed clocks which matches current format
recommendation: 'clock-<freq>' (see also the pattern in the binding for
any other options).

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/clock/fixed-clock.yaml?h=v6.11-rc1

> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <50000000>;
> +		clock-output-names = "uartclk";
> +	};
> +
> +	soc_uart0: serial@2a400000 {
> +		compatible = "arm,pl011", "arm,primecell";
> +		reg = <0x0 0x2a400000 0x0 0x1000>;
> +		interrupts = <GIC_SPI 63 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&soc_uartclk>, <&soc_refclk50mhz>;
> +		clock-names = "uartclk", "apb_pclk";
> +		status = "okay";

Why do you need it? Did you disable it?

> +	};
> +};


Best regards,
Krzysztof

