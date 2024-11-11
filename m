Return-Path: <linux-kernel+bounces-404046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ADBC9C3E84
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 13:36:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E71F51F223A2
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 12:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABBB319CC1C;
	Mon, 11 Nov 2024 12:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="c+gEJNaP"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E6B14F9E2
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 12:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731328590; cv=none; b=VZuwIKGsLugXFCuaJ8prwe5zGgFBejn0EhCKTxY9fcxRf90uPLW2Hck05WqbKjhjO4LL+8qv0vgTBq7+y3YGTsfOxCdgF6UYNadu3wA9hVpgTWTLUaEEbRNHjTew7HnHzuCvCgpnLCu85Bx43AMjFyJfcMtE3AidlMVqMSkuPkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731328590; c=relaxed/simple;
	bh=fL0FJMCi1hScPIlgpGJ/cgIhxfwzaCsKDP4Y+fgJtX0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=p4DZSofsxlokWmzlagx6FWoxF5oP4xBP6UuGke5hjk4IGIA3K/enrELv1a7K7Xh3xTfchTgnBjhnzDlwVPYdDSWSiSjCsGPMpz7+yPYca1X8R5iKYkTJVRohFyA//05eD7YXHHmC6kSMi8mbynfNBhXyS824RCelYq1aaxrSTCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=c+gEJNaP; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1291A1BF205;
	Mon, 11 Nov 2024 12:36:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1731328586;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lEuh5s/boyvsj4t0oSTEvebQYcCGEo5tXwMo58H8NSk=;
	b=c+gEJNaPPByhBM/jbh1R2MB577WMJS78OPLv4pyQ3UKT52lBNxOwIscQTFD6MrVLj63IA4
	E4m/nOff1S39jBi8g52TmEVu0XITVsfbBhFrIyydAH7iZ6zAK18Hbdl91DBnD6MH8f0uOK
	fX/BFT7VhWUYtnmrlJ+JT6GqGajZDlfkOPI9ZlSXajQESpPWEQ/8cRfOxzYvtLUn/jnEK6
	TFRyOAX2HLYJLPhHCwycEIhGGSdnPB79lWuZNiD0ZA2Q71QNRtPJKGqUc58b5PXYfUZYe2
	TH8Hkt2rmB3L715b2H3F78gWfypjYkWiyfjzOb/aVAHVI5NNzxQz1wKCouaFfw==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Mon, 11 Nov 2024 13:36:20 +0100
Subject: [PATCH v3 1/4] drm/drm_mode_object: fix typo in kerneldoc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241111-drm-small-improvements-v3-1-a9f576111b41@bootlin.com>
References: <20241111-drm-small-improvements-v3-0-a9f576111b41@bootlin.com>
In-Reply-To: <20241111-drm-small-improvements-v3-0-a9f576111b41@bootlin.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Jani Nikula <jani.nikula@linux.intel.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
X-Mailer: b4 0.14.2
X-GND-Sasl: luca.ceresoli@bootlin.com

Remove unintended extra word.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
 include/drm/drm_mode_object.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/drm/drm_mode_object.h b/include/drm/drm_mode_object.h
index 08d7a7f0188fea79e2d8ad5ee6cc5044300f1a26..c68edbd126d04d51221f50aa2b4166475543b59f 100644
--- a/include/drm/drm_mode_object.h
+++ b/include/drm/drm_mode_object.h
@@ -35,7 +35,7 @@ struct drm_file;
  * @id: userspace visible identifier
  * @type: type of the object, one of DRM_MODE_OBJECT\_\*
  * @properties: properties attached to this object, including values
- * @refcount: reference count for objects which with dynamic lifetime
+ * @refcount: reference count for objects with dynamic lifetime
  * @free_cb: free function callback, only set for objects with dynamic lifetime
  *
  * Base structure for modeset objects visible to userspace. Objects can be

-- 
2.34.1


