Return-Path: <linux-kernel+bounces-384274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0FAB9B28E1
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 08:37:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88C4428201C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 07:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C05571DA61D;
	Mon, 28 Oct 2024 07:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ipfvYEN5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PVdLhbiX"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C3B192B8F
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 07:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730100744; cv=none; b=VDi0wim521CaoZ6Qq/onF14wstq+VDXnkhuhMDjrc6EzFtC5nuhFTBb32BqjOPFkgfy9mNRwzbLc4F1y1l6Xj9KRoom+hlyxKuquG5y8unxQx8Bu+R0i8+i+EbM0rhDsMlzLW7L0K7qrY00z+g5ogW0t0/LI9pU6/d/USM9fSIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730100744; c=relaxed/simple;
	bh=WM1Mp7nD+1z2S/O3yOgyCIJPT8k4b8byfoBHNxw6N7c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Crq3pI3V1XqsEzuec6dYwwKzChx3LYimPb8RK4cDiO2mojknamqZ375uTihwyTv/IMsUNQSElJbmcT8cvhfCDQ1sghRu0uRu6sYlrT7Tu0YxUvLQ60Ye0GaktaGlOV9qnCImMkW+J5amGc0mNB+hYKypVOVgWHRpUdUIIHGg+gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ipfvYEN5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PVdLhbiX; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730100739;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B5zZoeNFjrAN+nVop+LdA4aT3KoLdw5lw2yxTRa3DO0=;
	b=ipfvYEN5IsSFKk50pBtqhrJ5a/k3WQOOFbch/hs57sBc0dYTVC9pGhSJ5UDmbm84vNr5YY
	r5HjrVUoWrg3OlT0TLENx1FbKDbGk8CCL5AI50TAOCCQfz/ps02T7IHb5aBfZBrBd/3MpO
	PTSU791EsEEV8FqSA6DkcQTHk7PiMKt+17z5HTadIjwtGkTDkwIeoEM/4otp6RveSBihJ3
	HU92TmH+Y5vCiZ2u3IfcX2wAhOl56/6Gu76O3YHtxTa49moL3DwXgcaOb7KrwVTixPjn3d
	QmoCoNyt8avBC1B25AnKG55xSwkF6SJjVqhGf8plvIlbgxe56kMfCh99wYF42w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730100739;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B5zZoeNFjrAN+nVop+LdA4aT3KoLdw5lw2yxTRa3DO0=;
	b=PVdLhbiXLdlGzwIvIJSmCLsmwfo5hREos5lj6r8k5oMSKmJMOuJgMQfVMXKvPtuCsDpW6K
	8ZCGpj5LYjL9DRAQ==
To: Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>,
	Russell King <linux@armlinux.org.uk>
Subject: [PATCH 09/31] ARM: 8611/1: l2x0: Switch to use hrtimer_setup()
Date: Mon, 28 Oct 2024 08:31:42 +0100
Message-Id: <0d4ef3ad2558fd19e09e5977712a69e2c43ae094.1729864823.git.namcao@linutronix.de>
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
Cc: Russell King <linux@armlinux.org.uk>
---
 arch/arm/mm/cache-l2x0-pmu.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/mm/cache-l2x0-pmu.c b/arch/arm/mm/cache-l2x0-pmu.c
index 993fefdc167a..93ef0502b7ff 100644
--- a/arch/arm/mm/cache-l2x0-pmu.c
+++ b/arch/arm/mm/cache-l2x0-pmu.c
@@ -539,8 +539,7 @@ static __init int l2x0_pmu_init(void)
 	 * at higher frequencies.
 	 */
 	l2x0_pmu_poll_period =3D ms_to_ktime(1000);
-	hrtimer_init(&l2x0_pmu_hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	l2x0_pmu_hrtimer.function =3D l2x0_pmu_poll;
+	hrtimer_setup(&l2x0_pmu_hrtimer, l2x0_pmu_poll, CLOCK_MONOTONIC, HRTIMER_=
MODE_REL);
=20
 	cpumask_set_cpu(0, &pmu_cpu);
 	ret =3D cpuhp_setup_state_nocalls(CPUHP_AP_PERF_ARM_L2X0_ONLINE,
--=20
2.39.5


