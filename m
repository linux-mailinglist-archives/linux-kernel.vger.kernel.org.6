Return-Path: <linux-kernel+bounces-240619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9886A926FE9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 08:47:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 259D91F242B2
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 06:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4286C1A08CB;
	Thu,  4 Jul 2024 06:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LSJtHY7V"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48914DF51;
	Thu,  4 Jul 2024 06:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720075647; cv=none; b=VXnZ3RJBW5421vmRz+b6T/PAeJZ7I23JiVZ/orV1KOIKP27jtQjOHq7lfBK7g49zPGR59KjKw15yJv4st3KoSCulasFjBGWtYsijzQhWOOjiaaC+JBYzJQgdIKdD1mmzzLQvobKn6JlPm2MHRBIRxg6z286lTKXPidLyRiiD+dA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720075647; c=relaxed/simple;
	bh=PiomyUmGl6plnWsEmsQogpCVgMK71XeKNayFAg2gpfM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fgSjEd0N2RqYPpYsM8SFcIMMRBPh2QVgVTczoDoUJb8zBPrlxKU69EjBcwwsBXVgitmKhlCNmsHx0Hqu6Yjy1ccVWNhF3B9O2kUduzDnIlnsSUHdQTstkJKnCZlQXFMcBNOv1LqanWR2xFsYwXa0mTKO9qhakZnJPIjoXffNMhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LSJtHY7V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E149C3277B;
	Thu,  4 Jul 2024 06:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720075646;
	bh=PiomyUmGl6plnWsEmsQogpCVgMK71XeKNayFAg2gpfM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=LSJtHY7Vm2Byz+C+t2S4O3kkYEkZoRt6A6azq+XmEnx8NG70IAEdTjjsK+Vi2ggif
	 Kdqem3ajvdy9dLkPwS74P7Tp24aZvB2MV1+r/Wpfl0BdD5epTznHvh1fIH2uUs2aHZ
	 x/AlX2zwEDvX8OMoE/1Fa4CphaQogY34uaj75kPZ/8+KzfHsG8ux2ByqD9FDMjLBrX
	 yiWCoW/JUg6h7gtsUNrhOmwq4bqDnkDC/7Hm/4fCgM+2LfGZBShidOTVYerifwril/
	 JYPpT1eC3dbjkaJT6csZBd2uyGnDcaqOuKbakhqpHxIEBtwlPc0U0B3hyGYU6KaNMN
	 x82SHRdEBvyMA==
