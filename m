Return-Path: <linux-kernel+bounces-384381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8A639B2963
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 08:58:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A80EF282BF0
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 07:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37FEF2071EC;
	Mon, 28 Oct 2024 07:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VSLg3EbU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4t3uLEXo"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B973C20607F
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 07:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730100972; cv=none; b=kvZTKBicrnVcnWyx/N1XvRERK5EK44uDH9EqYGgPiLvByeXLztroLQK/nwSpYBU4aWUwLv6XbWFgDCilyQ/GxtmTjrDQ5wDfP5Se9ATYbJJiRH6KTrIHelzsb0Ir9t3wBUek6ZKcHV2LaWNO/AMIPvJhwFl6npSeJXKeszDvUEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730100972; c=relaxed/simple;
	bh=qgjhrQFGyujCPiQZ0OXqoKSFTsi7AT39xDf2eeX+7Ok=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ntVNVXUVZ8cYKVyuSXUcixixi4KHTeXJqbKSNGMPtfTKx7mhCzqsAnv7JeWpE5bPYl6N703mzVIXYDFtRmoQUrssKG8Dzt4JXo6ruaThOpT0Hg+REOKlbNW+q51O7Q7YaoxKslPlmZS3dbGnDMliUY2ObPXaDx7Nhkn/HN+Jhlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VSLg3EbU; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4t3uLEXo; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730100967;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kOhHjfDyZHiacjP/QNpCtVG3O7BwOGaKuYJ+lfkMK/8=;
	b=VSLg3EbUDiCfAIX6+s4IjRlGrYbGK4OGSq2v7xUbVapV+E3YdZ+uXudvqcDxaxJLzQwTYQ
	NObRMBpbZpQRcNyWmvZ758fjzTbohH71K08FKxB0rvjkfkugpHiKQUoibpw44dLVE9ivYP
	5/a6FnKb/bVJpImkBLPRSckSNyxVLIyQxYIg0kHWqX1/zQV2gcalf0HO7pTw4Sn7hUrQ7v
	uu/Uu2MXDKYfgSQdygauknsfz0rOv4jsli6YC0kblGbS3wU4WWzfiM0+W1q8yXDyQmhALT
	MVMobrLebZCSo7TwAGwKeLL5+h783il2nJ+lQ0G4CLmJlRj/w+PW9iBKnQ1ODA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730100967;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kOhHjfDyZHiacjP/QNpCtVG3O7BwOGaKuYJ+lfkMK/8=;
	b=4t3uLEXor7FG+a8TOFhf1O6BfCRnysO9EKJ0w5U18Y+5/tzu0sA9XPOwRB1liRHlUNDt0x
	jYY7/TWwHg5i0yCA==
To: Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH 07/12] hrtimers: Make callback function pointer private
Date: Mon, 28 Oct 2024 08:35:51 +0100
Message-Id: <e82b7bc0c04158652a6bc63bd4dd131d00b488a6.1729865740.git.namcao@linutronix.de>
In-Reply-To: <cover.1729865740.git.namcao@linutronix.de>
References: <cover.1729865740.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Make the field 'function' of struct hrtimer private, to prevent users from
changing this field in an unsafe way. hrtimer_update_function() should be
used if the callback function needs to be changed.

Signed-off-by: Nam Cao <namcao@linutronix.de>
---
Cc: Steven Rostedt <rostedt@goodmis.org>
---
 include/linux/hrtimer.h       | 2 +-
 include/linux/hrtimer_types.h | 2 +-
 include/trace/events/timer.h  | 4 ++--
 kernel/time/hrtimer.c         | 8 ++++----
 kernel/time/timer_list.c      | 2 +-
 5 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/include/linux/hrtimer.h b/include/linux/hrtimer.h
index 47103a0f6691..38983c2e1dd4 100644
--- a/include/linux/hrtimer.h
+++ b/include/linux/hrtimer.h
@@ -339,7 +339,7 @@ static inline void hrtimer_update_function(struct hrtim=
er *timer,
 	if (WARN_ON_ONCE(!function))
 		return;
=20
-	timer->function =3D function;
+	ACCESS_PRIVATE(timer, function) =3D function;
 }
=20
 /* Forward a hrtimer so it expires after now: */
