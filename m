Return-Path: <linux-kernel+bounces-302260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DDF4095FBCC
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 23:37:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C7B51C20D81
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 21:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAA5B19B3D8;
	Mon, 26 Aug 2024 21:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="epK3hZDV"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84207F7FC;
	Mon, 26 Aug 2024 21:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724708269; cv=none; b=e/gMn8XZbd3Gn2deK9buLpv7++UImjrbfLiDdfkfbM6W1rTJr2ZuUMRlvLFcjIU+kBFJ0nV+/eWWrkopSAX9MEFTp6aH2fz1iDa86UAQ+FPTYcm2f1p10/G1ydvjG1nD+TGGYx3XegveLcE6iuRXFBfh26XI0GJsf5KPIgkLW3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724708269; c=relaxed/simple;
	bh=aW9wia3uk6XOGc9qgz2oY52IEKNMNOCAMK+SWniio6g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WN7CdmYejhijpG6BJKz1hcsR+8QxcTJSRj50L477UwuRHOxMKiisALb4vlC+oiCiPp5vhLGy4ovxXZVtHdSk6DGu9ChBv/SMOWmXPrq41VNY8+i8h6gjckuWAUT/0UF6yE0V9Zj4O85RoZKPlKFHMCMYwIWweMFbZsQ6L1tAZ6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=epK3hZDV; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 03C0845CC6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1724708267; bh=LDX3Y5+Jha9vksTAxf461nNLNTuxgcR9NT6a1WSlGAc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=epK3hZDVzFqiqxXHf5x+3Uu+NyVjpbx/5vVWvBs4GeCYD9tx5lGvXIiLPRwziVa3S
	 cvnC0qHNrjzXqaSvA1pBD5yJ0n70z4SsqGYFJp0IcFjJVZuhnBn8hPjZQa8oGF4PcV
	 rMWb8rq5DJ35Q+OMYg6O8DJOWAuooQs1FmMWp1Zzvjs4HogS1y1bTL/q5E6iNn17kQ
	 zK+wgNawqqrsBihN7BrGwH4yxJNoKnyCdYP8zAHaZ1jpfB4Tdn0QQtFj6bO56blVBZ
	 HRU73scTAO0DaJUdZD4JeUREP2gt5pMOOizUZOqp/GE1KX3UiRqOUTNMCUDrY0V/Ds
	 OqxohbDJzMyMA==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 03C0845CC6;
	Mon, 26 Aug 2024 21:37:46 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Gianfranco Trad <gianf.trad@gmail.com>, akinobu.mita@gmail.com
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Gianfranco Trad
 <gianf.trad@gmail.com>
Subject: Re: [PATCH] Fix typo "allocateed" to allocated
In-Reply-To: <20240819110641.1931-1-gianf.trad@gmail.com>
References: <20240819110641.1931-1-gianf.trad@gmail.com>
Date: Mon, 26 Aug 2024 15:37:46 -0600
Message-ID: <87wmk355jp.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Gianfranco Trad <gianf.trad@gmail.com> writes:

> Fix minor typo in the fault-injection documentation,
> where the word allocated was misspelled as "allocateed".
>
> Signed-off-by: Gianfranco Trad <gianf.trad@gmail.com>
> ---
>  Documentation/fault-injection/fault-injection.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/fault-injection/fault-injection.rst b/Documentation/fault-injection/fault-injection.rst
> index 70380a2a01b4..9170e22db215 100644
> --- a/Documentation/fault-injection/fault-injection.rst
> +++ b/Documentation/fault-injection/fault-injection.rst
> @@ -283,7 +283,7 @@ kernel may crash because it may not be able to handle the error.
>  There are 4 types of errors defined in include/asm-generic/error-injection.h
>  
>  EI_ETYPE_NULL
> -  This function will return `NULL` if it fails. e.g. return an allocateed
> +  This function will return `NULL` if it fails. e.g. return an allocated
>    object address.

Applied, thanks.

jon

