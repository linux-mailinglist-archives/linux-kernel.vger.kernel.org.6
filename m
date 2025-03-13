Return-Path: <linux-kernel+bounces-559897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 511B7A5FACA
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 17:07:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D7F87A4BCF
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 16:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8A7B271269;
	Thu, 13 Mar 2025 16:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IC2k4W1/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Rl3gPVMA"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A5E270ED1
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 16:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741881655; cv=none; b=HUE9JiJwPhlbQHjpMHK/jjHqH9GbWfQbufj3mp3BDQg8pYw61ifYjW5VETIrePKRWv+bXQSjalyVT2frG+fGVEHzgoeuOYG12SYELZA/AHObyiegHCOBSMnv9MjhhoKQWyB3ZVTL739iy5+gAZ0t81PlWfr90AQvA8FkPviWed8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741881655; c=relaxed/simple;
	bh=mVXxcoK3WExTSdKgmIUUyG89B2x71ZcLZlRZ5GExM7Q=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=KvkccBGCLp3+mDTdiPX6gdb/Ide+PRPYb0qpd07+k0myfdTcgJCz3shQH5xlDzm3y4x56nwzwZTve4YEZ4Sga1wqRIheSeCxgfbuwqupaZIjV846/e7bH6aC6brreipuX4Jzo5eYDjLaSiAHNm+h5vNAYHA8IzkcBaBnsVcKjiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IC2k4W1/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Rl3gPVMA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250313155916.593648845@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741881652;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=TFhQSReQb2KUOo2saM7MJ3Hp8TV3kdr6sRN4/io4++4=;
	b=IC2k4W1/9M3la0gilvJUi6wUnDvJlVEfEklt5Nlj5anbj1dIVwDfaJ+VZF4PTVav6jdBk0
	FWuHoZib++0C5zhHP3c8n+8Wyh5CPJeCisVGAX/bo5Zyybt6v0j0Jz6NsedLJB9Dn9yZSB
	JomuKT5Vg0M7qiBWN7HzGKgxDMxv5TZPLribaDfCEzXpb3gqw3IiRDOZIc5AhJPaG8/U8f
	omaJleK31vjjtiQ7P71hOXWZTti4q37Yo9O+H7KP3iv799qAJIQEa9MpCBUkCmftjRXTmT
	m4CUdCe+Q4wxnSSQrpkbIzfhiW69jH2uHy6XA8ZnxX1GoegdGgotr9HtOT4tkA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741881652;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=TFhQSReQb2KUOo2saM7MJ3Hp8TV3kdr6sRN4/io4++4=;
	b=Rl3gPVMABG75qcj3fJGM0ZdBL/Mha0kIvpGDBBxL/rfYD2MG+/c3908Md6a/v08OTp0yXp
	jjfIPKuMCTpZO9Bw==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
 Jiri Slaby <jirislaby@kernel.org>
Subject: [patch 40/46] genirq/manage: Rework irq_percpu_is_enabled()
References: <20250313154615.860723120@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Thu, 13 Mar 2025 17:00:51 +0100 (CET)

Use the new guards to get and lock the interrupt descriptor and tidy up the
code.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/irq/manage.c |   16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -2321,19 +2321,9 @@ void enable_percpu_nmi(unsigned int irq,
  */
 bool irq_percpu_is_enabled(unsigned int irq)
 {
-	unsigned int cpu = smp_processor_id();
-	struct irq_desc *desc;
-	unsigned long flags;
-	bool is_enabled;
-
-	desc = irq_get_desc_lock(irq, &flags, IRQ_GET_DESC_CHECK_PERCPU);
-	if (!desc)
-		return false;
-
-	is_enabled = cpumask_test_cpu(cpu, desc->percpu_enabled);
-	irq_put_desc_unlock(desc, flags);
-
-	return is_enabled;
+	scoped_irqdesc_get_and_lock(irq, IRQ_GET_DESC_CHECK_PERCPU)
+		return cpumask_test_cpu(smp_processor_id(), scoped_irqdesc->percpu_enabled);
+	return false;
 }
 EXPORT_SYMBOL_GPL(irq_percpu_is_enabled);
 


