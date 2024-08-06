Return-Path: <linux-kernel+bounces-276486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C75DA949478
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 17:25:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4773A1F21EC6
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 15:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2F331BF37;
	Tue,  6 Aug 2024 15:25:42 +0000 (UTC)
Received: from zg8tmtyylji0my4xnjeumjiw.icoremail.net (zg8tmtyylji0my4xnjeumjiw.icoremail.net [162.243.161.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A70918D63A;
	Tue,  6 Aug 2024 15:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.161.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722957941; cv=none; b=lmc31alPpekkWicaMyQPpAKZKIBeP+5Xr9ZS/7ZMSl/5p5puo3cQFuN+l/4p5ilQ1sTGzkYVca9ZyY0pGi4fQ22onURwlelpr+6fq6nK7UK/urNeLTu9l7b6u7CzEt/J7Ha6QcYocTyuFG1Xfyk1L/M4lgvlVMHmvYNm9KxWjug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722957941; c=relaxed/simple;
	bh=B/qLJA3wF+hP04Do5OVMccPDyi10MP4gvOPDqJTlnSU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PoACHV3JQbNdoXWTZqQKdhyWsdfmrnAFJA+7T8jYxduQsbbPGXBJFC3RqHxavo+azF1QgQGFfKfSwWap0EM5cqRqsvuu2phe8Qn/Ues1mPI83Heoaie6Hb0mm5+jVd0WrWgFITt/b6oMZfR+GFATgTnJfFskE2S/JDpnNXBt1Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn; spf=pass smtp.mailfrom=hust.edu.cn; arc=none smtp.client-ip=162.243.161.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hust.edu.cn
Received: from hust.edu.cn (unknown [172.16.0.50])
	by app1 (Coremail) with SMTP id HgEQrABHp2xEQLJm6eHNAg--.52925S2;
	Tue, 06 Aug 2024 23:24:52 +0800 (CST)
Received: from [192.168.1.111] (unknown [10.12.177.116])
	by gateway (Coremail) with SMTP id _____wBX0HFDQLJmOOrYAA--.29714S2;
	Tue, 06 Aug 2024 23:24:51 +0800 (CST)
Message-ID: <502bcb7a-83d5-49c8-b2e2-a908900281ee@hust.edu.cn>
Date: Tue, 6 Aug 2024 23:24:50 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] docs/zh_CN: Add dev-tools/kcsan Chinese translation
To: Alex Shi <seakeel@gmail.com>, si.yanteng@linux.dev,
 Alex Shi <alexs@kernel.org>, Yanteng Si <siyanteng@loongson.cn>,
 Jonathan Corbet <corbet@lwn.net>, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Cc: hust-os-kernel-patches@googlegroups.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev
References: <20240731180916.36617-1-tttturtleruss@hust.edu.cn>
 <074662fa2977a708d7a9a4545ffad26612514dc2@linux.dev>
 <b59dbfef-35a9-41e7-b995-655446d503f0@gmail.com>
From: Haoyang Liu <tttturtleruss@hust.edu.cn>
In-Reply-To: <b59dbfef-35a9-41e7-b995-655446d503f0@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:HgEQrABHp2xEQLJm6eHNAg--.52925S2
Authentication-Results: app1; spf=neutral smtp.mail=tttturtleruss@hust
	.edu.cn;
X-Coremail-Antispam: 1UD129KBjvAXoW3ZrW3Xry3GF13JrWDuFW3Wrg_yoW8Jw18to
	W5Kr4fCr48Gr15Jr15A3yDJrWYy3WUGFnrJrWakrn8JryUKw10y3WUJw15Jr4UGr45JF13
	JFy7Jr17Aa4UXas5n29KB7ZKAUJUUUUf529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUO27k0a2IF6FyUM7kC6x804xWl1xkIjI8I6I8E6xAIw20EY4v2
	0xvaj40_Wr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7
	IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK
	6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1ln4kS14v26r
	126r1DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I8C
	rVACY4xI64kE6c02F40Ex7xfMcIj64x0Y40En7xvr7AKxVW8Jr0_Cr1UMcIj6x8ErcxFaV
	Av8VW8uFyUJr1UMcIj6xkF7I0En7xvr7AKxVW8Jr0_Cr1UMcvjeVCFs4IE7xkEbVWUJVW8
	JwACjcxG0xvEwIxGrwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCF04k20x
	vE74AGY7Cv6cx26r4fZr1UJr1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_
	GFv_Wrylx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1V
	AY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAI
	cVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42
	IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIev
	Ja73UjIFyTuYvjxUVco2UUUUU
X-CM-SenderInfo: rxsqjiqrssiko6kx23oohg3hdfq/1tbiAQkBAmaxmbIwBwAAsA


在 2024/8/6 11:19, Alex Shi 写道:
> Please don't use HTML format to send emails.
OK.
> Does this file look great in web browser after 'make htmldocs'?

Yes, I check the output html file and it looks all right.


Thanks,

Haoyang

>
> Thanks
> Alex
>
> On 8/6/24 10:20 AM, si.yanteng@linux.dev wrote:
>> 2024年8月1日 02:09, "Haoyang Liu" <tttturtleruss@hust.edu.cn> 写到:
>>
>>
>>
>>> Translate dev-tools/kcsan commit 31f605a308e6
>>>
>>> ("kcsan, compiler_types: Introduce __data_racy type qualifier")
>>>
>>> into Chinese and add it in dev-tools/zh_CN/index.rst
>>>
>>> Signed-off-by: Haoyang Liu <tttturtleruss@hust.edu.cn>
>>>
>>> ---
>>>
>>> v3 -> v4: Added original English text for proper nouns and modified some unclear experessions.
>>>
>>> v2 -> v3: Revised some sentences based on reviewer's suggestions and updated the KTSAN url.
>>>
>>> v1 -> v2: Added commit tag and fixed style problems according to reviewer's suggestions.
>>>
>>>   .../translations/zh_CN/dev-tools/index.rst | 2 +-
>>>
>>>   .../translations/zh_CN/dev-tools/kcsan.rst | 321 ++++++++++++++++++
>>>
>>>   2 files changed, 322 insertions(+), 1 deletion(-)
>>>
>>>   create mode 100644 Documentation/translations/zh_CN/dev-tools/kcsan.rst
>>>
>>> diff --git a/Documentation/translations/zh_CN/dev-tools/index.rst b/Documentation/translations/zh_CN/dev-tools/index.rst
>>>
>>> index c540e4a7d5db..6a8c637c0be1 100644
>>>
>>> --- a/Documentation/translations/zh_CN/dev-tools/index.rst
>>>
>>> +++ b/Documentation/translations/zh_CN/dev-tools/index.rst
>>>
>>> @@ -21,6 +21,7 @@ Documentation/translations/zh_CN/dev-tools/testing-overview.rst
>>>
>>>   testing-overview
>>>
>>>   sparse
>>>
>>>   kcov
>>>
>>> + kcsan
>>>
>>>   gcov
>>>
>>>   kasan
>>>
>>>   ubsan
>>>
>>> @@ -32,7 +33,6 @@ Todolist:
>>>
>>>   - checkpatch
>>>
>>>   - coccinelle
>>>
>>>   - kmsan
>>>
>>> - - kcsan
>>>
>>>   - kfence
>>>
>>>   - kgdb
>>>
>>>   - kselftest
>>>
>>> diff --git a/Documentation/translations/zh_CN/dev-tools/kcsan.rst b/Documentation/translations/zh_CN/dev-tools/kcsan.rst
>>>
>>> new file mode 100644
>>>
>>> index 000000000000..39fa43d8c414
>>>
>>> --- /dev/null
>>>
>>> +++ b/Documentation/translations/zh_CN/dev-tools/kcsan.rst
>>>
>>> @@ -0,0 +1,321 @@
>>>
>>> +.. SPDX-License-Identifier: GPL-2.0
>>>
>>> +
>>>
>>> +.. include:: ../disclaimer-zh_CN.rst
>>>
>>> +
>>>
>>> +:Original: Documentation/dev-tools/kcsan.rst
>>>
>>> +:Translator: 刘浩阳 Haoyang Liu <tttturtleruss@hust.edu.cn>
>>>
>>> +
>>>
>>> +内核并发消毒剂(KCSAN)
>>>
>>> +=====================
>>>
>>> +
>>>
>>> +内核并发消毒剂（KCSAN）是一个动态竞争检测器，依赖编译时插桩，并且使用基于观察
>>>
>>> +点的采样方法来检测竞争。KCSAN 的主要目的是检测 `数据竞争`_。
>>>
>>> +
>>>
>>> +使用
>>>
>>> +----
>>>
>>> +
>>>
>>> +KCSAN 受 GCC 和 Clang 支持。使用 GCC 需要版本 11 或更高，使用 Clang 也需要
>>>
>>> +版本 11 或更高。
>>>
>>> +
>>>
>>> +为了启用 KCSAN，用如下参数配置内核::
>>>
>>> +
>>>
>>> + CONFIG_KCSAN = y
>>>
>>> +
>>>
>>> +KCSAN 提供了几个其他的配置选项来自定义行为（见 ``lib/Kconfig.kcsan`` 中的各自的
>>>
>>> +帮助文档以获取更多信息）。
>>>
>>> +
>>>
>>> +错误报告
>>>
>>> +~~~~~~~~
>>>
>>> +
>>>
>>> +一个典型数据竞争的报告如下所示::
>>>
>>> +
>>>
>>> + ==================================================================
>>>
>>> + BUG: KCSAN: data-race in test_kernel_read / test_kernel_write
>>>
>>> +
>>>
>>> + write to 0xffffffffc009a628 of 8 bytes by task 487 on cpu 0:
>>>
>>> + test_kernel_write+0x1d/0x30
>>>
>>> + access_thread+0x89/0xd0
>>>
>>> + kthread+0x23e/0x260
>>>
>>> + ret_from_fork+0x22/0x30
>>>
>>> +
>>>
>>> + read to 0xffffffffc009a628 of 8 bytes by task 488 on cpu 6:
>>>
>>> + test_kernel_read+0x10/0x20
>>>
>>> + access_thread+0x89/0xd0
>>>
>>> + kthread+0x23e/0x260
>>>
>>> + ret_from_fork+0x22/0x30
>>>
>>> +
>>>
>>> + value changed: 0x00000000000009a6 -> 0x00000000000009b2
>>>
>>> +
>>>
>>> + Reported by Kernel Concurrency Sanitizer on:
>>>
>>> + CPU: 6 PID: 488 Comm: access_thread Not tainted 5.12.0-rc2+ #1
>>>
>>> + Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-2 04/01/2014
>>>
>>> + ==================================================================
>>>
>>> +
>>>
>>> +报告的头部提供了一个关于竞争中涉及到的函数的简短总结。随后是竞争中的两个线程的
>>>
>>> +访问类型和堆栈信息。如果 KCSAN 发现了一个值的变化，那么那个值的旧值和新值会在
>>>
>>> +“value changed”这一行单独显示。
>>>
>>> +
>>>
>>> +另一个不太常见的数据竞争类型的报告如下所示::
>>>
>>> +
>>>
>>> + ==================================================================
>>>
>>> + BUG: KCSAN: data-race in test_kernel_rmw_array+0x71/0xd0
>>>
>>> +
>>>
>>> + race at unknown origin, with read to 0xffffffffc009bdb0 of 8 bytes by task 515 on cpu 2:
>>>
>>> + test_kernel_rmw_array+0x71/0xd0
>>>
>>> + access_thread+0x89/0xd0
>>>
>>> + kthread+0x23e/0x260
>>>
>>> + ret_from_fork+0x22/0x30
>>>
>>> +
>>>
>>> + value changed: 0x0000000000002328 -> 0x0000000000002329
>>>
>>> +
>>>
>>> + Reported by Kernel Concurrency Sanitizer on:
>>>
>>> + CPU: 2 PID: 515 Comm: access_thread Not tainted 5.12.0-rc2+ #1
>>>
>>> + Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-2 04/01/2014
>>>
>>> + ==================================================================
>>>
>>> +
>>>
>>> +这个报告是当另一个竞争线程不可能被发现，但是可以从观测的内存地址的值改变而推断
>>>
>>> +出来的时候生成的。这类报告总是会带有“value changed”行。这类报告的出现通常是因
>>>
>>> +为在竞争线程中缺少插桩，也可能是因为其他原因，比如 DMA 访问。这类报告只会在
>>>
>>> +设置了内核参数 ``CONFIG_KCSAN_REPORT_RACE_UNKNOWN_ORIGIN=y`` 时才会出现，而这
>>>
>>> +个参数是默认启用的。
>>>
>>> +
>>>
>>> +选择性分析
>>>
>>> +~~~~~~~~~~
>>>
>>> +
>>>
>>> +对于一些特定的访问，函数，编译单元或者整个子系统，可能需要禁用数据竞争检测。
>>>
>>> +对于静态黑名单，有如下可用的参数：
>>>
>>> +
>>>
>>> +* KCSAN 支持使用 ``data_race(expr)`` 注解，这个注解告诉 KCSAN 任何由访问
>>>
>>> + ``expr`` 所引起的数据竞争都应该被忽略，其产生的行为后果被认为是安全的。请查阅
>>>
>>> + `"Marking Shared-Memory Accesses" in the LKMM`_ 获得更多信息。
>>>
>>> +
>>>
>>> +* 与 ``data_race(...)`` 相似，可以使用类型限定符 ``__data_racy`` 来标记一个变量
>>>
>>> + ，所有访问该变量而导致的数据竞争都是故意为之并且应该被 KCSAN 忽略::
>>>
>>> +
>>>
>>> + struct foo {
>>>
>>> + ...
>>>
>>> + int __data_racy stats_counter;
>>>
>>> + ...
>>>
>>> + };
>>>
>>> +
>>>
>>> +* 使用函数属性 ``__no_kcsan`` 可以对整个函数禁用数据竞争检测::
>>>
>>> +
>>>
>>> + __no_kcsan
>>>
>>> + void foo(void) {
>>>
>>> + ...
>>>
>>> +
>>>
>>> + 为了动态限制该为哪些函数生成报告，查阅 `Debug 文件系统接口`_ 黑名单/白名单特性。
>>>
>>> +
>>>
>>> +* 为特定的编译单元禁用数据竞争检测，将下列参数加入到 ``Makefile`` 中::
>>>
>>> +
>>>
>>> + KCSAN_SANITIZE_file.o := n
>>>
>>> +
>>>
>>> +* 为 ``Makefile`` 中的所有编译单元禁用数据竞争检测，将下列参数添加到相应的
>>>
>>> + ``Makefile`` 中::
>>>
>>> +
>>>
>>> + KCSAN_SANITIZE := n
>>>
>>> +
>>>
>>> +.. _"Marking Shared-Memory Accesses" in the LKMM: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/memory-model/Documentation/access-marking.txt
>>>
>>> +
>>>
>>> +此外，KCSAN 可以根据偏好设置显示或隐藏整个类别的数据竞争。可以使用如下
>>>
>>> +Kconfig 参数进行更改:
>>>
>>> +
>>>
>>> +* ``CONFIG_KCSAN_REPORT_VALUE_CHANGE_ONLY``: 如果启用了该参数并且通过观测点
>>>
>>> + (watchpoint) 观测到一个有冲突的写操作，但是对应的内存地址中存储的值没有改变，
>>>
>>> + 则不会报告这起数据竞争。
>>>
>>> +
>>>
>>> +* ``CONFIG_KCSAN_ASSUME_PLAIN_WRITES_ATOMIC``: 假设默认情况下，不超过字大小的简
>>>
>>> + 单对齐写入操作是原子的。假设这些写入操作不会受到不安全的编译器优化影响，从而导
>>>
>>> + 致数据竞争。该选项使 KCSAN 不报告仅由不超过字大小的简单对齐写入操作引起
>>>
>>> + 的冲突所导致的数据竞争。
>>>
>>> +
>>>
>>> +* ``CONFIG_KCSAN_PERMISSIVE``: 启用额外的宽松规则来忽略某些常见类型的数据竞争。
>>>
>>> + 与上面的规则不同，这条规则更加复杂，涉及到值改变模式，访问类型和地址。这个
>>>
>>> + 选项依赖编译选项 ``CONFIG_KCSAN_REPORT_VALUE_CHANGE_ONLY=y``。请查看
>>>
>>> + ``kernel/kcsan/permissive.h`` 获取更多细节。对于只侧重于特定子系统而不是整个
>>>
>>> + 内核报告的测试者和维护者，建议禁用该选项。
>>>
>>> +
>>>
>>> +要使用尽可能严格的规则，选择 ``CONFIG_KCSAN_STRICT=y``，这将配置 KCSAN 尽可
>>>
>>> +能紧密地遵循 Linux 内核内存一致性模型（LKMM）。
>>>
>>> +
>>>
>>> +Debug 文件系统接口
>>>
>>> +~~~~~~~~~~~~~~~~~~
>>>
>>> +
>>>
>>> +文件 ``/sys/kernel/debug/kcsan`` 提供了如下接口：
>>>
>>> +
>>>
>>> +* 读 ``/sys/kernel/debug/kcsan`` 返回不同的运行时统计数据。
>>>
>>> +
>>>
>>> +* 将 ``on`` 或 ``off`` 写入 ``/sys/kernel/debug/kcsan`` 允许打开或关闭 KCSAN。
>>>
>>> +
>>>
>>> +* 将 ``!some_func_name`` 写入 ``/sys/kernel/debug/kcsan`` 会将
>>>
>>> + ``some_func_name`` 添加到报告过滤列表中，该列表（默认）会将数据竞争报告中的顶
>>>
>>> + 层堆栈帧是列表中函数的情况列入黑名单。
>>>
>>> +
>>>
>>> +* 将 ``blacklist`` 或 ``whitelist`` 写入 ``/sys/kernel/debug/kcsan`` 会改变报告
>>>
>>> + 过滤行为。例如，黑名单的特性可以用来过滤掉经常发生的数据竞争。白名单特性可以帮
>>>
>>> + 助复现和修复测试。
>>>
>>> +
>>>
>>> +性能调优
>>>
>>> +~~~~~~~~
>>>
>>> +
>>>
>>> +影响 KCSAN 整体的性能和 bug 检测能力的核心参数是作为内核命令行参数公开的，其默认
>>>
>>> +值也可以通过相应的 Kconfig 选项更改。
>>>
>>> +
>>>
>>> +* ``kcsan.skip_watch`` (``CONFIG_KCSAN_SKIP_WATCH``): 在另一个观测点设置之前每
>>>
>>> + 个 CPU 要跳过的内存操作次数。更加频繁的设置观测点将增加观察到竞争情况的可能性
>>>
>>> + 。这个参数对系统整体的性能和竞争检测能力影响最显著。
>>>
>>> +
>>>
>>> +* ``kcsan.udelay_task`` (``CONFIG_KCSAN_UDELAY_TASK``): 对于任务，观测点设置之
>>>
>>> + 后暂停执行的微秒延迟。值越大，检测到竞争情况的可能性越高。
>>>
>>> +
>>>
>>> +* ``kcsan.udelay_interrupt`` (``CONFIG_KCSAN_UDELAY_INTERRUPT``): 对于中断，
>>>
>>> + 观测点设置之后暂停执行的微秒延迟。中断对于延迟的要求更加严格，其延迟通常应该小
>>>
>>> + 于为任务选择的延迟。
>>>
>>> +
>>>
>>> +它们可以通过 ``/sys/module/kcsan/parameters/`` 在运行时进行调整。
>>>
>>> +
>>>
>>> +数据竞争
>>>
>>> +--------
>>>
>>> +
>>>
>>> +在一次执行中，如果两个内存访问存在 *冲突*，在不同的线程中并发执行，并且至少
>>>
>>> +有一个访问是 *简单访问*，则它们就形成了 *数据竞争*。如果它们访问了同一个内存地址并且
>>>
>>> +至少有一个是写操作，则称它们存在 *冲突*。有关更详细的讨论和定义，见
>>> +`"Plain Accesses and Data Races" in the LKMM`_。
>>>
>>> +
>>>
>>> +.. _"Plain Accesses and Data Races" in the LKMM:
>> Sorry for the delay for so long, how about
>> translating it into Chinese as well?
>>   
>>
>>
>> Thanks,
>> Yanteng


