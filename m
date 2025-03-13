Return-Path: <linux-kernel+bounces-559888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F729A5FAD1
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 17:08:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE95719C4493
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 16:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77C3C26FA66;
	Thu, 13 Mar 2025 16:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yr8yL4Nn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2GKbHPKL"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8D926E959
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 16:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741881639; cv=none; b=M9c+gF5+cq4JoxICQsDbuBD2KSrDsoRy1ANiZB1ECZEJOsfDN/m3NVAYc/uE0vPVaaU09oSxb9RPT31lcx7wngI/gYlxyL4S8tGNYWfbcdO9qyzsoOZbqsPC45mo8fZ3lJ8SXiH579nXmGfNe2W5H0KvXkuh6hL3oDEGB6t2IyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741881639; c=relaxed/simple;
	bh=bMN+DbojOy5B0OswHaeBgYwVxoMnEJCouo/AuqNgNy8=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=XBun9/Lrk1AiXuCyHRGH0b5XZGNChxxWQHZlIYU7P5X+AunoXpAwH9f64xHL9F9l6DJmi3PhZn5iUtqriOgYcovrWP9aA/dsSic749wPxahC8y3Fm6Gq5XiPtz/JRnSFukgX5BA3PGrwz5n1o4nlz4uXr92pnSph9kNG8Q3SG/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yr8yL4Nn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2GKbHPKL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250313155915.997259133@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741881636;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=2EVkz1rcKBRf6XF592WLPXvWWe+ptpgPbWZ56FdYztM=;
	b=yr8yL4NnSvcTKEFZ7buctpHapGv7WDDLFwguHj6k1jJh1yL/Pv9Ipgi4UmCGKQGJ3E22UK
	n/LDNuAOMYxeHe2hBM7knY0lktkhB02HsbRcETEsgj1AwjQPmn6mD9cMMsvaVfKE1DcTHF
	Vb1/bwtw/eRJPoTzDKIgHypttIPfYWX1th1jOQhTE4ZQT6+V+vkfilG5r8kuERJ4vaOkbL
	WuihRE3TUG58JUi9UhMVROInbof4QWfPp10kVqbFPvvbT9JGCgTSBZ3l8D07mHrMFiUIjH
	OZY2nwrdKtwYJimnnX1D9zEvGG0j1mJgNWY8mTXTo6TuSFQG38Em8HXOAsZzhw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741881636;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=2EVkz1rcKBRf6XF592WLPXvWWe+ptpgPbWZ56FdYztM=;
	b=2GKbHPKLw+ygJPiOD/SaG/Hfd0TMLB/MtRL6CiP6HM436TYYS09/SKwBg4aBjO+VTJ/hLU
	Mo2137yxySBlDGCg==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
 Jiri Slaby <jirislaby@kernel.org>
Subject: [patch 31/46] genirq/manage: Rework irq_update_affinity_desc()
References: <20250313154615.860723120@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Thu, 13 Mar 2025 17:00:35 +0100 (CET)

Use the new guards to get and lock the interrupt descriptor and tidy up the
code.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/irq/manage.c |   76 +++++++++++++++++++++-------------------------------
 1 file changed, 32 insertions(+), 44 deletions(-)

--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -393,14 +393,8 @@ int irq_set_affinity_locked(struct irq_d
  * an interrupt which is already started or which has already been configured
  * as managed will also fail, as these mean invalid init state or double init.
  */
-int irq_update_affinity_desc(unsigned int irq,
-			     struct irq_affinity_desc *affinity)
+int irq_update_affinity_desc(unsigned int irq, struct irq_affinity_desc *affinity)
 {
-	struct irq_desc *desc;
-	unsigned long flags;
-	bool activated;
-	int ret = 0;
-
 	/*
 	 * Supporting this with the reservation scheme used by x86 needs
 	 * some more thought. Fail it for now.
@@ -408,44 +402,38 @@ int irq_update_affinity_desc(unsigned in
 	if (IS_ENABLED(CONFIG_GENERIC_IRQ_RESERVATION_MODE))
 		return -EOPNOTSUPP;
 
-	desc = irq_get_desc_buslock(irq, &flags, 0);
-	if (!desc)
-		return -EINVAL;
-
-	/* Requires the interrupt to be shut down */
-	if (irqd_is_started(&desc->irq_data)) {
-		ret = -EBUSY;
-		goto out_unlock;
-	}
-
-	/* Interrupts which are already managed cannot be modified */
-	if (irqd_affinity_is_managed(&desc->irq_data)) {
-		ret = -EBUSY;
-		goto out_unlock;
+	scoped_irqdesc_get_and_buslock(irq, 0) {
+		struct irq_desc *desc = scoped_irqdesc;
+		bool activated;
+
+		/* Requires the interrupt to be shut down */
+		if (irqd_is_started(&desc->irq_data))
+			return -EBUSY;
+
+		/* Interrupts which are already managed cannot be modified */
+		if (irqd_affinity_is_managed(&desc->irq_data))
+			return -EBUSY;
+		/*
+		 * Deactivate the interrupt. That's required to undo
+		 * anything an earlier activation has established.
+		 */
+		activated = irqd_is_activated(&desc->irq_data);
+		if (activated)
+			irq_domain_deactivate_irq(&desc->irq_data);
+
+		if (affinity->is_managed) {
+			irqd_set(&desc->irq_data, IRQD_AFFINITY_MANAGED);
+			irqd_set(&desc->irq_data, IRQD_MANAGED_SHUTDOWN);
+		}
+
+		cpumask_copy(desc->irq_common_data.affinity, &affinity->mask);
+
+		/* Restore the activation state */
+		if (activated)
+			irq_domain_activate_irq(&desc->irq_data, false);
+		return 0;
 	}
-
-	/*
-	 * Deactivate the interrupt. That's required to undo
-	 * anything an earlier activation has established.
-	 */
-	activated = irqd_is_activated(&desc->irq_data);
-	if (activated)
-		irq_domain_deactivate_irq(&desc->irq_data);
-
-	if (affinity->is_managed) {
-		irqd_set(&desc->irq_data, IRQD_AFFINITY_MANAGED);
-		irqd_set(&desc->irq_data, IRQD_MANAGED_SHUTDOWN);
-	}
-
-	cpumask_copy(desc->irq_common_data.affinity, &affinity->mask);
-
-	/* Restore the activation state */
-	if (activated)
-		irq_domain_activate_irq(&desc->irq_data, false);
-
-out_unlock:
-	irq_put_desc_busunlock(desc, flags);
-	return ret;
+	return -EINVAL;
 }
 
 static int __irq_set_affinity(unsigned int irq, const struct cpumask *mask,


