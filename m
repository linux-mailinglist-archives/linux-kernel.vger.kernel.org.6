Return-Path: <linux-kernel+bounces-276484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D545949471
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 17:24:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CADF91F22356
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 15:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C32951BDDB;
	Tue,  6 Aug 2024 15:24:33 +0000 (UTC)
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [20.231.56.155])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9675F9DF;
	Tue,  6 Aug 2024 15:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=20.231.56.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722957873; cv=none; b=rWC+9FEK0NMmEbMJGKL7xehaHu7roFQ2HmXPOTAer9yWdmkVFrjzaQ8oIbOJHEm8mnOuUqBO31DLLCrMQGtVeL+civyi0NUEjHDD4futtk6eM6mOppoiY4aRpqlphgI9H3y0u8GEEbG1jtcRxos/awPVg+yljTZqiM3DvwpcRDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722957873; c=relaxed/simple;
	bh=WTyF3gHGH/iQaGcAvmph5Yx+f6EvDmsTD1Pw2QCb3MM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GCxc5YjgR/CuLU5mqEMxhoiPHSwjw4azu2tY3mhT8k/7pMIYz53Nk77+fiYqMOePKEvGDZNAldnCWgTDrv+lay1sL9+Rct973ub994AYT7rrQs4Zet6BIJtmHg1mMEbEr2dzPx0ZxNflDKT19UtViSBgtKe5YOu9iwCSNLHuKqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn; spf=pass smtp.mailfrom=hust.edu.cn; arc=none smtp.client-ip=20.231.56.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hust.edu.cn
Received: from hust.edu.cn (unknown [172.16.0.50])
	by app1 (Coremail) with SMTP id HgEQrABnbjoEQLJmD93NAg--.28009S2;
	Tue, 06 Aug 2024 23:23:48 +0800 (CST)
Received: from [192.168.1.111] (unknown [10.12.177.116])
	by gateway (Coremail) with SMTP id _____wCHEHMCQLJmsufYAA--.29934S2;
	Tue, 06 Aug 2024 23:23:47 +0800 (CST)
Message-ID: <1d0cfce3-cf65-4d3a-b8af-73c3bc5d2d45@hust.edu.cn>
Date: Tue, 6 Aug 2024 23:23:45 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] docs/zh_CN: Add dev-tools/kcsan Chinese translation
To: si.yanteng@linux.dev, Alex Shi <alexs@kernel.org>,
 Yanteng Si <siyanteng@loongson.cn>, Jonathan Corbet <corbet@lwn.net>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Cc: hust-os-kernel-patches@googlegroups.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev
References: <20240731180916.36617-1-tttturtleruss@hust.edu.cn>
 <074662fa2977a708d7a9a4545ffad26612514dc2@linux.dev>
From: Haoyang Liu <tttturtleruss@hust.edu.cn>
In-Reply-To: <074662fa2977a708d7a9a4545ffad26612514dc2@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:HgEQrABnbjoEQLJmD93NAg--.28009S2
Authentication-Results: app1; spf=neutral smtp.mail=tttturtleruss@hust
	.edu.cn;
X-Coremail-Antispam: 1UD129KBjvAXoWfGF18tr4xGF47tw47Kw4kJFb_yoW8Jr4DWo
	W5Kr4fCr48Gr15Xr15C3yDJayYy3WUCFnrJrZIkrsxAryUK3WFy3WUAw15Jr4UCrW5J3W3
	JFy2qr17AayUXas3n29KB7ZKAUJUUUUf529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUOz7k0a2IF6w4xM7kC6x804xWl1xkIjI8I6I8E6xAIw20EY4v2
	0xvaj40_Wr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7
	IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vE
	x4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAaw2AFwI0_JF
	0_Jw1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4xG
	64xvF2IEw4CE5I8CrVC2j2WlYx0EF7xvrVAajcxG14v26r4UJVWxJr1lYx0E74AGY7Cv6c
	x26r4fZr1UJr1lYx0Ec7CjxVAajcxG14v26r4UJVWxJr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcVAKI48JMxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxAIw28IcV
	Cjz48v1sIEY20_GFW3Jr1UJwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWU
	AVWUtwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67
	kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY
	6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0x
	vEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2Kfnx
	nUUI43ZEXa7IU0lksPUUUUU==
X-CM-SenderInfo: rxsqjiqrssiko6kx23oohg3hdfq/1tbiAQsBAmaxmbIv-wAHsi


