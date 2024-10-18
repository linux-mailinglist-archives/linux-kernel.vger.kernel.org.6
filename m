Return-Path: <linux-kernel+bounces-371796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 160EB9A4063
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 15:50:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A9981C20E55
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 13:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2876218872C;
	Fri, 18 Oct 2024 13:50:11 +0000 (UTC)
Received: from zg8tmja2lje4os43os4xodqa.icoremail.net (zg8tmja2lje4os43os4xodqa.icoremail.net [206.189.79.184])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DD06134AC;
	Fri, 18 Oct 2024 13:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.79.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729259410; cv=none; b=sQt30I5mSUIElEwgOonnXP+4GVTDzl7Y4QUIF50NO3GfQ7xl5TfGtzAapSWBIsCqlDSFrrPRlGHH3vKw5ko/uG00o+OwwImm0/xjwzR6cAXmh+2kK50nTZi7oiGRreNS7v8FuV6R7AHdRPIPzABQyz41GymkPY3Ut6CRAFvAmSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729259410; c=relaxed/simple;
	bh=czDWpuzBrIG1632hdNm09j0TAUks93v06t9QTW0G4Wg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i06VHMmZEQCniVOp3DD+QvdLVrcpHb+gcTei6FegMPGjuX1+UheqA0H9lwXpTbvgKKxtTRzRnZ+12lWqbRklE6EaKSiC+3H6PpPM6RjIvS+bPNi0ZbSy1WzFpmFhxlxxkCj2QgHi8iTxGuZSK7o7Mu4G2xx7fNcfJd6aRMl6MJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn; spf=pass smtp.mailfrom=hust.edu.cn; arc=none smtp.client-ip=206.189.79.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hust.edu.cn
Received: from hust.edu.cn (unknown [172.16.0.50])
	by app2 (Coremail) with SMTP id HwEQrABHTwNYZxJnBKoYAQ--.16023S2;
	Fri, 18 Oct 2024 21:49:12 +0800 (CST)
Received: from pride-PowerEdge-R740.. (unknown [222.20.126.129])
	by gateway (Coremail) with SMTP id _____wDHGAwsZxJnn+VmAA--.4455S4;
	Fri, 18 Oct 2024 21:49:11 +0800 (CST)
From: Dongliang Mu <dzm91@hust.edu.cn>
To: si.yanteng@linux.dev,
	Alex Shi <alexs@kernel.org>,
	Yanteng Si <siyanteng@loongson.cn>,
	Jonathan Corbet <corbet@lwn.net>,
	Dongliang Mu <dzm91@hust.edu.cn>
Cc: hust-os-kernel-patches@googlegroups.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] docs/zh_CN: add the translations of kbuild/reproducible-builds.rst
Date: Fri, 18 Oct 2024 21:47:53 +0800
Message-ID: <dcd09bf28f52ba0461b26f800fdbb145c879a313.1729259177.git.dzm91@hust.edu.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1729259177.git.dzm91@hust.edu.cn>
References: <cover.1729259177.git.dzm91@hust.edu.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:HwEQrABHTwNYZxJnBKoYAQ--.16023S2
Authentication-Results: app2; spf=neutral smtp.mail=dzm91@hust.edu.cn;
X-Coremail-Antispam: 1UD129KBjvJXoW3AF1UWw45CF18ZFWkur4DArb_yoW3JF4Dpa
	sagrZ7JFn7tFyUArZ2kF4UuF15Cws2gw17K3Z7t3Wrtrn2vrZ0yr47t348ua4fWa48A343
	CFZ3JFy5Cr1UZ3JanT9S1TB71UUUUjDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQab7Iv0xC_Cr1lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
	cIk0rVWrJVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjx
	v20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwA2z4x0Y4vE
	x4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAaw2AFwI0_JF
	0_Jw1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF
	0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0EF7xvrVAajcxG14v26F
	4j6r4UJwAv7VCjz48v1sIEY20_GFW3Jr1UJwAv7VCY1x0262k0Y48FwI0_Gr1j6F4UJwAm
	72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42
	xK82IYc2Ij64vIr41l42xK82IY6x8ErcxFaVAv8VW8uFyUJr1UMxC20s026xCaFVCjc4AY
	6r1j6r4UMxCIbckI1I0E14v26r4a6rW5MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26ryj6F1UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Cr0_Gr1UMIIF0xvEx4A2jsIEc7Cj
	xVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UGApnUUUUU=
