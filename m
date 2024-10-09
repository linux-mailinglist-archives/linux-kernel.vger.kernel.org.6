Return-Path: <linux-kernel+bounces-356439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD1F5996114
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 09:40:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79E171F2170C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 07:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AC6D183CCA;
	Wed,  9 Oct 2024 07:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ukj7pfxl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011B017C9AC
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 07:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728459595; cv=none; b=exvJxFAcP8kFO6CUqeU6Btf4mDMJb+L/lbH5rMBYPR86NFIkpgMAWD5IRMgWwE7aEhE3G81ZLMV5Li3Y6jk4sXquKYySEqnL0fPB8VeR+S32u8GDi94KBHh+JF5oLCf8xXjUy9Bt1kXGkqju5p6a4IxevgoCwBvYlsRTjDOQZZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728459595; c=relaxed/simple;
	bh=dnzlc1VWzpkmxxhS5ccO7X0laqxK6Ptv5GnMR37hZhQ=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Oa1ygsBQL1/qSvyqXLi9YXArsvaEdpc/hwpACx6PBRWF1WWJDZLIafmHQTUSfTxkniVPkFcmuL/kPn5hma+zM39+QT6KyO0rUJLQXJdqmDDKBj0Bnelf0yBVthCXo4ediKDsuXkhlh1sqWEs8fU7Vbdoy+XpdIcP2aSan3lvbd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ukj7pfxl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E928C4CECE;
	Wed,  9 Oct 2024 07:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728459594;
	bh=dnzlc1VWzpkmxxhS5ccO7X0laqxK6Ptv5GnMR37hZhQ=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=Ukj7pfxl6BPr6vxUtr/OrU0Gp1B/0rQZWFO1jpzQweP/mFsD+fODF/pO6soIHpomX
	 PdSHO6OVu4XVUT66SGwv5LEG+wq6jAQgYLvAqMa+nfaUpZRyuX9ULRPueVrsH7YEtC
	 Z6i9lJZ9m+EiR0hB2rNysdrz2JP5yk8qk6pVSBgmJLB2EluFKZnM+mz0yjWvd8vz2/
	 eJ6GZ01KBsfEAW43ZBro7MhfL2AJYOmtbitLo9Vn3HGIcEvQada1bvjFgRqdKm8o/m
	 nZTUJcu7A1JT08NEq2ICJPHc0nlkuhHkaQKoTI6b2ZlKlOfRdy9wa8EYYklmFg9uGD
	 sB3nZT1E/zZAw==
Message-ID: <bcaef79d-29f9-47fa-9f92-64e665e95fa2@kernel.org>
Date: Wed, 9 Oct 2024 15:39:50 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Chao Yu <chao@kernel.org>, linux-f2fs-devel@lists.sourceforge.net,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] f2fs-tools:provide a more reasonable ovp rate for
 manually setting rsvd
