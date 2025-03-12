Return-Path: <linux-kernel+bounces-557972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9662A5E002
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 16:16:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38C25171025
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 15:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 182FE2528F0;
	Wed, 12 Mar 2025 15:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KQXfr5+2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GNIj+GFE"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E411EB1A9
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 15:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741792604; cv=none; b=k37TWC7xyosgsjnv9guMRFUF/5LLcw2njlbQoJ1j26oBala25nAdBhwVlQ5rI8g52zqrGEe2Zhf96dC1vaHmDHE1iXdD7w/JcuA+AX1SuSXlvMXpwtbLlZaTCngPrJGvXNum2rhrCZLF7jGaYbKpzgqNeM+BiXsm5P2I0ck9K4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741792604; c=relaxed/simple;
	bh=IKCqymlZHiMJT+CqMRlS9IoHd/fGF5KQBWzzQjT0dN0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q/APtWGPjER0xPKiUuEJy3i5wvpXxhz/ioPpeuuoRW4hCgLotZ2r+EcVW0XdPbxIFZ3yHCKsFH5MihvYJ1bUcXglXz6Ne0R+i7ApbrsNm/OX2DzdAeVWI/lfyiB96rJ6vyVtTI+2uxF9WMpbr/ekkGNlz3Ts4HxI4KuXkXlwXts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KQXfr5+2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GNIj+GFE; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741792601;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mZHtf3xWmXqiraVMjhasP+1bQqaBuZbzg7ehXZac8eA=;
	b=KQXfr5+2zgw1mdvr0FCRmBN7Gg4xlJ1phesr8jbVVEpbODhZnDDVAmj/ipfUyxeU5nmPvj
	MnJN84ribiKfGHzKClGc2tIH3G/AYxJW+tqcjtvLEFB/V9WVtfemgGkkZhyMd774KwpJxa
	xwfG5N5FirdIC8BslX9WR4PllhqF39Wkn5+Sr51aAX5vNuDPCTfELL/NaDaOJYOnHzcjtH
	q90xhas0NkK8yU8OhARTnmjXKHdanyl3yRAXpIatIJ7TkTHLqjLspbz50akhQPlnPjOAsE
	Nk7EaMoxN+t+U7T4rzYZAQmONeDlB8xIS32/bzUNeFvc0NF2Y5VupqRIcR0oIQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741792601;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mZHtf3xWmXqiraVMjhasP+1bQqaBuZbzg7ehXZac8eA=;
	b=GNIj+GFEOrJ5Sc9qjSZoyR+VKIiFLg8GMewQ4mRq94ABt8fXts+865PDiDXkvNXPOu/uoA
	whg5ZzKxDRQu0ADw==
To: linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Waiman Long <longman@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v10 03/21] futex: Pull futex_hash() out of futex_q_lock()
Date: Wed, 12 Mar 2025 16:16:16 +0100
Message-ID: <20250312151634.2183278-4-bigeasy@linutronix.de>
In-Reply-To: <20250312151634.2183278-1-bigeasy@linutronix.de>
References: <20250312151634.2183278-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Peter Zijlstra <peterz@infradead.org>

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/futex/core.c     | 7 +------
 kernel/futex/futex.h    | 2 +-
 kernel/futex/pi.c       | 3 ++-
 kernel/futex/waitwake.c | 6 ++++--
 4 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index cca15859a50be..7adc914878933 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -502,13 +502,9 @@ void __futex_unqueue(struct futex_q *q)
 }
=20
 /* The key must be already stored in q->key. */
-struct futex_hash_bucket *futex_q_lock(struct futex_q *q)
+void futex_q_lock(struct futex_q *q, struct futex_hash_bucket *hb)
 	__acquires(&hb->lock)
 {
-	struct futex_hash_bucket *hb;
-
-	hb =3D futex_hash(&q->key);
-
 	/*
 	 * Increment the counter before taking the lock so that
 	 * a potential waker won't miss a to-be-slept task that is
@@ -522,7 +518,6 @@ struct futex_hash_bucket *futex_q_lock(struct futex_q *=
q)
 	q->lock_ptr =3D &hb->lock;
=20
 	spin_lock(&hb->lock);
-	return hb;
 }
=20
 void futex_q_unlock(struct futex_hash_bucket *hb)
diff --git a/kernel/futex/futex.h b/kernel/futex/futex.h
index 16aafd0113442..a219903e52084 100644
--- a/kernel/futex/futex.h
+++ b/kernel/futex/futex.h
@@ -354,7 +354,7 @@ static inline int futex_hb_waiters_pending(struct futex=
_hash_bucket *hb)
 #endif
 }
=20
-extern struct futex_hash_bucket *futex_q_lock(struct futex_q *q);
+extern void futex_q_lock(struct futex_q *q, struct futex_hash_bucket *hb);
 extern void futex_q_unlock(struct futex_hash_bucket *hb);
=20
=20
diff --git a/kernel/futex/pi.c b/kernel/futex/pi.c
index 7a941845f7eee..3bf942e9400ac 100644
--- a/kernel/futex/pi.c
+++ b/kernel/futex/pi.c
@@ -939,7 +939,8 @@ int futex_lock_pi(u32 __user *uaddr, unsigned int flags=
, ktime_t *time, int tryl
 		goto out;
=20
 retry_private:
-	hb =3D futex_q_lock(&q);
+	hb =3D futex_hash(&q.key);
+	futex_q_lock(&q, hb);
=20
 	ret =3D futex_lock_pi_atomic(uaddr, hb, &q.key, &q.pi_state, current,
 				   &exiting, 0);
diff --git a/kernel/futex/waitwake.c b/kernel/futex/waitwake.c
index 6cf10701294b4..1108f373fd315 100644
--- a/kernel/futex/waitwake.c
+++ b/kernel/futex/waitwake.c
@@ -441,7 +441,8 @@ int futex_wait_multiple_setup(struct futex_vector *vs, =
int count, int *woken)
 		struct futex_q *q =3D &vs[i].q;
 		u32 val =3D vs[i].w.val;
=20
-		hb =3D futex_q_lock(q);
+		hb =3D futex_hash(&q->key);
+		futex_q_lock(q, hb);
 		ret =3D futex_get_value_locked(&uval, uaddr);
=20
 		if (!ret && uval =3D=3D val) {
@@ -611,7 +612,8 @@ int futex_wait_setup(u32 __user *uaddr, u32 val, unsign=
ed int flags,
 		return ret;
=20
 retry_private:
-	hb =3D futex_q_lock(q);
+	hb =3D futex_hash(&q->key);
+	futex_q_lock(q, hb);
=20
 	ret =3D futex_get_value_locked(&uval, uaddr);
=20
--=20
2.47.2


