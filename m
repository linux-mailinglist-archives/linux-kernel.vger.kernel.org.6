Return-Path: <linux-kernel+bounces-211634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13D739054B1
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 16:03:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1C43B268B0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 14:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D5A117D8B1;
	Wed, 12 Jun 2024 14:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VrG6lVNe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B63017B4F1;
	Wed, 12 Jun 2024 14:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718201013; cv=none; b=gFWDvzWqGpP2X1/A5RT6uXH8atDRiHKraLQhHT282OngWlQ/JrOEdEg4Koif5I4+kT+dTKwiMuAnx3OoiKGMMBOiJLERac0UPg85yzT/ZEfqb6eAbUbHAIddmFvZlKjZNsGGYn6ECZhYYo40ZiSWyp5ghO5iMxgf3VVqzaLUaJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718201013; c=relaxed/simple;
	bh=T+d5/w/TrCDK3gbxr4NrNSoQldtcv42SmPQU3MNE7+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ag0gI6I0fRmAXQRjrvfo/kDZn8u8+EYVUt8Ulbx4GUTmrZ+N4GSBoo2NRVRWdOd6/rJpfX9Jy3Xqc/Ibe9f+di6PXuHc3oe2LlD60rOa0PiyrTYKXljHKwdtXdacUnwhR6tVvHowdCuGUxZ8ubTCpPd2iOgrAVqXIxuES5Xzfg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VrG6lVNe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52A89C4AF1A;
	Wed, 12 Jun 2024 14:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718201010;
	bh=T+d5/w/TrCDK3gbxr4NrNSoQldtcv42SmPQU3MNE7+8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VrG6lVNebfEEcNcaKfdsPm/90t3QuvUTE9d47oKtx4M8Hbu/H24D/4BKoxQvOElGM
	 l6ebdhLXq3nsuvcxOoKZ4q1OCoWRiaklCEdcwQwY+602efpNbpkIQNZIsdkGpD9zqW
	 es7b2cN3IyrSvOOrepEQRYs1sJvRXVyujYHVJqSDFowzt3nJSABh7+wbPgbMg28Qud
	 Op3T3ShwqploZFnEfzphqXkXVpi2cHRvgy8t6LJzjtaALblib8gPTorAkfTiLkjnKN
	 LcZ7XLjaJUUiiUInxUgIIswwiN3BTNhS0fpiOcChJuLCNUMOURhj6og2Y7bIMO4JNw
	 nCaaW6BLdJ77w==
Date: Wed, 12 Jun 2024 15:03:26 +0100
From: Lee Jones <lee@kernel.org>
To: Andreas Kemnade <andreas@kemnade.info>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	broonie@kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] dt-bindings: mfd: twl: Fix example
Message-ID: <20240612140326.GD1504919@google.com>
References: <20240612134039.1089839-1-andreas@kemnade.info>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240612134039.1089839-1-andreas@kemnade.info>

On Wed, 12 Jun 2024, Andreas Kemnade wrote:

> Fix example to also conform to rules specified in the separate
> not-included gpadc binding.
> 
> Fixes: 62e4f3396197 ("dt-bindings: regulator: twl-regulator: convert to yaml")

If this was applied via Regulator, that's where the fix will need to go.

Acked-by: Lee Jones <lee@kernel.org>

> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---
>  Documentation/devicetree/bindings/mfd/ti,twl.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/ti,twl.yaml b/Documentation/devicetree/bindings/mfd/ti,twl.yaml
> index 2cbdd238f48f..e94b0fd7af0f 100644
> --- a/Documentation/devicetree/bindings/mfd/ti,twl.yaml
> +++ b/Documentation/devicetree/bindings/mfd/ti,twl.yaml
> @@ -225,6 +225,7 @@ examples:
>          gpadc {
>            compatible = "ti,twl6030-gpadc";
>            interrupts = <6>;
> +          #io-channel-cells = <1>;
>          };
>  
>          rtc {
> -- 
> 2.39.2
> 

-- 
Lee Jones [李琼斯]

