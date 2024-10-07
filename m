Return-Path: <linux-kernel+bounces-353798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CAA89932D3
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 18:13:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D9DC1C22689
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 16:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C34AD1DC75A;
	Mon,  7 Oct 2024 16:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="EJG5VeHd"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8831DBB03;
	Mon,  7 Oct 2024 16:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728317464; cv=none; b=YudHmQ68uBKLwgXqaInO5Dh4JvZr2OZTNCU3FWULLIQehcQPKXvB4ytwvVdBOT0mTM4PLxHrVJQAOqAPSrUp5jCAEGCvMTJXgQIK9BbEKJ55Ib1ED9/FwDfEq2Gyj+5BFMOhfE9fJEW92f7yUXahT0afVJKdVrCv86Dy76LNCD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728317464; c=relaxed/simple;
	bh=OY3WebhRv0aeGADgqvUb4/UTEnKrmR0RzKDlWJXZa2E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Atiw0UpZ3ypmw+kmerk1VvFSBqvxAlyeObw7AsposuflaM5fssLkyUF33aGWA07EPi8DevA4WVlRi9gQwoyq3h4Hfcv8fq5r2aySr/N1GEpZYilBFce+zCWKW9kq3V0djxi+6lDFOutGbjJvQXsNUOOoMxHP00ZFGsp5QZdxDzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=EJG5VeHd; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9550640008;
	Mon,  7 Oct 2024 16:10:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1728317460;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hsQ2CTA2pljllkiENrEWMPdAOoEF3CDQQvjJFAj8G3E=;
	b=EJG5VeHdqibkfEsHHeUJaCQBZZwB336Y4Yae/96UlN/93JIijpUfk/wwXyvHZhUleAQrHd
	6fCTX1D0rMkYm1eLDea0pzM7NzLiqSf1+eD4TsZaSQ/xbxafi2ONvhp8A7UWxNB2GWoOdw
	XDXVY7dZB7tpSZCefijomhLcuTgIliATaYrME//Oscc7k3Nr0Ck1FLuQNwCIofdvECVcfk
	Gl/FC8OIpF8ATfzrxuYzh9SRFLFhwLKzyprgOdA0Wsd1zhWqUEDivDRQBRkQuNLf5vBpyV
	KEFDtqrS3ZygJ8BxTo+yTNXl2yQQDOaZnWsQ1gX/Inyf43raUikMCVoMhyWhpw==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Mon, 07 Oct 2024 18:10:46 +0200
Subject: [PATCH v12 12/15] drm/vkms: Drop YUV formats TODO
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241007-yuv-v12-12-01c1ada6fec8@bootlin.com>
References: <20241007-yuv-v12-0-01c1ada6fec8@bootlin.com>
In-Reply-To: <20241007-yuv-v12-0-01c1ada6fec8@bootlin.com>
To: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>, 
 Melissa Wen <melissa.srw@gmail.com>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mairacanal@riseup.net>, 
 Haneen Mohammed <hamohammed.sa@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
 Louis Chauvet <louis.chauvet@bootlin.com>, Simona Vetter <simona@ffwll.ch>, 
 rdunlap@infradead.org, arthurgrillo@riseup.net, 
 pekka.paalanen@haloniitty.fi, Simona Vetter <simona.vetter@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, thomas.petazzoni@bootlin.com, 
 jeremie.dautheribes@bootlin.com, miquel.raynal@bootlin.com, 
 seanpaul@google.com, marcheu@google.com, nicolejadeyee@google.com
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=881;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=P2BW0rn/HzAIDwl58Rwi6B7V7fHRrzFFCT1b251G+Ng=;
 b=owEBbQKS/ZANAwAIASCtLsZbECziAcsmYgBnBAgDBR4uYZGO5txdh3vIJuJ290SkPJaRBtVsM
 0SZfu4oxKiJAjMEAAEIAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCZwQIAwAKCRAgrS7GWxAs
 4g0ZD/4l2jUUXLh+lNGvq3/zf1ZIVNEXoElmkH3U0WT66RPA7zwYPQ8oPLsg3AElGByOrNuI/y9
 D491sMgq058XAnVkiEYm2jOizTQSFwZNpunbi14DXK2riPrGj0BxUgMwbixvll+EoKTRQNZJ8Nb
 lRLy9iPKDkDhhAzZVFPeaamDEb79Ea4G8jiBKaf+6+II5D/c+jlaBo6+yb2Fcuvb+YIsdSWyt4K
 70zOv/GQL0rGyUlvG75wI/hC/xoCzlTQ65qLj2Bf7jtXPMa6GyeJM0njPKiHKRDwrvZJyaea8eM
 nl5gLaGANrTj7RDn4Na8WnUFTUoxY6J//jpW1kEBWmeaCPVC3SoIH/8PRB2H/5vfAz6Qgpb0MQ1
 qoxZOdQ6hRmXsJ7s5pE70XURz29WXuWN21OxFW0TXGyCVDof/O+cvLolNSMk2ZBTsADcF5oXVEh
 On4E75gzAn/APqR7GLwya1fTqJHhmFhD/Xn2Q4Q/oAQjZNPMndWIUm/FvD5LTfsUktGGqI7KzmP
 zYY1GqTid7lBh93L39hLWxbVllYzCdUsTm4OMsAeXCtUHZ9fWaXXO7WWv5xOUGQoemR1JzPVklm
 MN/DZ9mvzk4/Nan9qL9/C0KIn9/1jliYWvjRoMaxg1cGkS0GQZsX4tGgP0phlcaHvCoPLYt/LrA
 Tm8OO6tKglleMxA==
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
X-GND-Sasl: louis.chauvet@bootlin.com

From: Arthur Grillo <arthurgrillo@riseup.net>

VKMS has support for YUV formats now. Remove the task from the TODO
list.

Signed-off-by: Arthur Grillo <arthurgrillo@riseup.net>
Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 Documentation/gpu/vkms.rst | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Documentation/gpu/vkms.rst b/Documentation/gpu/vkms.rst
index ba04ac7c2167..13b866c3617c 100644
--- a/Documentation/gpu/vkms.rst
+++ b/Documentation/gpu/vkms.rst
@@ -122,8 +122,7 @@ There's lots of plane features we could add support for:
 
 - Scaling.
 
-- Additional buffer formats, especially YUV formats for video like NV12.
-  Low/high bpp RGB formats would also be interesting.
+- Additional buffer formats. Low/high bpp RGB formats would be interesting.
 
 - Async updates (currently only possible on cursor plane using the legacy
   cursor api).

-- 
2.46.2


