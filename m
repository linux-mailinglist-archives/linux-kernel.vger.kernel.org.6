Return-Path: <linux-kernel+bounces-222161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AF3890FDAC
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 09:27:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C92EA1F2532E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 07:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B7484502E;
	Thu, 20 Jun 2024 07:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fQP1gFIn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD79144C64
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 07:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718868434; cv=none; b=n/uCjsC3DkV4eAPymqTBJv9zEQHJGBMWO9mxl2hXIiIyGYlbri/zcko8XnuBvYoXR7d0w+PfdfPxaRqRXw1xz+wny61JAhin9MsKmUgHOULIlPSU+k4EYX34spTKuWPydyozWC5RN6EkJUD3aWWxjMbgQT94yMe7GBTeeoVgl5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718868434; c=relaxed/simple;
	bh=CY+mRGNDq8rdR0CzZNFjbj7kad13ZCd0sT3y0g/8Pgs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O/BMJoc+44NRL7qUoQdDRKwk3jAWkbxq2pEy8YvhhVqLrYJ+HzFLM/5rcYTUIFfQ3eTQViLObLWT1Za+F1BDrfW+6htYAY1ujBo8bvYeSa0BrM+v+1Iwhrd6WfuApoL9XyK7lGgkKlNs6LFmqFxeTsCNTb9forT0aVC8XzGHtLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fQP1gFIn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34303C2BD10;
	Thu, 20 Jun 2024 07:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718868434;
	bh=CY+mRGNDq8rdR0CzZNFjbj7kad13ZCd0sT3y0g/8Pgs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=fQP1gFIn9YhJ8cBdijzEsehb84fwwpmWAsPuXehzXJlTCq/o19FAw+ZS8WOcDLzYa
	 hqF/9OPpQaOUXzSmXmnXUSlMu9qBiVLjmUApL1JEXbHLMtE88y35iakZbrBX7Sa5Qu
	 /k+ptp5anlyiwYNSFHyboUxxlOFYqGj/kqjA/od31NkwlJXWASopq2B4XsmlzCWW7H
	 QvMExtedtw4vfsssbGJCCWSqSJYirr7+4/g4H10Ylcta00XlOmyJQZTGDXkZN0HNsc
	 eaoqCZE4y84j4nVLUHN6WAsxDmmkOEzxwfrcGQYgsMV9wfKPVQpt2aNrT5TaWT3nBK
	 Lwl3R+rUH+MQw==
Message-ID: <e0d89f10-19b0-45db-948d-4c140c2dffa7@kernel.org>
Date: Thu, 20 Jun 2024 15:27:10 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: (2) (2) [f2fs-dev] [PATCH] Revert "f2fs: use flush command
 instead of FUA for zoned device"
To: daejun7.park@samsung.com, "jaegeuk@kernel.org" <jaegeuk@kernel.org>,
 Wenjie Cheng <cwjhust@gmail.com>
Cc: "qwjhust@gmail.com" <qwjhust@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-f2fs-devel@lists.sourceforge.net"
 <linux-f2fs-devel@lists.sourceforge.net>
References: <e2371e59-7be5-40dc-9a2a-aef90ac93b18@kernel.org>
 <2842767c-db80-407b-a5e5-2b9fa74b0d79@kernel.org>
 <20240614004841.103114-1-cwjhust@gmail.com>
 <20240620055648epcms2p11b9914d40f560fb02fa241a7d2599298@epcms2p1>
 <CGME20240620032223epcas2p4d6b770a8e256d140e5296df8a386418e@epcms2p1>
 <20240620072218epcms2p11597e482b28804dd5f66b9d42a21b22f@epcms2p1>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20240620072218epcms2p11597e482b28804dd5f66b9d42a21b22f@epcms2p1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024/6/20 15:22, Daejun Park wrote:
