Return-Path: <linux-kernel+bounces-377431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A1199ABEBA
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 08:29:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEAD81F24C49
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 06:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 758FB149C4A;
	Wed, 23 Oct 2024 06:29:17 +0000 (UTC)
Received: from zg8tmja2lje4os43os4xodqa.icoremail.net (zg8tmja2lje4os43os4xodqa.icoremail.net [206.189.79.184])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4E1E143C40;
	Wed, 23 Oct 2024 06:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.79.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729664957; cv=none; b=YlmHjtgn1LhE62zdwXLwN7wVI91N+V2ZTDXVaGTweYn+evKVN1sMrscE+mLY6HVcVvE7rfnZcVwFkykVrXRPG+AEGuCRM4mJXZVfi/nxyDrSFFqY/u3hlKXFXByDN6UQSG2f38HQjtnT1GCWf4WV0OyNQJT++GWsoQjtvriZiDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729664957; c=relaxed/simple;
	bh=dFSfjS4h9tPuzdzt1M5XnfRjvYg3CJK+vpEt2AYf+iE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=B49QUqQ+zYXlGCfo+UxUkPbWXvcb8diHBY41ZbvGOJ9w+JVkWij/L672ZjR+Pq286yPinOttoTFmn4LRLZBRpjnXoSUf6pdhBP9chuFM7clntwy0jyce9a4JNjyeFVvWomqFkVMBZSQ9RfP0EA0r5QNOIDpoR5DWh0aiVAWqZMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn; spf=pass smtp.mailfrom=hust.edu.cn; arc=none smtp.client-ip=206.189.79.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hust.edu.cn
Received: from hust.edu.cn (unknown [172.16.0.50])
	by app1 (Coremail) with SMTP id HgEQrADXNmxzlxhnAiR0CA--.20999S2;
	Wed, 23 Oct 2024 14:28:03 +0800 (CST)
Received: from pride-PowerEdge-R740.. (unknown [222.20.126.129])
	by gateway (Coremail) with SMTP id _____wDnEUBrlxhnRB6WAA--.64686S2;
	Wed, 23 Oct 2024 14:27:57 +0800 (CST)
From: Dongliang Mu <dzm91@hust.edu.cn>
To: si.yanteng@linux.dev,
	Alex Shi <alexs@kernel.org>,
	Yanteng Si <siyanteng@loongson.cn>,
	Jonathan Corbet <corbet@lwn.net>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Dongliang Mu <dzm91@hust.edu.cn>
Cc: hust-os-kernel-patches@googlegroups.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH v3] docs/zh_CN: update the translation of process/programming-language.rst
Date: Wed, 23 Oct 2024 14:27:43 +0800
Message-ID: <20241023062750.849951-1-dzm91@hust.edu.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:HgEQrADXNmxzlxhnAiR0CA--.20999S2
Authentication-Results: app1; spf=neutral smtp.mail=dzm91@hust.edu.cn;
X-Coremail-Antispam: 1UD129KBjvJXoW3WrW3Gw18WF1rCF4fZr43ZFb_yoW7tw13pF
	W7Kr9rKa18J3WxCrZ7Kr12vr1FkFs5Ka48trWUt3WYyF40ya9IqFyxKr43J342vryxuFWD
	Zw1fuFW0q3y3Aa7anT9S1TB71UUUU1UqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUHmb7Iv0xC_Zr1lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
	cIk0rVWrJVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjx
	v20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK
	6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1ln4kS14v26r
	1q6r43M2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI
	12xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj64x0Y40En7xvr7AKxV
	W8Jr0_Cr1UMcIj6x8ErcxFaVAv8VW8uFyUJr1UMcIj6xkF7I0En7xvr7AKxVW8Jr0_Cr1U
	McvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY1x0262kKe7AKxVW8ZVWrXw
	CF04k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv6cx26r4fZr1UJr1l4I8I3I0E4IkC6x0Y
	z7v_Jr0_Gr1l4IxYO2xFxVAFwI0_Jw0_GFylx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYY7kG6IIYr7AKxVW8JVW5
	JwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU5
	2eHPUUUUU==
X-CM-SenderInfo: asqsiiirqrkko6kx23oohg3hdfq/

