Return-Path: <linux-kernel+bounces-379103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7661E9AD9F4
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 04:32:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 076581F227E6
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 02:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAB6E14A0A3;
	Thu, 24 Oct 2024 02:32:02 +0000 (UTC)
Received: from hust.edu.cn (mail.hust.edu.cn [202.114.0.240])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B97C15383A;
	Thu, 24 Oct 2024 02:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.114.0.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729737122; cv=none; b=Zvocton3FgsckHItganyROJlPBfyqJ6WBB2c6yid+UUhzwH7TeMu6reDlA4CzhxMHb5/XFjNwRxeEn9rpqVNUK36CEHF5QfQc6BAIaNyixW8K5pUQqNHFkHQgeCM9M6o51OGicavP18hJHFUAOW9uJC4XWVr7yS77yvzzaquIfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729737122; c=relaxed/simple;
	bh=hnzWLeXrbkyQISAmKM5lV+4jV+erpVGdvE8PKeWtrZY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ul3cLF/jgv0cbkEDbch2PwP2cxHXERSRg0NP+7G77bcllV+l05vbUh9RHDRdke9WrJCRLnGapGC8Of6k05gW3S0vtcfZlwKLy7WdcFKWjfzSfKlGgW9R6MED/BtBi2GQ/jZ2Pm6y9khe+UvbDfU7cA/kKnaXgWvwPK/OLY6sXbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn; spf=pass smtp.mailfrom=hust.edu.cn; arc=none smtp.client-ip=202.114.0.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hust.edu.cn
Received: from hust.edu.cn (unknown [172.16.0.52])
	by app2 (Coremail) with SMTP id HwEQrAC3vc1hsRlnO_IkAQ--.30536S2;
	Thu, 24 Oct 2024 10:30:57 +0800 (CST)
Received: from [10.12.174.47] (unknown [10.12.174.47])
	by gateway (Coremail) with SMTP id _____wAnK81dsRln8RuNAA--.15442S2;
	Thu, 24 Oct 2024 10:30:55 +0800 (CST)
Message-ID: <345e8f10-fe1a-4736-9468-7c92ac55d62e@hust.edu.cn>
Date: Thu, 24 Oct 2024 10:30:53 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] docs/zh_CN: update the translation of
 process/programming-language.rst
To: Alex Shi <seakeel@gmail.com>, si.yanteng@linux.dev,
 Alex Shi <alexs@kernel.org>, Yanteng Si <siyanteng@loongson.cn>,
 Jonathan Corbet <corbet@lwn.net>, Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Cc: hust-os-kernel-patches@googlegroups.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 llvm@lists.linux.dev
References: <20241023062750.849951-1-dzm91@hust.edu.cn>
 <46e54088-ad96-4387-8a39-2e4686c842bd@gmail.com>
From: Dongliang Mu <dzm91@hust.edu.cn>
In-Reply-To: <46e54088-ad96-4387-8a39-2e4686c842bd@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:HwEQrAC3vc1hsRlnO_IkAQ--.30536S2
Authentication-Results: app2; spf=neutral smtp.mail=dzm91@hust.edu.cn;
X-Coremail-Antispam: 1UD129KBjvJXoW3AF4fXr47GrWxAFyDCrWruFg_yoWxCF15pF
	W7GasrKa18AFn7GrWfKr1UuF1Fkrs5ta18JrWUt3W5tr48ta90gFyxtr43W3y2yryxCFWk
	X3W3uFWkX3y5AFDanT9S1TB71UUUUbJqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUHab7Iv0xC_Cr1lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
	cIk0rVWrJVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjx
	v20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK
	6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1ln4kS14v26r
	1q6r43M2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI
	12xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj64x0Y40En7xvr7AKxV
	WxJVW8Jr1lYx0E74AGY7Cv6cx26r4fZr1UJr1lYx0Ec7CjxVAajcxG14v26r4UJVWxJr1l
	Ox8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxkF7I0En4kS14v26r4a6rW5MxAIw2
	8IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_GFW3Jr1UJwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwCFI7km07C267AKxVW8ZVWrXwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4
	vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkvb40EIxkG14v26r4j6ryUMIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWx
	JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU3wIDUU
	UUU
