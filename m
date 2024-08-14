Return-Path: <linux-kernel+bounces-286126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 904379516F0
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 10:47:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2EF41C20BA5
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 08:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD279143875;
	Wed, 14 Aug 2024 08:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Nm/lcfyq"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6655E13E02C
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 08:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723625225; cv=none; b=WkN1nBgOTVrXCL5skbfN8EVLXUshKnbZySlGYOzvY31BMWSSGDJVUreiigolTBntfMGyhisyN+dXhTp/LmbUSSPS+z5mT53gt5bp9gzJxpWgbJKnfjm/h5NpRdCAG6au5ithFqZ8fbtbFIjwnK9Qcs23kO6SPeZJ/xgKpjbWaMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723625225; c=relaxed/simple;
	bh=HkTR8P7eZOA/cD9/Ci7RUHkDKH0x6aG2NAlwkUXRY7M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hpBKQYRTxy8an+RG7QUKBwqQA7FLjvvbKn7pSqdYUYBJQ03bcKrj4U8oR9szYzIWH2qKSHEtWdArVxC/fEuxZ1AB3EV0a77/usaGlz5JGygBvzbJqnjxlN2IaoI4IUyzGdiqMA+Qjki0oVyLtC2jUVaXvKcrVpTTq0IpPzOgC7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Nm/lcfyq; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0A4A5FF80D;
	Wed, 14 Aug 2024 08:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1723625222;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DQhoLS7i08diXkXbtDyfB57FaNUlq4prNXvWOdsu1Lw=;
	b=Nm/lcfyqa1O/kdujLGhvfB3KkPTBsUuCP4WFSLWcXT1W7MmO+EON5iZa3CgK96jKGO8oWB
	bEYbwdgU7ypLogin32tAcvcY4PxEdlxNraSt5BaBTCecTR/Is/gsSfDGtSIQier39k5xX3
	yCr4dwOyQHkqDW18lTpyin7UZzU7hw41FW3aWLJlS22DvoTWLvD5EhmRai/7lP4MoDzY/b
	dEF8uvngATMoGfO2SefZZ+gAWX/mMluNVCarcAhTd97MFU1RkabUNp6FZHWzOHgB+Nbfy5
	KKCG60JBPLoY0Z+KQ596H+d+oLiast9SzCDh5FYsiOULdnM69+DcsTEZUWEUFw==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Wed, 14 Aug 2024 10:46:58 +0200
Subject: [PATCH 1/3] drm/vkms: Formatting and typo fix
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240814-google-clarifications-v1-1-3ee76d7d0c28@bootlin.com>
References: <20240814-google-clarifications-v1-0-3ee76d7d0c28@bootlin.com>
In-Reply-To: <20240814-google-clarifications-v1-0-3ee76d7d0c28@bootlin.com>
To: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>, 
 Melissa Wen <melissa.srw@gmail.com>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mairacanal@riseup.net>, 
 Haneen Mohammed <hamohammed.sa@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>
Cc: dri-devel@lists.freedesktop.org, arthurgrillo@riseup.net, 
 linux-kernel@vger.kernel.org, jeremie.dautheribes@bootlin.com, 
 miquel.raynal@bootlin.com, thomas.petazzoni@bootlin.com, 
 seanpaul@google.com, marcheu@google.com, nicolejadeyee@google.com, 
 Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1040;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=HkTR8P7eZOA/cD9/Ci7RUHkDKH0x6aG2NAlwkUXRY7M=;
 b=owEBbQKS/ZANAwAIASCtLsZbECziAcsmYgBmvG8DQPc1IkCGVGW7pZSJQkZ/lPEjqCBBdruw1
 auCE2m1bx6JAjMEAAEIAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCZrxvAwAKCRAgrS7GWxAs
 4t0dEADPCsb5gb7MDZvQDbZITNlXTrm8Z7D+ShDXUsG3vBZnSiRfin9iM6XivfGFpPhz3Lpf13j
 r9NqzCFzqtAAn5YzJalLkcY4pv+nzwikQHMsXapYdnVirInZgQgCl1/zrJbxzcnTdj+9btVcjoH
 XvYKX8cCQCBOiYQEECYCxuP8ai9E4usoUdE0TwOJ1nJpKju5A1lSvhOvFYK0s5z3H/aS0EXSW5A
 PbCEzZfdgUnn4t9IjVBWt3nXEtJGaBfG1WAjVF9cF3wf2tSt+kpDk+RAMDWo1XIdtySvfj8iEjw
 YYh2Ovoi1GiCKU+qyv8aRBEUFCwHtsZHhg76g4heQCVBxWwh4Oyr6z++hq9gMcsPdL/CGbNeTjL
 K/0+0yl/RqKoHSbEqGj4sOr2rWitn0+mB0R0zUd7xkgtKv0eiCB32wZuX7fw1IamH/OYQwKbYhe
 re43JNLbnwKziGnmnL5hhCMS2HJAMAxKSoRfT5B1mE+pRlLXiktxNASYV1apW7QonXaUDwclMRS
 ll0/a5UvefhoxgveHJGTb7iOWwecQTRqv8dyswo2uZS+Cmj3LoN6ML94SwfRkZ4r8vwBfxD0O94
 a4IiEwduJ4rw5MUzFwc39JR8btyf9sRsA/yp4KNlEJn913OhSMi8O8oD/+jfTjN6sWMEa5rexF4
 9+F519cUB7Enf3g==
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
X-GND-Sasl: louis.chauvet@bootlin.com

Some newlines were missing around comments.

Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 drivers/gpu/drm/vkms/vkms_drv.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_drv.c b/drivers/gpu/drm/vkms/vkms_drv.c
index 6860bee8e981..5aeb43592960 100644
--- a/drivers/gpu/drm/vkms/vkms_drv.c
+++ b/drivers/gpu/drm/vkms/vkms_drv.c
@@ -163,9 +163,11 @@ static int vkms_modeset_init(struct vkms_device *vkmsdev)
 	dev->mode_config.max_height = YRES_MAX;
 	dev->mode_config.cursor_width = 512;
 	dev->mode_config.cursor_height = 512;
-	/* FIXME: There's a confusion between bpp and depth between this and
+	/*
+	 * FIXME: There's a confusion between bpp and depth between this and
 	 * fbdev helpers. We have to go with 0, meaning "pick the default",
-	 * which ix XRGB8888 in all cases. */
+	 * which is XRGB8888 in all cases.
+	 */
 	dev->mode_config.preferred_depth = 0;
 	dev->mode_config.helper_private = &vkms_mode_config_helpers;
 

-- 
2.44.2


