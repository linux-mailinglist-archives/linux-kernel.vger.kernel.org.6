Return-Path: <linux-kernel+bounces-369670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96C7B9A20C3
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 13:15:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4297E1F2244B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 11:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E17F1DA636;
	Thu, 17 Oct 2024 11:15:27 +0000 (UTC)
Received: from zg8tmja5ljk3lje4ms43mwaa.icoremail.net (zg8tmja5ljk3lje4ms43mwaa.icoremail.net [209.97.181.73])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45FCA1CEE90;
	Thu, 17 Oct 2024 11:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.97.181.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729163726; cv=none; b=u2ktgu+oucGUj4Z4y+/PmfN8FxP6GDudnSGrfeuPHn6xqAbKOdTUVFmnH4EeOXLSlz2wJWGxWqx/aOOdMg4GDCbQNHFttbCw8XvNLJBfLZl7mw7zVHvh+47sc94NMlUMkcHp+J/nxsiTgKBihMN95gzA3x/LNKc6y/0ohLzfhjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729163726; c=relaxed/simple;
	bh=io3/4Cf0bUYtw09lEEcZFmcKlRORHsNz0B8fR6hP6ds=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=g4xJJeYBkL8M5MxSly/VGPez1tZ9Pw2LM9Eznk9BsrFRE7IoSuvfvdTklIt3lX/HLYW8QbynJnpYD5QMdz78CE3i1L5KSK9HMNTA7vM0ZHU4LlU7uP1y3hCVK2N/4bLrdVKziJya60Q71gQmrpXTh/Ce02npMoEoV+YQHVJ44dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn; spf=pass smtp.mailfrom=hust.edu.cn; arc=none smtp.client-ip=209.97.181.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hust.edu.cn
Received: from hust.edu.cn (unknown [172.16.0.52])
	by app1 (Coremail) with SMTP id HgEQrAB3fjqZ8RBnQTbxBw--.60027S2;
	Thu, 17 Oct 2024 19:14:33 +0800 (CST)
Received: from pride-PowerEdge-R740.. (unknown [222.20.126.129])
	by gateway (Coremail) with SMTP id _____wC3sMeS8RBnaGNLAA--.49481S2;
	Thu, 17 Oct 2024 19:14:28 +0800 (CST)
From: Dongliang Mu <dzm91@hust.edu.cn>
To: Alex Shi <alexs@kernel.org>,
	Yanteng Si <siyanteng@loongson.cn>,
	Jonathan Corbet <corbet@lwn.net>,
	Dongliang Mu <dzm91@hust.edu.cn>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Cc: hust-os-kernel-patches@googlegroups.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] docs/zh_CN: update the translation of process/submitting-patches.rst
Date: Thu, 17 Oct 2024 19:14:12 +0800
Message-ID: <20241017111419.3396605-1-dzm91@hust.edu.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:HgEQrAB3fjqZ8RBnQTbxBw--.60027S2
Authentication-Results: app1; spf=neutral smtp.mail=dzm91@hust.edu.cn;
X-Coremail-Antispam: 1UD129KBjvJXoWxZryUJrWDWr4rtFWxtry5Jwb_yoWrGry7pF
	s29343J3W8KF1rJ3yxGay8ZF18J3WkCF9rGrZrt3WSyFs5Ka9Fv3sIqryfWFW3t3s5KFy7
	ZFs2qr1vgry2vrDanT9S1TB71UUUUjDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQab7Iv0xC_tr1lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
	cIk0rVWrJVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjx
	v20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK
	6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1ln4kS14v26r
	126r1DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI
	12xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj64x0Y40En7xvr7AKxV
	W8Jr0_Cr1UMcIj6x8ErcxFaVAv8VW8uFyUJr1UMcIj6xkF7I0En7xvr7AKxVW8Jr0_Cr1U
	McvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY1x0262kKe7AKxVWUAVWUtw
	CF04k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv6cx26r4fZr1UJr1l4I8I3I0E4IkC6x0Y
	z7v_Jr0_Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42
	xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF
	7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07jhcTQUUUUU=
