Return-Path: <linux-kernel+bounces-186040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B3AA8CBF14
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 12:13:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0D821F22F14
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 10:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3123E81AC7;
	Wed, 22 May 2024 10:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marcinwanat.pl header.i=@marcinwanat.pl header.b="V2AzULBm";
	dkim=pass (2048-bit key) header.d=marcinwanat.pl header.i=@marcinwanat.pl header.b="I6xvTTPg"
Received: from mx.bitactive.com (mx.bitactive.com [178.32.63.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970D11CD13
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 10:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.32.63.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716372810; cv=none; b=eODo/E+6yVg7WgnMMVVqcGC9ZhKJodM/HginVjBZsCGvBpHUbprj9J+Rd9jeMz2xMgWwyS/2DfKxUREz8eVjVlBj2QWOgoZv3AYijkO4Hbirj8qEZOXVrQXC/3sxEjiqkXWsn6GunY9dWzNeP9VRopaDQ0MgwasKBROX2VFAr2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716372810; c=relaxed/simple;
	bh=f6uxh30zMm2VrV2fxQMmLGBXNp4mKz7OmD1+JtVasf0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type; b=uxdCWpTAzZlryaQtCvLtideVB29p1UN/YSlgQIkuMI+tbk3mTwXAEAcauq/5MqYzpITuhS2UosindNSr/Q4meYW9Rxcflx/nEInkx0yVUJiv7UR+dbUlOQOJAtsdtO0h6AXRuA8tTwaW9ioBwGyZlZg6ebVv2L7ESz1APuRpBQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marcinwanat.pl; spf=pass smtp.mailfrom=marcinwanat.pl; dkim=pass (2048-bit key) header.d=marcinwanat.pl header.i=@marcinwanat.pl header.b=V2AzULBm; dkim=pass (2048-bit key) header.d=marcinwanat.pl header.i=@marcinwanat.pl header.b=I6xvTTPg; arc=none smtp.client-ip=178.32.63.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marcinwanat.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marcinwanat.pl
Received: by mx.bitactive.com (Postfix, from userid 1044)
	id 4VknFD5NZrz7mgc; Wed, 22 May 2024 12:13:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marcinwanat.pl;
	s=s2048; t=1716372800;
	bh=vwogVyT1ERaJqCbtt35UMJYwBhprISHU+UzKOErpRZI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=V2AzULBmkBbI9nSndOmNy+octXyzb/U9BiEy/QL5uOZRBgH0zIUZjxkSLns+Fy+Uz
	 8iRZWrX6tsTnrQQ5JQFmA09zFnRfh2ZfFyKbFtl30jn5+knOnOneRAyCau94izHf9Y
	 Wr4EPCDrg2CLskc89HsiOZqEMu/DaG8QLn9NpkVY1+IRuulI+8HrXZblZN6DzVqh0J
	 q5AJTgBRCDGQqPHTxo2bx6SweuoS3VmnYssR1D/yDkDMbhfosyt+JGJk+6SXbOkg6q
	 eOlPgmM8uCTkKxqnoXRJjQpaV6WIzgYiHywUvXXdxB1wCuxYHze/xQL92I+HU9eJLh
	 cGQ1uOOM6404g==
X-Spam-Level: 
X-Spam-Virus: No
Message-ID: <b4883f83-9f5d-46b2-b30e-f2e78506bf30@marcinwanat.pl>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marcinwanat.pl;
	s=s2048; t=1716372794;
	bh=vwogVyT1ERaJqCbtt35UMJYwBhprISHU+UzKOErpRZI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=I6xvTTPgd8AbX5YRJV4/QLxDN2cp6/xs9z/YtVk3Dfl+0zUUWh61BNanaJ01aAKqJ
	 YEVB27YWFa1YLIfKpMAuvauphmQUHWoQd5L/ftsOxlF7NPU46SwGUjVM1vK+O5vdY5
	 qwhRmLwq1W6CL5dxcpT+TdV/Y5VDX3+AWfLEpSLmSDAi7Zc3UpckjDHdCvdqFO+nnB
	 iZmoVozdyzkZGrMF9QMK6geNKj+pBZMqTrcVGkn1kCAkYHQCUipui6IJKNWnBzqtwb
	 fRzPRGDYSUoRNBicZ/+d5y5TnbizkWChYSIH7xJax9bf3AVyNMZOfEYRRSjERfB7L2
	 Ntqptwirdv4qw==
Date: Wed, 22 May 2024 12:13:12 +0200
Subject: Re: [PATCH 1/1] mm: protect xa split stuff under lruvec->lru_lock
 during migration
To: Zhaoyang Huang <huangzhaoyang@gmail.com>
Cc: Dave Chinner <david@fromorbit.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "zhaoyang.huang" <zhaoyang.huang@unisoc.com>, Alex Shi <alexs@kernel.org>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
 Hugh Dickins <hughd@google.com>, Baolin Wang
 <baolin.wang@linux.alibaba.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, steve.kang@unisoc.com
References: <20240412064353.133497-1-zhaoyang.huang@unisoc.com>
 <20240412143457.5c6c0ae8f6df0f647d7cf0be@linux-foundation.org>
 <CAGWkznHRyZDuumF=70DncgPHFM0+pgxuONh98Bykz5b-=rCjCQ@mail.gmail.com>
 <ZhxwIh2M8jr6IZaF@dread.disaster.area>
 <CAGWkznHDpw5Sw5pAfB=TdgRqsf=bmwUQ6+kvvLht3=wumNNo6Q@mail.gmail.com>
 <d9f7c779-acc0-4b8b-993e-e56e9475438e@marcinwanat.pl>
 <CAGWkznESMXeOhWnK93q1JJxhP0r4wR16cRJxiVzKZmM47GiEWw@mail.gmail.com>
 <CAGWkznEG78ppUXyoM2HKoo9MCOBJQaW=vSdSKDYXJj6kWH6zjA@mail.gmail.com>
 <2652f0c1-acc9-4288-8bca-c95ee49aa562@marcinwanat.pl>
 <CAGWkznE0psiqZYSRjF+Joq73--Yo-xUhGD0gnBa42fYC55BFdA@mail.gmail.com>
Content-Language: en-US
From: Marcin Wanat <private@marcinwanat.pl>
In-Reply-To: <CAGWkznE0psiqZYSRjF+Joq73--Yo-xUhGD0gnBa42fYC55BFdA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.6 at mx.bitactive.com
X-Virus-Status: Clean
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

On 22.05.2024 07:37, Zhaoyang Huang wrote:
> On Tue, May 21, 2024 at 11:47 PM Marcin Wanat <private@marcinwanat.pl> wrote:
>>
>> On 21.05.2024 03:00, Zhaoyang Huang wrote:
>>> On Tue, May 21, 2024 at 8:58 AM Zhaoyang Huang <huangzhaoyang@gmail.com> wrote:
>>>>
>>>> On Tue, May 21, 2024 at 3:42 AM Marcin Wanat <private@marcinwanat.pl> wrote:
>>>>>
>>>>> On 15.04.2024 03:50, Zhaoyang Huang wrote:
>>>>> I have around 50 hosts handling high I/O (each with 20Gbps+ uplinks
>>>>> and multiple NVMe drives), running RockyLinux 8/9. The stock RHEL
>>>>> kernel 8/9 is NOT affected, and the long-term kernel 5.15.X is NOT affected.
>>>>> However, with long-term kernels 6.1.XX and 6.6.XX,
>>>>> (tested at least 10 different versions), this lockup always appears
>>>>> after 2-30 days, similar to the report in the original thread.
>>>>> The more load (for example, copying a lot of local files while
>>>>> serving 20Gbps traffic), the higher the chance that the bug will appear.
>>>>>
>>>>> I haven't been able to reproduce this during synthetic tests,
>>>>> but it always occurs in production on 6.1.X and 6.6.X within 2-30 days.
>>>>> If anyone can provide a patch, I can test it on multiple machines
>>>>> over the next few days.
>>>> Could you please try this one which could be applied on 6.6 directly. Thank you!
>>> URL: https://lore.kernel.org/linux-mm/20240412064353.133497-1-zhaoyang.huang@unisoc.com/
>>>
>>
>> Unfortunately, I am unable to cleanly apply this patch against the
>> latest 6.6.31
> Please try below one which works on my v6.6 based android. Thank you
> for your test in advance :D
> 
> mm/huge_memory.c | 22 ++++++++++++++--------
>   1 file changed, 14 insertions(+), 8 deletions(-)
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c

I have compiled 6.6.31 with this patch and will test it on multiple 
machines over the next 30 days. I will provide an update after 30 days 
if everything is fine or sooner if any of the hosts experience the same 
soft lockup again.

