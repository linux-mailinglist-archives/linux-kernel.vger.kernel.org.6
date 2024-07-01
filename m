Return-Path: <linux-kernel+bounces-236005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FFB691DC3C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 12:20:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93A141C203BE
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 10:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10D961494B8;
	Mon,  1 Jul 2024 10:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BrOJa88j";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="h3uMs5kf"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 977B213D625
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 10:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719829146; cv=none; b=GmKWKb7y996q6AFFrsKRdNHykpo9eiKqdGqEfB653tv65w9rDVb1AAq6y353QYuVF/TBQxCWuxoU52gaWYnyKrac9jNVx3jMK2rrV5Y6I62NfgZsE8IBdA3HvCP+SRoCzHNWQrDBU/MGc7syWGDY9cwbjuv1dbHOrCwYEsp1NqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719829146; c=relaxed/simple;
	bh=d1bdnk8WhuesMoDYlsyVW3NQHYSNR0skAu9tJwrhzmA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JHwV34M7G8Fj6a5QmuMwfqAp8nLZpM6d1mNwnsNijj0Ti4IdxdcqDVd5ukCTm3Xb0U2Pay3yW2RTdQgxvf6FFxsT8R4m7PPmm3Vws6TF7guOfRfEPn9tglCwTkmKQEJgkLGdHXq41bAsN3mjDK4fFfz2iztHbAdKd4Y+XXlQpqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BrOJa88j; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=h3uMs5kf; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719829137;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bCPPgf214+6N8Oo0G5UoJkaX1kFyTqM3hFGlx6gP1Jw=;
	b=BrOJa88jQEpUtulkmC1RA6HxGXwMttxhH14n7i0W7MbJ0XYzi1kI5zvU0fY2X8aB7TsIF5
	nAaxoISn9a+xcavVRXwAhAl/sKK8AMp/jGOayD7Ft7JUSQq6WSz4L+0GaniZ40kLh2fP4X
	gW3jppH5QB+tSpjgWqGkLi7DOgquyxAHmtgjDOWKFRmrOk+5R7k7IG+pdhxEP0TKPmC1ea
	q2+/V2cY/YayhGykG5SSWRYXRkHOtMz3AABKoVsP738TszdsLnUtJkxVeO6TDhLkzMUD1R
	OoJRhVqMH6UcaxxzpdWjm9tuwAnUiX1Ugv2F5j3PPim4ACjVuJ2lndr/8t9+SQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719829137;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bCPPgf214+6N8Oo0G5UoJkaX1kFyTqM3hFGlx6gP1Jw=;
	b=h3uMs5kfde4IwJ6RI1rwC5dBo55Zc1xklpIyLvHDmcsjUWXi9qdasMVD8MvdPkXx4VYGuH
	wCYzqqn4czKJ0rBg==
Date: Mon, 01 Jul 2024 12:18:43 +0200
Subject: [PATCH v3 7/8] timers/migration: Spare write when nothing changed
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240701-tmigr-fixes-v3-7-25cd5de318fb@linutronix.de>
References: <20240701-tmigr-fixes-v3-0-25cd5de318fb@linutronix.de>
In-Reply-To: <20240701-tmigr-fixes-v3-0-25cd5de318fb@linutronix.de>
To: Frederic Weisbecker <frederic@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>

The wakeup value is written unconditionally in tmigr_cpu_new_timer(). When
there was no new next timer expiry that needs to be propagated, then the
value that was read before is written. This is not required.

Move write to the place where wakeup value could have changed.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/time/timer_migration.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/kernel/time/timer_migration.c b/kernel/time/timer_migration.c
index b73d89e78163..bbc849539dd2 100644
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


