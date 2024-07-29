Return-Path: <linux-kernel+bounces-265642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 947EE93F3F2
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 13:25:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B67841C203E1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 11:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A98CA146A9B;
	Mon, 29 Jul 2024 11:21:42 +0000 (UTC)
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [52.237.72.81])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D37C156669;
	Mon, 29 Jul 2024 11:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.237.72.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722252101; cv=none; b=iaxNoCVIllSccGSBxacqhj8hLTNlynl04J9M47Zd2Z5TY/Owh/EZMc7uRx4bhC5wdzH2FYwr6NAqlxZP+wytaRSmtOcVMgwbPlFy5XZh0B/+soDu28Vms0xaspGoc63GvjTTlRjoamX0JkVYSvtwZK613Cz+KpvZMXSb5Av7HJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722252101; c=relaxed/simple;
	bh=FuggeuUKV38oAt716lEXzIwzTLlC8PtuUib1FGrVKR8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=n+BFg2OFTYyFi1yOGEAhlgVMhO/P5+gLXDZ0ITkQJosZicDJZ7++CTOiQ2ivtdjReWwRT7nSL2i3VJDTtVD0ipNIupuI2pIrerghnyGpSt9LFCPHt1BEsB4wNlBI5qiA2SjCjI8Ih6u7zk34t7PifuoEobby1+GK4XFTiBb55cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn; spf=pass smtp.mailfrom=hust.edu.cn; arc=none smtp.client-ip=52.237.72.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hust.edu.cn
Received: from hust.edu.cn (unknown [172.16.0.52])
	by app1 (Coremail) with SMTP id HgEQrADHKG79eqdm3n05Ag--.60348S2;
	Mon, 29 Jul 2024 19:20:29 +0800 (CST)
Received: from [198.18.0.1] (unknown [10.12.177.116])
	by gateway (Coremail) with SMTP id _____wBXUNf2eqdmLBkgAA--.26897S2;
	Mon, 29 Jul 2024 19:20:23 +0800 (CST)
Message-ID: <76c1d5ba-93c8-4f39-b0c7-48f1f815b33b@hust.edu.cn>
Date: Mon, 29 Jul 2024 19:20:22 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs/zh_CN: Add dev-tools/kcsan Chinese translation
To: si.yanteng@linux.dev
References: <20240720090828.363331-1-tttturtleruss@hust.edu.cn>
 <3d19ed86f0d18fa77c6ce1ce3d4f16bb68da8938@linux.dev>
 <bd06d5b4-96f0-4681-ac60-01455a55966e@Canary>
 <7cfcb8a27ba5e348d8e1de7b606b1123b1a06b4a@linux.dev>
Cc: hust-os-kernel-patches@googlegroups.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev
From: Haoyang Liu <tttturtleruss@hust.edu.cn>
In-Reply-To: <7cfcb8a27ba5e348d8e1de7b606b1123b1a06b4a@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:HgEQrADHKG79eqdm3n05Ag--.60348S2
Authentication-Results: app1; spf=neutral smtp.mail=tttturtleruss@hust
	.edu.cn;
X-Coremail-Antispam: 1UD129KBjvAXoWfXF4ruF4DJFyrGr1UuFykXwb_yoW5WrWkZo
	WUtr13Cr18Jr15Jr1UJw4DJr1jyw1UGr1UJryUGr1UJr1Utw1UAr1UJr1UJr4UGr45JF1U
	JryUJr1UAF1UXr15n29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUYi7k0a2IF6w4kM7kC6x804xWl1xkIjI8I6I8E6xAIw20EY4v2
	0xvaj40_Wr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7
	IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK
	6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1ln4kS14v26r
	1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I8C
	rVACY4xI64kE6c02F40Ex7xfMcIj64x0Y40En7xvr7AKxVW8Jr0_Cr1UMcIj6x8ErcxFaV
	Av8VW8uFyUJr1UMcIj6xkF7I0En7xvr7AKxVW8Jr0_Cr1UMcvjeVCFs4IE7xkEbVWUJVW8
	JwACjcxG0xvEwIxGrwCF04k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv6cx26r4fZr1UJr
	1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67AK
	xVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrx
	kI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v2
	6r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8Jw
	CI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07bxrWwUUUUU
	=
X-CM-SenderInfo: rxsqjiqrssiko6kx23oohg3hdfq/1tbiAQoNAmanDbAP0gAEsh


在 2024/7/29 16:36, si.yanteng@linux.dev 写道:
> 2024年7月24日 11:02, "TurtleRuss" <tttturtleruss@hust.edu.cn> 写到:
>
>
>
>> Hi Yanteng:
>>
>> Thank you for your review. I will add a commit tag in patch v2. BTW, i did run the checkpatch.pl, maybe I sent a wrong patch.
>>
>> I will send a v2 patch later.
>> Thank you.
>>
> 请避免使用top reply，这在邮件列表是不礼貌的行为；然后这封邮件你没有抄送邮件列表，因为maintainer一般都设置了邮件过滤规则，所以你这封邮件我今天才看到，以后请避免这么做；最后，上游的每条评论都需要得到明确的回复，直接在对应的评论后面回车断行，编辑回复的内容即可，谢谢。
>
>
> 延腾

好的，我对于内核社区邮件礼仪不太了解，感谢你的指导。下次我会注意这些的事项的。


浩阳

