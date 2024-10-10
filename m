Return-Path: <linux-kernel+bounces-359083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FC1A998738
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 15:10:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8562280FBC
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 13:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D03E1C9B8C;
	Thu, 10 Oct 2024 13:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="PZmbpH1q"
Received: from pv50p00im-hyfv10011601.me.com (pv50p00im-hyfv10011601.me.com [17.58.6.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 434BA1C7B6E
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 13:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728565837; cv=none; b=ZugPtm3w58ncTrW7nUPV1DplJVLt8z7wHkYQ6Dl+Fcywn5PbJvmtd+ny0tAEE73Vd67iY+vyQsBnwgmBxXFhNcbYLVk/MziW+ifDZUc/523vvxmWhBb/vscDnrm6slPToYwRN67fn2Jea2FzLWWFEopw5jKHMI7KGc0IGvd0cbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728565837; c=relaxed/simple;
	bh=finyVVlR0na0DP1HT1UABVmdrtvaVPYyz1c3SjgBD20=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CXPDQR/6DuouIxSmHdZEwiIFWQYDsF1XJQAeKGQ9O3SaBLwgIWNCYIdJOcUd/jTv6pUF4MyhPHHG1YEeMTEXozQIqsz9l/npjBpWVpmY1n+HdDXb10eoO5qSZTsmIQW1njJmvsIMTtmdNNdh0V9R+ZkUVtZ1r2/h5+xHqNhKxoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=PZmbpH1q; arc=none smtp.client-ip=17.58.6.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1728565835;
	bh=eO16NfOobASu3qtI1U5S9zNkv1CCKLM67lYMRvp/s38=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	b=PZmbpH1qlJw/LQxfuyfHmqJiTszxHJwfx19Hqr7Wu99w6DuT5mFVMxNltjwVdaiVy
	 MaDKO3P7Hz2q2oc8fGM7mhfbQbSajNpyjxDMvEYq2A5kOd7ZSZEiaA4SkVp+nq7ry2
	 6S33L59nKJ2zXgh8SkPVgYxyJ2BvY+5lCCt9mWUpZ8n+MOm1ZPXJQJ7vfmYIvr8jzv
	 skXdnuTN0jM0sKJ/nI/+nNxDObOfBVjfWXRvF11xQyCUshCvsbvx/1M6cyLuTFZ/mw
	 xq3dsJlrz3c7IpMX56jHULgNV7i6SOY0MxdlnQP4e3yoN614ie637kdHs9llxuqIOZ
	 jPqkMBxMpPUiQ==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-hyfv10011601.me.com (Postfix) with ESMTPSA id 699FDC801FC;
	Thu, 10 Oct 2024 13:10:10 +0000 (UTC)
Message-ID: <1c06375c-ade9-4419-b418-deaed07f5ba7@icloud.com>
Date: Thu, 10 Oct 2024 21:10:06 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 0/3] amba: bus: Move reading periphid operation from
 amba_match() to amba_probe()
To: Saravana Kannan <saravanak@google.com>
Cc: Russell King <linux@armlinux.org.uk>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Isaac Manjarres <isaacmanjarres@google.com>,
 Lu Baolu <baolu.lu@linux.intel.com>, linux-kernel@vger.kernel.org,
 Zijun Hu <quic_zijuhu@quicinc.com>
References: <20240909-fix_amba-v1-0-4658eed26906@quicinc.com>
 <CAGETcx9X0m3=8PPtVsHp=AAjyCoUZ0-53H5RzVd4HCDtWRS0Fw@mail.gmail.com>
 <a4cf15fb-bbaa-4ed0-a1d5-c362b7a5c6e2@icloud.com>
 <CAGETcx_YMUXRLye3OUOQ9O4Cw9nqLcVOts0hTMgORuLmQ7tAZw@mail.gmail.com>
 <343ef9ea-12ab-4ca6-bd9a-fc01bbf9962b@icloud.com>
 <CAGETcx-NzgsUeStjNncP=AYiH9ACEbpMvS1J4doYFd39qZ2zig@mail.gmail.com>
Content-Language: en-US
From: Zijun Hu <zijun_hu@icloud.com>
In-Reply-To: <CAGETcx-NzgsUeStjNncP=AYiH9ACEbpMvS1J4doYFd39qZ2zig@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: e4vxBLpnHjHP104_0G-KbI4u8GLmF36n
X-Proofpoint-GUID: e4vxBLpnHjHP104_0G-KbI4u8GLmF36n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-10_11,2024-10-10_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 phishscore=0 spamscore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2410100088

On 2024/10/3 09:49, Saravana Kannan wrote:
> On Wed, Sep 11, 2024 at 5:51 AM Zijun Hu <zijun_hu@icloud.com> wrote:
>>
>> On 2024/9/11 00:27, Saravana Kannan wrote:
>>> On Tue, Sep 10, 2024 at 5:17 AM Zijun Hu <zijun_hu@icloud.com> wrote:
>>>>
>>>> On 2024/9/9 15:24, Saravana Kannan wrote:
>>>>> On Sun, Sep 8, 2024 at 4:38 PM Zijun Hu <zijun_hu@icloud.com> wrote:
>>>>>>
>>>>>> This patch series is to make amba_match(), as bus_type @amba_bustype's
>>>>>> match(), also follow below ideal rule:
>>>>>>
>>>>> Also, patch 3/3 is not at all easy to understand and seems to be doing
>>>>> way more than what the commit message is trying to do.
>>>>>
>>>>
>>>> thanks for your code review.
>>>>
>>>> let me explain the issue here firstly to go on with discussion, will
>>>> correct it by next revision.
>>>>
>>>> amba_match(), as bus_type @amba_bustype's match(), operate hardware to
>>>> read id, may return -EPROBE_DEFER consequently.
>>>>
>>>> this design is not very good and has several disadvantages shown below:
>>>>
>>>> 1) it is not good time to operate hardware in a bus_type's match().
>>>>    hardware is not ready to operate normally in a bus_type's match()
>>>>    as driver_probe_device() shown, there are still many preparations
>>>>    to make hardware to operate after a bus_type's match(), for example,
>>>>    resuming device and its ancestors, ensuring all its suppliers have
>>>>    drivers bound, activating its power domain, ...
>>>>
>> .....
>>
>>>> 5) amba_match() is the only bus_type's match which breaks below ideal
>>>> rule in current kernel tree:
>>>>    bus_type's match() should only return bool type compatible integer 0
>>>> or 1 ideally since its main operations are lookup and comparison normally.
>>>
>>> All of this used to happen even if the bus match wasn't doing what
>>> it's doing today. You don't seem to have full context on how amba
>>> devices are added and probed. What you see now is a clean
>>> up/simplification of how things used to work.
>>>
>>> Please go read this patch history and git log history for these files
>>> to get more context.
>>>
>>> Nack for the entire series. It'll never go in.
>>>
>>
>> sorry, not agree with you.
>>
>> IMO, it is easy to make amba_match() return bool type as shown below:
>>
>> make amba_match() always match with AMBA device with INvalid periphid
>> and move reading id operation into amba_dma_configure().
>>
>> Above solution can have the same logical as current one but it looks ugly.
>>
>> so i make below optimizations to get this patch series:
>>
>> 1) only make AMBA device with INvalid periphid match with existing empty
>>    amba_proxy_drv to reduce unnecessary reading id operation.
> 
> No it doesn't. Once match() returns -EPROBE_DEFER we don't try
> matching with other drivers. So it doesn't cause more reads.
> 

