Return-Path: <linux-kernel+bounces-384257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E8CE9B28D1
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 08:34:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2ADCE280C35
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 07:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23D5A1D6199;
	Mon, 28 Oct 2024 07:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BTAZh58o";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NFMJLsXa"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBBAF1CC898
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 07:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730100639; cv=none; b=IyGjScka+KLynBu9Y3SvChbipEbPA7J/Y4c20gl59byjiPoNZi0v+R5aYAltMaq5VLtohwHAKuoZfKTI8DVd1gWqSbE96HPbRJyW7L0Tbug7vf1hrCB4QqE69gSG1Y/KRU6mTWsA9RHkeyDiHJ9IqkdNR3ZjIktIEAgfIDrhp5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730100639; c=relaxed/simple;
	bh=vawBPjVjhC0BJHmpKjEoR5oITpYLJoZAJKw1eVRUNq4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QBD5O5KcPlc9M0++AdAxw2hacRjsVWqwdlKjaGHV93Br/IJ2i+Sz4wDKHxiUAwO+BZtOPPgF6Ek9FXVxC0r7/xdMhbGdaHhTtVyJPsDugBdyChZ6Hg3gxI8mnVv2LearWEwtySiCIUz1DfLNG8HGf9zlezm3O/8tZ7qgnjN9L1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BTAZh58o; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NFMJLsXa; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730100634;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JirWdjsOsU2DPbQ75KQaxuXB0VuPgzxLe9NrnZll6S8=;
	b=BTAZh58oxeELGCFgaW9sQpUjPwJNE1QfW2x60jp4/gbIMx9bznd1NdF5Ui97hyVJHIcwlk
	LLz1fleUu7qtOy8CIf9ND6+dtB3+MpFuW+hR77+sj/1AMOjvf0F+/bNRasVk4WrCoyGUqo
	VRMfexN2hkTFrkUc3Qc73CrvFSE+hcaeM8tdTfL3h3bHTmBhTuf2Ff7A0DcbdyStwHG1N1
	6OaD83Uui5ur9Ikzv1AJYBSGViPDkPF/8xZHczIPlSJzHuWnIs63yu1MDxpYJo5Vqlwu+5
	8WpQACCc5vKS5eL7H1b9DDTUXilJsOnN5OlvePBO7X2/e32eQwOHEF4Pkql/vA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730100634;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JirWdjsOsU2DPbQ75KQaxuXB0VuPgzxLe9NrnZll6S8=;
	b=NFMJLsXaouzTwhFdYyemXZjbqIXPEcd/BeeDGYe1cL57j3ENzuhS/9mGaq+qz//l9xk2gJ
	qHa80fEZE001wSCg==
To: Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>
Subject: [PATCH 17/21] hrtimers: Delete hrtimer_init_sleeper_on_stack()
Date: Mon, 28 Oct 2024 08:29:36 +0100
Message-Id: <d47d9482e56ca8f160cac3cd75e4fc23a1cc4c53.1729864615.git.namcao@linutronix.de>
In-Reply-To: <cover.1729864615.git.namcao@linutronix.de>
References: <cover.1729864615.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

hrtimer_init_sleeper_on_stack() is unused. Delete it.

Signed-off-by: Nam Cao <namcao@linutronix.de>
---
 include/linux/hrtimer.h |  3 ---
 kernel/time/hrtimer.c   | 14 --------------
 2 files changed, 17 deletions(-)

diff --git a/include/linux/hrtimer.h b/include/linux/hrtimer.h
index 6e026730e803..4e4f04b3c0c2 100644
--- a/include/linux/hrtimer.h
+++ b/include/linux/hrtimer.h
@@ -235,9 +235,6 @@ extern void hrtimer_init_on_stack(struct hrtimer *timer=
, clockid_t which_clock,
 extern void hrtimer_setup_on_stack(struct hrtimer *timer,
 				   enum hrtimer_restart (*function)(struct hrtimer *),
 				   clockid_t clock_id, enum hrtimer_mode mode);
-extern void hrtimer_init_sleeper_on_stack(struct hrtimer_sleeper *sl,
-					  clockid_t clock_id,
-					  enum hrtimer_mode mode);
 extern void hrtimer_setup_sleeper_on_stack(struct hrtimer_sleeper *sl, clo=
ckid_t clock_id,
 					   enum hrtimer_mode mode);
=20
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 69430467a17d..376b8182b72e 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -2051,20 +2051,6 @@ static void __hrtimer_init_sleeper(struct hrtimer_sl=
eeper *sl,
 	sl->task =3D current;
 }
=20
-/**
- * hrtimer_init_sleeper_on_stack - initialize a sleeper in stack memory
- * @sl:		sleeper to be initialized
- * @clock_id:	the clock to be used
- * @mode:	timer mode abs/rel
- */
-void hrtimer_init_sleeper_on_stack(struct hrtimer_sleeper *sl,
-				   clockid_t clock_id, enum hrtimer_mode mode)
-{
-	debug_init_on_stack(&sl->timer, clock_id, mode);
-	__hrtimer_init_sleeper(sl, clock_id, mode);
-}
-EXPORT_SYMBOL_GPL(hrtimer_init_sleeper_on_stack);
-
 /**
  * hrtimer_setup_sleeper_on_stack - initialize a sleeper in stack memory
  * @sl:		sleeper to be initialized
--=20
2.39.5


