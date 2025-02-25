Return-Path: <linux-kernel+bounces-532425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB708A44D88
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 21:35:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85E4F3AB1BA
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 20:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EA0D21B9C5;
	Tue, 25 Feb 2025 20:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="iKuXRQiU"
Received: from smtp.smtpout.orange.fr (smtp-73.smtpout.orange.fr [80.12.242.73])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEFF921B1A8
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 20:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740515174; cv=none; b=G+eCHRu4S8EO7opB2TL9RktIRcKjPfJpNByUvH7wT4wzvUpwjbIAzS9kOV7BWXrnbuTctM41FyBFPvWoQmwgeyHb5Z9cijwX5Mi6maw12TUQHYid5m7zMx2zWTZ/O10/k2vmOHZKcpDC97Oz2mC7ZD/1xskAVyj0tTV00jFUiC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740515174; c=relaxed/simple;
	bh=sq4Py1SncPuWnYp7w/jC/603O9qbMx0qUhATBq2iLfs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mB9nB0I6bUdg3iUB+HbqzHlgGz6nSeJ3A5iean+okk4rpX1vS7B87RU1tpYxP7WUQYnnpCn1X7T974UkGycn+cFGPO5zpTQ+1UX2DekgNugNWRRjuLkQ+1igOH4Bo39ralB0NNlbR1bGO5BZ+j8KVwBy+E7Wk3ESSws6+iYybZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=iKuXRQiU; arc=none smtp.client-ip=80.12.242.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id n1U9t3mIzJOH0n1UCtJZCE; Tue, 25 Feb 2025 21:25:02 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1740515102;
	bh=7/99hPUZC748Mfc5SetBP+1lFgI4nJzICmyhFWlU/iY=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=iKuXRQiUr4DSCN5YIjxL5fg+7xNtpFVZ388ceGflyCUTRIIraXZLLuxfLRt1rrdNq
	 Mcjfh/bu78BMQ979Ocb32NIh4hMx/UBFK9+rWMK68e2oOfgtVSYYpvHuZQqqwhM2F4
	 xRwYDyIJ9r0JB4PyvxQtQnEJN+jWAM02yipCG6hFatdFz8hlHfys2cnAVfkfdrAGCL
	 pbmW/Xdk5r/cz1npcrMZCtEd64iGOZfOEwjYGUS28IlBKl6/iAZPdwpObirhwpHycQ
	 /bAX2zUVl+6cKzjA3iPLpYnaLHwK17kJN5G8XVfsNCrSwwR8hPHbqGldVViffZaaPe
	 7QvOVydYdewhQ==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Tue, 25 Feb 2025 21:25:02 +0100
X-ME-IP: 90.11.132.44
Message-ID: <dd1a326a-e165-4796-9005-6bff2019deef@wanadoo.fr>
Date: Tue, 25 Feb 2025 21:24:56 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] orangefs: move s_kmod_keyword_mask_map[] into debugfs.c
To: Arnd Bergmann <arnd@kernel.org>, Mike Marshall <hubcap@omnibond.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Martin Brandenburg <martin@omnibond.com>,
 Al Viro <viro@zeniv.linux.org.uk>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, devel@lists.orangefs.org,
 linux-kernel@vger.kernel.org
