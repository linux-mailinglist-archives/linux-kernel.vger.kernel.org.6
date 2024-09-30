Return-Path: <linux-kernel+bounces-344363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 284C098A8B8
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 17:37:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9CFAAB219F0
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 15:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CDEC19CC1B;
	Mon, 30 Sep 2024 15:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Oa6Stl64"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFBEE19C574;
	Mon, 30 Sep 2024 15:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727710392; cv=none; b=LVvUaGuO6cqjw21KJ2VDiY8IlnuqnuLMHcVHf1TdPvrVyQeeWjun6i1cZwjbPC4bRHnLNvz1mo5R3nh9mp9TzZm4zpCvMEw8Vm4LtOLVitkgD36p+KOqlWhGaxZgZVnA5M7rtJJ3j83DTD35dmMkqSHUk2txVq/IeQXnRx3p9oQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727710392; c=relaxed/simple;
	bh=OY3WebhRv0aeGADgqvUb4/UTEnKrmR0RzKDlWJXZa2E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=U21u7QXJcVpPoLtf/jW0U7P4J9/6AFkY6LXcMVfux6ZX+ySQiMRyUiBaQw3iVSMHiSVVe6M+i9TZBqEfMJDf2T0o7dtThGG/bMU/TguEs70Uq/4VYGMSiiLaoTDf8GMcfHnkD6y12P3QPGDgkWwABiuXKS3pPD2toeiK4mMmZQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Oa6Stl64; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id DAF6240002;
	Mon, 30 Sep 2024 15:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1727710389;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hsQ2CTA2pljllkiENrEWMPdAOoEF3CDQQvjJFAj8G3E=;
	b=Oa6Stl64jTk6jv2DwNuaOnzTX59OBAhDQLe1mZGTedF0TAYJz/yQJahT1PFe1VgtUkaY5L
	08Zaj/VXhKj64j1EIbzmWJ5jgxu6K7wfbVnPDzDwS8Nj2rEUpLQswOlSiaBqHQl4JUbeK+
	hx/1yhragi8D4polubNgmU1+hqZQm/nBogSKsWaldW9VjFrrMOZM558/WvBvKAPG1FmgQN
	aLwsZaLueES58huOq9V4/pExRcrEsEXGUEZ3W4XOVD0g0qwpoUHMGAUQnsOGWYx+KPpBOL
	cbq3/5yi7d1hJ7gVmXlLGwqYXEoRUra0UEPnOSDJX3FWNKHOxkpvX4zoYrar6g==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Mon, 30 Sep 2024 17:31:52 +0200
Subject: [PATCH v11 12/15] drm/vkms: Drop YUV formats TODO
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240930-yuv-v11-12-4b1a26bcfc96@bootlin.com>
References: <20240930-yuv-v11-0-4b1a26bcfc96@bootlin.com>
In-Reply-To: <20240930-yuv-v11-0-4b1a26bcfc96@bootlin.com>
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
 b=owEBbQKS/ZANAwAIASCtLsZbECziAcsmYgBm+sRw343Vaj2Iumq11WgviSJGj3zkNoVfohiNT
 qdz9KVUqRaJAjMEAAEIAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCZvrEcAAKCRAgrS7GWxAs
 4glKD/4mZuw+3SRXem2zT235pwvh8vL/tWupHQ5xcG+H/jViTi0aqn5mI3MmpUeGHFD0yTetFIy
 70kg08BsCX2H5IwLTJlKX9wHqmzUljMSYjTz//T+Orv8rXL2wnwcDcAAIn18nwOuNcU2REtWEJx
 p3OYXxXwi04HIgOLMql/Z3HEN+0RzGFWcPh/Kns7SCKUVJxmg4yQ/00qYafkWcyYNuQsU58h6ew
 Y1yBWlYloCnBlCIIbzf9fUtN8OPqTq+cHJYta08qRNv0M9YMoH8AXkEGMM+StTzjVMCjT1IJcvy
 //UbwRZ3xhtjHfhQdXRnlEHpQpf+mQC0+ojnPJwVlNjaTI1utKRhfygBAZQGM4B7/RVqGwW90q6
 zGj0qRimkcE6YSF3zQpFEy9ncWdvI9TuLytfN1PhSlmFDk4EYxfCaeqbkFRwvl4AXfK0nPF0iIc
 h1Mbz84DqopKw9pikv6Srj+oEQcA7YJrVBI43BEgIuzWQYxsf56IKGg0ht1oeb+bZM0QI+hsfdn
 7qWmKaqtrVGtY+uNlIWgcqPej3HrHkN0vR39azOHXkDclXgGk7ivq9nwBCdaoWCn5tDDwA+1Siq
 J//1osRl3D8Q6Ok6Ke+QdchMVlmeIZHjswd6zYpPrismQh4KhpdoMGTEPCleWL/Ssodk41L6v0k
 vvhNxKmwfFG2HDw==
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


