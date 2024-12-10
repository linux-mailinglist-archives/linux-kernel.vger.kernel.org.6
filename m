Return-Path: <linux-kernel+bounces-439357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 313329EAE0C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 11:35:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 310C628366B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 10:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05C2C210F6F;
	Tue, 10 Dec 2024 10:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fFfNGOVF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jJH3lJ5j"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915C32080D7
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 10:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733826862; cv=none; b=NP7jNXddNVh3b65WkYV65HUSfMA2IqNM1G1quhCmT71gvDaWnxY0uXKB49TR7dJbP0uPmHpZxN7JiASlZ7pM5SO2DwRIJBRuuGEb96xqGknhUbpR5d+huorgAx67SdROEywHgGcpuj+evX6Kd/MRdHg2MEkQt/xgTsTh9l8lHAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733826862; c=relaxed/simple;
	bh=kkUkaSLB+A3b5oNaOfn6H7NWYF11wNPQSI4Rqw4dE0Y=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=H8DFwbOWZmFPzJgwpVeVeWvVafj5WA6RGjm0x1vBdTqFLDUqEC36C3pQsuKyVxhMao24lK7LeKFAe6hgu1rXIxqpmGtwR+HeaCOrjBe4ICaGFTkfGJLJscAHLCJknr4wumzBqWH5Ln79bnyuTFe4FWCJIyMNORfg3iP8PcXoxAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fFfNGOVF; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jJH3lJ5j; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20241210103335.626707225@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733826858;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=5aTYhXT8OhSS4alOlqf6d0ntHhzH/LyWqanpwxxQXlo=;
	b=fFfNGOVFub+E8J2AZOf7i2O/TH5FehToC3RaXPsZTxncbXmNZZyhOtZj4pwNQQ5RRIBT4k
	AEqnJzX3PoXYhdTgl2v8mRKfGY6AHst4Poni8iN5Ghd06tZFYRrvJLW+261TAzKLCxp3sZ
	qVrjmXvb3TuJtCe2NgxQPpJQa06s3kMmZqJu4NqNjhPEPNt6zTOVYFTA+5XlmnCcWPxsjE
	XpbTjKWtpF88WePR0wMHlk9at5abEKqn4a5Cn2VRbuiadBXZYZM9/Qz1id2l1pv7q60qXq
	WaNJmzEPUv1bF848xdnjbYzSZEWZDWdJO0z6t9Q8muQabC6QasV6gg/a3YZMkg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733826858;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=5aTYhXT8OhSS4alOlqf6d0ntHhzH/LyWqanpwxxQXlo=;
	b=jJH3lJ5jF2dS03ZzbAaTJQ09ze/Ay7KGkYcCQeq1UdDfz+/iz7RL7LhbQDdtj5bEgFjnl/
	tfHBnqKPemHG/cAw==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: x86@kernel.org,
 Anup Patel <apatel@ventanamicro.com>,
 Vineet Gupta <vgupta@kernel.org>,
 Brian Cain <bcain@quicinc.com>,
 Wei Liu <wei.liu@kernel.org>,
 Steve Wahl <steve.wahl@hpe.com>,
 Joerg Roedel <joro@8bytes.org>,
 Lu Baolu <baolu.lu@linux.intel.com>,
 Juergen Gross <jgross@suse.com>
Subject: [patch 5/5] genirq: Remove IRQ_MOVE_PCNTXT and related code
References: <20241210102148.760383417@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Tue, 10 Dec 2024 11:34:17 +0100 (CET)

Now that x86 is converted over to use the IRQCHIP_MOVE_DEFERRED flags,
remove IRQ*_MOVE_PCNTXT and related code.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/Kconfig       |    1 -
 include/linux/irq.h    |   12 +-----------
 kernel/irq/chip.c      |   14 --------------
 kernel/irq/debugfs.c   |    1 -
 kernel/irq/internals.h |    2 +-
 kernel/irq/settings.h  |    6 ------
 6 files changed, 2 insertions(+), 34 deletions(-)