在 2024/8/6 10:20, si.yanteng@linux.dev 写道:
> 2024年8月1日 02:09, "Haoyang Liu" <tttturtleruss@hust.edu.cn> 写到:
>
>
>
>> Translate dev-tools/kcsan commit 31f605a308e6
>>
>> ("kcsan, compiler_types: Introduce __data_racy type qualifier")
>>
>> into Chinese and add it in dev-tools/zh_CN/index.rst
>>
>> Signed-off-by: Haoyang Liu <tttturtleruss@hust.edu.cn>
>>
>> ---
>>
>> v3 -> v4: Added original English text for proper nouns and modified some unclear experessions.
>>
>> v2 -> v3: Revised some sentences based on reviewer's suggestions and updated the KTSAN url.
>>
>> v1 -> v2: Added commit tag and fixed style problems according to reviewer's suggestions.
>>
>>   .../translations/zh_CN/dev-tools/index.rst | 2 +-
>>
>>   .../translations/zh_CN/dev-tools/kcsan.rst | 321 ++++++++++++++++++
>>
>>   2 files changed, 322 insertions(+), 1 deletion(-)
>>
>>   create mode 100644 Documentation/translations/zh_CN/dev-tools/kcsan.rst
>>
>> diff --git a/Documentation/translations/zh_CN/dev-tools/index.rst b/Documentation/translations/zh_CN/dev-tools/index.rst
>>
>> index c540e4a7d5db..6a8c637c0be1 100644
>>
>> --- a/Documentation/translations/zh_CN/dev-tools/index.rst
>>
>> +++ b/Documentation/translations/zh_CN/dev-tools/index.rst
>>
>> @@ -21,6 +21,7 @@ Documentation/translations/zh_CN/dev-tools/testing-overview.rst
>>
>>   testing-overview
>>
>>   sparse
>>
>>   kcov
>>
>> + kcsan
>>
>>   gcov
>>
>>   kasan
>>
>>   ubsan
>>
>> @@ -32,7 +33,6 @@ Todolist:
>>
>>   - checkpatch
>>
>>   - coccinelle
>>
>>   - kmsan
>>
>> - - kcsan
>>
>>   - kfence
>>
>>   - kgdb
>>
>>   - kselftest
>>
>> diff --git a/Documentation/translations/zh_CN/dev-tools/kcsan.rst b/Documentation/translations/zh_CN/dev-tools/kcsan.rst
>>
>> new file mode 100644
>>
>> index 000000000000..39fa43d8c414
>>
>> --- /dev/null
>>
>> +++ b/Documentation/translations/zh_CN/dev-tools/kcsan.rst
>>
>> @@ -0,0 +1,321 @@
>>
>> +.. SPDX-License-Identifier: GPL-2.0
>>
>> +
>>
>> +.. include:: ../disclaimer-zh_CN.rst
>>
>> +
>>
>> +:Original: Documentation/dev-tools/kcsan.rst
>>
>> +:Translator: 刘浩阳 Haoyang Liu <tttturtleruss@hust.edu.cn>
>>
>> +
>>
>> +内核并发消毒剂(KCSAN)
>>
>> +=====================
>>
>> +
>>
>> +内核并发消毒剂（KCSAN）是一个动态竞争检测器，依赖编译时插桩，并且使用基于观察
>>
>> +点的采样方法来检测竞争。KCSAN 的主要目的是检测 `数据竞争`_。
>>
>> +
>>
>> +使用
>>
>> +----
>>
>> +
>>
>> +KCSAN 受 GCC 和 Clang 支持。使用 GCC 需要版本 11 或更高，使用 Clang 也需要
>>
>> +版本 11 或更高。
>>
>> +
>>
>> +为了启用 KCSAN，用如下参数配置内核::
>>
>> +
>>
>> + CONFIG_KCSAN = y
>>
>> +
>>
>> +KCSAN 提供了几个其他的配置选项来自定义行为（见 ``lib/Kconfig.kcsan`` 中的各自的
>>
>> +帮助文档以获取更多信息）。
>>
>> +
>>
>> +错误报告
>>
>> +~~~~~~~~
>>
>> +
>>
>> +一个典型数据竞争的报告如下所示::
>>
>> +
>>
>> + ==================================================================
>>
>> + BUG: KCSAN: data-race in test_kernel_read / test_kernel_write
>>
>> +
>>
>> + write to 0xffffffffc009a628 of 8 bytes by task 487 on cpu 0:
>>
>> + test_kernel_write+0x1d/0x30
>>
>> + access_thread+0x89/0xd0
>>
>> + kthread+0x23e/0x260
>>
>> + ret_from_fork+0x22/0x30
>>
>> +
>>
>> + read to 0xffffffffc009a628 of 8 bytes by task 488 on cpu 6:
>>
>> + test_kernel_read+0x10/0x20
>>
>> + access_thread+0x89/0xd0
>>
>> + kthread+0x23e/0x260
>>
>> + ret_from_fork+0x22/0x30
>>
>> +
>>
>> + value changed: 0x00000000000009a6 -> 0x00000000000009b2
>>
>> +
>>
>> + Reported by Kernel Concurrency Sanitizer on:
>>
>> + CPU: 6 PID: 488 Comm: access_thread Not tainted 5.12.0-rc2+ #1
>>
>> + Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-2 04/01/2014
>>
>> + ==================================================================
>>
>> +
>>
>> +报告的头部提供了一个关于竞争中涉及到的函数的简短总结。随后是竞争中的两个线程的
>>
>> +访问类型和堆栈信息。如果 KCSAN 发现了一个值的变化，那么那个值的旧值和新值会在
>>
>> +“value changed”这一行单独显示。
>>
>> +
>>
>> +另一个不太常见的数据竞争类型的报告如下所示::
>>
>> +
>>
>> + ==================================================================
>>
>> + BUG: KCSAN: data-race in test_kernel_rmw_array+0x71/0xd0
>>
>> +
>>
>> + race at unknown origin, with read to 0xffffffffc009bdb0 of 8 bytes by task 515 on cpu 2:
>>
>> + test_kernel_rmw_array+0x71/0xd0
>>
>> + access_thread+0x89/0xd0
>>
>> + kthread+0x23e/0x260
>>
>> + ret_from_fork+0x22/0x30
>>
>> +
>>
>> + value changed: 0x0000000000002328 -> 0x0000000000002329
>>
>> +
>>
>> + Reported by Kernel Concurrency Sanitizer on:
>>
>> + CPU: 2 PID: 515 Comm: access_thread Not tainted 5.12.0-rc2+ #1
>>
>> + Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-2 04/01/2014
>>
>> + ==================================================================
>>
>> +
>>
>> +这个报告是当另一个竞争线程不可能被发现，但是可以从观测的内存地址的值改变而推断
>>
>> +出来的时候生成的。这类报告总是会带有“value changed”行。这类报告的出现通常是因
>>
>> +为在竞争线程中缺少插桩，也可能是因为其他原因，比如 DMA 访问。这类报告只会在
>>
>> +设置了内核参数 ``CONFIG_KCSAN_REPORT_RACE_UNKNOWN_ORIGIN=y`` 时才会出现，而这
>>
>> +个参数是默认启用的。
>>
>> +
>>
>> +选择性分析
>>
>> +~~~~~~~~~~
>>
>> +
>>
>> +对于一些特定的访问，函数，编译单元或者整个子系统，可能需要禁用数据竞争检测。
>>
>> +对于静态黑名单，有如下可用的参数：
>>
>> +
>>
>> +* KCSAN 支持使用 ``data_race(expr)`` 注解，这个注解告诉 KCSAN 任何由访问
>>
>> + ``expr`` 所引起的数据竞争都应该被忽略，其产生的行为后果被认为是安全的。请查阅
>>
>> + `"Marking Shared-Memory Accesses" in the LKMM`_ 获得更多信息。
>>
>> +
>>
>> +* 与 ``data_race(...)`` 相似，可以使用类型限定符 ``__data_racy`` 来标记一个变量
>>
>> + ，所有访问该变量而导致的数据竞争都是故意为之并且应该被 KCSAN 忽略::
>>
>> +
>>
>> + struct foo {
>>
>> + ...
>>
>> + int __data_racy stats_counter;
>>
>> + ...
>>
>> + };
>>
>> +
>>
>> +* 使用函数属性 ``__no_kcsan`` 可以对整个函数禁用数据竞争检测::
>>
>> +
>>
>> + __no_kcsan
>>
>> + void foo(void) {
>>
>> + ...
>>
>> +
>>
>> + 为了动态限制该为哪些函数生成报告，查阅 `Debug 文件系统接口`_ 黑名单/白名单特性。
>>
>> +
>>
>> +* 为特定的编译单元禁用数据竞争检测，将下列参数加入到 ``Makefile`` 中::
>>
>> +
>>
>> + KCSAN_SANITIZE_file.o := n
>>
>> +
>>
>> +* 为 ``Makefile`` 中的所有编译单元禁用数据竞争检测，将下列参数添加到相应的
>>
>> + ``Makefile`` 中::
>>
>> +
>>
>> + KCSAN_SANITIZE := n
>>
>> +
>>
>> +.. _"Marking Shared-Memory Accesses" in the LKMM: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/memory-model/Documentation/access-marking.txt
>>
>> +
>>
>> +此外，KCSAN 可以根据偏好设置显示或隐藏整个类别的数据竞争。可以使用如下
>>
>> +Kconfig 参数进行更改:
>>
>> +
>>
>> +* ``CONFIG_KCSAN_REPORT_VALUE_CHANGE_ONLY``: 如果启用了该参数并且通过观测点
>>
>> + (watchpoint) 观测到一个有冲突的写操作，但是对应的内存地址中存储的值没有改变，
>>
>> + 则不会报告这起数据竞争。
>>
>> +
>>
>> +* ``CONFIG_KCSAN_ASSUME_PLAIN_WRITES_ATOMIC``: 假设默认情况下，不超过字大小的简
>>
>> + 单对齐写入操作是原子的。假设这些写入操作不会受到不安全的编译器优化影响，从而导
>>
>> + 致数据竞争。该选项使 KCSAN 不报告仅由不超过字大小的简单对齐写入操作引起
>>
>> + 的冲突所导致的数据竞争。
>>
>> +
>>
>> +* ``CONFIG_KCSAN_PERMISSIVE``: 启用额外的宽松规则来忽略某些常见类型的数据竞争。
>>
>> + 与上面的规则不同，这条规则更加复杂，涉及到值改变模式，访问类型和地址。这个
>>
>> + 选项依赖编译选项 ``CONFIG_KCSAN_REPORT_VALUE_CHANGE_ONLY=y``。请查看
>>
>> + ``kernel/kcsan/permissive.h`` 获取更多细节。对于只侧重于特定子系统而不是整个
>>
>> + 内核报告的测试者和维护者，建议禁用该选项。
>>
>> +
>>
>> +要使用尽可能严格的规则，选择 ``CONFIG_KCSAN_STRICT=y``，这将配置 KCSAN 尽可
>>
>> +能紧密地遵循 Linux 内核内存一致性模型（LKMM）。
>>
>> +
>>
>> +Debug 文件系统接口
>>
>> +~~~~~~~~~~~~~~~~~~
>>
>> +
>>
>> +文件 ``/sys/kernel/debug/kcsan`` 提供了如下接口：
>>
>> +
>>
>> +* 读 ``/sys/kernel/debug/kcsan`` 返回不同的运行时统计数据。
>>
>> +
>>
>> +* 将 ``on`` 或 ``off`` 写入 ``/sys/kernel/debug/kcsan`` 允许打开或关闭 KCSAN。
>>
>> +
>>
>> +* 将 ``!some_func_name`` 写入 ``/sys/kernel/debug/kcsan`` 会将
>>
>> + ``some_func_name`` 添加到报告过滤列表中，该列表（默认）会将数据竞争报告中的顶
>>
>> + 层堆栈帧是列表中函数的情况列入黑名单。
>>
>> +
>>
>> +* 将 ``blacklist`` 或 ``whitelist`` 写入 ``/sys/kernel/debug/kcsan`` 会改变报告
>>
>> + 过滤行为。例如，黑名单的特性可以用来过滤掉经常发生的数据竞争。白名单特性可以帮
>>
>> + 助复现和修复测试。
>>
>> +
>>
>> +性能调优
>>
>> +~~~~~~~~
>>
>> +
>>
>> +影响 KCSAN 整体的性能和 bug 检测能力的核心参数是作为内核命令行参数公开的，其默认
>>
>> +值也可以通过相应的 Kconfig 选项更改。
>>
>> +
>>
>> +* ``kcsan.skip_watch`` (``CONFIG_KCSAN_SKIP_WATCH``): 在另一个观测点设置之前每
>>
>> + 个 CPU 要跳过的内存操作次数。更加频繁的设置观测点将增加观察到竞争情况的可能性
>>
>> + 。这个参数对系统整体的性能和竞争检测能力影响最显著。
>>
>> +
>>
>> +* ``kcsan.udelay_task`` (``CONFIG_KCSAN_UDELAY_TASK``): 对于任务，观测点设置之
>>
>> + 后暂停执行的微秒延迟。值越大，检测到竞争情况的可能性越高。
>>
>> +
>>
>> +* ``kcsan.udelay_interrupt`` (``CONFIG_KCSAN_UDELAY_INTERRUPT``): 对于中断，
>>
>> + 观测点设置之后暂停执行的微秒延迟。中断对于延迟的要求更加严格，其延迟通常应该小
>>
>> + 于为任务选择的延迟。
>>
>> +
>>
>> +它们可以通过 ``/sys/module/kcsan/parameters/`` 在运行时进行调整。
>>
>> +
>>
>> +数据竞争
>>
>> +--------
>>
>> +
>>
>> +在一次执行中，如果两个内存访问存在 *冲突*，在不同的线程中并发执行，并且至少
>>
>> +有一个访问是 *简单访问*，则它们就形成了 *数据竞争*。如果它们访问了同一个内存地址并且
>>
>> +至少有一个是写操作，则称它们存在 *冲突*。有关更详细的讨论和定义，见
>> +`"Plain Accesses and Data Races" in the LKMM`_。
>>
>> +
>>
>> +.. _"Plain Accesses and Data Races" in the LKMM:
> Sorry for the delay for so long, how about
> translating it into Chinese as well?

Sure.


Thanks,

Haoyang

>   
>
>
> Thanks,
> Yanteng


