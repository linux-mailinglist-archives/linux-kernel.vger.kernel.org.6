Return-Path: <linux-kernel+bounces-226908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ABEED91458D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 10:58:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6190A285773
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 08:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CB651304B0;
	Mon, 24 Jun 2024 08:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QiDNyL3W";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Nh7+hyf0"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F71412E1D1
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 08:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719219510; cv=none; b=KV5ExxeOcqBlavQt38GUpt49uLO7RB+Z9OWqcWcSmh4gLTz9JH+XvFbU9IIaimLxHpl36293nKfzWAf/ywvi+ZvI8hXEbOjyYHZlWs36302ZD8odkr8DeZZSJ9ErXiVzVVr23aRzcyq/Ci9T7MGTGLiEqSu86XKHLDnbetkhgCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719219510; c=relaxed/simple;
	bh=KLlbfw0gZgGUHMKq2SqKVutSjW8x+XA7iioeGFNgOAI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GWSSuQmthiDliZelA8GO+wnDhHcMemswSmJe77ZcmOdnnX7HO92MRHkOe1iNDKaBMeeY4IOZETdY75L69ksjENW9kvOrdcLxK7f4zCu44U+4fD9pYKAPOOXBYcNXA2Ic/SHjG3cBqmGVyP0NlWmcVSE8tmQ+Vwmto4ru19w3SnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QiDNyL3W; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Nh7+hyf0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719219506;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZlBkmccLp9D27RGSKMxounU0J8b/aSUDm3j0Eg001K4=;
	b=QiDNyL3WwOQA3ThSUhGz4SUCQ2fLukrCd+hjKaUKgqfoTAnyu6uJWJK49yqMSasZQo4FWE
	UaKTDAWKrDeQrK7EaLL86QD6sGd/2KzGqh1lDYr8fVy8PvMmu3WKxZ2dGVSdXfqUF5N0AW
	ek9R9h8Li2W3iXhBSxZDCKi4aEIa/9PCSf7ZWJYLoZDP4umTsGV0Jlby8uVFRGdqADC6MQ
	ytix0yJREEfIAQahaJdvbpMSAtr1pthfsuMgxbuYAGDR2qrSTVt1jRgS168fspHk4475dB
	NshMRhNzzU4OuC5pPSvhzUjSzQTgqe8rgj+a44ZiXG1D+NGE90EzTQIX5AVlEg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719219506;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZlBkmccLp9D27RGSKMxounU0J8b/aSUDm3j0Eg001K4=;
	b=Nh7+hyf01Si3GRtcCaXQWbvo7xAMWZ1YSGWz6tteETCfJs2izDse+xexkStSDqm2oBP5NO
	o00FTxyXur39aRBQ==
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
 Borislav Petkov <bp@alien8.de>, Narasimhan V <Narasimhan.V@amd.com>
Subject: Re: [PATCH 0/3] timer_migration: Fix a possible race and improvements
In-Reply-To: <ZnWOswTMML6ShzYO@localhost.localdomain>
References: <20240621-tmigr-fixes-v1-0-8c8a2d8e8d77@linutronix.de>
 <ZnWOswTMML6ShzYO@localhost.localdomain>
Date: Mon, 24 Jun 2024 10:58:26 +0200
Message-ID: <87zfrag1jh.fsf@somnus>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Frederic Weisbecker <frederic@kernel.org> writes:

> Le Fri, Jun 21, 2024 at 11:37:05AM +0200, Anna-Maria Behnsen a =C3=A9crit=
 :
>> Borislav reported a warning in timer migration deactive path
>>=20
>>   https://lore.kernel.org/r/20240612090347.GBZmlkc5PwlVpOG6vT@fat_crate.=
local
>>=20
>> Sadly it doesn't reproduce directly. But with the change of timing (by
>> adding a trace prinkt before the warning), it is possible to trigger the
>> warning reliable at least in my test setup. The problem here is a racy
>> check agains group->parent pointer. This is also used in other places in
>> the code and fixing this racy usage is adressed by the first patch.
>>=20
>> While working with the code, I saw two things which could be improved
>> (tracing and update of per cpu group wakeup value). This improvements are
>> adressed by the other two patches.
>>=20
>> Patches are available here:
>>=20
>>   https://git.kernel.org/pub/scm/linux/kernel/git/anna-maria/linux-devel=
.git timers/misc
>>=20
>> Cc: Frederic Weisbecker <frederic@kernel.org>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: linux-kernel@vger.kernel.org
>>=20
>> Thanks,
>>=20
>> Anna-Maria
>>=20
>> ---
>
> This made me stare at the group creation again and I might have found
> something. Does the following race look plausible to you?

Yes...

