Return-Path: <linux-kernel+bounces-559884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA05EA5FACD
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 17:08:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 507D619C5E8E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 16:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 866B92690C9;
	Thu, 13 Mar 2025 16:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SBqtcnK7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bEDZX64B"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 402AB26E959
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 16:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741881632; cv=none; b=JZnoJL18xxIrY2y4FN/LuuMSHCXtTvQ/WRdYBh7xlBG5dl1B8pnbACPDi25k8ywCvXStLtysCfcpz8cIcLLjfmKJDcutGhGtrPGfKYKw66Hl/+pc4Od34yONuuYh+0PDZ890yNZRksvDnli4XxcU40ilpL7vNESX9LHI5+1FdTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741881632; c=relaxed/simple;
	bh=uB0sewD/X8gbJD9jyv6i4iez/rs62VLP62MvshpIqyo=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=eWD6t7H2mD7kMrTm0k1r8aMLvOTFC8FBFpOt+exBz+EfukotlOrFngHgSd/QwYUt9AALaoGe6CrWIzyrWmB5NO6MCro31RGT7JfZBhil4FCOp2fUC5Sl5jL5hr+fG53ScNanobkWXRzSWcFOFeC3YG+jOSZa+t6uAn20XItAGPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SBqtcnK7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bEDZX64B; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250313155915.728402313@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741881629;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=gNmgVlyxfSLEM0Muk8MAQIlZJwhbT8iEAmWhEp/VBM8=;
	b=SBqtcnK7cXmD4e46E6Xn7C+Ek6z5QoKCFp8U9wzKAm6kUvBdUy6AKZ+h0Q6vKwCNSc77ah
	OOqpA0DLf5n//MNdUXbu88cBGvTp3j0S9doxw0Bnp275KcDyh4ffNOuL+Uh2/ZM3QHD1iS
	mw0WSRea4al+hrt/+/aO5ajahYA17sOOb+0At4o9oz+HmmV96XyOrG+gKkX6ailWU18DUT
	LDPdyIvPmBdTOqd+p9syhwjBHwI1ocIR6w7SsL5T/Pp2vS4bYPcLpkifCt4FKt9F7krX/L
	Us4uPy1POD3MKEq2TE/q+6Mv0Vj6+OkE6q/m/6LTrUnDmPdq9plXVsnTLSqYaA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741881629;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=gNmgVlyxfSLEM0Muk8MAQIlZJwhbT8iEAmWhEp/VBM8=;
	b=bEDZX64BM915n/4Gk6NqB7dick5dUJ74Nzg/uHlNhHiflFsKPLSGT1QqVCKyvkMbpg9m1s
	LKeGKsLlwI8v9HBQ==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
 Jiri Slaby <jirislaby@kernel.org>
Subject: [patch 27/46] genirq/chip: Rework irq_set_handler() variants
References: <20250313154615.860723120@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Thu, 13 Mar 2025 17:00:28 +0100 (CET)

Use the new guards to get and lock the interrupt descriptor and tidy up the
code.

Fixup the kernel doc comment while at it.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/irq/chip.c |   34 +++++++++++-----------------------
 1 file changed, 11 insertions(+), 23 deletions(-)

--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -973,35 +973,23 @@ static void
 	}
 }
 
-void
-__irq_set_handler(unsigned int irq, irq_flow_handler_t handle, int is_chained,
-		  const char *name)
+void __irq_set_handler(unsigned int irq, irq_flow_handler_t handle, int is_chained,
+		       const char *name)
 {
-	unsigned long flags;
-	struct irq_desc *desc = irq_get_desc_buslock(irq, &flags, 0);
-
-	if (!desc)
-		return;
-
-	__irq_do_set_handler(desc, handle, is_chained, name);
-	irq_put_desc_busunlock(desc, flags);
+	scoped_irqdesc_get_and_lock(irq, 0)
+		__irq_do_set_handler(scoped_irqdesc, handle, is_chained, name);
 }
 EXPORT_SYMBOL_GPL(__irq_set_handler);
 
-void
-irq_set_chained_handler_and_data(unsigned int irq, irq_flow_handler_t handle,
-				 void *data)
+void irq_set_chained_handler_and_data(unsigned int irq, irq_flow_handler_t handle,
+				      void *data)
 {
-	unsigned long flags;
-	struct irq_desc *desc = irq_get_desc_buslock(irq, &flags, 0);
-
-	if (!desc)
-		return;
+	scoped_irqdesc_get_and_buslock(irq, 0) {
+		struct irq_desc *desc = scoped_irqdesc;
 
-	desc->irq_common_data.handler_data = data;
-	__irq_do_set_handler(desc, handle, 1, NULL);
-
-	irq_put_desc_busunlock(desc, flags);
+		desc->irq_common_data.handler_data = data;
+		__irq_do_set_handler(desc, handle, 1, NULL);
+	}
 }
 EXPORT_SYMBOL_GPL(irq_set_chained_handler_and_data);
 


