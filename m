Return-Path: <linux-kernel+bounces-384323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A1319B2927
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 08:48:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF44D1F22028
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 07:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D2B41E0DB7;
	Mon, 28 Oct 2024 07:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XTjiX5JJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Qaqrkilh"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D18E91DF974
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 07:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730100898; cv=none; b=oGdXWintKFix1W8T6URMeXDKEUhrPjjeVRNbeH+IYjdFpomUHIdYTd3kRIswVbcnKqaBhIGINWwe7DaXwNpgCZXsEHYaUKX8mBLaHvxBoL2pS55XKQDJPZMv4ygRQNAFj0Hc+/lrbnGcy+xJmtrHoKrM3X+ubcCXMpSH/+wCxWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730100898; c=relaxed/simple;
	bh=g4MSRZ1ND/c/40scFoJuTaPHPPlbESMSFba+htRDtz0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=s5P5+hpAojR62zTZBgx42k8+l1OvUhh5K4mSnirm708BzhpM45Pzaz5LsRI3EgmnihrpnrvCuX8wBpp0skBJP3Sj9yyFTQZCWJ/1hdGiJ/kDm8xGCJjo5lz1mypM5T2SqEp78xkAJDzLuOJMHMlr/9oUOPNfZXOM7erBBcXNcAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XTjiX5JJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Qaqrkilh; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730100894;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4Mss6JzSI/n43HDWVW5WEmUllYHkMzaraJ7yyKBDbCw=;
	b=XTjiX5JJZOMlDBltE2AFwIhsLclMsLLEydRsNDFM4nm0FvSyGAcNr09pMlN3ZVc8xGKm0v
	JPvwQqb3OdZZjSB5BhSMf576nf5+tx+CBBaOjGu3U7ekksknIw47QQh6Aw7uD04Jo3VPMS
	w68yuz67gDGpy8/CUBg1vZW1XSWrBUHsUe9AqsNXwq39rs6xQZ7231ju3D7VrB1Q6y4jBg
	d536yec2X1YLJ5L2ONFFi0PxBDe8W6oS2s5YJfEEB+/j6kqVQjMsuHQSz6VLKsN+PvYOHm
	LKsTt6RS1R7orNPb+7vv5eDbcTO6CrkTsET9ZzoyCmPDDkc9sKhUp3IoJ9pA3w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730100894;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4Mss6JzSI/n43HDWVW5WEmUllYHkMzaraJ7yyKBDbCw=;
	b=QaqrkilhnMScyHaWC7fAs8Y2T++dVRxKr4+/teO4fJW0g97N1xfCCaGturEdTmCrmRr1k1
	u1FtJclk6v5wffDg==
To: Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 24/24] xfrm: Switch to use hrtimer_setup()
Date: Mon, 28 Oct 2024 08:34:37 +0100
Message-Id: <f6a27bdde5463ff1ba90dafe44e45360000d4c51.1729865232.git.namcao@linutronix.de>
In-Reply-To: <cover.1729865232.git.namcao@linutronix.de>
References: <cover.1729865232.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

There is a newly introduced hrtimer_setup() which will replace
hrtimer_init(). This new function is similar to the old one, except that it
also sanity-checks and initializes the timer's callback function.

Switch to use this new function.

Signed-off-by: Nam Cao <namcao@linutronix.de>
---
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
---
 net/xfrm/xfrm_state.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index 37478d36a8df..ee0581d45d9c 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -669,8 +669,8 @@ struct xfrm_state *xfrm_state_alloc(struct net *net)
 		INIT_HLIST_NODE(&x->bysrc);
 		INIT_HLIST_NODE(&x->byspi);
 		INIT_HLIST_NODE(&x->byseq);
-		hrtimer_init(&x->mtimer, CLOCK_BOOTTIME, HRTIMER_MODE_ABS_SOFT);
-		x->mtimer.function =3D xfrm_timer_handler;
+		hrtimer_setup(&x->mtimer, xfrm_timer_handler, CLOCK_BOOTTIME,
+			      HRTIMER_MODE_ABS_SOFT);
 		timer_setup(&x->rtimer, xfrm_replay_timer_handler, 0);
 		x->curlft.add_time =3D ktime_get_real_seconds();
 		x->lft.soft_byte_limit =3D XFRM_INF;
--=20
2.39.5


