Return-Path: <linux-kernel+bounces-559880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B128A5FAB7
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 17:04:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12C737A3927
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 16:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A341826E95B;
	Thu, 13 Mar 2025 16:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hYhEvVEI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rhYsbRHr"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2135826E952
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 16:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741881626; cv=none; b=mbD+dnpJtBO1H+R3JgbNvgAXZxchjtIEwY7yXLgEwwvga8FEabJO7GYCz1Cf4LtgqfLFFc6uNhdy5nhAL0KJ+/yUTiwcudQ4yxPnTMaBzBsdGFpgXUwh3UxR50angRrHtpXffiopnMzC2sCkZ/eBxbTQE2wT314VPbsWYVtlnBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741881626; c=relaxed/simple;
	bh=+eDcQW+ASiWa2cpmvtO1ybtAseF1B2h6ZHQFOMfdYnE=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=Kp9Hr1ehWWhQ24ZalIpej+mTm6y9r0sGLE61whKOtlS33MU8qsEdTCneic1RD9W1ec1gB1B85oGH5SaaOppIky2Ds5qrqwXDcwEAoh7KjNobWSXTdyzj8Co1/HSL+QNwimrS8SP3gsYuPy0XgsM0dfwSTm3D0h6r+6LWgNmn33I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hYhEvVEI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rhYsbRHr; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250313155915.453571016@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741881622;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=dp4NgCiDPp80fCiL6rbNPSkeQUAa0mSCzeJaGL1/OSE=;
	b=hYhEvVEIxTLhxiClp+wJFAcEdGsF4mcaOHZMgDeJSIQnkTG/fDkITG7cfpAZQ+IDxiqMm+
	B+WyVFZFXRqhC8KXn8AfygywzXO7xniHyyO7zYHq5zOcqgj+8JrI4/uPJ41Th3KheXUatl
	LN3bHBXG4usOxN7fq5zzPbRpA0SwPpowuxVvR0cJlCfAalzQUu99in+w99GLu/G8G/5HY3
	Qq67R0NVL2v0oiqfvky/G8N3DwWFMpSLUS9+wDrb7Y5Lv9Tgi5b0ostRuIl+cxCZQ+hFsk
	mgSA1z/dzLrECLrC0D0JRTCaSbd9tQgdMQNSOypU3PiUf7PRe7KzdAoDHqWgrw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741881622;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=dp4NgCiDPp80fCiL6rbNPSkeQUAa0mSCzeJaGL1/OSE=;
	b=rhYsbRHr1ZMWNz7GWt7gTDLCKxms8IttDRU2DxtX7cQVQGiO3ibBcGqRGMnLxcxdeckT8X
	+P5dIGv5zLWFF9Cg==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
 Jiri Slaby <jirislaby@kernel.org>
Subject: [patch 23/46] genirq/chip: Rework irq_set_irq_type()
References: <20250313154615.860723120@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Thu, 13 Mar 2025 17:00:22 +0100 (CET)

Use the new guards to get and lock the interrupt descriptor and tidy up the
code.

Fixup the kernel doc comment while at it.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/irq/chip.c |   19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -54,22 +54,15 @@ int irq_set_chip(unsigned int irq, const
 EXPORT_SYMBOL(irq_set_chip);
 
 /**
- *	irq_set_irq_type - set the irq trigger type for an irq
- *	@irq:	irq number
- *	@type:	IRQ_TYPE_{LEVEL,EDGE}_* value - see include/linux/irq.h
+ * irq_set_irq_type - set the irq trigger type for an irq
+ * @irq:	irq number
+ * @type:	IRQ_TYPE_{LEVEL,EDGE}_* value - see include/linux/irq.h
  */
 int irq_set_irq_type(unsigned int irq, unsigned int type)
 {
-	unsigned long flags;
-	struct irq_desc *desc = irq_get_desc_buslock(irq, &flags, IRQ_GET_DESC_CHECK_GLOBAL);
-	int ret = 0;
-
-	if (!desc)
-		return -EINVAL;
-
-	ret = __irq_set_trigger(desc, type);
-	irq_put_desc_busunlock(desc, flags);
-	return ret;
+	scoped_irqdesc_get_and_buslock(irq, IRQ_GET_DESC_CHECK_GLOBAL)
+		return __irq_set_trigger(scoped_irqdesc, type);
+	return -EINVAL;
 }
 EXPORT_SYMBOL(irq_set_irq_type);
 


