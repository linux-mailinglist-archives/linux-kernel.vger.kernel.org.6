Return-Path: <linux-kernel+bounces-418457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CCD19D61D6
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 17:15:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA867283108
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 16:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C18B1DF99E;
	Fri, 22 Nov 2024 16:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="e9QHAu4v"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 635BC1DF25B
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 16:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732292120; cv=none; b=kLZGuI4pT645TASRgdAKkn2L75Om0nXS2CkhJc07gQsFQ2XvEqQexAnXqzamXlQMlUU0T1mbv9y5XnqsOwg9Fs0vWHOJNnG7X1hbMmJ3HzmXuBACgX26iBLszBbtX5+Gu+I/lFxUWpJIbo3yx8/+N3WSrrgb9M3ECWDj67wp3lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732292120; c=relaxed/simple;
	bh=KCcQhPVz6PUxTkptUubEsPv0X3QW8k3JN+SJqqNicp0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eI8y07GhaYdy4ZD7eGhu2qfeMarKuqlb3/LDVHVfe3TFE6JCuk8P2bFLtIjXE0jHPfiDdyOk4sAOOwIDbr1AgPqN2gBbScXe74x58mTVSklEP+PxnWhu+rd/Rru9qy1dTyZv9mu+Yn9xjbfkKdrPRV2II2vDk3leTQeMTzt5kD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=e9QHAu4v; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4DEEE1C0006;
	Fri, 22 Nov 2024 16:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1732292110;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LyuZSeQhWN8yZC/+93Agwlt6oIM4sNXPX8BuSmxPT1g=;
	b=e9QHAu4v5qpnH3/4lofPsTsiGR54lTrJosUcvFmA560TtHxRWVRC9Ap5u8fA3jkzjECjPP
	YToqXZqmHBWz0PeSEmkAe4GpSvtKP9CGDHiJOWUyHuShkb7X72qBcmOYwgMzza4cBZDxcU
	s/V5+AzIN6DzMYtGSk89tQMfOeXLNRbSokIcSuzaiKVlPCBpZo7nyeybElUuCDdi4RJnXt
	83d+hIYo7UtKwE5+DkqETIPJ2oYvorQU8ccxxCOtcyce5PJ4EtYWYHV/g9fMc+uBqSR7uG
	AdhM5HOWEiwVmlIsvgoQEPWwCS2GITAeEoCYFVO0n+TzTwcyWvatgtBKpeg5aw==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Fri, 22 Nov 2024 17:15:03 +0100
Subject: [PATCH v14 3/7] drm/vkms: Drop YUV formats TODO
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241122-yuv-v14-3-e66d83d28d0c@bootlin.com>
References: <20241122-yuv-v14-0-e66d83d28d0c@bootlin.com>
In-Reply-To: <20241122-yuv-v14-0-e66d83d28d0c@bootlin.com>
To: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>, 
 Melissa Wen <melissa.srw@gmail.com>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mairacanal@riseup.net>, 
 Haneen Mohammed <hamohammed.sa@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, rdunlap@infradead.org, 
 arthurgrillo@riseup.net, Jonathan Corbet <corbet@lwn.net>, 
 pekka.paalanen@haloniitty.fi, Simona Vetter <simona.vetter@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 jeremie.dautheribes@bootlin.com, miquel.raynal@bootlin.com, 
 thomas.petazzoni@bootlin.com, seanpaul@google.com, marcheu@google.com, 
 nicolejadeyee@google.com, Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=937;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=iDZ/HJ7Gex8d9aGNH0HIIVbXcYQeibofjLc/H+dZBcg=;
 b=owEBbQKS/ZANAwAIASCtLsZbECziAcsmYgBnQK4HBuIoq//YMeeIKyGPMkM33ZY+HjZpEJQh3
 Bu/kYVjKMiJAjMEAAEIAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCZ0CuBwAKCRAgrS7GWxAs
 4lLgD/9x98VeLVlBYLzvcYfknylz/UYiYin/M4eKw0u3Id4wtMbCotQ97fejaUdKl5Fs3vOglBb
 eIS4U0dvS+4wR9C9OCszH8HjgNFa7G3dfwApP493zme1wQZFvf8G5PAeN/ETG5H3SBhuj1pc7qK
 9GLvtYDtxDcbAJLooSQHfGnfUa9AheIz2HaSWWuzioUtSXTXJgLZ/2z+nWReX3SRuFrabmjJA5N
 hFCn+g6CvWL94y7acnimmEa16UEkFwi0O2yTDQKRzXg7U19UXZ4TQ9SrKhIGEK42X1bVt3YYOHx
 ItQhzXqGn7eamWQP3DwvZycWHFDh2QdtvfIIDxvzTufVpEzAGU9s3WkAyBDf6G2fU8IPTg/AyeQ
 vsOLlkbMhJdzRaJh/bv8vxVL1WgWq9IvM44PbQDpxJ3yIxSeH4XXlcmAq3tdVExK9CTv8qAhGTE
 fmd645/Kl6+YPG/2R7aeBrhOgxkOXrBC9oR/pao6Z1GZZEGxgisFAbevBOyeap58NZMluMBOi/Y
 liGBT/VCq5zzrgsQ/UFlnTLUEm/fJdG4z9JcltROzNEnfTbkN0jEJCH2rTxvxtW3p9ZiIAVpyo9
 QKeJuFTppy3oSlVwTBwuKCe9U/CrDEGEDe0enVnpFBH58WRlTliKrCP250MOPcCPLEcdYImVsgs
 l+1CkE7P0l4N0bw==
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
index ba04ac7c2167a9d484c54c69a09a2fb8f2d9c0aa..13b866c3617cd44043406252d3caa912c931772f 100644
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
2.47.0


