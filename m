Return-Path: <linux-kernel+bounces-559865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DC9DA5FAA7
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 17:02:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FCEC420309
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 16:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DADE826B0AA;
	Thu, 13 Mar 2025 16:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pzCXlYly";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pxmE3x4P"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B3226AAB5
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 15:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741881601; cv=none; b=CSQO58zzazP89K304vMoW5QbiO/ixgCftdXR9XgO2HA3RDZ4q/YqTGqaMiWfflZRQl9fW6BLyM5OHKFVOOYavUQAlg9GPStjJaeu4ybx3ZZlfko5FHK5rOVRoB9fayG1V1FzBLtTxPs5ceYyZPdmuIw57LdEDq6URAIBnTopaVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741881601; c=relaxed/simple;
	bh=SXm/HPpRo9Hckn9uMEaCtJbqdUF8WWZ5y3ZzWz42Y+g=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=Q9fBOMxCdyxCt7teSaShzgwJwczp9iQS6/okkADTdN+xX58NZEtCyoiFLZqFR8P61KEqNzvskoO5ukeNUkYEwkhTFU2ZXNFYhI3o1oK74obfoV4lOe0CBEdE94WrV9xQtdYR3VJFG1m/rRvGuvItvNrXruXdDyzbpYhxlqb3nS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pzCXlYly; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pxmE3x4P; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250313155914.476509483@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741881598;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=RR9+I+Z137lD39z9Z00YQbOao2INFH7E7M22ZTqEg/k=;
	b=pzCXlYlyVioAOzvEAR+h7h7L0FbBPXNG1rc0aihp2bYLRFbHb15FXuT01Nu9uV22Af5XK6
	DvH/oyGWFuuCilFe6RdEzo7567SRH/OHAROrMhStpeYO6f+/dNLNQzeaZBCwuhyWP4nurF
	HBB3ptP3F7+4/+rdjlITApzpNNdsjlRp7hgaSiDPfNDpOD2xYrkYE8qa5OW9xbWQUDpLao
	7oOLYX1SowOCaBSXAdzlHDbm0goqbDp+Gqrw6KNfLO0ZeTaHdsQ+iKI12T//i903O/nR0S
	p2MT1yC4YLvNnqbsWFRfG6hnZJJN7rK53biw3/sWoTRw8eZkM00152RNN2Hp0Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741881598;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=RR9+I+Z137lD39z9Z00YQbOao2INFH7E7M22ZTqEg/k=;
	b=pxmE3x4P/bUtoWezCMkxIkhgO19obu9UKRPoS0t23v3+x7f1Dhx6ItBccI+5UJ7uY4OakH
	9ZLhYGGZo9AdzjDQ==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
 Jiri Slaby <jirislaby@kernel.org>
Subject: [patch 09/46] genirq/cpuhotplug: Convert to lock guards
References: <20250313154615.860723120@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Thu, 13 Mar 2025 16:59:57 +0100 (CET)

Convert all lock/unlock pairs to guards and tidy up the code.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/irq/cpuhotplug.c |   10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

--- a/kernel/irq/cpuhotplug.c
+++ b/kernel/irq/cpuhotplug.c
@@ -177,9 +177,8 @@ void irq_migrate_all_off_this_cpu(void)
 		bool affinity_broken;
 
 		desc = irq_to_desc(irq);
-		raw_spin_lock(&desc->lock);
-		affinity_broken = migrate_one_irq(desc);
-		raw_spin_unlock(&desc->lock);
+		scoped_guard (raw_spinlock, &desc->lock)
+			affinity_broken = migrate_one_irq(desc);
 
 		if (affinity_broken) {
 			pr_debug_ratelimited("IRQ %u: no longer affine to CPU%u\n",
@@ -244,9 +243,8 @@ int irq_affinity_online_cpu(unsigned int
 	irq_lock_sparse();
 	for_each_active_irq(irq) {
 		desc = irq_to_desc(irq);
-		raw_spin_lock_irq(&desc->lock);
-		irq_restore_affinity_of_irq(desc, cpu);
-		raw_spin_unlock_irq(&desc->lock);
+		scoped_guard (raw_spinlock, &desc->lock)
+			irq_restore_affinity_of_irq(desc, cpu);
 	}
 	irq_unlock_sparse();
 


