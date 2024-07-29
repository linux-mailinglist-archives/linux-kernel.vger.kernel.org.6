Return-Path: <linux-kernel+bounces-265034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FA8C93EBB8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 04:55:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ABB81B20F4D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 02:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5D8E7F7CA;
	Mon, 29 Jul 2024 02:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dj4r7rka"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E69768EF
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 02:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722221723; cv=none; b=Y84/w0bCVYLu2FZ6Gn4kQw72SFTV9WyxtUiIoAA9L681/6iK1aSWRTi2YGdBQsMUdG5rwMJKlbbLG7nPaOG9NiPQhdriv4pCahiDOl3eFybz/1orhAKggcsKWzHPbqLlshItV0f3L2nQAise1IE2C7szGfdjFgVddyBmARVc3Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722221723; c=relaxed/simple;
	bh=j0H9QTslhDV/5VOLLPEqODcRjE2Iv8/sMBXxP93cwAE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WkIwZ4xWENSQNC6X2+0EAefxv1//XxBTjyBamvP5k1Gi55Ub8zut8OVu22HdQgrUTCMkSdoLSPxuZ+2PfCruPjicHHW43KVv+tN6feIRKKRf1ilgEWLEyjsuzUMe3oZfuauUNSHGyJRfIZFrG6VIhJmkuC1lU8Y343C7mTSI5xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dj4r7rka; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49F1CC116B1;
	Mon, 29 Jul 2024 02:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722221722;
	bh=j0H9QTslhDV/5VOLLPEqODcRjE2Iv8/sMBXxP93cwAE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=dj4r7rka0FGQFqHB84aUDOzhgWy8SwFLLIdtdfXUs5/De9VnuveIpCx9mVeYKPe4/
	 7/D/FNItBs8tqIgMzrOI/Y0zVC/hlzfiZ5ZtkjZk9RwG2m7IiuOZJZSjzd8kBu6w5C
	 2KpKIlpfMASv2f8LCknVfp6BQTZGZVxP0fjcdgsS9wY5/pYFXAtnfyrJey9kjYRJJD
	 JWxfcwhR63NpxR8FuI51dbYEDD9s6GpAWaQ/dhIQqB6KVljPZ+71lWOUJ6zek8xuMR
	 bQSOhr4VoQ6OCDtfCFyZ5eNUiQKgce56TnPZvYZAvyz+zn1RvWoBuomAc5aY9g6NoI
	 P7hSIqf5jrbPA==
Message-ID: <44d5de6d-bd0f-4dd8-bf9b-281f68769714@kernel.org>
Date: Mon, 29 Jul 2024 10:55:18 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] f2fs: sysfs: support atgc_enabled
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: liujinbao1 <jinbaoliu365@gmail.com>,
 linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 liujinbao1 <liujinbao1@xiaomi.com>
References: <20240221073249.1710026-1-jinbaoliu365@gmail.com>
 <a2bf5d3e-6727-44d7-b1a0-3b1bcc7edad1@kernel.org>
 <ZqRotoF2iDcx2MZF@google.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <ZqRotoF2iDcx2MZF@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/7/27 11:25, Jaegeuk Kim wrote:
> On 07/26, Chao Yu wrote:
>> On 2024/2/21 15:32, liujinbao1 wrote:
>>> From: liujinbao1 <liujinbao1@xiaomi.com>
>>>
>>> When we add "atgc" to the fstab table, ATGC is not immediately enabled.
>>> There is a 7-day time threshold, and we can use "atgc_enabled" to
>>> show whether ATGC is enabled.
>>
>> Oh, I missed to reply on this patch, what about adding this readonly
>> atgc_enabled sysfs entry into /sys/fs/f2fs/<dev>/stat/ directory?
> 
> It looks like not stat.

Okay,

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

> 
>>
>> Thanks,
>>
>>>
>>> Signed-off-by: liujinbao1 <liujinbao1@xiaomi.com>
>>> ---
>>>    Documentation/ABI/testing/sysfs-fs-f2fs | 6 ++++++
>>>    fs/f2fs/sysfs.c                         | 8 ++++++++
>>>    2 files changed, 14 insertions(+)
>>>
>>> diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
>>> index 36c3cb547901..8597dfaef700 100644
>>> --- a/Documentation/ABI/testing/sysfs-fs-f2fs
>>> +++ b/Documentation/ABI/testing/sysfs-fs-f2fs
>>> @@ -564,6 +564,12 @@ Description:	When ATGC is on, it controls age threshold to bypass GCing young
>>>    		candidates whose age is not beyond the threshold, by default it was
>>>    		initialized as 604800 seconds (equals to 7 days).
>>> +What:		/sys/fs/f2fs/<disk>/atgc_enabled
>>> +Date:		Feb 2024
>>> +Contact:	"Jinbao Liu" <liujinbao1@xiaomi.com>
>>> +Description:	It represents whether ATGC is on or off. The value is 1 which
>>> +               indicates that ATGC is on, and 0 indicates that it is off.
>>> +
>>>    What:		/sys/fs/f2fs/<disk>/gc_reclaimed_segments
>>>    Date:		July 2021
>>>    Contact:	"Daeho Jeong" <daehojeong@google.com>
>>> diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
>>> index 417fae96890f..0915872abd97 100644
>>> --- a/fs/f2fs/sysfs.c
>>> +++ b/fs/f2fs/sysfs.c
>>> @@ -143,6 +143,12 @@ static ssize_t pending_discard_show(struct f2fs_attr *a,
>>>    				&SM_I(sbi)->dcc_info->discard_cmd_cnt));
>>>    }
>>> +static ssize_t atgc_enabled_show(struct f2fs_attr *a,
>>> +		struct f2fs_sb_info *sbi, char *buf)
>>> +{
>>> +	return sysfs_emit(buf, "%d\n", sbi->am.atgc_enabled ? 1 : 0);
>>> +}
>>> +
>>>    static ssize_t gc_mode_show(struct f2fs_attr *a,
>>>    		struct f2fs_sb_info *sbi, char *buf)
>>>    {
>>> @@ -1017,6 +1023,7 @@ F2FS_GENERAL_RO_ATTR(encoding);
>>>    F2FS_GENERAL_RO_ATTR(mounted_time_sec);
>>>    F2FS_GENERAL_RO_ATTR(main_blkaddr);
>>>    F2FS_GENERAL_RO_ATTR(pending_discard);
>>> +F2FS_GENERAL_RO_ATTR(atgc_enabled);
>>>    F2FS_GENERAL_RO_ATTR(gc_mode);
>>>    #ifdef CONFIG_F2FS_STAT_FS
>>>    F2FS_GENERAL_RO_ATTR(moved_blocks_background);
>>> @@ -1144,6 +1151,7 @@ static struct attribute *f2fs_attrs[] = {
>>>    	ATTR_LIST(atgc_candidate_count),
>>>    	ATTR_LIST(atgc_age_weight),
>>>    	ATTR_LIST(atgc_age_threshold),
>>> +	ATTR_LIST(atgc_enabled),
>>>    	ATTR_LIST(seq_file_ra_mul),
>>>    	ATTR_LIST(gc_segment_mode),
>>>    	ATTR_LIST(gc_reclaimed_segments),

