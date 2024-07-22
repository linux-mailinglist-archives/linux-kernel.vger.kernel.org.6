Return-Path: <linux-kernel+bounces-258404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A9EA93878B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 04:38:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B25FF28119C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 02:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8375D101E6;
	Mon, 22 Jul 2024 02:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="A7PkdViW"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C468611E;
	Mon, 22 Jul 2024 02:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721615898; cv=none; b=NDln7gsuvHkDKUCr+AKie/H1/US9tLuHiXYQyvC85Dm6mednvLYzkePuQ1abb5HNbvFqGjw2OmD4+7Fuws+G099oaZeoxnqF+xYTKqtJzRJLTjmoYf/osPTykCUH38Bn14m79GF+0xA1YeAdZjLOSIGhwO5YoLro7pxdVLwQi6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721615898; c=relaxed/simple;
	bh=1WpfDwDKT7mAfQJaUl8WnZY44gd0uRQWiQxMypyIWcg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C885oh//qtC3a59mplgEzG9Ljy7gXft7HnlmaVQ/ecFTqHdi1x7nH3Nh0LQHY+X2ZNtofm0CxQWIKdR2G7+saF2CZ45JUzf5iXF3rW29YAO4zHWXn0zKTCK2WSTAMN6C4ODKDpGo+HdY4gjlMfQn2XhhYR8xhL+muaiYmRbhAUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=A7PkdViW; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=63UgVkJkNjuIXkxwv0mFK2NMA38ylk/jK93RFEn2RoU=; b=A7PkdViW5kkdMWLpP8J2Q4Mfyu
	0B4Xha7krb/49ixExz1CG8UJgNQ4sL0agdOVbAUdfDQFDQ2oxVrNM3r//Q54iBt+oPYLCkhk3t9QM
	9FFR/tBx7HeDVWnLMENf5w00zSq1jm0ND+WoBkb/UOa86zYwmKgDdX48DtZNBurRWqGSdmeccKyCl
	7VM6CS8/hNbvZtSlQgcXnr0SVPIQAdlhS3UZJQymiil3kO4BZYKzYi/y+SqQQC8zU/v59l5UtkJCM
	SU49rN+A0p2M9sTNzRuCjSoPmjs1ohnK5N5ipgCFHgK6TXzdgn4sJsc1Uuz3RREnfWf6KJYC3pjOR
	ytywpF2g==;
Received: from [50.53.4.147] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sViwH-000000087YR-1jst;
	Mon, 22 Jul 2024 02:38:13 +0000
Message-ID: <ab8b08c2-762f-437f-8880-7411bacee3c2@infradead.org>
Date: Sun, 21 Jul 2024 19:38:12 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/16] xz: Fix kernel-doc formatting errors in xz.h
To: Lasse Collin <lasse.collin@tukaani.org>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Sam James <sam@gentoo.org>, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
References: <20240721133633.47721-1-lasse.collin@tukaani.org>
 <20240721133633.47721-6-lasse.collin@tukaani.org>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240721133633.47721-6-lasse.collin@tukaani.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/21/24 6:36 AM, Lasse Collin wrote:
> The opaque structs xz_dec and xz_dec_microlzma are declared in xz.h
> but their definitions are in xz_dec_lzma2.c without kernel-doc comments.
> Use regular comments for these structs in xz.h to avoid errors when
> building the docs.
> 
> Add a few missing colons.
> 
> Cc: linux-doc@vger.kernel.org
> Reviewed-by: Sam James <sam@gentoo.org>
> Signed-off-by: Lasse Collin <lasse.collin@tukaani.org>
> ---
>  include/linux/xz.h | 19 ++++++++++---------
>  1 file changed, 10 insertions(+), 9 deletions(-)

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

-- 
~Randy

