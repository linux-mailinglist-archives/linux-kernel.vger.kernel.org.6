Return-Path: <linux-kernel+bounces-559712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42DC9A5F873
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 15:35:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 905D119C49C4
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 14:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C987A26AA9B;
	Thu, 13 Mar 2025 14:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Xgxsboqb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xE6ajUEU"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A46268FE2
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 14:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741876282; cv=none; b=YnAYvx0b0OS4aI6ZHbvs2oqP/ptnWK4d9o/bKrTDFCAq4GbMpH2xBhYJk+wKSZny1sGkeRh46OJySAT9WAh1wZ6Do4PEzGJaOraAmd0YYcQBgULP+JKEyyjtoFDQGcEnnoEkszD9urwLJN2Tw7ubuNCNT0cY3gKkjA78NtKH53k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741876282; c=relaxed/simple;
	bh=T7XQKx+q8ClaipQug0jIEZIEuJpDA9f/d9I3/ZBzCJk=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=ngHbjRRMKO6pL7jsRNV9if6FpA4X6SHsBS7D6lyTzgiVcCjXMXYGdxwRSyps5TZpdUqeMGVaZaWDpf1aa+bGAQxaTp/yD25v9oCjWcT31M3FrHbKYw64JA6Ja1Qmdvb5yBhc9QKoKmqAIc8ib5v0K0w8TtkbYJEz1OSpb7VGtzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Xgxsboqb; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xE6ajUEU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250313142524.073826193@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741876278;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=b6xi2K4qzElaL97ZoIu4lP2Q0gu96SOJ6XZrZdkCrVc=;
	b=XgxsboqbA48WXi5Vt1RrHkC+tgHT4Q1XqzVcXnbW5Uo4xqlzNhHk3cCDf2F85bcGx7j5ul
	yqzhXL9fSSjO3tU0ir9hQSOQBfoAyo6w3gjGuSeY9DNAOJsxeucO+ra/xwU+g9ZDq+qm1C
	2A0nYRgLHs4Rj8FNObsmoQ/7BzJtOkrlNIxU4lfxPKN8WbthcfTAEyK2GnzWPBXJPl1Ltq
	1si+BOJgxbFgI0y1Lgs0tFdrF6kt/aHFpGAEFD3Tfdo+7QeYelOZakolCev8crJe9Nyk8r
	bQwWdqUT5rfjjbN60VnOhwk/PK5Zd14OTG4AsBfDhFJWjSOdRghVz4vC/tJSxw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741876278;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=b6xi2K4qzElaL97ZoIu4lP2Q0gu96SOJ6XZrZdkCrVc=;
	b=xE6ajUEUYzmG5dnkXw67ssobNneky5pg8qGkWixSv+RaVNPsqUZ1scxPF65isGNYdq+T0w
	7uYW2PfymRSr6HBQ==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Jiri Slaby <jirislaby@kernel.org>,
 Andrew Lunn <andrew@lunn.ch>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
 Gregory Clement <gregory.clement@bootlin.com>,
 =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 Bartosz Golaszewski <brgl@bgdev.pl>,
 Talel Shenhar <talel@amazon.com>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Guo Ren <guoren@kernel.org>,
 Herve Codina <herve.codina@bootlin.com>,
 Huacai Chen <chenhuacai@kernel.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Chen-Yu Tsai <wens@csie.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>
Subject: [patch 2/7] genirq/generic-chip: Convert core code to lock guards
References: <20250313142404.896902416@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Thu, 13 Mar 2025 15:31:17 +0100 (CET)

Replace the irq_gc_lock/unlock() pairs with guards. There is no point to
implement a guard wrapper for them as they just wrap around raw_spin_lock*().

Switch the other lock instances in the core code to guards as well.

Conversion was done with Coccinelle plus manual fixups.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/irq/generic-chip.c |   47 +++++++++++++++-------------------------------
 1 file changed, 16 insertions(+), 31 deletions(-)

--- a/kernel/irq/generic-chip.c
+++ b/kernel/irq/generic-chip.c
@@ -40,10 +40,9 @@ void irq_gc_mask_disable_reg(struct irq_
 	struct irq_chip_type *ct = irq_data_get_chip_type(d);
 	u32 mask = d->mask;
 
-	irq_gc_lock(gc);
+	guard(raw_spinlock)(&gc->lock);
 	irq_reg_writel(gc, mask, ct->regs.disable);
 	*ct->mask_cache &= ~mask;
-	irq_gc_unlock(gc);
 }
 EXPORT_SYMBOL_GPL(irq_gc_mask_disable_reg);
 
@@ -60,10 +59,9 @@ void irq_gc_mask_set_bit(struct irq_data
 	struct irq_chip_type *ct = irq_data_get_chip_type(d);
 	u32 mask = d->mask;
 
-	irq_gc_lock(gc);
+	guard(raw_spinlock)(&gc->lock);
 	*ct->mask_cache |= mask;
 	irq_reg_writel(gc, *ct->mask_cache, ct->regs.mask);
-	irq_gc_unlock(gc);
 }
 EXPORT_SYMBOL_GPL(irq_gc_mask_set_bit);
 
@@ -80,10 +78,9 @@ void irq_gc_mask_clr_bit(struct irq_data
 	struct irq_chip_type *ct = irq_data_get_chip_type(d);
 	u32 mask = d->mask;
 
-	irq_gc_lock(gc);
+	guard(raw_spinlock)(&gc->lock);
 	*ct->mask_cache &= ~mask;
 	irq_reg_writel(gc, *ct->mask_cache, ct->regs.mask);
-	irq_gc_unlock(gc);
 }
 EXPORT_SYMBOL_GPL(irq_gc_mask_clr_bit);
 
