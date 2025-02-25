Return-Path: <linux-kernel+bounces-532010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE876A44796
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 18:14:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C25CC17FCE3
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 17:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2AA81C84A5;
	Tue, 25 Feb 2025 17:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UveOwL8a";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vZXPygKI"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC4B1A073F
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 17:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740503372; cv=none; b=uP0V2FgHWaL7bIc0VmuKzoyqpNwd2090521hBqDo15G29VFjO+cnLijBZ1h60TSmIlhdAW8m0921yECecV/9FvynMSPy1KnlNOwgw8kHzxK23abE4ybzDa9i65qNWk/JJBvzhbvgWcXM2tQR4bNjqw0ims853ekl6lxY1Xb1UPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740503372; c=relaxed/simple;
	bh=sOe+wXZR4BqZvyAanWB7XKCQ40k5e6zY2rFmlzubbGg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F/KfA+wzguulEWOzphjxmbAXtXV6hUJcXKIobCc/W8ni33+uWbM6En+DHXqcWaQDcfDaQRP5ySZfO/yJYHicfBH92XsDRnwNkAaRIIlTZtBJEv5VyoaE3z7WEoS4Nv3RcC7HmPsc9AxJFm/LFovLLKtOa5PJhucwnCXAq4SOF7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UveOwL8a; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vZXPygKI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740503362;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aAMRbscoUAdf49hvJ3tjIaA97RO0pYHBV4A0ahIJ7q4=;
	b=UveOwL8aN2oBbR5anr81lBR2dmCGhlzas1qbNz4by/visEz2upi688DiOod/rUw5bHrtQC
	2zLFOZy6rRtvnxdPEpBgcEaWBgjMdp0WQCgGMVCQjDlSPr1hpAtu8NSNSadU90u7mrvC8V
	nIEZGq3ci8OlFd0mZU1O9tB7863oqPzA9hc7kqTpkdduVVpc8ryR4lpY9FvgGRIP2rrY6a
	sGTrbuwrHydttQCNUPz0owPJByb89gAo2PXl/Pl8EXF0RE5mbZS23Ye4iUZux8j0NE9DnZ
	TFzPOcBStNCI5AkCNBVotT3KIDCLy4z10FdfGHZXByxTe5IQKl+ZZAqEkLoOBQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740503362;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aAMRbscoUAdf49hvJ3tjIaA97RO0pYHBV4A0ahIJ7q4=;
	b=vZXPygKIp5df2UDgsR6gHbxJzGKZZty2r4MBO/WRxAGe38lrtwDCqK3v0EE+c1dV2WNz+r
	eqm0d6EKODB+7IAQ==
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
Subject: [PATCH v9 06/11] futex: Decrease the waiter count before the unlock operation.
Date: Tue, 25 Feb 2025 18:09:09 +0100
Message-ID: <20250225170914.289358-7-bigeasy@linutronix.de>
In-Reply-To: <20250225170914.289358-1-bigeasy@linutronix.de>
References: <20250225170914.289358-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

To support runtime resizing of the process private hash, it's required
to not use the obtained hash bucket once the reference count has been
dropped. The reference will be dropped after the unlock of the hash
bucket.
The amount of waiters is decremented after the unlock operation. There
is no requirement that this needs to happen after the unlock. The
increment happens before acquiring the lock to signal early that there
will be a waiter. The waiter can avoid blocking on the lock if it is
known that there will be no waiter.
There is no difference in terms of ordering if the decrement happens
before or after the unlock.

Decrease the waiter count before the unlock operation.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/futex/core.c    | 2 +-
 kernel/futex/requeue.c | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index e4e0bc7722d78..a66623524a952 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -554,8 +554,8 @@ void futex_q_lock(struct futex_q *q, struct futex_hash_=
bucket *hb)
 void futex_q_unlock(struct futex_hash_bucket *hb)
 	__releases(&hb->lock)
 {
-	spin_unlock(&hb->lock);
 	futex_hb_waiters_dec(hb);
+	spin_unlock(&hb->lock);
 }
=20
 void __futex_queue(struct futex_q *q, struct futex_hash_bucket *hb,
diff --git a/kernel/futex/requeue.c b/kernel/futex/requeue.c
index 992e3ce005c6f..023c028d2fce3 100644
--- a/kernel/futex/requeue.c
+++ b/kernel/futex/requeue.c
@@ -456,8 +456,8 @@ int futex_requeue(u32 __user *uaddr1, unsigned int flag=
s1,
 			ret =3D futex_get_value_locked(&curval, uaddr1);
=20
 			if (unlikely(ret)) {
-				double_unlock_hb(hb1, hb2);
 				futex_hb_waiters_dec(hb2);
+				double_unlock_hb(hb1, hb2);
=20
 				ret =3D get_user(curval, uaddr1);
 				if (ret)
@@ -542,8 +542,8 @@ int futex_requeue(u32 __user *uaddr1, unsigned int flag=
s1,
 				 * waiter::requeue_state is correct.
 				 */
 			case -EFAULT:
-				double_unlock_hb(hb1, hb2);
 				futex_hb_waiters_dec(hb2);
+				double_unlock_hb(hb1, hb2);
 				ret =3D fault_in_user_writeable(uaddr2);
 				if (!ret)
 					goto retry;
@@ -556,8 +556,8 @@ int futex_requeue(u32 __user *uaddr1, unsigned int flag=
s1,
 				 *   exit to complete.
 				 * - EAGAIN: The user space value changed.
 				 */
-				double_unlock_hb(hb1, hb2);
 				futex_hb_waiters_dec(hb2);
+				double_unlock_hb(hb1, hb2);
 				/*
 				 * Handle the case where the owner is in the middle of
 				 * exiting. Wait for the exit to complete otherwise
@@ -674,8 +674,8 @@ int futex_requeue(u32 __user *uaddr1, unsigned int flag=
s1,
 		put_pi_state(pi_state);
=20
 out_unlock:
-		double_unlock_hb(hb1, hb2);
 		futex_hb_waiters_dec(hb2);
+		double_unlock_hb(hb1, hb2);
 	}
 	wake_up_q(&wake_q);
 	return ret ? ret : task_count;
--=20
2.47.2


