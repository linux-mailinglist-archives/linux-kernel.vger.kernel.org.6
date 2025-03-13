Return-Path: <linux-kernel+bounces-559878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8650A5FABE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 17:05:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AB1F16FE40
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 16:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C5DB26E651;
	Thu, 13 Mar 2025 16:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VBAno23t";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HvWRmyrp"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A72426E16A
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 16:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741881621; cv=none; b=KP4hh+45IKDdtYP+EznMDEHf/bAy+ET/yikVkaRGX2y71OgyiAVyRE/7QADwmviiRDOYW5I6BeE1zti/9sDGsikB8WCszJp1KHmvgPYIfok77d7kC+uvmRTJAg3FPOH38CfRI/ZTAFX1qiO66eM7RBdOxbF+GBl8iRNv52keYnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741881621; c=relaxed/simple;
	bh=b0JZPSifyH4V9k3xP9rALjjJADVVPT8f22DBM2AIRkc=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=uTTX54+lp4L8dsiwneEP9LlHDF5obaydCCpdUnMsugaXGVkIBKlH4kq7zcALGpUK9bmblv0tbOptEbj7StJbY8AOSHQLP0QC/tnT7vMOCW72F42zrw8+fNVuvX8KbA2UIHPcML5qJhMqPrTdZCyiqTP3I/hiPsWdGSz+4k0nFSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VBAno23t; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HvWRmyrp; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250313155915.301000372@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741881619;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=21qxaZJUMfrnR91zfcgARK5+Av80xk5Antj7rW6iFIo=;
	b=VBAno23tKtjY32EkCAgiq+CghvliLpwm+CDVhBiaHiihyYKK5GFJ23z2kMf72KJ52FTJH8
	KYWxD8ki3tETm5HBWsOei0FqJgtF0JH+6TgVddbWaGHm12j8Xt0nIqTukvZrna3y/lJiyY
	SmyraxOe6J3E6uXzwIidIdzOCRolRAoboJMMRsan7PZeW+L61jIpVz28LcmCYjWxosGhiq
	a/4cVBbSkpISmpmH6E5xvIOAZiCEry7yo/54f64mL1ev353vD4VO/bT39i+v/ATtGtHhkK
	qQfyrMxWJPz1dcdVU/d1r3vOpVJGseBcqQJ/llHxGexJCLcA2muS9Vv/dq+/EQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741881619;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=21qxaZJUMfrnR91zfcgARK5+Av80xk5Antj7rW6iFIo=;
	b=HvWRmyrp7szvuEs2oMyKIEiHzpUlvYNq9wctIieR+zts1esJZVAGVc6GqCVYj9q+BkZGpv
	8pb2zV5LqqeuqWBg==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
 Jiri Slaby <jirislaby@kernel.org>
Subject: [patch 21/46] genirq/chip: Use lock guards where applicable
References: <20250313154615.860723120@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Thu, 13 Mar 2025 17:00:18 +0100 (CET)

Convert all lock/unlock pairs to guards and tidy up the code.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/irq/chip.c |   24 ++++++++----------------
 1 file changed, 8 insertions(+), 16 deletions(-)

--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -1081,25 +1081,21 @@ EXPORT_SYMBOL_GPL(irq_modify_status);
  */
 void irq_cpu_online(void)
 {
-	struct irq_desc *desc;
-	struct irq_chip *chip;
-	unsigned long flags;
 	unsigned int irq;
 
 	for_each_active_irq(irq) {
-		desc = irq_to_desc(irq);
+		struct irq_desc *desc = irq_to_desc(irq);
+		struct irq_chip *chip;
+
 		if (!desc)
 			continue;
 
-		raw_spin_lock_irqsave(&desc->lock, flags);
-
+		guard(raw_spinlock_irqsave)(&desc->lock);
 		chip = irq_data_get_irq_chip(&desc->irq_data);
 		if (chip && chip->irq_cpu_online &&
 		    (!(chip->flags & IRQCHIP_ONOFFLINE_ENABLED) ||
 		     !irqd_irq_disabled(&desc->irq_data)))
 			chip->irq_cpu_online(&desc->irq_data);
-
-		raw_spin_unlock_irqrestore(&desc->lock, flags);
 	}
 }
 
@@ -1111,25 +1107,21 @@ void irq_cpu_online(void)
  */
 void irq_cpu_offline(void)
 {
-	struct irq_desc *desc;
-	struct irq_chip *chip;
-	unsigned long flags;
 	unsigned int irq;
 
 	for_each_active_irq(irq) {
-		desc = irq_to_desc(irq);
+		struct irq_desc *desc = irq_to_desc(irq);
+		struct irq_chip *chip;
+
 		if (!desc)
 			continue;
 
-		raw_spin_lock_irqsave(&desc->lock, flags);
-
+		guard(raw_spinlock_irqsave)(&desc->lock);
 		chip = irq_data_get_irq_chip(&desc->irq_data);
 		if (chip && chip->irq_cpu_offline &&
 		    (!(chip->flags & IRQCHIP_ONOFFLINE_ENABLED) ||
 		     !irqd_irq_disabled(&desc->irq_data)))
 			chip->irq_cpu_offline(&desc->irq_data);
-
-		raw_spin_unlock_irqrestore(&desc->lock, flags);
 	}
 }
 #endif


