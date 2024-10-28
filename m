Return-Path: <linux-kernel+bounces-384303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7692F9B2912
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 08:44:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A86C11C212B5
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 07:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E980E1D3631;
	Mon, 28 Oct 2024 07:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BGOVTHgF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MkDeYlBY"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ADFD1D0F44
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 07:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730100889; cv=none; b=ZYez7B4QIpNNs3JktNkPY6eB05LPbfHKuQ1nRdF5lcjYlWwGqrgFhQxWkMEuS/dTPDHfiuK9kFlePnPrsPGTo8tVO8Z279M6iZBUjqmj5mW7hgcRSFFvmhQZyLDrmKYrge3ZiCqJn5y663TORNf8hfyXsGgx7yGW9K8xrHJbGaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730100889; c=relaxed/simple;
	bh=B1WDcXop0ExBXIdLaaXhRD8YeAYsjUTt23cq/CcRYTo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=o2eLIb1SnjNLwmBjApnYNOVZQ6zf1gZroch+plUQmCBn4sM/o+ArPUcR6J6fUsLhN4rJGZbmpRhvoysTq2CDQU0xkct2RzHOaOiNeSio2sTzRx9MNDYxscLbmHG5qltphv5EXMZuv8y49D/bu3419SP9CeqmbiH5TC8RLOmyswY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BGOVTHgF; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MkDeYlBY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730100885;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Apn3cvIPvUI0d3S8Oue+I7c0RI2f9N2EuYLkYYaFkKo=;
	b=BGOVTHgFVp/D6RxnxO08lkeZUYLKo+11JdpxDUbmtOaCcbbOGW57UJYFUtHdGT7eU2qgbY
	ifgmHiLvfWGLs7zEcVTRJhBLFAlQ9uPyzyXbaBpSa5jKYRxU+8yU/tjeU915hEjYI1dwKx
	tQiBwvJZJaVqAJEBUMqHFeqpCCzt9d5c+lg+ZsSIsC25QKOpKzVfW8auDSw+Oar5nFiSEU
	BM3tTssYX9OjJmdD4pzmoinSc3lpAV94DuPiSNLN1p4v3/6/AOJjboF7PTUlFbjvNVcKjS
	mwKH0t2Sg3yxjwhihJFS7vZsJrp+261LlpS3klHP3GTh6nviaLmM3diC0YxjRA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730100885;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Apn3cvIPvUI0d3S8Oue+I7c0RI2f9N2EuYLkYYaFkKo=;
	b=MkDeYlBYjz8g6UXZUBudsJGE/FW4g3eWjaQflx6qUCoaiSaV4Pz1FUvnMk44kPOxUCe1v5
	INjd+CB8qvFO67Dw==
To: Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 04/24] tcp: Switch to use hrtimer_setup()
Date: Mon, 28 Oct 2024 08:34:17 +0100
Message-Id: <bf180f9db2a4e6a58306ae9f4c2a1f2b154ee6ff.1729865232.git.namcao@linutronix.de>
In-Reply-To: <cover.1729865232.git.namcao@linutronix.de>
References: <cover.1729865232.git.namcao@linutronix.de>
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
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
---
 net/ipv4/tcp_timer.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
index 79064580c8c0..6fa99cac98c2 100644
--- a/net/ipv4/tcp_timer.c
+++ b/net/ipv4/tcp_timer.c
@@ -869,11 +869,9 @@ void tcp_init_xmit_timers(struct sock *sk)
 {
 	inet_csk_init_xmit_timers(sk, &tcp_write_timer, &tcp_delack_timer,
 				  &tcp_keepalive_timer);
-	hrtimer_init(&tcp_sk(sk)->pacing_timer, CLOCK_MONOTONIC,
-		     HRTIMER_MODE_ABS_PINNED_SOFT);
-	tcp_sk(sk)->pacing_timer.function =3D tcp_pace_kick;
+	hrtimer_setup(&tcp_sk(sk)->pacing_timer, tcp_pace_kick, CLOCK_MONOTONIC,
+		      HRTIMER_MODE_ABS_PINNED_SOFT);
=20
-	hrtimer_init(&tcp_sk(sk)->compressed_ack_timer, CLOCK_MONOTONIC,
-		     HRTIMER_MODE_REL_PINNED_SOFT);
-	tcp_sk(sk)->compressed_ack_timer.function =3D tcp_compressed_ack_kick;
+	hrtimer_setup(&tcp_sk(sk)->compressed_ack_timer, tcp_compressed_ack_kick,=
 CLOCK_MONOTONIC,
+		      HRTIMER_MODE_REL_PINNED_SOFT);
 }
--=20
2.39.5


