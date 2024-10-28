Return-Path: <linux-kernel+bounces-384261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C7CAE9B28D4
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 08:35:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56F34B210DA
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 07:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86F341D7E54;
	Mon, 28 Oct 2024 07:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wC1Marwv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="m8uCnzQ1"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B9DE1D2F6F
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 07:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730100640; cv=none; b=j5ybTJcgmh7QlwK2US2JakfHIy8mHBWB/jLWUyFOTJsLSa2KgLlGw6dXRft2txkLFaxKQjK6SlsCFn0IV6AYmbBppxX3yzYuFKxQf2psv+OP7tZzXbK5wMTZJfxLwPPjpGhHYARfZtl+obSl07P+g+VHFhQ0NjwAUySINZhR+KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730100640; c=relaxed/simple;
	bh=IW2dvXHtXHFDsIYV4XAPLaAUgKjPIL8JUW98j9mXX/k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=T7ZRioJPBQMtkTP3TttRpvUkp279602OPh2wxpVluFvGKxKIh5J0HE+pY4c6bWp4Q129QvaNRi1e7h+YYCqZJ/+L3BzGAoyh9IsqpK7PGDyiPLglIEgEvJlKInqQ1kTjQDC8XEzGImhyOQ+fUp/tXzzI52A5koZp76+pz2MYFCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wC1Marwv; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=m8uCnzQ1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730100636;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O1AA1NJRIJR372KlC5h6m7cnWrz+FjbPP6FjR2PwhQs=;
	b=wC1Marwv77zgarvjBkvBeUBVHTY/GukFTr3WzhTofkwFJvvzEY5YCtKoUs9JKqr8G0sEJR
	hT5eeETp3V7xZA1xpnLlYXi+vO/3NiyxdjntkGBxPtPitKHRJsBBhmmV3WEO+yJwa2qLQY
	gq/AkSx2qjTlNnJhWtmHgw2kvwZ1YyTbURRITHNMINRDOVLUKY4PPYFyEthFM++ZfsxXrh
	/qdocj5fAkYVNalQ/k8c6sAR9HM+BOfCIlGJjP5NusrCZtlDOJ1UKFyyYZ8up0mQVWuu3m
	JXuOZLbNrcvxAdU2mHWIMdIX9WBoYCxjzTuBNpn6ZCNUKDmJqvH8EB+aOoNLFA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730100636;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O1AA1NJRIJR372KlC5h6m7cnWrz+FjbPP6FjR2PwhQs=;
	b=m8uCnzQ1NOxL4EdtHQfBPKV70eK4jb0WGaH8KayYcq/Z6I+8xfJdR8ljrzQWKAo+g43GwP
	wFVqFOlnKTr6yRAg==
To: Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>,
	John Stultz <jstultz@google.com>
Subject: [PATCH 20/21] alarmtimer: Switch to use hrtimer_setup() and hrtimer_setup_on_stack()
Date: Mon, 28 Oct 2024 08:29:39 +0100
Message-Id: <0ac2e27f4bd4f5206d706f536387eeba908aa7a4.1729864615.git.namcao@linutronix.de>
In-Reply-To: <cover.1729864615.git.namcao@linutronix.de>
References: <cover.1729864615.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

There are two newly introduced hrtimer_setup() and hrtimer_setup_on_stack()
which will replace hrtimer_init() and hrtimer_init_on_stack().

The new functions are mostly similar, except that they also sanity-check
and initialize the timer's callback function.

Switch to use the new functions.

Signed-off-by: Nam Cao <namcao@linutronix.de>
---
Cc: John Stultz <jstultz@google.com>
---
 kernel/time/alarmtimer.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/kernel/time/alarmtimer.c b/kernel/time/alarmtimer.c
index 8bf888641694..3c70a3abd6a2 100644
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


