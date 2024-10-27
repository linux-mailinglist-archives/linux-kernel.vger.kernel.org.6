Return-Path: <linux-kernel+bounces-383829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 282BB9B20A1
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 21:59:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC8831F21D24
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 20:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31697185B62;
	Sun, 27 Oct 2024 20:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MFmKBX8Z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E96184551;
	Sun, 27 Oct 2024 20:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730062759; cv=none; b=dC11G2rt+ev5gC3nCsP5RILCGMnK52F/NGHA/32hJ+d12g77ME8wAl43eEvnuUpENHMEDqcvbjtMYGZS30ZpDIpnBUGM+pXTEMsJyxW4n1ZBJ5dlYui1Ce6fyEHRgDIyewBa4l7rspcJpnTAWei1NoOMTrJT4OOECr4WUfi96+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730062759; c=relaxed/simple;
	bh=fStGl32Y0xAhRyC+Z0PhJYiCdwrf57r+IzTtRSKzzW8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oFtBdVvQwdg9MD6LhbRK9BhPR8tKRT2J0BxQyzpZtfMo6oOkmfH8AvtU59ky2LXZOrfuSsj+d9k+I2p6LVJyChmraJcfNg6w9nxW3K4iWcnkcmBTxOOrS88joJa24Zl1pe3/AJv3YWp2DDxpmGAR4S2VEmrURdKc3aochOVKPV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MFmKBX8Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 825BAC4CEEA;
	Sun, 27 Oct 2024 20:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730062759;
	bh=fStGl32Y0xAhRyC+Z0PhJYiCdwrf57r+IzTtRSKzzW8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MFmKBX8Zmb1TGtjY+m94GvXWW+LoODiIgNZzedH6Ck61f0a+5yCdyjujtVHxUF5Aq
	 XZEnjbJgQ/648z2X5egC9TSYVwIf0dO0UmlTXRV8urAcrH5BlCIM0G9nP8NCCmbNQg
	 WlmsdvEKkFbRrNk4JoFDPfqMlaM2Q/5sqATcg6SVbqcJLrUOEXlmMjT/r4tpeHirs9
	 9z9A1hAEfPI3cCf/AVpqIbzjNK9TmiJkb0WJIqxlNhjxvLKtUh84pV8f9OjviUXKjb
	 5r+gKPPI2YpWXN1UwfaPkdnx+fvZsUaVVUzLlylPxF/4gi9T/ZFP94fOCkrr6BaytB
	 TanqfVhIPYddQ==
Date: Sun, 27 Oct 2024 21:59:15 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Fei Shao <fshao@chromium.org>
Cc: Mark Brown <broonie@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
	Rob Herring <robh@kernel.org>, Steve Lee <steves.lee@maximintegrated.com>, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org
Subject: Re: [PATCH 4/4] ASoC: dt-bindings: maxim,max98390: Document
 maxim,dsm_param_name property
Message-ID: <r2qtuopc6d2vygxghgydole5ixxr4z5weougk7ldadyma4zi56@sp34zufvzdaq>
References: <20241025104548.1220076-1-fshao@chromium.org>
 <20241025104548.1220076-5-fshao@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241025104548.1220076-5-fshao@chromium.org>

On Fri, Oct 25, 2024 at 06:44:44PM +0800, Fei Shao wrote:
> Add the missing "maxim,dsm_param_name" property in the binding.
> This property specifies the customized DSM parameter binary name.
> 
> Signed-off-by: Fei Shao <fshao@chromium.org>
> ---
> 
>  Documentation/devicetree/bindings/sound/maxim,max98390.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/sound/maxim,max98390.yaml b/Documentation/devicetree/bindings/sound/maxim,max98390.yaml
> index 5bd235cf15e6..fa4749735070 100644
> --- a/Documentation/devicetree/bindings/sound/maxim,max98390.yaml
> +++ b/Documentation/devicetree/bindings/sound/maxim,max98390.yaml
> @@ -32,6 +32,10 @@ properties:
>      minimum: 1
>      maximum: 8388607
>  
> +  maxim,dsm_param_name:
> +    description: The DSM parameter binary name (e.g. dsm_param.bin).
> +    $ref: /schemas/types.yaml#/definitions/string

NAK, you cannot document properties post-factum. It's not a property
coming from 2014.

For me, this is obvious that this is for ACPI and if you want to use it
for DT platforms, go through proper review.

In any case: NAK for this and other ACPI properties.

Best regards,
Krzysztof


