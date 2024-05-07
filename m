Return-Path: <linux-kernel+bounces-171492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BE2E8BE50F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 16:02:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B4391F23A8C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 14:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 296A315F3F3;
	Tue,  7 May 2024 14:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="SRwLjig1"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2490E158D9A;
	Tue,  7 May 2024 14:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715090517; cv=none; b=YgofaOlMuGOE/3euIyCHN5Imyp+W3rYV4RzRBlM/rsJGm6u1Agwm86rhRpNsR96MgRVcc025/z28XJSNC32BmntXlIpdpOU9XbWQopM0osoxzGIHrCFZ9JiOOw2P0meZOSBSI10vYq2sBmtHS854e35l5BP5nMGRTR5ibxK3YcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715090517; c=relaxed/simple;
	bh=I8Jh/c0O3HmeTvddNyCG+LPiNook2RF0dJ160XS3vEE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kbwYnCe6ftBfl5WfBy40DEyGRA8+0tEYWBMt8213u0KMn34IzPGfOv+FCJei+CzhhsPCG2cvIS+J1dfPXlFIlDInty6qdwl+Bp40wXfQjNktlHL0SGs8lL4PXmj20kiHiZ6hsmaXcJQqkljtFxZDxtAihQzxqdcohWKcFqu7auo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=SRwLjig1; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 6785247C42
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1715090515; bh=v8zpDZ52eJJsgwnWvpCntsojxBM4sw48U0a8jeYBkJU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=SRwLjig1A4b9jYCSZ43z5CULRf48H3strCTKj15I7/JjCqzo9uoTeVSy+nTIp/PMx
	 f1nB9w5FFFySKx67fnvolXM5Q9vpGea3B1Ot2sdh2raJ1BYHhs44mfkTiE+jMPt6ZX
	 7yUcOosRU+CP59izZcjoPa/DGctwmNbA+bcvwAzLuuGHM8H5bPRf9iLm3JJVtHIlzJ
	 gYATyXtEUFmZ1kKQgtN06WQV2QQKLBW9UsA2Kw90VLvuc4eEhIhNVffSsc6UEX2JNH
	 AcTrikbDSHFa7VIvtFY3HjuWazJJHHDum2exmiHRpwc/Tqb4n3/PTFw+polvai3wVu
	 y1EXwEx2K5nzg==
Received: from localhost (unknown [IPv6:2601:280:5e00:625:67c:16ff:fe81:5f9b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 6785247C42;
	Tue,  7 May 2024 14:01:55 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Dennis Lam <dennis.lamerice@gmail.com>, chris@chrisdown.name
Cc: Dennis Lam <dennis.lamerice@gmail.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs:core-api: fixed typos and grammar in printk-index
 page
In-Reply-To: <20240502212522.4263-1-dennis.lamerice@gmail.com>
References: <dennis.lamerice@gmail.com>
 <20240502212522.4263-1-dennis.lamerice@gmail.com>
Date: Tue, 07 May 2024 08:01:54 -0600
Message-ID: <87zft1g1pp.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Dennis Lam <dennis.lamerice@gmail.com> writes:

> Signed-off-by: Dennis Lam <dennis.lamerice@gmail.com>
> ---
>  Documentation/core-api/printk-index.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/core-api/printk-index.rst b/Documentation/core-api/printk-index.rst
> index 3062f37d119b..1979c5dd32fe 100644
> --- a/Documentation/core-api/printk-index.rst
> +++ b/Documentation/core-api/printk-index.rst
> @@ -4,7 +4,7 @@
>  Printk Index
>  ============
>  
> -There are many ways how to monitor the state of the system. One important
> +There are many ways to monitor the state of the system. One important
>  source of information is the system log. It provides a lot of information,
>  including more or less important warnings and error messages.
>  
> @@ -101,7 +101,7 @@ their own wrappers adding __printk_index_emit().
>  
>  Only few subsystem specific wrappers have been updated so far,
>  for example, dev_printk(). As a result, the printk formats from
> -some subsystes can be missing in the printk index.
> +some subsystems can be missing in the printk index.
>  
Applied, thanks.

jon

