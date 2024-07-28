Return-Path: <linux-kernel+bounces-264820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C690693E8CD
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 19:52:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F6D8281B70
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 17:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23F4F54F87;
	Sun, 28 Jul 2024 17:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="mQFJ+zMC"
Received: from smtp.smtpout.orange.fr (smtp-27.smtpout.orange.fr [80.12.242.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D122118EB0
	for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2024 17:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722189123; cv=none; b=AYNWc9xNvOziZy2wLYVL/J5IGl4gLcLbxbvIrfrVFI7jriyn5k7dTzxP+w1TCTrPxhT5om57XnQZnucC1sOJISxQLMIWq7NG+4LUhr4cEeEHGYiSEzoYpv3XdBz/EQ0zepPl4tHeJoG0XUy/u2fppejyHeFIu/DShuHdzAb+Uh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722189123; c=relaxed/simple;
	bh=KxFd1kdKgRdZ1EKUFbpUgTrZ8bJnV0y+kZWlvPDG9NE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AJ1qNih11eQ3eMXowce6vXW8lyG+2s99SGx+iDVSDJYY2eOBc6jX4Q2yiD2DlcImEryobUFXWq3ZsIOYfq0QKr8oMa2HEAS8RoGJC6FmiiiYinwYwmm8CSn/aX7A4K7sN5Q+UfeqDrqHAHLYNT0AcjuWCaDojk/ilZo2m6cT/BU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=mQFJ+zMC; arc=none smtp.client-ip=80.12.242.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id Y83esu79zBzr3Y83fsmYgb; Sun, 28 Jul 2024 19:51:52 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1722189112;
	bh=VtfuAOcrMVNDJSrM9yjaYAnitfgEG+/K+4UILcjSUP0=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=mQFJ+zMC0ThWwQUKA20xFHBkYX4NHPzDD6WpGaxcAwi0E7tKbKKmks8+35XgklLwQ
	 2NvGl3h6yHI6OrV3+VPAMI4M2ELLimeado9ayLE8M9Qh8Q62LaaDoP5DsMnw5S9XMZ
	 wNzjHEzxliVB4o3mCLa7FxXPWkM9uhqh0EbmCsLyFBK+uIjxeqI5puU23ZiwfGd8Q8
	 dc579kpKQRJwlug4RjTm458OBMeP4HWbbCB3DBkRou30QhA5pWBoe03obZt7genLVT
	 LVEcFlVF74+8ZQZilbnquBg6ObR7Waod8liKicHrkaBgiLsK/10t9ybtlEFkRKOffz
	 C5wVsZohEyrRg==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Sun, 28 Jul 2024 19:51:52 +0200
X-ME-IP: 90.11.132.44
Message-ID: <76573179-1e38-4620-bf59-6801341802b5@wanadoo.fr>
Date: Sun, 28 Jul 2024 19:51:42 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/8] minmax: Use _Static_assert() instead of
 static_assert()
To: David Laight <David.Laight@ACULAB.COM>,
 "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Cc: 'Linus Torvalds' <torvalds@linuxfoundation.org>,
 'Jens Axboe' <axboe@kernel.dk>,
 "'Matthew Wilcox (Oracle)'" <willy@infradead.org>,
 'Christoph Hellwig' <hch@infradead.org>,
 'Andrew Morton' <akpm@linux-foundation.org>,
 'Andy Shevchenko' <andriy.shevchenko@linux.intel.com>,
 'Dan Carpenter' <dan.carpenter@linaro.org>, 'Arnd Bergmann'
 <arnd@kernel.org>, "'Jason@zx2c4.com'" <Jason@zx2c4.com>,
 "'pedro.falcato@gmail.com'" <pedro.falcato@gmail.com>,
 'Mateusz Guzik' <mjguzik@gmail.com>,
 "'linux-mm@kvack.org'" <linux-mm@kvack.org>,
 'Lorenzo Stoakes' <lorenzo.stoakes@oracle.com>
References: <402c3c617c29465c898b1af55e3c6095@AcuMS.aculab.com>
 <b169a04caaee43c7b917a7e48470da6a@AcuMS.aculab.com>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <b169a04caaee43c7b917a7e48470da6a@AcuMS.aculab.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 28/07/2024 à 16:18, David Laight a écrit :
> The static_assert() wrapper provides the text of the expression as the
> error message, this isn't needed here as an explicit message is provided.
> If there is an error (quite likely for min/max) the wrapper also adds
> two more lines of error output that just make it harder to read.
> 
> Since it gives no benefit and actually makes things worse directly
> using _Static_assert() is much better.
> 
> Signed-off-by: David Laight <david.laight@aculab.com>
> ---
> v2:
> - No change.
> 
>   include/linux/minmax.h | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/minmax.h b/include/linux/minmax.h
> index cea63a8ac80f..ab64b2e73ae5 100644
> --- a/include/linux/minmax.h
> +++ b/include/linux/minmax.h
> @@ -48,7 +48,7 @@
>   #define __cmp_once(op, x, y, unique_x, unique_y) ({	\
>   	typeof(x) unique_x = (x);			\
>   	typeof(y) unique_y = (y);			\
> -	static_assert(__types_ok(x, y),			\
> +	_Static_assert(__types_ok(x, y),			\

Nitpick, should there be a v3: a tab can be removed to keep things aligned.

>   		#op "(" #x ", " #y ") signedness error, fix types or consider u" #op "() before " #op "_t()"); \
>   	__cmp(op, unique_x, unique_y); })

CJ

