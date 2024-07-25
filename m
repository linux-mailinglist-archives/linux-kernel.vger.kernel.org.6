Return-Path: <linux-kernel+bounces-261852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E92B93BCEC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 09:13:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60BFE1C21165
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 07:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E387F16F26E;
	Thu, 25 Jul 2024 07:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AdT8Ku7j"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2493816EB7A
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 07:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721891593; cv=none; b=nOsvGB71PjNteC1oAAIVHe7GwRefHHYjPua8dDzxWZEaabUtowI4g835SUk257AQebes/73TgQUNvRe2y1qyXrSq3HFKW3k/eW+/G7FQQcvAOhN7DVEvOzF9tdR3bEzvLVYyjD3UiZpmXiihUH/+/kntpVsC1HsWVPezoVXOyk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721891593; c=relaxed/simple;
	bh=iznDeLtQSiFdYyE2zhnhjv/lPgCAZdyjML0IA41Ovtw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=frNZIoa5QTafdpkBy+wMq4lscwJQLP9zWRug7hmCjx8erGL3HrnNneZjAir+BfsfljHN7tJvs9HfzNwBhOHHtVie2PGHIwFP1hEHpoN5BH6Zq84ZEXa2Yt4X6EeEtke+bLwSt21vwM3U645iRXLeJx2YEWLBncC0O32ZQJLEl80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AdT8Ku7j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FB0CC116B1;
	Thu, 25 Jul 2024 07:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721891592;
	bh=iznDeLtQSiFdYyE2zhnhjv/lPgCAZdyjML0IA41Ovtw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=AdT8Ku7jXtEHlxLNdUSvJm9JkyfK+RnAg0zhubyW+jiIhyA3TosLqHW3tsKV3CDbU
	 A3vz3SuqCPLcoDIKPDvxgnjEyKYmiZR5x5vTrsfi4y64zYv6i3oJ//pF1YbssXjTHV
	 Z9zt07UMNUlK7gQuKlET4ySJRHGhVbRFjmDKlnnhXSKfPxkWv64fkosl3Y/jnSVVxp
	 6cxWNeehf31fY+LABonaUtcRMAYzaWUVTQBJCv4RMVN3OZ50nIrqzznNhno6oxdz4C
	 0XIiWVEfM0MJAcY9Mt3LDwX+uVsIQLZanx0WswAGMIzUgIBHktIvZyyyFI7abCuWRP
	 kFb21NS9kKdog==
Message-ID: <87e6efe0-0ce4-4ae2-84a4-9b86f35090b3@kernel.org>
Date: Thu, 25 Jul 2024 15:13:08 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [f2fs-dev] [PATCH] dump.f2fs: add checkpoint version to dump_nat
To: Wu Bo <bo.wu@vivo.com>
Cc: jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-kernel@vger.kernel.org, wubo.oduw@gmail.com
References: <fd64e14e-7a77-4fe4-9569-f7342c68953b@kernel.org>
 <20240725035119.2843004-1-bo.wu@vivo.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20240725035119.2843004-1-bo.wu@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/7/25 11:51, Wu Bo wrote:
> On Thu, Jul 25, 2024 at 10:33:33AM +0800, Chao Yu wrote:
>> On 2024/7/24 18:35, Wu Bo wrote:
>>> The cp_ver of node footer is useful when analyzing data corruption
>>> issues.
>>>
>>> Signed-off-by: Wu Bo <bo.wu@vivo.com>
>>> ---
>>>    fsck/dump.c | 33 ++++++++++++++++++---------------
>>>    1 file changed, 18 insertions(+), 15 deletions(-)
>>>
>>> diff --git a/fsck/dump.c b/fsck/dump.c
>>> index 8d5613e..ca38101 100644
>>> --- a/fsck/dump.c
>>> +++ b/fsck/dump.c
>>> @@ -21,7 +21,7 @@
>>>    #endif
>>>    #include <locale.h>
>>> -#define BUF_SZ	80
>>> +#define BUF_SZ	256
>>
>> 128 is fine?
> 
> This buffer is located in the stack. Making it a little bigger shouldn't cause a
> performance drop, right?

Yup,

> 128 seems prone to overflow if additional information is added later.

The message will be truncated rather than it will causing overflow and
overwriting random stack size, so, it's safe now?

How about expanding it once it's not enough?

