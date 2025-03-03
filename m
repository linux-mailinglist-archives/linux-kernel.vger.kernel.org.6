Return-Path: <linux-kernel+bounces-541700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB036A4C04E
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 13:27:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1FA718967B7
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 12:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F6DA20FA8B;
	Mon,  3 Mar 2025 12:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=kingxukai@zohomail.com header.b="CVNQlvez"
Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C8D1D5CD9;
	Mon,  3 Mar 2025 12:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741004824; cv=pass; b=ki/p7tMoJGP62hdT5zgouMerzGlnwFdBGcJtPLz2+2E23eQUVeaX/X0yjM3Ujh0q7OMCkGp5BhqLqe5M+KzdhSumZYVoGOkvel8YyhuBA1urcHqSeyTBxfx8KmE9NHB7aol1XNGRtWDEIBFHGw5xlbWzvfBe8aKSmEsNhoLsS8w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741004824; c=relaxed/simple;
	bh=MjZmkjSJD6MJSiNXTKSj/Prb0VwfVgXZpp5KyeaYd/o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=orQgWGC/KE9S9Ufj/wuWLkG1CIDihZaV+CsgtKyba3n7gKJ1ab6nWgWt257HgppzJ2SVZeflZdWvv90t2xHMpX28whJ3q5kLLShV/vpBNtrwdStWcizvSFGzRYBB/RVn4UoPIc6MFc4G0ht1HRguQ7OQSBAVZdhpzopvHBx7fkI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=kingxukai@zohomail.com header.b=CVNQlvez; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
ARC-Seal: i=1; a=rsa-sha256; t=1741004806; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=dCLmGOpMTmAuxvDdTWEmL7fKkPuH+dQVKI2GbNGEEroHR74o+fJ9Ksu7j8zBBKcab98QwVAg3SpP/eBDQUu+oH5U8orSSG3nCJUgUp6ta70uDZ1YXkgYlUX4oH+55L6EYmc6iKE//z4xO2tsVJhj2WaHiZ7MJECp8THtONN+HaQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1741004806; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=KfBeFzP/GHd5Ky/PKHGXYMvqyX5pKSIENWPgz66iSM4=; 
	b=LEm5jIlzhczQCmMjF9behFjYEXVl2qlXt2A4wF06HjSHE9jFInFLsQTeWXI7Z1nF327ScTZQohUs9K8r4u2Zx0kxxS4N3xkfuxf1UDVoqAuRGE4FV/o8rpZIxZ1cmQoiTBT5HRTi/0Ik6V00c8J0fE5O2q/ee016MVe52liHB/U=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=kingxukai@zohomail.com;
	dmarc=pass header.from=<kingxukai@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1741004806;
	s=zm2022; d=zohomail.com; i=kingxukai@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=KfBeFzP/GHd5Ky/PKHGXYMvqyX5pKSIENWPgz66iSM4=;
	b=CVNQlvezC9BgEqfUTl+0TxoPgFK5gwalMGh62+cf7hsN2qMQj6BVRH6H6r/2NdBs
	Wx9BDzmYV04a7WDf8+QA9EMa6kC2SPrUPv1eTfWY3Y5C5fW/37MmSi4qEugw/zQdA79
	UEcR/9cyl8Z/a6H6Qo9UhJaWwmm0j3OBYpk1w8zw=
Received: by mx.zohomail.com with SMTPS id 1741004802325445.1739152543331;
	Mon, 3 Mar 2025 04:26:42 -0800 (PST)
Message-ID: <c9d436ff-1fc6-4f28-845c-c7635b31917f@zohomail.com>
Date: Mon, 3 Mar 2025 20:26:20 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/3] dt-bindings: clock: Add bindings for Canaan K230
 clock controller
To: Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 Samuel Holland <samuel.holland@sifive.com>,
 Troy Mitchell <TroyMitchell988@gmail.com>,
 Paul Walmsley <paul.walmsley@sifive.com>,
 Michael Turquette <mturquette@baylibre.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Conor Dooley <conor+dt@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Stephen Boyd <sboyd@kernel.org>,
 Rob Herring <robh@kernel.org>, Conor Dooley <conor@kernel.org>
References: <20250303-b4-k230-clk-v5-0-748d121283e3@zohomail.com>
 <20250303-b4-k230-clk-v5-1-748d121283e3@zohomail.com>
From: Xukai Wang <kingxukai@zohomail.com>
Content-Language: en-US
In-Reply-To: <20250303-b4-k230-clk-v5-1-748d121283e3@zohomail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Feedback-ID: rr080112274afbe326d615e5b0444854c80000c326b26460fff2c574191e95b569a673be03c75ba6492d517c:zu08011227797b7a52fbefa521f9d5fee3000064a766f903853869ab26a37756b41ca77faa2d9e0002872fe9:rf0801122cfa59d5f02a79194a230f625700008f460aca7cd1b032c309e3721df5b9f8152e653064bd03aef47ebc6dabbd:ZohoMail
X-ZohoMailClient: External


On 2025/3/3 20:20, Xukai Wang wrote:
> This patch adds the Device Tree binding for the clock controller
> on Canaan k230. The binding defines the new clocks available and
> the required properties to configure them correctly.
>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

This patch has been modified,

but it only adds a few necessary UARTs and DMA macros,

so I didn’t remove your `Reviewed-by` tag.