diff --git a/include/linux/hrtimer_types.h b/include/linux/hrtimer_types.h
index 7c5b27daa89d..8fbbb6bdf7a1 100644
--- a/include/linux/hrtimer_types.h
+++ b/include/linux/hrtimer_types.h
@@ -39,7 +39,7 @@ enum hrtimer_restart {
 struct hrtimer {
 	struct timerqueue_node		node;
 	ktime_t				_softexpires;
-	enum hrtimer_restart		(*function)(struct hrtimer *);
+	enum hrtimer_restart		(*__private function)(struct hrtimer *);
 	struct hrtimer_clock_base	*base;
 	u8				state;
 	u8				is_rel;
diff --git a/include/trace/events/timer.h b/include/trace/events/timer.h
index 1ef58a04fc57..f8c906be4cd0 100644
--- a/include/trace/events/timer.h
+++ b/include/trace/events/timer.h
@@ -235,7 +235,7 @@ TRACE_EVENT(hrtimer_start,
=20
 	TP_fast_assign(
 		__entry->hrtimer	=3D hrtimer;
-		__entry->function	=3D hrtimer->function;
+		__entry->function	=3D ACCESS_PRIVATE(hrtimer, function);
 		__entry->expires	=3D hrtimer_get_expires(hrtimer);
 		__entry->softexpires	=3D hrtimer_get_softexpires(hrtimer);
 		__entry->mode		=3D mode;
@@ -271,7 +271,7 @@ TRACE_EVENT(hrtimer_expire_entry,
 	TP_fast_assign(
 		__entry->hrtimer	=3D hrtimer;
 		__entry->now		=3D *now;
-		__entry->function	=3D hrtimer->function;
+		__entry->function	=3D ACCESS_PRIVATE(hrtimer, function);
 	),
=20
 	TP_printk("hrtimer=3D%p function=3D%ps now=3D%llu",
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index cf362d93a323..d11697492bdb 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1276,7 +1276,7 @@ void hrtimer_start_range_ns(struct hrtimer *timer, kt=
ime_t tim,
 	struct hrtimer_clock_base *base;
 	unsigned long flags;
=20
-	if (WARN_ON_ONCE(!timer->function))
+	if (WARN_ON_ONCE(!ACCESS_PRIVATE(timer, function)))
 		return;
 	/*
 	 * Check whether the HRTIMER_MODE_SOFT bit and hrtimer.is_soft
@@ -1577,9 +1577,9 @@ static void __hrtimer_setup(struct hrtimer *timer,
 	timerqueue_init(&timer->node);
=20
 	if (WARN_ON_ONCE(!function))
-		timer->function =3D hrtimer_dummy_timeout;
+		ACCESS_PRIVATE(timer, function) =3D hrtimer_dummy_timeout;
 	else
-		timer->function =3D function;
+		ACCESS_PRIVATE(timer, function) =3D function;
 }
=20
 /**
@@ -1691,7 +1691,7 @@ static void __run_hrtimer(struct hrtimer_cpu_base *cp=
u_base,
 	raw_write_seqcount_barrier(&base->seq);
=20
 	__remove_hrtimer(timer, base, HRTIMER_STATE_INACTIVE, 0);
-	fn =3D timer->function;
+	fn =3D ACCESS_PRIVATE(timer, function);
=20
 	/*
 	 * Clear the 'is relative' flag for the TIME_LOW_RES case. If the
diff --git a/kernel/time/timer_list.c b/kernel/time/timer_list.c
index 1c311c46da50..958dd4194684 100644
--- a/kernel/time/timer_list.c
+++ b/kernel/time/timer_list.c
@@ -46,7 +46,7 @@ static void
 print_timer(struct seq_file *m, struct hrtimer *taddr, struct hrtimer *tim=
er,
 	    int idx, u64 now)
 {
-	SEQ_printf(m, " #%d: <%pK>, %ps", idx, taddr, timer->function);
+	SEQ_printf(m, " #%d: <%pK>, %ps", idx, taddr, ACCESS_PRIVATE(timer, funct=
ion));
 	SEQ_printf(m, ", S:%02x", timer->state);
 	SEQ_printf(m, "\n");
 	SEQ_printf(m, " # expires at %Lu-%Lu nsecs [in %Ld to %Ld nsecs]\n",
--=20
2.39.5


