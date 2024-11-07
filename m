Return-Path: <linux-kernel+bounces-399158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D6059BFBB2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 02:37:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EC681C21C22
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 01:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A3E8101F2;
	Thu,  7 Nov 2024 01:37:00 +0000 (UTC)
Received: from zg8tmtu5ljy1ljeznc42.icoremail.net (zg8tmtu5ljy1ljeznc42.icoremail.net [159.65.134.6])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EF0BFC12;
	Thu,  7 Nov 2024 01:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.65.134.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730943419; cv=none; b=iNHjEifgs6aujbodhT2JO4FSxFYtaXp3FJJz+z5jQQahkwvg9pP3lpuSvKqXfiVOEENdQtwAQ6Xlo3ElrzQwVIuDnyKsrrsUyme2h6MrFSVKNOUsOevi++cgfHoyydv9N5SUMnC5X19+bfqa1wPCVTf+dZQmlNBshz9ydNPPdqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730943419; c=relaxed/simple;
	bh=j/YLujfjSz1iY7AtKCBJOZrm0NmFBEUlT6NJSCFYkFs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=osRHYzTVPJf4jDyo5FK1+Ed2QBtbnItCGhbUYrRyH9ZWYV7CYDxTssotxGLvrDlFwxlruNsjAGq54jlThy/MV1S/GAbHqRy0V/1Rka0PBRGxkegooekNkXfwTqKIKtGankpfJplRq9C+jFr2iasDHfgwq805RvdQZk0HYyfqSPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn; spf=pass smtp.mailfrom=hust.edu.cn; arc=none smtp.client-ip=159.65.134.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hust.edu.cn
Received: from hust.edu.cn (unknown [172.16.0.52])
	by app2 (Coremail) with SMTP id HwEQrADn7s6VGSxnEhREAQ--.50568S2;
	Thu, 07 Nov 2024 09:36:21 +0800 (CST)
Received: from pride-PowerEdge-R740.. (unknown [222.20.126.129])
	by gateway (Coremail) with SMTP id _____wAH3sSSGSxn64YWAQ--.16350S2;
	Thu, 07 Nov 2024 09:36:19 +0800 (CST)
From: Dongliang Mu <dzm91@hust.edu.cn>
To: si.yanteng@linux.dev,
	Alex Shi <alexs@kernel.org>,
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
Subject: [PATCH] docs/zh_CN: fix one sentence in llvm.rst
Date: Thu,  7 Nov 2024 09:35:52 +0800
Message-ID: <20241107013615.374757-1-dzm91@hust.edu.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:HwEQrADn7s6VGSxnEhREAQ--.50568S2
Authentication-Results: app2; spf=neutral smtp.mail=dzm91@hust.edu.cn;
X-Coremail-Antispam: 1UD129KBjvJXoW7WrWfZFW7KryfJry3ur1DAwb_yoW8JFy5pF
	Wqgr1xX3WrtF1Uu3s7Kr4j9F1UuFs2ga1UWF17t3Z0vFn3J3Wxtw1FqrWIgF17ArWvvFy5
	WF1Fk34FqFy7AFJanT9S1TB71UUUUjJqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQSb7Iv0xC_Cr1lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
	cIk0rVWrJVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjx
	v20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK
	6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1ln4kS14v26r
	126r1DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI
	12xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj64x0Y40En7xvr7AKxV
	W8Jr0_Cr1UMcIj6x8ErcxFaVAv8VW8uFyUJr1UMcIj6xkF7I0En7xvr7AKxVW8Jr0_Cr1U
	McvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY1x0262kKe7AKxVWUtVW8Zw
	CF04k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv6cx26r4fZr1UJr1l4I8I3I0E4IkC6x0Y
	z7v_Jr0_Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42
	xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF
	7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUsqjgDUUUU
X-CM-SenderInfo: asqsiiirqrkko6kx23oohg3hdfq/

According to Jinjie Ruan, the description about the prebuilt llvm is
incorrect. Fix this sentence with new understanding.

Link: https://groups.google.com/g/hust-os-kernel-patches/c/GbN5RkVrBho/m/2sC9rAw7BQAJ
Signed-off-by: Dongliang Mu <dzm91@hust.edu.cn>
---
 Documentation/translations/zh_CN/kbuild/llvm.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/translations/zh_CN/kbuild/llvm.rst b/Documentation/translations/zh_CN/kbuild/llvm.rst
index f71092144a26..f87e0181d8e7 100644
--- a/Documentation/translations/zh_CN/kbuild/llvm.rst
+++ b/Documentation/translations/zh_CN/kbuild/llvm.rst
@@ -188,7 +188,7 @@ LLVM 并不支持 Linux 内核所有可支持的架构，同样，即使 LLVM 
 
 我们在 `kernel.org <https://kernel.org/pub/tools/llvm/>`_ 提供预编译的稳定版 LLVM。
 这些版本已经针对 Linux 内核构建，使用配置文件数据进行优化。相较于其他发行版中的 LLVM，它们应该
-能提高内核构建时间。
+能提高内核构建效率。
 
 以下是一些有助于从源代码构建 LLVM 或通过发行版的包管理器获取 LLVM 的链接。
 
-- 
2.43.0


