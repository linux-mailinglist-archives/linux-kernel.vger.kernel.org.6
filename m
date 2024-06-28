Return-Path: <linux-kernel+bounces-233572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AFC391B9AF
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 10:22:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5827C282F96
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 08:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A407814659A;
	Fri, 28 Jun 2024 08:21:55 +0000 (UTC)
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B76148827
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 08:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719562915; cv=none; b=r7PepuQr8M7uyZp/JBM9db4fHA4Ug1myogbuq+9WS/7rGzmS2sYubOfAxTft4bvw+eX4+kDUtwfXi5Z2ARi5qqO0SlCkvyFs+pIT34qbr0OT8WwoHWMeS52fNrO5ZB+Q898Y7eSIQB+Vs2Oj2I767C2mn/whGw4paC/pB8i+Umk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719562915; c=relaxed/simple;
	bh=d8q7pCRYbNFyld1XcejuELeqSSRnuzqi5r6Ym3Gt9Fo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s44LDF3B49MacCTD0wQjaqhUsvLdtZWW5BFLGU4Trd99zpiEyijlADPaN82LvND9DNdXLGYM2k50g6xvV2bS1kyATUMJPZKIZFphHgL/UFYGl9EiETJ5YGjOeFvj+YVUsUscFmVJRPIqKOZtq6joaBeBxHUUwEd/BDtBsUB8PwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtp77t1719562896t2sg8m4v
X-QQ-Originating-IP: wW6Te52tLfIZhGbAIwW7ZTTx5j6Cem2c75vdERYyR2A=
Received: from [198.18.0.1] ( [223.112.234.130])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 28 Jun 2024 16:21:34 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16955004016337450842
Message-ID: <2CCFA0BD64E5F2E0+e4c7fc43-47b1-4788-a7d2-44f6a33cff66@shingroup.cn>
Date: Fri, 28 Jun 2024 16:21:34 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] powerpc/mmiotrace: Add MMIO Tracing tool for
 PowerPC
To: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin
 <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>,
 "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>
Cc: luming.yu@shingroup.cn, shenghui.qu@shingroup.cn,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Karol Herbst <karolherbst@gmail.com>,
 Pekka Paalanen <ppaalanen@gmail.com>, nouveau@lists.freedesktop.org
References: <2bf90acf7d29641ba6643934ff8dbba897dbd2d9.1718873074.git.jialong.yang@shingroup.cn>
 <87h6ddlfc7.fsf@mail.lhotse>
From: =?UTF-8?B?WWFuZyBKaWFsb25nIOadqOS9s+m+mQ==?= <jialong.yang@shingroup.cn>
In-Reply-To: <87h6ddlfc7.fsf@mail.lhotse>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:shingroup.cn:qybglogicsvrgz:qybglogicsvrgz8a-0


在 2024/6/28 15:02, Michael Ellerman 写道:
> Jialong Yang <jialong.yang@shingroup.cn> writes:
>> mmiotrace is a useful tool to trace MMIO accesses. Nowadays, it only
>> supported on x86 and x86_64 platforms.
> I've never used mmiotrace, and don't know it well.
>
> I'm not necessarily opposed to merging it, but AFAIK it was mostly used
> for reverse engineering proprietary drivers, where the driver itself
> couldn't be easily instrumented. Is that what you're using it for?

Yes. Just like you think. We have used it for network stack debug in 
ppc64le.


>
> For drivers where we have the source wouldn't it be easier to just use
> tracepoints in the MMIO accessors?


Tracepoints need pre-defined. And in some big driver, it's not easy to 
overwrite

all points where access registers in io area. And tracepoint is C 
function level filter.

mmiotrace is similar to set tracepoints in writel/readl... But it can do 
deeperly.

mmiotrace is a asm level filter tool. It doesn't care what have done in 
C level. It will

only find what have done by asm, such as stw(store word)/lw(load word),  
just like standing

in the view of device.


>
> Is it still in-use/maintained on the x86 side?


Here is some core file patches number in x86:

|      | mmio_mod.c | kmmio.c | pf_in.* | testmmiotrace.c |
|------+------------+---------+---------+-----------------|
| 2022 |               1 |            3 | |                  |
| 2021 |               2 |            1 |               |         |
| 2020 |               4 |            4 | |               1 |
| 2019 |               2 |            1 |            1 |               4 |
| 2018 |                  |            2 |               |          |
| 2017 |               2 |            2 | |               1 |
| 2016 |               1 |            2 |            1 |        |
| 2014 |                  |            1 |               |          |
| 2013 |               1 |               |               |          |
| 2012 |               1 |               | |                  |
| 2011 |               3 |               |            1 |         |
| 2010 |               1 |            3 |            2 |               1 |
| 2009 |               4 |          19 | |               3 |
| 2008 |             13 |            5 |            2 |               3 |

>
>> Here is a support for powerpc.
>> The manual is located at Documentation/trace/mmiotrace.rst which means
>> I have not changed user API. People will be easy to use it.
>> Almost all files are copied from x86/mm, there are only some
>> differences from hardware and architectures software.
>>
>> LINK: https://lore.kernel.org/lkml/20080127195536.50809974@daedalus.pq.iki.fi/
>>
>> Signed-off-by: Jialong Yang <jialong.yang@shingroup.cn>
>> ---
>>   arch/powerpc/Kconfig.debug       |   3 +
>>   arch/powerpc/mm/Makefile         |   1 +
>>   arch/powerpc/mm/kmmio.c          | 649 +++++++++++++++++++++++++++++++
>>   arch/powerpc/mm/mmio-mod.c       | 414 ++++++++++++++++++++
>>   arch/powerpc/mm/mmiotrace_arch.c | 149 +++++++
>>   arch/powerpc/mm/mmiotrace_arch.h |  25 ++
>>   arch/powerpc/mm/pf_in.c          | 185 +++++++++
>>   arch/powerpc/mm/pf_in.h          |  33 ++
>>   8 files changed, 1459 insertions(+)
>    
> At a glance most of that code could be shared between arches. I don't
> think I can merge that as-is, without some attempt to split the generic
> parts out.


Right.

I just copy them from arch/x86/mm. There are many code not arch specific.


> cheers
>


