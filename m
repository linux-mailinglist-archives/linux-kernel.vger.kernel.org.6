Return-Path: <linux-kernel+bounces-559879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03F41A5FAC7
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 17:07:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31FA13B8933
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 16:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 131EB26E64D;
	Thu, 13 Mar 2025 16:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VJSz1BDa";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LOZJlPKr"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5FFF26E94E
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 16:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741881625; cv=none; b=aXgSJCoKv1ukdqEN5Cs4foxiUcL+A+zINlDr9RAYW37Oz2xSDYELvY5cJ+bEoi/upZlfUq2Fe+eL1r2CC6AyiOL48UUcLYu/+lia8BV+eeTcEwhpwJ2J0Pjn04ODKoSItlyqDIRV19Oc+Mb5/CiVolFYPB6sIIlLzky5H0xrcLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741881625; c=relaxed/simple;
	bh=2oy4+AYag3wkv7a0aA2l4lnImRNYpzll8+i8lyaU+AI=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=pUytxp0i60dHoX7wWQC/N/g8IeomoW6HsW7A4bdJB30OU17itJHtfJls6x9ziCBXrb0GN/QsjNbbMCY7y3PWlJt4twWA9OFvrojPx6pF/E6e9j4g6iXVXOyGYA55Oh+atc61ndiA8CB3wY4BEWGOo4m5OpBaUG16IHyJapLs2i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VJSz1BDa; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LOZJlPKr; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250313155915.368650725@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741881621;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=oqaWp4gFAuFMj1xMvqqWiSZD5kZ9/WoSzBbN7KUn7ec=;
	b=VJSz1BDa5dhf5b2R1y/wok9109SvSKdY24e9spGr80nLHMebTyAopxk2VBYND6Lohl0Eey
	qM3tpz2Xms24ONucWTqr5Njoxox6YepcZ22YWlLzoGQJ7nNrd/s7xltV1JPbGqzt3/39Y0
	NUsxNb9s5P/Hd1esUxV54cgHI+pyjwHs066Ne8Q6ACCYZzBMSVWZyxTKd70qs7ZnnAqQH0
	6GGg6ti/Fl5L2Bqm8XIFZ9cJLSBuq49xBRBCiMBgbAto9kmSKdPMi8GU7JdHnzVk7Z+WEn
	VQqONyqQrlua9LWXpFymnsQVgd/WO7++SyAVWfIqxTupCTycLW2IW+TCMYMeEg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741881621;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=oqaWp4gFAuFMj1xMvqqWiSZD5kZ9/WoSzBbN7KUn7ec=;
	b=LOZJlPKrza1g0WqcNdM5PXQ1UyjeA+uukXZSjd84sMDyletmD2Zt5+3NlEUsjK3AYVex91
	E55mmBZDDK6SCQBw==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
 Jiri Slaby <jirislaby@kernel.org>
Subject: [patch 22/46] genirq/chip: Rework irq_set_chip()
References: <20250313154615.860723120@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Thu, 13 Mar 2025 17:00:20 +0100 (CET)

Use the new guards to get and lock the interrupt descriptor and tidy up the
code.

Fixup the kernel doc comment while at it.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/irq/chip.c |   28 ++++++++++++----------------
 1 file changed, 12 insertions(+), 16 deletions(-)

--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -34,26 +34,22 @@ struct irqaction chained_action = {
 };
 
 /**
- *	irq_set_chip - set the irq chip for an irq
- *	@irq:	irq number
- *	@chip:	pointer to irq chip description structure
+ * irq_set_chip - set the irq chip for an irq
+ * @irq:	irq number
+ * @chip:	pointer to irq chip description structure
  */
 int irq_set_chip(unsigned int irq, const struct irq_chip *chip)
 {
-	unsigned long flags;
-	struct irq_desc *desc = irq_get_desc_lock(irq, &flags, 0);
+	int ret = -EINVAL;
 
-	if (!desc)
-		return -EINVAL;
-
-	desc->irq_data.chip = (struct irq_chip *)(chip ?: &no_irq_chip);
-	irq_put_desc_unlock(desc, flags);
-	/*
-	 * For !CONFIG_SPARSE_IRQ make the irq show up in
-	 * allocated_irqs.
-	 */
-	irq_mark_irq(irq);
-	return 0;
+	scoped_irqdesc_get_and_lock(irq, 0) {
+		scoped_irqdesc->irq_data.chip = (struct irq_chip *)(chip ?: &no_irq_chip);
+		ret = 0;
+	}
+	/* For !CONFIG_SPARSE_IRQ make the irq show up in allocated_irqs. */
+	if (!ret)
+		irq_mark_irq(irq);
+	return ret;
 }
 EXPORT_SYMBOL(irq_set_chip);
 


