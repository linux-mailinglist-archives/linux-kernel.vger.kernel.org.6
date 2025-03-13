Return-Path: <linux-kernel+bounces-559891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BD48A5FACB
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 17:08:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC3BF17F231
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 16:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 622B227004C;
	Thu, 13 Mar 2025 16:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dIslWc8a";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0UF9EI4n"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32CE127002E
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 16:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741881644; cv=none; b=Yu3GZUh1xB+ijKJKXsPZM5GtK6phPsQfVwKYiYTzdEpW9xoXVSXI9DaQaFRofKiH4d6z7EMNqjq3pyY781WU2ryTu44d8NJhVinEXlHvuk2yhvKwEe06kV7nszNJw0LCyUrc84ZnOVu/QxnsLqcK+j79S/76hCuoMd2IbA1sd60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741881644; c=relaxed/simple;
	bh=y2Qfgh9O3vyfxqJvAsH1OMkacDTWW15QSL0dVpGaE28=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=E9sJnnNPuxdRwAyFGZ1JYPnihffkFSQYjwKtjHOKfzr5L7FEYbSV2MFPAqOexwR0lz7QP3doUGHhTOWvtGsfIFAngi2NyOha55P0jtQnb0W4dSZ5GiTDVmT98qbjfmx1pQhip5a4KPaQ5elyYg2ZjDb7N2dt6BfVecCE8GR5GGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dIslWc8a; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0UF9EI4n; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250313155916.196278528@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741881641;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=FyGdT/wj/ZEi69WkEeKXZEcm1FmkbQvnmLPT35GEITM=;
	b=dIslWc8aI/2PXqjTmJNj8f4AOFoGliEPZfH4g0UwtWC5ANf77GULiWfhekgrFjZvkxBn1T
	G+Ggi93Xk2jYFQzb9RJ9VsFdD4tVsmAs0pHVxHIGvt38r+YG0seSpQDfP08JHAbW2ezkjh
	hic96GmpLvSEURpqVmGq2moIPbNQ4kh83ztTZGS0GNCW1ZB/KsGba70q7QbJzTnkVCZlvD
	awG54W6KC+dFsLKGu3uIorx9/HelH7fut/gxNx9gBcINOqbL+zACQr3J8mH3g8CRVS1kve
	QDj93BCCJq63mVmcyM7276AAvTkXYOYlcObVOUqQr5FbtKGwOZB1sLlkC8JLhg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741881641;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=FyGdT/wj/ZEi69WkEeKXZEcm1FmkbQvnmLPT35GEITM=;
	b=0UF9EI4nGSzvcUYkJ7tFj4pq7YoYATJ2RSGDGYyi98SNY5g3u2YH6PivMrmIqT0lBbbc2w
	zxx9q++8cUgDHHCA==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
 Jiri Slaby <jirislaby@kernel.org>
Subject: [patch 34/46] genirq/manage: Rework __disable_irq_nosync()
References: <20250313154615.860723120@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Thu, 13 Mar 2025 17:00:41 +0100 (CET)

Use the new guards to get and lock the interrupt descriptor and tidy up the
code.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/irq/manage.c |   13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -658,14 +658,11 @@ void __disable_irq(struct irq_desc *desc
 
 static int __disable_irq_nosync(unsigned int irq)
 {
-	unsigned long flags;
-	struct irq_desc *desc = irq_get_desc_buslock(irq, &flags, IRQ_GET_DESC_CHECK_GLOBAL);
-
-	if (!desc)
-		return -EINVAL;
-	__disable_irq(desc);
-	irq_put_desc_busunlock(desc, flags);
-	return 0;
+	scoped_irqdesc_get_and_lock(irq, IRQ_GET_DESC_CHECK_GLOBAL) {
+		__disable_irq(scoped_irqdesc);
+		return 0;
+	}
+	return -EINVAL;
 }
 
 /**


