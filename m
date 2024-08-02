Return-Path: <linux-kernel+bounces-272818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BDAA3946194
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 18:13:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74DF01F234F7
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 16:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D74C3DABF9;
	Fri,  2 Aug 2024 16:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="hYwYPzlT"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47DA92139A8;
	Fri,  2 Aug 2024 16:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722615027; cv=none; b=QK4jrb5p2fpN846jOzfGNKqyN6qhrDzHeOJ/tNuuw9t1jc65PhV7fIUGf4OlB5d6jBDyIoDP9GlmZ4w+2gXXjFD/eSYPBg5+mEGPZ8wBpzyZwHgbWf4X2McEWyLP6IknUqK6PVcjaCB+K7QsoQXU2y3+kIgJUbYSCVr9Wd/rqbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722615027; c=relaxed/simple;
	bh=rZOSJb9lfOqVrCbd/HY0ghVUJgRRMtkqU90QpsSgK5E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GcBcPnvi66apgAMMWFMtiNc8E2E1GW06X9BEf6Bcxc5+TAFNVvWT0M7sBeeH9wUf0YYCXNSpswjVyjQlgW+w4qavG1KyTPktB4pcn/5XAju4g9tYe7ZZZFF1Cu05ZYvkvcD4169mlJgrIgpsNGZ8uDD0Z8w6CMQIMe+YPlX+Kqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=hYwYPzlT; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 09B941C0003;
	Fri,  2 Aug 2024 16:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1722615024;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nuZLqDhbRxZyFl4sZYfc726XqKnvDZ+QCn+mY1H6AVo=;
	b=hYwYPzlTXq7nmoNQdbCbOD2Ka9J7igeg2B/WKkc2luLYp0cmqaBnwiLSDJYO6be50gaPKy
	savmEeuJ3aNr58CKZ+69b6DPpNKXwvZr98iK96PMKo6caNaLlgMQ58SZDYxTb4/RHuvvtU
	L8yRNXZ92kg7lyGIFClxma7tvpovnXQhKYhnDBiT6FmjKg2w8MUivIzm4IkzN8PrQP4ZXm
	N1CPlfBVI0z7M7FZaIHFW+qAhCW2ZFrR+pvE2ncElyLHC2S2Oo/sHsTTyrt63SguKPTJeT
	g4Vikm9SgCtFp+80x95VRHvsnVdrSU1TJiaaMAaVHDnx2xdkmoUjueXjCwtycA==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Fri, 02 Aug 2024 18:09:59 +0200
Subject: [PATCH v9 14/17] drm/vkms: Drop YUV formats TODO
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240802-yuv-v9-14-08a706669e16@bootlin.com>
References: <20240802-yuv-v9-0-08a706669e16@bootlin.com>
In-Reply-To: <20240802-yuv-v9-0-08a706669e16@bootlin.com>
To: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>, 
 Melissa Wen <melissa.srw@gmail.com>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mairacanal@riseup.net>, 
 Haneen Mohammed <hamohammed.sa@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
 rdunlap@infradead.org, arthurgrillo@riseup.net, 
 pekka.paalanen@haloniitty.fi
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, jeremie.dautheribes@bootlin.com, 
 miquel.raynal@bootlin.com, thomas.petazzoni@bootlin.com, 
 seanpaul@google.com, marcheu@google.com, nicolejadeyee@google.com, 
 Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=881;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=Ji1Dob1J5G/v0m+OtcxBdGyR/6s9qdXv8iTJqYtkSqI=;
 b=owEBbQKS/ZANAwAIASCtLsZbECziAcsmYgBmrQTbKIk7q/I0MoTj7k+bL/K60avtVyb6k45vA
 F6vsy908UuJAjMEAAEIAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCZq0E2wAKCRAgrS7GWxAs
 4mjbEACdkCMIg5RS2lS+7m8nRDQu9ANky2ZL1oKre2beCDPr7nQkGWE9lu6mMs83UEtAZ63+4x0
 Zl9WwQRldMKlGxq3OP2qlcHiBLqF/IXPSPyPMy17qt4N5IBGfzh9JzdWWsL7+Ga/UUKUqIgmp9M
 P3lk16P9DnIscE7FzLX3PkQyA3S75At2Qlf0pRIR1PILPhMyiBVahhvmVn99N82E/VKjEseAm2L
 ym3eGzgb+m4aZ9ncJ/xcnBcIIf/AlKiokkNZtwzjM6qiq8jUg4+1YYv897H7JWRefgztRvR/dKX
 NTOXiDz2x+9P5Bdws1uaNA46PFtl5l8ZVQfycQfy8DFfFBjamqXE1PRceQvCLtNUkFXADO4Idfz
 8GxZPcXSAAbE/87fA3L++mTQHHQrVp66GwiXj1ihqXbHRXuGxZpTXpc4PzkyKvMzEVNRNlK8i0q
 43pA5CaxTlyo1TgWfxPOe5hf4baj8oK3Ri15P7x97eV27iLqV6dxV7YRuqf5hw1DxzYU5KjZCC6
 mP5F1wldDLBUTtdcByNxIa1I9TbMyqPgR5tpaHiHD3zRBDjyOj81VoHGWDRUYKO6n1ueVZsQais
 wPsvfIFWdzSxXHtJfh7VcjI8+KYHuZDAThINT63VJHm6wimUp3t4Omg7ZMk4LGZ0so6PuVfO5r2
 HJSKXnBcO9hrezQ==
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
2.44.2


