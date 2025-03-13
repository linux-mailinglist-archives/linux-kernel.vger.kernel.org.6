Return-Path: <linux-kernel+bounces-558972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 029C9A5EDCE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 09:18:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC9F8189EB62
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 08:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 589171EEA46;
	Thu, 13 Mar 2025 08:18:13 +0000 (UTC)
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A239F1EE013
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 08:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.216.63.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741853893; cv=none; b=ElGq1QfKb30huSC3yTOMGEWLcBDbqdHlMn1u5LBXu1E5p+Vn05W0msueoW40NPkDMPQ2IBtr59SVEiUokAU4SwppXQ1dV9rGBc+jgs5rbbcfCPh4P4wxKxR9Mm0q2vjQkMUtvm8i+ucQnv1GkmGs9ku56TU/qhjbfBmOSmW2TR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741853893; c=relaxed/simple;
	bh=UYv6sXTLSYGy56Rt3iZProysE/6ieVNaFvEFHmfo9AY=;
	h=Date:Message-ID:Mime-Version:From:To:Cc:Subject:Content-Type; b=sXdTGuTdCat13o7hx4yH4NflPFE8KFW7mNRUJ0OupU5aaSy7a8HhttXDombAe5aB5VdX+XkiHsgkQhb10wMPPlE1zVYFBlS1K9lX8qFwF5lzwOz8S8fW+Ro49JctpvtdE0cxM3/+PtRXeehRyONZfB6CJfUpBBPBABYVvj9RdIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=63.216.63.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4ZD0k840mRz5B1G1;
	Thu, 13 Mar 2025 16:18:08 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.99.176])
	by mse-fl2.zte.com.cn with SMTP id 52D8I142091338;
	Thu, 13 Mar 2025 16:18:01 +0800 (+08)
	(envelope-from ye.xingchen@zte.com.cn)
Received: from mapi (xaxapp02[null])
	by mapi (Zmail) with MAPI id mid31;
	Thu, 13 Mar 2025 16:18:03 +0800 (CST)
Date: Thu, 13 Mar 2025 16:18:03 +0800 (CST)
X-Zmail-TransId: 2afa67d294bb416-20d47
X-Mailer: Zmail v1.0
Message-ID: <20250313161803777QVS2cRAMUHinpoDwqg1XZ@zte.com.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <ye.xingchen@zte.com.cn>
To: <tglx@linutronix.de>
Cc: <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIIHYzXSBnZW5pcnE6IEZpeCBwYXJhbWV0ZXIgdHlwZSBpbiBkZWNsYXJhdGlvbiBhbmQgZGVmaW5pdGlvbg==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 52D8I142091338
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 67D294C0.000/4ZD0k840mRz5B1G1

From: YeXingchen <ye.xingchen@zte.com.cn>

The declaration of irq_set_irqchip_state in the header file uses
bool state as the parameter type, while the definition uses bool val.

This patch aligns the parameter name in the definition with the
declaration,changing val to state to ensure consistency.

Signed-off-by: YeXingchen <ye.xingchen@zte.com.cn>
---
v1->v3
fix the patch and patameter
 kernel/irq/manage.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index f300bb6be3bd..3008f14f4db2 100644
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
@@ -2890,7 +2890,7 @@ int irq_set_irqchip_state(unsigned int irq, enum irqchip_irq_state which,
 	} while (data);

 	if (data)
-		err = chip->irq_set_irqchip_state(data, which, val);
+		err = chip->irq_set_irqchip_state(data, which, state);

 out_unlock:
 	irq_put_desc_busunlock(desc, flags);
-- 
2.25.1