Message-ID: <e73a86fc-b2ff-4007-b1e2-17063338bd88@kernel.org>
Date: Thu, 4 Jul 2024 08:47:19 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: clock: sprd,sc9860-clk: convert to YAML
To: Stanislav Jakubek <stano.jakubek@gmail.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Orson Zhai <orsonzhai@gmail.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Baolin Wang <baolin.wang7@gmail.com>, Chunyan Zhang <zhang.lyra@gmail.com>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <ZoVS1GAC28Zpzok4@standask-GA-A55M-S2HP>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <ZoVS1GAC28Zpzok4@standask-GA-A55M-S2HP>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 03/07/2024 15:32, Stanislav Jakubek wrote:
> Convert the Spreadtrum SC9860 clock bindings to DT schema.
> 
> Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>
> ---
>  .../bindings/clock/sprd,sc9860-clk.txt        | 63 -------------
>  .../bindings/clock/sprd,sc9860-clk.yaml       | 90 +++++++++++++++++++
>  2 files changed, 90 insertions(+), 63 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/clock/sprd,sc9860-clk.txt
>  create mode 100644 Documentation/devicetree/bindings/clock/sprd,sc9860-clk.yaml
> 
> diff --git a/Documentation/devicetree/bindings/clock/sprd,sc9860-clk.txt b/Documentation/devicetree/bindings/clock/sprd,sc9860-clk.txt
> deleted file mode 100644
> index aaaf02ca2a6a..000000000000
> --- a/Documentation/devicetree/bindings/clock/sprd,sc9860-clk.txt
> +++ /dev/null
> @@ -1,63 +0,0 @@
> -Spreadtrum SC9860 Clock Binding
> -------------------------
> -
> -Required properties:
> -- compatible: should contain the following compatible strings:
> -	- "sprd,sc9860-pmu-gate"
> -	- "sprd,sc9860-pll"
> -	- "sprd,sc9860-ap-clk"
> -	- "sprd,sc9860-aon-prediv"
> -	- "sprd,sc9860-apahb-gate"
> -	- "sprd,sc9860-aon-gate"
> -	- "sprd,sc9860-aonsecure-clk"
> -	- "sprd,sc9860-agcp-gate"
> -	- "sprd,sc9860-gpu-clk"
> -	- "sprd,sc9860-vsp-clk"
> -	- "sprd,sc9860-vsp-gate"
> -	- "sprd,sc9860-cam-clk"
> -	- "sprd,sc9860-cam-gate"
> -	- "sprd,sc9860-disp-clk"
> -	- "sprd,sc9860-disp-gate"
> -	- "sprd,sc9860-apapb-gate"
> -
> -- #clock-cells: must be 1
> -
> -- clocks : Should be the input parent clock(s) phandle for the clock, this
> -	   property here just simply shows which clock group the clocks'
> -	   parents are in, since each clk node would represent many clocks
> -	   which are defined in the driver.  The detailed dependency
> -	   relationship (i.e. how many parents and which are the parents)
> -	   are implemented in driver code.
> -
> -Optional properties:
> -
> -- reg:	Contain the registers base address and length. It must be configured
> -	only if no 'sprd,syscon' under the node.
> -
> -- sprd,syscon: phandle to the syscon which is in the same address area with
> -	       the clock, and so we can get regmap for the clocks from the
> -	       syscon device.
> -
> -Example:
> -
> -	pmu_gate: pmu-gate {
> -		compatible = "sprd,sc9860-pmu-gate";
> -		sprd,syscon = <&pmu_regs>;
> -		clocks = <&ext_26m>;
> -		#clock-cells = <1>;
> -	};
> -
> -	pll: pll {
> -		compatible = "sprd,sc9860-pll";
> -		sprd,syscon = <&ana_regs>;
> -		clocks = <&pmu_gate 0>;
> -		#clock-cells = <1>;
> -	};
> -
> -	ap_clk: clock-controller@20000000 {
> -		compatible = "sprd,sc9860-ap-clk";
> -		reg = <0 0x20000000 0 0x400>;
> -		clocks = <&ext_26m>, <&pll 0>,
> -			 <&pmu_gate 0>;
> -		#clock-cells = <1>;
> -	};
> diff --git a/Documentation/devicetree/bindings/clock/sprd,sc9860-clk.yaml b/Documentation/devicetree/bindings/clock/sprd,sc9860-clk.yaml
> new file mode 100644
> index 000000000000..21ed023a928c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/sprd,sc9860-clk.yaml
> @@ -0,0 +1,90 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/sprd,sc9860-clk.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Spreadtrum SC9860 clock
> +
> +maintainers:
> +  - Orson Zhai <orsonzhai@gmail.com>
> +  - Baolin Wang <baolin.wang7@gmail.com>
> +  - Chunyan Zhang <zhang.lyra@gmail.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - sprd,sc9860-agcp-gate
> +      - sprd,sc9860-aonsecure-clk
> +      - sprd,sc9860-aon-gate
> +      - sprd,sc9860-aon-prediv
> +      - sprd,sc9860-apahb-gate
> +      - sprd,sc9860-apapb-gate
> +      - sprd,sc9860-ap-clk
> +      - sprd,sc9860-cam-clk
> +      - sprd,sc9860-cam-gate
> +      - sprd,sc9860-disp-clk
> +      - sprd,sc9860-disp-gate
> +      - sprd,sc9860-gpu-clk
> +      - sprd,sc9860-pll
> +      - sprd,sc9860-pmu-gate
> +      - sprd,sc9860-vsp-clk
> +      - sprd,sc9860-vsp-gate
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    minItems: 1
> +    maxItems: 3
> +    description:
> +      Should be the input parent clock(s) phandle for the clock, this
> +      property just simply shows which clock group the clocks' parents
> +      are in, since each clk node would represent many clocks which are
> +      defined in the driver. The detailed dependency relationship
> +      (i.e. how many parents and which are the parents) are implemented
> +      in driver code.

Description is redundant and not accurate. Which clocks are needed
cannot be defined by the driver, but by binding.

This should be constrained per variant and each item explicitly listed.

> +
> +  '#clock-cells':
> +    const: 1
> +
> +  sprd,syscon:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description:
> +      phandle to the syscon which is in the same address area with the
> +      clock, and so we can get regmap for the clocks from the syscon device
> +
> +oneOf:
> +  - required:
> +      - reg
> +  - required:
> +      - sprd,syscon
> +
> +required:
> +  - compatible
> +  - clocks
> +  - '#clock-cells'

allOf:if:then:, instead above oneOf, so you narrow which variant has reg
and which uses regmap.


Best regards,
Krzysztof


