Return-Path: <linux-kernel+bounces-384301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AC45B9B290F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 08:44:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A2FDB21EC3
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 07:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AE291D2796;
	Mon, 28 Oct 2024 07:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uwlaA9IC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gjQGE+5i"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB561D0BBB
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 07:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730100888; cv=none; b=hVCakFUO9dL3wrF1vJxAFvh0FpkLh+pvGCTbzDX7jAl/mNITtMK3zNMKVs/ghrjM2gNCLQThyMDAWhOwrT0ScDXHqm3OlSM33voBVnZZXcEYNiX3YnKzXrte8B0H2zb1IclZOODVs+yM8BIk4IQzVbwjEv1XyobT4rgg7bk0fcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730100888; c=relaxed/simple;
	bh=P8riEIWm7ykAvuWcsOp75Ih1vHHOFlRsTiRII98oDtA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sjtEKHewdhCr6Rv5gPI+XekGTPU6Iw9KA5NsbLfcp6xJR4CI4jhRzPylDnlwemxaL57tggGp343WVhjgRjeqRPNGxATG0GMU2e014ntiRtPTZVzMIBsQ2XZtl1VsfwdHbDF7OoCI5UJ+4zFApwQ6rJpwvmvL9BBfgWddzO4vYHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uwlaA9IC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gjQGE+5i; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730100885;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ikpGWi0uGltmqWu7YqbXrObJlOk7RQGNuhV2+Ee9X/E=;
	b=uwlaA9IC2iTV+NbB1G5j7fdpIyCyylPvAG1FkarZKhC0bkU5jrzMEwNAyUhWteOdt2g/gr
	vZHh4FkQfVN0RqZZkZJB489a99I1DL+s+l+A5Z7SXdTw/vuMa8+nRRzJq0Fma4tzEUQvLV
	OdKtodlo/vHSCVoW2Tkl9VOSakRRtBBOpG8xr4fBwqJiYuTIwt0m8XSG38TBjtPln5fBZI
	8IaKU5LDxdBTGp6v054wNdKtrBmURw7GeEL6aYYA3Sjq6YvHbzhgbpR2Ldwn4LG+VrBGFX
	6ttbXIDrvlQBeuv25GjTmHmaJlyM7jtyUxwbqU5lcH5v8T37ZI9WOMlrigFLBg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730100885;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ikpGWi0uGltmqWu7YqbXrObJlOk7RQGNuhV2+Ee9X/E=;
	b=gjQGE+5indy1HwRNZ5Z2prR+8Gm/gZ8nkARFJthYqMTw42111Gy/U+3glx+pLXWqnf4RQ0
	jXQi7Gpf+58jcLDw==
To: Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 02/24] net/sched: Switch to use hrtimer_setup()
Date: Mon, 28 Oct 2024 08:34:15 +0100
Message-Id: <2c4743b934be6bf071a696446c296d6546f070e9.1729865232.git.namcao@linutronix.de>
In-Reply-To: <cover.1729865232.git.namcao@linutronix.de>
References: <cover.1729865232.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

There is a newly introduced hrtimer_setup() which will replace
hrtimer_init(). This new function is similar to the old one, except that it
also sanity-checks and initializes the timer's callback function.

Switch to use this new function.

Patch was created by using Coccinelle.

Signed-off-by: Nam Cao <namcao@linutronix.de>
---
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
---
 net/sched/act_gate.c   | 3 +--
 net/sched/sch_api.c    | 3 +--
 net/sched/sch_taprio.c | 6 ++----
 3 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/net/sched/act_gate.c b/net/sched/act_gate.c
index 1dd74125398a..ba4bdb71f1f3 100644
--- a/net/sched/act_gate.c
+++ b/net/sched/act_gate.c
@@ -292,8 +292,7 @@ static void gate_setup_timer(struct tcf_gate *gact, u64=
 basetime,
 	gact->param.tcfg_basetime =3D basetime;
 	gact->param.tcfg_clockid =3D clockid;
 	gact->tk_offset =3D tko;
-	hrtimer_init(&gact->hitimer, clockid, HRTIMER_MODE_ABS_SOFT);
-	gact->hitimer.function =3D gate_timer_func;
+	hrtimer_setup(&gact->hitimer, gate_timer_func, clockid, HRTIMER_MODE_ABS_=
SOFT);
 }
=20
 static int tcf_gate_init(struct net *net, struct nlattr *nla,
diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
index 74afc210527d..679d441e6074 100644
--- a/net/sched/sch_api.c
+++ b/net/sched/sch_api.c
@@ -620,8 +620,7 @@ static enum hrtimer_restart qdisc_watchdog(struct hrtim=
er *timer)
 void qdisc_watchdog_init_clockid(struct qdisc_watchdog *wd, struct Qdisc *=
qdisc,
 				 clockid_t clockid)
 {
-	hrtimer_init(&wd->timer, clockid, HRTIMER_MODE_ABS_PINNED);
-	wd->timer.function =3D qdisc_watchdog;
+	hrtimer_setup(&wd->timer, qdisc_watchdog, clockid, HRTIMER_MODE_ABS_PINNE=
D);
 	wd->qdisc =3D qdisc;
 }
 EXPORT_SYMBOL(qdisc_watchdog_init_clockid);
diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
index 8498d0606b24..9b8bc27e633d 100644
--- a/net/sched/sch_taprio.c
+++ b/net/sched/sch_taprio.c
@@ -1932,8 +1932,7 @@ static int taprio_change(struct Qdisc *sch, struct nl=
attr *opt,
 	if (!TXTIME_ASSIST_IS_ENABLED(q->flags) &&
 	    !FULL_OFFLOAD_IS_ENABLED(q->flags) &&
 	    !hrtimer_active(&q->advance_timer)) {
-		hrtimer_init(&q->advance_timer, q->clockid, HRTIMER_MODE_ABS);
-		q->advance_timer.function =3D advance_sched;
+		hrtimer_setup(&q->advance_timer, advance_sched, q->clockid, HRTIMER_MODE=
_ABS);
 	}
=20
 	err =3D taprio_get_start_time(sch, new_admin, &start);
@@ -2055,8 +2054,7 @@ static int taprio_init(struct Qdisc *sch, struct nlat=
tr *opt,
=20
 	spin_lock_init(&q->current_entry_lock);
=20
-	hrtimer_init(&q->advance_timer, CLOCK_TAI, HRTIMER_MODE_ABS);
-	q->advance_timer.function =3D advance_sched;
+	hrtimer_setup(&q->advance_timer, advance_sched, CLOCK_TAI, HRTIMER_MODE_A=
BS);
=20
 	q->root =3D sch;
=20
--=20
2.39.5


