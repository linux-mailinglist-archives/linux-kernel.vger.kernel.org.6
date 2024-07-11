Return-Path: <linux-kernel+bounces-248638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B96A92E005
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 08:23:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57ADEB2275D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 06:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5241C83CDB;
	Thu, 11 Jul 2024 06:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W9KdPjOZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4CF1C14;
	Thu, 11 Jul 2024 06:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720679021; cv=none; b=kwLd6d/uqxUOF/82KZ8VLLUxrriUNsLMP1FiLMHaJSHv6mz04gfhiPv0fVPPRj7c2Sj+L+P6O/OYVV0u4N5YdYQeYU3PDiW6MqH/8N4vn4wKWbczSGXYBN0Eji7xTJ2V6bdOrmOly1IzpZCTFCgFZL6eKcs7cY0DViX/wVjfNkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720679021; c=relaxed/simple;
	bh=VX6tZdcn1eWIikd+NxnAQ898JDXbRS2js5xrYfx6W2Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mndg9mZABXwHeDtfaRk1rUn0PAawOnO6H6/whkr+bVD4ooGE8azVgcB/kYkfCzqahhlzkE9w7a7vc6iSsntf3JYpYpj4KFk+hVGpbZaqq2NHeXJyfSB1MRYE786WM7uHnExvPYRuHSbRdq4fvF4+RNeK2aF4diwriPZFVMRj1CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W9KdPjOZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82663C116B1;
	Thu, 11 Jul 2024 06:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720679021;
	bh=VX6tZdcn1eWIikd+NxnAQ898JDXbRS2js5xrYfx6W2Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=W9KdPjOZgzButHGmd1p1HZTQZnbOO099saQn+n/JEC9kdkoKHttpPwpWKETdu9eoT
	 Y/3Uc2HIr1jW8g0aCqRPlrIA1nWFrv6sDKN8egcRQA2aNTCD5WOxLg8D/CC6YswTE5
	 95/YJZmXTclU2OC1Cf6NfISdFdvZ61hfkVhHXziwEnCf4MnlvwBPAeKAvMT73DaKMr
	 LrKo34NjeYEbpx1UXgNcuE+Y1+7teDCOjXOtZap3mcGruzTAfKrGcTXPesM+LRvhgp
	 sPjfu2Spjdc/4w3NfdWfj/pq5Fq+dOlbvYbsCwOknISrxwov9ZbCK2p4I+Riy29irW
	 nVoJu0J+7KWaA==
Message-ID: <663574d8-26f3-4b4e-b374-db3b5c184e53@kernel.org>
Date: Thu, 11 Jul 2024 08:23:34 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: ti: Introduce J742S2 SoC and EVM
To: Manorit Chawdhry <m-chawdhry@ti.com>, Nishanth Menon <nm@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Udit Kumar <u-kumar1@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, Aniket Limaye <a-limaye@ti.com>
References: <20240711-b4-upstream-j742s2-v1-1-8b9e41c18f91@ti.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzk@kernel.org>
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20240711-b4-upstream-j742s2-v1-1-8b9e41c18f91@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/07/2024 07:26, Manorit Chawdhry wrote:
> This series add the Linux support for our new family of device J742S2.

This is a patch, not series. What Linux support are you adding? Where is
it? I see only DTS, not Linux support.

Please do not use "This commit/patch/change", but imperative mood. See
longer explanation here:
https://elixir.bootlin.com/linux/v5.17.1/source/Documentation/process/submitting-patches.rst#L95



