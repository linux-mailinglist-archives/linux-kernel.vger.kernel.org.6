Return-Path: <linux-kernel+bounces-556899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3156EA5D040
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 21:00:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCDF7189F45F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 20:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21C61262819;
	Tue, 11 Mar 2025 19:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rBPJVxj5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F63D1EBFE1;
	Tue, 11 Mar 2025 19:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741723195; cv=none; b=Y8dEeLdI7+sXcSIvPIqnH53NeEGGKeo8c1NUmZbBKL+ncBXTUiHII3Wfv2VW+mFyoLDGiFrw+pbfiH5Ou2lBit/qdRrtNBr1hHeyuIg5JNGyuMfKKWdZqjtpOsa29PcWcpoVo6QflhaaVb5MmkdeX44wmLrFKZ8OMMtl/ilfPvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741723195; c=relaxed/simple;
	bh=a7ft1FG1P7enHItsLHhcaGuRIOritOtiGuKBj8oJcz0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZhKojm1CWOTHlAQLQGb4Mto5fQkUAb9STZv2/yjJq5a03gKQsmBzdZKfWHw4HKPP504j9Ckph9dN4m/7GqTZGbLISvPyTNAiGa0nSbucXB8TfMoE7RGXiZX5mOeHx1ctJI5SSdJGJAHSvdpsP9gG6iobaE6aml0RWXtMkgEcvDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rBPJVxj5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB074C4CEE9;
	Tue, 11 Mar 2025 19:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741723195;
	bh=a7ft1FG1P7enHItsLHhcaGuRIOritOtiGuKBj8oJcz0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rBPJVxj5GfO21nu2i/ZfFuupxvCFPw+ws7YV96bY5T36lgy7bR1ghLdlq6zhwpjYD
	 AjFkGbeiwuXM8XLoL8oXgzYKFkxw6Mu5e8W3L7nh10Lygxx9aEC8lKjPb74hTiBW6Q
	 dcSSc9ncWHoMFz+4dw6VwSbOkH/FrVu8b4IHsr1WpYQGIzBs3Cg8I6PSpe5OobeAE3
	 hm/VSJhkpO+RDpIY5lvajhX3CSu7qTezLTvk2qQcHIhCMK3tBg7nqkAmpjJOj56Au0
	 bepj+jVJftYM6Cd+mEWGdHYLehGGfh7cqwwNlC303BfLQb40Qi6YME/WOVxU7Gucn7
	 Uz0C8nD1UoW2w==
Date: Tue, 11 Mar 2025 14:59:53 -0500
From: Rob Herring <robh@kernel.org>
To: Nick Hu <nick.hu@sifive.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Anup Patel <anup@brainfault.org>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH] dt-bindings: timer: Add SiFive CLINT2
Message-ID: <20250311195953.GA14239-robh@kernel.org>
References: <20250311051903.3825-1-nick.hu@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250311051903.3825-1-nick.hu@sifive.com>

On Tue, Mar 11, 2025 at 01:19:03PM +0800, Nick Hu wrote:
> Add compatible string and property for the SiFive CLINT v2.
> 
> Signed-off-by: Nick Hu <nick.hu@sifive.com>
> Reviewed-by: Samuel Holland <samuel.holland@sifive.com>
> ---
>  .../bindings/timer/sifive,clint.yaml          | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/timer/sifive,clint.yaml b/Documentation/devicetree/bindings/timer/sifive,clint.yaml
> index 76d83aea4e2b..93d74c504b5f 100644
> --- a/Documentation/devicetree/bindings/timer/sifive,clint.yaml
> +++ b/Documentation/devicetree/bindings/timer/sifive,clint.yaml
> @@ -36,6 +36,9 @@ properties:
>                - starfive,jh7110-clint   # StarFive JH7110
>                - starfive,jh8100-clint   # StarFive JH8100
>            - const: sifive,clint0        # SiFive CLINT v0 IP block

Notice that we don't allow clint0 by itself. We shouldn't start now.

> +      - items:

If you don't have a specific one yet, then add '- {}' for the first 
entry.

> +          - const: sifive,clint2        # SiFive CLINT v2 IP block
> +        description: SiFive CLINT v2 is the HRT that supports the Zicntr
>        - items:
>            - enum:
>                - allwinner,sun20i-d1-clint
> @@ -62,6 +65,22 @@ properties:
>      minItems: 1
>      maxItems: 4095
>  
> +  sifive,fine-ctr-bits:
> +    description: The width in bits of the fine counter.

maximum: 15

Unless you know of a different maximum in which case why aren't you 
documenting that too?

> +
> +if:
> +  properties:
> +    compatible:
> +      contains:
> +        const: sifive,clint2
> +then:
> +  properties:
> +    sifive,fine-ctr-bits:
> +      maximum: 15
> +else:
> +  properties:
> +    sifive,fine-ctr-bits: false
> +
>  additionalProperties: false
>  
>  required:
> -- 
> 2.17.1
> 

