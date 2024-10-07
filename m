Return-Path: <linux-kernel+bounces-353916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B634299346C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 19:07:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 613591F242A5
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 17:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE7691DC746;
	Mon,  7 Oct 2024 17:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="Sx/M9Q+p"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D681DC721;
	Mon,  7 Oct 2024 17:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728320845; cv=none; b=FL8uESq3U0cfsqjpF6u0sf8GPSTGBBX+lCkE2+lLhJ+tnS/OqTYX5v2LHC6+wCbirJsfbafWnnBwDJ8b1GCUsrWoa4REr6zJ27azz7OGF64feGoFFAc6hMugggpgVp7gAHeC3G3W78jz7SLOFrN+80DVHae7l2vyZxNBrr6Y2SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728320845; c=relaxed/simple;
	bh=OgKd8s6EFJ2msOFVt10PHZsFWvUTkWBcj8TgWznSyhQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Re2y330KvYWGIxdq88+JJvuxsbAx7/2bjSRj/k13jOtjretYqVU2SEMrpLlqz/EOzsf3T8MKuPNb95HjQNyt/OMigKTiXx2iLHkwQigluvAtpW5D6u/hODdT/O8WtEOjwMzneGXhMaJMp6A9UU4rrkhtqDqUb78GH2wRLeySDeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=Sx/M9Q+p; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 2300742C0D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1728320843; bh=oJU7EABAt2KsVj2EIm8/2tYtzj/bx+DV1mQWP+T51B8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Sx/M9Q+pDv1G925eerwGf+0GY4leEAn58FlhLPvoZhAC0UDRF4WFz2RikOL15obHg
	 lFv2jdZbFmQkQ7+3qeqNvkU3aIvIOCCvQYSpPrLrm7W9zzp82+LnVtzv1e0vgc8Xip
	 2HzSnDU/D4Jhr5sJ7zhiymki9VQQTpRD4PU5yaC555C3Fx3GgbdfaGPm9XNCkGUc07
	 DRhzNPlEGkwF+jpxmD64J9orjOKbR30OP203UEV/olmnHALQgukTZy14KT/X3Bhweo
	 oJBLSOQSXa4aKTn0v5hsI9HyLRviZ+8IZSTe0D98IA45CdvVfos9Ngk6wDCczUvgtP
	 3rkKZPF5Wz8BA==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 2300742C0D;
	Mon,  7 Oct 2024 17:07:23 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Andrew Kreimer <algonell@gmail.com>
Cc: workflows@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, Andrew
 Kreimer <algonell@gmail.com>
Subject: Re: [PATCH] docs: backporting: fix a typo
In-Reply-To: <20241002212150.11159-1-algonell@gmail.com>
References: <20241002212150.11159-1-algonell@gmail.com>
Date: Mon, 07 Oct 2024 11:07:22 -0600
Message-ID: <87msjfkfjp.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Andrew Kreimer <algonell@gmail.com> writes:

> Fix a typo in documentation.
>
> Signed-off-by: Andrew Kreimer <algonell@gmail.com>
> ---
>  Documentation/process/backporting.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/process/backporting.rst b/Documentation/process/backporting.rst
> index a71480fcf3b4..18e41e76ecba 100644
> --- a/Documentation/process/backporting.rst
> +++ b/Documentation/process/backporting.rst
> @@ -74,7 +74,7 @@ your source tree. Don't forget to cherry-pick with ``-x`` if you want a
>  written record of where the patch came from!
>  
>  Note that if you are submitting a patch for stable, the format is
> -slightly different; the first line after the subject line needs tobe
> +slightly different; the first line after the subject line needs to be
>  either::

Applied, thanks.

jon

