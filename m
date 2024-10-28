Return-Path: <linux-kernel+bounces-384314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CCFB9B291D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 08:46:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFD371C2132E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 07:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7132C1DFD84;
	Mon, 28 Oct 2024 07:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XB6OGRME";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Qzt2DAH/"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A8941D95AA
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 07:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730100895; cv=none; b=TRxq35/RxnWXyCJ3gl4BVLAwrGVXYJ7Bf+jydExpWx916zIVEPayv5KXyoJyrp9rNBvPKtzbI/o1y6rin2zyampx1vToKyPt2bFR1L3m67UR8SJ4L7mwbRrLIynoXjOVga9MgnNQ9vBRWSyT9K/jfGGWZUp1jIyXeOHCHi2equY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730100895; c=relaxed/simple;
	bh=OQG+UNiCOCkyb6VBoWT6XF6/j3JE/VKNWWuQyWf4gy0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uGZWD7ooVZHWsE1hxwaZbrZWjKMp8V0lVbYry1019i4009SXk18JPAsvd8PAGPa7QtQYSWyJmGHtSy4kaJ7B4Ix3yaq+4UXPfESt605mipsAMJ83k9T5fUSpLDHLsoiQXLuHUh8fbdYIv6uMBK9Lo4c93WmAMyXWNRJlTNLcPms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XB6OGRME; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Qzt2DAH/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730100890;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l8RfN8rOA54I4gGgwr0BwQLnPVnXOBjjm6x4TUe9WjE=;
	b=XB6OGRMECdmyUGHWpQvVLJgRXyste8lPN/t/rti96RBfRafvSumfOf/kVt7XbPLLrq7ugr
	ffQk2ZwOnQVpupCEpN19oj89kVWeOX6eK2xARjTONsyT4+2Hsp1xgZ9jUMmXYiain0DBzh
	JPWOI80hHWDe4aEmMdf1jqDYFVFMw7ixZ2wfWNQWCrOpoKG7FjhVaaIFIew8jvVWfT0ZGw
	K2wbNRGmoim8dT086MmeMcRYWd1HvdoYYur2IIIDNBXLisylga88TC0tRuhYLytAMGFPYz
	/OVsCnMIPM8uG4xv8HuUxVZ2gz3VFUL6Vi+8wIxMIpSUBV120ix4jqjhF/LHrw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730100890;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l8RfN8rOA54I4gGgwr0BwQLnPVnXOBjjm6x4TUe9WjE=;
	b=Qzt2DAH/Viy2gbOAgwCdGadMovjrlqyvgBj9Jsv7421PC/5EVx6tmr0CubArI/jQxtzVqe
	tA4a6/ITwxSYlrBw==
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
Subject: [PATCH 15/24] net: qualcomm: rmnet: Switch to use hrtimer_setup()
Date: Mon, 28 Oct 2024 08:34:28 +0100
Message-Id: <73546cd88cd51bd19d22c3fd38a8a8492bf8c65c.1729865232.git.namcao@linutronix.de>
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
 drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c b/drivers=
/net/ethernet/qualcomm/rmnet/rmnet_map_data.c
index a5e3d1a88305..8b4640c5d61e 100644
--- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c
+++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c
@@ -686,8 +686,8 @@ void rmnet_map_update_ul_agg_config(struct rmnet_port *=
port, u32 size,
=20
 void rmnet_map_tx_aggregate_init(struct rmnet_port *port)
 {
-	hrtimer_init(&port->hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	port->hrtimer.function =3D rmnet_map_flush_tx_packet_queue;
+	hrtimer_setup(&port->hrtimer, rmnet_map_flush_tx_packet_queue, CLOCK_MONO=
TONIC,
+		      HRTIMER_MODE_REL);
 	spin_lock_init(&port->agg_lock);
 	rmnet_map_update_ul_agg_config(port, 4096, 1, 800);
 	INIT_WORK(&port->agg_wq, rmnet_map_flush_tx_packet_work);
--=20
2.39.5