@@ -100,10 +97,9 @@ void irq_gc_unmask_enable_reg(struct irq
 	struct irq_chip_type *ct = irq_data_get_chip_type(d);
 	u32 mask = d->mask;
 
-	irq_gc_lock(gc);
+	guard(raw_spinlock)(&gc->lock);
 	irq_reg_writel(gc, mask, ct->regs.enable);
 	*ct->mask_cache |= mask;
-	irq_gc_unlock(gc);
 }
 EXPORT_SYMBOL_GPL(irq_gc_unmask_enable_reg);
 
@@ -117,9 +113,8 @@ void irq_gc_ack_set_bit(struct irq_data
 	struct irq_chip_type *ct = irq_data_get_chip_type(d);
 	u32 mask = d->mask;
 
-	irq_gc_lock(gc);
+	guard(raw_spinlock)(&gc->lock);
 	irq_reg_writel(gc, mask, ct->regs.ack);
-	irq_gc_unlock(gc);
 }
 EXPORT_SYMBOL_GPL(irq_gc_ack_set_bit);
 
@@ -133,9 +128,8 @@ void irq_gc_ack_clr_bit(struct irq_data
 	struct irq_chip_type *ct = irq_data_get_chip_type(d);
 	u32 mask = ~d->mask;
 
-	irq_gc_lock(gc);
+	guard(raw_spinlock)(&gc->lock);
 	irq_reg_writel(gc, mask, ct->regs.ack);
-	irq_gc_unlock(gc);
 }
 
 /**
@@ -156,11 +150,10 @@ void irq_gc_mask_disable_and_ack_set(str
 	struct irq_chip_type *ct = irq_data_get_chip_type(d);
 	u32 mask = d->mask;
 
-	irq_gc_lock(gc);
+	guard(raw_spinlock)(&gc->lock);
 	irq_reg_writel(gc, mask, ct->regs.disable);
 	*ct->mask_cache &= ~mask;
 	irq_reg_writel(gc, mask, ct->regs.ack);
-	irq_gc_unlock(gc);
 }
 EXPORT_SYMBOL_GPL(irq_gc_mask_disable_and_ack_set);
 
@@ -174,9 +167,8 @@ void irq_gc_eoi(struct irq_data *d)
 	struct irq_chip_type *ct = irq_data_get_chip_type(d);
 	u32 mask = d->mask;
 
-	irq_gc_lock(gc);
+	guard(raw_spinlock)(&gc->lock);
 	irq_reg_writel(gc, mask, ct->regs.eoi);
-	irq_gc_unlock(gc);
 }
 
 /**
@@ -196,12 +188,11 @@ int irq_gc_set_wake(struct irq_data *d,
 	if (!(mask & gc->wake_enabled))
 		return -EINVAL;
 
-	irq_gc_lock(gc);
+	guard(raw_spinlock)(&gc->lock);
 	if (on)
 		gc->wake_active |= mask;
 	else
 		gc->wake_active &= ~mask;
-	irq_gc_unlock(gc);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(irq_gc_set_wake);
@@ -288,7 +279,6 @@ int irq_domain_alloc_generic_chips(struc
 {
 	struct irq_domain_chip_generic *dgc;
 	struct irq_chip_generic *gc;
-	unsigned long flags;
 	int numchips, i;
 	size_t dgc_sz;
 	size_t gc_sz;
@@ -340,9 +330,8 @@ int irq_domain_alloc_generic_chips(struc
 				goto err;
 		}
 
-		raw_spin_lock_irqsave(&gc_lock, flags);
-		list_add_tail(&gc->list, &gc_list);
-		raw_spin_unlock_irqrestore(&gc_lock, flags);
+		scoped_guard (raw_spinlock, &gc_lock)
+			list_add_tail(&gc->list, &gc_list);
 		/* Calc pointer to the next generic chip */
 		tmp += gc_sz;
 	}
@@ -459,7 +448,6 @@ int irq_map_generic_chip(struct irq_doma
 	struct irq_chip_generic *gc;
 	struct irq_chip_type *ct;
 	struct irq_chip *chip;
-	unsigned long flags;
 	int idx;
 
 	gc = __irq_get_domain_generic_chip(d, hw_irq);
@@ -479,9 +467,8 @@ int irq_map_generic_chip(struct irq_doma
 
 	/* We only init the cache for the first mapping of a generic chip */
 	if (!gc->installed) {
-		raw_spin_lock_irqsave(&gc->lock, flags);
+		guard(raw_spinlock_irq)(&gc->lock);
 		irq_gc_init_mask_cache(gc, dgc->gc_flags);
-		raw_spin_unlock_irqrestore(&gc->lock, flags);
 	}
 
 	/* Mark the interrupt as installed */
@@ -548,9 +535,8 @@ void irq_setup_generic_chip(struct irq_c
 	struct irq_chip *chip = &ct->chip;
 	unsigned int i;
 
-	raw_spin_lock(&gc_lock);
-	list_add_tail(&gc->list, &gc_list);
-	raw_spin_unlock(&gc_lock);
+	scoped_guard (raw_spinlock, &gc_lock)
+		list_add_tail(&gc->list, &gc_list);
 
 	irq_gc_init_mask_cache(gc, flags);
 
@@ -616,9 +602,8 @@ void irq_remove_generic_chip(struct irq_
 {
 	unsigned int i, virq;
 
-	raw_spin_lock(&gc_lock);
-	list_del(&gc->list);
-	raw_spin_unlock(&gc_lock);
+	scoped_guard (raw_spinlock, &gc_lock)
+		list_del(&gc->list);
 
 	for (i = 0; msk; msk >>= 1, i++) {
 		if (!(msk & 0x01))


