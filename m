Return-Path: <linux-kernel+bounces-368101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2874C9A0B32
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 15:18:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A55B1C21F1C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 13:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E31DE208D7A;
	Wed, 16 Oct 2024 13:18:02 +0000 (UTC)
Received: from zg8tmja2lje4os43os4xodqa.icoremail.net (zg8tmja2lje4os43os4xodqa.icoremail.net [206.189.79.184])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 871F11E4A6;
	Wed, 16 Oct 2024 13:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.79.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729084682; cv=none; b=Ymq1Oy/0dtLc+z7YzBcw1I1d4HSM+DgZ3/pmZHkiyIaM55/8VSMYVcgmPShPr3tKM0Xn/eY9ImRptRCSdBnOGLjF+dQWSya+q4cox0wuR230pWlPsdQnbnEkPzbVM18yBDhQrx+w6HoELyoZ9t3hBlowSpqu7QbVd+qTVGIa61M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729084682; c=relaxed/simple;
	bh=o9QojEEoVu3EJyh7dPNCtmVzfQrHAuliI6UgMyrEw4g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UD4ew/UIchRlU3UsnloXfDEuPQhVabfi4IsgXKfE1eaIRMGLD5R7q2eNCt3d0XQ9paycoGzJv+pBoTOqwIShFpio9jsmiYOS5cTzXmvBdUqWdSw4sBOdce3NtUvlNdd4KwZaejPMZvakWOxBONuUCFu0f9b/OWj5As1R+MvS0aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn; spf=pass smtp.mailfrom=hust.edu.cn; arc=none smtp.client-ip=206.189.79.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hust.edu.cn
Received: from hust.edu.cn (unknown [172.16.0.52])
	by app2 (Coremail) with SMTP id HwEQrADX3gLivA9nNogTAQ--.4577S2;
	Wed, 16 Oct 2024 21:17:22 +0800 (CST)
Received: from pride-PowerEdge-R740.. (unknown [222.20.126.129])
	by gateway (Coremail) with SMTP id _____wDHksbhvA9nECJCAA--.14301S2;
	Wed, 16 Oct 2024 21:17:22 +0800 (CST)
From: Dongliang Mu <dzm91@hust.edu.cn>
To: Alex Shi <alexs@kernel.org>,
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
	Yanteng Si <si.yanteng@linux.dev>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH] docs/zh_CN: add the translation of kbuild/kbuild.rst
Date: Wed, 16 Oct 2024 21:16:32 +0800
Message-ID: <20241016131710.2619567-1-dzm91@hust.edu.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:HwEQrADX3gLivA9nNogTAQ--.4577S2
Authentication-Results: app2; spf=neutral smtp.mail=dzm91@hust.edu.cn;
X-Coremail-Antispam: 1UD129KBjvJXoW3Cr43KFWUtr4DtFW8ZF48tFb_yoWkZw47pa
	n3u347t3ZrtryrZFy7KFWjvr18Jr1kJw1Yq3WDtF92qw1xZrWDZr4UKry0yF9rG348J34D
	CFyUGry7AryUA3JanT9S1TB71UUUU1UqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQab7Iv0xC_Zr1lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
	cIk0rVWrJVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjx
	v20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK
	6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1ln4kS14v26r
	1q6r43M2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI
	12xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj64x0Y40En7xvr7AKxV
	WxJVW8Jr1lYx0E74AGY7Cv6cx26r4fZr1UJr1lYx0Ec7CjxVAajcxG14v26r4UJVWxJr1l
	Ox8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxkF7I0En4kS14v26r4a6rW5Mx
	AIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_GFW3Jr1UJwCFx2IqxVCFs4IE7xkE
	bVWUJVW8JwCFI7km07C267AKxVWUtVW8ZwC20s026c02F40E14v26r1j6r18MI8I3I0E74
	80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0
	I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04
	k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7Cj
	xVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jydgAUUUUU=
X-CM-SenderInfo: asqsiiirqrkko6kx23oohg3hdfq/

Finish the translation of kbuild/kbuild.rst and move kbuild
from TODO to the main body.

