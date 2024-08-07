Return-Path: <linux-kernel+bounces-277490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B4DE94A211
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 09:56:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CD031C23C86
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 07:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F06FD1C8227;
	Wed,  7 Aug 2024 07:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tnhib0SL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 281AA18FC9B;
	Wed,  7 Aug 2024 07:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723017354; cv=none; b=VeW+0KDsaiu1xAaT5fqXf0M0UzEMrPEz44h/yCqIbaMxF93+DkJPpsbONCqrx2uBVYcQY8PvZ9rxDbLJ+UZdH2b5ej70STmtmsKEIERT6vXqF/BDtSAefwJU9XVsBpPzT0mG9+F4WeriNDmSkfDbmugmGh71Wu6yspPoDWyuM+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723017354; c=relaxed/simple;
	bh=bHCZ2IVmYKXlNpYTfmDjcjQyCoWmi5TuenRLiW6R+Nw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VXxiCc0aU/WdLCy9vom+vB+jxxWJmRtS993qjxC+07BJf0Xb8i9eCXUY9Rh6S1LppiRd/4prjhbf2HAJ4zilVhB0pzdIMxaqC3Q8H6rHmyNW58uqLftMq7XCAo0grAcuW2ciMZ57aZhIeY1NACIFeh8Z0iKfVQaEF6yP2LLmAIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tnhib0SL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71BA7C32782;
	Wed,  7 Aug 2024 07:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723017353;
	bh=bHCZ2IVmYKXlNpYTfmDjcjQyCoWmi5TuenRLiW6R+Nw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Tnhib0SLlUSGPvmb2SNEhipBrUenTTDyAVUHsdTe+oWR4Mup2uHICXRQd0EmGLD/H
	 9kCIu5ZXNhOsz+lhX5f84UTH1uPU2Q5f4LYpvbtfJcPgBvwZYDtTQ8H36IyYorzGR2
	 XRTiwl0gekBcAOVIApGW/B2GGm6sP5jVVmU7zdUH4o7sxX9GngmZQ3cGqMomrbymbp
	 YqJWRh22ARzkPkXxq3oFq87C/oM72Wp7gNSBm1p4bCyoyVFXlBdgwP2IYSS7yE93sP
	 zV0+DP5wnMoUMhQWe51glSwP/nF8KOSoGVk/ueg/8APsAV6aavBIQ7MO51lw6gfsab
	 8XQhli8v7OfNg==
Message-ID: <55827e6d-4930-4c02-ad12-e9199ac63280@kernel.org>
Date: Wed, 7 Aug 2024 09:55:48 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 03/37] dt-bindings: Add binding for
 kalray,kv3-1-intc
To: Yann Sionneau <ysionneau@kalrayinc.com>, linux-kernel@vger.kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jonathan Borne <jborne@kalrayinc.com>,
 Julian Vetter <jvetter@kalrayinc.com>
Cc: Jules Maselbas <jmaselbas@zdiv.net>, devicetree@vger.kernel.org
References: <20240722094226.21602-1-ysionneau@kalrayinc.com>
 <20240722094226.21602-4-ysionneau@kalrayinc.com>
 <bcf385af-3c2c-4e1d-87eb-0810046f5a4d@kernel.org>
 <8f604cbd-3afe-4409-b6f5-a3d0795dea4e@kalrayinc.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <8f604cbd-3afe-4409-b6f5-a3d0795dea4e@kalrayinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 31/07/2024 16:47, Yann Sionneau wrote:
>>> +description: |
>>> +  The Kalray Core Interrupt Controller is tightly integrated in each kv3 core
>>> +  present in the Coolidge SoC.
>>> +
>>> +  It provides the following features:
>>> +  - 32 independent interrupt sources
>>> +  - 2-bit configurable priority level
>>> +  - 2-bit configurable ownership level
>>> +
>>> +properties:
>>> +  compatible:
>>> +    const: kalray,kv3-1-intc
>> What is the SoC name/model? You use "Kalray Core" and "Coolidge" and
>> "kv3-1".
> 
> The SoC name is Coolidge , it contains "Kalray cores". Kalray being the name of the company.
> 
> The exact core name is kv3-1. The core is part of the kvx family: next core generation will most likely be called kv4 or kv4-1.
> 
> The question whether to use "coolidge" (soc name) or "kv3-1" (cpu core name) for our IPs compatible is indeed a good one, we talked about it internally at Kalray.
> 
> We ended up using "kv3-1" at the beginning of the compatible when the hw IP is very closed/tightly integrated into the CPU core.
> 
> We ended up using "coolidge" when the hw IP is just some general IP inside the SoC (like the IOMMU, the dma_noc).
> 
> The "intc" or "core intc", is very tightly integrated into the cpu core.
> 
> The "core intc" is configured directly using core registers named SFR (System Function Registers) using special SFR handling instructions. It is not memory mapped.
> 
> So we ended up using "kv3-1" in the compatible. Is this OK?

Comaptibles are supposed to be based on SoC model name, thus kv3-1 is
fine (based in your explanation). However unified naming in title or
description would be helpful, e.g. in title:
"Kalray Coolidge kv3-1 Core Interrupt Controller"

And all other compatibles and titles need fixing. For example in other
places you use "coolidge".

> 
>>
>>> +
>>> +  "#interrupt-cells":
>>> +    const: 1
>>> +    description:
>>> +      The IRQ number.
>>> +
>>> +  "#address-cells":
>>> +    const: 0
>>> +
>>> +  interrupt-controller: true
>>> +
>>> +additionalProperties: false
>> Please put it after "required:" block. See example-schema. This applies
>> everywhere.
> Oops, ok, I will do this.
>>
>>> +
>>> +required:
>>> +  - compatible
>>> +  - "#interrupt-cells"
>>> +  - "#address-cells"
>>> +  - interrupt-controller
>>> +
>>> +examples:
>>> +  - |
>>> +    intc: interrupt-controller {
>> No resources? How does it talk with the hardware?
> CPU configures the core intc using special instructions to access SFR (System Function Registers).

Ack.


Best regards,
Krzysztof