To: Liao Yuanhong <liaoyuanhong@vivo.com>, Jaegeuk Kim <jaegeuk@kernel.org>
References: <20240924095636.19457-1-liaoyuanhong@vivo.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20240924095636.19457-1-liaoyuanhong@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/9/24 17:56, Liao Yuanhong wrote:
> The f2fs-tools support manual configuration of rsvd and ovp rate. In cases
> where only a small rsvd is set, the automatically calculated ovp rate can
> be very large, resulting in the reserved space of the entire file system
> being almost the same as before, failing to achieve the goal of reducing
> space usage. Therefore, for cases where only rsvd is set and ovp rate is
> not, we will provide the same ovp rate as in normal situations, which
> exceeds overprovision_segment_buffer, and does not occupy additional space.
> 
> Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>
> ---
>   fsck/resize.c      |  2 +-
>   include/f2fs_fs.h  |  8 ++++----
>   mkfs/f2fs_format.c | 15 ++++++++++++---
>   3 files changed, 17 insertions(+), 8 deletions(-)
> 
> diff --git a/fsck/resize.c b/fsck/resize.c
> index 049ddd3..eca6555 100644
> --- a/fsck/resize.c
> +++ b/fsck/resize.c
> @@ -147,7 +147,7 @@ safe_resize:
>   
>   	/* Let's determine the best reserved and overprovisioned space */
>   	if (c.new_overprovision == 0)
> -		c.new_overprovision = get_best_overprovision(sb);
> +		c.new_overprovision = get_best_overprovision(sb, true);
>   
>   	c.new_reserved_segments =
>   		(100 / c.new_overprovision + 1 + NR_CURSEG_TYPE) *
> diff --git a/include/f2fs_fs.h b/include/f2fs_fs.h
> index 870a6e4..038002a 100644
> --- a/include/f2fs_fs.h
> +++ b/include/f2fs_fs.h
> @@ -1760,13 +1760,13 @@ extern uint32_t f2fs_get_usable_segments(struct f2fs_super_block *sb);
>   #define ZONE_ALIGN(blks)	SIZE_ALIGN(blks, c.blks_per_seg * \
>   					c.segs_per_zone)
>   
> -static inline uint32_t get_reserved(struct f2fs_super_block *sb, double ovp)
> +static inline uint32_t get_reserved(struct f2fs_super_block *sb, double ovp, bool conf_reserved)
>   {
>   	uint32_t usable_main_segs = f2fs_get_usable_segments(sb);
>   	uint32_t segs_per_sec = round_up(usable_main_segs, get_sb(section_count));
>   	uint32_t reserved;
>   
> -	if (c.conf_reserved_sections)
> +	if (c.conf_reserved_sections && conf_reserved)
>   		reserved = c.conf_reserved_sections * segs_per_sec;
>   	else
>   		reserved = (100 / ovp + 1 + NR_CURSEG_TYPE) * segs_per_sec;
> @@ -1781,7 +1781,7 @@ static inline uint32_t overprovision_segment_buffer(struct f2fs_super_block *sb)
>   	return 6 * get_sb(segs_per_sec);
>   }
>   
> -static inline double get_best_overprovision(struct f2fs_super_block *sb)
> +static inline double get_best_overprovision(struct f2fs_super_block *sb, bool conf_reserved)
>   {
>   	double ovp, candidate, end, diff, space;
>   	double max_ovp = 0, max_space = 0;
> @@ -1799,7 +1799,7 @@ static inline double get_best_overprovision(struct f2fs_super_block *sb)
>   	}
>   
>   	for (; candidate <= end; candidate += diff) {
> -		reserved = get_reserved(sb, candidate);
> +		reserved = get_reserved(sb, candidate, conf_reserved);
>   		ovp = (usable_main_segs - reserved) * candidate / 100;
>   		if (ovp < 0)
>   			continue;
> diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
> index e26a513..9c917c9 100644
> --- a/mkfs/f2fs_format.c
> +++ b/mkfs/f2fs_format.c
> @@ -480,10 +480,19 @@ static int f2fs_prepare_super_block(void)
>   	 * overprovision ratio and reserved seg count based on avg usable
>   	 * segs_per_sec.
>   	 */
> -	if (c.overprovision == 0)
> -		c.overprovision = get_best_overprovision(sb);
> +	if (c.overprovision == 0) {
>   
> -	c.reserved_segments = get_reserved(sb, c.overprovision);
> +		/*
> +		 * If rsvd is manually set but ovp rate is not,
> +		 * provide the same ovp rate as in normal allocation.
> +		 */
> +		if (c.conf_reserved_sections)
> +			c.overprovision = get_best_overprovision(sb, false);
> +		else
> +			c.overprovision = get_best_overprovision(sb, true);

get_best_overprovision() can provide a pair value [ovp, reserved], which can
maximize available space for user. If we just pick one of them, and use configured
one instead of another of them, it's weird.

For your case, maybe we can introduce a default ovp value, and use it w/ configured
reserved value? or you can assign ovp/reserved secs directly by using -o and -Z?

Thanks,

> +	}
> +
> +	c.reserved_segments = get_reserved(sb, c.overprovision, true);
>   
>   	if (c.feature & F2FS_FEATURE_RO) {
>   		c.overprovision = 0;


