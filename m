Return-Path: <linux-kernel+bounces-559901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 769B6A5FAD9
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 17:10:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4FBA169744
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 16:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89DDB271825;
	Thu, 13 Mar 2025 16:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="f/KvRQH3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JeLVVep0"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4C9271801
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 16:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741881661; cv=none; b=qJLzAoUwWA5pPhNh8I/7OJt648aBTKw4TKRZu6SpJw+kOP2171sUwBUFdl4jQZcp1zL7toqMmc8hzQgo0ntJyoTuv0kAiuBj2ZPzeNQ+GRCFljre/gTMBcMRmdilzten5hcKL6M0E2mfEw1FFowA8I7sOucwA1shLvpYeTRp3EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741881661; c=relaxed/simple;
	bh=yg/ZmJBXFmKbBU6mz6fzEYdtgoVGLcu5d+ojwtGnWXc=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=KBn8scWI4/NYssiSLO3O1KNwy9Bynzk8+DxeJ53xDYvQnTdgGZ0f/9puobgxIIvH5iiG0l9BY9uEveWnZf6QpuGXL1B3D88gJAwRnJO8WHb7VgfOJPbQbkAcqNK6KGdwPp3HhuPe4XMSJSbaxLoEVmX1MbEcbYps7Wctm2yTeZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=f/KvRQH3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JeLVVep0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250313155916.793162927@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741881657;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=V5kaBJf0gcS62Piw8Vm7nlUZqbdpY8K201MQEACMUxM=;
	b=f/KvRQH3kOjEtpb799i96hyVD2jB4OYRoXiW2DYKliCToFMikmifeE2FyKuKQHZvWoHdkp
	20yUNKeEWY6+jxWkFGVz1EXggkSFAEv+oNtSGcjWIocLG93fZeQMzFFyvDctQfAHnkKmDs
	CPU+nbfQjTPqvFrefUTJM7E63FvQJN2tXnCETQ8aXIYaBXSyCr+4MmhQ63DTAxp06F2XXe
	aOLAIajB4v1lnIp1oSAutMd07ASfG0RhGfbFFecqbAUdLE1xnpdavKB/Ll7o/MTuAQsx2k
	6op8F0zCPd6OPeOZO1kDZ1qh3PT2wHnf2PZ52udYjUn8+OUXQz1c6SCf7Yjoqg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741881657;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=V5kaBJf0gcS62Piw8Vm7nlUZqbdpY8K201MQEACMUxM=;
	b=JeLVVep05ijCwCUj8G8dnbzasknLOltTnpyryIK/F3Hrfzz1HketeSu1P6kF0ATU6PyaZv
	DjZA9SQV6Kbo9lBQ==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
 Jiri Slaby <jirislaby@kernel.org>
Subject: [patch 43/46] genirq/manage: Rework teardown_percpu_nmi()
References: <20250313154615.860723120@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Thu, 13 Mar 2025 17:00:57 +0100 (CET)

Use the new guards to get and lock the interrupt descriptor and tidy up the
code.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/irq/manage.c |   19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -2633,22 +2633,13 @@ int prepare_percpu_nmi(unsigned int irq)
  */
 void teardown_percpu_nmi(unsigned int irq)
 {
-	unsigned long flags;
-	struct irq_desc *desc;
-
 	WARN_ON(preemptible());
 
-	desc = irq_get_desc_lock(irq, &flags,
-				 IRQ_GET_DESC_CHECK_PERCPU);
-	if (!desc)
-		return;
-
-	if (WARN_ON(!irq_is_nmi(desc)))
-		goto out;
-
-	irq_nmi_teardown(desc);
-out:
-	irq_put_desc_unlock(desc, flags);
+	scoped_irqdesc_get_and_lock(irq, IRQ_GET_DESC_CHECK_PERCPU) {
+		if (WARN_ON(!irq_is_nmi(scoped_irqdesc)))
+			return;
+		irq_nmi_teardown(scoped_irqdesc);
+	}
 }
 
 int __irq_get_irqchip_state(struct irq_data *data, enum irqchip_irq_state which,


