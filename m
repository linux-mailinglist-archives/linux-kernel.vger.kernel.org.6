Return-Path: <linux-kernel+bounces-390757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E4429B7E27
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 16:19:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D794D1F222EE
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 15:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27C3D1CC8B3;
	Thu, 31 Oct 2024 15:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3oLfX19B";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dYr0dnRr"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 047DC1C9EC0
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 15:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730387716; cv=none; b=iHgLx8SPA29LD2hRfDkpkmOBpNDOab5qd2M7l1OSuWTUhC56bpKfARGCuHg+K81aXGUB2Zc5ihDu2lOlJsvQqo2/Dxc8TXWyci9zG6ml7b1+PfogXPmN1z+tXZrshw/y1E0ocKi1dPNlW0bvBqJG4um03BW4179S/iztgyAjrgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730387716; c=relaxed/simple;
	bh=dl9A3y/7DWwcSmaoC9X28xC0xRgkB4mTKJespZKBbGI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ihV5UgfMrjVLG7hXdyhHK2wuUmGZs61QUlZYRv9Pyy8wn4PeUM8Jq9+ll1XqNdVzz2HeKnTczeL1zuRfoEG8zd44fu4r7t2kDmjXp1JkeycNwPFYISLa77CQD8CLdvyyt9bb5OVZppwTbo6WLiHDrfH+p/DKD8+l6wgTGjDZzh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3oLfX19B; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dYr0dnRr; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730387712;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GU2XVazw0GjbHPIfXGHM1SlNEVDhVGkrGNW/ZVs0bq8=;
	b=3oLfX19B9bkmjYpuep2ukDT9RuM0sjRNPZ1LYWuFrCC22OqBkClmt3FGa1f0TmYHvs3Fzy
	Nt1TSZJJIf/FDLz9S8eYlidHGwP/eeBF87HrvPGmeC9giczGNZt2ER7L3fM8x3cLogaG4f
	mKdn5xQ3hkcuX7KJxwF5XCXrXPOB2Wh2Sv8I1GtVyWKK2a2iXmkEuHKpbOYYVrLqNNPkhl
	9XRR/YcmKfHqnMYFa56FS6bcRu6XOyhl6++OIktbbjNKSoOag8KL0mi3Ts/lVmoNjY5ZHl
	I21szVK1FUyr0b7W516opP0/Bv+rBINOlXzsRMN1MjTkKahKYZuePy2m41wsSA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730387712;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GU2XVazw0GjbHPIfXGHM1SlNEVDhVGkrGNW/ZVs0bq8=;
	b=dYr0dnRr4PeCWO2kuEc2e2LCz/omiE1Ka36qPy0pqIZZGqW9NhLdUPz8PRZuMEClwAngpf
	CDGJ1gl+OGraXyBQ==
To: Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: Jani Nikula <jani.nikula@linux.intel.com>,
	intel-gfx@lists.freedesktop.org,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	x86@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Kalle Valo <kvalo@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christian Brauner <brauner@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	John Stultz <jstultz@google.com>,
	Nam Cao <namcao@linutronix.de>,
	Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [RESEND PATCH v2 18/19] alarmtimer: Switch to use hrtimer_setup() and hrtimer_setup_on_stack()
Date: Thu, 31 Oct 2024 16:14:32 +0100
Message-Id: <2bae912336103405adcdab96b88d3ea0353b4228.1730386209.git.namcao@linutronix.de>
In-Reply-To: <cover.1730386209.git.namcao@linutronix.de>
References: <cover.1730386209.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

hrtimer_setup() and hrtimer_setup_on_stack() take the callback function
pointer as argument and initialize the timer completely.

Replace the hrtimer_init*() variants and the open coded initialization of
hrtimer::function with the new setup mechanism.

Switch to use the new functions.

Signed-off-by: Nam Cao <namcao@linutronix.de>
Cc: John Stultz <jstultz@google.com>
---
 kernel/time/alarmtimer.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/kernel/time/alarmtimer.c b/kernel/time/alarmtimer.c
index 452d8aa2f6e0..f581868e1b3e 100644
--- a/kernel/time/alarmtimer.c
+++ b/kernel/time/alarmtimer.c
@@ -337,7 +337,6 @@ __alarm_init(struct alarm *alarm, enum alarmtimer_type =
type,
 	     enum alarmtimer_restart (*function)(struct alarm *, ktime_t))
 {
 	timerqueue_init(&alarm->node);
-	alarm->timer.function =3D alarmtimer_fired;
 	alarm->function =3D function;
 	alarm->type =3D type;
 	alarm->state =3D ALARMTIMER_STATE_INACTIVE;
@@ -352,8 +351,8 @@ __alarm_init(struct alarm *alarm, enum alarmtimer_type =
type,
 void alarm_init(struct alarm *alarm, enum alarmtimer_type type,
 		enum alarmtimer_restart (*function)(struct alarm *, ktime_t))
 {
-	hrtimer_init(&alarm->timer, alarm_bases[type].base_clockid,
-		     HRTIMER_MODE_ABS);
+	hrtimer_setup(&alarm->timer, alarmtimer_fired, alarm_bases[type].base_clo=
ckid,
+		      HRTIMER_MODE_ABS);
 	__alarm_init(alarm, type, function);
 }
 EXPORT_SYMBOL_GPL(alarm_init);
@@ -816,8 +815,8 @@ static void
 alarm_init_on_stack(struct alarm *alarm, enum alarmtimer_type type,
 		    enum alarmtimer_restart (*function)(struct alarm *, ktime_t))
 {
-	hrtimer_init_on_stack(&alarm->timer, alarm_bases[type].base_clockid,
-			      HRTIMER_MODE_ABS);
+	hrtimer_setup_on_stack(&alarm->timer, alarmtimer_fired, alarm_bases[type]=
.base_clockid,
+			       HRTIMER_MODE_ABS);
 	__alarm_init(alarm, type, function);
 }
=20
--=20
2.39.5


