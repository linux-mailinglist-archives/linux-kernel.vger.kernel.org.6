Return-Path: <linux-kernel+bounces-399620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A44749C01CA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 11:02:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E2731F23A9E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 10:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7DDB1E8825;
	Thu,  7 Nov 2024 10:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ls+pTpqK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D7611713;
	Thu,  7 Nov 2024 10:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730973739; cv=none; b=duAJphVbl8aY/33QsOmMGL0pN/dka6Mg8HJfmaj4QT41SEj+EN0FGDs5ls/PlwY/+ryHFgc4Jjds3v7u9nxueZEnnLXIOxAyq4wQIXuQw3JmHg/AiXsc6+jm5jwixzcyDEf5O81z+1IuzzzSnbsiiZvtKZgoX1ZaatVvMBVaZV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730973739; c=relaxed/simple;
	bh=eYH2ACgbRqffR/sv/0uuECjlgyo1XRetpJbSYf2Khb8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mQBtdWM+PPcXsJFqDeuWbIIX3Xlm6s1BBpAMY2QukHoTEFiteuZdM/GLINhDHX96UfrOttvlgMfDl90nTU2zZ5iCx15f0sfImGEmLPOvPdsFReahHzV7xB0JGx5/2+4N7t9blXWKRIl/A5OyPf3Yz9752boFlykwRAlQWQg2iKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ls+pTpqK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9111EC4CECC;
	Thu,  7 Nov 2024 10:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730973738;
	bh=eYH2ACgbRqffR/sv/0uuECjlgyo1XRetpJbSYf2Khb8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ls+pTpqKEVFBnjSler0aLSN7NjB7FCMguWmgezFpnazhMTTmT+zdNwoSPyeWZ4geE
	 /E/4bW9ZVWubuCw8uzmb0OKRJ+Hg8AEz3JX1h5M9yct2/0AH/7gru09Rp8MRXXJSNz
	 Bla2G6XeEfYocOo0gX6FlRrG24nGsQVGg2gTkC0sxssM1ubKv6vhv/ozXxswt42vIu
	 cdEnYxCci4D6GiVNSYK7RoTWQcdlpC+r2ww6TqFgITVLRHXQNS6KCHTo11BZ+eBxCx
	 CWIAPBhT63Ku2OjWvmmUonjYI5kpaZ87vC0FUHRdk33dxmV06cyP2248FUX+l7sGGm
	 stpvNEjMt5l+Q==
Date: Thu, 7 Nov 2024 11:02:13 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Kiseok Jo <kiseok.jo@irondevice.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org, 
	linux-sound@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v4 1/2] ASoC: dt-bindings: irondevice,sma1307: Add
 initial DT
Message-ID: <butx33avx7zainw6im72kwdxj6jfvfbdlzugxadu6rfn3uszdx@oxgvrnfl5t5h>
References: <20241106233144.9283-1-kiseok.jo@irondevice.com>
 <20241106233144.9283-2-kiseok.jo@irondevice.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241106233144.9283-2-kiseok.jo@irondevice.com>

On Thu, Nov 07, 2024 at 08:31:44AM +0900, Kiseok Jo wrote:
> This adds the schema binding for the Iron Device SMA1307 Amp
> 
> Signed-off-by: Kiseok Jo <kiseok.jo@irondevice.com>
> ---
> v3 -> v4
>  - Modify to fit the character-per-line format

<form letter>
This is a friendly reminder during the review process.

It looks like you received a tag and forgot to add it.

If you do not know the process, here is a short explanation: Please add
Acked-by/Reviewed-by/Tested-by tags when posting new versions, under
or above your Signed-off-by tag. Tag is "received", when provided
in a message replied to you on the mailing list. Tools like b4 can help
here. However, there's no need to repost patches *only* to add the tags.
The upstream maintainer will do that for tags received on the version
they apply.

https://elixir.bootlin.com/linux/v6.5-rc3/source/Documentation/process/submitting-patches.rst#L577

If a tag was not added on purpose, please state why and what changed.
</form letter>

Best regards,
Krzysztof


