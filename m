Return-Path: <linux-kernel+bounces-390748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB3D19B7E1E
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 16:17:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E27F1F2249B
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 15:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E89C01C1ACB;
	Thu, 31 Oct 2024 15:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KMuStyZL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JJzshGDZ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD831BD020
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 15:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730387711; cv=none; b=Z4Fne+zBH6LmCJuLDIbl8Itbv6oM0TwBqdTVr7dH1EL1sJySoYhumCNs/e8RUCjFhYvjS/xT2H7qRWaN1d3d0r0L+L2UlxKWUKCy8U8Of/opduPTT60J7GWzawmzzI6SKmhANk/+/1VMzGIY1MnXLdy1hlYpVrx5SbRIcsnOOVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730387711; c=relaxed/simple;
	bh=TPuf0LrhCx31+dfQrFbYZoYwWMWhKMazpUYH4/zyrFU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=u+5nAM9Whofl6QUHgiOMGXLbOYTg+gOLMwZfRp+YegErOYQQhskEYwTkFfxCPe5mfABdET+2aixBTYz0nqEvJ5IieHB8BQQ48gWVgvmyRnVYDhrhjyfI80xbmwiORU/aBkgxKLubAPzuAcym+dKD9MEg0p34h40rbY/Zh32wi2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KMuStyZL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JJzshGDZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730387706;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pgW81mJgAIDJ6I8UWZoazeDmtDlfTTtXbZvn0v+KF3E=;
	b=KMuStyZLQJ87FD5gpD+CENeqH1MxgSeGxmxX04MwzhkdiAMaUzzwKOrL75g2d5vb9FeI6+
	8Q6VQ3jR14bZF4VEJuybCACjr0WEqH0zTIgve6WFfnQFlW0Jfri3+KgvWmdOBPPmYJ4kMb
	EGZJJBeQ6wgLbLynE39lvyN4HJ8nDilManRnc+ajH9ae7CptIam+vxMsEbK8Qx6WSunw2E
	VezniRzhuOWl8LHc8S+fJfhQp0eDOR0+Zsd/4+pNTnyepBcmOshe5h1Lixmv8Di1INUSwp
	Sx9g9F3BbVrzYvi6whsrPITcuW5Aq3Bqos+jOh8cK4RuaIQAeXdnPlbyzPKJWQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730387706;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pgW81mJgAIDJ6I8UWZoazeDmtDlfTTtXbZvn0v+KF3E=;
	b=JJzshGDZV2BdIrokNMSNAmQdOzpgzIqd8oF1Rv4SZJEYqIrp66dJvhczxlTyvt+t98Ybp2
	aomNsunmz1ldp4Dg==
To: Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: Jani Nikula <jani.nikula@linux.intel.com>,
	intel-gfx@lists.freedesktop.org,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	x86@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Kalle Valo <kvalo@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christian Brauner <brauner@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	John Stultz <jstultz@google.com>,
	Nam Cao <namcao@linutronix.de>,
	Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [RESEND PATCH v2 10/19] fs/aio: Switch to use hrtimer_setup_sleeper_on_stack()
Date: Thu, 31 Oct 2024 16:14:24 +0100
Message-Id: <5f10c259fa43ba2fe774de5b2cedc22f5e9cfd2d.1730386209.git.namcao@linutronix.de>
In-Reply-To: <cover.1730386209.git.namcao@linutronix.de>
References: <cover.1730386209.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

hrtimer_setup_sleeper_on_stack() replaces hrtimer_init_sleeper_on_stack()
to keep the naming convention consistent.

Convert the usage site over to it. The conversion was done with Coccinelle.

Signed-off-by: Nam Cao <namcao@linutronix.de>
Cc: Christian Brauner <brauner@kernel.org>
---
 fs/aio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/aio.c b/fs/aio.c
index e8920178b50f..a5d331f29943 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -1335,7 +1335,7 @@ static long read_events(struct kioctx *ctx, long min_=
nr, long nr,
 	if (until =3D=3D 0 || ret < 0 || ret >=3D min_nr)
 		return ret;
=20
-	hrtimer_init_sleeper_on_stack(&t, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+	hrtimer_setup_sleeper_on_stack(&t, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
 	if (until !=3D KTIME_MAX) {
 		hrtimer_set_expires_range_ns(&t.timer, until, current->timer_slack_ns);
 		hrtimer_sleeper_start_expires(&t, HRTIMER_MODE_REL);
--=20
2.39.5


