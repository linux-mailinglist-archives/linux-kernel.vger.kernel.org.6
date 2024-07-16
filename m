Return-Path: <linux-kernel+bounces-253880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DABB93282C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 16:21:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2ABD3B235AA
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 14:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4719819DF88;
	Tue, 16 Jul 2024 14:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hcIi+GWu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NOZuvwtZ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB5519CCE5
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 14:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721139608; cv=none; b=c/vS4baIOysgRBlI+DdcShkb3suebxYjfjYTj7sEKSIIvyI4qnEE78zYGwv007cwRNsirmYZ6T7V43umH4dkb4FApNg50OGxb+toY1rDXzd5wm6RaMBVy/LisS98OKo2q5GWCCPD7mwMFew3NbdzzoypwZ3EJgkICfuTpg25LSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721139608; c=relaxed/simple;
	bh=CJRPZNuXLuZ/yu9NhMbuXk9maWjw4OFm+J5olVlKwF4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kVqOzlBW+Gd1x+OxJoz2tr2Y06xiLQZRHrHCQvO0ywLuGVJS0w/eG+2JC5PA9/gRNpKVByxer5bPofiqmcYtzYHuvcJJNgedO8AseN8SmLPiRt8SpPStrFmzoBYCvGpodu1+c/WQ4sOLz5UvDtFj6Qo+duS6wlaJj1JcLv2eIrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hcIi+GWu; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NOZuvwtZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1721139599;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y7dNorIr0s63dA0vovdGnD9gO2IO8v8ecVyaj97Uvfo=;
	b=hcIi+GWu7heYDm3rDabjfz+V6D7dN1wzNGku59fv22qgTmT0EzJBhWpDKUJIjBGAJo01zr
	fAHQBO6zHeA8YPvcaIWI1qdFkmFsTWamwEk1eOFCi1xB4i4w6mY8+RHq/h9WZ5pYrpR1P9
	MySCR8vwZSRiCvAwrF9rLhLQScftJ3Qw83wX0SI1HPe9udjbjUYwQdt7cJBAg6/KDgwwki
	sIFoC9fjEMMN8AagqNRrkBMmgebLQGcTxEv/dpB7l0qmRna/X2U3j7GxKQy1E0QhzuGmdR
	2/o+d43UYyWvahjHyyjboq+IIPBFtdRp4xUbJ3bpibXXRFC3lq7M5sJGve0QWQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1721139599;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y7dNorIr0s63dA0vovdGnD9gO2IO8v8ecVyaj97Uvfo=;
	b=NOZuvwtZXvr+vpXT26zT5iZjw0tl4BWJev1RmSEMSlEVL0m8vJ+FRfza87ILAMvM5dy91g
	MwEIZeMQ5xo1kBBQ==
Date: Tue, 16 Jul 2024 16:19:25 +0200
Subject: [PATCH v4 7/8] timers/migration: Spare write when nothing changed
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240716-tmigr-fixes-v4-7-757baa7803fe@linutronix.de>
References: <20240716-tmigr-fixes-v4-0-757baa7803fe@linutronix.de>
In-Reply-To: <20240716-tmigr-fixes-v4-0-757baa7803fe@linutronix.de>
To: Frederic Weisbecker <frederic@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>

The wakeup value is written unconditionally in tmigr_cpu_new_timer(). When
there was no new next timer expiry that needs to be propagated, then the
value that was read before is written. This is not required.

Move write to the place where wakeup value could have changed.

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
---
 kernel/time/timer_migration.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/kernel/time/timer_migration.c b/kernel/time/timer_migration.c
index 5c206e71c212..d9f7e9b77f11 100644
--- a/kernel/time/timer_migration.c
+++ b/kernel/time/timer_migration.c
@@ -1215,14 +1215,13 @@ u64 tmigr_cpu_new_timer(u64 nextexp)
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


