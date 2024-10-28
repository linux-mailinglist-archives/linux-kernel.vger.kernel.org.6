Return-Path: <linux-kernel+bounces-384249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C52B9B28C9
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 08:32:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFD32281D8F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 07:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 649F9198E84;
	Mon, 28 Oct 2024 07:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ketm5QGj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8NQyUa0l"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52174191F9C
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 07:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730100634; cv=none; b=H+jN9jNDJN4vb9D9FoDJGT12PIYUV5SV7XhAKtOdTGt73nH0le/1wjsOgqG3BYiPQvF4fHzBjyreIylA+rzCKhje12R7/gYs7OkRUvcUZeuLpvC15K10ZDFajOEtTFPD1+U7MEVYHgMJR/JM9b5yhxMigWT2z2TnAkKQLv1PGps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730100634; c=relaxed/simple;
	bh=/TiV3JZyyoDCuhZwy3q7qmd+NClcP5OpUDNnTdfw/FQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Nx0yQnNd4YLEzr2fTjfEjr236olq4vA3znHusmNEtmuQpjWFEaiH4q7lbJ/yrWRu7WdDDutKlpUX+HGk/oy8/5nKsc8+8ZQRSBXPOUSJUIvFeVDO5TWMtfjBYf9GLneKLdC3ANcVeAtfAJDUaKUxSpX77Qz60H3IaqUZFcAyzFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ketm5QGj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=8NQyUa0l; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730100630;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C0XVO90iLQ7PE7PoHD7NMl5oQGpGsAUbSQs5v9r9boQ=;
	b=Ketm5QGjD10DDXZX/BACxxPNHvKwPglzdn3L6ds75Ki7ZDbEfujHtVIlySXg+vn36MMc+7
	qu53k6bZVyx0fMrMv6oCKiSqCQ67G6ric1udyi1HuvPwo9NoGSaHcXIYbqDERfrRwp5+FX
	te7y7JY0nyGHyM8tY1LNQ4+1hQIy2z+KLS+J0sBW50RaKTzHhaiLnRBt2I/rIF30rhFgSN
	pLrwXnyEG/NuWaqV4V314DRkRMSmX//ITTXawGQFb7FJz4/Ackxmhh3tjxu0LibMzZKVpF
	/6h+YwbOV3EhUx8SRqKeuCznkYYayT6D3RxKWlqyBgYFluHZei9xDMC2+OV1Jw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730100630;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C0XVO90iLQ7PE7PoHD7NMl5oQGpGsAUbSQs5v9r9boQ=;
	b=8NQyUa0lGolXaPje5Zv5PuTAERG/5LjcVtBJu9vVLC+y438xoSuqXu4+c8wpt92C8w9iCJ
	mUgRPA4Bwg/4jyCg==
To: Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>
Subject: [PATCH 09/21] hrtimers: Introduce hrtimer_setup_on_stack()
Date: Mon, 28 Oct 2024 08:29:28 +0100
Message-Id: <bfe414f8d99ef0d752ce9bc5958f492f7d0d627c.1729864615.git.namcao@linutronix.de>
In-Reply-To: <cover.1729864615.git.namcao@linutronix.de>
References: <cover.1729864615.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

To initialize hrtimer on stack, hrtimer_init_on_stack() needs to be called
and also struct hrtimer::function must be set. Introduce
hrtimer_setup_on_stack() which does both of these things, so that users of
hrtimer can be simplified.

This function also does sanity check on the callback function pointer. If
the callback function pointer is invalid, set 'function' to a dummy
callback function, so that the kernel does not blow up later on.

hrtimer_init_on_stack() will be removed as soon as all of its users have
been converted to the new function.

Signed-off-by: Nam Cao <namcao@linutronix.de>
---
 include/linux/hrtimer.h |  3 +++
 kernel/time/hrtimer.c   | 19 +++++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/include/linux/hrtimer.h b/include/linux/hrtimer.h
index bcc0715c59a8..2da513f8d66a 100644
--- a/include/linux/hrtimer.h
+++ b/include/linux/hrtimer.h
@@ -232,6 +232,9 @@ extern void hrtimer_setup(struct hrtimer *timer, enum h=
rtimer_restart (*function
 			  clockid_t clock_id, enum hrtimer_mode mode);
 extern void hrtimer_init_on_stack(struct hrtimer *timer, clockid_t which_c=
lock,
 				  enum hrtimer_mode mode);
+extern void hrtimer_setup_on_stack(struct hrtimer *timer,
+				   enum hrtimer_restart (*function)(struct hrtimer *),
+				   clockid_t clock_id, enum hrtimer_mode mode);
 extern void hrtimer_init_sleeper_on_stack(struct hrtimer_sleeper *sl,
 					  clockid_t clock_id,
 					  enum hrtimer_mode mode);
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index a5ef67edcda9..daee4e27f839 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1646,6 +1646,25 @@ void hrtimer_init_on_stack(struct hrtimer *timer, cl=
ockid_t clock_id,
 }
 EXPORT_SYMBOL_GPL(hrtimer_init_on_stack);
=20
+/**
+ * hrtimer_setup_on_stack - initialize a timer on stack memory
+ * @timer:	The timer to be initialized
+ * @function:	the callback function
+ * @clock_id:	The clock to be used
+ * @mode:       The timer mode
+ *
+ * Similar to hrtimer_setup(), except that this one must be used if struct=
 hrtimer is in stack
+ * memory.
+ */
+void hrtimer_setup_on_stack(struct hrtimer *timer,
+			    enum hrtimer_restart (*function)(struct hrtimer *),
+			    clockid_t clock_id, enum hrtimer_mode mode)
+{
+	debug_init_on_stack(timer, clock_id, mode);
+	__hrtimer_setup(timer, function, clock_id, mode);
+}
+EXPORT_SYMBOL_GPL(hrtimer_setup_on_stack);
+
 /*
  * A timer is active, when it is enqueued into the rbtree or the
  * callback function is running or it's in the state of being migrated
--=20
2.39.5


