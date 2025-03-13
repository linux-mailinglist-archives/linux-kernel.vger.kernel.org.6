Return-Path: <linux-kernel+bounces-559890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62517A5FAD6
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 17:09:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DBE4188F05B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 16:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B475B270037;
	Thu, 13 Mar 2025 16:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3gTtskj3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="G8L+RlfU"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8859D26FD9F
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 16:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741881643; cv=none; b=jOGHhx9uqGKf44OeRSEU0QBK0FQrqhDVVqVpXfrMhL5HZBf3wOfEKdOAkqaYmzggDpax13hsOm7XvLJbZnfOL46sbaAFY/83+7vsnx46QPShWkLsappG21Eu46xOFhRMK0V+i5fC6VITjUxgZxZlJwdbOOQU172dRbtXRz9pC8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741881643; c=relaxed/simple;
	bh=fX+9V4hA3EQMuF54WJ/NA4nHJQFLadOEmXV9GbY9xOc=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=r0PB0b8fC0IplYOOCZ87kw9f09AML4TPRLV+ZSgSRdnxrP9/K2f5SWsoC2u3Bl+gxw3DjU5OUB2BTzYSbmbegQ85hjQFt3x6QOow0JmtaWKsqQQCPd2mS6Gjgni3n/ZVEXk6lCzKyazD7zDfhtdhwS/TZt2umqyk7wvZxq1hbDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3gTtskj3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=G8L+RlfU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250313155916.130540523@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741881639;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=yrnX7COU4LFeImoI8Wb78L4FNIeSjf4l0HTLETlsEkY=;
	b=3gTtskj3yBKtHpIed725QXcgfplI1mgd78ieU55TvqMuc8u4fkLP8sf3DKMAcWaObdI1kO
	/051GjvL9IRAu0oPcI04bL1WIU/f8CeOlsSnwavwbKVXNY7lIc7+C7NynNIr+VgWppHjxv
	DCIBrG+fN//9i+y36v+YsveTHO+Q+sxHMLaKOsTaRNCLTgXAKdpqWn9nziBoh/UmmNfgmy
	t3SOrAoJ1tFzXeIwDxrMfr1MekFqzjsgFRpsaK+M1J/jRnSXSknqQAkNTHCGthk5AMJM56
	zUOhH7yhJr6uojmn2rjuyz0ykrMMzdTssASTc3b/mxZdt9tAaZUXbksqOvVTlw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741881639;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=yrnX7COU4LFeImoI8Wb78L4FNIeSjf4l0HTLETlsEkY=;
	b=G8L+RlfUS8GAG+AZEcnKWEXydxCbgxnE+2tIp/gO+K1sMoDNExc+TanGbYeqFqvyJ+H2Ba
	pafk/5nxpf3eSRCw==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
 Jiri Slaby <jirislaby@kernel.org>
Subject: [patch 33/46] genirq/manage: Rework irq_set_vcpu_affinity()
References: <20250313154615.860723120@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Thu, 13 Mar 2025 17:00:39 +0100 (CET)

Use the new guards to get and lock the interrupt descriptor and tidy up the
code.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/irq/manage.c |   40 +++++++++++++++++-----------------------
 1 file changed, 17 insertions(+), 23 deletions(-)

--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -627,32 +627,26 @@ int irq_setup_affinity(struct irq_desc *
  */
 int irq_set_vcpu_affinity(unsigned int irq, void *vcpu_info)
 {
-	unsigned long flags;
-	struct irq_desc *desc = irq_get_desc_lock(irq, &flags, 0);
-	struct irq_data *data;
-	struct irq_chip *chip;
-	int ret = -ENOSYS;
+	scoped_irqdesc_get_and_lock(irq, 0) {
+		struct irq_desc *desc = scoped_irqdesc;
+		struct irq_data *data;
+		struct irq_chip *chip;
+		int ret = -ENOSYS;
 
-	if (!desc)
-		return -EINVAL;
+		data = irq_desc_get_irq_data(desc);
+		do {
+			chip = irq_data_get_irq_chip(data);
+			if (chip && chip->irq_set_vcpu_affinity)
+				break;
 
-	data = irq_desc_get_irq_data(desc);
-	do {
-		chip = irq_data_get_irq_chip(data);
-		if (chip && chip->irq_set_vcpu_affinity)
-			break;
-#ifdef CONFIG_IRQ_DOMAIN_HIERARCHY
-		data = data->parent_data;
-#else
-		data = NULL;
-#endif
-	} while (data);
+			data = irqd_get_parent_data(data);
+		} while (data);
 
-	if (data)
-		ret = chip->irq_set_vcpu_affinity(data, vcpu_info);
-	irq_put_desc_unlock(desc, flags);
-
-	return ret;
+		if (data)
+			ret = chip->irq_set_vcpu_affinity(data, vcpu_info);
+		return ret;
+	}
+	return -EINVAL;
 }
 EXPORT_SYMBOL_GPL(irq_set_vcpu_affinity);
 