> This device is a subset of J784S4 and shares the same memory map and
> thus the nodes are being reused from J784S4 to avoid duplication.
> 
> Here are some of the salient features of the J742S2 automotive grade
> application processor:
> 
> The J742S2 SoC belongs to the K3 Multicore SoC architecture platform,
> providing advanced system integration in automotive, ADAS and industrial
> applications requiring AI at the network edge. This SoC extends the K3
> Jacinto 7 family of SoCs with focus on raising performance and
> integration while providing interfaces, memory architecture and compute
> performance for multi-sensor, high concurrency applications.
> 
> Some highlights of this SoC are:
> * Up to Four Arm® Cortex®-A72 microprocessor subsystem at up to 2.0GHz,
>   3 C7x floating point vector DSPs with Up to Two Deep-learning matrix
>   multiply accelerator (MMAv2),
> * 3D GPU: Automotive grade IMG BXS-4-64 MC1
> * Vision Processing Accelerator (VPAC) with image signal processor and
>   Depth and Motion Processing Accelerator (DMPAC)
> * Three CSI2.0 4L RX plus two CSI2.0 4L TX, two DSI Tx, one eDP/DP and
>   one DPI interface.
> * Integrated gigabit ethernet switch, up to 4 ports ,two ports
>   support 10Gb USXGMII; One 4 lane PCIe-GEN3 controllers, USB3.0
>   Dual-role device subsystems, Up to 20 MCANs, among other peripherals.

Clean this up from marketing.

> 
> ( Refer Table 2-1 for Device comparison with J7AHP )
> 
> Link: https://www.ti.com/lit/pdf/spruje3 (TRM)
> Link: https://www.ti.com/lit/ug/sprujd8/sprujd8.pdf (EVM user guide)
> Link: https://www.ti.com/lit/zip/SPAC001 (Schematics)
> ---
> The series adds support for J742S2 family of SoCs. Also adds J742S2 EVM
> Support and re-uses most of the stuff from the superset device J784s4.
> 
> Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
> ---
>  arch/arm64/boot/dts/ti/Makefile            |  3 ++
>  arch/arm64/boot/dts/ti/k3-j742s2-evm.dts   | 22 ++++++++++++++
>  arch/arm64/boot/dts/ti/k3-j742s2-main.dtsi | 47 ++++++++++++++++++++++++++++++
>  arch/arm64/boot/dts/ti/k3-j742s2.dtsi      | 18 ++++++++++++
>  4 files changed, 90 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
> index e20b27ddf901..4d0688c5cff7 100644
> --- a/arch/arm64/boot/dts/ti/Makefile
> +++ b/arch/arm64/boot/dts/ti/Makefile
> @@ -119,6 +119,9 @@ dtb-$(CONFIG_ARCH_K3) += k3-j784s4-evm-pcie0-pcie1-ep.dtbo
>  dtb-$(CONFIG_ARCH_K3) += k3-j784s4-evm-quad-port-eth-exp1.dtbo
>  dtb-$(CONFIG_ARCH_K3) += k3-j784s4-evm-usxgmii-exp1-exp2.dtbo
>  
> +# Boards with J742S2 SoC
> +dtb-$(CONFIG_ARCH_K3) += k3-j742s2-evm.dtb
> +
>  # Build time test only, enabled by CONFIG_OF_ALL_DTBS
>  k3-am625-beagleplay-csi2-ov5640-dtbs := k3-am625-beagleplay.dtb \
>  	k3-am625-beagleplay-csi2-ov5640.dtbo
> diff --git a/arch/arm64/boot/dts/ti/k3-j742s2-evm.dts b/arch/arm64/boot/dts/ti/k3-j742s2-evm.dts
> new file mode 100644
> index 000000000000..98088ccfd76d
> --- /dev/null
> +++ b/arch/arm64/boot/dts/ti/k3-j742s2-evm.dts
> @@ -0,0 +1,22 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2024 Texas Instruments Incorporated - https://www.ti.com/
> + *
> + * EVM Board Schematics: https://www.ti.com/lit/zip/SPAC001
> + */
> +
> +#include "k3-j784s4-evm.dts"
> +#include "k3-j742s2.dtsi"
> +
> +/delete-node/ &c71_3_dma_memory_region;
> +/delete-node/ &c71_3_memory_region;
> +
> +/ {
> +	model = "Texas Instruments J742S2 EVM";

Missing compatible and bindings.

Best regards,
Krzysztof


