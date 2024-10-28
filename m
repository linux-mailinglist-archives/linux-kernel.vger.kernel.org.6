Return-Path: <linux-kernel+bounces-384374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 305E39B295B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 08:57:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBFE01F23AE0
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 07:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F4A0205E1E;
	Mon, 28 Oct 2024 07:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yi09C2yQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jjFeP1Kp"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0BA191478
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 07:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730100968; cv=none; b=N6r6XckqNEJSdecKcCgu+KY/FWcjmqaqiwk+/o2xh5pT+A13LQKUCfp4ONTC8QgnLWl2PmVAP/ZdSfxksg2pkdtxRizkuiLlcyskqM3GiuN3k9zLuPOryiTb3CvCaPm0SBbFHaozCPFDJdTzFRmZW4R0J/Yu/zB/i7hYVdGWcNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730100968; c=relaxed/simple;
	bh=EU8Ie+iT6Fk2gRwcRiV/wdZUAioy6FnNy/roxslGrIw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=e0USgItvczq6CHoEPmeJt8McPjVnsFflgD5ZCrPEi4G5qz1Ol2Zc/n1gQ3ymYHA0YZ1r2gwyj3yCBXXt+y0eCr11Rlxfrjk2dV9WveQ7N69eWmMpvsuMXBMzFW0jw2gmSrc9Y9tIWZThKBu1iE1m9RSLOd56mcopZMdDGN9hnO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yi09C2yQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jjFeP1Kp; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730100965;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pjCSSJ0vW46ZiT80KY9Uct7w1SEE5WswuvQfmiuIeMo=;
	b=yi09C2yQivqtvxoJFS+h8cetE5T8Hlkw2YDVh/3LI0b7kBN9nOkxJkH7OWvf6OXwXr0Mrt
	oLBtr3dNSzBWSySw0QQ9QMm/Oq7OAX8Wv6gyGKBxIv2K9NKERgX9TxJP7fvtbpHD14EcNd
	Orc14KoVqpxrpVw100t7HvjxY7agJ0evOhd/YnwyAtV3crvUpzSEyuR+/4pdTF4Ofx3jjS
	ud6TI9CAKmZ5EwHP652CTsLQalZqz7jUK96tSB8r01SG/PIMMmnJ7WOBRqwKmxAZ3Teuzu
	1aGNU0/plnT8QjvabafIu2ES7J8+jiu+KCIYySP4dVSeQD0fVi16eOyp4RZJgw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730100965;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pjCSSJ0vW46ZiT80KY9Uct7w1SEE5WswuvQfmiuIeMo=;
	b=jjFeP1KpMzfXGaVfODOUsVXe+iVX9F+XURlteqzlwpTO3hFm9Ii09JlMmXRiI4q9hY03rb
	Jy15R6H8xbgHjrAQ==
To: Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>
Subject: [PATCH 01/12] hrtimers: Delete hrtimer_init()
Date: Mon, 28 Oct 2024 08:35:45 +0100
Message-Id: <7bde2762d82d30dab184c7a747e76afc41208da0.1729865740.git.namcao@linutronix.de>
In-Reply-To: <cover.1729865740.git.namcao@linutronix.de>
References: <cover.1729865740.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

hrtimer_init() is unused. Delete it.

Signed-off-by: Nam Cao <namcao@linutronix.de>
---
 include/linux/hrtimer.h       |  2 --
 include/linux/hrtimer_types.h |  2 +-
 kernel/time/hrtimer.c         | 20 --------------------
 3 files changed, 1 insertion(+), 23 deletions(-)

diff --git a/include/linux/hrtimer.h b/include/linux/hrtimer.h
index 7ef5f7ef31a9..47103a0f6691 100644
--- a/include/linux/hrtimer.h
+++ b/include/linux/hrtimer.h
@@ -226,8 +226,6 @@ static inline void hrtimer_cancel_wait_running(struct h=
rtimer *timer)
 /* Exported timer functions: */
=20
 /* Initialize timers: */
-extern void hrtimer_init(struct hrtimer *timer, clockid_t which_clock,
-			 enum hrtimer_mode mode);
 extern void hrtimer_setup(struct hrtimer *timer, enum hrtimer_restart (*fu=
nction)(struct hrtimer *),
 			  clockid_t clock_id, enum hrtimer_mode mode);
 extern void hrtimer_setup_on_stack(struct hrtimer *timer,
diff --git a/include/linux/hrtimer_types.h b/include/linux/hrtimer_types.h
index ad66a3081735..7c5b27daa89d 100644
--- a/include/linux/hrtimer_types.h
+++ b/include/linux/hrtimer_types.h
@@ -34,7 +34,7 @@ enum hrtimer_restart {
  * @is_hard:	Set if hrtimer will be expired in hard interrupt context
  *		even on RT.
  *
- * The hrtimer structure must be initialized by hrtimer_init()
+ * The hrtimer structure must be initialized by hrtimer_setup()
  */
 struct hrtimer {
 	struct timerqueue_node		node;
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 55e9ffbcd49a..60cb805a6b0b 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1588,26 +1588,6 @@ static void __hrtimer_setup(struct hrtimer *timer,
 		timer->function =3D function;
 }
=20
-/**
- * hrtimer_init - initialize a timer to the given clock
- * @timer:	the timer to be initialized
- * @clock_id:	the clock to be used
- * @mode:       The modes which are relevant for initialization:
- *              HRTIMER_MODE_ABS, HRTIMER_MODE_REL, HRTIMER_MODE_ABS_SOFT,
- *              HRTIMER_MODE_REL_SOFT
- *
- *              The PINNED variants of the above can be handed in,
- *              but the PINNED bit is ignored as pinning happens
- *              when the hrtimer is started
- */
-void hrtimer_init(struct hrtimer *timer, clockid_t clock_id,
-		  enum hrtimer_mode mode)
-{
-	debug_init(timer, clock_id, mode);
-	__hrtimer_init(timer, clock_id, mode);
-}
-EXPORT_SYMBOL_GPL(hrtimer_init);
-
 /**
  * hrtimer_setup - initialize a timer to the given clock
  * @timer:	the timer to be initialized
--=20
2.39.5


