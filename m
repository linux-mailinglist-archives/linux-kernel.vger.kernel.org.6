Return-Path: <linux-kernel+bounces-353863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C99E79933C6
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 18:47:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF78D1C23B4B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 16:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C0681DCB2E;
	Mon,  7 Oct 2024 16:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="VQ43bJmw"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2BB41DC75C
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 16:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728319594; cv=none; b=ZpfDMoGKlxGIZpyUpGfK309zJPgHa4S71ySWjbKT1Pqb9cHEwYEaJQ9XOe1D32fns2UoO9UtQ9vKyh5f16KGkYpG6fRVlnYCfpeWgRGZLNyTTaC4pAeB/vDiY3B8irsyd5xHDh9sm9CJh+2gvXvxqS7+J3MpFRIg+CEQp192q4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728319594; c=relaxed/simple;
	bh=y8C70ewoTgGfHL96TQe4gJLZQgBlDJaqpUWN8xMc2SM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RRMiEqMHXF75D2gy5i5rv4ov1vzQRtKqkcU916H4w5iMIoPEX1SxPVXAohE55HYfmognhVpI1HurpE9yiTjlulX8zPuSi5SzTrQj8t5ku8YHacoGnA35pZEEhO1N8bCLtfvWX0CT4ZC3UXAvhyKDOOVqwoQJaZ1UYYkJ1KWqaJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=VQ43bJmw; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 80DA04000E;
	Mon,  7 Oct 2024 16:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1728319590;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xUqVo+rsIarUdQ9nThu6rtZixqT2ecV/BMOIPH+GeZk=;
	b=VQ43bJmw9T0aDcfHRC638iVpqfF9uGkwF1M0ImSukWgJvlAi25kbsoRV+//0eqwO4RonjN
	gUD41nqGtZCBCIzxzhX1OLg8HlPfjurY8+C+/aAIT8wtQe7xhI3rIrHK8eWpDKXE+ZhVt7
	CZF47EorieU6Qc5Jik2AqffI4DjHMAohQrybnXlJgxvOcBzz5fbPGwW5x8jAMYoD8zfPes
	vXRHiAKaIbZxgLzpgsbNqIqHp/asTX5URqzwXzC2k4Lx/lUiOEvqqrw6Dcjy/kz6V7bjfM
	meVCxpOar1xcFZM3lX59nPBDmm6dsAaGxH+DnfEDScSOnPMPuifzA3CCNXetUQ==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Mon, 07 Oct 2024 18:46:13 +0200
Subject: [PATCH RESEND v2 8/8] drm/vkms: Add P01* formats
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241007-b4-new-color-formats-v2-8-d47da50d4674@bootlin.com>
References: <20241007-b4-new-color-formats-v2-0-d47da50d4674@bootlin.com>
In-Reply-To: <20241007-b4-new-color-formats-v2-0-d47da50d4674@bootlin.com>
To: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>, 
 Melissa Wen <melissa.srw@gmail.com>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mairacanal@riseup.net>, 
 Haneen Mohammed <hamohammed.sa@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Simona Vetter <simona.vetter@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, arthurgrillo@riseup.net, 
 linux-kernel@vger.kernel.org, jeremie.dautheribes@bootlin.com, 
 miquel.raynal@bootlin.com, thomas.petazzoni@bootlin.com, 
 seanpaul@google.com, marcheu@google.com, nicolejadeyee@google.com, 
 Louis Chauvet <louis.chauvet@bootlin.com>, 
 20241007-yuv-v12-0-01c1ada6fec8@bootlin.com
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1885;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=y8C70ewoTgGfHL96TQe4gJLZQgBlDJaqpUWN8xMc2SM=;
 b=owEBbQKS/ZANAwAIASCtLsZbECziAcsmYgBnBBBdO3f55XEK9pnuYa/9GHdQXPRaM2/n6xGoY
 w5U4c8bFGWJAjMEAAEIAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCZwQQXQAKCRAgrS7GWxAs
 4kmjD/4t1rVvULWoAs9Df8w8312noBCoUn3740HZi9Db+/+PZcT7UcwaGQZgoHtV5Ti2z20Q98w
 xcGrlUDYrkQA6eB6+pK0DlhPtHpKq2ufLkZc4CGr2689us1KzjK8dcTy1BGdZo2EsUv4OQ+at0s
 lgz1KhAhcZ7al0sYIdG/JUR/rLt/S5DmWFlrkilTk+XyC1UKQIGLlutrcMYm9xAzdLA3DXUCNBd
 7GfNJ97UFjL11NjxQ67Y46bTqkiLj8dwqp5TlPlmBmoWh4J3UVIllHVPYj6qC5JiNQr5QEz62cl
 W7mbeVGSpZg6vEPmR97nGvMXsFYIZ1UQsSnh7n2wH+14PjSSJdv0MDcSm1oc8/hJeiykKRV9E4V
 QVLNLHNX2nkX2EOPuE26N7A36cTi9gtcNAra/8OyXCxyLrPeMAj7giw3Rf885Lf0yisRpPxw665
 4qnVkFEo/WeXojKUwhFrvgbXzjjmelHOnfmLccEUwRqjQT+KmXC+ilk3jg8i0/o+RIUtuvExLkA
 MqPWZbtWo5m8wQXQN28urIVmG7SVRnBFuq16/oPVIZJrewDTDzcsGhejYkGnVbMsc0D2XgRL0gX
 E0ehXiIi7VpoI9fLM0ahFWXlEk7BK5txA11KuGFGaVom6jo3nKZ2ITJvkQKmMgiMbOs+nRpsB5H
 +et8tHpH1AoJfag==
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
X-GND-Sasl: louis.chauvet@bootlin.com

