Return-Path: <linux-kernel+bounces-384336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 620909B2936
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 08:50:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 938CA1C2172C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 07:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BC881F754E;
	Mon, 28 Oct 2024 07:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QCBkFyXE";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NU8DQSFg"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49CD91E501B
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 07:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730100940; cv=none; b=d7Su22wR5P1VJEtDTWpmLqvxp3+liUo48m31P7KmPoYB0Pj7aG53J5IECMykSbpjCmLsEKc51j2i/Gbt2JGgi7z4YfUvXI4Uqpn+N7RaS29wdYAwdnhF4K02LCfx5qdM6czTdEI+QCCiRJwP0kAFb6X78IyOewSRgyvgMSpy2bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730100940; c=relaxed/simple;
	bh=12s/ih4rMxB/9E8RQdqFXVBfX1NG0zoQ/1YuJDRofK4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kCHVTrFFIRJNIuw8nk7pvzQU77z0SxRx0MeTWGiXStdnqZX8bY6ZHab4rjDS4168sTAuaylIcNAewQfJGblk9oJSTikoj0vRNcU1hl6uXJ21P3yYUuGCUvYgRvt0podC9wMtW25NxrYDNGysPLnQ2yw1nqaqt1PtEFi9oOJ3qXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QCBkFyXE; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NU8DQSFg; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730100936;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VG98OgNYUt7AOG1lFIJaU4AmAsdYRtodd5/LuDGAKhA=;
	b=QCBkFyXE7Q8v3Yo1mMXICr3x0GEPgfy/vz4hmeKXtbWg4FjRnf8aTumQ0AotgA7geupGKh
	VcAZLfFGXklkhrexSmzShO77QkstxIyLI+DIaVR9CU4JasgL3BnVMbGwuOEvTPHecdIsdl
	uT4gAcddPFVWl51e6BHEG+w8DvCdlMU/3Ju3sszM87CqYmQ5yv86y4lQJM3rBjJGF/u4sZ
	7Kb450PpuW9giIkQqywTNX5nImVaAJ4hjcu0X54lu+O2KT/Fg01W3HnF1hZTbOoE2y3Pga
	UgvgDk8SBicjcQj5cx6UGmS6vpJlJSOjEC3jIqTXtk9y9Y/NCdUZ8KHklEuFzA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730100936;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VG98OgNYUt7AOG1lFIJaU4AmAsdYRtodd5/LuDGAKhA=;
	b=NU8DQSFgSmJ7Mou+Tq27weWz9ILntAOi1zaHPOO+zqXL2q1D87k6iE1LcDdmg+oVXUhCCI
	MmrKYZrNR7qOxECg==
To: Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 12/44] scsi: Switch to use hrtimer_setup()
Date: Mon, 28 Oct 2024 08:34:48 +0100
Message-Id: <ba360064dd7c7a25ad0f062b445f6bb4fde0c553.1729865485.git.namcao@linutronix.de>
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
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
---
 drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c | 4 +---
 drivers/scsi/lpfc/lpfc_init.c            | 7 +++----
 drivers/scsi/scsi_debug.c                | 4 ++--
 3 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c b/drivers/scsi/ibmvsc=
si_tgt/ibmvscsi_tgt.c
index 16d085d56e9d..9e42230e42b8 100644
--- a/drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c
+++ b/drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c
@@ -2922,9 +2922,7 @@ static long ibmvscsis_alloctimer(struct scsi_info *vs=
csi)
 	struct timer_cb *p_timer;
=20
 	p_timer =3D &vscsi->rsp_q_timer;
-	hrtimer_init(&p_timer->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-
-	p_timer->timer.function =3D ibmvscsis_service_wait_q;
+	hrtimer_setup(&p_timer->timer, ibmvscsis_service_wait_q, CLOCK_MONOTONIC,=
 HRTIMER_MODE_REL);
 	p_timer->started =3D false;
 	p_timer->timer_pops =3D 0;
=20
diff --git a/drivers/scsi/lpfc/lpfc_init.c b/drivers/scsi/lpfc/lpfc_init.c
index 0dd451009b07..5dc9f47af1f2 100644
--- a/drivers/scsi/lpfc/lpfc_init.c
+++ b/drivers/scsi/lpfc/lpfc_init.c
@@ -7969,11 +7969,10 @@ lpfc_sli4_driver_resource_setup(struct lpfc_hba *ph=
ba)
 	timer_setup(&phba->fcf.redisc_wait, lpfc_sli4_fcf_redisc_wait_tmo, 0);
=20
 	/* CMF congestion timer */
-	hrtimer_init(&phba->cmf_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	phba->cmf_timer.function =3D lpfc_cmf_timer;
+	hrtimer_setup(&phba->cmf_timer, lpfc_cmf_timer, CLOCK_MONOTONIC, HRTIMER_=
MODE_REL);
 	/* CMF 1 minute stats collection timer */
-	hrtimer_init(&phba->cmf_stats_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	phba->cmf_stats_timer.function =3D lpfc_cmf_stats_timer;
+	hrtimer_setup(&phba->cmf_stats_timer, lpfc_cmf_stats_timer, CLOCK_MONOTON=
IC,
+		      HRTIMER_MODE_REL);
=20
 	/*
 	 * Control structure for handling external multi-buffer mailbox
diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
index d95f417e24c0..6ddd2f83003d 100644
--- a/drivers/scsi/scsi_debug.c
+++ b/drivers/scsi/scsi_debug.c
@@ -6385,8 +6385,8 @@ static struct sdebug_queued_cmd *sdebug_alloc_queued_=
cmd(struct scsi_cmnd *scmd)
=20
 	sd_dp =3D &sqcp->sd_dp;
=20
-	hrtimer_init(&sd_dp->hrt, CLOCK_MONOTONIC, HRTIMER_MODE_REL_PINNED);
-	sd_dp->hrt.function =3D sdebug_q_cmd_hrt_complete;
+	hrtimer_setup(&sd_dp->hrt, sdebug_q_cmd_hrt_complete, CLOCK_MONOTONIC,
+		      HRTIMER_MODE_REL_PINNED);
 	INIT_WORK(&sd_dp->ew.work, sdebug_q_cmd_wq_complete);
=20
 	sqcp->scmd =3D scmd;
--=20
2.39.5


