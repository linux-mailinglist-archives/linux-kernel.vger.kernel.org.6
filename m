Return-Path: <linux-kernel+bounces-263412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3303793D57B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 16:58:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B69472837AB
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 14:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 265F91F95A;
	Fri, 26 Jul 2024 14:58:49 +0000 (UTC)
Received: from zg8tmja5ljk3lje4ms43mwaa.icoremail.net (zg8tmja5ljk3lje4ms43mwaa.icoremail.net [209.97.181.73])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 250CE17838E;
	Fri, 26 Jul 2024 14:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.97.181.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722005928; cv=none; b=BOKPLCvgvqMAXVW0tSJAXv9p1vLm2nvJ8fMyh0/QpEvFiosaDmujzKzWqXLIzhAOzBfs8J/Xtz/xa7NFchP3C3lYGD/NJgLdJ1WU01S0CLrYSZfUCK0wyW1SkOnJ7dAIqR+ZeNUcNCLxP6D5qqXO8eq0Rb06xdPiC1fbCP463Oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722005928; c=relaxed/simple;
	bh=dzlJqty6mK3u9JfGL9aBf3nIxzEBSXB1Yp38r35/d6k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pf4HDjcx6OWFddBtIDY1ERgNqeEHK97DYi9m8QdVPgfdiLnS7rUUfYhU2fypelJPUsrzbGT05WVwL2YgJWY6ND15Nwph3okQeerDGV1r+3FhOLU/erSlVMVGNmCyAcF6vQSW0gFSKgZmt9hrNVVq7Tw+1aOysplScK6F56qKWaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn; spf=pass smtp.mailfrom=hust.edu.cn; arc=none smtp.client-ip=209.97.181.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hust.edu.cn
Received: from hust.edu.cn (unknown [172.16.0.52])
	by app2 (Coremail) with SMTP id HwEQrAB3fgJ6uaNmO45UAA--.22199S2;
	Fri, 26 Jul 2024 22:58:02 +0800 (CST)
Received: from pride-PowerEdge-R740.. (unknown [222.20.126.129])
	by gateway (Coremail) with SMTP id _____wDnOCx3uaNmQNwHAA--.3379S2;
	Fri, 26 Jul 2024 22:58:00 +0800 (CST)
From: Dongliang Mu <dzm91@hust.edu.cn>
To: Alex Shi <alexs@kernel.org>,
	Yanteng Si <siyanteng@loongson.cn>,
	Jonathan Corbet <corbet@lwn.net>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Dongliang Mu <dzm91@hust.edu.cn>
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH] docs/zh_CN: add the translation of kbuild/headers_install.rst
Date: Fri, 26 Jul 2024 22:57:23 +0800
Message-ID: <20240726145754.2598197-1-dzm91@hust.edu.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:HwEQrAB3fgJ6uaNmO45UAA--.22199S2
Authentication-Results: app2; spf=neutral smtp.mail=dzm91@hust.edu.cn;
X-Coremail-Antispam: 1UD129KBjvJXoWxZF13tFW5GF1UuF47Kr1rJFb_yoWrKF1xp3
	WqgryxKF4UJFyakFyfGFW7GF1rGan29ay7t3WxJ34aqryrJFW8trnFvrySgrn7KrW8AFyU
	WF40qa4jkrW7A3DanT9S1TB71UUUUjDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQab7Iv0xC_Zr1lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
	cIk0rVWrJVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjx
	v20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwA2z4x0Y4vE
	x4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAaw2AFwI0_JF
	0_Jw1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF
	0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0EF7xvrVAajcxG14v26r
	4UJVWxJr1lYx0E74AGY7Cv6cx26r4fZr1UJr1lYx0Ec7CjxVAajcxG14v26r4UJVWxJr1l
	Ox8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxkF7I0En4kS14v26r1q6r43Mx
	AIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_GFW3Jr1UJwCFx2IqxVCFs4IE7xkE
	bVWUJVW8JwCFI7km07C267AKxVWUAVWUtwC20s026c02F40E14v26r1j6r18MI8I3I0E74
	80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0
	I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04
	k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7Cj
	xVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jh189UUUUU=
X-CM-SenderInfo: asqsiiirqrkko6kx23oohg3hdfq/

Finish the translation of kbuild/headers_install.rst and
kbuild/index.rst, then add kbuild into zh_CN/index.rst.

