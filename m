Return-Path: <linux-kernel+bounces-379737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD65E9AE2FD
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 12:49:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B6EE28415A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 10:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6E631C4A38;
	Thu, 24 Oct 2024 10:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PaGAkgOp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E3D6176AAD
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 10:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729766941; cv=none; b=dj+AVG6qIw05HBZLi2v7khAfgoiRcHKHjam1w2v2S/h4QFjdanlyePlt5j9Y1jHxCfjAN3ai9USy2X04YptwdkNwF84ETSpqNO+VzjcblPLN+nelmPgvm+w3p/IpcwK7nVZsmzeNWoIhhH66jrHkahb8jw0RDQs738E7rRY+45s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729766941; c=relaxed/simple;
	bh=QBIUyzNrF0JLjhARXuYRcTcvRkEiWVTMcOrNUSB679s=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=g0S4dOnASkBp0g/MF25hdV1sfGVQkA5PdVRtrBm+/dspQSycvzHEhXA9zCw0M/VSryODWam50nL0fYoNc+1+O04va0kNgCS9LWzEh+4yWNWK8I8a7OzeS8qksODnOaGpWyPziHoMDoqzteFzAt9vwopbd147tJjhWKtZCWg84X4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PaGAkgOp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE8F8C4CEC7;
	Thu, 24 Oct 2024 10:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729766940;
	bh=QBIUyzNrF0JLjhARXuYRcTcvRkEiWVTMcOrNUSB679s=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=PaGAkgOpPsDYIUNbryZOZKUGtPadB14Z8I965dkhNKDla8AQ1kwiP/r1ylgGkiXlC
	 ULX1Q4MqeRNwmSPvZ0ozhr1mR6raKluRrSLttRov2YobqXh3fCMdwrDZSy5Y/y/0Dl
	 UK1PDtb6IUrY6BlD4bk0fGfCJ6BBWg6acwMRs7vU5PcsVFxpI4fd/cZ686XxK/jE9v
	 xGV6ghfJp96Ie3V9RQB/64rEvNYVGabyGBaIWYXrM7WPAdcFAoaVtBLOcDfo/qQu5F
	 97/ZUOcQPyczHsEFVIovGkKB6yHG1ThlRrgz8lvW30oHrhr7uHv8vnKqXxZvHlcwRv
	 CEGnmWGrjmNEw==
Message-ID: <a224e560-2937-4edd-93d8-8077de6054b1@kernel.org>
Date: Thu, 24 Oct 2024 18:48:55 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Chao Yu <chao@kernel.org>, linux-f2fs-devel@lists.sourceforge.net,
 linux-kernel@vger.kernel.org, niuzhiguo84@gmail.com, ke.wang@unisoc.com,
 Hao_hao.Wang@unisoc.com