>
>                   [GRP0:0]
>                migrator =3D 0
>                active   =3D 0
>                nextevt  =3D KTIME_MAX
>                /         \
>               0         1 .. 7
>           active         idle
>
> 0) Hierarchy has only 8 CPUs (single node for now with only CPU 0
>    as active.
>
>=20=20=20=20
>                              [GRP1:0]
>                         migrator =3D TMIGR_NONE
>                         active   =3D NONE
>                         nextevt  =3D KTIME_MAX
>                                          \
>                  [GRP0:0]                  [GRP0:1]
>               migrator =3D 0              migrator =3D TMIGR_NONE
>               active   =3D 0              active   =3D NONE
>               nextevt  =3D KTIME_MAX      nextevt  =3D KTIME_MAX
>                 /         \                    |
>               0          1 .. 7                8
>           active         idle                !online
>
> 1) CPU 8 is booting and creates a new node and a new top. For now it's
>    only connected to GRP0:1, not yet to GRP0:0. Also CPU 8 hasn't called
>    __tmigr_cpu_activate() on itself yet.

NIT: In step 1) CPU8 is not yet connected to GRP0:1 as the second while
loop is not yet finished, but nevertheless...

>
>                              [GRP1:0]
>                         migrator =3D TMIGR_NONE
>                         active   =3D NONE
>                         nextevt  =3D KTIME_MAX
>                        /                  \
>                  [GRP0:0]                  [GRP0:1]
>               migrator =3D 0              migrator =3D TMIGR_NONE
>               active   =3D 0              active   =3D NONE
>               nextevt  =3D KTIME_MAX      nextevt  =3D KTIME_MAX
>                 /         \                    |
>               0          1 .. 7                8
>           active         idle                active
>
> 2) CPU 8 connects GRP0:0 to GRP1:0 and observes while in
>    tmigr_connect_child_parent() that GRP0:0 is not TMIGR_NONE. So it
>    prepares to call tmigr_active_up() on it. It hasn't done it yet.

NIT: CPU8 keeps its state !online until step 5.

>
>
>                              [GRP1:0]
>                         migrator =3D TMIGR_NONE
>                         active   =3D NONE
>                         nextevt  =3D KTIME_MAX
>                        /                  \
>                  [GRP0:0]                  [GRP0:1]
>               migrator =3D TMIGR_NONE        migrator =3D TMIGR_NONE
>               active   =3D NONE              active   =3D NONE
>               nextevt  =3D KTIME_MAX         nextevt  =3D KTIME_MAX
>                 /         \                    |
>               0          1 .. 7                8
>             idle         idle                active
>
> 3) CPU 0 goes idle. Since GRP0:0->parent has been updated by CPU 8 with
>    GRP0:0->lock held, CPU 0 observes GRP1:0 after calling tmigr_update_ev=
ents()
>    and it propagates the change to the top (no change there and no wakeup
>    programmed since there is no timer).
>
>
>                              [GRP1:0]
>                         migrator =3D GRP0:0
>                         active   =3D GRP0:0
>                         nextevt  =3D KTIME_MAX
>                        /                  \
>                  [GRP0:0]                  [GRP0:1]
>               migrator =3D TMIGR_NONE       migrator =3D TMIGR_NONE
>               active   =3D NONE             active   =3D NONE
>               nextevt  =3D KTIME_MAX        nextevt  =3D KTIME_MAX
>                 /         \                    |
>               0          1 .. 7                8
>             idle         idle                active
>
> 4) Now CPU 8 finally calls tmigr_active_up() to GRP0:0

... oh no. Here it starts to go mad. Good catch!

>
>                              [GRP1:0]
>                         migrator =3D GRP0:0
>                         active   =3D GRP0:0, GRP0:1
>                         nextevt  =3D KTIME_MAX
>                        /                  \
>                  [GRP0:0]                  [GRP0:1]
>               migrator =3D TMIGR_NONE       migrator =3D 8
>               active   =3D NONE             active   =3D 8
>               nextevt  =3D KTIME_MAX        nextevt  =3D KTIME_MAX
>                 /         \                    |
>               0          1 .. 7                8
>             idle         idle                active
>
> 5) And out of tmigr_cpu_online() CPU 8 calls tmigr_active_up() on itself
>
>                              [GRP1:0]
>                         migrator =3D GRP0:0
>                         active   =3D GRP0:0
>                         nextevt  =3D T8
>                        /                  \
>                  [GRP0:0]                  [GRP0:1]
>               migrator =3D TMIGR_NONE         migrator =3D TMIGR_NONE
>               active   =3D NONE               active   =3D NONE
>               nextevt  =3D KTIME_MAX          nextevt  =3D T8
>                 /         \                    |
>               0          1 .. 7                8
>             idle         idle                  idle
>
> 5) CPU 8 goes idle with a timer T8 and relies on GRP0:0 as the migrator.
>    But it's not really active, so T8 gets ignored.
>
>
> And if that race looks plausible, does the following fix look good?

Holding the lock will not help as the state is not protected by the
lock. Step 4) would nevertheless happen. To properly fix this, we need a
memory barrier. I added a comment back then in tmigr_active_up() why the
barrier is not required there but without having this corner case in
mind. Or am I wrong?

To solve it, we could

a) add a memory barrier also in tmigr_active_up() and read the
   childstate there always (similar to tmigr_inactive_up()).

b) create a separate tmigr_setup_active_up() function with this memory
   barrier and with reading the childstate there after the memory
   barrier.

I would propose to go with b) to do not impact active_up().