Update to commit 5b67fbfc32b5 ("Merge tag 'kbuild-v5.7' of
git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild")

Signed-off-by: Dongliang Mu <dzm91@hust.edu.cn>
---
 Documentation/translations/zh_CN/index.rst    |  2 +-
 .../zh_CN/kbuild/headers_install.rst          | 39 +++++++++++++++++++
 .../translations/zh_CN/kbuild/index.rst       | 35 +++++++++++++++++
 3 files changed, 75 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/translations/zh_CN/kbuild/headers_install.rst
 create mode 100644 Documentation/translations/zh_CN/kbuild/index.rst

diff --git a/Documentation/translations/zh_CN/index.rst b/Documentation/translations/zh_CN/index.rst
index 20b9d4270d1f..7574e1673180 100644
--- a/Documentation/translations/zh_CN/index.rst
+++ b/Documentation/translations/zh_CN/index.rst
@@ -89,10 +89,10 @@ TODOList:
    admin-guide/index
    admin-guide/reporting-issues.rst
    userspace-api/index
+   内核构建系统 <kbuild/index>
 
 TODOList:
 
-* 内核构建系统 <kbuild/index>
 * 用户空间工具 <tools/index>
 
 也可参考独立于内核文档的 `Linux 手册页 <https://www.kernel.org/doc/man-pages/>`_ 。
diff --git a/Documentation/translations/zh_CN/kbuild/headers_install.rst b/Documentation/translations/zh_CN/kbuild/headers_install.rst
new file mode 100644
index 000000000000..50ab819a7f96
--- /dev/null
+++ b/Documentation/translations/zh_CN/kbuild/headers_install.rst
@@ -0,0 +1,39 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+.. include:: ../disclaimer-zh_CN.rst
+
+:Original: Documentation/kbuild/headers_install.rst
+:Translator: 慕冬亮 Dongliang Mu <dzm91@hust.edu.cn>
+
+============================
+导出内核头文件供用户空间使用
+============================
+
+"make headers_install" 命令以适合于用户空间程序的形式导出内核头文件。
+
+Linux 内核导出的头文件描述了用户空间程序尝试使用内核服务的 API。这些内核
+头文件被系统的 C 库（例如 glibc 和 uClibc）用于定义可用的系统调用，以及
+与这些系统调用一起使用的常量和结构。C 库的头文件包括来自 linux 子目录的
+内核头文件。系统的 libc 头文件通常被安装在默认位置 /usr/include，而内核
+头文件在该位置的子目录中（主要是 /usr/include/linux 和 /usr/include/asm）。
+
+内核头文件向后兼容，但不向前兼容。这意味着使用旧内核头文件的 C 库构建的程序
+可以在新内核上运行（尽管它可能无法访问新特性），但使用新内核头文件构建的程序
+可能无法在旧内核上运行。
+
+"make headers_install" 命令可以在内核源代码的顶层目录中运行（或使用标准
+的树外构建）。它接受两个可选参数::
+
+  make headers_install ARCH=i386 INSTALL_HDR_PATH=/usr
+
+ARCH 表明为其生成头文件的架构，默认为当前架构。导出内核头文件的 linux/asm
+目录是基于特定平台的，要查看支持架构的完整列表，使用以下命令::
+
+  ls -d include/asm-* | sed 's/.*-//'
+
+INSTALL_HDR_PATH 表明头文件的安装位置，默认为 "./usr"。
+
+该命令会在 INSTALL_HDR_PATH 中自动创建创建一个 'include' 目录，而头文件
+会被安装在 INSTALL_HDR_PATH/include 中。
+
+内核头文件导出的基础设施由 David Woodhouse <dwmw2@infradead.org> 维护。
\ No newline at end of file
diff --git a/Documentation/translations/zh_CN/kbuild/index.rst b/Documentation/translations/zh_CN/kbuild/index.rst
new file mode 100644
index 000000000000..b9feb56b846a
--- /dev/null
+++ b/Documentation/translations/zh_CN/kbuild/index.rst
@@ -0,0 +1,35 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+.. include:: ../disclaimer-zh_CN.rst
+
+:Original: Documentation/kbuild/index
+:Translator: 慕冬亮 Dongliang Mu <dzm91@hust.edu.cn>
+
+============
+内核编译系统
+============
+
+.. toctree::
+    :maxdepth: 1
+
+    headers_install
+
+TODO:
+
+- kconfig-language
+- kconfig-macro-language
+- kbuild
+- kconfig
+- makefiles
+- modules
+- issues
+- reproducible-builds
+- gcc-plugins
+- llvm
+
+.. only::  subproject and html
+
+   目录
+   =====
+
+   * :ref:`genindex`
-- 
2.43.0


