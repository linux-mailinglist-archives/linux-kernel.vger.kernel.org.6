Return-Path: <linux-kernel+bounces-559869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55F1AA5FAAD
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 17:03:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 731144208F4
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 16:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2C8F269898;
	Thu, 13 Mar 2025 16:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lQDCu2J0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="D4uDVth+"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D43C26B945
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 16:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741881608; cv=none; b=N1DQSLa6tuBfOUz+v11fGBJM3xNij4nhcZBU19A2osJ7dskZICi1doMhnL5xU4USOyKEVlFayH0VoRvPgU1nY2UwyXvIkBJzrreJ/Y3MMODWEaGKnVsFQxzpqIRqV9XFkyZAdkjna7KsHe14aRcEiVX8q3fzazvl1BVw/vGt4b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741881608; c=relaxed/simple;
	bh=3j1UdluVBUaeENfQD/hEHlLRA6hs7QQlt4dExfD1TsA=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=Rug9g9fk7z7UaUJFXQZz39cRnpgv2mNR/cGSfT930eLwwwkz5PGVOQd2n1Z7GJdhYiQJBp7EjLwc3PuxZcvn6zvgpAGVvlZ9ltFuHXq74y/Z0qYS4Th7cm1bqYd6niIQwzO9l9JPJcF3Sth3GJNCm4HINsTntmNYZu6xKqjdbZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lQDCu2J0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=D4uDVth+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250313155914.743439508@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741881604;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=sICWpqh1x/oGKWN5RIIzAEe0Urq6dmsBpoEtBZUP36g=;
	b=lQDCu2J0seZ1qw1ztaeeGl1YPiWrmdMQU3ewCveDsxTb1+LHfSiev4csRAYkqUs9Vve2BJ
	5thoy/ZgzFam9P+o6EirndAqfljX5avsM10QPvVRFQuWzTXSImXRnFgmRx04jGSfulwBw0
	9OPAUH1U//jTflQ4z8GSI1x5FMODqgQqtLxHCd+clpjlCNAC+Ip6At9OB8Q5UULQ4Ph73t
	oQOKYE6s0GYNLDM/p/DsEc3TJNqCiMLIrbiHIJRyu8rhIiaEF44kfYCg0uL0x1eggwDQ9r
	tX69vtnzlvkY3WxFypnhnuRqqBmdTOFhLbVv7/8FMRkz5vKOS/xJtupgf3xV4Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741881604;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=sICWpqh1x/oGKWN5RIIzAEe0Urq6dmsBpoEtBZUP36g=;
	b=D4uDVth+tc5n2c9aOhI+FL6Ltfch+vt+fNtmX94wBLB0CJV1kbZPbCsvjNIOLX06K+JP9R
	A8TwxxyC/bxXO+Bw==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
 Jiri Slaby <jirislaby@kernel.org>
Subject: [patch 13/46] genirq/chip: Rework handle_simple_irq()
References: <20250313154615.860723120@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Thu, 13 Mar 2025 17:00:04 +0100 (CET)

Use the new helpers to decide whether the interrupt should be handled and
switch the descriptor locking to guard().

Fixup the kernel doc comment while at it.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/irq/chip.c |   30 ++++++++++--------------------
 1 file changed, 10 insertions(+), 20 deletions(-)

--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -538,35 +538,25 @@ void handle_nested_irq(unsigned int irq)
 EXPORT_SYMBOL_GPL(handle_nested_irq);
 
 /**
- *	handle_simple_irq - Simple and software-decoded IRQs.
- *	@desc:	the interrupt description structure for this irq
+ * handle_simple_irq - Simple and software-decoded IRQs.
+ * @desc:	the interrupt description structure for this irq
  *
- *	Simple interrupts are either sent from a demultiplexing interrupt
- *	handler or come from hardware, where no interrupt hardware control
- *	is necessary.
+ * Simple interrupts are either sent from a demultiplexing interrupt
+ * handler or come from hardware, where no interrupt hardware control is
+ * necessary.
  *
- *	Note: The caller is expected to handle the ack, clear, mask and
- *	unmask issues if necessary.
+ * Note: The caller is expected to handle the ack, clear, mask and unmask
+ * issues if necessary.
  */
 void handle_simple_irq(struct irq_desc *desc)
 {
-	raw_spin_lock(&desc->lock);
+	guard(raw_spinlock)(&desc->lock);
 
-	if (!irq_can_handle_pm(desc))
-		goto out_unlock;
-
-	desc->istate &= ~(IRQS_REPLAY | IRQS_WAITING);
-
-	if (unlikely(!desc->action || irqd_irq_disabled(&desc->irq_data))) {
-		desc->istate |= IRQS_PENDING;
-		goto out_unlock;
-	}
+	if (!irq_can_handle(desc))
+		return;
 
 	kstat_incr_irqs_this_cpu(desc);
 	handle_irq_event(desc);
-
-out_unlock:
-	raw_spin_unlock(&desc->lock);
 }
 EXPORT_SYMBOL_GPL(handle_simple_irq);
 


