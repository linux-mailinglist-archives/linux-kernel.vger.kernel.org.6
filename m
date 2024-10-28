Return-Path: <linux-kernel+bounces-384302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D555B9B2911
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 08:44:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39F73B21914
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 07:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1E591D3185;
	Mon, 28 Oct 2024 07:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="o+Y8tmAV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="60rYZr8R"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E6F190676
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 07:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730100889; cv=none; b=ImEPpzjYis7HlTc3lfMLw/irXAuTSwSdx5BMYwuD7GTq5M7k/UpXzS+MUCfKUYgwCJG8G+HHV1ex8cHqs8VH+08ZODYR/nn83c9wNTFwwjQ9AJKwv2zxTDmJ+zX4cNCsl9iFLiYdWyutD/giJmeDv1hKyxequzQq3PfEttP/a6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730100889; c=relaxed/simple;
	bh=uSFmRHZ4mORz9jnaWbqf93G4GdYS641MvBhPZkvsHrk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kygWUIJs1UAFZixAvt2XctnpmV58+J6DxFLP9cSNGwn7+nbmhRy2V7whVSoce15eHZ7RGXml4T8xwrw7AwR74nAGbLrsCn40eqnTLHJozB/pIb4LLANn+lwQk5ctvzPPbEphEwEwq8awGZaGMsUSzTeHksBOMOGrLA6qBxBkRWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=o+Y8tmAV; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=60rYZr8R; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730100885;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nZKpBfygwf4iBxAlcXdYvSaGK+lTqEy3dGw1GX1UVVo=;
	b=o+Y8tmAVtESwzzllBu7CqaZsiX+qprLqcUvOFRiChvjI3xgPgxxnfsiRN1SeDnYwN9eXP0
	vxfg/7nZun7rSjYfPphUOVGutxSbNsUTHIQEeelpEq5M1amZY1eaIvtesyN8DnguyJ2lYf
	rBS3oFcP4nL3Rha0eI3fD8+YlHvu/XbrmQeGPkXsZfI89s6sOPRFRcA/OwqalpfdsL5Kv0
	lUsI1uZN51urROz1S1C6lZtpAfUzCVrHX5sFWfbpInYXAlY2wZzcbs5yqVdIaXaJF9UVpy
	tluvfncWEnWBbbjyDv3XJ45bCegbVn3ytKH8sbEuWzNtfi+OSelaTabEN6SuYw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730100885;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nZKpBfygwf4iBxAlcXdYvSaGK+lTqEy3dGw1GX1UVVo=;
	b=60rYZr8RL+vC7qpU4FddZ7i8kdAf46QRUpY/B3gf7Kq3CHx9J1ma48I7Bc9HY1u5ENg8+h
	69fS1aBi7q3Y45Dg==
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
Subject: [PATCH 03/24] mac802154: Switch to use hrtimer_setup()
Date: Mon, 28 Oct 2024 08:34:16 +0100
Message-Id: <6bdfd7e7a3cac9856766ba7f1eb25a7a6378950d.1729865232.git.namcao@linutronix.de>
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
 net/mac802154/main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/mac802154/main.c b/net/mac802154/main.c
index 21b7c3b280b4..ea1efef3572a 100644
--- a/net/mac802154/main.c
+++ b/net/mac802154/main.c
@@ -213,8 +213,8 @@ int ieee802154_register_hw(struct ieee802154_hw *hw)
 		goto out_wq;
 	}
=20
-	hrtimer_init(&local->ifs_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	local->ifs_timer.function =3D ieee802154_xmit_ifs_timer;
+	hrtimer_setup(&local->ifs_timer, ieee802154_xmit_ifs_timer, CLOCK_MONOTON=
IC,
+		      HRTIMER_MODE_REL);
=20
 	wpan_phy_set_dev(local->phy, local->hw.parent);
=20
--=20
2.39.5