I dropped the walk_hierarchy information for tmigr_setup_active_up() and
also do not set the group event ignore bit. This shouldn't be required,
as this active update could only happen between the new top level and
the formerly top level group. And the event ignore bit on the top level
isn't taken into account.

This is not tested yet, but it could look like the following. When it
makes sense to you and if I didn't miss something else - I would start
testing and functionality verification ;)

---8<----
--- a/kernel/time/timer_migration.c
+++ b/kernel/time/timer_migration.c
@@ -623,12 +623,37 @@ static u64 tmigr_next_groupevt_expires(s
 		return evt->nextevt.expires;
 }
=20
+static bool __tmigr_active_up(struct tmigr_group *group, bool *walk_done, =
union tmigr_state *curstate, u8 childmask)
+{
+	union tmigr_state newstate;
+
+	newstate =3D *curstate;
+	*walk_done =3D true;
+
+	if (newstate.migrator =3D=3D TMIGR_NONE) {
+		newstate.migrator =3D childmask;
+
+		/* Changes need to be propagated */
+		*walk_done =3D false;
+	}
+
+	newstate.active |=3D childmask;
+	newstate.seq++;
+
+	if (atomic_try_cmpxchg(&group->migr_state, &curstate->state, newstate.sta=
te)) {
+		trace_tmigr_group_set_cpu_active(group, newstate, childmask);
+		return true;
+	}
+
+	return false;
+}
+
 static bool tmigr_active_up(struct tmigr_group *group,
 			    struct tmigr_group *child,
 			    void *ptr)
 {
-	union tmigr_state curstate, newstate;
 	struct tmigr_walk *data =3D ptr;
+	union tmigr_state curstate;
 	bool walk_done;
 	u8 childmask;
=20
@@ -640,23 +665,10 @@ static bool tmigr_active_up(struct tmigr
 	 */
 	curstate.state =3D atomic_read(&group->migr_state);
=20
-	do {
-		newstate =3D curstate;
-		walk_done =3D true;
-
-		if (newstate.migrator =3D=3D TMIGR_NONE) {
-			newstate.migrator =3D childmask;
-
-			/* Changes need to be propagated */
-			walk_done =3D false;
-		}
-
-		newstate.active |=3D childmask;
-		newstate.seq++;
-
-	} while (!atomic_try_cmpxchg(&group->migr_state, &curstate.state, newstat=
e.state));
-
-	trace_tmigr_group_set_cpu_active(group, newstate, childmask);
+	for(;;) {
+		if (__tmigr_active_up(group, &walk_done, &curstate, childmask))
+		    break;
+	}
=20
 	if (walk_done =3D=3D false)
 		data->childmask =3D group->childmask;
@@ -1436,6 +1448,35 @@ u64 tmigr_quick_check(u64 nextevt)
 	return KTIME_MAX;
 }
=20
+static void tmigr_setup_active_up(struct tmigr_group *group, struct tmigr_=
group *child)
+{
+	union tmigr_state curstate, childstate;
+	bool walk_done;
+
+	/*
+	 * FIXME: Memory barrier is required here as the child state
+	 * could have changed in the meantime
+	 */
+	curstate.state =3D atomic_read_acquire(&group->migr_state);
+
+	for (;;) {
+		childstate.state =3D atomic_read(&child->migr_state);
+		if (!childstate.active)
+			return;
+
+		if (__tmigr_active_up(group, &walk_done, &curstate, child->childmask))
+			break;
+
+		/*
+		 * The memory barrier is paired with the cmpxchg() in
+		 * tmigr_inactive_up() to make sure the updates of child and group
+		 * states are ordered. It is required only when the
+		 * try_cmpxchg() in __tmigr_active_up() fails.
+		 */
+		smp_mb__after_atomic();
+	}
+}
+
 static void tmigr_init_group(struct tmigr_group *group, unsigned int lvl,
 			     int node)
 {
@@ -1510,8 +1551,6 @@ static struct tmigr_group *tmigr_get_gro
 static void tmigr_connect_child_parent(struct tmigr_group *child,
 				       struct tmigr_group *parent)
 {
-	union tmigr_state childstate;
-
 	raw_spin_lock_irq(&child->lock);
 	raw_spin_lock_nested(&parent->lock, SINGLE_DEPTH_NESTING);
=20
@@ -1539,21 +1578,7 @@ static void tmigr_connect_child_parent(s
 	 *   executed with the formerly top level group (child) and the newly
 	 *   created group (parent).
 	 */
-	childstate.state =3D atomic_read(&child->migr_state);
-	if (childstate.migrator !=3D TMIGR_NONE) {
-		struct tmigr_walk data;
-
-		data.childmask =3D child->childmask;
-
-		/*
-		 * There is only one new level per time (which is protected by
-		 * tmigr_mutex). When connecting the child and the parent and
-		 * set the child active when the parent is inactive, the parent
-		 * needs to be the uppermost level. Otherwise there went
-		 * something wrong!
-		 */
-		WARN_ON(!tmigr_active_up(parent, child, &data) && parent->parent);
-	}
+	tmigr_setup_active_up(parent, child);
 }
=20
 static int tmigr_setup_groups(unsigned int cpu, unsigned int node)

