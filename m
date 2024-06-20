Return-Path: <linux-kernel+bounces-222202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4CEC90FE24
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 10:01:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F862281F18
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 08:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E4873BBCB;
	Thu, 20 Jun 2024 08:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rLJCB/E+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F412139D7
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 08:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718870471; cv=none; b=q6OsJ8d0nZ0CFbtZYaV2LmC0C+bFiQvcYgZTCKe4T1ckjRN1H+/KEoND+2u8FU1L4Frv6/aWZ7PUYqc8wezoeWfaMS6E3K+0m95UVnc6EV4H8slnVrMzm/bVok+rW9py65BJWFwkNeF/Yrz0gKcUPL9hUJNkkxJT9EmKAbRmkTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718870471; c=relaxed/simple;
	bh=Y3La64nEZFTJ5KhlL/R90AhCl3EJVfrwS8pZpoItdNs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kBAYI/HEd6C+3+CV03QliCQORww9h56KwrVSd1gAvpl5UH57EVPlFE0vmGcpns84CqhB90p8vG/pMB+CpchDYYdQYL2RCPeMUPce/dvMVBU0xXWvlgDYrWkfldzAEuLk2NpWD8lBxF6eHW+DLOvDfc8ig8n/VP8xsWaiSvP5uQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rLJCB/E+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BB17C2BD10;
	Thu, 20 Jun 2024 08:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718870469;
	bh=Y3La64nEZFTJ5KhlL/R90AhCl3EJVfrwS8pZpoItdNs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=rLJCB/E+oza6ve0WtASPkLy9Z16lpaqCTtre4fZc+LU0B8XmV0PFiVznxQwk2DIAi
	 RR0CLqzK+gukCA1QRaTcNjyphSFabRCrqUXLpRAne2oACzfZ8Oqx75WBgwDf4OI4UY
	 56gSm9TQxy1SZ4wNVOhC3J5vf84l8EHB2CzICh1nCY2+Ibcrskjd8Jg8h1sPE7ndFr
	 r8Dtv5zL6hLezaL2HutDGVHoWqgEB6RPDdhReW53FaWEPnmv2xvvhT+RSIRDt17MAK
	 JkZkHnxo225ErCf1kC62Ll5jHoHFcjeZ6JLhTKxcnb2dM1VbWqwlSajumNQA/6cVqT
	 BMzwHX4fgD3kw==
Message-ID: <04e52097-def3-4baa-a566-8519c8a2b26d@kernel.org>
Date: Thu, 20 Jun 2024 16:01:05 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: (2) (2) (2) [f2fs-dev] [PATCH] Revert "f2fs: use flush command
 instead of FUA for zoned device"
To: daejun7.park@samsung.com, "jaegeuk@kernel.org" <jaegeuk@kernel.org>,
 Wenjie Cheng <cwjhust@gmail.com>
Cc: "qwjhust@gmail.com" <qwjhust@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-f2fs-devel@lists.sourceforge.net"
 <linux-f2fs-devel@lists.sourceforge.net>
References: <e0d89f10-19b0-45db-948d-4c140c2dffa7@kernel.org>
 <e2371e59-7be5-40dc-9a2a-aef90ac93b18@kernel.org>
 <2842767c-db80-407b-a5e5-2b9fa74b0d79@kernel.org>
 <20240614004841.103114-1-cwjhust@gmail.com>
 <20240620055648epcms2p11b9914d40f560fb02fa241a7d2599298@epcms2p1>
 <20240620072218epcms2p11597e482b28804dd5f66b9d42a21b22f@epcms2p1>
 <CGME20240620032223epcas2p4d6b770a8e256d140e5296df8a386418e@epcms2p3>
 <20240620075634epcms2p35d3bafffb5f60902b1df25bf3269a686@epcms2p3>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20240620075634epcms2p35d3bafffb5f60902b1df25bf3269a686@epcms2p3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024/6/20 15:56, Daejun Park wrote:
