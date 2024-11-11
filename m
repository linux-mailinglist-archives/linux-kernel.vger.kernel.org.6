Return-Path: <linux-kernel+bounces-403796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BBE19C3AF6
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 10:36:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A8A8B226F7
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 09:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4D4914A60F;
	Mon, 11 Nov 2024 09:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Pf2E7tYo"
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54120145B25
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 09:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731317762; cv=none; b=r2Ioc+E8aBQxsXQzN3TjGKj8tz7ivXbB4mEgdJDDadVcofGkQ5/hhV0ie7VBftFfU8Dmcl8EqcSGfP/6TxQ5Oy3a2kxYmjXu6gSciwBA4eZ5ZMyX58kZJxdS53JHX3A1IeHZU5Wwf2NT/Hejn/mpUZlJzo2gB1lvHwjdG9/JLUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731317762; c=relaxed/simple;
	bh=iIW5qj9a/eM0HykFd6sTzBvh1Kj4iue7W2O9hAD71jA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qeptA9CMJ3SiFdtvDffTaaVpi8MZHPgFeolpFlncRMN8+z6hnXdWBT/ON8SykEc1nIwH2L7Qr2BaYB6INWQcEpuvJ9BRpTtChY8LGc793ZVFoPiTriP6YBchb9p89PqzOryIhotO425ykhT2uoNrFViDpg7tpva165Y8SCT9UqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Pf2E7tYo; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1731317751; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=Hpg+68rgL8L/zyM5X4Eco0pzFbnhK0+ZZq9cQjmtXs4=;
	b=Pf2E7tYo8zi2voOJpM678R/ntAiUXjnFnxSslTvzOR7g9QLBELYFE3/7sN9aBVvy8N4LI0ct5u3OnbF04GCt54Xd751DBNO+HP8qpXNhjC0ZlNWFa6wIjz53mWDPD13jny5rvLLSvMXtpuIEm3TMFzIdJ4bT6EODQJdFyRTE654=
Received: from 30.221.129.158(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0WJ8TrbA_1731317750 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 11 Nov 2024 17:35:50 +0800
Message-ID: <6c468b6c-c449-444d-90af-fd2a6c7c1993@linux.alibaba.com>
Date: Mon, 11 Nov 2024 17:35:49 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ocfs2: update seq_file index in ocfs2_dlm_seq_next
To: Wengang Wang <wen.gang.wang@oracle.com>
Cc: "ocfs2-devel@lists.linux.dev" <ocfs2-devel@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20241108192829.58813-1-wen.gang.wang@oracle.com>
 <614f6304-f096-41f7-b0a4-05127904e601@linux.alibaba.com>
 <72E849B5-ECE7-4304-AF90-A60784B4EEFF@oracle.com>
Content-Language: en-US
From: Joseph Qi <joseph.qi@linux.alibaba.com>
In-Reply-To: <72E849B5-ECE7-4304-AF90-A60784B4EEFF@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 11/11/24 3:04 PM, Wengang Wang wrote:
> 
> 
>> On Nov 10, 2024, at 5:38 PM, Joseph Qi <joseph.qi@linux.alibaba.com> wrote:
>>
>>
>>
>> On 11/9/24 3:28 AM, Wengang Wang wrote:
>>> The following INFO level message was seen:
>>>
>>> seq_file: buggy .next function ocfs2_dlm_seq_next [ocfs2] did not
>>> update position index
>>>
>>> Fix:
>>> Updata m->index to make seq_read_iter happy though the index its self makes
>>> no sense to ocfs2_dlm_seq_next.
>>>
>>> Signed-off-by: Wengang Wang <wen.gang.wang@oracle.com>
>>> ---
>>> fs/ocfs2/dlmglue.c | 1 +
>>> 1 file changed, 1 insertion(+)
>>>
>>> diff --git a/fs/ocfs2/dlmglue.c b/fs/ocfs2/dlmglue.c
>>> index 60df52e4c1f8..349d131369cf 100644
>>> --- a/fs/ocfs2/dlmglue.c
>>> +++ b/fs/ocfs2/dlmglue.c
>>> @@ -3120,6 +3120,7 @@ static void *ocfs2_dlm_seq_next(struct seq_file *m, void *v, loff_t *pos)
>>> }
>>> spin_unlock(&ocfs2_dlm_tracking_lock);
>>>
>>> + m->index++;
>>
>> We can directly use '(*pos)++' instead.
>>
> 
> The input/output "pos” indicates more an offset into the file. Actually the output for an item is not really 1 byte in length, so incrementing the offset by 1 sounds a bit strange to me. Instead If we increment the “index”, It would be easier to understand it as  for next item. Though updating “index” or updating “*pos” instead makes no difference to binary running, the code understanding is different.  I know other seq_operations.next functions are directly incrementing the “*pos”, I think updating “index” is better. Well, if you persist (*pos)++, I will also let it go.
> 
From seq_read_iter(), the input pos is equivalent to '&m->index'. So the
above two ways seems have no functional difference.
IMO, we'd better hide the m->index logic into seqfile and just use pos
instead like other .next implementations.

Thanks,
Joseph


