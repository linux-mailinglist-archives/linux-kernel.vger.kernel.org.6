Return-Path: <linux-kernel+bounces-390750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD80F9B7E20
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 16:17:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68C271F21249
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 15:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 263121C9B74;
	Thu, 31 Oct 2024 15:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bq+e+1uS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ElaKesmn"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4771BDAAF
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 15:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730387712; cv=none; b=prZ8QHO0hMt9QJoCy+UlQTgYZ5ExgmlIyazfKbF6/p7E70AUh06tK9/yQByauVsinCnHXmaFCwN8MpSjLeyBPA4VrY7ENmFzrcqPTv+wkUPeFVYyyHLQcIbxqRT4Bc6/HFWOy0fkr4PBOck5ui4rHbgMlqfhSrby2ZF0coIv45Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730387712; c=relaxed/simple;
	bh=FKFIN/9MgUKbjEkKjmwE7XM0N8D4YxPIPgHMEHKn0bM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LwC2+nSH8Lmyzrolxt51/3uQYLfme+tmDfVi5Qwj6sBvR6LSlYuW8LOuJSsyyBInunXHWHzsUkhQWMDk3AXtVk4U2D7eoqviZ6zpPan9o+OegpzAy487wtsptTBMQJZMRjeGuNLxrz+zw8zykFYEDzNwcDR8JHnvD9S58YPnSEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bq+e+1uS; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ElaKesmn; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730387708;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9xCqurd8D1hnYmih39A2c6mcsRvTzJVfoQsu+HImsEA=;
	b=bq+e+1uSxeiSPkawLE7eQxW9kMjb3UL5exQoCQt0FM9GKq3x5htOe6XCAmIz0H3ahXu/lh
	y3hS0thACuf/gaqKLzVGriHu9CNhQvuCCl71PmzGKxTsPbh0Za8njj6LEqKZxyMtp+doPd
	INq8pdimzIg5NnNbH/TVxIfs0QX1d6jbHdYKCL1jAY5TrkgoyVolGMS5yerVudbTHDMtLi
	awI16ZOVSlu/nHOd6dwqswLqyytlGIkd+rK9CQz1LoXdji50ch0wlbcbidE3ZbLo6xq8Qf
	6cBM5o+XMnPOfI8ZHihwZqN7si5vGcEQS4X6HsGouAHfJfwIf6xnIrMZTy+hyQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730387708;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9xCqurd8D1hnYmih39A2c6mcsRvTzJVfoQsu+HImsEA=;
	b=ElaKesmniCSDRRMv87u1XEUWiUT43CrILh2/yJDCZgn4GTVr+VI2MEiZshH1lWc1git8Yh
	ARFV+cqtSnHG/DBg==
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
Subject: [RESEND PATCH v2 12/19] net: pktgen: Switch to use hrtimer_setup_sleeper_on_stack()
Date: Thu, 31 Oct 2024 16:14:26 +0100
Message-Id: <c4b40b8fef250b6a325e1b8bd6057005fb3cb660.1730386209.git.namcao@linutronix.de>
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
Cc: Jakub Kicinski <kuba@kernel.org>
---
 net/core/pktgen.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/pktgen.c b/net/core/pktgen.c
index 34f68ef74b8f..7e23cacbe66e 100644
--- a/net/core/pktgen.c
+++ b/net/core/pktgen.c
@@ -2285,7 +2285,7 @@ static void spin(struct pktgen_dev *pkt_dev, ktime_t =
spin_until)
 	s64 remaining;
 	struct hrtimer_sleeper t;
=20
-	hrtimer_init_sleeper_on_stack(&t, CLOCK_MONOTONIC, HRTIMER_MODE_ABS);
+	hrtimer_setup_sleeper_on_stack(&t, CLOCK_MONOTONIC, HRTIMER_MODE_ABS);
 	hrtimer_set_expires(&t.timer, spin_until);
=20
 	remaining =3D ktime_to_ns(hrtimer_expires_remaining(&t.timer));
--=20
2.39.5