Update to commit 2eb5d7f24299 ("kbuild: doc: describe the -C
option precisely for external module builds")

Signed-off-by: Dongliang Mu <dzm91@hust.edu.cn>
---
 .../translations/zh_CN/kbuild/index.rst       |   2 +-
 .../translations/zh_CN/kbuild/kbuild.rst      | 304 ++++++++++++++++++
 2 files changed, 305 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/translations/zh_CN/kbuild/kbuild.rst

diff --git a/Documentation/translations/zh_CN/kbuild/index.rst b/Documentation/translations/zh_CN/kbuild/index.rst
index e8eb448c1197..c06268cf44be 100644
--- a/Documentation/translations/zh_CN/kbuild/index.rst
+++ b/Documentation/translations/zh_CN/kbuild/index.rst
@@ -15,12 +15,12 @@
     kconfig
     headers_install
     gcc-plugins
+    kbuild
 
 TODO:
 
 - kconfig-language
 - kconfig-macro-language
-- kbuild
 - makefiles
 - modules
 - issues
diff --git a/Documentation/translations/zh_CN/kbuild/kbuild.rst b/Documentation/translations/zh_CN/kbuild/kbuild.rst
new file mode 100644
index 000000000000..e5e2aebe1ebc
--- /dev/null
+++ b/Documentation/translations/zh_CN/kbuild/kbuild.rst
@@ -0,0 +1,304 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+.. include:: ../disclaimer-zh_CN.rst
+
+:Original: Documentation/kbuild/kbuild.rst
+:Translator: 慕冬亮 Dongliang Mu <dzm91@hust.edu.cn>
+
+======
+Kbuild
+======
+
+
+输出文件
+========
+
+modules.order
+-------------
+该文件记录模块在 Makefile 中出现的顺序。modprobe 使用该文件来确定性
+解析匹配多个模块的别名。
+
+modules.builtin
+---------------
+该文件列出了所有内置到内核中的模块。modprobe 使用该文件来避免尝试加载
+内置模块时出错。
+
+modules.builtin.modinfo
+-----------------------
+该文件包含所有内置模块的 modinfo。与单独模块的 modinfo 不同，所有字段
+都带有模块名称前缀。
+
+modules.builtin.ranges
+----------------------
+该文件包含所有内核内置模块的地址偏移范围（每个 ELF 节）。结合 System.map
+文件，它可以用来将模块名称与符号关联起来。
+
+环境变量
+========
+
+KCPPFLAGS
+---------
+在预处理时传递的额外选项。kbuild 进行所有预处理（包括构建 C 文件和汇编文件）
+时，都会使用这些预处理选项。
+
+KAFLAGS
+-------
+传递给汇编器的额外选项（适用于内置模块和外部模块）。
+
+AFLAGS_MODULE
+-------------
+外部模块的额外汇编选项。
+
+AFLAGS_KERNEL
+-------------
+内置模块的额外汇编选项。
+
+KCFLAGS
+-------
+传递给 C 编译器的额外选项（适用于内置模块和外部模块）。
+
+KRUSTFLAGS
+----------
+传递给 Rust 编译器的额外选项（适用于内置模块和外部模块）。
+
+CFLAGS_KERNEL
+-------------
+在编译内置代码时，传递给 $(CC) 的额外选项。
+
+CFLAGS_MODULE
+-------------
+编译外部模块时，传递给 $(CC) 的额外模块特定选项。
+
+RUSTFLAGS_KERNEL
+----------------
+在编译内置代码时，传递给 $(RUSTC) 的额外选项。
+
+RUSTFLAGS_MODULE
+----------------
+用于 $(RUSTC) 的额外模块特定选项。
+
+LDFLAGS_MODULE
+--------------
+用于 $(LD) 链接模块时的额外选项。
+
+HOSTCFLAGS
+----------
+在构建主机程序时传递给 $(HOSTCC) 的额外标志。
+
+HOSTCXXFLAGS
+------------
+在构建主机程序时传递给 $(HOSTCXX) 的额外标志。
+
+HOSTRUSTFLAGS
+-------------
+在构建主机程序时传递给 $(HOSTRUSTC) 的额外标志。
+
+HOSTLDFLAGS
+-----------
+链接主机程序时传递的额外选项。
+
+HOSTLDLIBS
+----------
+在构建主机程序时链接的额外库。
+
+.. _zh_cn_userkbuildflags:
+
+USERCFLAGS
+----------
+用于 $(CC) 编译用户程序（userprogs）时的额外选项。
+
+USERLDFLAGS
+-----------
+用于 $(LD) 链接用户程序时的额外选项。用户程序（userprogs）是使用 CC 链接的，
+因此 $(USERLDFLAGS) 应该根据需要包含 "-Wl," 前缀。
+
+KBUILD_KCONFIG
+--------------
+将顶级 Kconfig 文件设置为此环境变量的值。默认名称为 "Kconfig"。
+
+KBUILD_VERBOSE
+--------------
+设置 kbuild 的详细程度。可以分配与 "V=..." 相同的值。
+
+有关完整列表，请参见 `make help`。
+
+设置 "V=..." 优先于 KBUILD_VERBOSE。
+
+KBUILD_EXTMOD
+-------------
+在构建外部模块时设置内核源代码的搜索目录。
+
+设置 "M=..." 优先于 KBUILD_EXTMOD。
+
+KBUILD_OUTPUT
+-------------
+指定内核构建的输出目录。
+
+在单独的构建目录中为预构建内核构建外部模块时，这个变量也可以指向内核输出目录。请注意，
+这并不指定外部模块本身的输出目录。
+
+输出目录也可以使用 "O=..." 指定。
+
+设置 "O=..." 优先于 KBUILD_OUTPUT。
+
+KBUILD_EXTRA_WARN
+-----------------
+指定额外的构建检查。也可以通过在命令行传递 "W=..." 来设置相同的值。
+
+请参阅 `make help` 了解支持的值列表。
+
+设置 "W=..." 优先于 KBUILD_EXTRA_WARN。
+
+KBUILD_DEBARCH
+--------------
+对于 deb-pkg 目标，允许覆盖 deb-pkg 部署的正常启发式方法。通常 deb-pkg 尝试根据
+UTS_MACHINE 变量（在某些架构中还包括内核配置）来猜测正确的架构。KBUILD_DEBARCH
+的值假定（不检查）为有效的 Debian 架构。
+
+KDOCFLAGS
+---------
+指定在构建过程中用于 kernel-doc 检查的额外（警告/错误）标志，查看
+scripts/kernel-doc 了解支持的标志。请注意，这目前不适用于文档构建。
+
+ARCH
+----
+设置 ARCH 为要构建的架构。
+
+在大多数情况下，架构的名称与 arch/ 目录中的子目录名称相同。
+
+但某些架构（如 x86 和 sparc）有别名。
+
+- x86: i386 表示 32 位，x86_64 表示 64 位
+- parisc: parisc64 表示 64 位
+- sparc: sparc32 表示 32 位，sparc64 表示 64 位
+
+CROSS_COMPILE
+-------------
+指定 binutils 文件名的可选固定部分。CROSS_COMPILE 可以是文件名的一部分或完整路径。
+
+在某些设置中，CROSS_COMPILE 也用于 ccache。
+
+CF
+--
+用于 sparse 的额外选项。
+
+CF 通常在命令行中如下所示使用::
+
+    make CF=-Wbitwise C=2
+
+INSTALL_PATH
+------------
+INSTALL_PATH 指定放置更新后的内核和系统映像的路径。默认值是 /boot，但你可以设置
+为其他值。
+
+INSTALLKERNEL
+-------------
+使用 "make install" 时调用的安装脚本。
+默认名称是 "installkernel"。
+
+该脚本将会以以下参数调用：
+
+   - $1 - 内核版本
+   - $2 - 内核映像文件
+   - $3 - 内核映射文件
+   - $4 - 默认安装路径（如果为空，则使用根目录）
+
+"make install" 的实现是架构特定的，可能与上述有所不同。
+
+提供 INSTALLKERNEL 以便在交叉编译内核时可以指定自定义安装程序。
+
+MODLIB
+------
+指定模块的安装位置。
+默认值为::
+
+    $(INSTALL_MOD_PATH)/lib/modules/$(KERNELRELEASE)
+
+该值可以被覆盖，在这种情况下将忽略默认值。
+
+INSTALL_MOD_PATH
+----------------
+INSTALL_MOD_PATH 指定了模块目录重定位时 MODLIB 的前缀，通常由构建根
+（build roots）所需。它没有在 makefile 中定义，但如果需要，可以作为
+参数传递给 make。
+
+INSTALL_MOD_STRIP
+-----------------
+如果 INSTALL_MOD_STRIP 被定义，内核模块在安装后会被剥离。如果
+INSTALL_MOD_STRIP 的值为 '1'，则会使用默认选项 --strip-debug。否则，
+INSTALL_MOD_STRIP 的值将作为 strip 命令的选项。
+
+INSTALL_HDR_PATH
+----------------
+INSTALL_HDR_PATH 指定了执行 "make headers_*" 时，用户空间头文件的安装位置。
+
+默认值为::
+
+    $(objtree)/usr
+
+$(objtree) 是保存输出文件的目录。
+输出目录通常使用命令行中的 "O=..." 进行设置。
+
+该值可以被覆盖，在这种情况下将忽略默认值。
+
+INSTALL_DTBS_PATH
+-----------------
+INSTALL_DTBS_PATH 指定了设备树二进制文件的安装位置，通常由构建根（build roots）所需。
+它没有在 makefile 中定义，但如果需要，可以作为参数传递给 make。
+
+KBUILD_ABS_SRCTREE
+--------------------------------------------------
+Kbuild 在可能的情况下使用相对路径指向源代码树。例如，在源代码树中构建时，源代码树路径是
+'.'。
+
+设置该标志请求 Kbuild 使用源代码树的绝对路径。
+在某些情况下这是有用的，例如在生成带有绝对路径条目的标签文件时等。
+
+KBUILD_SIGN_PIN
+---------------
+当签署内核模块时，如果私钥需要密码或 PIN，此变量允许将密码或 PIN 传递给 sign-file 工具。
+
+KBUILD_MODPOST_WARN
+-------------------
+KBUILD_MODPOST_WARN 可以设置为在最终模块链接阶段出现未定义符号时避免错误。它将这些错误
+转为警告。
+
+KBUILD_MODPOST_NOFINAL
+----------------------
+KBUILD_MODPOST_NOFINAL 可以设置为跳过模块的最终链接。这仅在加速编译测试时有用。
+
+KBUILD_EXTRA_SYMBOLS
+--------------------
+用于依赖其他模块符号的模块。详见 modules.rst。
+
+ALLSOURCE_ARCHS
+---------------
+对于 tags/TAGS/cscope 目标，可以指定包含在数据库中的多个架构，用空格分隔。例如::
+
+    $ make ALLSOURCE_ARCHS="x86 mips arm" tags
+
+要获取所有可用架构，也可以指定 all。例如::
+
+    $ make ALLSOURCE_ARCHS=all tags
+
+IGNORE_DIRS
+-----------
+对于 tags/TAGS/cscope 目标，可以选择不包含在数据库中的目录，用空格分隔。例如::
+
+    $ make IGNORE_DIRS="drivers/gpu/drm/radeon tools" cscope
+
+KBUILD_BUILD_TIMESTAMP
+----------------------
+将该环境变量设置为日期字符串，可以覆盖在 UTS_VERSION 定义中使用的时间戳
+（运行内核时的 uname -v）。该值必须是一个可以传递给 date -d 的字符串。默认值是
+内核构建某个时刻的 date 命令输出。
+
+KBUILD_BUILD_USER, KBUILD_BUILD_HOST
+------------------------------------
+这两个变量允许覆盖启动时显示的 user@host 字符串以及 /proc/version 中的信息。
+默认值分别是 whoami 和 host 命令的输出。
+
+LLVM
+----
+如果该变量设置为 1，Kbuild 将使用 Clang 和 LLVM 工具，而不是 GCC 和 GNU
+binutils 来构建内核。
-- 
2.43.0