sorry to give reply late due to travel.

above points is not applicable for driver attaching as explained below.

devn_n : AMBA device n with periphid n
drvn   : AMBA device devn_n's driver.

AMBA bus
├── dev0_0  // dev0 with Invalid periphid 0
├── @amba_proxy_drv // the empty AMBA driver

now let us register 2 AMBA drivers drv1 and drv2.

-EPROBE_DEFER returned during trying to match dev0_0 with drv1
can NOT stopping reading periphid when trying to match dev0_0 with
drv2 since the error code is ignored for driver attaching.

MY solution is shown below:
1) only make device with Invalid ID 0 match with @amba_proxy_drv
   this will reduce unnecessary reading ID operations.
2) Move reading ID from bus's match() to bus's probe()

>> 2) moving reading id operation to amba_probe() looks more graceful.
> 
> To do a driver/device match, you need to periphid. It doesn't make
> sense to push that into some stub probe function instead of doing it
> where it's needed. In the match function.
> 

1) it is not good location for a bus's match() to operate hardware to
read ID as explained by below link:

https://lore.kernel.org/all/a4cf15fb-bbaa-4ed0-a1d5-c362b7a5c6e2@icloud.com/

2) ideally, amba_proxy_drv's probe() is better than the AMBA bus's
probe() to read ID, i use the later since it is simpler and my limited
AMBA knowledge.

@amba_proxy_drv was introduced to ensure triggering reading ID operation
, perhaps, make it take charge for reading ID and have similar role as
the generic USB driver.

>> Look at below 3 consecutive history commits:
>>
>> git log --pretty='%h (\"%s\")' 656b8035b0ee -3
>> Commit: 656b8035b0ee ("ARM: 8524/1: driver cohandle -EPROBE_DEFER from
>> bus_type.match()")
>> Commit: 17f29d36e473 ("ARM: 8523/1: sa1111: ensure no negative value
>> gets returned on positive match")
>> Commit: 82ec2ba2b181 ("ARM: 8522/1: drivers: nvdimm: ensure no negative
>> value gets returned on positive match")
> 
> Those are commits from 2016! Way before any of the cleanup was done.
> 
>> the first AMBA related commit breaks that a bus_type's match() have bool
>> type return value.
> 
> Have you actually looked at the definition of match and it's doc? It's
> return type is int and not bool. And the doc says it should return
> -EPROBE_DEFER.
>

yes, but ALL other bus's match()s only return 0 and 1, AMBA is the only
one which returns extra -EPROBE_DEFER.

-EPROBE_DEFER is a probe related error code and should not be returned
by a bus's match()
it was below AMBA change which make a bus's match() return -EPROBE_DEFER.

Commit: 656b8035b0ee ("ARM: 8524/1: driver cohandle -EPROBE_DEFER from
bus_type.match()")

>> the remaining two commits at the same time really do not like negative
>> return value for a bus_type's match().
> 
> This whole series is fixing a non-issue because you have a subjective
> opinion that the reading of periphid should happen outside of the
> match() function where it's actually needed.
> 

this patch serials is to improve design and not to fix bugs.

> And you even have a comment saying it's adding a race.

as explained by 3) of below link, we don't need extra periphid_lock
any more if moving reading ID operations into probe(). and relevant
a bit race is acceptable.

https://lore.kernel.org/all/a4cf15fb-bbaa-4ed0-a1d5-c362b7a5c6e2@icloud.com/

> 
> Russell,
> 
> Definite huge NACK from me. Please don't merge this series. I don't
> see it fixing anything and it's moving around code for
> pointless/questionable reasons. If it is fixing any real bug, I've yet
> to hear it explained properly.
> 
> If I don't reply further, it means my NACK stands. If the replies
> somehow convince me to remove my NACK, I'll do so.
> 
> -Saravana


