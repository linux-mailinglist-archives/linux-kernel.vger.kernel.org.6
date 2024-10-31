Return-Path: <linux-kernel+bounces-390751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 844EF9B7E21
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 16:17:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A2CFB22BA4
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 15:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E1F51BC9F5;
	Thu, 31 Oct 2024 15:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="d9rQyJXk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iJYPn13q"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F3FD1BDAAE
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 15:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730387712; cv=none; b=PGNbrBOz2e/vx3r8gzNWvmRiDcvG4onLzdQK3QCkr0Rl46x/pujngQKJ9D6G2QBs7XZGLQsLQ2JfHLCdgp+fozctLIHURThS3SaTNK/IbCDMg1IEwbrx50osxD3kzccJvShaDpdd3Q8ycTVouBefLiE0x0+rkE92EHZmq5p9kqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730387712; c=relaxed/simple;
	bh=Toc/w+R6FyfgS/eLMMePZ5Yd2hzg8/twjIrV45SRRwo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ht6IaPTu/V9soFEo26qv+HPP8feQ21FtgLoHZa2wLjLtexg/PElAYjCnbC4zBhpTt99MSXe0xWER/08DwF8Gv9huwoA3zaCcfFzvpSSntUJBO+F3XSbWe+488ZHqO9bqwRA+cM48WevcknmivdgEzgAP8+YXUXFXFel0KAal794=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=d9rQyJXk; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iJYPn13q; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730387708;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eQ4OaVFfuzEdwAbuzRaqadqXL1D9oVVD1jPEwjjtzBI=;
	b=d9rQyJXk7rC9Ud2vUivz4oheHxCrS0wy8Y4I9K4/MwEyTgoXth2bQ2ofGtKZqPrFrVAIFE
	eBreuX1JVSmQrZD9ZDuooRfa1967UO0NZX1rARt6M96UtckeFmNYJOJm+z722maWukY9tW
	UPi2/iZ6ZLJoyBZ6n38jyfuc1ZfqAxYBWy6j4+X58VvSo8p2cQn9WQuvkg1qwLSg3so5Gv
	j/M3l8Hu5yr+9m2V8UTKPUNuID1rHZGM+AMAlpH4XdrHiXlrrAw6ksktCYwShH6mafxPFX
	ni31Gieao14CLn8aRp24XyT14z+KasjZBV6+OLJclicfvZX2lHjXvYqkHVTdHA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730387708;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eQ4OaVFfuzEdwAbuzRaqadqXL1D9oVVD1jPEwjjtzBI=;
	b=iJYPn13qrmJTzgAjFo+ik3kN94gVU4BPHiCVoai61h8kObYhmoA/rxwepH/pG8fD5GF6Pb
	nfIKXy/X2Yvou0DQ==
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
Subject: [RESEND PATCH v2 11/19] futex: Switch to use hrtimer_setup_sleeper_on_stack()
Date: Thu, 31 Oct 2024 16:14:25 +0100
Message-Id: <d92116a17313dee283ebc959869bea80fbf94cdb.1730386209.git.namcao@linutronix.de>
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
Cc: Peter Zijlstra <peterz@infradead.org>
---
 kernel/futex/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index 136768ae2637..fb7214c7a36f 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -140,9 +140,9 @@ futex_setup_timer(ktime_t *time, struct hrtimer_sleeper=
 *timeout,
 	if (!time)
 		return NULL;
=20
-	hrtimer_init_sleeper_on_stack(timeout, (flags & FLAGS_CLOCKRT) ?
-				      CLOCK_REALTIME : CLOCK_MONOTONIC,
-				      HRTIMER_MODE_ABS);
+	hrtimer_setup_sleeper_on_stack(timeout,
+				       (flags & FLAGS_CLOCKRT) ? CLOCK_REALTIME : CLOCK_MONOTONIC,
+				       HRTIMER_MODE_ABS);
 	/*
 	 * If range_ns is 0, calling hrtimer_set_expires_range_ns() is
 	 * effectively the same as calling hrtimer_set_expires().
--=20
2.39.5