X-CM-SenderInfo: asqsiiirqrkko6kx23oohg3hdfq/

Finish the translation of kbuild/reproducible-builds.rst and move
reproducible-builds.rst from TODO to the main body.

Update to commit 114ff6fe6cfb ("Documentation: kbuild: Add description
of git for reproducible builds")

Signed-off-by: Dongliang Mu <dzm91@hust.edu.cn>
---
 .../translations/zh_CN/kbuild/index.rst       |   2 +-
 .../zh_CN/kbuild/reproducible-builds.rst      | 114 ++++++++++++++++++
 2 files changed, 115 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/translations/zh_CN/kbuild/reproducible-builds.rst

diff --git a/Documentation/translations/zh_CN/kbuild/index.rst b/Documentation/translations/zh_CN/kbuild/index.rst
index c06268cf44be..0ba96aecb13a 100644
--- a/Documentation/translations/zh_CN/kbuild/index.rst
+++ b/Documentation/translations/zh_CN/kbuild/index.rst
@@ -16,6 +16,7 @@
     headers_install
     gcc-plugins
     kbuild
+    reproducible-builds
 
 TODO:
 
@@ -24,7 +25,6 @@ TODO:
 - makefiles
 - modules
 - issues
-- reproducible-builds
 - llvm
 
 .. only::  subproject and html
diff --git a/Documentation/translations/zh_CN/kbuild/reproducible-builds.rst b/Documentation/translations/zh_CN/kbuild/reproducible-builds.rst
new file mode 100644
index 000000000000..5f27ebf2fbfc
--- /dev/null
+++ b/Documentation/translations/zh_CN/kbuild/reproducible-builds.rst
@@ -0,0 +1,114 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+.. include:: ../disclaimer-zh_CN.rst
+
+:Original: Documentation/kbuild/reproducible-builds.rst
+
+:Translator: 慕冬亮 Dongliang Mu <dzm91@hust.edu.cn>
+
+============
+可重现的构建
+============
+
+通常希望使用相同工具集构建相同源代码是可重现的，即，输出始终完全相同。这使得能够验证
+二进制分发或嵌入式系统的构建基础设施未被篡改。这样也更容易验证源代码或工具的更改不会
+影响最终生成的二进制文件。
+
+`可重现构建项目`_ 提供了有关该主题的更多信息。本文档涵盖了构建内核可能不可重现的
+各种原因，以及如何避免这些问题。
+
+时间戳
+------
+
+内核在三个地方嵌入时间戳：
+
+* 通过 ``uname()`` 显示与包含在 ``/proc/version`` 中的版本字符串
+
+* initramfs 中的文件时间戳
+
+* 如果启动 ``CONFIG_IKHEADERS``，内核或相应模块中嵌入的内核头文件的时间戳，
+  通过 ``/sys/kernel/kheaders.tar.xz`` 显示
+
+默认情况下，时间戳为当前时间或内核头文件的修改时间。这个内容必须使用
+`KBUILD_BUILD_TIMESTAMP`_ 变量进行覆盖。如果你从某个 git 提交进行构建，
+可以使用其提交日期。
+
+内核 *不* 使用 ``__DATE__`` 和 ``__TIME__`` 宏，并在使用这些宏时启用警告。
+如果你合并的外部代码使用这些宏，则必须通过设置 `SOURCE_DATE_EPOCH`_ 环境
+变量来覆盖它们对应的时间戳。
+
+用户，主机
+----------
+
+内核在 ``/proc/version`` 中嵌入构建用户和主机名。必须使用
+`KBUILD_BUILD_USER 和 KBUILD_BUILD_HOST`_ 变量来覆盖这些设置。如果
+您从某个 git 提交进行构建，可以使用其提交者地址。
+
+绝对文件名
+----------
+
+当内核在树外构建时，调试信息可能包括源文件的绝对文件名。这些信息必须通过在
+`KCFLAGS`_ 变量中包含 ``-fdebug-prefix-map`` 选项来覆盖。
+
+根据使用的编译器，``__FILE__`` 宏在树外构建中也可能扩展为绝对文件名。Kbuild
+自动使用 ``-fmacro-prefix-map`` 选项来防止这种情况，前提是它被支持。
+
+可重现构建网站提供了有关这些 `prefix-map 选项`_ 的更多信息。
+
+在源包中的生成文件
+------------------
+
+在 ``tools/`` 子目录下，一些程序的构建过程并不完全支持树外构建。这可能导致后续
+使用如 ``make rpm-pkg`` 构建的源码包包含生成的文件。在构建源码包之前，您应该通过
+运行 ``make mrproper`` 或 ``git clean -d -f -x`` 来确保源码树是干净的。
+
+模块签名
+--------
+
+如果你启用 ``CONFIG_MODULE_SIG_ALL``，默认行为是为每次构建生成不同的临时密钥，
+从而导致模块不可重现。然而，将签名密钥包含在源代码中显然会违背签名模块的目的。
+
+一种方法是将构建过程分为几个部分，以便不可重现的部分可以作为源处理：
+
+1. 生成一个持久的签名密钥。将该密钥的证书添加到内核源代码中。
+
+2. 将 ``CONFIG_SYSTEM_TRUSTED_KEYS`` 符号设置为包括签名密钥的证书，将
+``CONFIG_MODULE_SIG_KEY`` 设置为空字符串，并禁用 ``CONFIG_MODULE_SIG_ALL``。
+最后，构建内核和模块。
+
+3. 为模块创建分离的签名，并将它们作为源发布。
+
+4. 附加模块签名并进行第二次构建。这可以重建模块，或使用步骤 2 的输出。
+
+结构随机化
+----------
+
+如果你启用 ``CONFIG_RANDSTRUCT``，则需要在 ``scripts/basic/randstruct.seed``
+中预生成随机种子，以便每次构建都使用相同的值。有关详细信息，请参见
+``scripts/gen-randstruct-seed.sh``。
+
+调试信息冲突
+------------
+
+这并非是个不可重现性的问题，而是生成的文件 *过于* 可重现的问题。
+
+一旦你设置了所有必要的变量来开展可重现构建，vDSO 的调试信息可能即使对于不同的内核版
+本也是相同的。这会导致不同内核版本的调试信息软件包之间发生文件冲突。
+
+为了避免这种情况，你可以通过在 vDSO 中包含一个任意的 salt 字符串，使其对于不同的
+内核版本是不同的。这种机制由 Kconfig 符号 ``CONFIG_BUILD_SALT`` 指定。
+
+Git
+---
+
+未提交的更改或 Git 中的不同提交 ID 也可能导致不同的编译结果。例如，在执行
+``git reset HEAD^`` 后，即使代码相同，编译期间生成的
+``include/config/kernel.release`` 也会不同，导致最终生成的二进制文件也不尽相同。
+有关详细信息，请参见 ``scripts/setlocalversion``。
+
+.. _KBUILD_BUILD_TIMESTAMP: kbuild.html#kbuild-build-timestamp
+.. _KBUILD_BUILD_USER 和 KBUILD_BUILD_HOST: kbuild.html#kbuild-build-user-kbuild-build-host
+.. _KCFLAGS: kbuild.html#kcflags
+.. _prefix-map 选项: https://reproducible-builds.org/docs/build-path/
+.. _可重现构建项目: https://reproducible-builds.org/
+.. _SOURCE_DATE_EPOCH: https://reproducible-builds.org/docs/source-date-epoch/
-- 
2.43.0


