Return-Path: <linux-kernel+bounces-559894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ECD90A5FADA
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 17:10:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61A9819C79D0
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 16:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B5332702DD;
	Thu, 13 Mar 2025 16:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UNwAMfGL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ayh0/9oG"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C45D2702B4
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 16:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741881649; cv=none; b=SdgBK1Eotr7UseL9HjUJYb5F40O91Z05irpeyuXhg+o/pXMkhiZRPWQn5sjRqg+D+N3bb2ZHA7HLQfKBDv40Q2JgeY9/DPZd3QqANnGmYxiPk+uu61RctfUqJqOlUcKdbcbIULSjaAkMhH2aed0hXhm+YcLAjNP8UNcOCr5WijM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741881649; c=relaxed/simple;
	bh=VQzJgZotj8ZtgQcJ6Edhm1zAkrPtwYakyzFXTItHvYU=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=ahW1q31Yw0/2eqv0AldmMzcKFiCKIGNQke44jqInWOH6HwhGaOTzZFWy+rvanWlLIshqitlrbJcZXQ482xw7uzh1vXlR/qi5PSvwmBLob4ah6eL5RitiWYIfuNJv2NMeQlPQztLGo1fpIxbC5VOdh644S70xjowoubSFvUJtjyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UNwAMfGL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ayh0/9oG; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250313155916.394833438@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741881646;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=XEQFY2GvR2o0nlA2bS1T5VB3+fBDAJQ6z72wzlPROe8=;
	b=UNwAMfGLPzkHORz924FBXAq1HPhNYHtYN27WWapI7GY2YPlXzb4xOHKsx1TVF/Y3uIMXNe
	eXwPOo2kqgf4sdWMax5XiwP375Q8kmaNvai16P4m+pLLWc/Umj3LwQACKgd37EdmZa9pS3
	AGCBYnPFDw4nqLvgs9NUzOrL0+4tYYQEAriIiob0hod88aXSS6xhyIfbkxceSyTWSfHPhr
	v8B/yPGew6i4nPC2uQQSYEFs2Nsy5lWnQO9VaNAau9WJPfyIUN1NI2/NRWnEAfnCfZgGFq
	mdfZuyxhiOlWnK4e5+BoDhfXqEqi9T8o58WKoFlp4He6dlVEhJ2EllSwVuMuqw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741881646;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=XEQFY2GvR2o0nlA2bS1T5VB3+fBDAJQ6z72wzlPROe8=;
	b=ayh0/9oGh3XYwzAVzJsAHCZWr5/Cp8rUAbsVEB0I0UQyZFh7K7esFwAfg3Jh5yQ56UH979
	XR6e8jta3IFSBIBA==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
 Jiri Slaby <jirislaby@kernel.org>
Subject: [patch 37/46] genirq/manage: Rework can_request_irq()
References: <20250313154615.860723120@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Thu, 13 Mar 2025 17:00:46 +0100 (CET)

Use the new guards to get and lock the interrupt descriptor and tidy up the
code.

Make the return value boolean to reflect it's meaning.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/irq.h |    2 +-
 kernel/irq/manage.c |   21 ++++++++-------------
 2 files changed, 9 insertions(+), 14 deletions(-)

--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -700,7 +700,7 @@ extern void note_interrupt(struct irq_de
 extern int noirqdebug_setup(char *str);
 
 /* Checks whether the interrupt can be requested by request_irq(): */
-extern int can_request_irq(unsigned int irq, unsigned long irqflags);
+extern bool can_request_irq(unsigned int irq, unsigned long irqflags);
 
 /* Dummy irq-chip implementations: */
 extern struct irq_chip no_irq_chip;
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -887,22 +887,17 @@ EXPORT_SYMBOL(irq_set_irq_wake);
  * particular irq has been exclusively allocated or is available
  * for driver use.
  */
-int can_request_irq(unsigned int irq, unsigned long irqflags)
+bool can_request_irq(unsigned int irq, unsigned long irqflags)
 {
-	unsigned long flags;
-	struct irq_desc *desc = irq_get_desc_lock(irq, &flags, 0);
-	int canrequest = 0;
+	scoped_irqdesc_get_and_lock(irq, IRQ_GET_DESC_CHECK_GLOBAL) {
+		struct irq_desc *desc = scoped_irqdesc;
 
-	if (!desc)
-		return 0;
-
-	if (irq_settings_can_request(desc)) {
-		if (!desc->action ||
-		    irqflags & desc->action->flags & IRQF_SHARED)
-			canrequest = 1;
+		if (irq_settings_can_request(desc)) {
+			if (!desc->action || irqflags & desc->action->flags & IRQF_SHARED)
+				return true;
+		}
 	}
-	irq_put_desc_unlock(desc, flags);
-	return canrequest;
+	return false;
 }
 
 int __irq_set_trigger(struct irq_desc *desc, unsigned long flags)


