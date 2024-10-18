Return-Path: <linux-kernel+bounces-370804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC0B79A3243
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 03:49:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 912211F23F76
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 01:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 239BC84D02;
	Fri, 18 Oct 2024 01:49:33 +0000 (UTC)
Received: from sgoci-sdnproxy-4.icoremail.net (sgoci-sdnproxy-4.icoremail.net [129.150.39.64])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03F202E64A;
	Fri, 18 Oct 2024 01:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.150.39.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729216172; cv=none; b=ofF5LnXfd6BhlX/v8vpFveqaBucmTw3lwioeCNkdu4TFSAUWkSB0iGX47mb5f+jJPmV+uFsHAGuLjBZ1hA4HbWEab8DiBXCYjr3aw4L3o2hPRtZNZuhYeMrhaMzGrLHPm8cchcDdF3pN+tieb7QwBAp5h4DBtCms5kcW8WCUhes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729216172; c=relaxed/simple;
	bh=Lt/4wEswi50wYeLdKZRBDV2B8BQ79W67NiEasMAgFoU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lXGwA89Eh2L86kiUaKz9aAHhzO2/eOKJLT+/UPKUxuCVx4dxWG3Wpf2G/JqNOzihAI4EwTSB1cBHLZ1HoXtGk4XH31xQG9pdIlx4zSjj49iZKMKc647uX6TZOtUytM8B3uDiH4oA5ekASl0gcU0c+8q1YDi0481E0zzfLRkSf+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn; spf=pass smtp.mailfrom=hust.edu.cn; arc=none smtp.client-ip=129.150.39.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hust.edu.cn
Received: from hust.edu.cn (unknown [172.16.0.50])
	by app1 (Coremail) with SMTP id HgEQrAB3fn6WvhFnZbkACA--.16579S2;
	Fri, 18 Oct 2024 09:49:10 +0800 (CST)
Received: from pride-PowerEdge-R740.. (unknown [222.20.126.129])
	by gateway (Coremail) with SMTP id _____wDnOAyWvhFntQJhAA--.61876S2;
	Fri, 18 Oct 2024 09:49:10 +0800 (CST)
From: Dongliang Mu <dzm91@hust.edu.cn>
To: si.yanteng@linux.dev,
	Alex Shi <alexs@kernel.org>,
	Yanteng Si <siyanteng@loongson.cn>,
	Jonathan Corbet <corbet@lwn.net>,
	Dongliang Mu <dzm91@hust.edu.cn>
Cc: hust-os-kernel-patches@googlegroups.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] docs/zh_CN: update the translation of process/email-clients.rst
Date: Fri, 18 Oct 2024 09:49:01 +0800
Message-ID: <20241018014908.3783976-1-dzm91@hust.edu.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:HgEQrAB3fn6WvhFnZbkACA--.16579S2
Authentication-Results: app1; spf=neutral smtp.mail=dzm91@hust.edu.cn;
X-Coremail-Antispam: 1UD129KBjvJXoW7AFWfGFykur4UGF43Kr4fuFg_yoW8KFWxpr
	nrKFyxta18Ga4UtFWUGryv9ry8AFyfGrW7JF97twnFqrn5tw40vFsIyrnxXF93Kr10ya45
	XryDKr90vryUuFUanT9S1TB71UUUUjDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQSb7Iv0xC_Zr1lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
	cIk0rVWrJVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjx
	v20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK
	6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1ln4kS14v26r
	126r1DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI
	12xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj64x0Y40En7xvr7AKxV
	W8Jr0_Cr1UMcIj6x8ErcxFaVAv8VW8uFyUJr1UMcIj6xkF7I0En7xvr7AKxVW8Jr0_Cr1U
	McvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY1x0262kKe7AKxVWUAVWUtw
	CF04k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv6cx26r4fZr1UJr1l4I8I3I0E4IkC6x0Y
	z7v_Jr0_Gr1l4IxYO2xFxVAFwI0_GFv_Wrylx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42
	xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF
	7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU3YFADUUUU
X-CM-SenderInfo: asqsiiirqrkko6kx23oohg3hdfq/

Update to commit 91031ca349ee ("docs: improve comment consistency in
.muttrc example configuration")

scripts/checktransupdate.py reports:

Documentation/translations/zh_CN/process/email-clients.rst
commit 91031ca349ee ("docs: improve comment consistency in .muttrc
example configuration")
commit 7fe7de7be828 ("Docs/process/email-clients: Document HacKerMaiL")
commit 9c03bc90c065 ("Documentation: process: Revert "Document suitability
of Proton Mail for kernel development"")
commit 1d2ed9234c85 ("Documentation: process: Document suitability of
Proton Mail for kernel development")
4 commits needs resolving in total

Signed-off-by: Dongliang Mu <dzm91@hust.edu.cn>
---
v1->v2: revise the script name
 .../translations/zh_CN/process/email-clients.rst         | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/Documentation/translations/zh_CN/process/email-clients.rst b/Documentation/translations/zh_CN/process/email-clients.rst
index 34d51cdadc7b..a70393089df3 100644
--- a/Documentation/translations/zh_CN/process/email-clients.rst
+++ b/Documentation/translations/zh_CN/process/email-clients.rst
@@ -197,7 +197,7 @@ Mutt不自带编辑器，所以不管你使用什么编辑器，不自动断行
 Mutt 是高度可配置的。 这里是个使用mutt通过 Gmail 发送的补丁的最小配置::
 
   # .muttrc
-  # ================  IMAP ====================
+  # ================  IMAP  ====================
   set imap_user = 'yourusername@gmail.com'
   set imap_pass = 'yourpassword'
   set spoolfile = imaps://imap.gmail.com/INBOX
@@ -325,3 +325,10 @@ Gmail网页客户端自动地把制表符转换为空格。
 另一个问题是Gmail还会把任何含有非ASCII的字符的消息改用base64编码，如欧洲人的
 名字。
 
+HacKerMaiL (TUI)
+****************
+
+HacKerMaiL (hkml) 是一个基于公共收件箱的简单邮件管理工具，它不需要订阅邮件列表。
+该工具由 DAMON 维护者开发和维护，旨在支持 DAMON 和通用内核子系统的基本开发工作
+流程。详细信息可参考 HacKerMaiL 的 README 文件
+(https://github.com/sjp38/hackermail/blob/master/README.md)。
-- 
2.43.0


