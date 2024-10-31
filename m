Return-Path: <linux-kernel+bounces-391065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96E549B823A
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 19:07:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B4F628354D
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 18:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C01281CB33B;
	Thu, 31 Oct 2024 18:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="DPQD5qUk"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57FAE1C57A0;
	Thu, 31 Oct 2024 18:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730397983; cv=none; b=bkE9ihBTHSuHLCMZ8PzoAbMEa0m+18dss/XaxjFiVXncO9I3UT7hYUW1Y4fDw33PlypWsCD+M3/FFBW5bRtr5rrwAQV7b9TT0OUCWdhUFbka9XvXVb3Z9lDw5kEDfW61aBtXWw9yo8ZlBRgZPTPjxq3SHdlOl2PBvCwORZUuhhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730397983; c=relaxed/simple;
	bh=OY3WebhRv0aeGADgqvUb4/UTEnKrmR0RzKDlWJXZa2E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dbtbF9DGJkmSN/HPVRZnctgnC7g59r9KJwmLUFRD3R06hGmXfPWpwxSbd6Z04j6c11SGGsB0jhqrZJJHsV63bPpJ3BA5cKRHanEoTviooCSMuR6staRxVVtTAiYAJB15cqDrNmLOMSujaXPy0c+PU9VHthmNF5Mu46iaMmBWTAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=DPQD5qUk; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 831F22000B;
	Thu, 31 Oct 2024 18:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1730397973;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hsQ2CTA2pljllkiENrEWMPdAOoEF3CDQQvjJFAj8G3E=;
	b=DPQD5qUkYkmp/uTYcGSpBlp7CYk0GB6U5ar80NulIzYl9Y49YCPnhcRuDrknHevkSUVm1L
	9VO4T0DBrYCHrtO/gtFq6XAG95mb9mSiQbAWaRE55jvXBfUEE4++AXZbtCP6XW0NyPR7pJ
	Ieb7g4P485uhxVZwTlSHFam9SsF4RJeB1Tlj6NpjzWMPbuKwCWsNXuG4Tj6FzphJ+o9msk
	LgraFgyO98FwJ5PT2V6aOJmtFD4nRhYRyrggt0Gkcj5QoTXuHHBDcdIkV6NWx3aU9JWGkS
	2rhAPJmz9I7UQBdHpb5CQixRD+wmwhi6e4R6CZYRmzwl/KpNBjYuOIxsMW3O/g==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Thu, 31 Oct 2024 19:06:03 +0100
Subject: [PATCH v13 3/7] drm/vkms: Drop YUV formats TODO
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241031-yuv-v13-3-c67a337301ae@bootlin.com>
References: <20241031-yuv-v13-0-c67a337301ae@bootlin.com>
In-Reply-To: <20241031-yuv-v13-0-c67a337301ae@bootlin.com>
To: Louis Chauvet <louis.chauvet@bootlin.com>, 
 Haneen Mohammed <hamohammed.sa@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Melissa Wen <melissa.srw@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
 Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mairacanal@riseup.net>, rdunlap@infradead.org, 
 arthurgrillo@riseup.net, pekka.paalanen@haloniitty.fi, 
 Simona Vetter <simona.vetter@ffwll.ch>
Cc: thomas.petazzoni@bootlin.com, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 jeremie.dautheribes@bootlin.com, miquel.raynal@bootlin.com, 
 seanpaul@google.com, marcheu@google.com, nicolejadeyee@google.com, 
 20241031-yuv-v13-0-bd5463126faa@bootlin.com
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=881;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=P2BW0rn/HzAIDwl58Rwi6B7V7fHRrzFFCT1b251G+Ng=;
 b=owEBbQKS/ZANAwAIASCtLsZbECziAcsmYgBnI8cNTg7Vuqg944sB2+yE/4NQDuaF8i/v33e2M
 TxAZd53WzuJAjMEAAEIAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCZyPHDQAKCRAgrS7GWxAs
 4i+4D/9+eY7dnehTONtd/+40Vi4PhyrB8h7laI5EeVBfEFG1vvcV/Q5W5VdtDTKPn+hEb+JZmkR
 NVe7SmjHHjApdudPYlEB+6wMgE/igdXbuu0qXL9vGhFfDASuD3lIxVeRCghZjLho0ZGeyDb1TSu
 O34LB2lpUpAUmgnoCqeHl4+Nl5Vt4adS7NlxG814SY4lra1o1N8T5UtSUSqo9g3ndbWfTm/MJqx
 4W+rkJSUZxf72V23MAM5mT+6XTCtP92D1vYN+H9yPI0xSspyfEmyblGLH/Q8W7OI+sgVVKbH4WI
 N756sKHtglDAT0uVcTgGOcDp9UQD6n3OcFhWmtILXhPkCE+mhbJIDTRLaFRW4prlwJXOV8c1Gkr
 xgeqpDpE5mnijB3zCnWh6Z3UXnT8FHVAaL4F7xMX7jiN2DyFoWaAdFqyP0opMcpp8F7FpZxHQF7
 yNVxkhqRzvLSOtXRWriIQazObUw9CHyId9g/qYwFlcgDe4bW1GMTK/c4u5h9Y6h4qdGZNoVDsDA
 ziTsbTIgWQK+6m1mh21/weiwzJuB4fztM9m1OBPt53MhQlo+Q+kGGzhvy3Tw7cfUiKvdMknRhk3
 R2neb1AP4t8Cwb3wPRLNErieXXE2cq+IocgLhul74Lr5Il7i7IHAUyzGEAL4cXx8OG/S7OTYjVU
 EyireR2ErzDnkXw==
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


