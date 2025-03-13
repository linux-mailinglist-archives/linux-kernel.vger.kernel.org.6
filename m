Return-Path: <linux-kernel+bounces-559895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E2C2A5FADC
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 17:10:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 440C319C42AE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 16:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ED0F270EBE;
	Thu, 13 Mar 2025 16:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IFcj6FBD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QHyElu3r"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485C91D79B6
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 16:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741881651; cv=none; b=Pj/W86VGTghugP7Pbihi81KcEnDzt6Dbl7hGjBr47zalA+tlIFYqDuLaw0IDU52Ibjs9P7xKv2LHW8cuhgeO+gdfyRR0yZ18iWFv33i0QEfVivKp75k5qzZ+5nJziPxBDriG6jTPt2rPlCZLdaIzOFKOpQK87Pn7E0o/VX0z/78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741881651; c=relaxed/simple;
	bh=7OGHj8ca1aYwqj1cPr9aQ7GIsfk2dFspz38uKwmKKO8=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=fdgVfsqai7KLg0oFG8z9X4Pz3BlSoWTwVDVEbAq04SpR4B1dB3caa6144sCOsgyXJd+5Bi4/7EHI2MZoSeECQR1SY2m7ltHwH61UKUR5X6UONpsU2FML33ymYwQizlaXsfgzCYPsMvt4qetde6OLEeJ4OMmHD0Sdsjex8Dzo2qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IFcj6FBD; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QHyElu3r; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250313155916.461197302@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741881648;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=o6UlnlIYX7HzshZEKYRUTMKnqz9sEvfGRD91Swcs20o=;
	b=IFcj6FBDmSgU0k7IfKJIfejmv7epSrPRq7e8ubdkfVgPwltJN6iGOkEgJ0PjwYaBR4ehT7
	OJ7iqSlP1a/Om+ufwAz/SyAZNOEa+UmxZFyfFyJw33ZvHS7zte0aZbzOP1sBDdSw0ViX6K
	pzriFzyNvCAfejYnpFCi4E9t19+fLvZcaFr6TLBSwW4sfa53rQqjd4e4M/4T30QEO1Gn/g
	CN+X6+DW/qG3FCEpRsNa3hIzluXoJEUDKkOMPhy6NHxy9YJcU+DSd+KVnVcK0YumHvFxOV
	zlZy+M6s3OzkNuO2CPmbMw00CbY6uqwsLmZMgIhujifFCPbEp5MHmxNlbeTZvQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741881648;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=o6UlnlIYX7HzshZEKYRUTMKnqz9sEvfGRD91Swcs20o=;
	b=QHyElu3rMYT3f10vkHsJkyZKLrirwdlyvBLLeLPadqwBj8KchUgLBA0qXuxlB5KirjqKEX
	rnQd2Fy9UjnkRmBQ==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
 Jiri Slaby <jirislaby@kernel.org>
Subject: [patch 38/46] genirq/manage: Rework irq_set_parent()
References: <20250313154615.860723120@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Thu, 13 Mar 2025 17:00:48 +0100 (CET)

Use the new guards to get and lock the interrupt descriptor and tidy up the
code.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/irq/manage.c |   15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -958,16 +958,11 @@ int __irq_set_trigger(struct irq_desc *d
 #ifdef CONFIG_HARDIRQS_SW_RESEND
 int irq_set_parent(int irq, int parent_irq)
 {
-	unsigned long flags;
-	struct irq_desc *desc = irq_get_desc_lock(irq, &flags, 0);
-
-	if (!desc)
-		return -EINVAL;
-
-	desc->parent_irq = parent_irq;
-
-	irq_put_desc_unlock(desc, flags);
-	return 0;
+	scoped_irqdesc_get_and_lock(irq, 0) {
+		scoped_irqdesc->parent_irq = parent_irq;
+		return 0;
+	}
+	return -EINVAL;
 }
 EXPORT_SYMBOL_GPL(irq_set_parent);
 #endif


