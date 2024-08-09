Return-Path: <linux-kernel+bounces-281352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AD3794D5DC
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 19:57:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B27591C21665
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 17:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ABA319413C;
	Fri,  9 Aug 2024 17:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="SNn7fnUG"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3872B16849A;
	Fri,  9 Aug 2024 17:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723226116; cv=none; b=JJYqjEhPMivrUOUurpYvz7y4L2eD+xdpULEuojqasNFUC0vEGcyT0vBJyLUgsVB4Ha+/aKvgaKMBF1vEfj+VzMDxSEBvKHHvYNCuV/rmAGXk5GFk/SyVOiwKlGKi/r7izMmy8fxl58QsSspVQUtf7ULxRDYzHdCU1P2ga03spYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723226116; c=relaxed/simple;
	bh=rZOSJb9lfOqVrCbd/HY0ghVUJgRRMtkqU90QpsSgK5E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=k2B01/iSSsrotpgdjMMt6kqrZ2mYu/2cy+ot4QX3QvZnco0KWLR8LGWi1HiIlx9SFZA6H9vbffE4NBPgyzooMw/B1os+uKHYGgO/l4bHZqj4TUerrrdTWZ8HJgkNUHKJSKyXVDyP5bHd3ZTiOT/ckJnReu877J8AHMre1XQl94Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=SNn7fnUG; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id CD3C4FF80E;
	Fri,  9 Aug 2024 17:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1723226112;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nuZLqDhbRxZyFl4sZYfc726XqKnvDZ+QCn+mY1H6AVo=;
	b=SNn7fnUGehKVONU15RAo5kZ/IF3bZDnDzbLFjbWgn+UYWYGeP7YRmUW/evvVO0f3pAxahM
	Oa+nRbAMz8YhCvUYBVBeLtFTgY0nWRz/6GPvvN2CABZco/fB19V/WtNagOFfXvXiVd6yjR
	Pl7sO2tBD5YEvcfP9vF2bqR9/n6p8gkxNtUV6c1c0awXnA0UbeGtktMUDv3cE+VAp2qT57
	zx/sK/rcIfZeFN6Z+nzGyGeNNyYupcdrjo4cEiP3bVImNOoo9WcdUqqmwh0hwnRizJMI/C
	zC5Tp1VVA6/i5/D/UeHXkRSfQA6hpOS9lAYioZmDVmbw83+UHYxtz10x8jqZig==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Fri, 09 Aug 2024 19:54:54 +0200
Subject: [PATCH v10 13/16] drm/vkms: Drop YUV formats TODO
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240809-yuv-v10-13-1a7c764166f7@bootlin.com>
References: <20240809-yuv-v10-0-1a7c764166f7@bootlin.com>
In-Reply-To: <20240809-yuv-v10-0-1a7c764166f7@bootlin.com>
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
 b=owEBbQKS/ZANAwAIASCtLsZbECziAcsmYgBmtlfr+iFGUcMsiIsyg9/BpXreo06y/ptqMsbQE
 j2f0gEhQuOJAjMEAAEIAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCZrZX6wAKCRAgrS7GWxAs
 4rDTD/0XBtpjZlBjaUNdMhnzcSFf6SznpchqRUGBV0zujW1csNfqfslS2J1MtIQG2a9p1eVXuC9
 BfXsejooOJ8SC9y4QK89z8fzwKo5u2zdXxKEL4Sb9YIv4Y3PwSSNbYjU/rvvXLu2AmympGH013V
 mpVvUJpZoI/BkQIKUBqepj5hh7uP5nPTpNxKUCPUZHrRZbM8pY/uAvmTQmFvYuaYSrQC/9UY+aq
 bQlm4CD1sm9d+M0bzW2aTquZE+W5tpnQSOEcZ/Skzj3gBontiZogMHnLwE6z9Kpv+dL1oCH/gNd
 hKmuCJ/BRjii5t2tDfoG19+rGzK2mYjmRb/FPg0OWT8tJG42jG6XK/KXQBZJbwxfLpGJ8H0Y7z9
 nXEgT/RlBFLsUljz6N812gbtOOJ+JXUargiFx0Iygyq/b5oQWpA6QwIVfcqjS2mHwNJ1bkTiP0+
 w4lTpvkze2XFA7t8LvvAI9RGHHAHeZDJg2lSsimXgCwc/EUxpTIxP3mrT/APGeYWAMLEm9/s9Fe
 8WEPy92CzzOwy9+uzYyk/PDCl2aNJ44VHjYUOcNgquIHu0K21rgTGffocXDFlI21N569J9sFj29
 0UWtwqq7iIX3Geb8+9ScCb9YYfdqWPHkU12nh4pHjI0yyRNs9UPsnaPurj1Govsqrosfl4MO8L1
 P6ciKtjL3bEaB6Q==
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


