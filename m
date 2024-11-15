Return-Path: <linux-kernel+bounces-411080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8D409CF2B4
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 18:21:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B84B1F24011
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 17:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C6481D63CF;
	Fri, 15 Nov 2024 17:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2VnrhiYT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DKEUhz62"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 812541D5AAD
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 17:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731691246; cv=none; b=ttFasF6M0JLjtz1MbQAPTPpvxgV7fzAgbkH4wvoGU3DrDmN2xZVywIriifmc8KYQAzP1OIYWHyBZgJPYlOFEs8TG/pxcDRJPFbGB2HXeRIePjwHJaoIHLiIPcmL2ew+Sv1uQbO2PQwXPPtnJZcARcVWJMPEjP8qPGBaTUtF2dy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731691246; c=relaxed/simple;
	bh=wxTiCPgczYeasflXTB3Gnf/RVwmWOrJrFbwDdZDzhX4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sZfOxG+t7N+8X/ckELs+n7E2GKrPVnJcTX9xXGaKli0GDQ8e5wzA9WV6wcpxSoFHNFVj/adpgWMea4tm6vq4nwO8Gr2SxUgI7XB5BgUmYjBPdPkFKKNQ+hzif2GbVzofA03/gIU3xloxZGN5O89Gh7SlBfr1l16uGb5WZvcASnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2VnrhiYT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DKEUhz62; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1731691242;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4mZlKRrG+DPnUxrk/55cv+455WXnVQzhH1V8fNj3nts=;
	b=2VnrhiYTiAmLGQrjJ16qjkrjR/d1b3jOx3TEBwhm2WAekj2rIyptD6CIsETB6z3c4cY39P
	uCM0uwkZYbL/6902R9ZXbhOfU2ZsHPmdyxXwVSw63JMUOAixfuy4eJpuTu50l8mC3g8ffu
	OBXonUfGzyFLj59SxBBTfFbC9o7hQ2tmburqTI/m0J2Mkww5mLTNKc66IdY4EHN9BV0Qcx
	6r7KFfcgdo0uPPA6oTUj0pB6q7K9SGyOD59R6n2iLFobhxmCppeNeULDXB8WLKGaq4umqk
	SyEuUrMDgMsSbOw9YZQgj4MDce6a0ry16kIkDuYlnIB52Li7HHq4CQG7k7Az4A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1731691242;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4mZlKRrG+DPnUxrk/55cv+455WXnVQzhH1V8fNj3nts=;
	b=DKEUhz62Z18n85ppjSjG9tT6rNiezg/7ILHb/r5qQUuwzWeRvo4G19xmzDx9+sDkKsniBI
	sLeILguCtdOAYtDA==
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
Subject: [RFC PATCH v3 1/9] futex: Create helper function to initialize a hash slot.
Date: Fri, 15 Nov 2024 17:58:42 +0100
Message-ID: <20241115172035.795842-2-bigeasy@linutronix.de>
In-Reply-To: <20241115172035.795842-1-bigeasy@linutronix.de>
References: <20241115172035.795842-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Factor out the futex_hash_bucket initialisation into a helpr function.
The helper function will be used in a follow up patch.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/futex/core.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index 136768ae26375..de6d7f71961eb 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -1146,6 +1146,13 @@ void futex_exit_release(struct task_struct *tsk)
 	futex_cleanup_end(tsk, FUTEX_STATE_DEAD);
 }
=20
+static void futex_hash_bucket_init(struct futex_hash_bucket *fhb)
+{
+	atomic_set(&fhb->waiters, 0);
+	plist_head_init(&fhb->chain);
+	spin_lock_init(&fhb->lock);
+}
+
 static int __init futex_init(void)
 {
 	unsigned int futex_shift;
@@ -1163,11 +1170,8 @@ static int __init futex_init(void)
 					       futex_hashsize, futex_hashsize);
 	futex_hashsize =3D 1UL << futex_shift;
=20
-	for (i =3D 0; i < futex_hashsize; i++) {
-		atomic_set(&futex_queues[i].waiters, 0);
-		plist_head_init(&futex_queues[i].chain);
-		spin_lock_init(&futex_queues[i].lock);
-	}
+	for (i =3D 0; i < futex_hashsize; i++)
+		futex_hash_bucket_init(&futex_queues[i]);
=20
 	return 0;
 }
--=20
2.45.2


