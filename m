Return-Path: <linux-kernel+bounces-384343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26A349B293C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 08:52:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 587A81C21759
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 07:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FCDE20101F;
	Mon, 28 Oct 2024 07:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WUz/V0ti";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IZ4FYzFN"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A96F1F4264
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 07:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730100943; cv=none; b=Q7B1r9aG54kcMnCoryUSe8BzxfNmhm0FuOKfo2hQmFyYx1tc1urZGkBFWS5U4GxpCovxK8O/+t7oAWkRYAK+frHPa8/9xEcYUVJf8IU4B99+1Ib6of1TCt2Gt7u2FeDqFoqXm9nH0RsvRk2toPH6+DWBWSsew7eWEigL20KbPpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730100943; c=relaxed/simple;
	bh=lEpQxL9xXuQFToIcVd6yy5VJRuxNaTDofAFptwuN6Zo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NJ/1GGa7tuHSylPerFP4NOs5Axwnmd6PiQ892mNTMrG+LqeOwE8mzU7kKQV3pURPuEc8KrzsGOfioWFl7S4pb7cyIuxgm21VDLQzULAeLqgocKj3iZN/SLD7OPvfnQjkJQ4URykAK87HV4wOvB0rrbLnB2sbU4XlRFHSwEl9Sjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WUz/V0ti; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IZ4FYzFN; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730100939;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ab5B+FqZ3WhkZ6WaAXYb+YI7fVubcn8HVzkt7ibXae4=;
	b=WUz/V0tiYnaI0K58Zo/cv9WTcRPFZZ1GtFxqaVZMYoMsSqxtek0mHFdrEW4HE6ME3E61HA
	ncDqSy9DiY1th1FIo5QUKTcLber0N7qnXJKkZA1q0SqEdrLta+KVYkTcPDNu628w4s1vJ/
	HqjAKgjSP2sf+2Pn87OfFG3RWQ5pFRcbwDWuTf4hSnBp8fwx/tZjxLXoFBbb0I3c5fsCRi
	rU+l3I5HoDpyOpK+ab283hjd9jnh2CILuANV5ka/6eyUe/5/L9jNQfVTO27rLeTvrG8h99
	ooBXBwZ3vM3KX6vaubkGuEH+cQJt2B6f8Vaz+S2eVaHy/SalqjREENG0e9jaEQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730100939;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ab5B+FqZ3WhkZ6WaAXYb+YI7fVubcn8HVzkt7ibXae4=;
	b=IZ4FYzFNXzDXaaEYm6ftTDcL/AV2ys1Kz9wKcUNKgT01cUOAeY90kzx6WFVJa19nyPa7ms
	YjmbUMve1VLCamDA==
To: Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>,
	Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH 20/44] mmc: dw_mmc: Switch to use hrtimer_setup()
Date: Mon, 28 Oct 2024 08:34:56 +0100
Message-Id: <36c90360480ab8c4c13f1034393f53e531ca5855.1729865485.git.namcao@linutronix.de>
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
Cc: Jaehoon Chung <jh80.chung@samsung.com>
---
 drivers/mmc/host/dw_mmc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 41e451235f63..3a15af97e4e1 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -1875,8 +1875,7 @@ static void dw_mci_init_fault(struct dw_mci *host)
 {
 	host->fail_data_crc =3D (struct fault_attr) FAULT_ATTR_INITIALIZER;
=20
-	hrtimer_init(&host->fault_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	host->fault_timer.function =3D dw_mci_fault_timer;
+	hrtimer_setup(&host->fault_timer, dw_mci_fault_timer, CLOCK_MONOTONIC, HR=
TIMER_MODE_REL);
 }
 #else
 static void dw_mci_init_fault(struct dw_mci *host)
--=20
2.39.5


