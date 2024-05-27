Return-Path: <linux-kernel+bounces-191206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77A0F8D0843
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 18:24:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6142B27297
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 16:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2ABF15F41D;
	Mon, 27 May 2024 16:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="nRhYPpcP"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84CD417E8EC;
	Mon, 27 May 2024 16:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716826313; cv=none; b=ZN5HyfUmrQVN1SnIg/EZL/5Nx4QBYuSpej1kW/dBGQ6S27j9KkxU3SLsQKtcfS4YEuVE03nfOfyVtY+2G5AdmFZ/bCpXPVLKFTlMrhm1Sz13ZOsu4wUkFBCLT2M8R9Qagu/aBak8FnkAxS++7vyH9LFkSWuyo1aiWnITtGoS0Yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716826313; c=relaxed/simple;
	bh=AZo4vcTw7yyS0pCRmU4gDq31dsX62WYBOqt2MYCWD7U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n0a5qqS93y51OFCCpd08NS6yuVNRgmZBzUe/ccUT7mWULtUvh+ydMIz3jzddGUut1t/wNpzoeXDHiMay9TIZSkwaIvTDaJfsyElM58kXfLStKAlSMzhXstTjgODIAZyFflKLkVJIi/rHffFoqQP4sCx15tWwtzVabvBb83igOz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=nRhYPpcP; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1716826306;
	bh=AZo4vcTw7yyS0pCRmU4gDq31dsX62WYBOqt2MYCWD7U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nRhYPpcP7rG/gEdPcMFKZYWZAh9R+swqfkZKG0mtRm1aOZwm117RbCYKdV0tBwAVR
	 wjyOfSTCgVvo6Svp5YI9IoYKrjEdKSS7jLH6upNC8xnolkNd9nUxoVV0f1DNQsJ51H
	 86eMSDeWIIveKZS3/W3aEIvdEBqanlqLrji8GL/E=
Date: Mon, 27 May 2024 18:11:46 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Shuah Khan <shuah@kernel.org>
Cc: Willy Tarreau <w@1wt.eu>, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] selftests: kselftest: also use strerror() on nolibc
Message-ID: <56ea48ee-e278-4f37-a80f-9fd70d9d8d3b@t-8ch.de>
References: <20240426-nolibc-strerror-v1-0-76a4c9c5271d@weissschuh.net>
 <20240426-nolibc-strerror-v1-3-76a4c9c5271d@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240426-nolibc-strerror-v1-3-76a4c9c5271d@weissschuh.net>

Hi Shuah,

Could you Ack the patch below to kselftest.h?

Thanks,
Thomas

On 2024-04-26 13:08:58+0000, Thomas Weißschuh wrote:
> nolibc gained an implementation of strerror() recently.
> Use it and drop the ifdeffery.
> 
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> ---
>  tools/testing/selftests/kselftest.h | 8 --------
>  1 file changed, 8 deletions(-)
> 
> diff --git a/tools/testing/selftests/kselftest.h b/tools/testing/selftests/kselftest.h
> index 541bf192e30e..f4bfe98c31e4 100644
> --- a/tools/testing/selftests/kselftest.h
> +++ b/tools/testing/selftests/kselftest.h
> @@ -161,15 +161,7 @@ static inline __printf(1, 2) void ksft_print_msg(const char *msg, ...)
>  
>  static inline void ksft_perror(const char *msg)
>  {
> -#ifndef NOLIBC
>  	ksft_print_msg("%s: %s (%d)\n", msg, strerror(errno), errno);
> -#else
> -	/*
> -	 * nolibc doesn't provide strerror() and it seems
> -	 * inappropriate to add one, just print the errno.
> -	 */
> -	ksft_print_msg("%s: %d)\n", msg, errno);
> -#endif
>  }
>  
>  static inline __printf(1, 2) void ksft_test_result_pass(const char *msg, ...)
> 
> -- 
> 2.44.0
> 

