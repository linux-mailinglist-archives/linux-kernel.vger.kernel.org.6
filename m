Return-Path: <linux-kernel+bounces-245190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A5A2392AF6F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 07:33:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3FD71C213DD
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 05:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 519EB12C522;
	Tue,  9 Jul 2024 05:33:38 +0000 (UTC)
Received: from mail.parknet.co.jp (mail.parknet.co.jp [210.171.160.6])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E977D63A
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 05:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.171.160.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720503217; cv=none; b=rB2SzvhuUHMsiROvJnq+bXOOtGtZK43Q+1I9XIbKrLIQ+vo988XZLKiszu3laipVmX+sBWFJo0i5NCTQbOV3VrkNwId2dxKwFgJNluKOq9wRSD5GWM0FrAVpkceIdhWnUL6FhgDKGKdarYlde4/QvvDQvvTNSydGzcEMP/gMoKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720503217; c=relaxed/simple;
	bh=FsK2z7JkKDREgaTN3EI7PgnQwrmHW57J0z4rTP028J0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=t2T+cRcR8odEDlca5wIkoZw6129SutDxSvJ7+pFyNCRUsNYWmykB0Ifrn8BGd+GWK1XK5GWTeKZXgBuO85/EhE2znp0LpSfeSrKmBG9f+jFRMrYFiIwtQIfmCsHQbu80lqDyncQ2Kdx5Xmp+AEIHV0OkyYGuRWcvDz+sMwAceM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mail.parknet.co.jp; spf=pass smtp.mailfrom=parknet.co.jp; arc=none smtp.client-ip=210.171.160.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mail.parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=parknet.co.jp
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
	by mail.parknet.co.jp (Postfix) with ESMTPSA id B121D2055FA3;
	Tue,  9 Jul 2024 14:33:27 +0900 (JST)
Received: from devron.myhome.or.jp (foobar@devron.myhome.or.jp [192.168.0.3])
	by ibmpc.myhome.or.jp (8.18.1/8.18.1/Debian-5) with ESMTPS id 4695XPrf148815
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 9 Jul 2024 14:33:26 +0900
Received: from devron.myhome.or.jp (foobar@localhost [127.0.0.1])
	by devron.myhome.or.jp (8.18.1/8.18.1/Debian-5) with ESMTPS id 4695XPv7863250
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 9 Jul 2024 14:33:25 +0900
Received: (from hirofumi@localhost)
	by devron.myhome.or.jp (8.18.1/8.18.1/Submit) id 4695XPlp863248;
	Tue, 9 Jul 2024 14:33:25 +0900
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To: Sungjong Seo <sj1557.seo@samsung.com>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fat: print s_dev via fat_msg
In-Reply-To: <20240709041734.3719513-1-sj1557.seo@samsung.com> (Sungjong Seo's
	message of "Tue, 9 Jul 2024 13:17:34 +0900")
References: <CGME20240709041754epcas1p4ee6f7b1fd0dbf287e756b709aba321c8@epcas1p4.samsung.com>
	<20240709041734.3719513-1-sj1557.seo@samsung.com>
Date: Tue, 09 Jul 2024 14:33:25 +0900
Message-ID: <87frsjt9i2.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Sungjong Seo <sj1557.seo@samsung.com> writes:

> To clarify MAJOR/MINOR number of a mounted device, fat_msg prints prefix
> that includes them.

Hm, why do we need the major/minor (why can't use sysfs to resolve if
need), and why do you care only fat?

Thanks.

> Signed-off-by: Sungjong Seo <sj1557.seo@samsung.com>
> ---
>  fs/fat/fat.h  | 2 +-
>  fs/fat/misc.c | 4 +++-
>  2 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/fs/fat/fat.h b/fs/fat/fat.h
> index 66cf4778cf3b..538bcb3e28e1 100644
> --- a/fs/fat/fat.h
> +++ b/fs/fat/fat.h
> @@ -435,7 +435,7 @@ void __fat_fs_error(struct super_block *sb, int report, const char *fmt, ...);
>  #define fat_fs_error_ratelimit(sb, fmt, args...) \
>  	__fat_fs_error(sb, __ratelimit(&MSDOS_SB(sb)->ratelimit), fmt , ## args)
>  
> -#define FAT_PRINTK_PREFIX "%sFAT-fs (%s): "
> +#define FAT_PRINTK_PREFIX "%sFAT-fs (%s[%d:%d]): "
>  #define fat_msg(sb, level, fmt, args...)				\
>  do {									\
>  	printk_index_subsys_emit(FAT_PRINTK_PREFIX, level, fmt, ##args);\
> diff --git a/fs/fat/misc.c b/fs/fat/misc.c
> index c7a2d27120ba..6672cefc5484 100644
> --- a/fs/fat/misc.c
> +++ b/fs/fat/misc.c
> @@ -9,6 +9,7 @@
>  
>  #include "fat.h"
>  #include <linux/iversion.h>
> +#include <linux/blkdev.h>
>  
>  /*
>   * fat_fs_error reports a file system problem that might indicate fa data
> @@ -59,7 +60,8 @@ void _fat_msg(struct super_block *sb, const char *level, const char *fmt, ...)
>  	va_start(args, fmt);
>  	vaf.fmt = fmt;
>  	vaf.va = &args;
> -	_printk(FAT_PRINTK_PREFIX "%pV\n", level, sb->s_id, &vaf);
> +	_printk(FAT_PRINTK_PREFIX "%pV\n", level, sb->s_id,
> +		MAJOR(sb->s_dev), MINOR(sb->s_dev), &vaf);
>  	va_end(args);
>  }

-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

