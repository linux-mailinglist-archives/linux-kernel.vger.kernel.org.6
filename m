Return-Path: <linux-kernel+bounces-398057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 142499BE4C1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 11:50:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5C38283503
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 10:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 292BB1DEFF5;
	Wed,  6 Nov 2024 10:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="h181rJVJ"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63AAD1DE2DA
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 10:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730890129; cv=none; b=Uivlh1/2fqN5zGs6A9kONF/VVZ7uMAEJgGkVfYgYL/qIGbhq+3CUP3zN0M6gf0AXYSv+8ERmFEbokLE7fxs8QticiUV9XHoM76Y+f4DCvi0+H/gDLXV4dJfQ/4azpbuKRKpgcst48jdTfGRRSaMV0cAYqfvqjWMiTYNt+eM8mdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730890129; c=relaxed/simple;
	bh=fL0FJMCi1hScPIlgpGJ/cgIhxfwzaCsKDP4Y+fgJtX0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=h30WKhjA557eFZam7NKu5nnPAGdVUTgjAhVG1jyYTMsVODq/HoyfKcMTJaAdWehaMP4jseCt5LbesXKAMbV505WW0OrKsARwWVS+S5yru15Uz/akMNlcLWTLDEMHTwOgQ0nNFT0CZzrc3/jolNgLtUTSCbG3A09UD0Qsew3LmgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=h181rJVJ; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 21B026000B;
	Wed,  6 Nov 2024 10:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1730890122;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lEuh5s/boyvsj4t0oSTEvebQYcCGEo5tXwMo58H8NSk=;
	b=h181rJVJmgDXRgMEtKz1LRVCXHTYXIm4vQUmedPRaXj6vPKK90exzlyq2L8/A/iYHe9wHT
	XTQr0WSW/vlhd9bhOdYzc3dZQLbQGo0Wv5TqOPIVIdXQmLNPF75eZQGg3VkKu/U/TKRQse
	CFesmiaELt1plh0h5GPMqWTmr9uaqSn5YEahI+4xNFf0p9RbXPLrINWYaLQ36JD3MwKZPS
	/6crV0FVEFQF8P2t/cd8HIo36INu1NmrGMN4zTWVx9AX9tV8EMME7cuDFNqqjGgcfwbw6x
	FOy7KfaKETOfmrVwpsnE13SllWiCQ4g9yNRq/wZQj7ePoz3iDZt11nZLmv7tmg==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Wed, 06 Nov 2024 11:48:24 +0100
Subject: [PATCH v2 1/4] drm/drm_mode_object: fix typo in kerneldoc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241106-drm-small-improvements-v2-1-f6e2aef86719@bootlin.com>
References: <20241106-drm-small-improvements-v2-0-f6e2aef86719@bootlin.com>
In-Reply-To: <20241106-drm-small-improvements-v2-0-f6e2aef86719@bootlin.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
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


