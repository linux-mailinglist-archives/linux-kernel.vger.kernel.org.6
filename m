Return-Path: <linux-kernel+bounces-411078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47DE79CF2A9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 18:18:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE91D1F21E5E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 17:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B70FC1D63CF;
	Fri, 15 Nov 2024 17:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="oBd6nc/Y"
Received: from smtp.smtpout.orange.fr (smtp-20.smtpout.orange.fr [80.12.242.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F13621D5AAD;
	Fri, 15 Nov 2024 17:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731691078; cv=none; b=lB5WcyHFvOuXeyn7w6RTuLUQSrsqRUpZ0mQGSqHo43SEN8e12et9d5BeemqCaIqI8dNT82Ctut+heROqfP55Ld7GTI2Tqpw9Q4KLv3OQjU9+gP53SJ8z4pByRecxnvFjIMJVD7DKoytAzhgUYMNQDD8ykLIrZqv1MHPZ1no6kSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731691078; c=relaxed/simple;
	bh=A3XfQLWFeEI3B8csH2YJxU0EFPGKWtOEhtBvLgkdqek=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=vGBhhAwJaZm1o5hOL8m5zp6X69J2vVgS7cdRpAX83LbDvh+J90gXiWEPsCd1zeHWG5TVI23leibQK3NKrHzsohOqFPEhy+rCQE1Ed8zQWVoN7mPTntLziXrMI5qHMR0PsP4kFYfyry8iMW44qYh8HxNnmtygXuh641yygY1B9VU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=oBd6nc/Y; arc=none smtp.client-ip=80.12.242.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from localhost.localdomain ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id Bzx9tMAAh8AEMBzx9t85Ul; Fri, 15 Nov 2024 18:17:53 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1731691074;
	bh=ISPrq17danPOpPQ4NpNMvjghXiy3pfLupLJvQtzC6JE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=oBd6nc/YARXreRA3M9Pq2t+jvnNX3qzxwdqosxR/EPoYRzBDDWOAMc/bbXjeB4EuQ
	 ZuUvWnIXFQVccJm+/ga018jdZdcvZ0o/LBC4b3ldYFA96bLHSxncOHAUJYJhab5f4z
	 8KKQDI6kn02UkBesWS9NBz0zqBxvEc9wemi91qkcuzHXT20PRU34FuJHvuyt9uEbvv
	 dU+0/Dewjp2a4C2P7bmG6pBBlH2nAXoYtjBiQzLOleC9jk4QrUIA4WIFD36cNMRsvp
	 XxvOhp8b8y9ny6Vl4ySHm1aZcJcqpQnlThMSTDlJfbaj5jjhIqjY65dDZAcguqtQ6L
	 h/F6Nf3jNXWtA==
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 15 Nov 2024 18:17:54 +0100
X-ME-IP: 90.11.132.44
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: linux@weissschuh.net,
	broonie@kernel.org,
	lee@kernel.org,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	dri-devel@lists.freedesktop.org
Subject: [PATCH v2] drm/i2c: tda9950: Constify struct i2c_device_id
Date: Fri, 15 Nov 2024 18:17:27 +0100
Message-ID: <d0f63518a053a817cec0ad0e7d9241f9eb2a4a8e.1731689044.git.christophe.jaillet@wanadoo.fr>
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

v2: fix missing const :(
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
+static const struct i2c_device_id tda9950_ids[] = {
 	{ "tda9950", 0 },
 	{ },
 };
-- 
2.47.0