>> On 2024/6/20 13:56, Daejun Park wrote:
>>> Hi Chao,
>>>
>>>> Jaegeuk,
>>>>
>>>> Quoted commit message from commit c550e25bca66 ("f2fs: use flush command
>>>> instead of FUA for zoned device")
>>>> "
>>>> The block layer for zoned disk can reorder the FUA'ed IOs. Let's use flush
>>>> command to keep the write order.
>>>> "
>>>>
>>>> It seems mq-deadline use fifo queue and make queue depth of zone device
>>>> as 1 to IO order, so why FUA'ed write node IOs can be reordered by block
>>>> layer?
>>>
>>> While other writes are aligned by the mq-deadline, write with FUA is not passed
>>> to the scheduler but handled at the block layer.
>>
>> Hi Daejun,
>>
>> IIUC, do you mean write w/ FUA may be handled directly in below path?
>>
>> - blk_mq_submit_bio
>>    - op_is_flush && blk_insert_flush
> 
> Hi Chao,
> 
> Yes, I think the path caused an unaligned write when the zone lock was
> being applied by mq-deadline.

But, blk_insert_flush() may return false due to policy should be
REQ_FSEQ_DATA or REQ_FSEQ_DATA | REQ_FSEQ_POSTFLUSH, then
blk_mq_insert_request() after blk_insert_flush() will be called?

Thanks,

> 
>>
>> Thanks,
>>
>>>
>>> Thanks,
>>> Daejun
>>>
>>>>
>>>> Thanks,
>>>>
>>>> On 2024/6/14 8:48, Wenjie Cheng wrote:
>>>>> This reverts commit c550e25bca660ed2554cbb48d32b82d0bb98e4b1.
>>>>>
>>>>> Commit c550e25bca660ed2554cbb48d32b82d0bb98e4b1 ("f2fs: use flush
>>>>> command instead of FUA for zoned device") used additional flush
>>>>> command to keep write order.
>>>>>
>>>>> Since Commit dd291d77cc90eb6a86e9860ba8e6e38eebd57d12 ("block:
>>>>> Introduce zone write plugging") has enabled the block layer to
>>>>> handle this order issue, there is no need to use flush command.
>>>>>
>>>>> Signed-off-by: Wenjie Cheng <cwjhust@gmail.com>
>>>>> ---
>>>>>      fs/f2fs/file.c 3 +--
>>>>>      fs/f2fs/node.c 2 +-
>>>>>      2 files changed, 2 insertions(+), 3 deletions(-)
>>>>>
>>>>> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
>>>>> index eae2e7908072..f08e6208e183 100644
>>>>> --- a/fs/f2fs/file.c
>>>>> +++ b/fs/f2fs/file.c
>>>>> @@ -372,8 +372,7 @@ static int f2fs_do_sync_file(struct file *file, loff_t start, loff_t end,
>>>>>               f2fs_remove_ino_entry(sbi, ino, APPEND_INO);
>>>>>               clear_inode_flag(inode, FI_APPEND_WRITE);
>>>>>      flush_out:
>>>>> -        if ((!atomic && F2FS_OPTION(sbi).fsync_mode != FSYNC_MODE_NOBARRIER)
>>>>> -            (atomic && !test_opt(sbi, NOBARRIER) && f2fs_sb_has_blkzoned(sbi)))
>>>>> +        if (!atomic && F2FS_OPTION(sbi).fsync_mode != FSYNC_MODE_NOBARRIER)
>>>>>                       ret = f2fs_issue_flush(sbi, inode->i_ino);
>>>>>               if (!ret) {
>>>>>                       f2fs_remove_ino_entry(sbi, ino, UPDATE_INO);
>>>>> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
>>>>> index 144f9f966690..c45d341dcf6e 100644
>>>>> --- a/fs/f2fs/node.c
>>>>> +++ b/fs/f2fs/node.c
>>>>> @@ -1631,7 +1631,7 @@ static int __write_node_page(struct page *page, bool atomic, bool *submitted,
>>>>>                       goto redirty_out;
>>>>>               }
>>>>>   
>>>>> -        if (atomic && !test_opt(sbi, NOBARRIER) && !f2fs_sb_has_blkzoned(sbi))
>>>>> +        if (atomic && !test_opt(sbi, NOBARRIER))
>>>>>                       fio.op_flags = REQ_PREFLUSH REQ_FUA;
>>>>>   
>>>>>               /* should add to global list before clearing PAGECACHE status */