X-CM-SenderInfo: asqsiiirqrkko6kx23oohg3hdfq/


On 2024/10/24 10:21, Alex Shi wrote:
>
> On 10/23/24 14:27, Dongliang Mu wrote:
>> Update to commit 0b02076f9953 ("docs: programming-language: add Rust
>> programming language section")
>>
>> scripts/checktransupdate.py reports:
>>
>> Documentation/translations/zh_CN/process/programming-language.rst
>> commit 0b02076f9953 ("docs: programming-language: add Rust programming
>> language section")
>> commit 38484a1d0c50 ("docs: programming-language: remove mention of the
>> Intel compiler")
>> 2 commits needs resolving in total
>>
>> Signed-off-by: Dongliang Mu <dzm91@hust.edu.cn>
>> ---
>> v2->v3: fix warnings in the make htmldocs
>> v1->v2: revise the script name
>>   .../zh_CN/process/programming-language.rst    | 78 +++++++------------
>>   1 file changed, 30 insertions(+), 48 deletions(-)
>>
>> diff --git a/Documentation/translations/zh_CN/process/programming-language.rst b/Documentation/translations/zh_CN/process/programming-language.rst
>> index fabdc338dbfb..95aa4829d78f 100644
>> --- a/Documentation/translations/zh_CN/process/programming-language.rst
>> +++ b/Documentation/translations/zh_CN/process/programming-language.rst
>> @@ -3,25 +3,22 @@
>>   :Original: :ref:`Documentation/process/programming-language.rst <programming_language>`
>>   :Translator: Alex Shi <alex.shi@linux.alibaba.com>
>>   
>> -.. _cn_programming_language:
>> -
>>   程序设计语言
>>   ============
>>   
>> -内核是用C语言 :ref:`c-language <cn_c-language>` 编写的。更准确地说，内核通常是用 :ref:`gcc <cn_gcc>`
>> -在 ``-std=gnu11`` :ref:`gcc-c-dialect-options <cn_gcc-c-dialect-options>` 下编译的：ISO C11的 GNU 方言
>> -
>> -这种方言包含对语言 :ref:`gnu-extensions <cn_gnu-extensions>` 的许多扩展，当然，它们许多都在内核中使用。
>> +内核是用 C 编程语言编写的 [zh_cn_c-language]_。更准确地说，内核通常使用 ``gcc`` [zh_cn_gcc]_ 编译，
>> +并且使用 ``-std=gnu11`` [zh_cn_gcc-c-dialect-options]_：这是 ISO C11 的 GNU 方言。
>> +``clang`` [zh_cn_clang]_ 也得到了支持，详见文档：
>> +:ref:`使用 Clang/LLVM 构建 Linux <kbuild_llvm>`。
>>   
>> -对于一些体系结构，有一些使用 :ref:`clang <cn_clang>` 和 :ref:`icc <cn_icc>` 编译内核
>> -的支持，尽管在编写此文档时还没有完成，仍需要第三方补丁。
>> +这种方言包含对 C 语言的许多扩展 [zh_cn_gnu-extensions]_，当然，它们许多都在内核中使用。
>>   
>>   属性
>>   ----
>>   
>> -在整个内核中使用的一个常见扩展是属性（attributes） :ref:`gcc-attribute-syntax <cn_gcc-attribute-syntax>`
>> +在整个内核中使用的一个常见扩展是属性（attributes） [zh_cn_gcc-attribute-syntax]_。
>>   属性允许将实现定义的语义引入语言实体（如变量、函数或类型），而无需对语言进行
>> -重大的语法更改（例如添加新关键字） :ref:`n2049 <cn_n2049>`
>> +重大的语法更改（例如添加新关键字） [zh_cn_n2049]_。
>>   
>>   在某些情况下，属性是可选的（即不支持这些属性的编译器仍然应该生成正确的代码，
>>   即使其速度较慢或执行的编译时检查/诊断次数不够）
>> @@ -30,42 +27,27 @@
>>   ``__attribute__((__pure__))`` ），以检测可以使用哪些关键字和/或缩短代码, 具体
>>   请参阅 ``include/linux/compiler_attributes.h``
>>   
>> -.. _cn_c-language:
>> -
>> -c-language
>> -   http://www.open-std.org/jtc1/sc22/wg14/www/standards
>> -
>> -.. _cn_gcc:
>> -
>> -gcc
>> -   https://gcc.gnu.org
>> -
>> -.. _cn_clang:
>> -
>> -clang
>> -   https://clang.llvm.org
>> -
>> -.. _cn_icc:
>> -
>> -icc
>> -   https://software.intel.com/en-us/c-compilers
>> -
>> -.. _cn_gcc-c-dialect-options:
>> -
>> -c-dialect-options
>> -   https://gcc.gnu.org/onlinedocs/gcc/C-Dialect-Options.html
>> -
>> -.. _cn_gnu-extensions:
>> -
>> -gnu-extensions
>> -   https://gcc.gnu.org/onlinedocs/gcc/C-Extensions.html
>> -
>> -.. _cn_gcc-attribute-syntax:
>> -
>> -gcc-attribute-syntax
>> -   https://gcc.gnu.org/onlinedocs/gcc/Attribute-Syntax.html
>> -
>> -.. _cn_n2049:
>> +Rust
>> +----
>>   
>> -n2049
>> -   http://www.open-std.org/jtc1/sc22/wg14/www/docs/n2049.pdf
>> +内核对 Rust 编程语言 [zh_cn_rust-language]_ 的支持是实验性的，并且可以通过配置选项
>> +``CONFIG_RUST`` 来启用。Rust 代码使用 ``rustc`` [zh_cn_rustc]_ 编译器在
>> +``--edition=2021`` [zh_cn_rust-editions]_ 选项下进行编译。版本（Editions）是一种
>> +在语言中引入非后向兼容的小型变更的方式。
>> +
>> +除此之外，内核中还使用了一些不稳定的特性 [zh_cn_rust-unstable-features]_。这些不稳定
>> +的特性将来可能会发生变化，因此，一个重要的目标是达到仅使用稳定特性的程度。
>> +
>> +具体请参阅 Documentation/rust/index.rst
>> +
>> +.. [zh_cn_c-language] http://www.open-std.org/jtc1/sc22/wg14/www/standards
>> +.. [zh_cn_gcc] https://gcc.gnu.org
>> +.. [zh_cn_clang] https://clang.llvm.org
>> +.. [zh_cn_gcc-c-dialect-options] https://gcc.gnu.org/onlinedocs/gcc/C-Dialect-Options.html
>> +.. [zh_cn_gnu-extensions] https://gcc.gnu.org/onlinedocs/gcc/C-Extensions.html
>> +.. [zh_cn_gcc-attribute-syntax] https://gcc.gnu.org/onlinedocs/gcc/Attribute-Syntax.html
>> +.. [zh_cn_n2049] http://www.open-std.org/jtc1/sc22/wg14/www/docs/n2049.pdf
>> +.. [zh_cn_rust-language] https://www.rust-lang.org
>> +.. [zh_cn_rustc] https://doc.rust-lang.org/rustc/
>> +.. [zh_cn_rust-editions] https://doc.rust-lang.org/edition-guide/editions/
>> +.. [zh_cn_rust-unstable-features] https://github.com/Rust-for-Linux/linux/issues/2
> Hi Dongliang,
>
> Good job! Most of translation are good.
> Just the above doc seems still English version, give them a zh_cn name may cause misunderstand?

Oh, I see. However, you cannot use gcc or rustc since it already exists 
in the English documents. We need another name to make sphinx happy. 
Therefore, why do not we directly use the final version of name? :)

Correct me if I make any misunderstanding.

Dongliang Mu

>   
> Thanks


