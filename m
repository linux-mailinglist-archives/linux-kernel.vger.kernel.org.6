Return-Path: <linux-kernel+bounces-549407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B93F1A55228
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 18:02:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4AD3188D977
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 17:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 086A826B0AD;
	Thu,  6 Mar 2025 16:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="tCnYfG+r"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D6D25A621
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 16:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741280300; cv=none; b=I9Wa0c1lIFqsQK6LJyJEOum0qzqqdorlCwabxmEGSSFgsYBzC+ragFZvJ3Ik/fFRVRIs9ZilHliJqpUq+RDB2mCwOmPH/lNwVSECaRqxU5mc8lBgcYWdw43d0/f05MDmuZZkvJ2p0OaLYQS9rVDjwt+rR4l//Run5Ev8QJ81dVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741280300; c=relaxed/simple;
	bh=aRbRe8yZpCM4GvTXvrtq4xcyqkvIzv6b6TRu0eyMc/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kxzd6oHGFUKuebzDg4UlvJNw7n3HOrsRhP5NP+ajtAMFU33w5lyYiofowbhIFgoQeIgBEl18WFBmwl50asP6aXJjP+w6SQ8mtX7QJ3OFwNOSgIRCqcbgEJ34CVF8TNJr+9STIIEiDqEQx3l042kVKDroQjtpuJBx2r1rNDFZy4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=tCnYfG+r; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1741280296;
	bh=aRbRe8yZpCM4GvTXvrtq4xcyqkvIzv6b6TRu0eyMc/Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tCnYfG+rEderWQ8gr7SUeQy/xokRpZUKgO+W/o5Aj/hQsrLHuUkthhXRBWNxu3a9p
	 KdcGHbMzD2AFZ1qlnE2GCt/nmiTUMJY7wp2Tgj+WUTwBHWNNkBmpTIpw1wm5qr01VU
	 9Ir6LJ1+slSm+h3B6lj3qEp6F8j9yob53iWcMzJo=
Date: Thu, 6 Mar 2025 17:58:15 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Louis Taylor <louis@kragniz.eu>
Cc: Willy Tarreau <w@1wt.eu>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/5] tools/nolibc: drop outdated example from overview
 comment
Message-ID: <ca86492d-7564-466a-87b7-2105f6b02a49@t-8ch.de>
References: <20250304075846.66563-1-louis@kragniz.eu>
 <20250304075846.66563-4-louis@kragniz.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250304075846.66563-4-louis@kragniz.eu>

On 2025-03-04 07:58:18+0000, Louis Taylor wrote:
> This behaviour was changed in commit a7604ba149e7 ("tools/nolibc/sys:
> make open() take a vararg on the 3rd argument").
> 
> Signed-off-by: Louis Taylor <louis@kragniz.eu>

Acked-by : Thomas Weißschuh <linux@weissschuh.net>

> ---
>  tools/include/nolibc/nolibc.h | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/tools/include/nolibc/nolibc.h b/tools/include/nolibc/nolibc.h
> index 05d92afedb72..70872401aca8 100644
> --- a/tools/include/nolibc/nolibc.h
> +++ b/tools/include/nolibc/nolibc.h
> @@ -31,8 +31,7 @@
>   *   - The third level is the libc call definition. It exposes the lower raw
>   *     sys_<name>() calls in a way that looks like what a libc usually does,
>   *     takes care of specific input values, and of setting errno upon error.
> - *     There can be minor variations compared to standard libc calls. For
> - *     example the open() call always takes 3 args here.
> + *     There can be minor variations compared to standard libc calls.
>   *
>   * The errno variable is declared static and unused. This way it can be
>   * optimized away if not used. However this means that a program made of
> -- 
> 2.45.2
> 

