Return-Path: <linux-kernel+bounces-372729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27D9B9A4C67
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 10:56:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 949EAB227AE
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 08:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BF2B1DEFED;
	Sat, 19 Oct 2024 08:56:25 +0000 (UTC)
Received: from zg8tmja5ljk3lje4ms43mwaa.icoremail.net (zg8tmja5ljk3lje4ms43mwaa.icoremail.net [209.97.181.73])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 766361DE4FE;
	Sat, 19 Oct 2024 08:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.97.181.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729328185; cv=none; b=PYxHLk3EhiQtON5rqYOYcN9NP0uyjQEV9m6R0J79fZ4EZoZq90KYWB05MyfGGT3AAFE+YFiEvRXDW1gS+ZSzwEr5HrJQF8bwPtgmaDbE3+ypm2C4BSPWR3mw5rJa5ZFVnLk6P5X1NvHMOA02mwz67qwgETMRs4AdNOUDt1AUNVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729328185; c=relaxed/simple;
	bh=bVLBN8at33uFZ4Z5AY2kKe9DOyH6BntE5wsJr9ZhQJw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JmC3fLZ9R+OHudgC98FoJYjxJjuU9Bh+7H7Vl3Ff3p0AAoFgZjX1C1GsDjjgWL9MZ2C9dfj8pTRdRCEns9QxrdL3NWYLjFeNBZlMjaRk0Hy3HTcGusC5yA0+9QtvIWQpLtL+8gO/aDbSaMy3XVsfQgaBoJdnuaCucBYYWlJVxWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn; spf=pass smtp.mailfrom=hust.edu.cn; arc=none smtp.client-ip=209.97.181.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hust.edu.cn
Received: from hust.edu.cn (unknown [172.16.0.50])
	by app2 (Coremail) with SMTP id HwEQrAD3nxQmdBNnBVEaAQ--.14007S2;
	Sat, 19 Oct 2024 16:56:06 +0800 (CST)
Received: from pride-PowerEdge-R740.. (unknown [222.20.126.129])
	by gateway (Coremail) with SMTP id _____wAH8UIMdBNnstxuAA--.62062S6;
	Sat, 19 Oct 2024 16:56:06 +0800 (CST)
From: Dongliang Mu <dzm91@hust.edu.cn>
To: si.yanteng@linux.dev,
	alexs@kernel.org,
	corbet@lwn.net,
	Yanteng Si <siyanteng@loongson.cn>,
	Dongliang Mu <dzm91@hust.edu.cn>
Cc: hust-os-kernel-patches@googlegroups.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5/6] docs/zh_CN: update the translation of mm/page_table_check.rst
Date: Sat, 19 Oct 2024 16:54:55 +0800
Message-ID: <68b62a5713d5a465f09226c1a607dee7ec76a6aa.1729327831.git.dzm91@hust.edu.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1729327831.git.dzm91@hust.edu.cn>
References: <cover.1729327831.git.dzm91@hust.edu.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:HwEQrAD3nxQmdBNnBVEaAQ--.14007S2
Authentication-Results: app2; spf=neutral smtp.mail=dzm91@hust.edu.cn;
X-Coremail-Antispam: 1UD129KBjvJXoW7ZF4rCw1xuw4xtrWrtF4rAFb_yoW8uFyxp3
	Wvg34xWFW5Ca45Z3y7C34jvry8AF4fJay7Xr1xKa1vqw1kA3y8AF4DKr1qqan7tryrZF9a
	9F4Y9FW5Gr4Yy3JanT9S1TB71UUUUjDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQab7Iv0xC_Cr1lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
	cIk0rVWrJVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjx
	v20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwA2z4x0Y4vE
	x4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAaw2AFwI0_JF
	0_Jw1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF
	0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0EF7xvrVAajcxG14v26r
	4UJVWxJr1lYx0E74AGY7Cv6cx26r4fZr1UJr1lYx0Ec7CjxVAajcxG14v26r4UJVWxJr1l
	Ox8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxkF7I0En4kS14v26r126r1DMx
	AIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_GFW3Jr1UJwCFx2IqxVCFs4IE7xkE
	bVWUJVW8JwCFI7km07C267AKxVWrXVW3AwC20s026c02F40E14v26r1j6r18MI8I3I0E74
	80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0
	I7IYx2IY67AKxVW5JVW7JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04
	k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7Cj
	xVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jfvtZUUUUU=
X-CM-SenderInfo: asqsiiirqrkko6kx23oohg3hdfq/

Update to commit 8430557fc584 ("mm/page_table_check: support
userfault wr-protect entries")

scripts/checktransupdate.py reports:

Documentation/translations/zh_CN/mm/page_table_check.rst
commit 8430557fc584 ("mm/page_table_check: support userfault wr-protect
entries")
commit 81a31a860bb6 ("mm: page_table_check: Make it dependent on
EXCLUSIVE_SYSTEM_RAM")
commit ee86588960e2 ("docs/mm: remove useless markup")
3 commits needs resolving in total

Signed-off-by: Dongliang Mu <dzm91@hust.edu.cn>
---
 .../translations/zh_CN/mm/page_table_check.rst      | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/translations/zh_CN/mm/page_table_check.rst b/Documentation/translations/zh_CN/mm/page_table_check.rst
index e8077310a76c..dc34570dceff 100644
--- a/Documentation/translations/zh_CN/mm/page_table_check.rst
+++ b/Documentation/translations/zh_CN/mm/page_table_check.rst
@@ -54,3 +54,16 @@
 
 可以选择用PAGE_TABLE_CHECK_ENFORCED来构建内核，以便在没有额外的内核参数的情况下获得页表
 支持。
+
+实现注意事项
+============
+
+我们特意决定不使用 VMA 信息，以避免依赖于 MM 状态（除了有限的 “struct page” 信息）。页表检查
+独立于 Linux-MM 状态机，它验证用户可访问的页面不会被错误地共享。
+
+PAGE_TABLE_CHECK 依赖于 EXCLUSIVE_SYSTEM_RAM。原因在于，若没有 EXCLUSIVE_SYSTEM_RAM，
+用户被允许通过 /dev/mem 将任意物理内存区域映射到用户空间。同时，页面可能在映射到用户空间期间
+改变自己的属性（例如，从匿名页面变为命名页面），导致页表检查检测到“损坏”。
+
+即使有 EXCLUSIVE_SYSTEM_RAM，I/O 页面可能仍然被允许通过 /dev/mem 映射。然而，这些页面始终
+被视为命名页面，所以它们不会破坏页表检查中使用的逻辑。
-- 
2.43.0


