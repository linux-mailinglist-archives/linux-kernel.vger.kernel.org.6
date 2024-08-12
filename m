Return-Path: <linux-kernel+bounces-283841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3022194F958
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 00:08:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 627F51C2228A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 22:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3EC3194C83;
	Mon, 12 Aug 2024 22:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HBRqNDvB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB9916DEAB;
	Mon, 12 Aug 2024 22:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723500474; cv=none; b=R6W/egmXtFQpKe8aOmm8a+nWqb2Oy9MoRcfp1EXtbiWjTzMjdqI96Sdnnbf5+8JzfLTcIszafoReKwmDq4/fpBkmucs9WdajdhjG4ddBnKAP0LOG80Ir38eYL5N7FMpKUkT7EblrTf01q8WIttu6WFScbLeh6Ad5IiZs9skFyAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723500474; c=relaxed/simple;
	bh=hfNQdjFl3+0TDoQHZP71Q8L+ao31aSFSQPDJnD6kSEU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y0KX9qXvPhCUKNB+yKY9J8Rc4q7cjyVJFrjaHxLEZfrjpXB3vONM6OKPDIQ18S/dlqJFlfg4UXU3I13qIx/pVdz7OUgHDobV8z3Z73ent2riEQStRu3JBLghmmoKdDGeGqjixx+yuyKEJe4GzQknWxroZBdjFYECGei4rqS5GzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HBRqNDvB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C407C4AF0D;
	Mon, 12 Aug 2024 22:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723500473;
	bh=hfNQdjFl3+0TDoQHZP71Q8L+ao31aSFSQPDJnD6kSEU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HBRqNDvBu1wkWO5iTmpwEXJHwLTYVqLkdUtLKnPfldmTxQaOkwkIvgceRz+3ahXbT
	 5Elhh67y1/QLfw58IvNm+owPDkf4rP5J8lF9v35OgDhpvabTMhup33VJGV2xnCQypi
	 Cm/zkh3DvXW3b0sC3HdnuOgfJ+NPUXAWoj7EkBVWFdyWzb0V7Eo0dIqHH3G6imk84R
	 S3F5Et6uCu5zeEeTFizvWpnbX11x3URGZk0lgKZSmA7PL3gsfLyUXxFRlZOvQ/HzcN
	 3uJVicvxi+6qyet7Z90KtXseNkmskOGj0NGk815b+mKgGVryrNWj7306hiYBfoR6H5
	 J90JUrvsQ/gcA==
Date: Mon, 12 Aug 2024 16:07:51 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Conor Dooley <conor+dt@kernel.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	devicetree@vger.kernel.org, Frank Li <Frank.Li@nxp.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] dt-bindings: fsl: fsl,rcpm: fix unevaluated
 fsl,rcpm-wakeup property
Message-ID: <172350046483.2314917.7547438885110898301.robh@kernel.org>
References: <20240811153507.126512-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240811153507.126512-1-krzysztof.kozlowski@linaro.org>


On Sun, 11 Aug 2024 17:35:07 +0200, Krzysztof Kozlowski wrote:
> Drop the RCPM consumer example from the binding (LPUART device node),
> because:
> 1. Using phandles is typical syntax, thus explaining it is not needed in
>    the provider binding,
> 2. It has 'fsl,rcpm-wakeup' property which is not allowed by LPUART
>    binding so it causes dt_binding_check warning:
> 
>    fsl,rcpm.example.dtb: serial@2950000: Unevaluated properties are not allowed ('fsl,rcpm-wakeup' was unexpected)
>      from schema $id: http://devicetree.org/schemas/serial/fsl-lpuart.yaml#
> 
> Alternatively, this property could be added to LPUART binding
> (fsl-lpuart.yaml), but it looks like none of in-tree DTS use it.
> 
> Fixes: ad21e3840a88 ("dt-bindings: soc: fsl: Convert rcpm to yaml format")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/soc/fsl/fsl,rcpm.yaml         | 11 +----------
>  1 file changed, 1 insertion(+), 10 deletions(-)
> 

Applied, thanks!