Subject: Re: [PATCH] f2fs-tools: correct some confused desc about unit
To: Zhiguo Niu <zhiguo.niu@unisoc.com>, jaegeuk@kernel.org
References: <1729762134-380-1-git-send-email-zhiguo.niu@unisoc.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <1729762134-380-1-git-send-email-zhiguo.niu@unisoc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/10/24 17:28, Zhiguo Niu wrote:
> F2FS_BLKSIZE may be 4KB, 16KB, so use F2FS_BLKSIZE to replace
> some hardcode desc about unit in some f2fs_io cmd, also
> adjust "-c" parameters in mkfs man, to be consistent with
> commit c35fa8cd75ac ("mkfs.f2fs: change -c option description").
> 
> Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
> ---
>   man/mkfs.f2fs.8         | 2 +-
>   tools/f2fs_io/f2fs_io.c | 6 +++---
>   2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/man/mkfs.f2fs.8 b/man/mkfs.f2fs.8
> index de885be..8b3b0cc 100644
> --- a/man/mkfs.f2fs.8
> +++ b/man/mkfs.f2fs.8
> @@ -122,7 +122,7 @@ block size matches the page size.
>   The default value is 4096.
>   .TP
>   .BI \-c " device-list"
> -Build f2fs with these additional comma separated devices, so that the user can
> +Build f2fs with these additional devices, so that the user can
>   see all the devices as one big volume.
>   Supports up to 7 devices except meta device.
>   .TP
> diff --git a/tools/f2fs_io/f2fs_io.c b/tools/f2fs_io/f2fs_io.c
> index 95f575f..ee4ed0e 100644
> --- a/tools/f2fs_io/f2fs_io.c
> +++ b/tools/f2fs_io/f2fs_io.c
> @@ -1013,7 +1013,7 @@ static void do_randread(int argc, char **argv, const struct cmd_desc *cmd)
>   
>   #define fiemap_desc "get block address in file"
>   #define fiemap_help					\
> -"f2fs_io fiemap [offset in 4kb] [count in 4kb] [file_path]\n\n"\
> +"f2fs_io fiemap [offset in F2FS_BLKSIZE] [count in F2FS_BLKSIZE] [file_path]\n\n"\
>   
>   #if defined(HAVE_LINUX_FIEMAP_H) && defined(HAVE_LINUX_FS_H)
>   static void do_fiemap(int argc, char **argv, const struct cmd_desc *cmd)
> @@ -1617,8 +1617,8 @@ static void do_move_range(int argc, char **argv, const struct cmd_desc *cmd)
>   #define gc_range_desc "trigger filesystem gc_range"
>   #define gc_range_help "f2fs_io gc_range [sync_mode] [start] [length] [file_path]\n\n"\
>   "  sync_mode : 0: asynchronous, 1: synchronous\n"			\
> -"  start     : start offset of defragment region, unit: 4kb\n"	\
> -"  length    : bytes number of defragment region, unit: 4kb\n"	\
> +"  start     : start offset of defragment region, unit: F2FS_BLKSIZE\n"	\
> +"  length    : bytes number of defragment region, unit: F2FS_BLKSIZE\n"	\

I think we'd better unify default block size to 4096 since in most of
places in f2fs_io.c, we use 4096 as default IO/buffer size.

git grep -n "4096" tools/f2fs_io/f2fs_io.c
tools/f2fs_io/f2fs_io.c:212:    args.block_size = 4096;
tools/f2fs_io/f2fs_io.c:662:    buf_size = bs * 4096;
tools/f2fs_io/f2fs_io.c:666:    buf = aligned_xalloc(4096, buf_size);
tools/f2fs_io/f2fs_io.c:877:    buf_size = bs * 4096;
tools/f2fs_io/f2fs_io.c:881:    buf = aligned_xalloc(4096, buf_size);
tools/f2fs_io/f2fs_io.c:901:            if (posix_fadvise(fd, 0, 4096, POSIX_FADV_SEQUENTIAL) != 0)
tools/f2fs_io/f2fs_io.c:903:            if (posix_fadvise(fd, 0, 4096, POSIX_FADV_WILLNEED) != 0)
tools/f2fs_io/f2fs_io.c:979:    buf_size = bs * 4096;
tools/f2fs_io/f2fs_io.c:981:    buf = aligned_xalloc(4096, buf_size);
tools/f2fs_io/f2fs_io.c:994:    aligned_size = (u64)stbuf.st_size & ~((u64)(4096 - 1));
tools/f2fs_io/f2fs_io.c:997:    end_idx = (u64)(aligned_size - buf_size) / (u64)4096 + 1;
tools/f2fs_io/f2fs_io.c:1004:           ret = pread(fd, buf, buf_size, 4096 * idx);
tools/f2fs_io/f2fs_io.c:1222:           char *buf = aligned_xalloc(4096, 4096);
tools/f2fs_io/f2fs_io.c:1224:           while ((ret = xread(src_fd, buf, 4096)) > 0)

git grep -n "F2FS_BLKSIZE" tools/f2fs_io/f2fs_io.c
tools/f2fs_io/f2fs_io.c:1034:   start = (u64)atoi(argv[1]) * F2FS_BLKSIZE;
tools/f2fs_io/f2fs_io.c:1035:   length = (u64)atoi(argv[2]) * F2FS_BLKSIZE;
tools/f2fs_io/f2fs_io.c:1042:                           start / F2FS_BLKSIZE, length / F2FS_BLKSIZE);

We can add a new macro F2FS_DEFAULT_BLKSIZE and use it instead of magic
number and F2FS_BLKSIZE, what do you think?

Thanks,

>   
>   static void do_gc_range(int argc, char **argv, const struct cmd_desc *cmd)
>   {


