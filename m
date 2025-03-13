Return-Path: <linux-kernel+bounces-558915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D9A1AA5ED07
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 08:30:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2870B1748BC
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 07:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F8A822DFA2;
	Thu, 13 Mar 2025 07:30:24 +0000 (UTC)
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2DA322DF95
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 07:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.216.63.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741851024; cv=none; b=JWtZn5DFqQnaVQiHw1nQlU/r/0hYwTR3sndfZhXRXZt+lnt4mMYl1dtuy9azKht3r1zKXRrEfoa9g0avlGpZ7CgX8etM3fH8GKSMfXsPYhfmfmQlUy9qCBBK0+qVk1NuhkXtfTbRv7MMLi9eT8yXusbga+gWaVyfW2eqg0rF3hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741851024; c=relaxed/simple;
	bh=LgcwkCtuF2Bj7bpRCoqVugs+6167YT67viU1v7T1oS4=;
	h=Date:Message-ID:Mime-Version:From:To:Cc:Subject:Content-Type; b=BZiL6KYSCUfB9IKmgevDOTF4jMzG7lGSC16kPOM6lwJkPTQMWh8YesOsjgLTyy+UcMcA/ELFWyGXgSyuYwwDRfDVpUr/8WejhbBbR0fBvAvcaGVJZL+beIo38fPBR7gFYZjiaoAt80+fBZ+FKxGyV5Jdrdx3+kqMOb8IgR8QCBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=63.216.63.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4ZCzfv649Dz8R04F;
	Thu, 13 Mar 2025 15:30:15 +0800 (CST)
Received: from xaxapp02.zte.com.cn ([10.88.97.241])
	by mse-fl2.zte.com.cn with SMTP id 52D7U4F9001072;
	Thu, 13 Mar 2025 15:30:04 +0800 (+08)
	(envelope-from ye.xingchen@zte.com.cn)
Received: from mapi (xaxapp04[null])
	by mapi (Zmail) with MAPI id mid31;
	Thu, 13 Mar 2025 15:30:06 +0800 (CST)
Date: Thu, 13 Mar 2025 15:30:06 +0800 (CST)
X-Zmail-TransId: 2afb67d2897e712-c609d
X-Mailer: Zmail v1.0
Message-ID: <202503131530063539XBMkqa4y8t8Gbdie-DRn@zte.com.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <ye.xingchen@zte.com.cn>
To: <tglx@linutronix.de>
Cc: <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIIHYyXSBnZW5pcnE6IEZpeCBwYXJhbWV0ZXIgdHlwZSBpbiBkZWNsYXJhdGlvbiBhbmQgZGVmaW5pdGlvbg==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 52D7U4F9001072
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 67D28987.002/4ZCzfv649Dz8R04F

From: YeXingchen <ye.xingchen@zte.com.cn>

The declaration of irq_set_irqchip_state in the header file uses
bool state as the parameter type, while the definition uses bool val.

This patch aligns the parameter name in the definition with the
declaration,changing val to state to ensure consistency.

Signed-off-by: YeXingchen <ye.xingchen@zte.com.cn>
---
 kernel/irq/manage.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index f300bb6be3bd..fc44c2df8d01 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -2860,7 +2860,7 @@ EXPORT_SYMBOL_GPL(irq_get_irqchip_state);
  *	interrupt controller has per-cpu registers.
  */
 int irq_set_irqchip_state(unsigned int irq, enum irqchip_irq_state which,
-			  bool val)
+			  bool state)
 {
 	struct irq_desc *desc;
 	struct irq_data *data;
-- 
2.25.1

