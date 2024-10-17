Return-Path: <linux-kernel+bounces-369900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BCEA9A2435
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 15:47:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC4B2B24A97
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 13:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C36111DE3A6;
	Thu, 17 Oct 2024 13:47:07 +0000 (UTC)
Received: from zg8tmja2lje4os4yms4ymjma.icoremail.net (zg8tmja2lje4os4yms4ymjma.icoremail.net [206.189.21.223])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E46DC147;
	Thu, 17 Oct 2024 13:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.21.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729172827; cv=none; b=Z5sK2O/B2syNFRzRFbFKx1wQEczxtcqprWPkT2JQDy3qWEcKleSIsTfzZSIzmPQHatZOs/1G4kngavuRj2FzQCAaS+wUr8KO85Wr78E1RhOUi6Y0CVHMWnQIZfwzxCFtyoNCcCpMMaTXfmylTADXW8IuYLNSkZLV0ws9kiiyH6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729172827; c=relaxed/simple;
	bh=RKvrVhWuW0oEQ9TYgL2vOW8X6Ewhct/BYylygYF4WuU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CtZKYkEjP6nUb8BQYa58qGgwrTZko9FhWBz/zlTCt5aMb4kk74cD4vj4QPnId260aN16ErmIADAYpaOsLkvz4IFvKK2XpU0kLcnI5KIuvBQO9VanLDEebLxHwIgtiJI7o+Lv1iq7N32ciSmszfONTtR78G9kSCPNGwbG7U0HC6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn; spf=pass smtp.mailfrom=hust.edu.cn; arc=none smtp.client-ip=206.189.21.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hust.edu.cn
Received: from hust.edu.cn (unknown [172.16.0.52])
	by app2 (Coremail) with SMTP id HwEQrAAXH88rFRFnMyIWAQ--.15126S2;
	Thu, 17 Oct 2024 21:46:19 +0800 (CST)
Received: from pride-PowerEdge-R740.. (unknown [222.20.126.129])
	by gateway (Coremail) with SMTP id _____wB3e80pFRFnNYFMAA--.51036S2;
	Thu, 17 Oct 2024 21:46:18 +0800 (CST)
From: Dongliang Mu <dzm91@hust.edu.cn>
To: Alex Shi <alexs@kernel.org>,
	Yanteng Si <siyanteng@loongson.cn>,
	Jonathan Corbet <corbet@lwn.net>,
	Dongliang Mu <dzm91@hust.edu.cn>
Cc: hust-os-kernel-patches@googlegroups.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] docs/zh_CN: update the translation of process/email-clients.rst
Date: Thu, 17 Oct 2024 21:46:04 +0800
Message-ID: <20241017134611.3482754-1-dzm91@hust.edu.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:HwEQrAAXH88rFRFnMyIWAQ--.15126S2
Authentication-Results: app2; spf=neutral smtp.mail=dzm91@hust.edu.cn;
X-Coremail-Antispam: 1UD129KBjvJXoW7AFWfKF47urWUWw4rGF18uFg_yoW8KF1Dpr
	nrKFyxta18Ga4UtFWUGryv9ry8AFyfGrW7JF97JwnFqrs5tw40vFsIyrnxXF93Kr10ya45
	XryDKr90vr1UuFUanT9S1TB71UUUUj7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQSb7Iv0xC_Zr1lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
	cIk0rVWrJVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjx
	v20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK
	6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1ln4kS14v26r
	126r1DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI
	12xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj64x0Y40En7xvr7AKxV
	W8Jr0_Cr1UMcIj6x8ErcxFaVAv8VW8uFyUJr1UMcIj6xkF7I0En7xvr7AKxVW8Jr0_Cr1U
	McvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY1x0262kKe7AKxVWUAVWUtw
	CF04k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv6cx26r4fZr1UJr1l4I8I3I0E4IkC6x0Y
	z7v_Jr0_Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42
	xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF
	7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU3YFADUUUU
X-CM-SenderInfo: asqsiiirqrkko6kx23oohg3hdfq/

Update to commit 91031ca349ee ("docs: improve comment consistency in
.muttrc example configuration")

scripts/checktranstatus.py reports:

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


