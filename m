Return-Path: <linux-kernel+bounces-227433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D6AB91511E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 16:57:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC1AC286E39
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 14:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1768B19E803;
	Mon, 24 Jun 2024 14:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tEW5r+9r";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3Im6ORrd"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01CFF19D88C
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 14:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719240864; cv=none; b=gX+5xZSHagpmeJP9EWNEbpoGs/SKf2kOJfejwgmvyF2FUJZj6avotjoSA+SwQXU4g34YprZvQu5ehbl8rcC2hcRr9wzOUpyUnAIrnCsJHQn6DITOtKyerKwBQWv3x1bSj/MMiAYIsqohHVCsJNqVYD4EZmMkBkAvXFqECt8KXGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719240864; c=relaxed/simple;
	bh=sOD5/KUI5C/W7gKfhdqKa1clLl9j4FoXxPG9kCjGskc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZVTtsymrGTAcbRKjJcfDrrZDDJ+IaMxwoDKkjqmbDHch2gJWwCgLcbynxZxrT3oNCPNfhmTSHVO4jXOdZSp5qEfX83d9YK49RS+jC+UpSsmvnai4RZXAr2IOXdUyUXTNHsQGxEF+OXporArSP9Hxj+3jDKGePipStugKuROusv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tEW5r+9r; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3Im6ORrd; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719240859;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Op6walJII/gVaxljfpCXLxR/HhgFf5B7QUNkyDEsexo=;
	b=tEW5r+9riqeajpxUUvRgdNcYb85XusNKpjA/FWBOiJCk1sd0iUqYEBDNuruj/6fIl+1m7B
	73WQ2i5Shx5Endd2q/HB9mlU5kJc5StXwc1soFgLnIN0XtCS2a44wip/cuTy4wBdu67ltu
	K1idILjobmLStEHSMRwlNc8853+c1zmIlP8+YOgBnmlTqEbBLgqjluqnsWGzx5ICSQyiCF
	3z3ZNI5SQqlPTuj+FiQmnjcPxwrb0W9IOhEhfW5dgl4s0weTKRDqqGGNSZVwQEslBMVzWv
	r40A7h9Ei4t9h3ckxGtuBGT+apTcjZsUmXRLuEsG09e1rkzKsdMxmb7J39qPQQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719240859;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Op6walJII/gVaxljfpCXLxR/HhgFf5B7QUNkyDEsexo=;
	b=3Im6ORrd0BV9fThFY2aELbdk1VADrfIJlxTmDPEzU3ZbVD4YytSq32f6KqRybp+tHylYos
	hvOdksFTaylQTfBA==
Date: Mon, 24 Jun 2024 16:53:57 +0200
Subject: [PATCH v2 5/5] timer_migration: Spare write when nothing changed
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240624-tmigr-fixes-v2-5-3eb4c0604790@linutronix.de>
References: <20240624-tmigr-fixes-v2-0-3eb4c0604790@linutronix.de>
In-Reply-To: <20240624-tmigr-fixes-v2-0-3eb4c0604790@linutronix.de>
To: Frederic Weisbecker <frederic@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>

The wakeup value is written unconditionally in tmigr_cpu_new_timer(). When
there was no new next timer expiry that needs to be propagated, then the
value that was read before is written. This is not required.

Move write to the place where wakeup value could have changed.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
---
 kernel/time/timer_migration.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/kernel/time/timer_migration.c b/kernel/time/timer_migration.c
index 7971512a60b0..3fb47e4b4ce4 100644
--- a/kernel/time/timer_migration.c
+++ b/kernel/time/timer_migration.c
@@ -1248,14 +1248,13 @@ u64 tmigr_cpu_new_timer(u64 nextexp)
 		if (nextexp != tmc->cpuevt.nextevt.expires ||
 		    tmc->cpuevt.ignore) {
 			ret = tmigr_new_timer(tmc, nextexp);
+			/*
+			 * Make sure the reevaluation of timers in idle path
+			 * will not miss an event.
+			 */
+			WRITE_ONCE(tmc->wakeup, ret);
 		}
 	}
-	/*
-	 * Make sure the reevaluation of timers in idle path will not miss an
-	 * event.
-	 */
-	WRITE_ONCE(tmc->wakeup, ret);
-
 	trace_tmigr_cpu_new_timer_idle(tmc, nextexp);
 	raw_spin_unlock(&tmc->lock);
 	return ret;

-- 
2.39.2


