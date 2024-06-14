Return-Path: <linux-kernel+bounces-214986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3663C908CF3
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 16:04:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB4E6B254D9
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 14:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 939FB9441;
	Fri, 14 Jun 2024 14:04:05 +0000 (UTC)
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [52.237.72.81])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B27419D88F;
	Fri, 14 Jun 2024 14:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.237.72.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718373845; cv=none; b=mIINQYPJyGhp3D4rJTuerzmW4Oc3A5EleGH8RBXnkFe5v67RxiNQ4Jgid8hzTLd2J26h/07rHU3rVRqKQU2/Kz+V1gg2nYzvIh/2cCAN1wHJVzkYsqMN+q+4eK+OUez2sBNTPGw5MnXdZRBXN68DBw12PZROLuhuxz89BuHOvyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718373845; c=relaxed/simple;
	bh=rkF0k1RwPPKSYFrEbPqHA/ISHzb5dgdUG2YoZmRGpOs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=krUqAYtIL50u8YAygdQtws5oJup16iTn0ryULR/Ie2pWKY9YEZO3AXA2xuF+OBStsnbSsIXRfuj79r2O1sALWnOxKJC2qvYyNSY85HQJEvFccMOQ7w4VoEPplUlT8lFBEy9YKot1wZpAiGIKW+8rGA+VM91kvWbr4yu6Oco174E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn; spf=pass smtp.mailfrom=hust.edu.cn; arc=none smtp.client-ip=52.237.72.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hust.edu.cn
Received: from hust.edu.cn (unknown [172.16.0.52])
	by app1 (Coremail) with SMTP id HgEQrAB3eyqyTWxmpTbhBw--.18080S2;
	Fri, 14 Jun 2024 22:03:30 +0800 (CST)
Received: from pride-PowerEdge-R740.. (unknown [222.20.126.129])
	by gateway (Coremail) with SMTP id _____wBXbyWxTWxm3_gXAQ--.29981S2;
	Fri, 14 Jun 2024 22:03:30 +0800 (CST)
From: Dongliang Mu <dzm91@hust.edu.cn>
To: Alex Shi <alexs@kernel.org>,
	Yanteng Si <siyanteng@loongson.cn>,
	Jonathan Corbet <corbet@lwn.net>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Dongliang Mu <dzm91@hust.edu.cn>,
	Qing Zhang <zhangqing@loongson.cn>,
	Huacai Chen <chenhuacai@kernel.org>
Cc: Marco Elver <elver@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] docs/zh_CN: add back the missing part in the English version
Date: Fri, 14 Jun 2024 22:03:20 +0800
Message-ID: <20240614140326.3028384-1-dzm91@hust.edu.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:HgEQrAB3eyqyTWxmpTbhBw--.18080S2
Authentication-Results: app1; spf=neutral smtp.mail=dzm91@hust.edu.cn;
X-Coremail-Antispam: 1UD129KBjvJXoW7KF4UZw4DJFyxXr4UJF4UCFg_yoW8Zw4Dpr
	97GryxJFy8Zry3Jry3CF4DGFyUAF1xGayUCFySgw1avr1UJrW7tr42kF98KFyxWry0yFyj
	9F4FkFWUCr1qy3JanT9S1TB71UUUUjJqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQIb7Iv0xC_Cr1lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
	cIk0rVWrJVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjx
	v20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwA2z4x0Y4vE
	x4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAaw2AFwI0_JF
	0_Jw1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF
	0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0EF7xvrVAajcxG14v26F
	4j6r4UJwAv7VCjz48v1sIEY20_GFW3Jr1UJwAv7VCY1x0262k0Y48FwI0_Gr1j6F4UJwAm
	72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxVAaw2AFwI0_Jw0_GFyl42
	xK82IYc2Ij64vIr41l42xK82IY6x8ErcxFaVAv8VW8uFyUJr1UMxC20s026xCaFVCjc4AY
	6r1j6r4UMxCIbckI1I0E14v26r126r1DMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x02
	67AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IUbW89tUUUUU==
X-CM-SenderInfo: asqsiiirqrkko6kx23oohg3hdfq/

The zh_CN kasan document misses the code change in commit eefe68280c94
("kasan: Add documentation for CONFIG_KASAN_EXTRA_INFO").

Fix this by adding the translation of the missing part.

Note that this missing commit is found by checktransupdate.py

Signed-off-by: Dongliang Mu <dzm91@hust.edu.cn>
---
 .../translations/zh_CN/dev-tools/kasan.rst     | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/translations/zh_CN/dev-tools/kasan.rst b/Documentation/translations/zh_CN/dev-tools/kasan.rst
index 2b1e8f74904b..4491ad2830ed 100644
--- a/Documentation/translations/zh_CN/dev-tools/kasan.rst
+++ b/Documentation/translations/zh_CN/dev-tools/kasan.rst
@@ -235,6 +235,24 @@ slab对象的描述以及关于访问的内存页的信息。
 通用KASAN还报告两个辅助调用堆栈跟踪。这些堆栈跟踪指向代码中与对象交互但不直接
 出现在错误访问堆栈跟踪中的位置。目前，这包括 call_rcu() 和排队的工作队列。
 
+CONFIG_KASAN_EXTRA_INFO
+~~~~~~~~~~~~~~~~~~~~~~~
+
+启用 CONFIG_KASAN_EXTRA_INFO 选项允许 KASAN 记录和报告更多信息。目前支持的
+额外信息包括分配和释放时的 CPU 编号和时间戳。更多的信息可以帮助找到内核错误的原因，
+并将错误与其他系统事件关联起来，但代价是用额外的内存来记录更多信息（有关更多
+开销的细节，请参见 CONFIG_KASAN_EXTRA_INFO 选项的帮助文本）。
+
+以下为 CONFIG_KASAN_EXTRA_INFO 开启后的报告（仅显示不同部分）::
+
+    ==================================================================
+    ...
+    Allocated by task 134 on cpu 5 at 229.133855s:
+    ...
+    Freed by task 136 on cpu 3 at 230.199335s:
+    ...
+    ==================================================================
+
 实施细则
 --------
 
-- 
2.43.0


