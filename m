Return-Path: <linux-kernel+bounces-371936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6EB89A4251
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 17:27:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D21B1F25BA7
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 15:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DF042022D7;
	Fri, 18 Oct 2024 15:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="k3C16OyO"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09968200B93
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 15:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729265218; cv=none; b=Uheq15qqggEwhQE6uL1iAly2oyrSrWrVNZePSiopMkshI1vNJ3UVMeQUrXAowFuDzSeLbuQlFRlDYTZQxouIg8KPy4uzr4t1JdkrXMS7pkgHWVgQMyUFP4BsD8yX4ZGhV0/lrTfxAfHrHha+fnI4fnMH2QmUV786jGOyZCsPDa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729265218; c=relaxed/simple;
	bh=G6qwGvs68ceIrAzlcq91SYa9iuck0iue4k7Ucx/wRMs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PrKrYstMo8Zc5TddRftCCY2S3ScOItItrZ/Z7HzuB2HZgYZphXDbaKphm8AlponDY3+bHRNNAE96JpRW1XOivtq7qngevJJgajJ7LCq3L1YGfhxSM07B0lU3R18HYW/0t+ra2hlfweeJ61gCOPEl3sCUH3nRL6wPtn+puQrGCM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=k3C16OyO; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 995021BF208;
	Fri, 18 Oct 2024 15:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1729265214;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zgyO7dIQcIllwdnmEg0IQTCT+gft9OECU9gbzrUZIvU=;
	b=k3C16OyO1gVTsFWB4qndxTa3+HfEL16s0zitKtfOrC04mvJf5VIsbGGXZV8cxX6TD6Z9OO
	2RlbuywlOTkbbYdHJtp23rG//iFIJ19iLgHf1R5J5a0YyZc0ONNgFfHvtTnOHddabxOv/D
	ohttQBhkrreXff7T1WRWdheDFvMdDwg27MltzYJ1FKFcBRomBnN7xgt6YeBntJcPs9iLO1
	5WsnV3UZiRgK7xFKxVapTs9Y9R2M7BGbdfBFqrKqUdRon7V/oHe9BfvFm3QOSdOgwJ/jkv
	diy3VxLRsV83dYYfJItiY4tvkBcs6cqO0vLJRMj1rwmd9n+uHeHQtrfBgvStTg==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Fri, 18 Oct 2024 17:26:51 +0200
Subject: [PATCH 1/2] drm/drm_mode_object: fix typo in kerneldoc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241018-drm-small-improvements-v1-1-cc316e1a98c9@bootlin.com>
References: <20241018-drm-small-improvements-v1-0-cc316e1a98c9@bootlin.com>
In-Reply-To: <20241018-drm-small-improvements-v1-0-cc316e1a98c9@bootlin.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
X-Mailer: b4 0.14.1
X-GND-Sasl: luca.ceresoli@bootlin.com

Remove unintended extra word.

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
 include/drm/drm_mode_object.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/drm/drm_mode_object.h b/include/drm/drm_mode_object.h
index 08d7a7f0188f..c68edbd126d0 100644
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