> Signed-off-by: Xukai Wang <kingxukai@zohomail.com>
> ---
>  .../devicetree/bindings/clock/canaan,k230-clk.yaml | 43 ++++++++++++++
>  include/dt-bindings/clock/canaan,k230-clk.h        | 69 ++++++++++++++++++++++
>  2 files changed, 112 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/clock/canaan,k230-clk.yaml b/Documentation/devicetree/bindings/clock/canaan,k230-clk.yaml
> new file mode 100644
> index 0000000000000000000000000000000000000000..d7220fa30e4699a68fa5279c04abc63c1905fa4a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/canaan,k230-clk.yaml
> @@ -0,0 +1,43 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/canaan,k230-clk.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Canaan Kendryte K230 Clock
> +
> +maintainers:
> +  - Xukai Wang <kingxukai@zohomail.com>
> +
> +properties:
> +  compatible:
> +    const: canaan,k230-clk
> +
> +  reg:
> +    items:
> +      - description: PLL control registers.
> +      - description: Sysclk control registers.
> +
> +  clocks:
> +    maxItems: 1
> +
> +  '#clock-cells':
> +    const: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - '#clock-cells'
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    clock-controller@91102000 {
> +        compatible = "canaan,k230-clk";
> +        reg = <0x91102000 0x1000>,
> +              <0x91100000 0x1000>;
> +        clocks = <&osc24m>;
> +        #clock-cells = <1>;
> +    };
> diff --git a/include/dt-bindings/clock/canaan,k230-clk.h b/include/dt-bindings/clock/canaan,k230-clk.h
> new file mode 100644
> index 0000000000000000000000000000000000000000..41edb13ea04bffaa1ddd1d1af87ae3406b688332
> --- /dev/null
> +++ b/include/dt-bindings/clock/canaan,k230-clk.h
> @@ -0,0 +1,69 @@
> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
> +/*
> + * Kendryte Canaan K230 Clock Drivers
> + *
> + * Author: Xukai Wang <kingxukai@zohomail.com>
> + */
> +
> +#ifndef CLOCK_K230_CLK_H
> +#define CLOCK_K230_CLK_H
> +
> +/* Kendryte K230 SoC clock identifiers (arbitrary values). */
> +#define K230_CPU0_SRC			0
> +#define K230_CPU0_ACLK			1
> +#define K230_CPU0_PLIC			2
> +#define K230_CPU0_NOC_DDRCP4		3
> +#define K230_CPU0_PCLK			4
> +#define K230_PMU_PCLK			5
> +#define K230_HS_HCLK_HIGH_SRC		6
> +#define K230_HS_HCLK_HIGH_GATE		7
> +#define K230_HS_HCLK_SRC		8
> +#define K230_HS_SD0_HS_AHB_GAT		9
> +#define K230_HS_SD1_HS_AHB_GAT		10
> +#define K230_HS_SSI1_HS_AHB_GA		11
> +#define K230_HS_SSI2_HS_AHB_GA		12
> +#define K230_HS_USB0_HS_AHB_GA		13
> +#define K230_HS_USB1_HS_AHB_GA		14
> +#define K230_HS_SSI0_AXI15		15
> +#define K230_HS_SSI1			16
> +#define K230_HS_SSI2			17
> +#define K230_HS_QSPI_AXI_SRC		18
> +#define K230_HS_SSI1_ACLK_GATE		19
> +#define K230_HS_SSI2_ACLK_GATE		20
> +#define K230_HS_SD_CARD_SRC		21
> +#define K230_HS_SD0_CARD_TX		22
> +#define K230_HS_SD1_CARD_TX		23
> +#define K230_HS_SD_AXI_SRC		24
> +#define K230_HS_SD0_AXI_GATE		25
> +#define K230_HS_SD1_AXI_GATE		26
> +#define K230_HS_SD0_BASE_GATE		27
> +#define K230_HS_SD1_BASE_GATE		28
> +#define K230_HS_OSPI_SRC		29
> +#define K230_HS_USB_REF_50M		30
> +#define K230_HS_SD_TIMER_SRC		31
> +#define K230_HS_SD0_TIMER_GATE		32
> +#define K230_HS_SD1_TIMER_GATE		33
> +#define K230_HS_USB0_REFERENCE		34
> +#define K230_HS_USB1_REFERENCE		35
> +#define K230_LS_APB_SRC			36
> +#define K230_LS_UART0_APB		37
> +#define K230_LS_UART1_APB		38
> +#define K230_LS_UART2_APB		39
> +#define K230_LS_UART3_APB		40
> +#define K230_LS_UART4_APB		41
> +#define K230_LS_I2C0_APB		42
> +#define K230_LS_I2C1_APB		43
> +#define K230_LS_I2C2_APB		44
> +#define K230_LS_I2C3_APB		45
> +#define K230_LS_GPIO_APB		46
> +#define K230_LS_PWM_APB			47
> +#define K230_LS_UART0			48
> +#define K230_LS_UART1			49
> +#define K230_LS_UART2			50
> +#define K230_LS_UART3			51
> +#define K230_LS_UART4			52
> +#define K230_SHRM_AXI_SRC		53
> +#define K230_SHRM_SDMA_AXI_GATE		54
> +#define K230_SHRM_PDMA_AXI_GATE		55
> +
> +#endif /* CLOCK_K230_CLK_H */
>

