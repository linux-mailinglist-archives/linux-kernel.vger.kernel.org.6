Return-Path: <linux-kernel+bounces-559863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B9CBA5FAA6
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 17:02:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A21717F3A5
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 16:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7643026AAA1;
	Thu, 13 Mar 2025 15:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aIkOL2hm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QN8w/sWM"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F30FB26A1D9
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 15:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741881597; cv=none; b=VbwhO4/j8RfKb2+PekB7qogBK1O3Hix9jK+7TKjpOlk3yvLw3QzB0KADrnPTiYswitEZK6e9zNVXe4gM5GHrgd7d9fGdihWS5JNmIhrTDwbr8VpS09s3fbizRuBLS3MgpJkdOxi81PzCwyzvDn272qr0qjl82d0kiZUwcqt6yBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741881597; c=relaxed/simple;
	bh=DqjGaG060lF4aE2timc47zvNhiw+mtiVztFT0F/eGLg=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=Y5N2zNQP4KHt7T+t07+H3NVNcT9EFZWlvkqdCkQtvA+RCdAD0s9K4N5ASEmECS4hw3At9/Gdw5bwdecFbYof0MHWKtlj1yT1s2xFSpYutXmCjtMRts6tyYpxOolcvp5Az3cgUXtZOPTn0eW/55BkQjjOpn9frK4nxM/18nJdWTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aIkOL2hm; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QN8w/sWM; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250313155914.342607279@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741881594;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=eulrkW/jQcxUqYO5aduwRSys83VZim01riXzxasZFKM=;
	b=aIkOL2hmvLadgFwu/m/H0lvxHDyXZLhPSU/+Cl7OePQgijFguatGm82yAUHV5vI1QVbGV9
	uVSFEPnq1fzKuOXP9DuVEoJv539VxAF4Ju1EpeGMQvCRQ7kZfcQhEcKXaMVawRJtylnsCL
	uiD/rkrDjn9M9D8WUd8CBoq8KZaamdPP6KqptL497Z+tu28tw231JIYyrPj1lbbywrl93B
	k4Gt2VqDJdZjZQx3NFmZwAQuESXpQs/4xjYVK8PLaIvqXoUDwWBlRveAz1VQXnNgfyxAwr
	crEcX/yRnph+G9c3rkdLo88htOk3ZRvEwdkuxzHvRiY7GUt1yvDwyH5NWxuOgA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741881594;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=eulrkW/jQcxUqYO5aduwRSys83VZim01riXzxasZFKM=;
	b=QN8w/sWMR3AKYciupC4gtP2YzscR1AL87lp+RhO2XkG83iMW1toWTUwg/WK0YMpy3w7h7R
	4jyVrStgnqvRK4Aw==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
 Jiri Slaby <jirislaby@kernel.org>
Subject: [patch 07/46] genirq/spurious: Cleanup code
References: <20250313154615.860723120@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Thu, 13 Mar 2025 16:59:53 +0100 (CET)

Clean up the coding style

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/irq/spurious.c |   74 ++++++++++++++++++--------------------------------
 1 file changed, 28 insertions(+), 46 deletions(-)

--- a/kernel/irq/spurious.c
+++ b/kernel/irq/spurious.c
@@ -34,8 +34,9 @@ static atomic_t irq_poll_active;
  * true and let the handler run.
  */
 bool irq_wait_for_poll(struct irq_desc *desc)
-	__must_hold(&desc->lock)
 {
+	lockdep_assert_held(&desc->lock);
+
 	if (WARN_ONCE(irq_poll_cpu == smp_processor_id(),
 		      "irq poll in progress on cpu %d for irq %d\n",
 		      smp_processor_id(), desc->irq_data.irq))
@@ -157,8 +158,7 @@ static void poll_spurious_irqs(struct ti
 			 continue;
 
 		/* Racy but it doesn't matter */
-		state = desc->istate;
-		barrier();
+		state = READ_ONCE(desc->istate);
 		if (!(state & IRQS_SPURIOUS_DISABLED))
 			continue;
 
@@ -168,8 +168,7 @@ static void poll_spurious_irqs(struct ti
 	}
 out:
 	atomic_dec(&irq_poll_active);
-	mod_timer(&poll_spurious_irq_timer,
-		  jiffies + POLL_SPURIOUS_IRQ_INTERVAL);
+	mod_timer(&poll_spurious_irq_timer, jiffies + POLL_SPURIOUS_IRQ_INTERVAL);
 }
 
 static inline int bad_action_ret(irqreturn_t action_ret)
@@ -195,15 +194,12 @@ static void __report_bad_irq(struct irq_
 	struct irqaction *action;
 	unsigned long flags;
 
-	if (bad_action_ret(action_ret)) {
-		printk(KERN_ERR "irq event %d: bogus return value %x\n",
-				irq, action_ret);
-	} else {
-		printk(KERN_ERR "irq %d: nobody cared (try booting with "
-				"the \"irqpoll\" option)\n", irq);
-	}
+	if (bad_action_ret(action_ret))
+		pr_err("irq event %d: bogus return value %x\n", irq, action_ret);
+	else
+		pr_err("irq %d: nobody cared (try booting with the \"irqpoll\" option)\n", irq);
 	dump_stack();
-	printk(KERN_ERR "handlers:\n");
+	pr_err("handlers:\n");
 
 	/*
 	 * We need to take desc->lock here. note_interrupt() is called
@@ -213,11 +209,10 @@ static void __report_bad_irq(struct irq_
 	 */
 	raw_spin_lock_irqsave(&desc->lock, flags);
 	for_each_action_of_desc(desc, action) {
-		printk(KERN_ERR "[<%p>] %ps", action->handler, action->handler);
+		pr_err("[<%p>] %ps", action->handler, action->handler);
 		if (action->thread_fn)
-			printk(KERN_CONT " threaded [<%p>] %ps",
-					action->thread_fn, action->thread_fn);
-		printk(KERN_CONT "\n");
+			pr_cont(" threaded [<%p>] %ps", action->thread_fn, action->thread_fn);
+		pr_cont("\n");
 	}
 	raw_spin_unlock_irqrestore(&desc->lock, flags);
 }
@@ -232,18 +227,17 @@ static void report_bad_irq(struct irq_de
 	}
 }
 
