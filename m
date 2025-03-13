Return-Path: <linux-kernel+bounces-559882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8001AA5FAC5
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 17:06:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDD9D16563C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 16:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 719A126F462;
	Thu, 13 Mar 2025 16:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FPxncm6I";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="i01WH0/g"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5254A26E97E
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 16:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741881629; cv=none; b=oPqnmDRPoFhLbHFxuO89HyYqoauyffsVSWKBt9GrUuHJQoN7NxBVWRJJ1KS2z8DFwTHUENsFTGfXNxRKGD/CVH8GObztk4vrXwnSAUBv9OpdOSYVX38PgS2MtJxLZZ9HrhUsigSMbm5wbZd0E9BmxWiHZmYplaIhqa00Nbwr5Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741881629; c=relaxed/simple;
	bh=6AdCTZXW4ujUGvs7TOpS+/fCGY/mpCKYZQSYTDFyDjk=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=jv4J8pvNxu9YvjuP1P8tRpwtSSyqnDLoytoNGnKOdD2U63ZM+ULjzekZykhTP3m+j5KZWMxzSLA7tmliHRUp34zGw1ukooi/g1vnYW5F6qkETcCm+vjcpVliHN2RpPXvz95jz2eHK/ce9AX1ekBsgxFTysiH0D9nuXCSsoyM8Xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FPxncm6I; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=i01WH0/g; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250313155915.588553874@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741881626;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=8m0pS7BdpfO/t/en/kCD7bZ2bw6XD1PoP+xUffyza4U=;
	b=FPxncm6IbU7dpU6k/dE2L0zy2SNh8If5Jb39Tm/GLUDw8tieScc5ReeuBLZvjwngBzw04r
	4yEGYwIfmCPmOch2uclSiMGWOM+LJbzjd3wj7HNqoPfo6Hp0lWtf2DRlh6+IMbyg1VSpb8
	FYxhA1eyEfwxLeqRkyM8WLXLGgK7QBEXVIlhZ9gRWvGbnBySE7Mcr//975N/dls/t10e+5
	bv7gaoqZT2+xgwa98xhlOydR7vltyrhU7k0HrahGXACEPKdUxvfaZ0L3WG5TAaWkUt5dpN
	cLOADfTXhgx7WyFkRZoUeTGuhXjHkuqMA6bzZWKDfAhMeSLFUuxHnRIteWpolg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741881626;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=8m0pS7BdpfO/t/en/kCD7bZ2bw6XD1PoP+xUffyza4U=;
	b=i01WH0/gFfZAVuocXXuSZUdArhynFszhkdJvR8SGR7ntzwmlo9l5Nazih3B2fPB915S2p1
	KFSBODibJZ3bX1Aw==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
 Jiri Slaby <jirislaby@kernel.org>
Subject: [patch 25/46] genirq/chip: Rework irq_set_msi_desc_off()
References: <20250313154615.860723120@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Thu, 13 Mar 2025 17:00:25 +0100 (CET)

Use the new guards to get and lock the interrupt descriptor and tidy up the
code.

Fixup the kernel doc comment while at it.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/irq/chip.c |   38 +++++++++++++++++---------------------
 1 file changed, 17 insertions(+), 21 deletions(-)

--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -84,34 +84,30 @@ int irq_set_handler_data(unsigned int ir
 EXPORT_SYMBOL(irq_set_handler_data);
 
 /**
- *	irq_set_msi_desc_off - set MSI descriptor data for an irq at offset
- *	@irq_base:	Interrupt number base
- *	@irq_offset:	Interrupt number offset
- *	@entry:		Pointer to MSI descriptor data
+ * irq_set_msi_desc_off - set MSI descriptor data for an irq at offset
+ * @irq_base:	Interrupt number base
+ * @irq_offset:	Interrupt number offset
+ * @entry:		Pointer to MSI descriptor data
  *
- *	Set the MSI descriptor entry for an irq at offset
+ * Set the MSI descriptor entry for an irq at offset
  */
-int irq_set_msi_desc_off(unsigned int irq_base, unsigned int irq_offset,
-			 struct msi_desc *entry)
+int irq_set_msi_desc_off(unsigned int irq_base, unsigned int irq_offset, struct msi_desc *entry)
 {
-	unsigned long flags;
-	struct irq_desc *desc = irq_get_desc_lock(irq_base + irq_offset, &flags, IRQ_GET_DESC_CHECK_GLOBAL);
-
-	if (!desc)
-		return -EINVAL;
-	desc->irq_common_data.msi_desc = entry;
-	if (entry && !irq_offset)
-		entry->irq = irq_base;
-	irq_put_desc_unlock(desc, flags);
-	return 0;
+	scoped_irqdesc_get_and_lock(irq_base + irq_offset, IRQ_GET_DESC_CHECK_GLOBAL) {
+		scoped_irqdesc->irq_common_data.msi_desc = entry;
+		if (entry && !irq_offset)
+			entry->irq = irq_base;
+		return 0;
+	}
+	return -EINVAL;
 }
 
 /**
- *	irq_set_msi_desc - set MSI descriptor data for an irq
- *	@irq:	Interrupt number
- *	@entry:	Pointer to MSI descriptor data
+ * irq_set_msi_desc - set MSI descriptor data for an irq
+ * @irq:	Interrupt number
+ * @entry:	Pointer to MSI descriptor data
  *
- *	Set the MSI descriptor entry for an irq
+ * Set the MSI descriptor entry for an irq
  */
 int irq_set_msi_desc(unsigned int irq, struct msi_desc *entry)
 {