Update to commit 0b02076f9953 ("docs: programming-language: add Rust
programming language section")

scripts/checktransupdate.py reports:

Documentation/translations/zh_CN/process/programming-language.rst
commit 0b02076f9953 ("docs: programming-language: add Rust programming
language section")
commit 38484a1d0c50 ("docs: programming-language: remove mention of the
Intel compiler")
2 commits needs resolving in total

Signed-off-by: Dongliang Mu <dzm91@hust.edu.cn>
---
v2->v3: fix warnings in the make htmldocs
v1->v2: revise the script name
 .../zh_CN/process/programming-language.rst    | 78 +++++++------------
 1 file changed, 30 insertions(+), 48 deletions(-)

diff --git a/Documentation/translations/zh_CN/process/programming-language.rst b/Documentation/translations/zh_CN/process/programming-language.rst
index fabdc338dbfb..95aa4829d78f 100644
--- a/Documentation/translations/zh_CN/process/programming-language.rst
+++ b/Documentation/translations/zh_CN/process/programming-language.rst
@@ -3,25 +3,22 @@
 :Original: :ref:`Documentation/process/programming-language.rst <programming_language>`
 :Translator: Alex Shi <alex.shi@linux.alibaba.com>
 
-.. _cn_programming_language:
-
 程序设计语言
 ============
 
-内核是用C语言 :ref:`c-language <cn_c-language>` 编写的。更准确地说，内核通常是用 :ref:`gcc <cn_gcc>`
-在 ``-std=gnu11`` :ref:`gcc-c-dialect-options <cn_gcc-c-dialect-options>` 下编译的：ISO C11的 GNU 方言
-
-这种方言包含对语言 :ref:`gnu-extensions <cn_gnu-extensions>` 的许多扩展，当然，它们许多都在内核中使用。
+内核是用 C 编程语言编写的 [zh_cn_c-language]_。更准确地说，内核通常使用 ``gcc`` [zh_cn_gcc]_ 编译，
+并且使用 ``-std=gnu11`` [zh_cn_gcc-c-dialect-options]_：这是 ISO C11 的 GNU 方言。
+``clang`` [zh_cn_clang]_ 也得到了支持，详见文档：
+:ref:`使用 Clang/LLVM 构建 Linux <kbuild_llvm>`。
 
-对于一些体系结构，有一些使用 :ref:`clang <cn_clang>` 和 :ref:`icc <cn_icc>` 编译内核
-的支持，尽管在编写此文档时还没有完成，仍需要第三方补丁。
+这种方言包含对 C 语言的许多扩展 [zh_cn_gnu-extensions]_，当然，它们许多都在内核中使用。
 
 属性
 ----
 
-在整个内核中使用的一个常见扩展是属性（attributes） :ref:`gcc-attribute-syntax <cn_gcc-attribute-syntax>`
+在整个内核中使用的一个常见扩展是属性（attributes） [zh_cn_gcc-attribute-syntax]_。
 属性允许将实现定义的语义引入语言实体（如变量、函数或类型），而无需对语言进行
-重大的语法更改（例如添加新关键字） :ref:`n2049 <cn_n2049>`
+重大的语法更改（例如添加新关键字） [zh_cn_n2049]_。
 
 在某些情况下，属性是可选的（即不支持这些属性的编译器仍然应该生成正确的代码，
 即使其速度较慢或执行的编译时检查/诊断次数不够）
@@ -30,42 +27,27 @@
 ``__attribute__((__pure__))`` ），以检测可以使用哪些关键字和/或缩短代码, 具体
 请参阅 ``include/linux/compiler_attributes.h``
 
-.. _cn_c-language:
-
-c-language
-   http://www.open-std.org/jtc1/sc22/wg14/www/standards
-
-.. _cn_gcc:
-
-gcc
-   https://gcc.gnu.org
-
-.. _cn_clang:
-
-clang
-   https://clang.llvm.org
-
-.. _cn_icc:
-
-icc
-   https://software.intel.com/en-us/c-compilers
-
-.. _cn_gcc-c-dialect-options:
-
-c-dialect-options
-   https://gcc.gnu.org/onlinedocs/gcc/C-Dialect-Options.html
-
-.. _cn_gnu-extensions:
-
-gnu-extensions
-   https://gcc.gnu.org/onlinedocs/gcc/C-Extensions.html
-
-.. _cn_gcc-attribute-syntax:
-
-gcc-attribute-syntax
-   https://gcc.gnu.org/onlinedocs/gcc/Attribute-Syntax.html
-
-.. _cn_n2049:
+Rust
+----
 
-n2049
-   http://www.open-std.org/jtc1/sc22/wg14/www/docs/n2049.pdf
+内核对 Rust 编程语言 [zh_cn_rust-language]_ 的支持是实验性的，并且可以通过配置选项
+``CONFIG_RUST`` 来启用。Rust 代码使用 ``rustc`` [zh_cn_rustc]_ 编译器在
+``--edition=2021`` [zh_cn_rust-editions]_ 选项下进行编译。版本（Editions）是一种
+在语言中引入非后向兼容的小型变更的方式。
+
+除此之外，内核中还使用了一些不稳定的特性 [zh_cn_rust-unstable-features]_。这些不稳定
+的特性将来可能会发生变化，因此，一个重要的目标是达到仅使用稳定特性的程度。
+
+具体请参阅 Documentation/rust/index.rst
+
+.. [zh_cn_c-language] http://www.open-std.org/jtc1/sc22/wg14/www/standards
+.. [zh_cn_gcc] https://gcc.gnu.org
+.. [zh_cn_clang] https://clang.llvm.org
+.. [zh_cn_gcc-c-dialect-options] https://gcc.gnu.org/onlinedocs/gcc/C-Dialect-Options.html
+.. [zh_cn_gnu-extensions] https://gcc.gnu.org/onlinedocs/gcc/C-Extensions.html
+.. [zh_cn_gcc-attribute-syntax] https://gcc.gnu.org/onlinedocs/gcc/Attribute-Syntax.html
+.. [zh_cn_n2049] http://www.open-std.org/jtc1/sc22/wg14/www/docs/n2049.pdf
+.. [zh_cn_rust-language] https://www.rust-lang.org
+.. [zh_cn_rustc] https://doc.rust-lang.org/rustc/
+.. [zh_cn_rust-editions] https://doc.rust-lang.org/edition-guide/editions/
+.. [zh_cn_rust-unstable-features] https://github.com/Rust-for-Linux/linux/issues/2
-- 
2.43.0


