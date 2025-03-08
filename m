Return-Path: <linux-kernel+bounces-552411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB06FA5799E
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 10:56:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9FDE16DA00
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 09:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 357B51A9B4D;
	Sat,  8 Mar 2025 09:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AK//zFk7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96FC9BE4F
	for <linux-kernel@vger.kernel.org>; Sat,  8 Mar 2025 09:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741427781; cv=none; b=mh8Z+fKQEHvxaK5WSGBdXlyW54/eTPXkbzqHB0Wmb2k8ioZEIi10od6izvEqcGjVM4dFEVAiUaQANeXGp3Pwta8cpf+wf9+ejzPHNSa9E7uwPRuT4jpS8z+Wke6MTagKaVIal7YVOQNapqV+YpoX/KLuqQ4CdFIoAWLaaOahbpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741427781; c=relaxed/simple;
	bh=60XBRM5aenNPXo3XHWO87rpYBuXDMcswRuEPm9TqGE4=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Poky2CVvYvUOp0t4hi+tfHfVtWTSKEX3y8r5/500yjzWn2AwkM6vl+B4p0WkZKDKzkqYABIH3vwgMEMI4GXz1oeOOJeoAsIS7203hFJ5QpJPy3tPjMdQmHRm6xvS3EL36VFxl/9udHJoI3XNaYEpCiJgP1exTFJXtz3TWWYqPCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AK//zFk7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22788C4CEE0;
	Sat,  8 Mar 2025 09:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741427781;
	bh=60XBRM5aenNPXo3XHWO87rpYBuXDMcswRuEPm9TqGE4=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=AK//zFk7TzNhTPApiVSBFzhf1Xu4kSHH8GNMi1tuLKDYnRagedy3SfCl/n4vp9/aA
	 LYPGdytkFoAwQYYg+JYY+0wzCG+RnnQ8NgoBgNikVzetRIl7n/NtEttTI+u9iC7MJ0
	 0+h1AISHybOULmTG5BdUja8H8YiX57FXHGMw7Rv9teB2G9UlH37JR5El9dxZivny76
	 0ajJKCiGBdnugbbGOPneOwGjG6hD8i4+z8LtDKpTgcOguvn68fBYD/3ya1jJo5Q68T
	 X9vDKr0hbcOpvKTAB0/H8nN9XZOEa2UyRvffz4uC4yYNzoHDWC1mcmwVoPuK7MhM/E
	 l2JgGX85UA5cQ==
Message-ID: <adbc8517-95c5-41cd-b654-79f1ad7ab58c@kernel.org>
Date: Sat, 8 Mar 2025 17:56:18 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] f2fs: disalbe nat_bits by default
To: Jaegeuk Kim <jaegeuk@kernel.org>
References: <20250307031838.19164-1-chao@kernel.org>
 <Z8s2rmqauwCGJb9v@google.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <Z8s2rmqauwCGJb9v@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025/3/8 2:10, Jaegeuk Kim wrote:
> I meant let's support it conservatively if someone needs to enable
> in other platform.

Oh, I've updated it, we can control it via mount option now.

Thanks,

> 
> On 03/07, Chao Yu wrote:
>> Let's disable nat_bits by default.
>>
>> Signed-off-by: Chao Yu <chao@kernel.org>
>> ---
>>   fs/f2fs/node.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
>> index 56873c41436e..3148d9e44e7f 100644
>> --- a/fs/f2fs/node.c
>> +++ b/fs/f2fs/node.c
>> @@ -3286,6 +3286,9 @@ static int init_node_manager(struct f2fs_sb_info *sbi)
>>   	if (!nm_i->nat_bitmap)
>>   		return -ENOMEM;
>>   
>> +	/* disable nat_bits feature by default */
>> +	disable_nat_bits(sbi, true);
>> +
>>   	err = __get_nat_bitmaps(sbi);
>>   	if (err)
>>   		return err;
>> -- 
>> 2.40.1


