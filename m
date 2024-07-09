Return-Path: <linux-kernel+bounces-245897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 77BD992BAFC
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 15:26:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED075B27E21
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 13:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E669161328;
	Tue,  9 Jul 2024 13:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="k15TyeHi"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9223D15ECF2;
	Tue,  9 Jul 2024 13:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720531377; cv=none; b=nbJRXPR0JD7qsxJQiDringim0287VCkZM9C4NOT8WZAz7DRPaQzn3J7IZEi4GnjjERggqMzOFzuYzYzsa1BBF2+/5fGSW7LrfYSnMYDDOqRuxh28AsivpRVUDuqOHwDq3qwI1YuI9yP1RwQXTabZu6+ESyMQUutZpXDZKJOTZ2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720531377; c=relaxed/simple;
	bh=BVpjp6awWafgQXlCutdW0mSjCD1HUnZvA3Y66INIa58=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JA9FXYH1pheKG42bVGbfXnSdImZ4aT4AgMRLIzeXYyJ//aG4dn1AQhCgC1PP8IyXgTxe7gU8tuI1+WGcjh95uV/kpUebsfWbmMdAytlc06m69e712BEgWp9iJGxNTqUCde7gXb/cF7XTUebcGvsZjWR7Nui2hHRLJ+7h9+xdjAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=k15TyeHi; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 284AE41A87
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1720531369; bh=B0IUPEucc7szkKko6Xb/IW+jrIcuCp7pfsHDSlyPkHU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=k15TyeHifGFb3NNzyQwTSKXhp61NeT9c/bwZLYioczuUayP7qWRIJTeWZEgyoZ9yH
	 2wmvFn5CPCI7a7BFNcwNDHNGoKkdHeurMeFY6VhIyGo2x5s7Nndbn/1I2jkmH9e0gV
	 1H32pszl3u9vIGBaiedhcuLm98kl2JuaokZh5mvDqwoTBAOlaKoU++leBl6mn6QDW9
	 vMZEMiVQDSLDUJeHTkb6SrCiSs5CYAXlrapFaiKOfYfsO9vxQdHFgWq9KPEwXAeZuP
	 jolxaeRKOKvLBluLxr+k5vzmvWSvdWIE0fPzSAROG5L9nCSc3hK0Aii3u0/PjiXMJQ
	 kQ2sevom2I2Wg==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 284AE41A87;
	Tue,  9 Jul 2024 13:22:49 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Daniel Lublin <daniel@lublin.se>
Cc: Daniel Lublin <daniel@lublin.se>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: add reference from dynamic debug to
 loglevel kernel params
In-Reply-To: <4c1da56d2f123af8566744ab61c9d41e0b32de64.1720518466.git.daniel@lublin.se>
References: <4c1da56d2f123af8566744ab61c9d41e0b32de64.1720518466.git.daniel@lublin.se>
Date: Tue, 09 Jul 2024 07:22:48 -0600
Message-ID: <87y16a8ztj.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Daniel Lublin <daniel@lublin.se> writes:

> Signed-off-by: Daniel Lublin <daniel@lublin.se>
> ---
>  Documentation/admin-guide/dynamic-debug-howto.rst | 6 ++++++
>  1 file changed, 6 insertions(+)

This change should really have a changelog.

> diff --git a/Documentation/admin-guide/dynamic-debug-howto.rst b/Documentation/admin-guide/dynamic-debug-howto.rst
> index 0e9b48daf690..7e55097e559d 100644
> --- a/Documentation/admin-guide/dynamic-debug-howto.rst
> +++ b/Documentation/admin-guide/dynamic-debug-howto.rst
> @@ -26,6 +26,12 @@ Dynamic debug provides:
>     - format string
>     - class name (as known/declared by each module)
>  
> +NOTE: To actually get the debug-print output on the console, you may
> +need to adjust the kernel ``loglevel=``, or use ``ignore_loglevel``.
> +Read about these kernel parameters in
> +:ref:`Documentation/admin-guide/kernel-parameters.rst
> +<kernelparameters>`.

Rather than use :ref:, you can just say
"Documentation/admin-guide/kernel-parameters.rst" and the right thing
will happen.

Thanks,

jon