-static inline int
-try_misrouted_irq(unsigned int irq, struct irq_desc *desc,
-		  irqreturn_t action_ret)
+static inline bool try_misrouted_irq(unsigned int irq, struct irq_desc *desc,
+				     irqreturn_t action_ret)
 {
 	struct irqaction *action;
 
 	if (!irqfixup)
-		return 0;
+		return false;
 
 	/* We didn't actually handle the IRQ - see if it was misrouted? */
 	if (action_ret == IRQ_NONE)
-		return 1;
+		return true;
 
 	/*
 	 * But for 'irqfixup == 2' we also do it for handled interrupts if
@@ -251,19 +245,16 @@ try_misrouted_irq(unsigned int irq, stru
 	 * traditional PC timer interrupt.. Legacy)
 	 */
 	if (irqfixup < 2)
-		return 0;
+		return false;
 
 	if (!irq)
-		return 1;
+		return true;
 
 	/*
 	 * Since we don't get the descriptor lock, "action" can
-	 * change under us.  We don't really care, but we don't
-	 * want to follow a NULL pointer. So tell the compiler to
-	 * just load it once by using a barrier.
+	 * change under us.
 	 */
-	action = desc->action;
-	barrier();
+	action = READ_ONCE(desc->action);
 	return action && (action->flags & IRQF_IRQPOLL);
 }
 
@@ -273,8 +264,7 @@ void note_interrupt(struct irq_desc *des
 {
 	unsigned int irq;
 
-	if (desc->istate & IRQS_POLL_INPROGRESS ||
-	    irq_settings_is_polled(desc))
+	if (desc->istate & IRQS_POLL_INPROGRESS || irq_settings_is_polled(desc))
 		return;
 
 	if (bad_action_ret(action_ret)) {
@@ -420,13 +410,12 @@ void note_interrupt(struct irq_desc *des
 		/*
 		 * Now kill the IRQ
 		 */
-		printk(KERN_EMERG "Disabling IRQ #%d\n", irq);
+		pr_emerg("Disabling IRQ #%d\n", irq);
 		desc->istate |= IRQS_SPURIOUS_DISABLED;
 		desc->depth++;
 		irq_disable(desc);
 
-		mod_timer(&poll_spurious_irq_timer,
-			  jiffies + POLL_SPURIOUS_IRQ_INTERVAL);
+		mod_timer(&poll_spurious_irq_timer, jiffies + POLL_SPURIOUS_IRQ_INTERVAL);
 	}
 	desc->irqs_unhandled = 0;
 }
@@ -436,11 +425,9 @@ bool noirqdebug __read_mostly;
 int noirqdebug_setup(char *str)
 {
 	noirqdebug = 1;
-	printk(KERN_INFO "IRQ lockup detection disabled\n");
-
+	pr_info("IRQ lockup detection disabled\n");
 	return 1;
 }
-
 __setup("noirqdebug", noirqdebug_setup);
 module_param(noirqdebug, bool, 0644);
 MODULE_PARM_DESC(noirqdebug, "Disable irq lockup detection when true");
@@ -452,12 +439,10 @@ static int __init irqfixup_setup(char *s
 		return 1;
 	}
 	irqfixup = 1;
-	printk(KERN_WARNING "Misrouted IRQ fixup support enabled.\n");
-	printk(KERN_WARNING "This may impact system performance.\n");
-
+	pr_warn("Misrouted IRQ fixup support enabled.\n");
+	pr_warn("This may impact system performance.\n");
 	return 1;
 }
-
 __setup("irqfixup", irqfixup_setup);
 module_param(irqfixup, int, 0644);
 
@@ -468,11 +453,8 @@ static int __init irqpoll_setup(char *st
 		return 1;
 	}
 	irqfixup = 2;
-	printk(KERN_WARNING "Misrouted IRQ fixup and polling support "
-				"enabled\n");
-	printk(KERN_WARNING "This may significantly impact system "
-				"performance\n");
+	pr_warn("Misrouted IRQ fixup and polling support enabled\n");
+	pr_warn("This may significantly impact system performance\n");
 	return 1;
 }
-
 __setup("irqpoll", irqpoll_setup);


