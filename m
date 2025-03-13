Return-Path: <linux-kernel+bounces-559861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 640ACA5FAAB
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 17:03:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BCD919C5813
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 16:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D0A326A1AF;
	Thu, 13 Mar 2025 15:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Z6ei5Uwu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oVYS5euJ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448E226A0E3
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 15:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741881593; cv=none; b=YME/RK6M7aIwe6Nz/J8YNkL4e7Rw7iUoAQyGjIPUZdM1VhyMgRRouRKEwG6PdPYXqGQgx5mH1ptf07Ig+7LIlMwjzDFYMqRa4uGQL0GaO8nsEU/NMn38UEynqnPuIu6QMwj9Zf6So/EtsJKKSF301oPpYelSFrj39YWaeMadeog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741881593; c=relaxed/simple;
	bh=4P2AYZaXXdHY79QfXZ8TNnbeCKt3muYA/QNuktSJAdc=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=kzIifooESYXgLWF8pEgRnh0huipUQ9RbIEFs+RTBkORg+3nWHQzo/EUJg5Scx2GVoMN2+srXSS4PiuM3nMJDUkj/cnlooodcljZmdTYaGFSOlWsDZdfcPNYDijlLwEMEzGjzeDrdjQMmZRzHe9N4qtMakdftwzJxHN0m9siELzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Z6ei5Uwu; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oVYS5euJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250313155914.210122456@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741881590;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=5LJQpMqIMYF5gjpITVf0v/W1X83bXVrvdfpXmhehpyk=;
	b=Z6ei5UwuxBHWaWp0mhNDq+1N3AOqAtKf1E7KRi5fakSV/z9NtCOuzGStiwFTtg0Vmrvw8E
	CvgWCeY+aUCnXbTrlUexjvx3OquXqc3Kwffj7/gJ65gBCCOicN/itTr4gTa9x5xCnhD6lL
	KxrNkybiL7TiATc0iC/lpqkFKrMemiLIgONXo8A7BPQ6YRCyjRtyb8H3E5Lgx3cNiot0c2
	TNWwl4aBw1Cta8mg9B32Cl2ygJ2ZC7TQ+oMEtRbTECKWiBkuKxyTM+3Agm7yn+OOc7QsjC
	a9MEPNrBEVWPUZBHwxXtmH0suCGZ3+IVLv+C/f/FFDWTdSBT5ztr3brdoS97Jg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741881590;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=5LJQpMqIMYF5gjpITVf0v/W1X83bXVrvdfpXmhehpyk=;
	b=oVYS5euJfiY3zIHmtfz8GuICfzy1663pm/qP0jkskJc3ToUPZFL55opp6xXgb0cWtAg4io
	00yi2XkCm9S/WsCg==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
 Jiri Slaby <jirislaby@kernel.org>
Subject: [patch 05/46] genirq/resend: Switch to lock guards
References: <20250313154615.860723120@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Thu, 13 Mar 2025 16:59:49 +0100 (CET)

Convert all lock/unlock pairs to guards and tidy up the code.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/irq/resend.c |   50 +++++++++++++++++++++-----------------------------
 1 file changed, 21 insertions(+), 29 deletions(-)

--- a/kernel/irq/resend.c
+++ b/kernel/irq/resend.c
@@ -30,18 +30,17 @@ static DEFINE_RAW_SPINLOCK(irq_resend_lo
  */
 static void resend_irqs(struct tasklet_struct *unused)
 {
-	struct irq_desc *desc;
-
-	raw_spin_lock_irq(&irq_resend_lock);
+	guard(raw_spinlock_irq)(&irq_resend_lock);
 	while (!hlist_empty(&irq_resend_list)) {
-		desc = hlist_entry(irq_resend_list.first, struct irq_desc,
-				   resend_node);
+		struct irq_desc *desc;
+
+		desc = hlist_entry(irq_resend_list.first, struct irq_desc,  resend_node);
 		hlist_del_init(&desc->resend_node);
+
 		raw_spin_unlock(&irq_resend_lock);
 		desc->handle_irq(desc);
 		raw_spin_lock(&irq_resend_lock);
 	}
-	raw_spin_unlock_irq(&irq_resend_lock);
 }
 
 /* Tasklet to handle resend: */
@@ -75,19 +74,18 @@ static int irq_sw_resend(struct irq_desc
 	}
 
 	/* Add to resend_list and activate the softirq: */
-	raw_spin_lock(&irq_resend_lock);
-	if (hlist_unhashed(&desc->resend_node))
-		hlist_add_head(&desc->resend_node, &irq_resend_list);
-	raw_spin_unlock(&irq_resend_lock);
+	scoped_guard (raw_spinlock, &irq_resend_lock) {
+		if (hlist_unhashed(&desc->resend_node))
+			hlist_add_head(&desc->resend_node, &irq_resend_list);
+	}
 	tasklet_schedule(&resend_tasklet);
 	return 0;
 }
 
 void clear_irq_resend(struct irq_desc *desc)
 {
-	raw_spin_lock(&irq_resend_lock);
+	guard(raw_spinlock)(&irq_resend_lock);
 	hlist_del_init(&desc->resend_node);
-	raw_spin_unlock(&irq_resend_lock);
 }
 
 void irq_resend_init(struct irq_desc *desc)
@@ -172,30 +170,24 @@ int check_irq_resend(struct irq_desc *de
  */
 int irq_inject_interrupt(unsigned int irq)
 {
-	struct irq_desc *desc;
-	unsigned long flags;
-	int err;
+	int err = -EINVAL;
 
 	/* Try the state injection hardware interface first */
 	if (!irq_set_irqchip_state(irq, IRQCHIP_STATE_PENDING, true))
 		return 0;
 
 	/* That failed, try via the resend mechanism */
-	desc = irq_get_desc_buslock(irq, &flags, 0);
-	if (!desc)
-		return -EINVAL;
+	scoped_irqdesc_get_and_buslock(irq, 0) {
+		struct irq_desc *desc = scoped_irqdesc;
 
-	/*
-	 * Only try to inject when the interrupt is:
-	 *  - not NMI type
-	 *  - activated
-	 */
-	if (irq_is_nmi(desc) || !irqd_is_activated(&desc->irq_data))
-		err = -EINVAL;
-	else
-		err = check_irq_resend(desc, true);
-
-	irq_put_desc_busunlock(desc, flags);
+		/*
+		 * Only try to inject when the interrupt is:
+		 *  - not NMI type
+		 *  - activated
+		 */
+		if (!irq_is_nmi(desc) && irqd_is_activated(&desc->irq_data))
+			err = check_irq_resend(desc, true);
+	}
 	return err;
 }
 EXPORT_SYMBOL_GPL(irq_inject_interrupt);


