Return-Path: <linux-kernel+bounces-395830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45E6B9BC3A0
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 04:09:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 690D71C21F94
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 03:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3A1315885E;
	Tue,  5 Nov 2024 03:08:34 +0000 (UTC)
Received: from hust.edu.cn (unknown [202.114.0.240])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46CD314F104;
	Tue,  5 Nov 2024 03:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.114.0.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730776114; cv=none; b=PQrCiuJHjkPEVJw9e+jA5K0Nj8sk4Uh6ev07LHVq/eXyr2G7thWBE2WUUhc1jTXkTlsAXsxc8DGmd6tEoLzkoMQDb1M5NahoJBBsIgeX0RAgHJDobvMyoL9/MB+kGKBa5fzoVEd14RZkJQiKCRI1InUBtw2+FzK4YD0A/diq5hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730776114; c=relaxed/simple;
	bh=9MexuOLJdjNx+M6TrmvbtoZScHLX2/pVon2MDOh/f2I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aB44RlgVhsJdPIIOh8EnjdvDrumLDmWEIzHcc/eEIrkWgyPvvCkL9Qyz/iY7kWx/jlgtgsKugj1lwFFDxGrSOoWkTOkZ7z9bnmj5faqJNWtCEbVnqYYwMv5C3ND32WxHzuALb0nrdYdnismYYGZDmnEz/9rNx5KOrW2oJWsfIbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn; spf=pass smtp.mailfrom=hust.edu.cn; arc=none smtp.client-ip=202.114.0.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hust.edu.cn
Received: from hust.edu.cn (unknown [172.16.0.50])
	by app1 (Coremail) with SMTP id HgEQrADHzn6biilnLPVnCQ--.12977S2;
	Tue, 05 Nov 2024 11:01:47 +0800 (CST)
Received: from [10.12.170.8] (unknown [10.12.170.8])
	by gateway (Coremail) with SMTP id _____wCHJvCZiilnY2YFAQ--.12665S2;
	Tue, 05 Nov 2024 11:01:46 +0800 (CST)
Message-ID: <fbd3db23-f89b-4868-b657-c36fcfe9f8b2@hust.edu.cn>
Date: Tue, 5 Nov 2024 11:01:45 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs/zh_CN: add the translation of kbuild/llvm.rst
To: Jinjie Ruan <ruanjinjie@huawei.com>, si.yanteng@linux.dev,
 Alex Shi <alexs@kernel.org>, Yanteng Si <siyanteng@loongson.cn>,
 Jonathan Corbet <corbet@lwn.net>, Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Cc: hust-os-kernel-patches@googlegroups.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 llvm@lists.linux.dev
References: <20241023153235.1291567-1-dzm91@hust.edu.cn>
 <d987b09d-985b-8d85-36e6-97ab4e8e222f@huawei.com>
From: Dongliang Mu <dzm91@hust.edu.cn>
In-Reply-To: <d987b09d-985b-8d85-36e6-97ab4e8e222f@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:HgEQrADHzn6biilnLPVnCQ--.12977S2
Authentication-Results: app1; spf=neutral smtp.mail=dzm91@hust.edu.cn;
X-Coremail-Antispam: 1UD129KBjvJXoW3Cr43XFyfGrW8ArWUAF1rCrg_yoWDZFyfpa
	97CFZ3Ka1qqry0yryI9F45uwnayr4vka48X3Z8ta40vrn2vFyDtw1UKr4rWasru3yxCryU
	Aw1fCF12yF17ArDanT9S1TB71UUUU1UqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUd0b7Iv0xC_Zr1lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
	cIk0rVWrJVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjx
	v20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK
	6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1ln4kS14v26r
	1q6r43M2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI
	12xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj64x0Y40En7xvr7AKxV
	W8Jr0_Cr1UMcIj6x8ErcxFaVAv8VW8uFyUJr1UMcIj6xkF7I0En7xvr7AKxVW8Jr0_Cr1U
	McvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCY1x0262kKe7AKxVWUtVW8ZwCF04
	k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv6cx26r4fZr1UJr1l4I8I3I0E4IkC6x0Yz7v_
	Jr0_Gr1l4IxYO2xFxVAFwI0_GFv_Wrylx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
	xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYY7kG6xAYrwCIccxYrVCIc48F
	wI0_Xr0_Ar1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjx
	v20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2
	jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0x
	ZFpf9x07b99akUUUUU=
