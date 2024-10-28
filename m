Return-Path: <linux-kernel+bounces-384242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A6C29B28BA
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 08:30:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A7681F2129F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 07:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4D78191496;
	Mon, 28 Oct 2024 07:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lBT+R3TA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KfvDvQNc"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 670BE15EFA1
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 07:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730100624; cv=none; b=qoJRslXPdfAYo3UkGUWq5VKVQVB25Zut4U9HD9Ufi0DDGd0pIOwYRjpU1kJBQ4W5lciVqwUEgGkCxtG6YXP1sXVNv/CUeA9sP3x+JuZ8e/qp6gw5lPQCOdPvi5JSgNZbdN2WiV7mXmng4WsvtfD+oeSHx6RM+I1ld1xaR09ea94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730100624; c=relaxed/simple;
	bh=w6b5i/T1VVaux01TmW7MupzzMAE/YhWZ7cFM/9JFuJw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bRduHbw85ukyhYySytebQR+UaYcpwx24U2hnyYZw00HYKN+C+XrbpL80gajnB5jnpkhPmdHrMhXo8n1KXE/Rwr40H53QHIYlPvM3d3KsB2wCbYKlL8YB8kYXIpOJnnADEhsmks0A9BtLTuNRzELSBGtxWsqfbmccAkCiyr6Od7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lBT+R3TA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KfvDvQNc; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730100620;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nZ/l/c6ufR94MIa+BdGeKTbIPK6yIIjnD9cOoHksrCA=;
	b=lBT+R3TA+OP024ytCfdyoLsZM+s8SyLaj683d6z1KzOxOLDVpQt3RcwEssOQ6HcXNFjymK
	z0Yg0auRXIPocUkHObKRO0gqsrk48LD8DjYw2MsFX6KZvEog2nUurn6Jo5egyteQfTDmOZ
	WQZ7rkyhvsVZl2+nsbNDfV0euuwunKoa3nYK9q+OINvs9K88lSaTgHW/OjQySy6OviPZdV
	uXqTFs4/1TmHNardWtLzhcgxnSMHGMr9aNAUmqlsLLAFvUUvkOmtB5ZCBYsXhVX+rGZR7k
	axEnRvOmZAgBHbKIg5KXZVhgWE/seNQxDGYkRAR5JYUsRPQhtJBDPWX/V7JaNg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730100620;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nZ/l/c6ufR94MIa+BdGeKTbIPK6yIIjnD9cOoHksrCA=;
	b=KfvDvQNcsZc43Rs3BUNLWq2DboVx7NpfOCaJQjFH/EH+ETYIVuzdJcb3id5GQVsNeSVtK3
	e9Czm5aY8+2GV1CQ==
To: Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>
Subject: [PATCH 02/21] hrtimers: Remove unused hrtimer_init_sleeper()
Date: Mon, 28 Oct 2024 08:29:21 +0100
Message-Id: <eee6763f12d340848fc30a090acaa2b3c965541a.1729864615.git.namcao@linutronix.de>
In-Reply-To: <cover.1729864615.git.namcao@linutronix.de>
References: <cover.1729864615.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

hrtimer_init_sleeper() is not used. Delete it.

Signed-off-by: Nam Cao <namcao@linutronix.de>
---
 include/linux/hrtimer.h |  2 --
 kernel/time/hrtimer.c   | 17 +----------------
 2 files changed, 1 insertion(+), 18 deletions(-)

diff --git a/include/linux/hrtimer.h b/include/linux/hrtimer.h
index 814d489cb7a2..5aa9d57528c4 100644
--- a/include/linux/hrtimer.h
+++ b/include/linux/hrtimer.h
@@ -228,8 +228,6 @@ static inline void hrtimer_cancel_wait_running(struct h=
rtimer *timer)
 /* Initialize timers: */
 extern void hrtimer_init(struct hrtimer *timer, clockid_t which_clock,
 			 enum hrtimer_mode mode);
-extern void hrtimer_init_sleeper(struct hrtimer_sleeper *sl, clockid_t clo=
ck_id,
-				 enum hrtimer_mode mode);
 extern void hrtimer_init_on_stack(struct hrtimer *timer, clockid_t which_c=
lock,
 				  enum hrtimer_mode mode);
 extern void hrtimer_init_sleeper_on_stack(struct hrtimer_sleeper *sl,
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 533769777ba4..4b0507cf38ea 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1952,7 +1952,7 @@ void hrtimer_sleeper_start_expires(struct hrtimer_sle=
eper *sl,
 	 * Make the enqueue delivery mode check work on RT. If the sleeper
 	 * was initialized for hard interrupt delivery, force the mode bit.
 	 * This is a special case for hrtimer_sleepers because
-	 * hrtimer_init_sleeper() determines the delivery mode on RT so the
+	 * __hrtimer_init_sleeper() determines the delivery mode on RT so the
 	 * fiddling with this decision is avoided at the call sites.
 	 */
 	if (IS_ENABLED(CONFIG_PREEMPT_RT) && sl->timer.is_hard)
@@ -1994,21 +1994,6 @@ static void __hrtimer_init_sleeper(struct hrtimer_sl=
eeper *sl,
 	sl->task =3D current;
 }
=20
-/**
- * hrtimer_init_sleeper - initialize sleeper to the given clock
- * @sl:		sleeper to be initialized
- * @clock_id:	the clock to be used
- * @mode:	timer mode abs/rel
- */
-void hrtimer_init_sleeper(struct hrtimer_sleeper *sl, clockid_t clock_id,
-			  enum hrtimer_mode mode)
-{
-	debug_init(&sl->timer, clock_id, mode);
-	__hrtimer_init_sleeper(sl, clock_id, mode);
-
-}
-EXPORT_SYMBOL_GPL(hrtimer_init_sleeper);
-
 /**
  * hrtimer_init_sleeper_on_stack - initialize a sleeper in stack memory
  * @sl:		sleeper to be initialized
--=20
2.39.5


