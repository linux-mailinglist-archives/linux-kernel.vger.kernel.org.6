Return-Path: <linux-kernel+bounces-390749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EA629B7E1F
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 16:17:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0991B22B08
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 15:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3023C1C3317;
	Thu, 31 Oct 2024 15:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XzQpNSwf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ha0W0r5L"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC5D01B5EB0
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 15:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730387711; cv=none; b=Tp/gpNDJJZrBdAyOv+lTRrwPZ/MERSIa0S6CGdcjVvvQO+BYiiUrZdxv3fpga68lr28biDeJehYBWAkXenjAUfl0lJajAFoIXbrfJjb71nlyhqE5QAVaTNjPauNc47ud2qQcCt1M4l86vDfceY9g9n/punXwkRevLX/ZvtaNdNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730387711; c=relaxed/simple;
	bh=2CY9kB6H7L5xJ90m7m3826zJ8H+R219yYNnhQ1D6tRE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WZitFXf+7Axx7MDYR172bootK7Y2eX63FWXa+OPYRmUqVCNV8R6TpsI3+gVBzKa83zSUYsrABJaw6OVFzTMNb74+gZjDwAqI8ZN9iWB5g75GAbac5PC7n7fIduZomoM+8MAFlGrEDuAOtiAUrFO6jokgq6JKxqqFIO2Dy/p+DR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XzQpNSwf; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ha0W0r5L; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730387705;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C2pgxdetyjFdGMAYQNmqquyKM9VvR5M1ScNctRcZor8=;
	b=XzQpNSwfS1KsUnzEEkGG3Iuey3l2dvDrRTyFBryik4D+t5RyKO+mb7tTLZD9ZRyilKUuWf
	jte3J1gze9W005BG2id+JasCiuOVN8Gm+pdNRzFCmKRwauq5toaCjAhMhKnl+3n3H3mAW6
	B6z6pd2Wo7aowmA7Fp7MnlAWij/z+Bm4httKMDT8QyMAgnh75B79HutAhcZPrm6uwCxeFN
	ynxeD/HDho8RIxt6s1+BJeHMiOsQ0NMv7f9XzKzWcd6L8BXy1AF5HJVyHvC2tk06QQhjz5
	F9svaQyXwwsC4J8fSNKrEUJ47wCZJnhPLuJm2ATe3DyJhfEuXpAnGwABAKV6lg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730387705;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C2pgxdetyjFdGMAYQNmqquyKM9VvR5M1ScNctRcZor8=;
	b=Ha0W0r5LMuvam3gSiw/Jbi7TY8QZoepcS+hye4MMw0ADw2CbjE4LANY+DtNBmeXri8s1yd
	8C8tjupm9PhrieAQ==
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
Subject: [RESEND PATCH v2 08/19] hrtimers: Introduce hrtimer_setup_sleeper_on_stack()
Date: Thu, 31 Oct 2024 16:14:22 +0100
Message-Id: <7b5e18e6dd0ace9eaa211201528cb9dc23752454.1730386209.git.namcao@linutronix.de>
In-Reply-To: <cover.1730386209.git.namcao@linutronix.de>
References: <cover.1730386209.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The hrtimer_init*() API is replaced by hrtimer_setup*() variants to
initialize the timer including the callback function at once.

hrtimer_init_sleeper_on_stack() does not need user to setup the callback
function separately, so a new variant would not be strictly necessary.

Nonetheless, to keep the naming convention consistent, introduce
hrtimer_setup_sleeper_on_stack(). hrtimer_init_on_stack() will be removed
once all users are converted.

Signed-off-by: Nam Cao <namcao@linutronix.de>
---
 include/linux/hrtimer.h |  2 ++
 kernel/time/hrtimer.c   | 14 ++++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/include/linux/hrtimer.h b/include/linux/hrtimer.h
index 2da513f8d66a..48872a2b4071 100644
--- a/include/linux/hrtimer.h
+++ b/include/linux/hrtimer.h
@@ -238,6 +238,8 @@ extern void hrtimer_setup_on_stack(struct hrtimer *time=
r,
 extern void hrtimer_init_sleeper_on_stack(struct hrtimer_sleeper *sl,
 					  clockid_t clock_id,
 					  enum hrtimer_mode mode);
+extern void hrtimer_setup_sleeper_on_stack(struct hrtimer_sleeper *sl, clo=
ckid_t clock_id,
+					   enum hrtimer_mode mode);
=20
 #ifdef CONFIG_DEBUG_OBJECTS_TIMERS
 extern void destroy_hrtimer_on_stack(struct hrtimer *timer);
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index daee4e27f839..1d1f5c03673c 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -2065,6 +2065,20 @@ void hrtimer_init_sleeper_on_stack(struct hrtimer_sl=
eeper *sl,
 }
 EXPORT_SYMBOL_GPL(hrtimer_init_sleeper_on_stack);
=20
+/**
+ * hrtimer_setup_sleeper_on_stack - initialize a sleeper in stack memory
+ * @sl:		sleeper to be initialized
+ * @clock_id:	the clock to be used
+ * @mode:	timer mode abs/rel
+ */
+void hrtimer_setup_sleeper_on_stack(struct hrtimer_sleeper *sl,
+				    clockid_t clock_id, enum hrtimer_mode mode)
+{
+	debug_init_on_stack(&sl->timer, clock_id, mode);
+	__hrtimer_init_sleeper(sl, clock_id, mode);
+}
+EXPORT_SYMBOL_GPL(hrtimer_setup_sleeper_on_stack);
+
 int nanosleep_copyout(struct restart_block *restart, struct timespec64 *ts)
 {
 	switch(restart->nanosleep.type) {
--=20
2.39.5


