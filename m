Return-Path: <linux-kernel+bounces-559439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FA77A5F3D6
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 13:08:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0DE13A857A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 12:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94044266F00;
	Thu, 13 Mar 2025 12:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jXBfePOu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02201266B5F
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 12:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741867622; cv=none; b=q+3tyk10CjctixkVKDFc2gzi/v4A2Yld6WRUAyXJzg6uIJEUcs1VbY0NOpqf3jDx05VJjCduOrZ8dDn+DKM0T3F0sg8MxVKhLDROw9ZKsNW+vMxJK7J1LlaEpQn24gp3wD+Qz+TfK0jnrHXmmAxp85wFWxaTVpTs7VpWq/umakI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741867622; c=relaxed/simple;
	bh=tPMv1e9p1LoBOgsBlCNb2KlLtLmYJbXlDQr2OnVcN4E=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=BR4IxCVxFInfXY/P+hKl5I/tNMxlkk16eE7A7/QtLq6wMBjcmnu45EaWWw865tFRy6B7eC8a0PTBAjSKdXq3AMV68jnvS6xVRjmBzRR4H51451ycqKZdaEjd8sB81oSqSghHqr75483BbvfvJolJbknn38Y/cL0Xc0E02klM0Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jXBfePOu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4B5AC4CEDD;
	Thu, 13 Mar 2025 12:07:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741867621;
	bh=tPMv1e9p1LoBOgsBlCNb2KlLtLmYJbXlDQr2OnVcN4E=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=jXBfePOuOB7rhnTba5KejxcO7mreOmQZqV5TXLHLxCSfITjJvWSfzLvYJFLvHUQx6
	 u3D6H0sCrO2N10VzJixabZMog9fjADMf2jtK+IY6KH8es4rF0T0Ymt0IP5fV3cBM2E
	 BgRSYM67F3S1SoxMhsnuyC23O5y/++7xTVWlgEqeT8JWFvDw6vshQM5FvkNCLAvhuz
	 mJ4uuqnTIvfTMi2Y1SjLiQlGInm5yP7jE9GTcyUYLXA7DxIgh6ee20kY8vkPoXli2q
	 XlGAG05SfSKYF/cU/3mEbZBIcXE6F6lKoosaaReOtDbG/O5Z0BbmhLYKTJEZnEl/Pu
	 IM37RzMhuCe6A==
Message-ID: <695b5311-d0bb-422c-9a96-52cfcc72afb4@kernel.org>
Date: Thu, 13 Mar 2025 20:06:58 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 00/10] erofs: 48-bit layout support
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20250310095459.2620647-1-hsiangkao@linux.alibaba.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20250310095459.2620647-1-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025/3/10 17:54, Gao Xiang wrote:
> Hi folks,
> 
> The current 32-bit block addressing limits EROFS to a 16TiB maximum
> volume size with 4KiB blocks.  However, several new use cases now
> require larger capacity support:
>   - Massive datasets for model training to boost random sampling
>     performance for each epoch;
>   - Object storage clients using EROFS direct passthrough.
> 
> This extends core on-disk structures to support 48-bit block addressing,
> such as inodes, device slots, and inode chunks.
> 
> In addition, it introduces an mtime field to 32-byte compact inodes for
> basic timestamp support, as well as expands the superblock root NID to
> an 8-byte rootnid_8b for out-of-place update incremental builds.
> 
> In order to support larger images beyond 32-bit block addressing and
> efficient indexing of large compression units for compressed data, and
> to better support popular compression algorithms (mainly Zstd) that
> still lack native fixed-sized output compression support, introduce
> byte-oriented encoded extents, so that these compressors are allowed
> to retain their current methods.
> 
> Therefore, it speeds up Zstd image building a lot by using:
> Processor: Intel(R) Xeon(R) Platinum 8163 CPU @ 2.50GHz * 96
> Dataset: enwik9
> Build time Size Type Command Line
> 3m52.339s 266653696 FO -C524288 -zzstd,22
> 3m48.549s 266174464 FO -E48bit -C524288 -zzstd,22
> 0m12.821s 272134144 FI -E48bit -C1048576 --max-extent-bytes=1048576 -zzstd,22
> 
> It has been stress-tested on my local setup for a while without any
> strange happens.

Cool, good work! For this serial,

Acked-by: Chao Yu <chao@kernel.org>

Hoping to grab continuous free slots to check the details, then we can
change it to rvb status before merge window. :)

Thanks,

> 
> Thanks,
> Gao Xiang
> 
> Gao Xiang (10):
>    erofs: get rid of erofs_map_blocks_flatmode()
>    erofs: simplify erofs_{read,fill}_inode()
>    erofs: add 48-bit block addressing on-disk support
>    erofs: implement 48-bit block addressing for unencoded inodes
>    erofs: support dot-omitted directories
>    erofs: initialize decompression early
>    erofs: add encoded extent on-disk definition
>    erofs: implement encoded extent metadata
>    erofs: support unaligned encoded data
>    erofs: enable 48-bit layout support
> 
>   fs/erofs/Kconfig             |  14 +--
>   fs/erofs/data.c              | 133 +++++++++++-------------
>   fs/erofs/decompressor.c      |   2 +-
>   fs/erofs/dir.c               |   7 +-
>   fs/erofs/erofs_fs.h          | 191 ++++++++++++++++-------------------
>   fs/erofs/inode.c             | 126 +++++++++++------------
>   fs/erofs/internal.h          |  30 +++---
>   fs/erofs/super.c             |  49 ++++-----
>   fs/erofs/sysfs.c             |   2 +
>   fs/erofs/zdata.c             |  96 +++++++++---------
>   fs/erofs/zmap.c              | 166 +++++++++++++++++++++++++-----
>   include/trace/events/erofs.h |   2 +-
>   12 files changed, 455 insertions(+), 363 deletions(-)
> 


