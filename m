Return-Path: <linux-kernel+bounces-384290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5544D9B28F3
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 08:40:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 874FE1C21557
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 07:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59C651DE2B2;
	Mon, 28 Oct 2024 07:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4FOdmIhi";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mpKtidrU"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE1B1DB924
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 07:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730100749; cv=none; b=Jr77+zkGQ3JYnYoYKrTLgXQfoengTVVm56EdC9yQ8pMOTwpe6YV6jYWjVAAJWwOAzM7vZWrXBChtSoTGh1aHNmKYiv7Y4YmcWiy4VTI/gAKA1jTwK/hJSOcEPcRgWAjqK+Ey35tMq3SwHHlV94ZLaxDruxh7Rmv5SmLbj6WYJzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730100749; c=relaxed/simple;
	bh=nxP3duLca3yFYtlvgvspSj0s7ofgTz6ODF1JE7KT6hY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qUlaAsN3JaRLyN4XwpRnKMZneVn2X8vBGtkkaP34Uoz3m8aD1kgvxiIJWC1pmI5uCpSCmUQ2neh+8nMDkxp1p2DIRyTsoXbdmXkWlrTdeynW4EvSqYHwuJVuxb4+z8aUwfQmL9YPtEXw/1VO3Qdo+4az0czRRTPvjZLjZGD6Ju8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4FOdmIhi; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mpKtidrU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730100746;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/S4respY/IH0zEpaeY1C+XtgRb1utITUk26WzJC8QFU=;
	b=4FOdmIhiLmX/kkpgjz/AezqjBCJjqFEUDUdaf5KlR+jHBoVPaAPm2R+wbd923FdOIvq4I9
	b5coYOHDFlHmrPXu71NSJ1U443pOXNfaDf72N+oPAV4TPtnjfdldnuVBFTh2P2tHOyrOrv
	ob6yHGf9KhcDEm04nfhhhXlFU80INPZhl218uyDv6IUJrE+/yFEig1oKX6yzV1z46HCEJg
	iFFMCrFB13CemNEJY/kw9n/44uHbnVuEzAWbqgR0nRe/dmJRYdPP00PpYlGvRQW8u7yTob
	Hg8e1FxfT91Ebj2FW81ZM4lHP72e9apuffe8Nl+NJ/vtZhJ3/ELSCuP+HEJxww==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730100746;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/S4respY/IH0zEpaeY1C+XtgRb1utITUk26WzJC8QFU=;
	b=mpKtidrU+Kw20MbRmHDpgi35JkIr8mjI+ivnouffj05SD85G9Rk0Tm8pIeiFN+pRtNktw0
	rmayKUPDY3sUI+AQ==
To: Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 27/31] blk_iocost: Switch to use hrtimer_setup()
Date: Mon, 28 Oct 2024 08:32:00 +0100
Message-Id: <ef35bfe8840954fe89f41f13083e76a9c04e6ece.1729864823.git.namcao@linutronix.de>
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
Cc: Jens Axboe <axboe@kernel.dk>
---
 block/blk-iocost.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index 9dc9323f84ac..5a89535c1303 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -2997,8 +2997,7 @@ static void ioc_pd_init(struct blkg_policy_data *pd)
 	iocg->hweight_inuse =3D WEIGHT_ONE;
=20
 	init_waitqueue_head(&iocg->waitq);
-	hrtimer_init(&iocg->waitq_timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS);
-	iocg->waitq_timer.function =3D iocg_waitq_timer_fn;
+	hrtimer_setup(&iocg->waitq_timer, iocg_waitq_timer_fn, CLOCK_MONOTONIC, H=
RTIMER_MODE_ABS);
=20
 	iocg->level =3D blkg->blkcg->css.cgroup->level;
=20
--=20
2.39.5