X-CM-SenderInfo: asqsiiirqrkko6kx23oohg3hdfq/

Update to commit eb5ed2fae197 ("docs: submitting-patches: Advertise b4")

scripts/checktranstatus.py reports:

Documentation/translations/zh_CN/process/submitting-patches.rst
commit eb5ed2fae197 ("docs: submitting-patches: Advertise b4")
commit 413e775efaec ("Documentation: fix links to mailing list services")
2 commits needs resolving in total

Signed-off-by: Dongliang Mu <dzm91@hust.edu.cn>
---
 .../zh_CN/process/submitting-patches.rst      | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/Documentation/translations/zh_CN/process/submitting-patches.rst b/Documentation/translations/zh_CN/process/submitting-patches.rst
index 7ca16bda3709..f7ae584a439e 100644
--- a/Documentation/translations/zh_CN/process/submitting-patches.rst
+++ b/Documentation/translations/zh_CN/process/submitting-patches.rst
@@ -105,7 +105,7 @@ xyzzy do frotz”或“[I]changed xyzzy to do frotz”，就好像你在命令
 当链接到邮件列表存档时，请首选lore.kernel.org邮件存档服务。用邮件中的
 ``Message-ID`` 头（去掉尖括号）可以创建链接URL。例如::
 
-    Link: https://lore.kernel.org/r/30th.anniversary.repost@klaava.Helsinki.FI/
+    Link: https://lore.kernel.org/30th.anniversary.repost@klaava.Helsinki.FI
 
 请检查该链接以确保可用且指向正确的邮件。
 
@@ -195,11 +195,8 @@ scripts/get_maintainer.pl在这个步骤中非常有用。如果您找不到正
 在MAINTAINERS文件中查找子系统特定的列表；您的补丁可能会在那里得到更多的关注。
 不过，请不要发送垃圾邮件到无关的列表。
 
-许多与内核相关的列表托管在vger.kernel.org上；您可以在
-http://vger.kernel.org/vger-lists.html 上找到它们的列表。不过，也有与内核相关
-的列表托管在其他地方。
-
-不要一次发送超过15个补丁到vger邮件列表！！！！
+许多与内核相关的列表托管在 kernel.org 上；您可以在 https://subspace.kernel.org
+上找到它们的列表。不过，也有与内核相关的列表托管在其他地方。
 
 Linus Torvalds是决定改动能否进入 Linux 内核的最终裁决者。他的邮件地址是
 torvalds@linux-foundation.org 。他收到的邮件很多，所以一般来说最好 **别**
@@ -621,6 +618,13 @@ Fixes: 指示补丁修复了之前提交的一个问题。它可以便于确定
 的工作所基于的树的提交哈希。你应该在封面邮件或系列的第一个补丁中添加它，它应
 该放在 ``---`` 行的下面或所有其他内容之后，即只在你的电子邮件签名之前。
 
+工具
+----
+
+这个过程的许多技术方面可以使用 b4 自动完成，其文档可在
+https://b4.docs.kernel.org/en/latest/ 查看。该工具可帮助处理诸如追踪依赖项、运行
+checkpatch 以及格式化和发送邮件等事务。
+
 参考文献
 --------
 
@@ -643,9 +647,6 @@ Greg Kroah-Hartman，“如何惹恼内核子系统维护人员”
 
   <http://www.kroah.com/log/linux/maintainer-06.html>
 
-不！！！别再发巨型补丁炸弹给linux-kernel@vger.kernel.org的人们了！
-  <https://lore.kernel.org/r/20050711.125305.08322243.davem@davemloft.net>
-
 内核 Documentation/translations/zh_CN/process/coding-style.rst
 
 Linus Torvalds关于标准补丁格式的邮件
-- 
2.43.0


