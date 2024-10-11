Return-Path: <linux-kernel+bounces-360445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A429999B0F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 05:14:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84EB5B225C6
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 03:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C057C1F4FA6;
	Fri, 11 Oct 2024 03:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Jbkaxge6"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA531F4720;
	Fri, 11 Oct 2024 03:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728616453; cv=none; b=DkI4RcL1kXmbPc1boTSm1IuRRRli8QE+FzbXDC/vrrpus9J9LoJgYXm7o++XsvChvF+uFfzSwPhvCxRbTiKMH4Tw06muc2pYXE4b94fsBRRv8MTrAHEOJz6q3EXwCMEpzRhGCgr1W3uy9FStegho9pYxSiUr5W388DjxPj/gHW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728616453; c=relaxed/simple;
	bh=Z32c1FoLtU4+0UulrXColHM4sVmGTFtTp+qwtVZ5TWY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pC/3Q9IdTNtqR7IQbK07r+qy+s30b1uK44vN18IeH9xX8OiCLK7VcKyfmoZq8WGv+SwPN9r8F/y4HM0TamYOunFWnb2stRV0RZSYz/CMKxo/JitPy6swu3J3nWxQmxM5PAJidUtOCwL9dpOzY6zweZlc7USydWb7XNfZLNQDb00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Jbkaxge6; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=oBdL52SEsTnjQsIEYsKwxiQNAGcIdl+RS9IR5NJ9FZE=; b=Jbkaxge6oiPPvQZCSKC7UCO7MH
	U2xCLqnIKb5Kdps5TeTa8dCrHX08LYMBUBNBmaUQfiyldGSF2tHx8wak2IF1lHREy5cnOO6GsrmYU
	ThBYrOOIyJ6T4sGpW7J/lrBqEETw2tniLPNuazzuBcJ7CYC41F4wON8srDqzjVpEWLcmIWrGHZk2d
	nPzyzRraQqhc/j2vFJ2rlzH08rrpcs469mQ0YePdQfZHQaKmwuNthZJNyooLK9tijEgIKOQDkqF2z
	SoTjvZPsMVLBwPdwDXFqzSaSEeY2WegHaWQHjOyQVigxNMukMqeUyIQfLSNiIDzS5Cw4wSa+YyIQy
	2RiStOFA==;
Received: from [50.53.2.24] (helo=[192.168.254.17])
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1sz66N-00000005ngt-0N6d;
	Fri, 11 Oct 2024 03:14:06 +0000
Message-ID: <0e8cb8e7-548f-4100-97a2-41576749fb63@infradead.org>
Date: Thu, 10 Oct 2024 20:13:59 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scripts/kernel-doc: Fix build time warnings
To: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>,
 Jonathan Corbet <corbet@lwn.net>, Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-dev@igalia.com
References: <20241010225933.166436-1-andrealmeid@igalia.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20241010225933.166436-1-andrealmeid@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 10/10/24 3:59 PM, André Almeida wrote:
> As stated at Documentation/kbuild/llvm.rst, to make usage of ccache one
> must set KBUILD_BUILD_TIMESTAMP=''. Setting this together with W=1
> will trigger the following warning for every compiled file:
> 
>   date: invalid date ‘+%s’
> 
> This comes from kernel-doc script, that produces the following command
> when KBUILD_BUILD_TIMESTAMP is empty:
> 
>   date -d"" +%s
> 
> That triggers the warning above. Add a space between the flag `-d` and
> the string argument to fix date command and remove the warning.
> 
> Signed-off-by: André Almeida <andrealmeid@igalia.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  scripts/kernel-doc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/kernel-doc b/scripts/kernel-doc
> index 2791f8195203..8728f9824c65 100755
> --- a/scripts/kernel-doc
> +++ b/scripts/kernel-doc
> @@ -160,7 +160,7 @@ my @export_file_list;
>  
>  my @build_time;
>  if (defined($ENV{'KBUILD_BUILD_TIMESTAMP'}) &&
> -    (my $seconds = `date -d"${ENV{'KBUILD_BUILD_TIMESTAMP'}}" +%s`) ne '') {
> +    (my $seconds = `date -d "${ENV{'KBUILD_BUILD_TIMESTAMP'}}" +%s`) ne '') {
>      @build_time = gmtime($seconds);
>  } else {
>      @build_time = localtime;

-- 
~Randy

