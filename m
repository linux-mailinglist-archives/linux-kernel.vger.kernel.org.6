Return-Path: <linux-kernel+bounces-411819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 526B19CFFF4
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 17:55:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10FAA28273B
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 16:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF7CF187FFA;
	Sat, 16 Nov 2024 16:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="PWdBuLQa"
Received: from smtp.smtpout.orange.fr (smtp-19.smtpout.orange.fr [80.12.242.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77BD117548
	for <linux-kernel@vger.kernel.org>; Sat, 16 Nov 2024 16:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731776105; cv=none; b=PeS47r5UIFWePCEge1J1BxReGlCVeAOOLC2zyxv+5QCH7ebSTzI7kKHMHX5o/tUhUWnzXKF5Vnlpx0Vbd5qEb9b5ThfdBf1iS0buutfzOdASz5aikDBh8Otocb7l1uPjKeXm+r0pXSpbvc6tu7k2AIlXb5n+qF8PTFWC4WAp9tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731776105; c=relaxed/simple;
	bh=tKyUOWXsLVGZxe1Ulhs5OzVYVexbN0uCIlE0sSJtrfM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LvzhE5H6p/qYDa4kGAWDh0LWQBTFMK5YUNb9lpL/6EXTTQINuEpq0BZtHHpgikq746B/Xud3SKRbw9DMbO4MOm8f6QjnVTpW5xmOHaAs2D1H95pHJEqTL58GN83BGvt3CvIwS9pBlvxAkqOQcf9zutpkAT0Pvs8Ee1cmx0wT1bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=PWdBuLQa; arc=none smtp.client-ip=80.12.242.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id CM4TtSwSb8AEMCM4TtV69b; Sat, 16 Nov 2024 17:54:54 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1731776094;
	bh=gRLvF0j4ihPFPoFcSZt3VuXORVsZwQBdv/+ra6bwjEE=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=PWdBuLQaocHWa3SqGn0E/jnjgH2kUkF+J0ex1i+gDs5QdcSIEKzClVlwB1tEvbs/w
	 VYv5JF04ttn85dgiywcqmVV8+Y3+BexCMEApMxdPXqqCKD/H1U3Y7fZhuuFAqXwIvz
	 WBI9KVY0WHaOPkbHwZARFtJpVw67Se6f9RJ/wjldh5bxFsfbQDQQVfNP446DdnucAK
	 eXKmHJw5CGwb/oNonWcG3EJTifk6ZT63lGzY7S9MA3kk56yeWAtfV9/QdIEqe4Y+Uq
	 +4LSKCI4t2esPu9LTEaEhQtus1tjgAd8yh3P1PN0UYCZJxUCXJBm+UmqYh6I3sFKR9
	 8i36aGWkYzm+w==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Sat, 16 Nov 2024 17:54:54 +0100
X-ME-IP: 90.11.132.44
Message-ID: <fe670aff-461f-417f-a9b7-7b714e84b5e2@wanadoo.fr>
Date: Sat, 16 Nov 2024 17:54:52 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] 9p/fs: Different branch return the same value
To: Rex Nie <rexnie3@gmail.com>, ericvh@kernel.org, lucho@ionkov.net,
 asmadeus@codewreck.org, linux_oss@crudebyte.com
Cc: linux-kernel@vger.kernel.org
References: <20241116152612.2423-1-rexnie3@gmail.com>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20241116152612.2423-1-rexnie3@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 16/11/2024 à 16:26, Rex Nie a écrit :
> The same code is executed when the condition ret < 0 is true or false.
> Remove the if branch and just return v9fs_init_inode_cache(). This
> does not change the semantics of the original code.
> 
> Signed-off-by: Rex Nie <rexnie3@gmail.com>
> ---
>   fs/9p/v9fs.c | 7 +------
>   1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/fs/9p/v9fs.c b/fs/9p/v9fs.c
> index 281a1ed03a04..ee0a374e0d9d 100644
> --- a/fs/9p/v9fs.c
> +++ b/fs/9p/v9fs.c
> @@ -661,12 +661,7 @@ static void v9fs_destroy_inode_cache(void)
>   
>   static int v9fs_cache_register(void)
>   {
> -	int ret;
> -
> -	ret = v9fs_init_inode_cache();
> -	if (ret < 0)
> -		return ret;
> -	return ret;
> +	return v9fs_init_inode_cache();
>   }
>   
>   static void v9fs_cache_unregister(void)

Hi,

a similar patch has already been sent.

See [1], which is the v2 of the patch and goes one step further.

CJ

[1]: 
https://lore.kernel.org/linux-kernel/20241107095756.10261-1-colin.i.king@gmail.com/

