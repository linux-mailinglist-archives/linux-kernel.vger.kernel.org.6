Return-Path: <linux-kernel+bounces-384382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0AA19B2962
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 08:58:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFC031C2199D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 07:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DE5D2071E7;
	Mon, 28 Oct 2024 07:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="J00wLZeX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6BCttQ/1"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9E7206502
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 07:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730100972; cv=none; b=mNd8CS2jHUuXCZgwPw0k5Lv/pDwW8rcb+YaXNBOHaPW+DlsGOgq0JQOJII8HI67Kuu+8QIpCpa8wdkRn22l+xGIQEwdmnewNazJWemmRZZoxLZXfwEOfgU3GEkFISixX/IrTckjdYMdkdx0Yw3YGLYP2nL0mADEBj1SaxagxO78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730100972; c=relaxed/simple;
	bh=9PdsUuYpTN2C6qHSqx434uFs5AXyTwcb5RovbxcyLis=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cbWP/DKrFaMySiyOJzUph2Id4Np0bTluH8bDqf3RBqp8+c08LOnQgqynfhjza9BlpzqimsLdloORVMfgYLGtAOdzT76noRRgKwN2JRLvi11oEQ3J27LUN8idYojhndqImwlM8ZmH3XJYgC3ivwsy3tpUD0gCq9pWQxkvbX0GaD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=J00wLZeX; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=6BCttQ/1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730100967;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n8+eIAnZAWa5IhIML+AEY4ZBvVRGHV38HNKn8muuaoo=;
	b=J00wLZeXuCTuZuAAgfmDWeAArN8Vd1TiMGjRy4UzwOdNArCh+8+Eaw1xgdOLhQZIiwoALp
	D5qSZlGQSZUGo2qx19eVR69KLdGnsZu1DH/3xkkMGy3Ri5BTS1x7sHZrlCcjk/xnAEqgf4
	Sb0qjNrtR57Nt4IzGMiyMhJoeftuhCq+yPNpv/3X+D1n6e+Kc4eNNTbqtnzbPg9xhCKljw
	BhpgtdTvS5an/VcEXzTp3m5Flu+wlweyY/9LNAyW3NIWomvG1UYAYadtq3dK1zu6f7hnaA
	iJbjUoxLSx52OqRfXWjkjkPLlaJOgppjvHihYdohlau2c72FyFf5LpMTH7H5Vg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730100967;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n8+eIAnZAWa5IhIML+AEY4ZBvVRGHV38HNKn8muuaoo=;
	b=6BCttQ/1jNLgSr+FwW3p5llQZd1nRard7bg/EqjNARK6YZG+TVsOIjmB3Qpgvu/CQrhaXp
	uTZW5AQMXI/nF8Ag==
To: Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>
Subject: [PATCH 09/12] hrtimers: Rename __hrtimer_init_sleeper() to __hrtimer_setup_sleeper()
Date: Mon, 28 Oct 2024 08:35:53 +0100
Message-Id: <a2fe1afcb479d0db51d6f4aef8399dd6e59384f3.1729865740.git.namcao@linutronix.de>
In-Reply-To: <cover.1729865740.git.namcao@linutronix.de>
References: <cover.1729865740.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

All the hrtimer_init*() functions have been renamed to hrtimer_setup*().
Rename __hrtimer_init_sleeper() to __hrtimer_setup_sleeper() as well, to
keep the names consistent.

Signed-off-by: Nam Cao <namcao@linutronix.de>
---
 kernel/time/hrtimer.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 2e03b07cbdac..36d55ce57810 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1964,7 +1964,7 @@ void hrtimer_sleeper_start_expires(struct hrtimer_sle=
eper *sl,
 	 * Make the enqueue delivery mode check work on RT. If the sleeper
 	 * was initialized for hard interrupt delivery, force the mode bit.
 	 * This is a special case for hrtimer_sleepers because
-	 * __hrtimer_init_sleeper() determines the delivery mode on RT so the
+	 * __hrtimer_setup_sleeper() determines the delivery mode on RT so the
 	 * fiddling with this decision is avoided at the call sites.
 	 */
 	if (IS_ENABLED(CONFIG_PREEMPT_RT) && sl->timer.is_hard)
@@ -1974,8 +1974,8 @@ void hrtimer_sleeper_start_expires(struct hrtimer_sle=
eper *sl,
 }
 EXPORT_SYMBOL_GPL(hrtimer_sleeper_start_expires);
=20
-static void __hrtimer_init_sleeper(struct hrtimer_sleeper *sl,
-				   clockid_t clock_id, enum hrtimer_mode mode)
+static void __hrtimer_setup_sleeper(struct hrtimer_sleeper *sl,
+				    clockid_t clock_id, enum hrtimer_mode mode)
 {
 	/*
 	 * On PREEMPT_RT enabled kernels hrtimers which are not explicitly
@@ -2015,7 +2015,7 @@ void hrtimer_setup_sleeper_on_stack(struct hrtimer_sl=
eeper *sl,
 				    clockid_t clock_id, enum hrtimer_mode mode)
 {
 	debug_init_on_stack(&sl->timer, clock_id, mode);
-	__hrtimer_init_sleeper(sl, clock_id, mode);
+	__hrtimer_setup_sleeper(sl, clock_id, mode);
 }
 EXPORT_SYMBOL_GPL(hrtimer_setup_sleeper_on_stack);
=20
--=20
2.39.5


