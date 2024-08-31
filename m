Return-Path: <linux-kernel+bounces-309681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB52B966F26
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 05:51:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C2E41F23A34
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 03:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7D1F5674E;
	Sat, 31 Aug 2024 03:51:48 +0000 (UTC)
Received: from sgoci-sdnproxy-4.icoremail.net (sgoci-sdnproxy-4.icoremail.net [129.150.39.64])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4AD639FC6;
	Sat, 31 Aug 2024 03:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.150.39.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725076308; cv=none; b=OepQ5Nmn5bGQTxLP6Rxaos3iM28h6IgwfnvW4MP94ujNHE/LYvfeCVnRHwKADvQWmNwCn1TzqYjsTQvWqpEAVO+79AlLP3f8wqGTb/Ke2HWMO9rKBJoxBnBcGMJGgKCOR0PU9DvWilL3pfpPr8lBAXbsHJnGe4skGPW7n4UMnDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725076308; c=relaxed/simple;
	bh=53bZytTUajpVNIHI0kdeFUfleUDqkJ/X5bRITQrwgYQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EZO3hQX7DeZfaoEK3gBPMrnnXRKCRIip6ohQt5bPFOAfHp1g7LxbW4cn78btjfBpEUa2GGXnL3iw/q2OyinEMdwSIOd46Wflg38BxrOTpFGM0YHIt0MWPtJrs3xsAkY3nEslEppGmGowHZcBYzXmNq3PWu7SB4f9wah3JOCUmz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn; spf=pass smtp.mailfrom=hust.edu.cn; arc=none smtp.client-ip=129.150.39.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hust.edu.cn
Received: from hust.edu.cn (unknown [172.16.0.52])
	by app2 (Coremail) with SMTP id HwEQrAA34BQck9JmpruhAA--.37159S2;
	Sat, 31 Aug 2024 11:50:52 +0800 (CST)
Received: from pride-PowerEdge-R740.. (unknown [222.20.126.129])
	by gateway (Coremail) with SMTP id _____wB3EjwXk9JmbHjZAA--.9330S2;
	Sat, 31 Aug 2024 11:50:48 +0800 (CST)
From: Dongliang Mu <dzm91@hust.edu.cn>
To: Alex Shi <alexs@kernel.org>,
	Yanteng Si <siyanteng@loongson.cn>,
	Jonathan Corbet <corbet@lwn.net>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Dongliang Mu <dzm91@hust.edu.cn>
Cc: hust-os-kernel-patches@googlegroups.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH v2] docs/zh_CN: add the translation of kbuild/gcc-plugins.rst
Date: Sat, 31 Aug 2024 11:48:46 +0800
Message-ID: <20240831034924.3729507-1-dzm91@hust.edu.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:HwEQrAA34BQck9JmpruhAA--.37159S2
Authentication-Results: app2; spf=neutral smtp.mail=dzm91@hust.edu.cn;
X-Coremail-Antispam: 1UD129KBjvJXoWxtry3CrWrKr13Gr4xKryfJFb_yoWxXrWUpw
	4qk34SgFWSyFy093yfKr1xuF15JFs3Ww1UKa48Gwn7tF1kJrZ0y3y3try5GryfWFy8ZrW3
	XF4ayrWUuw1UZa7anT9S1TB71UUUUjJqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQIb7Iv0xC_Zr1lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
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
	I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04
	k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7Cj
	xVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU0trc3UUUUU==
X-CM-SenderInfo: asqsiiirqrkko6kx23oohg3hdfq/

Finish the translation of kbuild/gcc-plugins.rst and move gcc-plugins
from TODO to the main body.

