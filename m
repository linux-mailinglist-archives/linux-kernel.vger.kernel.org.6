Return-Path: <linux-kernel+bounces-177301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B647E8C3C98
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 09:53:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6DB61C211A6
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 07:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D3D814A4D8;
	Mon, 13 May 2024 07:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="PJmJp52y"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E33B149E10
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 07:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715586660; cv=none; b=Gk1xQNtiD98jADs8lnwjg4tXf3fv0qAiQgKZD1TqwXT+i2C+SAaf6PI6+CMSdytmqZlLsZYM9Oxdvq4/8aT659y2UBvrwYlpJI/XAU9d8mbt+UMjXZpZxUrQX0UOqgJh8QaTk8N86ZCsAUlRc4ZBdScRcjC4BqI8kSUpfToo0b0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715586660; c=relaxed/simple;
	bh=akILSvu+vd0uaxT0kBqUrUilOOmGW8544rYfdZP+Ll0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WAD9ajvDjLoLqpSNYN22IT17uiRR9Oq1R+mLLQLKWDet2h8EFSr3m3gKifiTYy9eEtK2LY3uDpzkkrsx4/vHNYOIRqa5IJ9PcN12OLlOFowlYBMD4vpnekUh39nTDWm0n/nCJ22ddn7qbGCc9czwWKymKscCmjkP/4F72b6B1fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=PJmJp52y; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2A29820002;
	Mon, 13 May 2024 07:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1715586657;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3pbUUmy13w4guEulP+QztTkzQuy51RgJPVYnilwQVRo=;
	b=PJmJp52yTa3VBMoLB3QdVsrYKCqn35SO941YttvXPDyPvO9AhRXaTIaY5SSDQp7+cuRPCi
	XNg2hqP6w8yIcqfV+di/8z+03oNS8vHTFIUL0Kl3Noqbnfd6wZ01Rr/nJMYu/chzvJhepM
	EThrX/BxH0ZPkWlcs9TFRUiIkxnFKUyBZ/6VunSsIhwd5W+uX0H83KiWP+k3sASbCt0dVJ
	hGh3oaogAJIpYhc1UH8fHzQnlS+JL7EG0nXy7BRH1KDFSJuh3CWUNhlPP3T6WI48o4pED9
	u6eU5cSVyxkYPn106uAvJEyozsO0NbzsPDuybqdImf2jzLuWzipKWgjmCFHuJw==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Mon, 13 May 2024 09:50:35 +0200
Subject: [PATCH v7 14/17] drm/vkms: Drop YUV formats TODO
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240513-yuv-v7-14-380e9ffec502@bootlin.com>
References: <20240513-yuv-v7-0-380e9ffec502@bootlin.com>
In-Reply-To: <20240513-yuv-v7-0-380e9ffec502@bootlin.com>
To: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>, 
 Melissa Wen <melissa.srw@gmail.com>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mairacanal@riseup.net>, 
 Haneen Mohammed <hamohammed.sa@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, rdunlap@infradead.org, 
 arthurgrillo@riseup.net, Jonathan Corbet <corbet@lwn.net>, 
 pekka.paalanen@haloniitty.fi
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 jeremie.dautheribes@bootlin.com, miquel.raynal@bootlin.com, 
 thomas.petazzoni@bootlin.com, seanpaul@google.com, marcheu@google.com, 
 nicolejadeyee@google.com, Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=881;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=N9UhJoLZuEKa5YILFan7TkC9c/lglpLVoc0iCcUfoUg=;
 b=owEBbQKS/ZANAwAIASCtLsZbECziAcsmYgBmQcZEpJ3YUey+C2QjSA6iW6tV6sCnz4j0bSPLm
 7J9jJYcsDiJAjMEAAEIAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCZkHGRAAKCRAgrS7GWxAs
 4o1kEACGQv8EjpwNwm8D36/N4jUFxU9HRqnp1sIyxYROywAkyhvLLVIQtx+d5bVPgzdo8yaRigb
 0YCfB+YCNql05/pnXzey5nN6jRxqyIlRc6FJtH9u5ZcazA8ZhtfMvuaDzZereKHCKbjMm4bRebZ
 rbSa+WwER/t0oLI5GUvTN2LIsHLivyGnwfV21lRGDz192wkzc2/0tJwnU0ixR7hBa4r3ajt4Dlf
 iWh30x3W9JQKrQJNUGBqBdlliGFQI1JcHdllQY/kp/1ttcMlqnc+M/LzoLealeJ+xR3kVfvann4
 v2KMu4r6KgCUteB4dI3gf0i5bI2u9+WfH61tZIhj76I33TYxFxW2wEnUo6ZpZOAT67NvsbhFqFc
 KXDOf+Xip5tN/jcphPdLXvqdr5oCYXvAzSYCIYiekYi2NC3aI9A0qPiiu0colcKOrYtrxTNr9pU
 cZxkw5nX9NDxpBJYzEdiKG5LVGLAd4XLNdvZ2KcbA/PqDLbgspaOYUoQ0Ih9pg9kDXZFat35hiD
 wN4DRZBW4ggoal9MFo0D9BJ+z3/C/HxKIXe3LMBSo+riTHwO5hNq3le9rPUfAT401NFlgI5CDfw
 7EqRMLS1q3MG9mZkaS/WggtSEVNW3qpKuWfYjzxPO6D11RPa5gRFdUhSs+ygyv6Yd9PWDHHG3Ay
 PUkn8QxtMclXT/g==
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
2.43.2


