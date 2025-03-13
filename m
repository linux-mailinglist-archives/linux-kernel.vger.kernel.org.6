Return-Path: <linux-kernel+bounces-559867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F200DA5FAB1
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 17:04:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 802E73B1E7D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 16:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A21A26B94A;
	Thu, 13 Mar 2025 16:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FcDYFk7r";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="z7Ykj2n8"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A1C13AA20
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 16:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741881604; cv=none; b=pCTh8RplJneWjCcbLNs+j5tKUGDcE/2p5jh5/9NIPyZo9+E+ybc1GR8zlaEnM/EVeJxavMMDWoHL/z1w9/lRTqj5r7Kolit8emq6YhPRAONmAnmUttorrCNFcaaBUJ1q/FMuJHyeCjCPC/tne66KlXkvvx91/+vE23ax8SGUejw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741881604; c=relaxed/simple;
	bh=U6xnEiiLcxoUlj5oziXTzUPFCVFD860N0hio44XXlp0=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=rJV9PMklb6L+O08Su2gldI7uqyDkaDojTKlndJIEpMosaebpd0D/ypzErXvWdQXq8e5jG+HiaGuBa4M7F4oxU2NYbemw5TAft6F66s1rjNSiZlnQNKZpAFIa1VhGrv20d0mhd3tu3t9iSsFcLTiwhZ1hm5KOblvGBbj2efa/jxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FcDYFk7r; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=z7Ykj2n8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250313155914.608834932@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741881601;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=v9TPN0WGgiXJz+hAgbLeIiP+glBj25kHZkxUWZhnzK4=;
	b=FcDYFk7r4qpYrNzDyXzSok7grPr1HkMqpXfQBTX4RN19cdoDbLtG0Wn83nh88oPeDKff5X
	siZq1ktWbrwl6MSEaXBfIQNjl7sNbKCmDuy8JLt+OfwKXR2Etky5fWKf2VrAyeH6oNGBSz
	OoWZPYlHTUe2IQUeyM8JDCqZm/NNkDTUhXyYRIfALBqmbRGca3fcvS1vfCxO3j53vlcE8z
	qZJMM8WkTfrNHfyHE9M0ljwnVn9LnSRffvNeKraN81aPmJVwgmoO4ardwCTVVvz1EmnikP
	gfxaUDieU363C5FCBQhJP1lDxEMLBbv3/bQ9XRBYjNLGqgvxnCB3coxBJarSDA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741881601;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=v9TPN0WGgiXJz+hAgbLeIiP+glBj25kHZkxUWZhnzK4=;
	b=z7Ykj2n80telETYKwGRQYAK7Pe5c5Kg6kRsYZEj8ae1UxeLvfnAgoJDGkmjAtsSR0jPdFt
	jYGwMwNzuDFmKcDQ==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
 Jiri Slaby <jirislaby@kernel.org>
Subject: [patch 11/46] genirq/chip: Prepare for code reduction
References: <20250313154615.860723120@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Thu, 13 Mar 2025 17:00:00 +0100 (CET)

The interrupt flow handlers have similar patterns to decide whether to
handle an interrupt or not.

Provide common helper functions to allow removal of duplicated code.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/irq/chip.c |   37 ++++++++++++++++++++++++++++---------
 1 file changed, 28 insertions(+), 9 deletions(-)

--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -499,7 +499,7 @@ static bool irq_check_poll(struct irq_de
 	return irq_wait_for_poll(desc);
 }
 
-static bool irq_may_run(struct irq_desc *desc)
+static bool irq_can_handle_pm(struct irq_desc *desc)
 {
 	unsigned int mask = IRQD_IRQ_INPROGRESS | IRQD_WAKEUP_ARMED;
 
@@ -524,6 +524,25 @@ static bool irq_may_run(struct irq_desc
 	return irq_check_poll(desc);
 }
 
+static inline bool irq_can_handle_actions(struct irq_desc *desc)
+{
+	desc->istate &= ~(IRQS_REPLAY | IRQS_WAITING);
+
+	if (unlikely(!desc->action || irqd_irq_disabled(&desc->irq_data))) {
+		desc->istate |= IRQS_PENDING;
+		return false;
+	}
+	return true;
+}
+
+static inline bool irq_can_handle(struct irq_desc *desc)
+{
+	if (!irq_can_handle_pm(desc))
+		return false;
+
+	return irq_can_handle_actions(desc);
+}
+
 /**
  *	handle_simple_irq - Simple and software-decoded IRQs.
  *	@desc:	the interrupt description structure for this irq
@@ -539,7 +558,7 @@ void handle_simple_irq(struct irq_desc *
 {
 	raw_spin_lock(&desc->lock);
 
-	if (!irq_may_run(desc))
+	if (!irq_can_handle_pm(desc))
 		goto out_unlock;
 
 	desc->istate &= ~(IRQS_REPLAY | IRQS_WAITING);
@@ -574,7 +593,7 @@ void handle_untracked_irq(struct irq_des
 {
 	raw_spin_lock(&desc->lock);
 
-	if (!irq_may_run(desc))
+	if (!irq_can_handle_pm(desc))
 		goto out_unlock;
 
 	desc->istate &= ~(IRQS_REPLAY | IRQS_WAITING);
@@ -630,7 +649,7 @@ void handle_level_irq(struct irq_desc *d
 	raw_spin_lock(&desc->lock);
 	mask_ack_irq(desc);
 
-	if (!irq_may_run(desc))
+	if (!irq_can_handle_pm(desc))
 		goto out_unlock;
 
 	desc->istate &= ~(IRQS_REPLAY | IRQS_WAITING);
@@ -695,7 +714,7 @@ void handle_fasteoi_irq(struct irq_desc
 	 * can arrive on the new CPU before the original CPU has completed
 	 * handling the previous one - it may need to be resent.
 	 */
-	if (!irq_may_run(desc)) {
+	if (!irq_can_handle_pm(desc)) {
 		if (irqd_needs_resend_when_in_progress(&desc->irq_data))
 			desc->istate |= IRQS_PENDING;
 		goto out;
@@ -790,7 +809,7 @@ void handle_edge_irq(struct irq_desc *de
 
 	desc->istate &= ~(IRQS_REPLAY | IRQS_WAITING);
 
-	if (!irq_may_run(desc)) {
+	if (!irq_can_handle_pm(desc)) {
 		desc->istate |= IRQS_PENDING;
 		mask_ack_irq(desc);
 		goto out_unlock;
@@ -854,7 +873,7 @@ void handle_edge_eoi_irq(struct irq_desc
 
 	desc->istate &= ~(IRQS_REPLAY | IRQS_WAITING);
 
-	if (!irq_may_run(desc)) {
+	if (!irq_can_handle_pm(desc)) {
 		desc->istate |= IRQS_PENDING;
 		goto out_eoi;
 	}
@@ -1213,7 +1232,7 @@ void handle_fasteoi_ack_irq(struct irq_d
 
 	raw_spin_lock(&desc->lock);
 
-	if (!irq_may_run(desc))
+	if (!irq_can_handle_pm(desc))
 		goto out;
 
 	desc->istate &= ~(IRQS_REPLAY | IRQS_WAITING);
@@ -1265,7 +1284,7 @@ void handle_fasteoi_mask_irq(struct irq_
 	raw_spin_lock(&desc->lock);
 	mask_ack_irq(desc);
 
-	if (!irq_may_run(desc))
+	if (!irq_can_handle_pm(desc))
 		goto out;
 
 	desc->istate &= ~(IRQS_REPLAY | IRQS_WAITING);


