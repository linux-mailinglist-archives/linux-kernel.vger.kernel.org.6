Return-Path: <linux-kernel+bounces-384251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EC0D9B28CC
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 08:33:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D10331C21476
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 07:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4871B1CCECE;
	Mon, 28 Oct 2024 07:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JZIOfWJF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ci6+6RmJ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC66E192B60
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 07:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730100636; cv=none; b=CjoEb5u3/R8Wyek01P0bwugJeLsr1MGIDnndZr/yWTDqZRfBo8lQW7kEQCuuXRButRKZ1LJtexnYyP7T1JAFqcie7KTfMX1oonFnztlF6cDofT8MHchObk+kl1+Qm2eIw0nU4Ud4ErWwy0LCm7bvlftPiIhaUSIAJGhOvdmBy70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730100636; c=relaxed/simple;
	bh=VGdxVDo6ASMFPWX2sDzqlW/Dhjo5IawnrhXDtIMp0EM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Nu04brvp9yw+j+uoANDfU5c267P9qXdZjrkq4pZ2qZkwqwidYlZfNtqf8Klkc+7/F0Pqkoqbwee2Xs3bbMlS4eAcRvUrmY8Pm/Qa/nJgJ0lMDTj3rmClmAdjCC6zTh4hMemtSL/cPDAKhslWXmpWcwa6cLtY4BaZFwvunTLQNTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JZIOfWJF; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ci6+6RmJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730100631;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Bm8biOfFQ9hw4SGs0WskkwgwYHgdOlauZhBLT/M7a4M=;
	b=JZIOfWJFS4E0h0v8VW2jG5J+VU7Ojobm85Zphc6WXDVrlGCciFwd4DJvSw1uIPJj5xh9zp
	8dBgM1q0Kzl6Udm4TQjovHIEAJMAA1gjs6DJEaVF9T9MmNJHYUf0ixncGzSbiixhOC7eVH
	1Eb/B6Vmwfgb/pIccO+EM5BOfqxG8V6EZ1yLvIIhUfEzaQXampImcmkPhg8Z5sGBqWZiqR
	bAMgpxHw7z0KeT9bJjIlZSSEJI9vwk/NLQvVf3QSTQFtqF3OkCouYR/xAEaDIuwhFxGwKc
	Wk+d+fa3i/6mNJu1cvq0EasqkQXUO+5egExAgkwHWfwRyX+feCQyeFH4+D7GJw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730100631;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Bm8biOfFQ9hw4SGs0WskkwgwYHgdOlauZhBLT/M7a4M=;
	b=ci6+6RmJi67ARkwzGYNsBwMSpf9DYNYWxyoURVuBGXlwIQGcS/0CSWMg38WYmH1mw1sRON
	8RITC3xAzgXPi8DQ==
To: Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>
Subject: [PATCH 11/21] hrtimers: Introduce hrtimer_update_function()
Date: Mon, 28 Oct 2024 08:29:30 +0100
Message-Id: <faa9e48d25517dd6747740367cfce03615c05040.1729864615.git.namcao@linutronix.de>
In-Reply-To: <cover.1729864615.git.namcao@linutronix.de>
References: <cover.1729864615.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Some users of hrtimer need to change the callback function after the
initial setup, and they touch the 'function' field of struct hrtimer
directly. However, directly changing the 'function' field is not safe under
all circumstances. It's only safe when the hrtimer is not enqueued.

Introduce hrtimer_update_function() helper function, which also performs
runtime checks whether it is safe (i.e. the timer is not enqueued).

The field 'function' of struct hrtimer will be changed to private in the
future.

Signed-off-by: Nam Cao <namcao@linutronix.de>
---
 include/linux/hrtimer.h | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/include/linux/hrtimer.h b/include/linux/hrtimer.h
index 48872a2b4071..6e026730e803 100644
--- a/include/linux/hrtimer.h
+++ b/include/linux/hrtimer.h
@@ -327,6 +327,28 @@ static inline int hrtimer_callback_running(struct hrti=
mer *timer)
 	return timer->base->running =3D=3D timer;
 }
=20
+/**
+ * hrtimer_update_function - Update the timer's callback function
+ * @timer:	Timer to update
+ * @function:	New callback function
+ *
+ * Only safe to call if the timer is not enqueued. Can be called in the ca=
llback function if the
+ * timer is not enqueued at the same time (see the comments above HRTIMER_=
STATE_ENQUEUED).
+ */
+static inline void hrtimer_update_function(struct hrtimer *timer,
+					   enum hrtimer_restart (*function)(struct hrtimer *))
+{
+	guard(raw_spinlock_irqsave)(&timer->base->cpu_base->lock);
+
+	if (WARN_ON_ONCE(hrtimer_is_queued(timer)))
+		return;
+
+	if (WARN_ON_ONCE(!function))
+		return;
+
+	timer->function =3D function;
+}
+
 /* Forward a hrtimer so it expires after now: */
 extern u64
 hrtimer_forward(struct hrtimer *timer, ktime_t now, ktime_t interval);
--=20
2.39.5


