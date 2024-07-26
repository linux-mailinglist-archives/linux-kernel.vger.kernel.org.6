Return-Path: <linux-kernel+bounces-262761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E35093CC56
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 03:20:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD856282D26
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 01:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABB041C17;
	Fri, 26 Jul 2024 01:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gMFlrYz9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEADBED8
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 01:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721956838; cv=none; b=c+MbfgzJ8jU1mmZQEH3kBEMEPd77dJmndjiqfQmKGZmNxTCDSI6X57nDa2a8FhTwOfinCyP1gvQcQFl53YitJHnk/eJCP/jkRuOcE6KgBi5ayfFD2XJnP34VJ3iVW3jEf/zbZ2lQUM9yrTK/bcZF50s1R6LLjejg6q0cwspBYDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721956838; c=relaxed/simple;
	bh=YozLokCRygnO9rCCHDNVibLyEQRw1CmSYywlm7K/76c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GMTspve4GheInEDraDxD7X0RdCJ/bnSLzuSI1xAUFgh6P7u8R1Jzd/DY+zKUZjdwnhSoHN/xG5u5wuBpo5HYZ6/gDLiYRW6IZ7qx2Uwz0b1QPyovnz6iENSxNXpzMDu66k8SN9NY++Ua2XrRgd1fgwFmLNN8FIo9safTUQtFXwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gMFlrYz9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FD09C116B1;
	Fri, 26 Jul 2024 01:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721956837;
	bh=YozLokCRygnO9rCCHDNVibLyEQRw1CmSYywlm7K/76c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gMFlrYz9jOPOvC0dbOXjUJWp+hTMqc5+NNcvpWe1k54RK/dvBsuNMgWiKfKcXCAk2
	 caaSsjE3GG/atGwmbTZ3tdiVt8r2BW2iTtSoO7VoWUV168VLn1cpqFP2ar8pGIj29G
	 eLb3F0VKpmYY+44rTK+M5SXg9+2h8F2QsZUdghS+R4Sb71b7I3u8OoNZEo5x7Ss3En
	 UNOVChzoIEIlUfXUoKwBSW+hyWxqiJzFY6/cfUThSjnsDObg0yZjjJCGPsadjhmKFD
	 ICNyF8y2uLozss0XYM7YAPZBZgaqr/K4C/ozN8aHquh4+bIzyzliNiwYDHIZ/1tlSr
	 2Grm/ArWC8I2A==
Message-ID: <a2bf5d3e-6727-44d7-b1a0-3b1bcc7edad1@kernel.org>
Date: Fri, 26 Jul 2024 09:20:32 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] f2fs: sysfs: support atgc_enabled
To: liujinbao1 <jinbaoliu365@gmail.com>, jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 liujinbao1 <liujinbao1@xiaomi.com>
References: <20240221073249.1710026-1-jinbaoliu365@gmail.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20240221073249.1710026-1-jinbaoliu365@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/2/21 15:32, liujinbao1 wrote:
> From: liujinbao1 <liujinbao1@xiaomi.com>
> 
> When we add "atgc" to the fstab table, ATGC is not immediately enabled.
> There is a 7-day time threshold, and we can use "atgc_enabled" to
> show whether ATGC is enabled.

Oh, I missed to reply on this patch, what about adding this readonly
atgc_enabled sysfs entry into /sys/fs/f2fs/<dev>/stat/ directory?

Thanks,

> 
> Signed-off-by: liujinbao1 <liujinbao1@xiaomi.com>
> ---
>   Documentation/ABI/testing/sysfs-fs-f2fs | 6 ++++++
>   fs/f2fs/sysfs.c                         | 8 ++++++++
>   2 files changed, 14 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
> index 36c3cb547901..8597dfaef700 100644
> --- a/Documentation/ABI/testing/sysfs-fs-f2fs
> +++ b/Documentation/ABI/testing/sysfs-fs-f2fs
> @@ -564,6 +564,12 @@ Description:	When ATGC is on, it controls age threshold to bypass GCing young
>   		candidates whose age is not beyond the threshold, by default it was
>   		initialized as 604800 seconds (equals to 7 days).
>   
> +What:		/sys/fs/f2fs/<disk>/atgc_enabled
> +Date:		Feb 2024
> +Contact:	"Jinbao Liu" <liujinbao1@xiaomi.com>
> +Description:	It represents whether ATGC is on or off. The value is 1 which
> +               indicates that ATGC is on, and 0 indicates that it is off.
> +
>   What:		/sys/fs/f2fs/<disk>/gc_reclaimed_segments
>   Date:		July 2021
>   Contact:	"Daeho Jeong" <daehojeong@google.com>
> diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
> index 417fae96890f..0915872abd97 100644
> --- a/fs/f2fs/sysfs.c
> +++ b/fs/f2fs/sysfs.c
> @@ -143,6 +143,12 @@ static ssize_t pending_discard_show(struct f2fs_attr *a,
>   				&SM_I(sbi)->dcc_info->discard_cmd_cnt));
>   }
>   
> +static ssize_t atgc_enabled_show(struct f2fs_attr *a,
> +		struct f2fs_sb_info *sbi, char *buf)
> +{
> +	return sysfs_emit(buf, "%d\n", sbi->am.atgc_enabled ? 1 : 0);
> +}
> +
>   static ssize_t gc_mode_show(struct f2fs_attr *a,
>   		struct f2fs_sb_info *sbi, char *buf)
>   {
> @@ -1017,6 +1023,7 @@ F2FS_GENERAL_RO_ATTR(encoding);
>   F2FS_GENERAL_RO_ATTR(mounted_time_sec);
>   F2FS_GENERAL_RO_ATTR(main_blkaddr);
>   F2FS_GENERAL_RO_ATTR(pending_discard);
> +F2FS_GENERAL_RO_ATTR(atgc_enabled);
>   F2FS_GENERAL_RO_ATTR(gc_mode);
>   #ifdef CONFIG_F2FS_STAT_FS
>   F2FS_GENERAL_RO_ATTR(moved_blocks_background);
> @@ -1144,6 +1151,7 @@ static struct attribute *f2fs_attrs[] = {
>   	ATTR_LIST(atgc_candidate_count),
>   	ATTR_LIST(atgc_age_weight),
>   	ATTR_LIST(atgc_age_threshold),
> +	ATTR_LIST(atgc_enabled),
>   	ATTR_LIST(seq_file_ra_mul),
>   	ATTR_LIST(gc_segment_mode),
>   	ATTR_LIST(gc_reclaimed_segments),

