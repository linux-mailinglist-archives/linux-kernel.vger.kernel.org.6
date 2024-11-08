Return-Path: <linux-kernel+bounces-401474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 258DD9C1AE6
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 11:42:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDB8A1F23371
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 10:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BA0F1E285E;
	Fri,  8 Nov 2024 10:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aHiJn/o/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JhRs5HBi"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED155197A82
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 10:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731062546; cv=none; b=Y6G/NFJGfYC0dujj2pO0blRQvR48mbq64m367oRv1nes0pNc5TXPKi8+lNQSfne3XbZXbfIpBJDnF/eV9ekjQEq7704lI3orJRjbFcQw9ypDRZIseFaNoB+041bANiWWbtXcRxu13oLjW7i4XV/UM3Vfzw9QcKLwpW6yG5k8HZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731062546; c=relaxed/simple;
	bh=l1hA+3w6YqDgs7wKbP/EcIpLbeETSQ63y0Ow7Athh74=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tXNN2bT+DwcM15nlfi6il5gAvdzXdVt1zXQUuqrfba9FP87EeCWgluz4tHhq3la6W2C60/AwQg5fcGe6YkH8N0GUPwf2JcCbIyjMjlmrheZsji66rbkhDJc2tLzz3wgpdOqRXiTmcnJzDGywI95Jm3ZVN6OCtCr54DaDITiSGn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aHiJn/o/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JhRs5HBi; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1731062543;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CcYB5rXKKViOk7fZRL5jGg/tydDAGzhBkw56NFEZwc4=;
	b=aHiJn/o/+6onX0kCs8A1AF+dH4PkQZuCiqCHE9SqK55ncLjfpg1wXCj+mytiP4POXPWxIc
	LasvbEFflpW2QiawiJuNUBoYqo1LUSNMMCVWNe3HjnWCKBB74ZIQMT3QcqqtESkoTT5Svu
	pmnNyPkgjHw6sSu7gSRm/y0Yl422xMRqXizzfJSFS4t6H2wQ883iWHWoZQdRCYNVyZbcPL
	Y8bnx2oBAeXr6UTD5sFgH34hxBDtIlwRwtIAE3KjLB2td+B63DBzRDh9/8dp8+mGmXJTKf
	u8j9HEE/1HP71YQv3nRjyx9c6Q8bbr238ij/G1P8w+aAPZvsilvIpQ1Z7WEVsw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1731062543;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CcYB5rXKKViOk7fZRL5jGg/tydDAGzhBkw56NFEZwc4=;
	b=JhRs5HBiMYA0iJy0GGk0/CmAR2p7t7xPyc7Y9NrbJck2tkOJxhBw3tKEnOcV16A4OpkPAo
	kXbaprGbEnguLkCQ==
To: kasan-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Marco Elver <elver@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Tomas Gleixner <tglx@linutronix.de>,
	Vlastimil Babka <vbabka@suse.cz>,
	akpm@linux-foundation.org,
	cl@linux.com,
	iamjoonsoo.kim@lge.com,
	longman@redhat.com,
	penberg@kernel.org,
	rientjes@google.com,
	sfr@canb.auug.org.au,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v3 1/4] scftorture: Avoid additional div operation.
Date: Fri,  8 Nov 2024 11:39:31 +0100
Message-ID: <20241108104217.3759904-2-bigeasy@linutronix.de>
In-Reply-To: <20241108104217.3759904-1-bigeasy@linutronix.de>
References: <20241108104217.3759904-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Replace "scfp->cpu % nr_cpu_ids" with "cpu". This has been computed
earlier.

Tested-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/scftorture.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/scftorture.c b/kernel/scftorture.c
index 44e83a6462647..455cbff35a1a2 100644
--- a/kernel/scftorture.c
+++ b/kernel/scftorture.c
@@ -463,7 +463,7 @@ static int scftorture_invoker(void *arg)
=20
 	// Make sure that the CPU is affinitized appropriately during testing.
 	curcpu =3D raw_smp_processor_id();
-	WARN_ONCE(curcpu !=3D scfp->cpu % nr_cpu_ids,
+	WARN_ONCE(curcpu !=3D cpu,
 		  "%s: Wanted CPU %d, running on %d, nr_cpu_ids =3D %d\n",
 		  __func__, scfp->cpu, curcpu, nr_cpu_ids);
=20
--=20
2.45.2


