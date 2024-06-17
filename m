Return-Path: <linux-kernel+bounces-218373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B7E790BD7D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 00:25:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EA1428229B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 22:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B23EA199239;
	Mon, 17 Jun 2024 22:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="Atr3qmMY"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D293419146C;
	Mon, 17 Jun 2024 22:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718663146; cv=none; b=k+q2N98ZFGSUUnd8SYX+t+FNHklW9PoamurLg6d3YSAH6tEyxAZo30a7SQdr/1n2KfGZfvAKXRZTcmSnNF0b3WXpr50b0Q/OcCkA2V0oNmODUrMZir0Z7HRj2gTdfNW1TBmVxm/q1DovtFwBpwc1OZiqWJgF/fEZV6cGC3xGM8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718663146; c=relaxed/simple;
	bh=BPOTM7iaB9LMCqLSjFWscOBBjKpmTukVqZZy5jfsEyE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qz4tmi21ABoxcSOk3QMnDz/88kgxSz2T/dH8pbw2832uNMipVOkcmu/lfPdM0OAgqDkQneh2ddFgEWUuyY1RCfM5cXTLujGbwuo8MGUwOTydCEhaa4PUbOd92q9V/qPVMrVZbLoMtiWA+QhMSTEMse+A8LvYjDa9p+oHsavPC8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=Atr3qmMY; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 1A0E945E2A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1718663144; bh=H82+wvXyhvj6l/rMq/9uITecpN/HRsCtmlqDYD/RkDs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Atr3qmMYRHb+QpgUszAGnDQmtuQfOk2aVs73ObNKfYnMssTZxr54mPlw+0tKt6dRT
	 U4XPSi1J1XrLo89V1uP6utLmZMrf+HBvGjM8r6o6B1P71LBBJCjJHQPG0M5q8VzV9u
	 c+IqNFkqp7VPJf/MeQN0X5K1pIu8rwcTGplqMXb+qDGqDz8+7+cGYNPhRZo0FhfN/8
	 uhooskGYeN5fAhHIScvhM05COOK7muz7EUIOx1GQHQPjA7tZ5EwjPhDXJrkjxvV4R6
	 zFJZQBJH4kxL4xVvhQnKM2yIXfe0urZ4bZY00Z06HG+Un/sK0cY6KRcOavylnuELOZ
	 BsEf5YiW0ScDA==
Received: from localhost (c-24-9-249-71.hsd1.co.comcast.net [24.9.249.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 1A0E945E2A;
	Mon, 17 Jun 2024 22:25:44 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Thomas Huth <thuth@redhat.com>, linux-doc@vger.kernel.org, Vineet Gupta
 <vgupta@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org
Subject: Re: [PATCH] Documentation: Remove unused "nps_mtm_hs_ctr" from
 kernel-parameters.txt
In-Reply-To: <20240614190804.602970-1-thuth@redhat.com>
References: <20240614190804.602970-1-thuth@redhat.com>
Date: Mon, 17 Jun 2024 16:25:43 -0600
Message-ID: <87le33gqag.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thomas Huth <thuth@redhat.com> writes:

> The "nps_mtm_hs_ctr" parameter has been removed in commit dd7c7ab01a04
> ("ARC: [plat-eznps]: Drop support for EZChip NPS platform"). Remove it
> from the documentation now, too.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  Documentation/admin-guide/kernel-parameters.txt | 9 ---------
>  1 file changed, 9 deletions(-)
>
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index dd8436c98735..f58001338860 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -4143,15 +4143,6 @@
>  			parameter, xsave area per process might occupy more
>  			memory on xsaves enabled systems.
>  
> -	nps_mtm_hs_ctr=	[KNL,ARC]
> -			This parameter sets the maximum duration, in
> -			cycles, each HW thread of the CTOP can run
> -			without interruptions, before HW switches it.
> -			The actual maximum duration is 16 times this
> -			parameter's value.
> -			Format: integer between 1 and 255
> -			Default: 255
> -
>  	nptcg=		[IA-64] Override max number of concurrent global TLB

Applied, thanks.

jon