Update to commit 3832d1fd84b6 ("docs/core-api: expand Fedora instructions
for GCC plugins")

Signed-off-by: Dongliang Mu <dzm91@hust.edu.cn>
---
v1->v2: fix comments from yanteng

 .../translations/zh_CN/kbuild/gcc-plugins.rst | 126 ++++++++++++++++++
 .../translations/zh_CN/kbuild/index.rst       |   2 +-
 2 files changed, 127 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/translations/zh_CN/kbuild/gcc-plugins.rst

diff --git a/Documentation/translations/zh_CN/kbuild/gcc-plugins.rst b/Documentation/translations/zh_CN/kbuild/gcc-plugins.rst
new file mode 100644
index 000000000000..f31fed139289
--- /dev/null
+++ b/Documentation/translations/zh_CN/kbuild/gcc-plugins.rst
@@ -0,0 +1,126 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+.. include:: ../disclaimer-zh_CN.rst
+
+:Original: Documentation/kbuild/gcc-plugins.rst
+:Translator: 慕冬亮 Dongliang Mu <dzm91@hust.edu.cn>
+
+================
+GCC 插件基础设施
+================
+
+
+介绍
+=====
+
+GCC 插件是为编译器提供额外功能的可加载模块 [1]_。它们对于运行时插装和静态分析非常有用。
+我们可以在编译过程中通过回调 [2]_，GIMPLE [3]_，IPA [4]_ 和 RTL Passes [5]_
+（译者注：Pass 是编译器所采用的一种结构化技术，用于完成编译对象的分析、优化或转换等功能）
+来分析、修改和添加更多的代码。
+
+内核的 GCC 插件基础设施支持构建树外模块、交叉编译和在单独的目录中构建。插件源文件必须由
+C++ 编译器编译。
+
+目前 GCC 插件基础设施只支持一些架构。搜索 "select HAVE_GCC_PLUGINS" 来查找支持
+GCC 插件的架构。
+
+这个基础设施是从 grsecurity [6]_  和 PaX [7]_ 移植过来的。
+
+--
+
+.. [1] https://gcc.gnu.org/onlinedocs/gccint/Plugins.html
+.. [2] https://gcc.gnu.org/onlinedocs/gccint/Plugin-API.html#Plugin-API
+.. [3] https://gcc.gnu.org/onlinedocs/gccint/GIMPLE.html
+.. [4] https://gcc.gnu.org/onlinedocs/gccint/IPA.html
+.. [5] https://gcc.gnu.org/onlinedocs/gccint/RTL.html
+.. [6] https://grsecurity.net/
+.. [7] https://pax.grsecurity.net/
+
+
+目的
+=======
+
+GCC 插件的设计目的是提供一个用于试验 GCC 或 Clang 上游没有的潜在编译器功能的场所。
+一旦它们的实用性得到验证，这些功能将被添加到 GCC（和 Clang）的上游。随后，在所有
+支持的 GCC 版本都支持这些功能后，它们会被从内核中移除。
+
+具体来说，新插件应该只实现上游编译器（GCC 和 Clang）不支持的功能。
+
+当 Clang 中存在 GCC 中不存在的某项功能时，应努力将该功能做到 GCC 上游（而不仅仅
+是作为内核专用的 GCC 插件），以使整个生态都能从中受益。
+
+类似的，如果 GCC 插件提供的功能在 Clang 中 **不** 存在，但该功能被证明是有用的，也应
+努力将该功能上传到 GCC（和 Clang）。
+
+在上游 GCC 提供了某项功能后，该插件将无法在相应的 GCC 版本（以及更高版本）下编译。
+一旦所有内核支持的 GCC 版本都提供了该功能，该插件将从内核中移除。
+
+
+文件
+=====
+
+**$(src)/scripts/gcc-plugins**
+
+	这是 GCC 插件的目录。
+
+**$(src)/scripts/gcc-plugins/gcc-common.h**
+
+	这是 GCC 插件的兼容性头文件。
+	应始终包含它，而不是单独的 GCC 头文件。
+
+**$(src)/scripts/gcc-plugins/gcc-generate-gimple-pass.h,
+$(src)/scripts/gcc-plugins/gcc-generate-ipa-pass.h,
+$(src)/scripts/gcc-plugins/gcc-generate-simple_ipa-pass.h,
+$(src)/scripts/gcc-plugins/gcc-generate-rtl-pass.h**
+
+	这些头文件可以自动生成 GIMPLE、SIMPLE_IPA、IPA 和 RTL passes 的注册结构。
+	与手动创建结构相比，它们更受欢迎。
+
+
+用法
+=====
+
+你必须为你的 GCC 版本安装 GCC 插件头文件，以 Ubuntu 上的 gcc-10 为例::
+
+	apt-get install gcc-10-plugin-dev
+
+或者在 Fedora 上::
+
+	dnf install gcc-plugin-devel libmpc-devel
+
+或者在 Fedora 上使用包含插件的交叉编译器时::
+
+	dnf install libmpc-devel
+
+在内核配置中启用 GCC 插件基础设施与一些你想使用的插件::
+
+	CONFIG_GCC_PLUGINS=y
+	CONFIG_GCC_PLUGIN_LATENT_ENTROPY=y
+	...
+
+运行 gcc（本地或交叉编译器），确保能够检测到插件头文件::
+
+	gcc -print-file-name=plugin
+	CROSS_COMPILE=arm-linux-gnu- ${CROSS_COMPILE}gcc -print-file-name=plugin
+
+"plugin" 这个词意味着它们没有被检测到::
+
+	plugin
+
+完整的路径则表示插件已经被检测到::
+
+       /usr/lib/gcc/x86_64-redhat-linux/12/plugin
+
+编译包括插件在内的最小工具集::
+
+	make scripts
+
+或者直接在内核中运行 make，使用循环复杂性 GCC 插件编译整个内核。
+
+
+4. 如何添加新的 GCC 插件
+==============================
+
+GCC 插件位于 scripts/gcc-plugins/。你需要将插件源文件放在 scripts/gcc-plugins/ 目录下。
+子目录创建并不支持，你必须添加在 scripts/gcc-plugins/Makefile、scripts/Makefile.gcc-plugins
+和相关的 Kconfig 文件中。
diff --git a/Documentation/translations/zh_CN/kbuild/index.rst b/Documentation/translations/zh_CN/kbuild/index.rst
index d906a4e88d0f..b51655d981f6 100644
--- a/Documentation/translations/zh_CN/kbuild/index.rst
+++ b/Documentation/translations/zh_CN/kbuild/index.rst
@@ -13,6 +13,7 @@
     :maxdepth: 1
 
     headers_install
+    gcc-plugins
 
 TODO:
 
@@ -24,7 +25,6 @@ TODO:
 - modules
 - issues
 - reproducible-builds
-- gcc-plugins
 - llvm
 
 .. only::  subproject and html
-- 
2.43.0


