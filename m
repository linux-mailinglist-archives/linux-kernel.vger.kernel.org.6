Return-Path: <linux-kernel+bounces-559892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CDE1A5FAD7
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 17:10:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E36D19C7886
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 16:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 211052702B2;
	Thu, 13 Mar 2025 16:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="v5Acw7ba";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TlNDOjCQ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2213C27005A
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 16:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741881647; cv=none; b=hWlY9i50myDSZQb6tfsGNElVZXT7EZuB4sxBg3E5QWp6wNOIb4aNd+aV3Y00XQDNcV+Owj2zzLpsooAzCQz0MQW4w1LYkkcNuedkrozQfRu2HRhnjynUWTn7rFnryXD0cFM+H07xcNDCKcX3RigXmUUiaf5TufQB3A2kCrHoOUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741881647; c=relaxed/simple;
	bh=XPn9ovDcyi/hW6vEFdSZx8GOXw+zO7JA/Fus0LhHqMc=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=A3aymUnTxqowqm4EaioSns17JYc2e+KSOqdvVKLca1agSTx5Lns0vUfH/cUAdKVBTBTb/u/Sh9cDODLPazoFHTkH1LbizSDF7HRQwpAzM/LwJsyyUIi+dftUnrM1I7RLnBcAVs191zqaxyf2ZNAkFeBGk1LNbr2kF89pUBJBhcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=v5Acw7ba; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TlNDOjCQ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250313155916.262816046@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741881643;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=qAITU5mZvIeYzJYUj7EkSoCfebgAS5tXEspL0xsod3I=;
	b=v5Acw7baSufCUd2Clj7N47KcgovScxOPp4yPa/azOFCE6eBGIn3f1U8ycPa72GZCvAEQbz
	PADHBOaI5D1FgMn5iIhp9fy+WwMPtstXS95J0AmHd7x7zvQ6zKmWkIlQFP6uwF6AVgTYou
	VZSug6djafm+VbRjZ6ZO9IpmEKry8sIP8Gla+STF2gT4OLA2ciF/FZieiwUdBRRKfzV9gC
	+J8VY4thVWPvqhLaFCQHhEzLs+SeV24A3WrCMrVBO7RHPRY4m9sZwfZrEb715v+a6ZDTlb
	BzQ8YM1S93KTmwTPNnxUcyFWOG4OzPX0SA+Q/s10FIPU8NOGiRkUL5VWM7E2fg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741881643;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=qAITU5mZvIeYzJYUj7EkSoCfebgAS5tXEspL0xsod3I=;
	b=TlNDOjCQYAXsvGvRdT6cMXGviZS6haAar5XjIVup6FL/PO7rKQXN+VSE4tlLG92al47/eb
	9fqQ7VlGjqxtffBg==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
 Jiri Slaby <jirislaby@kernel.org>
Subject: [patch 35/46] genirq/manage: Rework enable_irq()
References: <20250313154615.860723120@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Thu, 13 Mar 2025 17:00:42 +0100 (CET)

Use the new guards to get and lock the interrupt descriptor and tidy up the
code.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/irq/manage.c |   17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -788,18 +788,13 @@ void __enable_irq(struct irq_desc *desc)
  */
 void enable_irq(unsigned int irq)
 {
-	unsigned long flags;
-	struct irq_desc *desc = irq_get_desc_buslock(irq, &flags, IRQ_GET_DESC_CHECK_GLOBAL);
+	scoped_irqdesc_get_and_lock(irq, IRQ_GET_DESC_CHECK_GLOBAL) {
+		struct irq_desc *desc = scoped_irqdesc;
 
-	if (!desc)
-		return;
-	if (WARN(!desc->irq_data.chip,
-		 KERN_ERR "enable_irq before setup/request_irq: irq %u\n", irq))
-		goto out;
-
-	__enable_irq(desc);
-out:
-	irq_put_desc_busunlock(desc, flags);
+		if (WARN(!desc->irq_data.chip, "enable_irq before setup/request_irq: irq %u\n", irq))
+			return;
+		__enable_irq(desc);
+	}
 }
 EXPORT_SYMBOL(enable_irq);
 


