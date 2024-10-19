Return-Path: <linux-kernel+bounces-372728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A8D39A4C65
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 10:56:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 235B31C212BE
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 08:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 074841DE8AE;
	Sat, 19 Oct 2024 08:56:24 +0000 (UTC)
Received: from zg8tmja2lje4os4yms4ymjma.icoremail.net (zg8tmja2lje4os4yms4ymjma.icoremail.net [206.189.21.223])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7545418C34D;
	Sat, 19 Oct 2024 08:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.21.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729328183; cv=none; b=KNm8hd2GTn5INOcFlaPgVvaw6yI4x5Yh7CKS7k7x9lKAv0bP4mdGuODbMAuP6y0kI1yKGmmPmLJMXrYhZOuilubU4vCffzEIeY03ZwW1STeg8SYf2tTYZ7+Vz7quU0Mzxt8iMszXDnQaz+BHydIH1KttB9tZaktJKoRGg71DqWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729328183; c=relaxed/simple;
	bh=+f5mpupx+uPqvl4kzVJHmOmdb5sLaDqTOwYifxQYQiw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oVIXTuRwZayOuI6GYMN+7CjztkBs3PYzbivbfMOHArXUoti6xUUXXyfBjsBZ6yuDEc4Zd5wjYMRdrxF+bijvGDJX2wtgkWims/gXEyp6PWf2UaqBl0zSmHVUcAGzlIgLE/Ys/40jxv8aKUwA5zRmWfsv0bFgfMZldGzoK8/2dDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn; spf=pass smtp.mailfrom=hust.edu.cn; arc=none smtp.client-ip=206.189.21.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hust.edu.cn
Received: from hust.edu.cn (unknown [172.16.0.50])
	by app2 (Coremail) with SMTP id HwEQrAAnL88ddBNn8VAaAQ--.6642S2;
	Sat, 19 Oct 2024 16:55:57 +0800 (CST)
Received: from pride-PowerEdge-R740.. (unknown [222.20.126.129])
	by gateway (Coremail) with SMTP id _____wAH8UIMdBNnstxuAA--.62062S4;
	Sat, 19 Oct 2024 16:55:56 +0800 (CST)
From: Dongliang Mu <dzm91@hust.edu.cn>
To: si.yanteng@linux.dev,
	alexs@kernel.org,
	corbet@lwn.net,
	Yanteng Si <siyanteng@loongson.cn>,
	Dongliang Mu <dzm91@hust.edu.cn>
Cc: hust-os-kernel-patches@googlegroups.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] docs/zh_CN: update the translation of mm/admon/faq.rst
Date: Sat, 19 Oct 2024 16:54:53 +0800
Message-ID: <20e7e17b18542ecbf924234ed40438b95345e514.1729327831.git.dzm91@hust.edu.cn>
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
X-CM-TRANSID:HwEQrAAnL88ddBNn8VAaAQ--.6642S2
Authentication-Results: app2; spf=neutral smtp.mail=dzm91@hust.edu.cn;
X-Coremail-Antispam: 1UD129KBjvJXoW7CFWrCw4kXF4kGF45CFyrXrb_yoW8tr1Dp3
	sakr97Ka48tFyUXr1UGryUZF18JFW7GFW3Jry8J3WDXrsYy3y8Kw4jyry8JFy3Wa48AF98
	Jr18CryrZFy2vrUanT9S1TB71UUUUjDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQab7Iv0xC_Cr1lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
	cIk0rVWrJVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjx
	v20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwA2z4x0Y4vE
	x4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAaw2AFwI0_JF
	0_Jw1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF
	0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0EF7xvrVAajcxG14v26r
	4UJVWxJr1lYx0E74AGY7Cv6cx26r4fZr1UJr1lYx0Ec7CjxVAajcxG14v26r4UJVWxJr1l
	Ox8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxkF7I0En4kS14v26r126r1DMx
	AIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_GFW3Jr1UJwCFx2IqxVCFs4IE7xkE
	bVWUJVW8JwCFI7km07C267AKxVW8ZVWrXwC20s026c02F40E14v26r1j6r18MI8I3I0E74
	80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0
	I7IYx2IY67AKxVW5JVW7JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04
	k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7Cj
	xVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jfvtZUUUUU=
X-CM-SenderInfo: asqsiiirqrkko6kx23oohg3hdfq/

Update to commit c6bb975aa60b ("Docs/mm/damon/faq: remove old questions")

scripts/checktransupdate.py reports:

Documentation/translations/zh_CN/mm/damon/faq.rst
commit c6bb975aa60b ("Docs/mm/damon/faq: remove old questions")
1 commits needs resolving in total

Signed-off-by: Dongliang Mu <dzm91@hust.edu.cn>
---
 .../translations/zh_CN/mm/damon/faq.rst         | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/Documentation/translations/zh_CN/mm/damon/faq.rst b/Documentation/translations/zh_CN/mm/damon/faq.rst
index de4be417494a..234d63f4f072 100644
--- a/Documentation/translations/zh_CN/mm/damon/faq.rst
+++ b/Documentation/translations/zh_CN/mm/damon/faq.rst
@@ -13,23 +13,6 @@
 常见问题
 ========
 
-为什么是一个新的子系统，而不是扩展perf或其他用户空间工具？
-==========================================================
-
-首先，因为它需要尽可能的轻量级，以便可以在线使用，所以应该避免任何不必要的开销，如内核-用户
-空间的上下文切换成本。第二，DAMON的目标是被包括内核在内的其他程序所使用。因此，对特定工具
-（如perf）的依赖性是不可取的。这就是DAMON在内核空间实现的两个最大的原因。
-
-
-“闲置页面跟踪” 或 “perf mem” 可以替代DAMON吗？
-==============================================
-
-闲置页跟踪是物理地址空间访问检查的一个低层次的原始方法。“perf mem”也是类似的，尽管它可以
-使用采样来减少开销。另一方面，DAMON是一个更高层次的框架，用于监控各种地址空间。它专注于内
-存管理优化，并提供复杂的精度/开销处理机制。因此，“空闲页面跟踪” 和 “perf mem” 可以提供
-DAMON输出的一个子集，但不能替代DAMON。
-
-
 DAMON是否只支持虚拟内存？
 =========================
 
-- 
2.43.0


