Return-Path: <linux-kernel+bounces-299928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97AA495DC56
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 08:55:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D2201F23433
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 06:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26D74153824;
	Sat, 24 Aug 2024 06:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="sDclFOai"
Received: from smtp.smtpout.orange.fr (smtp-13.smtpout.orange.fr [80.12.242.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 498BDC148
	for <linux-kernel@vger.kernel.org>; Sat, 24 Aug 2024 06:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724482541; cv=none; b=fcs+jegidtT7tSj196mi7ZgAEkgR1LJsho0S6mjdummeG6HZelxpqE5tm45cBPHYK0KFijrZe6A3oE64FWvSh6euhZngfluAx9s9cQeX2psPlK1CE9mjwmb+UQK54Vy+lYGSiGlbAmisAyeXUJD68vzdpZSlghSkYL3VZcmbAIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724482541; c=relaxed/simple;
	bh=4kmF9szrxHMI+EnHh3a9bMYw9yVfO568Y2IZkHiaM9c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Sej1XD5xnwBJlhxhIIViaf6I+cWUmiwzfxdWorC1QSqccJjG6WewOATwJyqPASRXrJ7QOci/Ylz74vNTIdudVxwCgvV5ymymSGwb3mP6bSYjPjS0/mjBswjiJL3qlU54JjZ439+sUjo/0OGqudG7wgNS4YdI2WhH1VjQgyq+f0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=sDclFOai; arc=none smtp.client-ip=80.12.242.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id hkgHsOgpszHoQhkgHsZAr4; Sat, 24 Aug 2024 08:55:30 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1724482530;
	bh=j/Oekpz9cgS3OyVH/t3YcO9F5N2XM6vT8hNtOU5iRWs=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=sDclFOaiKfUaGQ4/6QOImEZjH8zLpfzXd9JerxXCIylp/Ecg7oiSQnQXesw4BGS7V
	 /DrxQkM+XVheTbKe+Y9NRjQm/AlZkQt74TK2oAHIIDLDjKS26n/I6Pt8DZ3i9o7RkA
	 j3LLJLZYU1uqWzBlj22Vz9ZimUgTYwDrB1iaRGLyNuVQbT9oMitf9hA0mBAg/mNfVt
	 noZFth2hNP50ZeW6R1ZWsUO2/MlC3T8sUwZSuc2nLeLMrA3YuQBwK8KRInGk3LYBl5
	 LbDWZViVaIOabJhwup0x26xioJmuWQRI4j0FO7aYoqVJ2ozSWkW/pagd4jIH8mZ0pV
	 ZAwdfSnMxJECQ==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Sat, 24 Aug 2024 08:55:30 +0200
X-ME-IP: 90.11.132.44
Message-ID: <70a3d71d-b0f9-48b8-bb00-497cd17da764@wanadoo.fr>
Date: Sat, 24 Aug 2024 08:55:25 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND v8 1/2] mm: store zero pages to be swapped out in a
 bitmap
To: Usama Arif <usamaarif642@gmail.com>, akpm@linux-foundation.org
Cc: hannes@cmpxchg.org, shakeel.butt@linux.dev, david@redhat.com,
 ying.huang@intel.com, hughd@google.com, willy@infradead.org,
 yosryahmed@google.com, nphamcs@gmail.com, chengming.zhou@linux.dev,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
 Andi Kleen <ak@linux.intel.com>
References: <20240823190545.979059-1-usamaarif642@gmail.com>
 <20240823190545.979059-2-usamaarif642@gmail.com>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20240823190545.979059-2-usamaarif642@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 23/08/2024 à 21:04, Usama Arif a écrit :
> Approximately 10-20% of pages to be swapped out are zero pages [1].
> Rather than reading/writing these pages to flash resulting
> in increased I/O and flash wear, a bitmap can be used to mark these
> pages as zero at write time, and the pages can be filled at
> read time if the bit corresponding to the page is set.
> With this patch, NVMe writes in Meta server fleet decreased
> by almost 10% with conventional swap setup (zswap disabled).
> 
> [1] https://lore.kernel.org/all/20171018104832epcms5p1b2232e2236258de3d03d1344dde9fce0@epcms5p1/
> 

...

> @@ -3428,6 +3444,17 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
>   		goto bad_swap_unlock_inode;
>   	}
>   
> +	/*
> +	 * Use kvmalloc_array instead of bitmap_zalloc as the allocation order might
> +	 * be above MAX_PAGE_ORDER incase of a large swap file.
> +	 */
> +	zeromap = kvmalloc_array(BITS_TO_LONGS(maxpages), sizeof(long),
> +				    GFP_KERNEL | __GFP_ZERO);

Nitpick: kvcalloc() maybe, to be slightly less verbose?

> +	if (!zeromap) {
> +		error = -ENOMEM;
> +		goto bad_swap_unlock_inode;
> +	}
> +
>   	if (si->bdev && bdev_stable_writes(si->bdev))
>   		si->flags |= SWP_STABLE_WRITES;
>   

...

CJ


