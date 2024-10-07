Return-Path: <linux-kernel+bounces-352785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDDF999241B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 08:07:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A09571F22EFA
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 06:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0D3013D53E;
	Mon,  7 Oct 2024 06:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rgif4kiB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356CE2744D;
	Mon,  7 Oct 2024 06:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728281252; cv=none; b=AzDQRMqkvjTRj7TJLzIsKpsB8YOMJdr5auo3xRbFTYaPDo+YnFRA64z0Ut8nJwHgtoLWSQ4JPkom2PJyupHXKCAqC+nj6QjlrVGrZgrrO9o49CtZUq0T4NT5mXa6yR4mfklWp/fH3O1iqyj2rSZorBvxTHinImFu8NsrYEAGh48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728281252; c=relaxed/simple;
	bh=TJDZRfnnzX+xy8MEiw6sdpR/evFaYYUlQz5KOokMWuM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dx5HZ9I4Cp+uvMvwn96wYQx25Qs3YPhaad+VQTdivRu9jHvb6nncydyecHqSIO0sjSiLxY1NmeNE1y0szskYvWeh+mxBYp/bXdoYVNy6Z8rCMXr9HxsdygXM7P+4mEWXnmYWyXEzHr/BfVl/xMFwDVFQcVwDrxNXb/xlY81fW9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rgif4kiB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9303C4CEC6;
	Mon,  7 Oct 2024 06:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728281251;
	bh=TJDZRfnnzX+xy8MEiw6sdpR/evFaYYUlQz5KOokMWuM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rgif4kiBYf98qIriEbWJ1RlmAXJ9t6cVkAwy7wqP5ktAykrx662rDDUgsE/hpsf/r
	 Qg9WpDC40ZBG26HTlVv2/k4C5pssboAbKtiHKQ2FPE+QZAY5NIVpeosAvWifDnDhVR
	 3kUUk3l/OPX+xCjNKzGoI55bCNOaO0wd4G1vkwh/cISivY4+OmTo9zAOWgnKiqvOcp
	 3lppdvzdZJSrTDLB8cwdCRKvEL6b6EdRRDocvYsKapepqGq0EQ9Mza9GOunWfcOt1h
	 40pMIA9XpAiAnynnNvdenyCyxTUBOkk7WpaWNU9oG/GvFIsYE543BV6l8svTVcyd5D
	 zKhAXRKa8JeTA==
Date: Mon, 7 Oct 2024 08:07:27 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Marcus Folkesson <marcus.folkesson@gmail.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>, 
	Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org
Subject: Re: [PATCH v4 2/2] dt-bindings: mtd: davinci: convert to yaml
Message-ID: <deeflg5wd756tkfr6zdta4imuc7ijwl56yclfwiqexlqdq6jsk@5za5g6i7wj6k>
References: <20241006-ondie-v4-0-ff9b9fd9a81d@gmail.com>
 <20241006-ondie-v4-2-ff9b9fd9a81d@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241006-ondie-v4-2-ff9b9fd9a81d@gmail.com>

On Sun, Oct 06, 2024 at 03:05:47PM +0200, Marcus Folkesson wrote:
> +  ti,davinci-nand-use-bbt:
> +    type: boolean
> +    description:
> +      Use flash based bad block table support. OOB identifier is saved in OOB
> +      area.
> +    deprecated: true
> +
> +required:
> +  - compatible
> +  - reg
> +  - ti,davinci-chipselect
> +
> +additionalProperties: true

That's a final device schema, this cannot be true. Why you are doing
this entirely different than all other bindings?

You wrote in changelog, that you "silent the errors". Sorry, but that's
a no go. You are not suppose to silent them, but FIX THEM.


> +
> +examples:
> +  - |
> +    nand-controller@2000000 {
> +      compatible = "ti,davinci-nand";
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      reg = <0 0x02000000>;

Keep order like in DTS coding style.

Best regards,
Krzysztof


