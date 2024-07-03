Return-Path: <linux-kernel+bounces-239009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9BF29254D2
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 09:41:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1C061C20B4B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 07:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16A4A137777;
	Wed,  3 Jul 2024 07:41:06 +0000 (UTC)
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA7913774D
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 07:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719992465; cv=none; b=giS4FyJ/RtUsbw/Sm3GejhUufJN07+OiP84wjV56AAE0+54ygKIJasBvPcDhPr3p/SS4jY3Ye1KuQix/k+FwVyQlAIlsuRYhdQeGI2PCG5D+FqRRTf9ShFc4NzBGyUbESzmopNT5Leac6uYgqzgi3o2kDX3HlbvulUwpRkgEveg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719992465; c=relaxed/simple;
	bh=zE86B+fayGin3ySzfTjzUp0JKbeB9dMRuf/mE7qwMSM=;
	h=Message-ID:Date:MIME-Version:Subject:References:To:From:Cc:
	 In-Reply-To:Content-Type; b=qnn3bOVcW8Zu6BDQJGcVhjImST7Eb4ti+DA4m97RW/Ix7y5HbkwLv3zUpbsNKkEDocmw4gjyiBeFmfDQvuhNITRcp6gxqUE8rDi2oO+y2uOn9Ig9aDWvzvHBxoCggJv384BT+03FUIuLyOX0ZBbHP4OeJdvwfgCUcNqiXlZ4fxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtpsz2t1719992351trnd3yb
X-QQ-Originating-IP: OlCy8zcIWB+TDQh2H+CxgxP5J6G2tPFQxMeJsEbO1iI=
Received: from [198.18.0.1] ( [223.112.234.130])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 03 Jul 2024 15:39:09 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3271192141224954492
Message-ID: <5F5B4CCA07D939BE+1a8b7985-b0c6-4b03-8c31-d1281f7b56e4@shingroup.cn>
Date: Wed, 3 Jul 2024 15:39:09 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Fwd: [PATCH v1 1/2] powerpc/mmiotrace: Add MMIO Tracing tool for
 PowerPC
References: <2CCFA0BD64E5F2E0+e4c7fc43-47b1-4788-a7d2-44f6a33cff66@shingroup.cn>
To: rostedt@goodmis.org, mhiramat@kernel.org,
 Karol Herbst <karolherbst@gmail.com>, Pekka Paalanen <ppaalanen@gmail.com>,
 mathieu.desnoyers@efficios.com
From: =?UTF-8?B?WWFuZyBKaWFsb25nIOadqOS9s+m+mQ==?= <jialong.yang@shingroup.cn>
Cc: Michael Ellerman <mpe@ellerman.id.au>, linux-kernel@vger.kernel.org
In-Reply-To: <2CCFA0BD64E5F2E0+e4c7fc43-47b1-4788-a7d2-44f6a33cff66@shingroup.cn>
X-Forwarded-Message-Id: <2CCFA0BD64E5F2E0+e4c7fc43-47b1-4788-a7d2-44f6a33cff66@shingroup.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:shingroup.cn:qybglogicsvrgz:qybglogicsvrgz8a-0

Hello, mmiotrace maintainers.

Here is a first version patch used to support mmiotrace function on 
powerpc platform. When I copy mmiotrace to powerpc archtecture, we found 
that there are many code are general, such as code in kmmio.c and 
mmio-mod.c in arch/x86/mm/.  But we have file trace_mmiotrace.c as a low 
layer to finish the function. Whether we can abstract out one layer 
again or not?






-------- 转发的消息 --------
主题: 	Re: [PATCH v1 1/2] powerpc/mmiotrace: Add MMIO Tracing tool for 
PowerPC
日期: 	Fri, 28 Jun 2024 16:21:34 +0800
From: 	Yang Jialong 杨佳龙 <jialong.yang@shingroup.cn>
收件人: 	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin 
<npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
Naveen N. Rao <naveen.n.rao@linux.ibm.com>
抄送: 	luming.yu@shingroup.cn, shenghui.qu@shingroup.cn, 
linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, Steven 
Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
Karol Herbst <karolherbst@gmail.com>, Pekka Paalanen 
<ppaalanen@gmail.com>, nouveau@lists.freedesktop.org




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
| 2021 |               2 |            1 |               | |
| 2020 |               4 |            4 | |               1 |
| 2019 |               2 |            1 |            1 |               4 |
| 2018 |                  |            2 |               |        |
| 2017 |               2 |            2 | |               1 |
| 2016 |               1 |            2 |            1 |        |
| 2014 |                  |            1 |               |        |
| 2013 |               1 |               |               |        |
| 2012 |               1 |               | |                  |
| 2011 |               3 |               |            1 | |
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
>> LINK: 
>> https://lore.kernel.org/lkml/20080127195536.50809974@daedalus.pq.iki.fi/
>>
>> Signed-off-by: Jialong Yang <jialong.yang@shingroup.cn>
>> ---
>> arch/powerpc/Kconfig.debug | 3 +
>> arch/powerpc/mm/Makefile | 1 +
>> arch/powerpc/mm/kmmio.c | 649 +++++++++++++++++++++++++++++++
>> arch/powerpc/mm/mmio-mod.c | 414 ++++++++++++++++++++
>> arch/powerpc/mm/mmiotrace_arch.c | 149 +++++++
>> arch/powerpc/mm/mmiotrace_arch.h | 25 ++
>> arch/powerpc/mm/pf_in.c | 185 +++++++++
>> arch/powerpc/mm/pf_in.h | 33 ++
>> 8 files changed, 1459 insertions(+)
> At a glance most of that code could be shared between arches. I don't
> think I can merge that as-is, without some attempt to split the generic
> parts out.


Right.

I just copy them from arch/x86/mm. There are many code not arch specific.


> cheers
>