X-CM-SenderInfo: asqsiiirqrkko6kx23oohg3hdfq/


On 2024/11/5 10:54, 'Jinjie Ruan' via HUST OS Kernel Contribution wrote:
>
> On 2024/10/23 23:32, Dongliang Mu wrote:
>> Finish the translation of kbuild/llvm.rst and move llvm from TODO
>> to the main body.
>>
>> Update to commit 145082ebfcf0 ("Documentation/llvm: turn make command
>> for ccache into code block")
>>
>> Signed-off-by: Dongliang Mu <dzm91@hust.edu.cn>
>> ---
>>   .../translations/zh_CN/kbuild/index.rst       |   3 +-
>>   .../translations/zh_CN/kbuild/llvm.rst        | 203 ++++++++++++++++++
>>   2 files changed, 205 insertions(+), 1 deletion(-)
>>   create mode 100644 Documentation/translations/zh_CN/kbuild/llvm.rst
>>
>> diff --git a/Documentation/translations/zh_CN/kbuild/index.rst b/Documentation/translations/zh_CN/kbuild/index.rst
>> index 0ba96aecb13a..3f9ab52fa5bb 100644
>> --- a/Documentation/translations/zh_CN/kbuild/index.rst
>> +++ b/Documentation/translations/zh_CN/kbuild/index.rst
>> @@ -17,6 +17,7 @@
>>       gcc-plugins
>>       kbuild
>>       reproducible-builds
>> +    llvm
>>   
>>   TODO:
>>   
>> @@ -25,7 +26,7 @@ TODO:
>>   - makefiles
>>   - modules
>>   - issues
>> -- llvm
>> +
>>   
>>   .. only::  subproject and html
>>   
>> diff --git a/Documentation/translations/zh_CN/kbuild/llvm.rst b/Documentation/translations/zh_CN/kbuild/llvm.rst
>> new file mode 100644
>> index 000000000000..f71092144a26
>> --- /dev/null
>> +++ b/Documentation/translations/zh_CN/kbuild/llvm.rst
>> @@ -0,0 +1,203 @@
>> +.. SPDX-License-Identifier: GPL-2.0
>> +
>> +.. include:: ../disclaimer-zh_CN.rst
>> +
>> +:Original: Documentation/kbuild/llvm.rst
>> +:Translator: 慕冬亮 Dongliang Mu <dzm91@hust.edu.cn>
>> +
>> +==========================
>> +使用 Clang/LLVM 构建 Linux
>> +==========================
>> +
>> +本文档介绍如何使用 Clang 和 LLVM 工具构建 Linux 内核。
>> +
>> +关于
>> +----
>> +
>> +Linux 内核传统上一直使用 GNU 工具链（如 GCC 和 binutils）进行编译。持续的工作使得
>> +`Clang <https://clang.llvm.org/>`_ 和 `LLVM <https://llvm.org/>`_ 工具可
>> +作为可行的替代品。一些发行版，如 `Android <https://www.android.com/>`_、
>> +`ChromeOS <https://www.chromium.org/chromium-os>`_、`OpenMandriva
>> +<https://www.openmandriva.org/>`_ 和 `Chimera Linux
>> +<https://chimera-linux.org/>`_ 使用 Clang 编译的内核。谷歌和 Meta 的数据中心
>> +集群也运行由 Clang 编译的内核。
>> +
>> +`LLVM 是由 C++ 对象实现的工具链组件集合 <https://www.aosabook.org/en/llvm.html>`_。
>> +Clang 是 LLVM 的前端，支持 C 语言和内核所需的 GNU C 扩展，其发音为 "klang"，而非
>> +"see-lang"。
>> +
>> +使用 LLVM 构建
>> +--------------
>> +
>> +通过以下命令调用 ``make``::
>> +
>> +	make LLVM=1
>> +
>> +为主机目标进行编译。对于交叉编译::
>> +
>> +	make LLVM=1 ARCH=arm64
>> +
>> +LLVM= 参数
>> +----------
>> +
>> +LLVM 有 GNU binutils 工具的替代品。这些工具可以单独启用。以下是支持的 make 变量
>> +完整列表::
>> +
>> +	make CC=clang LD=ld.lld AR=llvm-ar NM=llvm-nm STRIP=llvm-strip \
>> +	  OBJCOPY=llvm-objcopy OBJDUMP=llvm-objdump READELF=llvm-readelf \
>> +	  HOSTCC=clang HOSTCXX=clang++ HOSTAR=llvm-ar HOSTLD=ld.lld
>> +
>> +``LLVM=1`` 扩展为上述命令。
>> +
>> +如果你的 LLVM 工具不在 PATH 中，你可以使用以斜杠结尾的 LLVM 变量提供它们的位置::
>> +
>> +	make LLVM=/path/to/llvm/
>> +
>> +这将使用 ``/path/to/llvm/clang``、``/path/to/llvm/ld.lld`` 等工具。也可以
>> +使用以下命令::
>> +
>> +	PATH=/path/to/llvm:$PATH make LLVM=1
>> +
>> +如果你的 LLVM 工具带有版本后缀，并且你希望测试该特定版本而非无后缀的可执行文件，
>> +类似于 ``LLVM=1``，你可以使用 ``LLVM`` 变量传递该后缀::
>> +
>> +	make LLVM=-14
>> +
>> +这将使用 ``clang-14``、``ld.lld-14`` 等工具。为了支持带有版本后缀的树外路径组合，
>> +我们建议::
>> +
>> +	PATH=/path/to/llvm/:$PATH make LLVM=-14
>> +
>> +``LLVM=0`` 与省略 ``LLVM`` 完全不同，它将表现得像 ``LLVM=1``。如果你只希望使用
>> +某些 LLVM 工具，请使用它们各自的 make 变量。
>> +
>> +在通过不同命令配置和构建时，应为每次调用 ``make`` 设置相同的 ``LLVM=`` 值。如果
>> +运行的脚本最终会调用 ``make``，则还应将 ``LLVM=`` 设置为环境变量。
>> +
>> +交叉编译
>> +--------
>> +
>> +单个 Clang 编译器二进制文件（及其对应的 LLVM 工具）通常会包含所有支持的后端，这可以
>> +简化交叉编译，尤其是使用 ``LLVM=1`` 时。如果仅使用 LLVM 工具，``CROSS_COMPILE``
>> +或目标三元组前缀就变得不必要。示例::
>> +
>> +	make LLVM=1 ARCH=arm64
>> +
>> +作为混合 LLVM 和 GNU 工具的示例，对于像 ``ARCH=s390`` 这样目前尚不支持
>> +``ld.lld`` 或 ``llvm-objcopy`` 的目标，你可以通过以下方式调用 ``make``::
>> +
>> +	make LLVM=1 ARCH=s390 LD=s390x-linux-gnu-ld.bfd \
>> +	  OBJCOPY=s390x-linux-gnu-objcopy
>> +
>> +此示例将调用 ``s390x-linux-gnu-ld.bfd`` 作为链接器和
>> +``s390x-linux-gnu-objcopy``，因此请确保它们在你的 ``$PATH`` 中。
>> +
>> +当 ``LLVM=1`` 未设置时，``CROSS_COMPILE`` 不会用于给 Clang 编译器二进制文件
>> +（或相应的 LLVM 工具）添加前缀，而 GNU 工具则需要这样做。
>> +
>> +LLVM_IAS= 参数
>> +--------------
>> +
>> +Clang 可以编译汇编代码。你可以传递 ``LLVM_IAS=0`` 禁用此行为，使 Clang 调用
>> +相应的非集成汇编器。示例::
>> +
>> +	make LLVM=1 LLVM_IAS=0
>> +
>> +在交叉编译时，你需要使用 ``CROSS_COMPILE`` 与 ``LLVM_IAS=0``，从而设置
>> +``--prefix=`` 使得编译器可以对应的非集成汇编器（通常，在面向另一种架构时，
>> +你不想使用系统汇编器）。例如::
>> +
>> +	make LLVM=1 ARCH=arm LLVM_IAS=0 CROSS_COMPILE=arm-linux-gnueabi-
>> +
>> +Ccache
>> +------
>> +
>> +``ccache`` 可以与 ``clang`` 一起使用，以改善后续构建（尽管在不同构建之间
>> +KBUILD_BUILD_TIMESTAMP_ 应设置为同一确定值，以避免 100% 的缓存未命中，
>> +详见 Reproducible_builds_ 获取更多信息）::
>> +
>> +	KBUILD_BUILD_TIMESTAMP='' make LLVM=1 CC="ccache clang"
>> +
>> +.. _KBUILD_BUILD_TIMESTAMP: kbuild.html#kbuild-build-timestamp
>> +.. _Reproducible_builds: reproducible-builds.html#timestamps
>> +
>> +支持的架构
>> +----------
>> +
>> +LLVM 并不支持 Linux 内核所有可支持的架构，同样，即使 LLVM 支持某一架构，也并不意味着在
>> +该架构下内核可以正常构建或工作。以下是当前 ``CC=clang`` 或 ``LLVM=1`` 支持的架构总结。
>> +支持级别对应于 MAINTAINERS 文件中的 "S" 值。如果某个架构未列出，则表示 LLVM 不支持它
>> +或存在已知问题。使用最新的稳定版 LLVM 或甚至开发版本通常会得到最佳结果。一个架构的
>> +``defconfig`` 通常预期能够良好工作，但某些配置可能存在尚未发现的问题。欢迎在以下
>> +问题跟踪器中提交错误报告！
>> +
>> +.. list-table::
>> +   :widths: 10 10 10
>> +   :header-rows: 1
>> +
>> +   * - 架构
>> +     - 支持级别
>> +     - ``make`` 命令
>> +   * - arm
>> +     - 支持
>> +     - ``LLVM=1``
>> +   * - arm64
>> +     - 支持
>> +     - ``LLVM=1``
>> +   * - hexagon
>> +     - 维护
>> +     - ``LLVM=1``
>> +   * - loongarch
>> +     - 维护
>> +     - ``LLVM=1``
>> +   * - mips
>> +     - 维护
>> +     - ``LLVM=1``
>> +   * - powerpc
>> +     - 维护
>> +     - ``LLVM=1``
>> +   * - riscv
>> +     - 支持
>> +     - ``LLVM=1``
>> +   * - s390
>> +     - 维护
>> +     - ``LLVM=1`` （LLVM >= 18.1.0），``CC=clang`` （LLVM < 18.1.0）
>> +   * - um (用户模式)
>> +     - 维护
>> +     - ``LLVM=1``
>> +   * - x86
>> +     - 支持
>> +     - ``LLVM=1``
>> +
>> +获取帮助
>> +--------
>> +
>> +- `网站 <https://clangbuiltlinux.github.io/>`_
>> +- `邮件列表 <https://lore.kernel.org/llvm/>`_: <llvm@lists.linux.dev>
>> +- `旧邮件列表档案 <https://groups.google.com/g/clang-built-linux>`_
>> +- `问题跟踪器 <https://github.com/ClangBuiltLinux/linux/issues>`_
>> +- IRC: #clangbuiltlinux 在 irc.libera.chat
>> +- `Telegram <https://t.me/ClangBuiltLinux>`_: @ClangBuiltLinux
>> +- `维基 <https://github.com/ClangBuiltLinux/linux/wiki>`_
>> +- `初学者问题 <https://github.com/ClangBuiltLinux/linux/issues?q=is%3Aopen+is%3Aissue+label%3A%22good+first+issue%22>`_
>> +
>> +.. _zh_cn_getting_llvm:
>> +
>> +获取 LLVM
>> +---------
>> +
>> +我们在 `kernel.org <https://kernel.org/pub/tools/llvm/>`_ 提供预编译的稳定版 LLVM。
>> +这些版本已经针对 Linux 内核构建，使用配置文件数据进行优化。相较于其他发行版中的 LLVM，它们应该
>> +能提高内核构建时间。
> ^^^^^^^^^^^^^^^^^^^^^^
>
> It doesn't match the meaning of the original text.
>
> may be "减少/改进内核构建时间" or "提高内核构建效率".

确实，个人倾向于使用意译，改成 “提高内核构建效率”。

我尽快提交一个 patch 来修改。

>
>> +
>> +以下是一些有助于从源代码构建 LLVM 或通过发行版的包管理器获取 LLVM 的链接。
>> +
>> +- https://releases.llvm.org/download.html
>> +- https://github.com/llvm/llvm-project
>> +- https://llvm.org/docs/GettingStarted.html
>> +- https://llvm.org/docs/CMake.html
>> +- https://apt.llvm.org/
>> +- https://www.archlinux.org/packages/extra/x86_64/llvm/
>> +- https://github.com/ClangBuiltLinux/tc-build
>> +- https://github.com/ClangBuiltLinux/linux/wiki/Building-Clang-from-source
>> +- https://android.googlesource.com/platform/prebuilts/clang/host/linux-x86/