References: <20250225200901.4041575-1-arnd@kernel.org>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20250225200901.4041575-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 25/02/2025 à 21:08, Arnd Bergmann a écrit :
> From: Arnd Bergmann <arnd@arndb.de>
> 
> gcc warns about unused const variables when building with W=1
> 
>      In file included from fs/orangefs/protocol.h:287,
>                       from fs/orangefs/acl.c:8:
>      fs/orangefs/orangefs-debug.h:86:18: error: 'num_kmod_keyword_mask_map' defined but not used [-Werror=unused-const-variable=]
>         86 | static const int num_kmod_keyword_mask_map = (int)
>            |                  ^~~~~~~~~~~~~~~~~~~~~~~~~
> 
> This one is only used in one file, so just move the definition
> next to its only user.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>   fs/orangefs/orangefs-debug.h   | 43 ----------------------------------
>   fs/orangefs/orangefs-debugfs.c | 43 ++++++++++++++++++++++++++++++++++
>   2 files changed, 43 insertions(+), 43 deletions(-)
> 
> diff --git a/fs/orangefs/orangefs-debug.h b/fs/orangefs/orangefs-debug.h
> index 6e079d4230d0..d4463534cec6 100644
> --- a/fs/orangefs/orangefs-debug.h
> +++ b/fs/orangefs/orangefs-debug.h
> @@ -43,47 +43,4 @@
>   #define GOSSIP_MAX_NR                 16
>   #define GOSSIP_MAX_DEBUG              (((__u64)1 << GOSSIP_MAX_NR) - 1)
>   
> -/* a private internal type */
> -struct __keyword_mask_s {
> -	const char *keyword;
> -	__u64 mask_val;
> -};
> -
> -/*
> - * Map all kmod keywords to kmod debug masks here. Keep this
> - * structure "packed":
> - *
> - *   "all" is always last...
> - *
> - *   keyword     mask_val     index
> - *     foo          1           0
> - *     bar          2           1
> - *     baz          4           2
> - *     qux          8           3
> - *      .           .           .
> - */
> -static struct __keyword_mask_s s_kmod_keyword_mask_map[] = {
> -	{"super", GOSSIP_SUPER_DEBUG},
> -	{"inode", GOSSIP_INODE_DEBUG},
> -	{"file", GOSSIP_FILE_DEBUG},
> -	{"dir", GOSSIP_DIR_DEBUG},
> -	{"utils", GOSSIP_UTILS_DEBUG},
> -	{"wait", GOSSIP_WAIT_DEBUG},
> -	{"acl", GOSSIP_ACL_DEBUG},
> -	{"dcache", GOSSIP_DCACHE_DEBUG},
> -	{"dev", GOSSIP_DEV_DEBUG},
> -	{"name", GOSSIP_NAME_DEBUG},
> -	{"bufmap", GOSSIP_BUFMAP_DEBUG},
> -	{"cache", GOSSIP_CACHE_DEBUG},
> -	{"debugfs", GOSSIP_DEBUGFS_DEBUG},
> -	{"xattr", GOSSIP_XATTR_DEBUG},
> -	{"init", GOSSIP_INIT_DEBUG},
> -	{"sysfs", GOSSIP_SYSFS_DEBUG},
> -	{"none", GOSSIP_NO_DEBUG},
> -	{"all", GOSSIP_MAX_DEBUG}
> -};
> -
> -static const int num_kmod_keyword_mask_map = (int)
> -	(ARRAY_SIZE(s_kmod_keyword_mask_map));
> -
>   #endif /* __ORANGEFS_DEBUG_H */
> diff --git a/fs/orangefs/orangefs-debugfs.c b/fs/orangefs/orangefs-debugfs.c
> index f52073022fae..6a34e6feac45 100644
> --- a/fs/orangefs/orangefs-debugfs.c
> +++ b/fs/orangefs/orangefs-debugfs.c
> @@ -54,6 +54,49 @@
>   #define ORANGEFS_VERBOSE "verbose"
>   #define ORANGEFS_ALL "all"
>   
> +/* a private internal type */
> +struct __keyword_mask_s {
> +	const char *keyword;
> +	__u64 mask_val;
> +};
> +
> +/*
> + * Map all kmod keywords to kmod debug masks here. Keep this
> + * structure "packed":
> + *
> + *   "all" is always last...
> + *
> + *   keyword     mask_val     index
> + *     foo          1           0
> + *     bar          2           1
> + *     baz          4           2
> + *     qux          8           3
> + *      .           .           .
> + */
> +static struct __keyword_mask_s s_kmod_keyword_mask_map[] = {

Unrelated to your patch, but I think that this could be made const.

Just my 2c.

CJ

> +	{"super", GOSSIP_SUPER_DEBUG},
> +	{"inode", GOSSIP_INODE_DEBUG},
> +	{"file", GOSSIP_FILE_DEBUG},
> +	{"dir", GOSSIP_DIR_DEBUG},
> +	{"utils", GOSSIP_UTILS_DEBUG},
> +	{"wait", GOSSIP_WAIT_DEBUG},
> +	{"acl", GOSSIP_ACL_DEBUG},
> +	{"dcache", GOSSIP_DCACHE_DEBUG},
> +	{"dev", GOSSIP_DEV_DEBUG},
> +	{"name", GOSSIP_NAME_DEBUG},
> +	{"bufmap", GOSSIP_BUFMAP_DEBUG},
> +	{"cache", GOSSIP_CACHE_DEBUG},
> +	{"debugfs", GOSSIP_DEBUGFS_DEBUG},
> +	{"xattr", GOSSIP_XATTR_DEBUG},
> +	{"init", GOSSIP_INIT_DEBUG},
> +	{"sysfs", GOSSIP_SYSFS_DEBUG},
> +	{"none", GOSSIP_NO_DEBUG},
> +	{"all", GOSSIP_MAX_DEBUG}
> +};
> +
> +static const int num_kmod_keyword_mask_map = (int)
> +	(ARRAY_SIZE(s_kmod_keyword_mask_map));
> +
>   /*
>    * An array of client_debug_mask will be built to hold debug keyword/mask
>    * values fetched from userspace.