The formats NV 12/16/24/21/61/42 were already supported.
Add support for:
- P010
- P012
- P016

Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 drivers/gpu/drm/vkms/vkms_formats.c | 7 ++++++-
 drivers/gpu/drm/vkms/vkms_plane.c   | 3 +++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vkms/vkms_formats.c b/drivers/gpu/drm/vkms/vkms_formats.c
index 1cc52320475d..d77718d8e01d 100644
--- a/drivers/gpu/drm/vkms/vkms_formats.c
+++ b/drivers/gpu/drm/vkms/vkms_formats.c
@@ -535,7 +535,8 @@ static void function_name(const struct vkms_plane_state *plane, int x_start,			\
 
 READ_LINE_YUV_SEMIPLANAR(YUV888_semiplanar_read_line, y, uv, u8, u8, argb_u16_from_yuv161616,
 			 y[0] * 257, uv[0] * 257, uv[1] * 257)
-
+READ_LINE_YUV_SEMIPLANAR(YUV161616_semiplanar_read_line, y, uv, u16, u16, argb_u16_from_yuv161616,
+			 y[0], uv[0], uv[1])
 /*
  * This callback can be used for YUV format where each color component is
  * stored in a different plane (often called planar formats). It will
@@ -728,6 +729,10 @@ pixel_read_line_t get_pixel_read_line_function(u32 format)
 	case DRM_FORMAT_NV61:
 	case DRM_FORMAT_NV42:
 		return &YUV888_semiplanar_read_line;
+	case DRM_FORMAT_P010:
+	case DRM_FORMAT_P012:
+	case DRM_FORMAT_P016:
+		return &YUV161616_semiplanar_read_line;
 	case DRM_FORMAT_YUV420:
 	case DRM_FORMAT_YUV422:
 	case DRM_FORMAT_YUV444:
diff --git a/drivers/gpu/drm/vkms/vkms_plane.c b/drivers/gpu/drm/vkms/vkms_plane.c
index 0fa589abc53a..03716616f819 100644
--- a/drivers/gpu/drm/vkms/vkms_plane.c
+++ b/drivers/gpu/drm/vkms/vkms_plane.c
@@ -41,6 +41,9 @@ static const u32 vkms_formats[] = {
 	DRM_FORMAT_YVU420,
 	DRM_FORMAT_YVU422,
 	DRM_FORMAT_YVU444,
+	DRM_FORMAT_P010,
+	DRM_FORMAT_P012,
+	DRM_FORMAT_P016,
 	DRM_FORMAT_R1,
 	DRM_FORMAT_R2,
 	DRM_FORMAT_R4,

-- 
2.46.2


