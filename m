Return-Path: <linux-kernel+bounces-287563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF55695295E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 08:30:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 857DA1F239E8
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 06:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 251C715CD6E;
	Thu, 15 Aug 2024 06:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="DrPxR345"
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB95F18D65A
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 06:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723703446; cv=none; b=u0q5B9W+Zzv89jQtTXMi3VOyqzpngWMx1hqsAGV4+dK3xXaHew3xpcN6ytqVbGhskpy4s+quDIigAohX4or1SGVvqPgATrNzcLdhgMbacFpDYj7WOI0lUUV2gkCDTq+Co1q7AypXObDJbbHn3CrwYHH6jN6BD/IiueI383YaV8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723703446; c=relaxed/simple;
	bh=F/Oy9V/ctHL5djnfOP3acxQzXED1PmGHLAwRZAQIX/8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e2AMVdGdKKt2s/cJlXIa+rCH7mP+MJavaRhN+nAjKqvQ1H1i620fg68u5izliTPP+RaUAaX1PEHeObjCHcQft+XD/m6uyn5XtJXx+0S+e+eiSvi3JcMrPVOd3nArx1JFzai9E4Oh/RAmsm+OEPQi7gLTHWzwnuMwcNbL5mwV8L4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=DrPxR345; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4WkwGy3Jsdz9tJZ;
	Thu, 15 Aug 2024 08:30:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1723703434;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CK4141k8BNCO4jrS2GBigSCKMddiD/IO3x0nliEKLGw=;
	b=DrPxR345zBE7gj1klnGOV6GdM8hdQiamly5nw2JtMoW0DogTF7/6+3DO0nph3+f+/LKnzK
	qfhF9+3b/VPUpsN1B0eocaQGwAwT0LYRDzF8zP9TT9ccQrfsEbZiw89bDGO9NblNWeO5ot
	qG94vRCW7JV2eTSYf8eIxoe2MzhdxzWJEtrNm0UXy9l1YHOfypYVaX4jJbDE9AEkfU296g
	1c2spburZlxV0PX7p/tfqrMV2zHvxZAr2i8pHxBfyRl4XPYjEfdKyS16UAcLI5Estwfp1o
	2vRPYhDsLOXM0mYKQFb04yF9ovYHu9iiCgZ4Cfw3LhE/+Ls6XEHK45b7pdksPw==
Date: Thu, 15 Aug 2024 08:30:31 +0200
From: Erhard Furtner <erhard_f@mailbox.org>
To: Ivan Orlov <ivan.orlov0322@gmail.com>
Cc: akpm@linux-foundation.org, kees@kernel.org, davidgow@google.com,
 kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kunit/overflow: Fix UB in overflow_allocation_test
Message-ID: <20240815083031.03c1cac4@yea>
In-Reply-To: <20240815000431.401869-1-ivan.orlov0322@gmail.com>
References: <20240815000431.401869-1-ivan.orlov0322@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: yfi9ge5yw9d5ixgk8d6jtkfk6ee8ao74
X-MBO-RS-ID: 32918510ed561d00d21

On Thu, 15 Aug 2024 01:04:31 +0100
Ivan Orlov <ivan.orlov0322@gmail.com> wrote:

> The 'device_name' array doesn't exist out of the
> 'overflow_allocation_test' function scope. However, it is being used as
> a driver name when calling 'kunit_driver_create' from
> 'kunit_device_register'. It produces the kernel panic with KASAN
> enabled.
> 
> Since this variable is used in one place only, remove it and pass the
> device name into kunit_device_register directly as an ascii string.
> 
> Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>
> ---
>  lib/overflow_kunit.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/lib/overflow_kunit.c b/lib/overflow_kunit.c
> index f314a0c15a6d..2abc78367dd1 100644
> --- a/lib/overflow_kunit.c
> +++ b/lib/overflow_kunit.c
> @@ -668,7 +668,6 @@ DEFINE_TEST_ALLOC(devm_kzalloc,  devm_kfree, 1, 1, 0);
>  
>  static void overflow_allocation_test(struct kunit *test)
>  {
> -	const char device_name[] = "overflow-test";
>  	struct device *dev;
>  	int count = 0;
>  
> @@ -678,7 +677,7 @@ static void overflow_allocation_test(struct kunit *test)
>  } while (0)
>  
>  	/* Create dummy device for devm_kmalloc()-family tests. */
> -	dev = kunit_device_register(test, device_name);
> +	dev = kunit_device_register(test, "overflow-test");
>  	KUNIT_ASSERT_FALSE_MSG(test, IS_ERR(dev),
>  			       "Cannot register test device\n");
>  
> -- 
> 2.34.1

Thanks Ivan!

I can confirm that your patch fixes the KASAN hit on ppc32 when the overflow_kunit test is built as a module and modprobed later.

Regards,
Erhard

