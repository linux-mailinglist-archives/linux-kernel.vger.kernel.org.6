Return-Path: <linux-kernel+bounces-411036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F4439CF204
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 17:47:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24B26295D52
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 16:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 340031D5CEE;
	Fri, 15 Nov 2024 16:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="UHJnlDmt"
Received: from smtp.smtpout.orange.fr (smtp-22.smtpout.orange.fr [80.12.242.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE4DA1D5AC3;
	Fri, 15 Nov 2024 16:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731689105; cv=none; b=SPNf+bALFkkSIYAuGhvjWEAJv58Q6aCM29NNPbCnqA5iDZDp0fsHJr8lozdkhS0d6qjm8YElN5scrci6Drp3FHioALbYq+EBdRCrwwmWcJu/Kua5hMps4NtTnRa1ROdIdifG9JaAgWN7WlepcVTZ01dkk8aZQqOsH9NomMELz8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731689105; c=relaxed/simple;
	bh=9osvHc4yaQHRYSrVx6nuy+zzEEXa/T40Z1U5UcKJ2kY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AzHPfXUZWRFNW3lvJiVL2BK566FThSFaR4Eg8aSVhbxiMpqMt0Fl6SIW47Q7by5nfPDAY+SujmipSqCxLos2sQVeqdgPJEVw0Mocac/TTiIikBvwfwP8q7xiueq9HuAb7Kttn1GmfESaw6zr7gwaggG7i6opVAe1+nroEHEAiEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=UHJnlDmt; arc=none smtp.client-ip=80.12.242.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from localhost.localdomain ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id BzRKt9S50PqyaBzRKtzdae; Fri, 15 Nov 2024 17:45:00 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1731689100;
	bh=g8Wzp5+7fJS/vNhoxSgPrU0/wiW6HwJG9NHcRVskjnA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=UHJnlDmtghCt+DMn9DMXGCZ7Gil6JVGU9YC9L3LHs7vp6stA5ABULWORq+tDjWDlw
	 Tc4k1iYJCnvJHpZD8tilknCJL9DQT3JmzL5vnh4AbRRHTWMbm/RacwVf8l4k8Uy3X8
	 Iu0GEF8mqrY9diLsqMWhGMQBajm0fSJ3Ee5/XJAVqaYsL6T0IAgK7yFdlSFexSt7zr
	 OpKOcULXJ8/koIo0CnIHn58bDrihkcvdLJiOpoa69IlIHqTRCPnKH/fNDt1NeMq1ZF
	 ee/dedxkmslMOTKhNNYCvZNtd+9KOeI/Ium9eVKuwJ4Y4LQWbZJbtg1IiWoYcmrwol
	 HP+nNmdwBza1g==
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 15 Nov 2024 17:45:00 +0100
X-ME-IP: 90.11.132.44
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/i2c: tda9950: Constify struct i2c_device_id
Date: Fri, 15 Nov 2024 17:44:27 +0100
Message-ID: <d0f63418af53a887cec0ad0e7d9741ffeb2a7a8e.1731689044.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'struct i2c_device_id' is not modified in this driver.

Constifying this structure moves some data to a read-only section, so
increase overall security.

On a x86_64, with allmodconfig:
Before:
======
   text	   data	    bss	    dec	    hex	filename
  12136	    822	      0	  12958	   329e	drivers/gpu/drm/i2c/tda9950.o

After:
=====
   text	   data	    bss	    dec	    hex	filename
  12200	    758	      0	  12958	   329e	drivers/gpu/drm/i2c/tda9950.o

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested-only.
---
 drivers/gpu/drm/i2c/tda9950.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i2c/tda9950.c b/drivers/gpu/drm/i2c/tda9950.c
index 82d618c40dce..5065d6212fe4 100644
--- a/drivers/gpu/drm/i2c/tda9950.c
+++ b/drivers/gpu/drm/i2c/tda9950.c
@@ -485,7 +485,7 @@ static void tda9950_remove(struct i2c_client *client)
 	cec_unregister_adapter(priv->adap);
 }
 
-static struct i2c_device_id tda9950_ids[] = {
+static  struct i2c_device_id tda9950_ids[] = {
 	{ "tda9950", 0 },
 	{ },
 };
-- 
2.47.0


