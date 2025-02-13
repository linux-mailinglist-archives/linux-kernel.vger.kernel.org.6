Return-Path: <linux-kernel+bounces-513460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F23A7A34A81
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 17:46:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F5D61738A7
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 16:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91CE215689A;
	Thu, 13 Feb 2025 16:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="hFCjxbbp"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D5A828A2DE;
	Thu, 13 Feb 2025 16:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739464564; cv=none; b=RPCchV3WvCcrYjSGrqWMjS1h+6/mrwjUcxmRL2+WC9I2fnZcl76flq3Yp8sDK4xleK1T/Qb+8KUGK5dtsLpc9Rph+ujHMtqNLpLRIF74tRLV0zt0UAQTO+wfw4iQy7u7EoCCIoDluMv6ixt5HY14hxa2TJokTMI4k71G8rzqy7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739464564; c=relaxed/simple;
	bh=0MzAe+/zz8BM94vbORyLrX9hrn9VGCXIUL+TcD+ALPk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=smkhcXM0Qadoj6P6nkr4f6ySYb5N3s+vafJENOV/HJgd2aMkL86Bnm2gZ7FRIIxF3E2dPnRvbKw/bmjJni6uuECKaAtxkZ8DYK/mI40qx8oqsyGuqIJHodSca5Yf5SvbYoC8083m2lgxcghVcFQUEsUa/MxlAVkc/y6sXKd8uAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=hFCjxbbp; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 6320844097
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1739464559; bh=mCREvOYTSSlEvg7uFL3Cn8JKxmc33r7oFVvZAruvAj0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=hFCjxbbpHICujl3dOiAlhumYwo5L3OncX05NllUJWX2MtRQgI1EppYj2FrxgquLjM
	 JyfF6skmkonNjexDFypuuLyhOhKKpEOK1PLTdu9th4Wg5sVlS1m+U50QkFXHffn1Tn
	 bNv2DtEqSZ4VtcSkkmskcCaWoFnc2HfIumeZnPneHkYVZIKkOWw6s2GW5CVIuLo+cX
	 7qh+qcXqYjuGF8w6s27UpmbaHBpcxglMA9S503D7fmdZ7LGHQ1v7IASUmf8p+bugo3
	 zsxTjmvZQa36GYqyD5ohg9R9DwKiHzkr8NcLfqPUrwEOXByvKfYZjxb7XBYi5jZVHs
	 4vymVWnQYfIoQ==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 6320844097;
	Thu, 13 Feb 2025 16:35:59 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Linux Doc Mailing
 List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Mauro Carvalho Chehab
 <mchehab+huawei@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scripts/kernel-doc: remove an obscure logic from
 kernel-doc
In-Reply-To: <fd3b28dec36ba1668325d6770d4c4754414337fc.1739340170.git.mchehab+huawei@kernel.org>
References: <fd3b28dec36ba1668325d6770d4c4754414337fc.1739340170.git.mchehab+huawei@kernel.org>
Date: Thu, 13 Feb 2025 09:35:58 -0700
Message-ID: <87wmdt6bv5.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:

> Kernel-doc has an obscure logic that uses an external file
> to map files via a .tmp_filelist.txt file stored at the current
> directory. The rationale for such code predates git time,
> as it was added on Kernel v2.4.5.5, with the following description:
>
> 	# 26/05/2001 -         Support for separate source and object trees.
> 	#              Return error code.
> 	#              Keith Owens <kaos@ocs.com.au>
>
> from commit 396a6123577d ("v2.4.5.4 -> v2.4.5.5") at the historic
> tree:
> 	https://git.kernel.org/pub/scm/linux/kernel/git/history/history.git/
>
> Support for separate source and object trees is now done on a different
> way via make O=<object>.
>
> There's no logic to create such file, so it sounds to me that this is
> just dead code.
>
> So, drop it.
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  scripts/kernel-doc | 19 +------------------
>  1 file changed, 1 insertion(+), 18 deletions(-)

Weird ... I went and looked, and can't find anything that ever created
that tmp_filelist.txt file; I wonder if this code ever did anything?

Don't put that functionality into the Python version :)

Applied, thanks.

jon

