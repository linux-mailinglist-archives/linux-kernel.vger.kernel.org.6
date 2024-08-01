Return-Path: <linux-kernel+bounces-270908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96D039446E2
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 10:44:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3237C1F228E1
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 08:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33178170A0A;
	Thu,  1 Aug 2024 08:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bTG05Hcg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598B616EBFF;
	Thu,  1 Aug 2024 08:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722501848; cv=none; b=T8YDGGtNVKZ9hLtCZzcYs0341YKHZiXOwCoK2SeTu8p2eiPsEZR8pimBP18V5Nwn11n4mgaBNfAKZMslyqr95jo6dtyGOy9cK/2HvWcNRT0yMT5wBPCnPOJn1+Y5h3GAdS5UzAXYl5+aiRTYUnZ/zzLDCVuzo1RsSNcocYKpo+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722501848; c=relaxed/simple;
	bh=pkP/xIqZv5Vo+FSqxHACXd1Vwc3K1w47BaCVHECboCM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kkj3BLMokolJJGcq2ibeNBwQlWt4Acl5ArxQ8dVQWDO+pW95tGHBHHkOdkTSfIzadlHSWgc4JzohFOkg0oqLBm8DbLJz7woJ+PJ4RRHg/NnL2d3ahtIDSUa4ipw7mGYUWsBWaO4ugOHO/F0ZtMSlsYxCSGqg+RoIVyWYogf6cc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bTG05Hcg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6277DC32786;
	Thu,  1 Aug 2024 08:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722501848;
	bh=pkP/xIqZv5Vo+FSqxHACXd1Vwc3K1w47BaCVHECboCM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=bTG05HcgcXncnzlRA6SlJ0z8yJMGJH+ODRhv+IJxmcCjdBLickj94fXrUl/VcUqbg
	 01+1KcXJ1hNfYV2kOfyp4FyF9jnsfANp9L9o6WLyrE/3M0jM35uSZ8Fd1AOC+An1a+
	 p8+adGA6uWE5+m2v4b5nRnl32DRf721Tj5uY9fsMvT/9bmP/NnrSwGQ8tLZTbzhHHj
	 JjFanuX5xMtnIzwjCUyzQeT3PCSy7P5p/cONm+nZbkQmjVazmll2v2pGz9TClRZZ7S
	 TaxzMbNMvmd4vXeQci7WMJhtBXdGx49vy2Hwq99OI9PrfO4CJ5DAYLCba/LJNvKDic
	 7X8v0oHLrsJSw==
Message-ID: <5f9f4062-91e0-43e0-9ef5-48e30ca68ac9@kernel.org>
Date: Thu, 1 Aug 2024 10:44:03 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: arm: socfpga: Add Altera SOCFPGA SDRAM EDAS
To: Alessandro Zanni <alessandro.zanni87@gmail.com>, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, skhan@linuxfoundation.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240731230231.12917-1-alessandro.zanni87@gmail.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzk@kernel.org>
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20240731230231.12917-1-alessandro.zanni87@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 01/08/2024 01:02, Alessandro Zanni wrote:

Thank you for your patch. There is something to discuss/improve.


> diff --git a/Documentation/devicetree/bindings/arm/altera/socfpga-sdram-edac.yaml b/Documentation/devicetree/bindings/arm/altera/socfpga-sdram-edac.yaml
> new file mode 100644
> index 000000000000..78fbe31e4a2b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/altera/socfpga-sdram-edac.yaml

Filename like compatible, so altr,sdram-edac.yaml

Fix the placement - arm is only for top-level sutff. This goes to
memory-controllers or edac



> @@ -0,0 +1,46 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/arm/altera/socfpga-sdram-edac.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Altera SOCFPGA SDRAM Error Detection & Correction [EDAC]
> +
> +maintainers:
> +  - Dinh Nguyen <dinguyen@kernel.org>
> +
> +description:
> +  The EDAC accesses a range of registers in the SDRAM controller.
> +
> +properties:
> +  compatible:
> +    oneOf:

Drop oneOf

> +      - items:

Drop items, just use enum


> +          - enum:
> +              - altr,sdram-edac
> +              - altr,sdram-edac-a10
> +
> +  altr,sdr-syscon:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: 
> +      Phandle of the sdr module
> +
> +  interrupts:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - altr,sdr-syscon
> +  - interrupts
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    sdramedac {

Node names should be generic. See also an explanation and list of
examples (not exhaustive) in DT specification:
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

e.g. memory-controller


> +      compatible = "altr,sdram-edac";
> +      altr,sdr-syscon = <&sdr>;
> +      interrupts = <0 39 4>;

Use proper defines.

> +    };
> +
> +...

Best regards,
Krzysztof