>> Haoyang
>>
>>   
>>   
>>   
>>   
>> --
>>
>> Sent from Canary https://canarymail.io/
>>   
>>
>>   
>>   
>>   
>>   
>>   
>>> On Wednesday, Jul 24, 2024 at 9:50 AM, <si.yanteng@linux.dev> wrote:
>>>   
>>> 2024年7月20日 17:08, "Haoyang Liu" <tttturtleruss@hust.edu.cn> 写到:
>>>
>>>   
>>>
>>> Hi Haoyang
>>>
>>>   
>>>
>>>> Translate dev-tools/kcsan into Chinese.
>>>> Let's add a commit tag, then the checktransupdate.py can recognize it.
>>>   
>>>
>>>   
>>>
>>>> Signed-off-by: Haoyang Liu <tttturtleruss@hust.edu.cn>
>>>> Remove the blankline, and have you ever run checkpatch.pl?
>>>   
>>>
>>>> ---
>>>>
>>>>   
>>>>
>>>> .../translations/zh_CN/dev-tools/index.rst | 2 +-
>>>>
>>>>   
>>>>
>>>> .../translations/zh_CN/dev-tools/kcsan.rst | 321 ++++++++++++++++++
>>>>
>>>>   
>>>>
>>>> 2 files changed, 322 insertions(+), 1 deletion(-)
>>>>
>>>>   
>>>>
>>>> create mode 100644 Documentation/translations/zh_CN/dev-tools/kcsan.rst
>>>>
>>>>   
>>>>
>>>> diff --git a/Documentation/translations/zh_CN/dev-tools/index.rst b/Documentation/translations/zh_CN/dev-tools/index.rst
>>>>
>>>>   
>>>>
>>>> index c540e4a7d5db..4cc94d288157 100644
>>>>
>>>>   
>>>>
>>>> --- a/Documentation/translations/zh_CN/dev-tools/index.rst
>>>>
>>>>   
>>>>
>>>> +++ b/Documentation/translations/zh_CN/dev-tools/index.rst
>>>>
>>>>   
>>>>
>>>> @@ -23,6 +23,7 @@ Documentation/translations/zh_CN/dev-tools/testing-overview.rst
>>>>
>>>>   
>>>>
>>>> kcov
>>>>
>>>>   
>>>>
>>>> gcov
>>>>
>>>>   
>>>>
>>>> kasan
>>>>
>>>>   
>>>>
>>>> + kcsan
>>>>
>>>>   
>>>>
>>>> ubsan
>>>>
>>>>   
>>>>
>>>> kmemleak
>>>>
>>>>   
>>>>
>>>> gdb-kernel-debugging
>>>>
>>>>   
>>>>
>>>> @@ -32,7 +33,6 @@ Todolist:
>>>>
>>>>   
>>>>
>>>> - checkpatch
>>>>
>>>>   
>>>>
>>>> - coccinelle
>>>>
>>>>   
>>>>
>>>> - kmsan
>>>>
>>>>   
>>>>
>>>> - - kcsan
>>>>
>>>>   
>>>>
>>>> - kfence
>>>>
>>>>   
>>>>
>>>> - kgdb
>>>>
>>>>   
>>>>
>>>> - kselftest
>>>>
>>>>   
>>>>
>>>> diff --git a/Documentation/translations/zh_CN/dev-tools/kcsan.rst b/Documentation/translations/zh_CN/dev-tools/kcsan.rst
>>>>
>>>>   
>>>>
>>>> new file mode 100644
>>>>
>>>>   
>>>>
>>>> index 000000000000..1971f87eeb18
>>>>
>>>>   
>>>>
>>>> --- /dev/null
>>>>
>>>>   
>>>>
>>>> +++ b/Documentation/translations/zh_CN/dev-tools/kcsan.rst
>>>>
>>>>   
>>>>
>>>> @@ -0,0 +1,321 @@
>>>>
>>>>   
>>>>
>>>> +.. SPDX-License-Identifier: GPL-2.0
>>>>
>>>>   
>>>>
>>>> +
>>>>
>>>>   
>>>>
>>>> +.. include:: ../disclaimer-zh_CN.rst
>>>>
>>>>   
>>>>
>>>> +
>>>>
>>>>   
>>>>
>>>> +:Original: Documentation/dev-tools/kcsan.rst
>>>>
>>>>   
>>>>
>>>> +:Translator: 刘浩阳 Haoyang Liu <tttturtleruss@hust.edu.cn>
>>>>
>>>>   
>>>>
>>>> +
>>>>
>>>>   
>>>>
>>>> +内核并发消毒剂 （KCSAN）
>>>>
>>>>   
>>>>
>>>> +===========================
>>>> Please trim the “=” length. Include similar below.
>>>> +
>>>>
>>>>   
>>>>
>>>> +内核并发消毒剂（KCSAN）是一个动态竞争检测器，依赖编译时插桩，并且使用基于观察
>>>>
>>>>   
>>>>
>>>> +点的采样方法来检测竞争。KCSAN 的主要目的是检测 `数据竞争`_。
>>>>
>>>>   
>>>>
>>>> +
>>>>
>>>>   
>>>>
>>>> +使用
>>>>
>>>>   
>>>>
>>>> +----
>>>>
>>>>   
>>>>
>>>> +
>>>>
>>>>   
>>>>
>>>> +KCSAN 受 GCC 和 Clang 支持。使用 GCC 需要版本 11 或更高，使用 Clang 也需要
>>>>
>>>>   
>>>>
>>>> +版本 11 或更高。
>>>>
>>>>   
>>>>
>>>> +
>>>>
>>>>   
>>>>
>>>> +为了启用 KCSAN，用如下参数配置内核::
>>>>
>>>>   
>>>>
>>>> +
>>>>
>>>>   
>>>>
>>>> + CONFIG_KCSAN = y
>>>>
>>>>   
>>>>
>>>> +
>>>>
>>>>   
>>>>
>>>> +KCSAN 提供了几个其他的配置选项来自定义行为（见 ``lib/Kconfig.kcsan`` 中的各自的
>>>>
>>>>   
>>>>
>>>> +帮助文档以获取更多信息）。
>>>>
>>>>   
>>>>
>>>> +
>>>>
>>>>   
>>>>
>>>> +错误报告
>>>>
>>>>   
>>>>
>>>> +~~~~~~~~~~
>>>>
>>>>   
>>>>
>>>> +
>>>>
>>>>   
>>>>
>>>> +一个典型数据竞争的报告如下所示::
>>>>
>>>>   
>>>>
>>>> +
>>>>
>>>>   
>>>>
>>>> + ==================================================================
>>>>
>>>>   
>>>>
>>>> + BUG: KCSAN: data-race in test_kernel_read / test_kernel_write
>>>>
>>>>   
>>>>
>>>> +
>>>>
>>>>   
>>>>
>>>> + write to 0xffffffffc009a628 of 8 bytes by task 487 on cpu 0:
>>>>
>>>>   
>>>>
>>>> + test_kernel_write+0x1d/0x30
>>>>
>>>>   
>>>>
>>>> + access_thread+0x89/0xd0
>>>>
>>>>   
>>>>
>>>> + kthread+0x23e/0x260
>>>>
>>>>   
>>>>
>>>> + ret_from_fork+0x22/0x30
>>>>
>>>>   
>>>>
>>>> +
>>>>
>>>>   
>>>>
>>>> + read to 0xffffffffc009a628 of 8 bytes by task 488 on cpu 6:
>>>>
>>>>   
>>>>
>>>> + test_kernel_read+0x10/0x20
>>>>
>>>>   
>>>>
>>>> + access_thread+0x89/0xd0
>>>>
>>>>   
>>>>
>>>> + kthread+0x23e/0x260
>>>>
>>>>   
>>>>
>>>> + ret_from_fork+0x22/0x30
>>>>
>>>>   
>>>>
>>>> +
>>>>
>>>>   
>>>>
>>>> + value changed: 0x00000000000009a6 -> 0x00000000000009b2
>>>>
>>>>   
>>>>
>>>> +
>>>>
>>>>   
>>>>
>>>> + Reported by Kernel Concurrency Sanitizer on:
>>>>
>>>>   
>>>>
>>>> + CPU: 6 PID: 488 Comm: access_thread Not tainted 5.12.0-rc2+ #1
>>>>
>>>>   
>>>>
>>>> + Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-2 04/01/2014
>>>>
>>>>   
>>>>
>>>> + ==================================================================
>>>>
>>>>   
>>>>
>>>> +
>>>>
>>>>   
>>>>
>>>> +报告的头部提供了一个关于竞争中涉及到的函数的简短总结。随后是竞争中的两个线程的
>>>>
>>>>   
>>>>
>>>> +访问类型和堆栈信息。如果 KCSAN 发现了一个值的变化，那么那个值的旧值和新值会在
>>>>
>>>>   
>>>>
>>>> +“value changed”这一行单独显示。
>>>>
>>>>   
>>>>
>>>> +
>>>>
>>>>   
>>>>
>>>> +另一个不太常见的数据竞争类型的报告如下所示::
>>>>
>>>>   
>>>>
>>>> +
>>>>
>>>>   
>>>>
>>>> + ==================================================================
>>>>
>>>>   
>>>>
>>>> + BUG: KCSAN: data-race in test_kernel_rmw_array+0x71/0xd0
>>>>
>>>>   
>>>>
>>>> +
>>>>
>>>>   
>>>>
>>>> + race at unknown origin, with read to 0xffffffffc009bdb0 of 8 bytes by task 515 on cpu 2:
>>>>
>>>>   
>>>>
>>>> + test_kernel_rmw_array+0x71/0xd0
>>>>
>>>>   
>>>>
>>>> + access_thread+0x89/0xd0
>>>>
>>>>   
>>>>
>>>> + kthread+0x23e/0x260
>>>>
>>>>   
>>>>
>>>> + ret_from_fork+0x22/0x30
>>>>
>>>>   
>>>>
>>>> +
>>>>
>>>>   
>>>>
>>>> + value changed: 0x0000000000002328 -> 0x0000000000002329
>>>>
>>>>   
>>>>
>>>> +
>>>>
>>>>   
>>>>
>>>> + Reported by Kernel Concurrency Sanitizer on:
>>>>
>>>>   
>>>>
>>>> + CPU: 2 PID: 515 Comm: access_thread Not tainted 5.12.0-rc2+ #1
>>>>
>>>>   
>>>>
>>>> + Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-2 04/01/2014
>>>>
>>>>   
>>>>
>>>> + ==================================================================
>>>>
>>>>   
>>>>
>>>> +
>>>>
>>>>   
>>>>
>>>> +这个报告是当另一个竞争线程不可能被发现，但是可以从观测的内存地址的值改变而推断
>>>>
>>>>   
>>>>
>>>> +出来的时候生成的。这类报告总是会带有“value changed”行。这类报告的出现通常是因
>>>>
>>>>   
>>>>
>>>> +为在竞争线程中没有插桩，也可能是因为其他原因，比如 DMA 访问。这类报告只会在
>>>>
>>>>   
>>>>
>>>> +设置了内核参数 ``CONFIG_KCSAN_REPORT_RACE_UNKNOWN_ORIGIN=y`` 时才会出现，而这
>>>>
>>>>   
>>>>
>>>> +个参数是默认启用的。
>>>>
>>>>   
>>>>
>>>> +
>>>>
>>>>   
>>>>
>>>> +选择性分析
>>>>
>>>>   
>>>>
>>>> +~~~~~~~~~~~~~
>>>>
>>>>   
>>>>
>>>> +
>>>>
>>>>   
>>>>
>>>> +对于一些特定的访问，函数，编译单元或者整个子系统，可能需要禁用数据竞争检测。
>>>>
>>>>   
>>>>
>>>> +对于静态黑名单，有如下可用的参数：
>>>>
>>>>   
>>>>
>>>> +
>>>>
>>>>   
>>>>
>>>> +* KCSAN 支持使用 ``data_race(expr)`` 注解，这个注解告诉 KCSAN 任何由访问
>>>>
>>>>   
>>>>
>>>> + ``expr`` 所引起的数据竞争都应该被忽略，其产生的行为后果被认为是安全的。请查阅
>>>>
>>>>   
>>>>
>>>> + `"Marking Shared-Memory Accesses" in the LKMM`_ 获得更多信息。
>>>>
>>>>   
>>>>
>>>> +
>>>>
>>>>   
>>>>
>>>> +* 与 ``data_race(...)`` 相似，可以使用类型限定符 ``__data_racy`` 来标记一个变量
>>>>
>>>>   
>>>>
>>>> + ，所有访问该变量而导致的数据竞争都是故意为之并且应该被 KCSAN 忽略::
>>>>
>>>>   
>>>>
>>>> +
>>>>
>>>>   
>>>>
>>>> + struct foo {
>>>>
>>>>   
>>>>
>>>> + ...
>>>>
>>>>   
>>>>
>>>> + int __data_racy stats_counter;
>>>>
>>>>   
>>>>
>>>> + ...
>>>>
>>>>   
>>>>
>>>> + };
>>>>
>>>>   
>>>>
>>>> +
>>>>
>>>>   
>>>>
>>>> +* 使用函数属性 ``__no_kcsan`` 可以对整个函数禁用数据竞争检测::
>>>>
>>>>   
>>>>
>>>> +
>>>>
>>>>   
>>>>
>>>> + __no_kcsan
>>>>
>>>>   
>>>>
>>>> + void foo(void) {
>>>>
>>>>   
>>>>
>>>> + ...
>>>>
>>>>   
>>>>
>>>> +
>>>>
>>>>   
>>>>
>>>> + 为了动态限制该为哪些函数生成报告，查阅 `Debug 文件系统接口`_ 黑名单/白名单特性。
>>>>
>>>>   
>>>>
>>>> +
>>>>
>>>>   
>>>>
>>>> +* 为特定的编译单元禁用数据竞争检测，将下列参数加入到 ``Makefile`` 中::
>>>>
>>>>   
>>>>
>>>> +
>>>>
>>>>   
>>>>
>>>> + KCSAN_SANITIZE_file.o := n
>>>>
>>>>   
>>>>
>>>> +
>>>>
>>>>   
>>>>
>>>> +* 为 ``Makefile`` 中的所有编译单元禁用数据竞争检测，将下列参数添加到相应的
>>>>
>>>>   
>>>>
>>>> + ``Makefile`` 中::
>>>>
>>>>   
>>>>
>>>> +
>>>>
>>>>   
>>>>
>>>> + KCSAN_SANITIZE := n
>>>>
>>>>   
>>>>
>>>> +
>>>>
>>>>   
>>>>
>>>> +.. _"Marking Shared-Memory Accesses" in the LKMM: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/memory-model/Documentation/access-marking.txt
>>>>
>>>>   
>>>>
>>>> +
>>>>
>>>>   
>>>>
>>>> +此外，可以根据偏好设置 KCSAN 显示或隐藏整个类别的数据竞争。可以使用如下
>>>>
>>>>   
>>>>
>>>> +Kconfig 参数进行更改:
>>>>
>>>>   
>>>>
>>>> +
>>>>
>>>>   
>>>>
>>>> +* ``CONFIG_KCSAN_REPORT_VALUE_CHANGE_ONLY``: 如果启用了该参数并且通过观测点观测
>>>>
>>>>   
>>>>
>>>> + 到一个有冲突的写操作，但是对应的内存地址中存储的值没有改变，则不会报告这起数据
>>>>
>>>>   
>>>>
>>>> + 竞争。
>>>>
>>>>   
>>>>
>>>> +
>>>>
>>>>   
>>>>
>>>> +* ``CONFIG_KCSAN_ASSUME_PLAIN_WRITES_ATOMIC``: 假设默认情况下，不超过字大小的简
>>>>
>>>>   
>>>>
>>>> + 单对齐写入操作是原子的。假设这些写入操作不会受到不安全的编译器优化影响，从而导
>>>>
>>>>   
>>>>
>>>> + 致数据竞争。该选项使 KCSAN 不报告仅由不超过字大小的简单对齐写入操作引起
>>>>
>>>>   
>>>>
>>>> + 的冲突所导致的数据竞争。
>>>>
>>>>   
>>>>
>>>> +
>>>>
>>>>   
>>>>
>>>> +* ``CONFIG_KCSAN_PERMISSIVE``: 启用额外的宽松规则来忽略某些常见类型的数据竞争。
>>>>
>>>>   
>>>>
>>>> + 与上面的规则不同，这条规则更加复杂，涉及到值改变模式，访问类型和地址。这个
>>>>
>>>>   
>>>>
>>>> + 选项依赖编译选项 ``CONFIG_KCSAN_REPORT_VALUE_CHANGE_ONLY=y``。请查看
>>>>
>>>>   
>>>>
>>>> + ``kernel/kcsan/permissive.h`` 获取更多细节。对于只侧重于特定子系统而不是整个
>>>>
>>>>   
>>>>
>>>> + 内核报告的测试者和维护者，建议禁用该选项。
>>>>
>>>>   
>>>>
>>>> +
>>>>
>>>>   
>>>>
>>>> +要使用尽可能严格的规则，选择 ``CONFIG_KCSAN_STRICT=y``，这将配置 KCSAN 尽可
>>>>
>>>>   
>>>>
>>>> +能紧密地遵循 Linux 内核内存一致性模型（LKMM）。
>>>>
>>>>   
>>>>
>>>> +
>>>>
>>>>   
>>>>
>>>> +Debug 文件系统接口
>>>>
>>>>   
>>>>
>>>> +~~~~~~~~~~~~~~~~~~~~~
>>>>
>>>>   
>>>>
>>>> +
>>>>
>>>>   
>>>>
>>>> +文件 ``/sys/kernel/debug/kcsan`` 提供了如下接口：
>>>>
>>>>   
>>>>
>>>> +
>>>>
>>>>   
>>>>
>>>> +* 读 ``/sys/kernel/debug/kcsan`` 返回不同的运行时统计数据。
>>>>
>>>>   
>>>>
>>>> +
>>>>
>>>>   
>>>>
>>>> +* 将 ``on`` 或 ``off`` 写入 ``/sys/kernel/debug/kcsan`` 允许打开或关闭 KCSAN。
>>>>
>>>>   
>>>>
>>>> +
>>>>
>>>>   
>>>>
>>>> +* 将 ``!some_func_name`` 写入 ``/sys/kernel/debug/kcsan`` 会将
>>>>
>>>>   
>>>>
>>>> + ``some_func_name`` 添加到报告过滤列表中，这将（默认）禁止报告任意一个顶层栈帧
>>>>
>>>>   
>>>>
>>>> + 在该列表中的数据竞争。
>>>>
>>>>   
>>>>
>>>> +
>>>>
>>>>   
>>>>
>>>> +* 将 ``blacklist`` 或 ``whitelist`` 写入 ``/sys/kernel/debug/kcsan`` 会改变报告
>>>>
>>>>   
>>>>
>>>> + 过滤行为。例如，黑名单的特性可以用来过滤掉经常发生的数据竞争。白名单特性可以帮
>>>>
>>>>   
>>>>
>>>> + 助复现和修复测试。
>>>>
>>>>   
>>>>
>>>> +
>>>>
>>>>   
>>>>
>>>> +性能调优
>>>>
>>>>   
>>>>
>>>> +~~~~~~~~~~~~~
>>>>
>>>>   
>>>>
>>>> +
>>>>
>>>>   
>>>>
>>>> +影响 KCSAN 整体的性能和 bug 检测能力的核心参数是作为内核命令行参数公开的，其默认
>>>>
>>>>   
>>>>
>>>> +值也可以通过相应的 Kconfig 选项更改。
>>>>
>>>>   
>>>>
>>>> +
>>>>
>>>>   
>>>>
>>>> +* ``kcsan.skip_watch`` (``CONFIG_KCSAN_SKIP_WATCH``): 在另一个观测点设置之前每
>>>>
>>>>   
>>>>
>>>> + 个 CPU 要跳过的内存操作次数。更加频繁的设置观测点将增加观察到竞争情况的可能性
>>>>
>>>>   
>>>>
>>>> + 。这个参数对系统整体的性能和竞争检测能力影响最显著。
>>>>
>>>>   
>>>>
>>>> +
>>>>
>>>>   
>>>>
>>>> +* ``kcsan.udelay_task`` (``CONFIG_KCSAN_UDELAY_TASK``): 对于任务，观测点设置之
>>>>
>>>>   
>>>>
>>>> + 后暂停执行的微秒延迟。值越大，检测到竞争情况的可能性越高。
>>>>
>>>>   
>>>>
>>>> +
>>>>
>>>>   
>>>>
>>>> +* ``kcsan.udelay_interrupt`` (``CONFIG_KCSAN_UDELAY_INTERRUPT``): 对于中断，
>>>>
>>>>   
>>>>
>>>> + 观测点设置之后暂停执行的微秒延迟。中断对于延迟的要求更加严格，其延迟通常应该小
>>>>
>>>>   
>>>>
>>>> + 于为任务选择的延迟。
>>>>
>>>>   
>>>>
>>>> +
>>>>
>>>>   
>>>>
>>>> +它们可以通过 ``/sys/module/kcsan/parameters/`` 在运行时进行调整。
>>>>
>>>>   
>>>>
>>>> +
>>>>
>>>>   
>>>>
>>>> +数据竞争
>>>>
>>>>   
>>>>
>>>> +--------
>>>>
>>>>   
>>>>
>>>> +
>>>>
>>>>   
>>>>
>>>> +在一次执行中，如果两个内存访问存在 *冲突*，在不同的线程中并发执行，并且至少
>>>>
>>>>   
>>>>
>>>> +有一个访问是 *简单访问*，则它们就形成了 *数据竞争*。如果它们访问了同一个内存地址并且
>>>>
>>>>   
>>>>
>>>> +至少有一个是写操作，则称它们存在 *冲突*。有关更详细的讨论和定义，见
>>>>
>>>>   
>>>>
>>>> +`"Plain Accesses and Data Races" in the LKMM`_。
>>>>
>>>>   
>>>>
>>>> +
>>>>
>>>>   
>>>>
>>>> +.. _"Plain Accesses and Data Races" in the LKMM: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/memory-model/Documentation/explanation.txt#n1922
>>>>
>>>>   
>>>>
>>>> +
>>>>
>>>>   
>>>>
>>>> +与 Linux 内核内存一致性模型（LKMM）的关系
>>>>
>>>>   
>>>>
>>>> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>>
>>>>   
>>>>
>>>> +
>>>>
>>>>   
>>>>
>>>> +LKMM 定义了各种内存操作的传播和排序规则，让开发者可以推理并发代码。最终这允许确
>>>>
>>>>   
>>>>
>>>> +定并发代码可能的执行情况并判断这些代码是否存在数据竞争。
>>>>
>>>>   
>>>>
>>>> +
>>>>
>>>>   
>>>>
>>>> +KCSAN 可以识别 *被标记的原子操作* （ ``READ_ONCE``, ``WRITE_ONCE`` , ``atomic_*``
>>>>
>>>>   
>>>>
>>>> +等），以及内存屏障所隐含的一部分顺序保证。启用 ``CONFIG_KCSAN_WEAK_MEMORY=y``
>>>>
>>>>   
>>>>
>>>> +配置，KCSAN 会对加载或存储缓冲区进行建模，并可以检测遗漏的
>>>>
>>>>   
>>>>
>>>> +``smp_mb()``, ``smp_wmb()``, ``smp_rmb()``, ``smp_store_release()``，以及所有的
>>>>
>>>>   
>>>>
>>>> +具有等效隐含内存屏障的 ``atomic_*`` 操作。
>>>>
>>>>   
>>>>
>>>> +
>>>>
>>>>   
>>>>
>>>> +请注意，KCSAN 不会报告所有由于缺失内存顺序而导致的数据竞争，特别是在需要内存屏障
>>>>
>>>>   
>>>>
>>>> +来禁止后续内存操作在屏障之前重新排序的情况下。因此，开发人员应该仔细考虑那些未
>>>>
>>>>   
>>>>
>>>> +被检查的内存顺序要求。
>>>>
>>>>   
>>>>
>>>> +
>>>>
>>>>   
>>>>
>>>> +数据竞争以外的竞争检测
>>>>
>>>>   
>>>>
>>>> +---------------------------
>>>>
>>>>   
>>>>
>>>> +
>>>>
>>>>   
>>>>
>>>> +对于有着复杂并发设计的代码，竞争状况不总是表现为数据竞争。如果并发操作引起了意‘
>>>>
>>>>   
>>>>
>>>> +料之外的系统行为，则认为发生了竞争状况。另一方面，数据竞争是在 C 语言层面定义
>>>>
>>>>   
>>>>
>>>> +的。下面的宏定义可以用来检测非数据竞争的漏洞并发代码的属性。
>>>>
>>>>   
>>>>
>>>> +
>>>>
>>>>   
>>>>
>>>> +.. kernel-doc:: include/linux/kcsan-checks.h
>>>>
>>>>   
>>>>
>>>> + :functions: ASSERT_EXCLUSIVE_WRITER ASSERT_EXCLUSIVE_WRITER_SCOPED
>>>>
>>>>   
>>>>
>>>> + ASSERT_EXCLUSIVE_ACCESS ASSERT_EXCLUSIVE_ACCESS_SCOPED
>>>>
>>>>   
>>>>
>>>> + ASSERT_EXCLUSIVE_BITS
>>>>
>>>>   
>>>>
>>>> +
>>>>
>>>>   
>>>>
>>>> +实现细节
>>>>
>>>>   
>>>>
>>>> +-----------
>>>>
>>>>   
>>>>
>>>> +
>>>>
>>>>   
>>>>
>>>> +KCSAN 需要观测两个并发访问。特别重要的是，我们想要（a）增加观测到竞争的机会（尤
>>>>
>>>>   
>>>>
>>>> +其是很少发生的竞争），以及（b）能够实际观测到这些竞争。我们可以通过（a）注入
>>>>
>>>>   
>>>>
>>>> +不同的延迟，以及（b）使用地址观测点（或断点）来实现。
>>>>
>>>>   
>>>>
>>>> +
>>>>
>>>>   
>>>>
>>>> +如果我们在设置了地址观察点的情况下故意延迟一个内存访问，然后观察到观察点被触发
>>>>
>>>>   
>>>>
>>>> +，那么两个对同一地址的访问就发生了竞争。使用硬件观察点，这是 `DataCollider
>>>>
>>>>   
>>>>
>>>> +<http://usenix.org/legacy/events/osdi10/tech/full_papers/Erickson.pdf>%60_ http://usenix.org/legacy/events/osdi10/tech/full_papers/Erickson.pdf%3E%60_ 中采用
>>>>
>>>>   
>>>>
>>>> +的方法。与 DataCollider 不同，KCSAN 不使用硬件观察点，而是依赖于编译器插装和“软
>>>>
>>>>   
>>>>
>>>> +观测点”。
>>>>
>>>>   
>>>>
>>>> +
>>>>
>>>>   
>>>>
>>>> +在 KCSAN 中，观察点是通过一种高效的编码实现的，该编码将访问类型、大小和地址存储
>>>>
>>>>   
>>>>
>>>> +在一个长整型变量中；使用“软观察点”的好处是具有可移植性和更大的灵活性。然后，
>>>>
>>>>   
>>>>
>>>> +KCSAN依赖于编译器对普通访问的插桩。对于每个插桩的普通访问：
>>>>
>>>>   
>>>>
>>>> +
>>>>
>>>>   
>>>>
>>>> +1. 检测是否存在一个复合的观测点，如果存在，并且至少有一个操作是写操作，则我们发
>>>>
>>>>   
>>>>
>>>> + 现了一个竞争访问。
>>>>
>>>>   
>>>>
>>>> +
>>>>
>>>>   
>>>>
>>>> +2. 如果不存在匹配的观察点，则定期的设置一个观测点并随机延迟一小段时间。
>>>>
>>>>   
>>>>
>>>> +
>>>>
>>>>   
>>>>
>>>> +3. 在延迟前检查数据值，并在延迟后重新检查数据值；如果值不匹配，我们推测存在一个
>>>>
>>>>   
>>>>
>>>> + 未知来源的竞争状况。
>>>>
>>>>   
>>>>
>>>> +
>>>>
>>>>   
>>>>
>>>> +为了检测普通访问和标记访问之间的数据竞争，KCSAN 也对标记访问进行标记，但仅用于
>>>>
>>>>   
>>>>
>>>> +检查是否存在观察点；即 KCSAN 不会在标记访问上设置观察点。通过不在标记操作上设
>>>>
>>>>   
>>>>
>>>> +置观察点，如果对一个变量的所有并发访问都被正确标记，KCSAN 将永远不会触发观察点
>>>>
>>>>   
>>>>
>>>> +，因此也不会报告这些访问。
>>>>
>>>>   
>>>>
>>>> +
>>>>
>>>>   
>>>>
>>>> +弱内存建模
>>>>
>>>>   
>>>>
>>>> +~~~~~~~~~~~~~~~~~~~~
>>>>
>>>>   
>>>>
>>>> +
>>>>
>>>>   
>>>>
>>>> +KSCAN 检测由于缺失内存屏障的数据检测的方法是居于对访问重新排序的建模（使用参数
>>>>
>>>>   
>>>>
>>>> +``CONFIG_KCSAN_WEAK_MEMORY=y``）。每个设置了观察点的普通内存访问也会被选择在其
>>>>
>>>>   
>>>>
>>>> +函数范围内进行模拟重新排序（最多一个正在进行的访问）。
>>>>
>>>>   
>>>>
>>>> +
>>>>
>>>>   
>>>>
>>>> +一旦某个访问被选择用于重新排序，它将在函数范围内与每个其他访问进行检查。如果遇
>>>>
>>>>   
>>>>
>>>> +到适当的内存屏障，该访问将不再被考虑进行模拟重新排序。
>>>>
>>>>   
>>>>
>>>> +
>>>>
>>>>   
>>>>
>>>> +当内存操作的结果应该由屏障排序时，KCSAN 可以检测到仅由于缺失屏障而导致的冲突的
>>>>
>>>>   
>>>>
>>>> +数据竞争。考虑下面的例子::
>>>>
>>>>   
>>>>
>>>> +
>>>>
>>>>   
>>>>
>>>> + int x, flag;
>>>>
>>>>   
>>>>
>>>> + void T1(void)
>>>>
>>>>   
>>>>
>>>> + {
>>>>
>>>>   
>>>>
>>>> + x = 1; // data race!
>>>>
>>>>   
>>>>
>>>> + WRITE_ONCE(flag, 1); // correct: smp_store_release(&flag, 1)
>>>>
>>>>   
>>>>
>>>> + }
>>>>
>>>>   
>>>>
>>>> + void T2(void)
>>>>
>>>>   
>>>>
>>>> + {
>>>>
>>>>   
>>>>
>>>> + while (!READ_ONCE(flag)); // correct: smp_load_acquire(&flag)
>>>>
>>>>   
>>>>
>>>> + ... = x; // data race!
>>>>
>>>>   
>>>>
>>>> + }
>>>>
>>>>   
>>>>
>>>> +
>>>>
>>>>   
>>>>
>>>> +当启用了弱内存建模，KCSAN 将考虑对 ``T1`` 中的 ``x`` 进行模拟重新排序。在写入
>>>>
>>>>   
>>>>
>>>> +``flag`` 之后，x再次被检查是否有并发访问：因为 ``T2`` 可以在写入
>>>>
>>>>   
>>>>
>>>> +``flag`` 之后继续进行，因此检测到数据竞争。如果遇到了正确的屏障， ``x`` 在正确
>>>>
>>>>   
>>>>
>>>> +释放 ``flag`` 后将不会被考虑重新排序，因此不会检测到数据竞争。
>>>>
>>>>   
>>>>
>>>> +
>>>>
>>>>   
>>>>
>>>> +在复杂性上的权衡以及实际的限制意味着只能检测到一部分由于缺失内存屏障而导致的数
>>>>
>>>>   
>>>>
>>>> +据竞争。由于当前可用的编译器支持，KCSAN 的实现仅限于建模“缓冲”（延迟访问）的
>>>>
>>>>   
>>>>
>>>> +效果，因为运行时不能“预取”访问。同时要注意，观测点只设置在普通访问上，这是唯
>>>>
>>>>   
>>>>
>>>> +一一个 KCSAN 会模拟重新排序的访问类型。这意味着标记访问的重新排序不会被建模。
>>>>
>>>>   
>>>>
>>>> +
>>>>
>>>>   
>>>>
>>>> +上述情况的一个后果是获取操作不需要屏障插桩（不需要预取）。此外，引入地址或控制
>>>>
>>>>   
>>>>
>>>> +依赖的标记访问不需要特殊处理（标记访问不能重新排序，后续依赖的访问不能被预取）
>>>>
>>>>   
>>>>
>>>> +。
>>>>
>>>>   
>>>>
>>>> +
>>>>
>>>>   
>>>>
>>>> +关键属性
>>>>
>>>>   
>>>>
>>>> +~~~~~~~~~~~~~~
>>>>
>>>>   
>>>>
>>>> +
>>>>
>>>>   
>>>>
>>>> +1. **内存开销**：整体的内存开销只有几 MiB，取决于配置。当前的实现是使用一个小长
>>>>
>>>>   
>>>>
>>>> + 整型数组来编码观测点信息，几乎可以忽略不计。
>>>>
>>>>   
>>>>
>>>> +
>>>>
>>>>   
>>>>
>>>> +2. **性能开销**：KCSAN 的运行时旨在性能开销最小化，使用一个高效的观测点编码，在
>>>>
>>>>   
>>>>
>>>> + 快速路径中不需要获取任何锁。在拥有 8 个 CPU 的系统上的内核启动来说：
>>>>
>>>>   
>>>>
>>>> +
>>>>
>>>>   
>>>>
>>>> + - 使用默认 KCSAN 配置时，性能下降 5 倍；
>>>>
>>>>   
>>>>
>>>> + - 仅因运行时快速路径开销导致性能下降 2.8 倍（设置非常大的
>>>>
>>>>   
>>>>
>>>> + ``KCSAN_SKIP_WATCH`` 并取消设置 ``KCSAN_SKIP_WATCH_RANDOMIZE``）。
>>>>
>>>>   
>>>>
>>>> +
>>>>
>>>>   
>>>>
>>>> +3. **注解开销**：KCSAN 运行时之外需要的注释很少。因此，随着内核的发展维护的开
>>>>
>>>>   
>>>>
>>>> + 销也很小。
>>>>
>>>>   
>>>>
>>>> +
>>>>
>>>>   
>>>>
>>>> +4. **检测设备的竞争写入**：由于设置观测点时会检查数据值，设备的竞争写入也可以
>>>>
>>>>   
>>>>
>>>> + 被检测到。
>>>>
>>>>   
>>>>
>>>> +
>>>>
>>>>   
>>>>
>>>> +5. **内存排序**：KCSAN 只了解一部分 LKMM 排序规则；这可能会导致漏报数据竞争（
>>>>
>>>>   
>>>>
>>>> + 假阴性）。
>>>>
>>>>   
>>>>
>>>> +
>>>>
>>>>   
>>>>
>>>> +6. **分析准确率**： 对于观察到的执行，由于使用采样策略，分析是 * 不健全 * 的
>>>>
>>>>   
>>>>
>>>> + （可能有假阴性），但期望得到完整的分析（没有假阳性）。
>>>>
>>>>   
>>>>
>>>> +
>>>>
>>>>   
>>>>
>>>> +考虑的替代方案
>>>>
>>>>   
>>>>
>>>> +-------------------
>>>>
>>>>   
>>>>
>>>> +
>>>>
>>>>   
>>>>
>>>> +一个内核数据竞争检测的替代方法是 `Kernel Thread Sanitizer (KTSAN)
>>>>
>>>>   
>>>>
>>>> +<https://github.com/google/ktsan/wiki>%60_%E3%80%82KTSAN https://github.com/google/ktsan/wiki%3E%60_%E3%80%82KTSAN 是一个先行发生的数据竞争检测器
>>>>
>>>>   
>>>>
>>>> +，它显式建立内存操作之间的先行发生顺序，这可以用来确定
>>>>
>>>>   
>>>>
>>>> +`数据竞争`_ 中定义的数据竞争。
>>>>
>>>>   
>>>>
>>>> +
>>>>
>>>>   
>>>>
>>>> +为了建立正确的先行发生关系，KTSAN 必须了解 LKMM 的所有排序规则和同步原语。不幸
>>>>
>>>>   
>>>>
>>>> +的是，任何遗漏都会导致大量的假阳性，这在包含众多自定义同步机制的内核上下文中特
>>>>
>>>>   
>>>>
>>>> +别有害。为了跟踪前因后果关系，KTSAN 的实现需要为每个内存位置提供元数据（影子内
>>>>
>>>>   
>>>>
>>>> +存），这意味着每页内存对应 4 页影子内存，在大型系统上可能会带来数十 GiB 的开销
>>>>
>>>>   
>>>>
>>>> +。
>>>>
>>>>   
>>>>
>>>> \ No newline at end of file
>>>> Let's add a blankline at end of file.
>>>   
>>>
>>> BTW, the merge windows has open, so if you don't mind, could you send v2
>>>
>>> next week?
>>>
>>>   
>>>
>>> Thanks,
>>>
>>> Yanteng
>>>


