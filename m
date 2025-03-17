Return-Path: <linux-kernel+bounces-563420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F484A64167
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 07:27:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71FED168D70
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 06:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64515219A67;
	Mon, 17 Mar 2025 06:27:46 +0000 (UTC)
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A809207E1C
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 06:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.216.63.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742192866; cv=none; b=Q2xebltOwJQDSjaYjr8K5lIWP8wieiNBMlZVH1trvNBq4Ubwl37P22uYU3f7hY24PE7KoAtjuJ1JPh90AoNNQ7bXeu9V0vv83YLUcz55PiF1J+HJPg+Q/fpnq85Gtlz6qCfnljlhnc/00+BDWqDlqfogSz+6eYv31ZFaDWUndcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742192866; c=relaxed/simple;
	bh=lrbStXuhtba/tf2eyBPgbMwjXEqi2WgI8rO58vUZgPY=;
	h=Date:Message-ID:Mime-Version:From:To:Cc:Subject:Content-Type; b=ue3kR7KsYVbTPxGPjEfbXMatxbzfUvfs6GMIaHPbye4uhJHq1DeMDxqmoD3wXwuL+tXmeh8gIFahICGaHUx6A27msefx/NJpekL3X2d3a7RJCv2a/0jaP7AmRX2cWrYKrG+Fw27R44l0cIXMgZJS0BonPZS4Jd7ZfsyKKszC7J0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=63.216.63.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4ZGQ4n3Mxdz8R03x;
	Mon, 17 Mar 2025 14:27:37 +0800 (CST)
Received: from xaxapp02.zte.com.cn ([10.88.97.241])
	by mse-fl2.zte.com.cn with SMTP id 52H6RSwn016175;
	Mon, 17 Mar 2025 14:27:29 +0800 (+08)
	(envelope-from xie.ludan@zte.com.cn)
Received: from mapi (xaxapp04[null])
	by mapi (Zmail) with MAPI id mid32;
	Mon, 17 Mar 2025 14:27:30 +0800 (CST)
Date: Mon, 17 Mar 2025 14:27:30 +0800 (CST)
X-Zmail-TransId: 2afb67d7c0d22ff-847df
X-Mailer: Zmail v1.0
Message-ID: <20250317142730784jyJNa1DQf10K4kIqtJw3w@zte.com.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <xie.ludan@zte.com.cn>
To: <tglx@linutronix.de>
Cc: <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIIGxpbnV4LW5leHRdIGdlbmlycTogdXNlIHN5c2ZzX2VtaXQoKSBpbnN0ZWFkIG9mIHNjbnByaW50ZigpLg==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 52H6RSwn016175
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 67D7C0D9.000/4ZGQ4n3Mxdz8R03x

Date: Fri, 14 Mar 2025 12:05:36 +0800

Follow the advice in Documentation/filesystems/sysfs.rst:
show() should only use sysfs_emit() or sysfs_emit_at() when formatting
the value to be returned to user space.

Signed-off-by: XieLudan <xie.ludan@zte.com.cn>
---
 kernel/irq/irqdesc.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index 287830739783..8ffe12fe5af6 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -257,11 +257,11 @@ static ssize_t per_cpu_count_show(struct kobject *kobj,
 	for_each_possible_cpu(cpu) {
 		unsigned int c = irq_desc_kstat_cpu(desc, cpu);

-		ret += scnprintf(buf + ret, PAGE_SIZE - ret, "%s%u", p, c);
+		ret += sysfs_emit(buf + ret, "%s%u", p, c);
 		p = ",";
 	}

-	ret += scnprintf(buf + ret, PAGE_SIZE - ret, "\n");
+	ret += sysfs_emit(buf + ret, "\n");
 	return ret;
 }
 IRQ_ATTR_RO(per_cpu_count);
@@ -274,7 +274,7 @@ static ssize_t chip_name_show(struct kobject *kobj,

 	raw_spin_lock_irq(&desc->lock);
 	if (desc->irq_data.chip && desc->irq_data.chip->name) {
-		ret = scnprintf(buf, PAGE_SIZE, "%s\n",
+		ret = sysfs_emit(buf, "%s\n",
 				desc->irq_data.chip->name);
 	}
 	raw_spin_unlock_irq(&desc->lock);
@@ -337,7 +337,7 @@ static ssize_t name_show(struct kobject *kobj,

 	raw_spin_lock_irq(&desc->lock);
 	if (desc->name)
-		ret = scnprintf(buf, PAGE_SIZE, "%s\n", desc->name);
+		ret = sysfs_emit(buf, "%s\n", desc->name);
 	raw_spin_unlock_irq(&desc->lock);

 	return ret;
@@ -354,14 +354,14 @@ static ssize_t actions_show(struct kobject *kobj,

 	raw_spin_lock_irq(&desc->lock);
 	for_each_action_of_desc(desc, action) {
-		ret += scnprintf(buf + ret, PAGE_SIZE - ret, "%s%s",
+		ret += sysfs_emit(buf + ret, "%s%s",
 				 p, action->name);
 		p = ",";
 	}
 	raw_spin_unlock_irq(&desc->lock);

 	if (ret)
-		ret += scnprintf(buf + ret, PAGE_SIZE - ret, "\n");
+		ret += sysfs_emit(buf + ret, "\n");

 	return ret;
 }
-- 
2.25.1

