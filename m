Return-Path: <linux-kernel+bounces-559885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A2C5A5FACE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 17:08:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 667D719C5E11
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 16:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02E7B26FA59;
	Thu, 13 Mar 2025 16:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="n0HdXtGe";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VWur79KY"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B719B26F47C
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 16:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741881634; cv=none; b=RxYImvkQDZpRu/UAHEqY7D/Nxu9VdP8b055+PSOXsJvPWQ3HzyTvQ/ARldeYVyxoIyT8qiGNsCV70VW2qzkuP5PIHxFDYnicadujmrrSsrn4UM6vZ/6KkwKP1l96REPXlQ/nzA6i3CZxyRsyg4rCrQz82RxZlJJ38uAmC+H9UN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741881634; c=relaxed/simple;
	bh=Vavl2DtUnnB2ydlyEK1fgQDOt58k/ezEpxVpS0jYlA4=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=Kugw00wsAyrZH56EGCMZdUQlNbrz12xCrjjKYftxs659DePZ6QGZU9LDBm9sjkeDHk8RXhvRaS1StpBOb61z7o5aUfSMzBHocjcv10nWNeqfoVfDCHm/bqMvak/hR3nWnN/7siECmr40W89C76NWjoHIWjykAxOs5zJImaFQCCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=n0HdXtGe; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VWur79KY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250313155915.794856595@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741881631;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=Hm+dYey42J9LEd5L9MWy6SefTDYLCO+AcXSE5xq6HWI=;
	b=n0HdXtGeDk5gBOm4TZjtFSknh1nN2TBQNAHkg54eZ7Cps2D9B3CB+qA+z6y7i3536Z2mN/
	AWsa7dhAYqcj7v2CSQAZfRcEEEwm1UwVkxmozhTbM0T8TLgAIOVP4b98UwkbFvON34MSxp
	rkcGFywKB9iclUl6phqaozoRMP2HZuFOuda55dKZMfKUa1KeFc7lIOBiXuiYDOcar0K0qF
	9Iul5tvCM6X1fj9ZtImclyv/m53tOx1FvfFfG/sm9YpvNQDY5LmPVAwkVUNpNz05yGekjb
	aZL/6P7v0j+3Tsi9qTU2oEQCaqXB9w/1zXz/wFPTMAzCqO9znEEvU7fzEsX0tA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741881631;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=Hm+dYey42J9LEd5L9MWy6SefTDYLCO+AcXSE5xq6HWI=;
	b=VWur79KYFuCYs+Wu2hZJ3IwcoDSqjfSij2jZyAaqQZq2u2EEeY1iP0EC98e3TqW4y6HcQ4
	B/gP6HuM/2aEIdAg==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
 Jiri Slaby <jirislaby@kernel.org>
Subject: [patch 28/46] genirq/chip: Rework irq_modify_status()
References: <20250313154615.860723120@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Thu, 13 Mar 2025 17:00:30 +0100 (CET)

Use the new guards to get and lock the interrupt descriptor and tidy up the
code.

Fixup the kernel doc comment while at it.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/irq/chip.c |   58 +++++++++++++++++++++++++-----------------------------
 1 file changed, 27 insertions(+), 31 deletions(-)

--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -1004,38 +1004,34 @@ EXPORT_SYMBOL_GPL(irq_set_chip_and_handl
 
 void irq_modify_status(unsigned int irq, unsigned long clr, unsigned long set)
 {
-	unsigned long flags, trigger, tmp;
-	struct irq_desc *desc = irq_get_desc_lock(irq, &flags, 0);
+	scoped_irqdesc_get_and_lock(irq, 0) {
+		struct irq_desc *desc = scoped_irqdesc;
+		unsigned long trigger, tmp;
+		/*
+		 * Warn when a driver sets the no autoenable flag on an already
+		 * active interrupt.
+		 */
+		WARN_ON_ONCE(!desc->depth && (set & _IRQ_NOAUTOEN));
+
+		irq_settings_clr_and_set(desc, clr, set);
+
+		trigger = irqd_get_trigger_type(&desc->irq_data);
+
+		irqd_clear(&desc->irq_data, IRQD_NO_BALANCING | IRQD_PER_CPU |
+			   IRQD_TRIGGER_MASK | IRQD_LEVEL);
+		if (irq_settings_has_no_balance_set(desc))
+			irqd_set(&desc->irq_data, IRQD_NO_BALANCING);
+		if (irq_settings_is_per_cpu(desc))
+			irqd_set(&desc->irq_data, IRQD_PER_CPU);
+		if (irq_settings_is_level(desc))
+			irqd_set(&desc->irq_data, IRQD_LEVEL);
+
+		tmp = irq_settings_get_trigger_mask(desc);
+		if (tmp != IRQ_TYPE_NONE)
+			trigger = tmp;
 
-	if (!desc)
-		return;
-
-	/*
-	 * Warn when a driver sets the no autoenable flag on an already
-	 * active interrupt.
-	 */
-	WARN_ON_ONCE(!desc->depth && (set & _IRQ_NOAUTOEN));
-
-	irq_settings_clr_and_set(desc, clr, set);
-
-	trigger = irqd_get_trigger_type(&desc->irq_data);
-
-	irqd_clear(&desc->irq_data, IRQD_NO_BALANCING | IRQD_PER_CPU |
-		   IRQD_TRIGGER_MASK | IRQD_LEVEL);
-	if (irq_settings_has_no_balance_set(desc))
-		irqd_set(&desc->irq_data, IRQD_NO_BALANCING);
-	if (irq_settings_is_per_cpu(desc))
-		irqd_set(&desc->irq_data, IRQD_PER_CPU);
-	if (irq_settings_is_level(desc))
-		irqd_set(&desc->irq_data, IRQD_LEVEL);
-
-	tmp = irq_settings_get_trigger_mask(desc);
-	if (tmp != IRQ_TYPE_NONE)
-		trigger = tmp;
-
-	irqd_set(&desc->irq_data, trigger);
-
-	irq_put_desc_unlock(desc, flags);
+		irqd_set(&desc->irq_data, trigger);
+	}
 }
 EXPORT_SYMBOL_GPL(irq_modify_status);
 


