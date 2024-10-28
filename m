Return-Path: <linux-kernel+bounces-384300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DF879B290D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 08:44:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15B361F2228F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 07:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E839718E34C;
	Mon, 28 Oct 2024 07:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rIJUCe9f";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="e0MFjrC3"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 575EA1CF5CA
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 07:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730100888; cv=none; b=W3HUYaCFl+RwcVWSwwRCKSmOlzzecoEu1nOXLtBJ6N6OILROr1ySAWM+gIkONwdJVM+sS+ohk9Lk8mUZ0ACb7mYsWyk7ZJUfpNSJtLTRJEeFUwlp/xrX/5Gl5J64by4/sKT56hbDEXr8uhayiIU6NX5+KmFUSTp/7g9OgGp5z1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730100888; c=relaxed/simple;
	bh=miT8OtQMm1y32Xc0/YDlas6CWZQ8j1jbIlPl4FjPCaA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sAQKlh0GJqn1Q1ihHAdoux2dMyCBTHjrTeLDGtCNSofdhGdzVYWfpBNqAR6qO+Ej3VSuKKfh+htpLyUA8TGS6gmvxKtvpCUYWtBJHRdV7Ipo7P0s52K8PhcPKkcvQz6tSud9kciHZLi6X/46kiOtYKYF1xXJTCE785SuP3crUHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rIJUCe9f; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=e0MFjrC3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730100884;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qcXDwPaoD5nocGgqRGtaTVq6ULiMLIy5K2rLo240QfA=;
	b=rIJUCe9fwHjbRJGBfCICejqCwCRj6AWZCQRhbQpDu1yKOjeYNu/Yy7HJeCtej0wUSyCZ3f
	2vtS1KGxzrwRtlNPpkqdC6bYSaIusiGEE5YzxW5lD+hi4bAIfwlnwEWRAmB3eNNWvgI2cP
	GySDwW4SbYcX40EB8tebGL02WoXtfh5tjE9ORdk0Au+ZxZPA9gSJ5dqZOC2Iou8H5zeIEN
	oZoi88Ajr9wQIJSklow0qIL0JOFNe8BfcQaUMv3LJ97SFQ7m5SUWSV78y5nwgOucUxu6g4
	6lbV3fnCfTSPpYjxqv0OGL+dJGkN61xz7X+9NzPNv1P7RNfnhpXUP1jP5FEr9A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730100884;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qcXDwPaoD5nocGgqRGtaTVq6ULiMLIy5K2rLo240QfA=;
	b=e0MFjrC3pM9PqCCx3zMNJ51OVIjNKVkeNiJ8ku4g6WuLE6yVgZyFm5jRyZEYyIxKT7NGnW
	xg8RUMQ+XD+XZkBw==
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
Subject: [PATCH 01/24] netdev: Switch to use hrtimer_setup()
Date: Mon, 28 Oct 2024 08:34:14 +0100
Message-Id: <287f1d85c215b99b21556fe4de5d8d7df0acb13d.1729865232.git.namcao@linutronix.de>
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
 net/core/dev.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index cd479f5f22f6..83971c85466e 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -6645,8 +6645,7 @@ void netif_napi_add_weight(struct net_device *dev, st=
ruct napi_struct *napi,
=20
 	INIT_LIST_HEAD(&napi->poll_list);
 	INIT_HLIST_NODE(&napi->napi_hash_node);
-	hrtimer_init(&napi->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_PINNED);
-	napi->timer.function =3D napi_watchdog;
+	hrtimer_setup(&napi->timer, napi_watchdog, CLOCK_MONOTONIC, HRTIMER_MODE_=
REL_PINNED);
 	init_gro_hash(napi);
 	napi->skb =3D NULL;
 	INIT_LIST_HEAD(&napi->rx_list);
--=20
2.39.5