> 
>>
>>>    /* current extent info */
>>>    struct extent_info dump_extent;
>>> @@ -38,6 +38,7 @@ void nat_dump(struct f2fs_sb_info *sbi, nid_t start_nat, nid_t end_nat)
>>>    {
>>>    	struct f2fs_nat_block *nat_block;
>>>    	struct f2fs_node *node_block;
>>> +	struct node_footer *footer;
>>>    	nid_t nid;
>>>    	pgoff_t block_addr;
>>>    	char buf[BUF_SZ];
>>> @@ -47,6 +48,7 @@ void nat_dump(struct f2fs_sb_info *sbi, nid_t start_nat, nid_t end_nat)
>>>    	ASSERT(nat_block);
>>>    	node_block = (struct f2fs_node *)calloc(F2FS_BLKSIZE, 1);
>>>    	ASSERT(node_block);
>>> +	footer = F2FS_NODE_FOOTER(node_block);
>>>    	fd = open("dump_nat", O_CREAT|O_WRONLY|O_TRUNC, 0666);
>>>    	ASSERT(fd >= 0);
>>> @@ -54,6 +56,7 @@ void nat_dump(struct f2fs_sb_info *sbi, nid_t start_nat, nid_t end_nat)
>>>    	for (nid = start_nat; nid < end_nat; nid++) {
>>>    		struct f2fs_nat_entry raw_nat;
>>>    		struct node_info ni;
>>> +		int len;
>>>    		if(nid == 0 || nid == F2FS_NODE_INO(sbi) ||
>>>    					nid == F2FS_META_INO(sbi))
>>>    			continue;
>>> @@ -66,15 +69,15 @@ void nat_dump(struct f2fs_sb_info *sbi, nid_t start_nat, nid_t end_nat)
>>>    			ret = dev_read_block(node_block, ni.blk_addr);
>>>    			ASSERT(ret >= 0);
>>>    			if (ni.blk_addr != 0x0) {
>>> -				memset(buf, 0, BUF_SZ);
>>> -				snprintf(buf, BUF_SZ,
>>> +				len = snprintf(buf, BUF_SZ,
>>>    					"nid:%5u\tino:%5u\toffset:%5u"
>>> -					"\tblkaddr:%10u\tpack:%d\n",
>>> +					"\tblkaddr:%10u\tpack:%d"
>>> +					"\tcp_ver:0x%08x\n",
>>>    					ni.nid, ni.ino,
>>> -					le32_to_cpu(F2FS_NODE_FOOTER(node_block)->flag) >>
>>> -						OFFSET_BIT_SHIFT,
>>> -					ni.blk_addr, pack);
>>> -				ret = write(fd, buf, strlen(buf));
>>> +					le32_to_cpu(footer->flag) >> OFFSET_BIT_SHIFT,
>>> +					ni.blk_addr, pack,
>>> +					(uint32_t)le64_to_cpu(footer->cp_ver));
>>
>> (uint64_t)le64_to_cpu(footer->cp_ver) ?
> 
> Is the upper 32 bits used for CRC?
> I've noticed that the checkpoint version dumped is always 32 bits long.
> To better compare with the current checkpoint, I only print the lower 32 bits here.

Do you want to compare high 32-bits crc value in cp_ver w/ crc value
in CP? maybe you can dump them to two hexadecimal numbers?

Thanks,

> 
>>
>>> +				ret = write(fd, buf, len);
>>>    				ASSERT(ret >= 0);
>>>    			}
>>>    		} else {
>>> @@ -87,15 +90,15 @@ void nat_dump(struct f2fs_sb_info *sbi, nid_t start_nat, nid_t end_nat)
>>>    			ret = dev_read_block(node_block, ni.blk_addr);
>>>    			ASSERT(ret >= 0);
>>> -			memset(buf, 0, BUF_SZ);
>>> -			snprintf(buf, BUF_SZ,
>>> +			len = snprintf(buf, BUF_SZ,
>>>    				"nid:%5u\tino:%5u\toffset:%5u"
>>> -				"\tblkaddr:%10u\tpack:%d\n",
>>> +				"\tblkaddr:%10u\tpack:%d"
>>> +				"\tcp_ver:0x%08x\n",
>>>    				ni.nid, ni.ino,
>>> -				le32_to_cpu(F2FS_NODE_FOOTER(node_block)->flag) >>
>>> -					OFFSET_BIT_SHIFT,
>>> -				ni.blk_addr, pack);
>>> -			ret = write(fd, buf, strlen(buf));
>>> +				le32_to_cpu(footer->flag) >> OFFSET_BIT_SHIFT,
>>> +				ni.blk_addr, pack,
>>> +				(uint32_t)le64_to_cpu(footer->cp_ver));
>>
>> Ditto,
>>
>> Thanks,
>>
>>> +			ret = write(fd, buf, len);
>>>    			ASSERT(ret >= 0);
>>>    		}
>>>    	}
>>
>>
>> _______________________________________________
>> Linux-f2fs-devel mailing list
>> Linux-f2fs-devel@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

