Return-Path: <linux-kernel+bounces-559893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0920EA5FAD8
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 17:10:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EDA6189AC12
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 16:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C4102702BA;
	Thu, 13 Mar 2025 16:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EOqt56Sf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KkQGrnt6"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E7C27005D
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 16:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741881647; cv=none; b=fo/gGiLQq2NmUyZMGSxcPNJb73IUiBhN0iT829VDx56w+gMxlCktxxEHaLokkti5xlV7zKSp1kfxdScyeX+y6LcanoLKpTH6yOplcS/Pvvm1Un274CcBt6aSIeajZ8zQW1aHriiyXqA4CrEqA9Mf9M6/a66pYcfV1vCO2I3PxL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741881647; c=relaxed/simple;
	bh=Xbp4GPbXtcWOJ71YmuLxg1E6RaEKbB2RnvBInvUoDnI=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=Psrvtd0jmBkzlvs7ULixF0ApIP3GaoGQaNOpA6IIxMehuJj6wRivg/kSjUDgJLf47J/ecPKoz3cfLgWLA/rSp/KLbpX0hFm0CinM4cp6lQhkjDk3+Gvo0GF43xMrkAVmmMDt95C171msce989e5ZYwxtnY9W1vMa07qnNhB6UC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EOqt56Sf; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KkQGrnt6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250313155916.329399391@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741881645;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=/BowEdnxdEYpHrLC8+9yvjB5ISXv0pAhEHCMyXLAkQI=;
	b=EOqt56Sf9jdWMGx9pREH8VxJiFW0a73gGkRo6n+pivgNEZ2QTe8frOdck7zFEPUHHIkLtB
	OhGijl+gS/KZvm8fzCGmu8+EYb+l53vbYe9uVyto7YVKoamDjLyCoIzlf7fKXrPRlEUOtq
	UIaa4nHBm4FTpetHoOhRgJ7j5i3tgHmxf79aI0YztZxb5TN3/G8McHJcvzY80bsrEUTBdN
	qAL327qGNjDZxOZvdHky7kpdp0cffrOc76x0K+Si4NEVyo3NQYfq0a9byXSQXhpZB8WC2o
	1zJAn8TFbLVDCe0C3dKgcyEaZ8iGkQ7TkrYgc7dN5zk9K6j976WOlS/5G3KFyQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741881645;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=/BowEdnxdEYpHrLC8+9yvjB5ISXv0pAhEHCMyXLAkQI=;
	b=KkQGrnt6H8jLsD0oJEvOVnDQibhpauzIOqR4+125PyI5KlvswGaekWsL90+ayUPNHhn1Sg
	FNV7RqZx7brU+QDQ==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
 Jiri Slaby <jirislaby@kernel.org>
Subject: [patch 36/46] genirq/manage: Rework irq_set_irq_wake()
References: <20250313154615.860723120@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Thu, 13 Mar 2025 17:00:44 +0100 (CET)

Use the new guards to get and lock the interrupt descriptor and tidy up the
code.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/irq/manage.c |   61 +++++++++++++++++++++++-----------------------------
 1 file changed, 28 insertions(+), 33 deletions(-)

--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -845,44 +845,39 @@ static int set_irq_wake_real(unsigned in
  */
 int irq_set_irq_wake(unsigned int irq, unsigned int on)
 {
-	unsigned long flags;
-	struct irq_desc *desc = irq_get_desc_buslock(irq, &flags, IRQ_GET_DESC_CHECK_GLOBAL);
-	int ret = 0;
+	int ret = -EINVAL;
 
-	if (!desc)
-		return -EINVAL;
+	scoped_irqdesc_get_and_lock(irq, IRQ_GET_DESC_CHECK_GLOBAL) {
+		struct irq_desc *desc = scoped_irqdesc;
 
-	/* Don't use NMIs as wake up interrupts please */
-	if (irq_is_nmi(desc)) {
-		ret = -EINVAL;
-		goto out_unlock;
-	}
+		/* Don't use NMIs as wake up interrupts please */
+		if (irq_is_nmi(desc))
+			return -EINVAL;
 
-	/* wakeup-capable irqs can be shared between drivers that
-	 * don't need to have the same sleep mode behaviors.
-	 */
-	if (on) {
-		if (desc->wake_depth++ == 0) {
-			ret = set_irq_wake_real(irq, on);
-			if (ret)
-				desc->wake_depth = 0;
-			else
-				irqd_set(&desc->irq_data, IRQD_WAKEUP_STATE);
-		}
-	} else {
-		if (desc->wake_depth == 0) {
-			WARN(1, "Unbalanced IRQ %d wake disable\n", irq);
-		} else if (--desc->wake_depth == 0) {
-			ret = set_irq_wake_real(irq, on);
-			if (ret)
-				desc->wake_depth = 1;
-			else
-				irqd_clear(&desc->irq_data, IRQD_WAKEUP_STATE);
+		/*
+		 * wakeup-capable irqs can be shared between drivers that
+		 * don't need to have the same sleep mode behaviors.
+		 */
+		if (on) {
+			if (desc->wake_depth++ == 0) {
+				ret = set_irq_wake_real(irq, on);
+				if (ret)
+					desc->wake_depth = 0;
+				else
+					irqd_set(&desc->irq_data, IRQD_WAKEUP_STATE);
+			}
+		} else {
+			if (desc->wake_depth == 0) {
+				WARN(1, "Unbalanced IRQ %d wake disable\n", irq);
+			} else if (--desc->wake_depth == 0) {
+				ret = set_irq_wake_real(irq, on);
+				if (ret)
+					desc->wake_depth = 1;
+				else
+					irqd_clear(&desc->irq_data, IRQD_WAKEUP_STATE);
+			}
 		}
 	}
-
-out_unlock:
-	irq_put_desc_busunlock(desc, flags);
 	return ret;
 }
 EXPORT_SYMBOL(irq_set_irq_wake);


