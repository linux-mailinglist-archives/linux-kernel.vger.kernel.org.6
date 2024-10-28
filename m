Return-Path: <linux-kernel+bounces-384342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 074F29B293B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 08:52:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38C281C21795
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 07:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CC2F1FF61B;
	Mon, 28 Oct 2024 07:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oToFpIYG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RmhyG4kt"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27BFD1F4263
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 07:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730100943; cv=none; b=dDSxFnqRalexfqP/1ujrYsiBaZKgGiGVi+uk0OAPLFaRC41o3ejte22S9v3T0TASOrvlXh5RUR1wmnqTyvAb/+DGeGqJHtEEYHbVoAVEX/9l3Jip1M6DL9mk9CEs+nEojg2t9vsxYFgcLwWNhuq+PclxJvScnZh8LUOZkh8+lNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730100943; c=relaxed/simple;
	bh=uVoa015HYe5btTzsgcGmX8XI598wivKdFZ21JQQzg0A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=E3yuVoFBj8ECyCjJ89SxNBXcL4vCvUTHvf3QvHSeqZnlILHKXRk6OwPrM5vaXRj1auaidLgSjCSDiCyJrYXX335yYYeSzqADM1OM8EBzA9QjZEfV2lMs1AhXA0UTkkM1fn3iboFBlfeHbCbePVo54ge3dPoVi2jW3151pRJKRuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oToFpIYG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RmhyG4kt; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730100939;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/gDKN/lQVomGUAoZsZW6IwuYx+nvxNLfs4vpRCbgKAo=;
	b=oToFpIYGbP6T7Gl+GtHC9Vg9I5O1a/LBetiwe0UJGw3/2GJyVFLMLnUrOGYSOozrQokXR3
	Wkhmj2cLt/pclIPgPNMpLGerI9x5CCyeu55lxheswo9aKUZWYatV0VJLzsnz3KATtSFLtd
	o9hCsvNkv7cVfLxtDgScr70cyomX7tIcjGCph7P1l2KUv2YqIavz93CkZkr/KKOvUFDW1m
	C26eg3NIPICrpmIJfWisKZQHmHdCoZkov8j1OrzJOu/4C7NCasCbPcTMLqnEerK81XnQiL
	GVWLrispITyfhlb14tAmFxnZPTaujuHQK/dQkV6QVYPfcCkqGeiofbVUjxy2ig==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730100939;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/gDKN/lQVomGUAoZsZW6IwuYx+nvxNLfs4vpRCbgKAo=;
	b=RmhyG4kth9+v5gcMvHlgiXzpI+T/JVD/g5h2wPPSNk6HwzZZjzibP7PVwu3ccINg60PSzf
	hxpyjEDTSVQt6JAg==
To: Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>,
	Jon Mason <jdmason@kudzu.us>
Subject: [PATCH 19/44] ntb: ntb_pingpong: Switch to use hrtimer_setup()
Date: Mon, 28 Oct 2024 08:34:55 +0100
Message-Id: <57598af834c409f2f81ae162aa544ef503725374.1729865485.git.namcao@linutronix.de>
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
Cc: Jon Mason <jdmason@kudzu.us>
---
 drivers/ntb/test/ntb_pingpong.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/ntb/test/ntb_pingpong.c b/drivers/ntb/test/ntb_pingpon=
g.c
index 8aeca7914050..1c1c74f4ff2d 100644
--- a/drivers/ntb/test/ntb_pingpong.c
+++ b/drivers/ntb/test/ntb_pingpong.c
@@ -284,8 +284,7 @@ static struct pp_ctx *pp_create_data(struct ntb_dev *nt=
b)
 	pp->ntb =3D ntb;
 	atomic_set(&pp->count, 0);
 	spin_lock_init(&pp->lock);
-	hrtimer_init(&pp->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	pp->timer.function =3D pp_timer_func;
+	hrtimer_setup(&pp->timer, pp_timer_func, CLOCK_MONOTONIC, HRTIMER_MODE_RE=
L);
=20
 	return pp;
 }
--=20
2.39.5