--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -173,7 +173,6 @@ config X86
 	select GENERIC_IRQ_RESERVATION_MODE
 	select GENERIC_IRQ_SHOW
 	select GENERIC_PENDING_IRQ		if SMP
-	select GENERIC_PENDING_IRQ_CHIPFLAGS	if SMP
 	select GENERIC_PTDUMP
 	select GENERIC_SMP_IDLE_THREAD
 	select GENERIC_TIME_VSYSCALL
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -64,7 +64,6 @@ enum irqchip_irq_state;
  * IRQ_NOAUTOEN			- Interrupt is not automatically enabled in
  *				  request/setup_irq()
  * IRQ_NO_BALANCING		- Interrupt cannot be balanced (affinity set)
- * IRQ_MOVE_PCNTXT		- Interrupt can be migrated from process context
  * IRQ_NESTED_THREAD		- Interrupt nests into another thread
  * IRQ_PER_CPU_DEVID		- Dev_id is a per-cpu variable
  * IRQ_IS_POLLED		- Always polled by another interrupt. Exclude
@@ -93,7 +92,6 @@ enum {
 	IRQ_NOREQUEST		= (1 << 11),
 	IRQ_NOAUTOEN		= (1 << 12),
 	IRQ_NO_BALANCING	= (1 << 13),
-	IRQ_MOVE_PCNTXT		= (1 << 14),
 	IRQ_NESTED_THREAD	= (1 << 15),
 	IRQ_NOTHREAD		= (1 << 16),
 	IRQ_PER_CPU_DEVID	= (1 << 17),
@@ -105,7 +103,7 @@ enum {
 
 #define IRQF_MODIFY_MASK	\
 	(IRQ_TYPE_SENSE_MASK | IRQ_NOPROBE | IRQ_NOREQUEST | \
-	 IRQ_NOAUTOEN | IRQ_MOVE_PCNTXT | IRQ_LEVEL | IRQ_NO_BALANCING | \
+	 IRQ_NOAUTOEN | IRQ_LEVEL | IRQ_NO_BALANCING | \
 	 IRQ_PER_CPU | IRQ_NESTED_THREAD | IRQ_NOTHREAD | IRQ_PER_CPU_DEVID | \
 	 IRQ_IS_POLLED | IRQ_DISABLE_UNLAZY | IRQ_HIDDEN)
 
@@ -201,8 +199,6 @@ struct irq_data {
  * IRQD_LEVEL			- Interrupt is level triggered
  * IRQD_WAKEUP_STATE		- Interrupt is configured for wakeup
  *				  from suspend
- * IRQD_MOVE_PCNTXT		- Interrupt can be moved in process
- *				  context
  * IRQD_IRQ_DISABLED		- Disabled state of the interrupt
  * IRQD_IRQ_MASKED		- Masked state of the interrupt
  * IRQD_IRQ_INPROGRESS		- In progress state of the interrupt
@@ -233,7 +229,6 @@ enum {
 	IRQD_AFFINITY_SET		= BIT(12),
 	IRQD_LEVEL			= BIT(13),
 	IRQD_WAKEUP_STATE		= BIT(14),
-	IRQD_MOVE_PCNTXT		= BIT(15),
 	IRQD_IRQ_DISABLED		= BIT(16),
 	IRQD_IRQ_MASKED			= BIT(17),
 	IRQD_IRQ_INPROGRESS		= BIT(18),
@@ -338,11 +333,6 @@ static inline bool irqd_is_wakeup_set(st
 	return __irqd_to_state(d) & IRQD_WAKEUP_STATE;
 }
 
-static inline bool irqd_can_move_in_process_context(struct irq_data *d)
-{
-	return __irqd_to_state(d) & IRQD_MOVE_PCNTXT;
-}
-
 static inline bool irqd_irq_disabled(struct irq_data *d)
 {
 	return __irqd_to_state(d) & IRQD_IRQ_DISABLED;
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -47,13 +47,6 @@ int irq_set_chip(unsigned int irq, const
 		return -EINVAL;
 
 	desc->irq_data.chip = (struct irq_chip *)(chip ?: &no_irq_chip);
-
-	if (IS_ENABLED(CONFIG_GENERIC_PENDING_IRQ_CHIPFLAGS) && chip) {
-		if (chip->flags & IRQCHIP_MOVE_DEFERRED)
-			irqd_clear(&desc->irq_data, IRQD_MOVE_PCNTXT);
-		else
-			irqd_set(&desc->irq_data, IRQD_MOVE_PCNTXT);
-	}
 	irq_put_desc_unlock(desc, flags);
 	/*
 	 * For !CONFIG_SPARSE_IRQ make the irq show up in
@@ -1129,13 +1122,6 @@ void irq_modify_status(unsigned int irq,
 	if (irq_settings_is_level(desc))
 		irqd_set(&desc->irq_data, IRQD_LEVEL);
 
-	/* Keep this around until x86 is converted over */
-	if (!IS_ENABLED(CONFIG_GENERIC_PENDING_IRQ_CHIPFLAGS)) {
-		irqd_clear(&desc->irq_data, IRQD_MOVE_PCNTXT);
-		if (irq_settings_can_move_pcntxt(desc))
-			irqd_set(&desc->irq_data, IRQD_MOVE_PCNTXT);
-	}
-
 	tmp = irq_settings_get_trigger_mask(desc);
 	if (tmp != IRQ_TYPE_NONE)
 		trigger = tmp;
--- a/kernel/irq/debugfs.c
+++ b/kernel/irq/debugfs.c
@@ -109,7 +109,6 @@ static const struct irq_bit_descr irqdat
 	BIT_MASK_DESCR(IRQD_NO_BALANCING),
 
 	BIT_MASK_DESCR(IRQD_SINGLE_TARGET),
-	BIT_MASK_DESCR(IRQD_MOVE_PCNTXT),
 	BIT_MASK_DESCR(IRQD_AFFINITY_SET),
 	BIT_MASK_DESCR(IRQD_SETAFFINITY_PENDING),
 	BIT_MASK_DESCR(IRQD_AFFINITY_MANAGED),
--- a/kernel/irq/internals.h
+++ b/kernel/irq/internals.h
@@ -421,7 +421,7 @@ irq_init_generic_chip(struct irq_chip_ge
 #ifdef CONFIG_GENERIC_PENDING_IRQ
 static inline bool irq_can_move_pcntxt(struct irq_data *data)
 {
-	return irqd_can_move_in_process_context(data);
+	return !(data->chip->flags & IRQCHIP_MOVE_DEFERRED);
 }
 static inline bool irq_move_pending(struct irq_data *data)
 {
--- a/kernel/irq/settings.h
+++ b/kernel/irq/settings.h
@@ -11,7 +11,6 @@ enum {
 	_IRQ_NOREQUEST		= IRQ_NOREQUEST,
 	_IRQ_NOTHREAD		= IRQ_NOTHREAD,
 	_IRQ_NOAUTOEN		= IRQ_NOAUTOEN,
-	_IRQ_MOVE_PCNTXT	= IRQ_MOVE_PCNTXT,
 	_IRQ_NO_BALANCING	= IRQ_NO_BALANCING,
 	_IRQ_NESTED_THREAD	= IRQ_NESTED_THREAD,
 	_IRQ_PER_CPU_DEVID	= IRQ_PER_CPU_DEVID,
@@ -142,11 +141,6 @@ static inline void irq_settings_set_nopr
 	desc->status_use_accessors |= _IRQ_NOPROBE;
 }
 
-static inline bool irq_settings_can_move_pcntxt(struct irq_desc *desc)
-{
-	return desc->status_use_accessors & _IRQ_MOVE_PCNTXT;
-}
-
 static inline bool irq_settings_can_autoenable(struct irq_desc *desc)
 {
 	return !(desc->status_use_accessors & _IRQ_NOAUTOEN);