>> On 2024/6/20 15:22, Daejun Park wrote:
>>>> On 2024/6/20 13:56, Daejun Park wrote:
>>>>> Hi Chao,
>>>>>
>>>>>> Jaegeuk,
>>>>>>
>>>>>> Quoted commit message from commit c550e25bca66 ("f2fs: use flush command
>>>>>> instead of FUA for zoned device")
>>>>>> "
>>>>>> The block layer for zoned disk can reorder the FUA'ed IOs. Let's use flush
>>>>>> command to keep the write order.
>>>>>> "
>>>>>>
>>>>>> It seems mq-deadline use fifo queue and make queue depth of zone device
>>>>>> as 1 to IO order, so why FUA'ed write node IOs can be reordered by block
>>>>>> layer?
>>>>>
>>>>> While other writes are aligned by the mq-deadline, write with FUA is not passed
>>>>> to the scheduler but handled at the block layer.
>>>>
>>>> Hi Daejun,
>>>>
>>>> IIUC, do you mean write w/ FUA may be handled directly in below path?
>>>>
>>>> - blk_mq_submit_bio
>>>>      - op_is_flush && blk_insert_flush
>>>
>>> Hi Chao,
>>>
>>> Yes, I think the path caused an unaligned write when the zone lock was
>>> being applied by mq-deadline.
>>
>> But, blk_insert_flush() may return false due to policy should be
>> REQ_FSEQ_DATA or REQ_FSEQ_DATA REQ_FSEQ_POSTFLUSH, then
>> blk_mq_insert_request() after blk_insert_flush() will be called?
>>
> 
> I was just discussing the handling of FUAs in commit c550e25bca66,
> which is not an issue in the current code as FUAs are handled correctly.

Yup, I think it needs to be reverted. :)

Thanks,

> 
> Thanks,
> 
> 
>> Thanks,
>>
>>>
>>>>
>>>> Thanks,
>>>>
>>>>>
>>>>> Thanks,
>>>>> Daejun
>>>>>
>>>>>>
>>>>>> Thanks,
>>>>>>
>>>>>> On 2024/6/14 8:48, Wenjie Cheng wrote:
>>>>>>> This reverts commit c550e25bca660ed2554cbb48d32b82d0bb98e4b1.
>>>>>>>
>>>>>>> Commit c550e25bca660ed2554cbb48d32b82d0bb98e4b1 ("f2fs: use flush
>>>>>>> command instead of FUA for zoned device") used additional flush
>>>>>>> command to keep write order.
>>>>>>>
>>>>>>> Since Commit dd291d77cc90eb6a86e9860ba8e6e38eebd57d12 ("block:
>>>>>>> Introduce zone write plugging") has enabled the block layer to
>>>>>>> handle this order issue, there is no need to use flush command.
>>>>>>>
>>>>>>> Signed-off-by: Wenjie Cheng <cwjhust@gmail.com>
>>>>>>> ---
>>>>>>>        fs/f2fs/file.c 3 +--
>>>>>>>        fs/f2fs/node.c 2 +-
>>>>>>>        2 files changed, 2 insertions(+), 3 deletions(-)
>>>>>>>
>>>>>>> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
>>>>>>> index eae2e7908072..f08e6208e183 100644
>>>>>>> --- a/fs/f2fs/file.c
>>>>>>> +++ b/fs/f2fs/file.c
>>>>>>> @@ -372,8 +372,7 @@ static int f2fs_do_sync_file(struct file *file, loff_t start, loff_t end,
>>>>>>>                 f2fs_remove_ino_entry(sbi, ino, APPEND_INO);
>>>>>>>                 clear_inode_flag(inode, FI_APPEND_WRITE);
>>>>>>>        flush_out:
>>>>>>> -        if ((!atomic && F2FS_OPTION(sbi).fsync_mode != FSYNC_MODE_NOBARRIER)
>>>>>>> -            (atomic && !test_opt(sbi, NOBARRIER) && f2fs_sb_has_blkzoned(sbi)))
>>>>>>> +        if (!atomic && F2FS_OPTION(sbi).fsync_mode != FSYNC_MODE_NOBARRIER)
>>>>>>>                         ret = f2fs_issue_flush(sbi, inode->i_ino);
>>>>>>>                 if (!ret) {
>>>>>>>                         f2fs_remove_ino_entry(sbi, ino, UPDATE_INO);
>>>>>>> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
>>>>>>> index 144f9f966690..c45d341dcf6e 100644
>>>>>>> --- a/fs/f2fs/node.c
>>>>>>> +++ b/fs/f2fs/node.c
>>>>>>> @@ -1631,7 +1631,7 @@ static int __write_node_page(struct page *page, bool atomic, bool *submitted,
>>>>>>>                         goto redirty_out;
>>>>>>>                 }
>>>>>>>   
>>>>>>> -        if (atomic && !test_opt(sbi, NOBARRIER) && !f2fs_sb_has_blkzoned(sbi))
>>>>>>> +        if (atomic && !test_opt(sbi, NOBARRIER))
>>>>>>>                         fio.op_flags = REQ_PREFLUSH REQ_FUA;
>>>>>>>   
>>>>>>>                 /* should add to global list before clearing PAGECACHE status */

