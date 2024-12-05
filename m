Return-Path: <linux-kernel+bounces-432732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8DC69E4F88
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 09:16:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A4FF286CE4
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 08:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13C351B2186;
	Thu,  5 Dec 2024 08:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AIKVnjdg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687482391BC;
	Thu,  5 Dec 2024 08:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733386612; cv=none; b=p3nJedMZnqEyvqm1z7JdrWLy7M/lkVPJTuMCZVkfwgv9Vx+POVDBuz8sD8i0IfsqRxxOycmxZtBTTu12v3R7MgosQzTXBUdGXxoP53SaxqfOkLWWEAwM8SuezPefAvUiD8oyeHYOWGRabLsuWeJY+Z3cvm4SwhTdBJ0o8Q2gm2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733386612; c=relaxed/simple;
	bh=v5YMVBLFaNQyG3N8yGkbXOj72cn8bq1dBgHNk+/bZkY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oDpeUqk0GBT3ocochk9WJhgnTRomsdscEr3w/O0M9zK+BGe0OmUXIsV6ZU37qGSakvUIvZbBuVtuqtz2GsTO7j6X4H8SRT7YFNLQtQIHC+w0nd5Fa5LLR9jpc8xMxKqxKUu2JqZCy9hSKILI5bEZnaAHgXQJ8/ryTuUMhmwG4K0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AIKVnjdg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BDCBC4CED1;
	Thu,  5 Dec 2024 08:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733386612;
	bh=v5YMVBLFaNQyG3N8yGkbXOj72cn8bq1dBgHNk+/bZkY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AIKVnjdgpYOAF4L/6FlAtcAhJFHh4xev7UfxqA2l+ZnfHiqERX+6EzaroIgUXXCpU
	 Dua6HfKGySb7XskcQ8aLXSe2HsTJWmL1JhBadbTlhsH4xyADdIzeS3CcvZq3kKGdMt
	 f9ajM0l9i42fm5iQrRT1UI31re78agJ6VtmKlKw4qAZNzdTiIQSnF21wK9TSoXr2gd
	 lBmmQ6rhA67MZfxWmIaFiw+S3pP7xk6T/kMPRYw4Y+WDzEi2lSMMV7qvcy7q4HgWLc
	 4vC75sqN1clPjRixrDBcO+9ZtGPtFYySgGJhgpQeMYGlYrAjj9NgnzLC7XIMLIRipk
	 HNeCNmNKMhyOg==
Date: Thu, 5 Dec 2024 09:16:49 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Nikolaos Pasaloukos <nikolaos.pasaloukos@blaize.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	James Cowgill <james.cowgill@blaize.com>, Matt Redfearn <matt.redfearn@blaize.com>, 
	Neil Jones <neil.jones@blaize.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, soc@lists.linux.dev
Subject: Re: [PATCH v5 6/6] MAINTAINER: Add entry for Blaize SoC
Message-ID: <h5awakp52e6pxnnfrclhtlhhs3i66twvmqwlf5vmnfwk2xhbwr@marp6wti72ti>
References: <20241204-blaize-blzp1600_init_board_support-v5-0-b642bcc49307@blaize.com>
 <20241204-blaize-blzp1600_init_board_support-v5-6-b642bcc49307@blaize.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241204-blaize-blzp1600_init_board_support-v5-6-b642bcc49307@blaize.com>

On Wed, Dec 04, 2024 at 04:05:29PM +0000, Nikolaos Pasaloukos wrote:
> Add MAINTAINERS entry for Blaize SoC platform with a list of
> maintainers.
> 
> Signed-off-by: Nikolaos Pasaloukos <nikolaos.pasaloukos@blaize.com>
> ---
>  MAINTAINERS | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 273a84483b74543b510de7b08804bbd1f6514358..43846a23f9d990ae9fe066e65ed2bdd36376e327 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2238,6 +2238,15 @@ F:	arch/arm64/boot/dts/bitmain/
>  F:	drivers/clk/clk-bm1880.c
>  F:	drivers/pinctrl/pinctrl-bm1880.c
>  
> +ARM/BLAIZE ARCHITECTURE
> +M:	James Cowgill <james.cowgill@blaize.com>
> +M:	Matt Redfearn <matt.redfearn@blaize.com>
> +M:	Neil Jones <neil.jones@blaize.com>
> +M:	Nikolaos Pasaloukos <nikolaos.pasaloukos@blaize.com>

Just to be clear: this is list of active maintainers, so all above are
supposed to perform reviews or maintainer duties. This is not
credits/managers/I-need-to-please-someone list.

With the assumption these are active maintainers:

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

They should also ack it to confirm they understand the burden.

Best regards,
Krzysztof


