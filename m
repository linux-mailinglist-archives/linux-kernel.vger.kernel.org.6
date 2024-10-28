Return-Path: <linux-kernel+bounces-384360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C33A89B294E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 08:54:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F3A3B2175B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 07:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BDEF2038CA;
	Mon, 28 Oct 2024 07:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Hzxhe8ij";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="32lwbkQz"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A826020103B
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 07:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730100950; cv=none; b=hRrDGZPaM0dDHMw2CvOqq0bIxJHE5HeansY6pHVgH2yT2+7ECj0WEpfUpVktpaleukzPPSd0EzTwXYmvbZT6bUjTMOwtfxZ4HewBpAijktGDMRpH2BKlsfJ8bN3gV7rixpNQx4pIudoThbICS4M9gvlIacP9PVTy7sUwzdncmY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730100950; c=relaxed/simple;
	bh=v0RPT0OMep2K6Mo6s2uR2d1ekab+Ly2Ar/Ea5HBqeiw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BM2xgawR+Oxqqw/5Ed7F0JLPPWGpJw7M6spqNeK0d3g8Ae7DuB4FxHxlwtbWOlcp9UXkbY9bjBID1SEK+q20GqpUYMcFlHwqpG/OmICS3/G8Jk6do1r/+pHUzEV/OFXswPMPlDwIY1FKqwttq1P2a5ax+YijTaDMjGKmUmi+oZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Hzxhe8ij; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=32lwbkQz; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730100945;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rWHQDyubjZWA+hi6pNCvcOiea7GiWMjj2xs2Oakz3bo=;
	b=Hzxhe8ij4ZEGz0obSse4rDgIPWvEBRr4cajuIhko29oTpbm5/4F1e5AIBhvIAwgRf7DUBd
	rwejuP7qFjYF4t0u2nJ3LfDKE+KnG0WnqvGeI97J187WdBcgdESBGEyunlPqV8e14CEcFq
	e9x9ww/n3BhY+LKLNocpOa4oyjJU14N5HKV3xn0WGI/G/6RaWwGh8nmmGLxalMjsMiSPWk
	AAExKd3puteWk0Ib5Sei5Ishq7JhbIjbQM7PE8WfGQWOb/D2stdAOm7raDKVjgfdL/Ibdp
	EeaSleID8Q7BOM//X6IXC+VL1aQsapDA3o+2L+jQo2pmfq271Fs10IS2VSGMNg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730100945;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rWHQDyubjZWA+hi6pNCvcOiea7GiWMjj2xs2Oakz3bo=;
	b=32lwbkQzr9NCNuObcApg1ny8tWmex7Zl4RX+dDU5FIpP92hQBpQwicRzLzDer+2ycbnLqh
	WZ1C7HFh6u5N/CDQ==
To: Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>,
	Jani Nikula <jani.nikula@linux.intel.com>
Subject: [PATCH 34/44] drm/i915/uncore: Switch to use hrtimer_setup()
Date: Mon, 28 Oct 2024 08:35:10 +0100
Message-Id: <4e2d3f9085781c67f94002cb91694c0f813614f9.1729865485.git.namcao@linutronix.de>
In-Reply-To: <cover.1729865485.git.namcao@linutronix.de>
References: <cover.1729865485.git.namcao@linutronix.de>
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
Cc: Jani Nikula <jani.nikula@linux.intel.com>
---
 drivers/gpu/drm/i915/intel_uncore.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/intel_uncore.c b/drivers/gpu/drm/i915/int=
el_uncore.c
index 6aa179a3e92a..f68e76c5c883 100644
--- a/drivers/gpu/drm/i915/intel_uncore.c
+++ b/drivers/gpu/drm/i915/intel_uncore.c
@@ -2098,8 +2098,7 @@ static int __fw_domain_init(struct intel_uncore *unco=
re,
=20
 	d->mask =3D BIT(domain_id);
=20
-	hrtimer_init(&d->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	d->timer.function =3D intel_uncore_fw_release_timer;
+	hrtimer_setup(&d->timer, intel_uncore_fw_release_timer, CLOCK_MONOTONIC, =
HRTIMER_MODE_REL);
=20
 	uncore->fw_domains |=3D BIT(domain_id);
=20
--=20
2.39.5


