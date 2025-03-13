Return-Path: <linux-kernel+bounces-559900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55EF7A5FAE9
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 17:12:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 439853A9E5E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 16:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2851271811;
	Thu, 13 Mar 2025 16:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hq4y0Mqw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="k303IY3z"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 561D427127F
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 16:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741881660; cv=none; b=RivrUvCyxQ3PWj70Q4KbR+SGC3BGE1mVLVfvY6sCxx6nE55qKptTql8wkG+P4yFtz6AtzNg7wijQ7i+HtQA95akht5p8gLSJLhINlpeqsp3XiS7aRfOuSIVLMdmtXrjMU43RwZrehZJJQxBRAhiX/43QuI2Quvq2ofd0jHDbMHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741881660; c=relaxed/simple;
	bh=oxAWkkjweR2dcrV3IFUDJGUa4rwOZbTpjVRPZpoxVJ8=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=tu9iF0Dc4+fVvKsxy4LqjAcx/eWDJAvlHl+pwXshvNsRIQYnukhQJE0IsdlBiyxFoURuBrv99b5q+vvseusg4OANS6fala26n8NlB0IRiaHVGXV7Cni4235tP8pE6Q7F48DCbn3nRGtupukdZbZArVH1WGF/ITA3U+ImJBt886Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hq4y0Mqw; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=k303IY3z; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250313155916.727004678@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741881656;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=0oLkp+NEekLX9fYn3uXFTOkyFkfnNag3oPTNUCOTQAk=;
	b=hq4y0MqwDt2pOyLIRh2v4VN0SFAnNOil4r6LeF2cLG/Mdn8v4ny8n+tqes/6O0ag9LUc+Y
	93zc7EMPuYiP4bMHA2fIeFTwdmuz7SwPsom/8Pp9WGXCsy6ichdWw0sKfjfUWU2uLugKXl
	Ndf7KuePvZovdpVwoI4iJduVZur9NEaCNkai1Anhr5RhygCIv236Z/HzfgU0oH2tsanUra
	AaYLIhFasB+yMHDxjI1PvdROkmGJd5ZmWLz030WXvyvLNZamtCyzhEiKEkDj9bx4+pM/i7
	kX2Bl6RupQXDnelIHehDUE24s114Pf4jN5YfzjnWR1IYbJBRB6p2irlhntrugg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741881656;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=0oLkp+NEekLX9fYn3uXFTOkyFkfnNag3oPTNUCOTQAk=;
	b=k303IY3zdZDPjCvDEaSh+1oUAEmyYrcFRz+s6NcwgjpzTAxykB7UDzNl67UxVND50G4hK5
	TnNDBI/q4pWhcdDw==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
 Jiri Slaby <jirislaby@kernel.org>
Subject: [patch 42/46] genirq/manage: Rework prepare_percpu_nmi()
References: <20250313154615.860723120@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Thu, 13 Mar 2025 17:00:55 +0100 (CET)

Use the new guards to get and lock the interrupt descriptor and tidy up the
code.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/irq/manage.c |   31 +++++++++----------------------
 1 file changed, 9 insertions(+), 22 deletions(-)

--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -2605,32 +2605,19 @@ int request_percpu_nmi(unsigned int irq,
  */
 int prepare_percpu_nmi(unsigned int irq)
 {
-	unsigned long flags;
-	struct irq_desc *desc;
-	int ret = 0;
+	int ret = -EINVAL;
 
 	WARN_ON(preemptible());
 
-	desc = irq_get_desc_lock(irq, &flags,
-				 IRQ_GET_DESC_CHECK_PERCPU);
-	if (!desc)
-		return -EINVAL;
-
-	if (WARN(!irq_is_nmi(desc),
-		 KERN_ERR "prepare_percpu_nmi called for a non-NMI interrupt: irq %u\n",
-		 irq)) {
-		ret = -EINVAL;
-		goto out;
-	}
-
-	ret = irq_nmi_setup(desc);
-	if (ret) {
-		pr_err("Failed to setup NMI delivery: irq %u\n", irq);
-		goto out;
+	scoped_irqdesc_get_and_lock(irq, IRQ_GET_DESC_CHECK_PERCPU) {
+		if (WARN(!irq_is_nmi(scoped_irqdesc),
+			 "prepare_percpu_nmi called for a non-NMI interrupt: irq %u\n", irq))
+			return -EINVAL;
+
+		ret = irq_nmi_setup(scoped_irqdesc);
+		if (ret)
+			pr_err("Failed to setup NMI delivery: irq %u\n", irq);
 	}
-
-out:
-	irq_put_desc_unlock(desc, flags);
 	return ret;
 }
 


