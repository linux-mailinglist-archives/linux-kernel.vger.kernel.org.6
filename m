Return-Path: <linux-kernel+bounces-384276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F3EEC9B28E3
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 08:37:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98A5E1F21EB1
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 07:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6994D1DACB1;
	Mon, 28 Oct 2024 07:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="caBvsLBS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gBGboDw5"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D4B192D63
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 07:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730100744; cv=none; b=YflL7s1j6e6BZIfFvvHPsMYuHKu2CXvCm075lfHCJDhCgqMfviL4/mYFiNVUH/mX4e+KldF+U6P7ou1hoy7i1yun53w7FLxxAcgGH5yi7VTdOp4+0l4DYzWU+V8kBUXQfWJVahq7tw6Bf5N6l/2DZJeL8hiEPvxlfAqLNEfjgQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730100744; c=relaxed/simple;
	bh=bkqsIoCyE3CqSdDhx7dadJrfLwphPvU3dAe3uOitme8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KCB+79A8g1hnBIfKKeHFI/e7OtMcIn775fYOmuWUPr39pYWjmUV8Y5+NxLj5ZXXmzUvn+cQUnlUf7S8tUvm7KT2Znf+mXxX8x7qhonctofGjLu0quNLBQtMjZjp/tukogn1PNZyJMRbeRg0+CoR6jPXlv/xn/bKAiuUxSCQaJIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=caBvsLBS; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gBGboDw5; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730100739;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f/bFwrQjSGVLIFbGNl9gheDznbX3lT4A2xnJTp6woys=;
	b=caBvsLBSuNZHOOv6Ak9Hjy3hcH80QJwywcu2t/XYHT5TqxKNV5G8by6Qs6a2kojGxwAPz+
	VdcmaD13xmCPsUTqBqzmPtcKS2IRS6vmm+NHB8fips7oHh7nPfrGgpciPTUPkLCenP4niS
	7tlrmwu6X04bXjDY3s86ou5vQEMTg/qUD9Unqki1PGqHeD8NPMUsZ7q4b18dRcfHuo/fgL
	7lIB+FL+frqM6/5rks/0gyxY2fBHhIlCDGDkhhI3OG98JLgr/M7SIwKDIjrygD/U0XWlMd
	EWQJYteV97vPH7NF4olcT7ocQVJ4JA/9xmhFIhNGQRYmi4JGxqe9HqIX9rGkeg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730100739;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f/bFwrQjSGVLIFbGNl9gheDznbX3lT4A2xnJTp6woys=;
	b=gBGboDw5EPF0VtdEVuqyHOAmc8K+F+LPj+4UlHI5rDJ7uNNED9tzQBeM0CVAsNHIlr8onN
	2pa1txmFYrgsd4Aw==
To: Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 11/31] perf/x86: Switch to use hrtimer_setup()
Date: Mon, 28 Oct 2024 08:31:44 +0100
Message-Id: <0687a34c6cc33bd7f814b6c71c029d5cfcad0de8.1729864823.git.namcao@linutronix.de>
In-Reply-To: <cover.1729864823.git.namcao@linutronix.de>
References: <cover.1729864823.git.namcao@linutronix.de>
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

Patch was created by using Coccinelle.

Signed-off-by: Nam Cao <namcao@linutronix.de>
---
Cc: Peter Zijlstra <peterz@infradead.org>
---
 arch/x86/events/intel/uncore.c | 3 +--
 arch/x86/events/rapl.c         | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index d98fac567684..1579ee33f8eb 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -347,8 +347,7 @@ void uncore_pmu_cancel_hrtimer(struct intel_uncore_box =
*box)
=20
 static void uncore_pmu_init_hrtimer(struct intel_uncore_box *box)
 {
-	hrtimer_init(&box->hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	box->hrtimer.function =3D uncore_pmu_hrtimer;
+	hrtimer_setup(&box->hrtimer, uncore_pmu_hrtimer, CLOCK_MONOTONIC, HRTIMER=
_MODE_REL);
 }
=20
 static struct intel_uncore_box *uncore_alloc_box(struct intel_uncore_type =
*type,
diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
index a481a939862e..d072955e5930 100644
--- a/arch/x86/events/rapl.c
+++ b/arch/x86/events/rapl.c
@@ -264,8 +264,7 @@ static void rapl_hrtimer_init(struct rapl_pmu *pmu)
 {
 	struct hrtimer *hr =3D &pmu->hrtimer;
=20
-	hrtimer_init(hr, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	hr->function =3D rapl_hrtimer_handle;
+	hrtimer_setup(hr, rapl_hrtimer_handle, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
 }
=20
 static void __rapl_pmu_event_start(struct rapl_pmu *pmu,
--=20
2.39.5


