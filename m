Return-Path: <linux-kernel+bounces-370800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7B8E9A3238
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 03:47:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9145A1F23F65
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 01:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 480AD7DA79;
	Fri, 18 Oct 2024 01:47:11 +0000 (UTC)
Received: from zg8tmja2lje4os4yms4ymjma.icoremail.net (zg8tmja2lje4os4yms4ymjma.icoremail.net [206.189.21.223])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04C9B2E64A;
	Fri, 18 Oct 2024 01:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.21.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729216030; cv=none; b=T3lw/YNoN696YcepHyK4znnGZNEDvFv3ZcLvj1HnBn0hcOoLHv/Xr744pelsdMpgau3Nkb5jFjAvURTCDmhXimU/tkC8P9OaLVP+WwvRSf1qVRGq6jB1P0EFKxDyGYGYoqLgIDm4VAhGOzPZB9/uIq1uwxXuSerAnr/FrwGJ7Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729216030; c=relaxed/simple;
	bh=qEyhMsKmfdSxJ8v9at5pASGUiqPhNVZJFoLbUOpK6JQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lJAgDyss4zJ9WyXBFuLLQdRVD5TSNAPclNxi6uzM+lBOu02W+JHgUMx0AFMVtjbMTrci4L/8n9ZYki8MIAtdugg+w+BQ01gAvxbhSdtx7lcKqlHltdXUiifbbvNeyt8TJP/qgBe3SSolmOM49mxaYKknvTihZPxDUttS6y88+YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn; spf=pass smtp.mailfrom=hust.edu.cn; arc=none smtp.client-ip=206.189.21.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hust.edu.cn
Received: from hust.edu.cn (unknown [172.16.0.50])
	by app2 (Coremail) with SMTP id HwEQrAA3PwP4vRFnS0sXAQ--.48358S2;
	Fri, 18 Oct 2024 09:46:32 +0800 (CST)
Received: from pride-PowerEdge-R740.. (unknown [222.20.126.129])
	by gateway (Coremail) with SMTP id _____wDH0EH1vRFn9PxgAA--.44896S2;
	Fri, 18 Oct 2024 09:46:30 +0800 (CST)
From: Dongliang Mu <dzm91@hust.edu.cn>
To: si.yanteng@linux.dev,
	Alex Shi <alexs@kernel.org>,
	Yanteng Si <siyanteng@loongson.cn>,
	Jonathan Corbet <corbet@lwn.net>,
	SeongJae Park <sj@kernel.org>,
	Dongliang Mu <dzm91@hust.edu.cn>,
	Federico Vaga <federico.vaga@vaga.pv.it>,
	Thorsten Blum <thorsten.blum@toblux.com>
Cc: hust-os-kernel-patches@googlegroups.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] docs/zh_CN: update the translation of process/coding-style.rst
Date: Fri, 18 Oct 2024 09:46:01 +0800
Message-ID: <20241018014609.3781089-1-dzm91@hust.edu.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:HwEQrAA3PwP4vRFnS0sXAQ--.48358S2
Authentication-Results: app2; spf=neutral smtp.mail=dzm91@hust.edu.cn;
X-Coremail-Antispam: 1UD129KBjvJXoW7Ww1kZF1DCw4Dtr1xWr17Wrg_yoW8Ar1DpF
	y7Kr1xGa18CryUC3yxG348Xr48GFn7Jay5Kr4agwnaqFs5CFyIvrW3tF9Yva47XrWvvay5
	XF43CrW8Cw1F9aUanT9S1TB71UUUUbUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

Update to commit c5d436f05a3f ("docs/process: fix typos")

scripts/checktransupdate.py reports:

Documentation/translations/zh_CN/process/coding-style.rst
commit c5d436f05a3f ("docs/process: fix typos")
commit 82b8000c28b5 ("net: drop special comment style")
2 commits needs resolving in total

Signed-off-by: Dongliang Mu <dzm91@hust.edu.cn>
---
v1->v2: revise the script name
 .../translations/zh_CN/process/coding-style.rst       | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/Documentation/translations/zh_CN/process/coding-style.rst b/Documentation/translations/zh_CN/process/coding-style.rst
index 10b9cb4f6a65..0484d0c65c25 100644
--- a/Documentation/translations/zh_CN/process/coding-style.rst
+++ b/Documentation/translations/zh_CN/process/coding-style.rst
@@ -560,17 +560,6 @@ Documentation/translations/zh_CN/doc-guide/index.rst 和 scripts/kernel-doc 。
 	 * with beginning and ending almost-blank lines.
 	 */
 
-对于在 net/ 和 drivers/net/ 的文件，首选的长 (多行) 注释风格有些不同。
-
-.. code-block:: c
-
-	/* The preferred comment style for files in net/ and drivers/net
-	 * looks like this.
-	 *
-	 * It is nearly the same as the generally preferred comment style,
-	 * but there is no initial almost-blank line.
-	 */
-
 注释数据也是很重要的，不管是基本类型还是衍生类型。为了方便实现这一点，每一行
 应只声明一个数据 (不要使用逗号来一次声明多个数据)。这样你就有空间来为每个数据
 写一段小注释来解释它们的用途了。
-- 
2.43.0


