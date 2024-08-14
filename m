Return-Path: <linux-kernel+bounces-286128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44BF39516F2
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 10:47:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B26041F23F0E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 08:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A44D0145B2C;
	Wed, 14 Aug 2024 08:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="B6quKT3F"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8CE414375C
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 08:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723625227; cv=none; b=LzebUDtnFc2aetTnx+WVo5gtwTNoelmCEnpz0wuqxPkvKwhqh1ge1l7l1x9Fy/BL/B+2uzDnHkgf+FQbVaRgLfIuzv9X280qpjeg4SEcEg2H5qKKbjI1ZzGNreOFDN+GRL5/Z77rXru/huUc6Wqii41gvAd381N3NeGDKLHPXXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723625227; c=relaxed/simple;
	bh=aSuk2mWiTdVUJuBeR3o8G61bWGivtH+IEI1Je9+zlOk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eM8wFu1RYOn7fSSvi2tyHJTjZsEq9RuHrhcFojcGsYs2vLstai4bISn/DZcHnf0+NxezNKNx12YLY8okCnEWzrnT9Zd6tX/wRcEZ6JoreefY8Tmw/a0BnNxkAwRfRJ4EpSvFKTgqwHiamXNVaksLcTXgB1zeRSjGnSquhKn7oAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=B6quKT3F; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 15457FF80E;
	Wed, 14 Aug 2024 08:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1723625224;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vUDiBZ7QGmfDJ6NaVojAOKA60EYcBMHsx6yhqDwupvU=;
	b=B6quKT3FTCNwzUzsjCKbtUV+kJt671euyp6xqClWODszCmB8X1M4Bywq9MIM6YARiAMa/r
	E4S/0d7PeKeP6NR5pKw6b7nupik1berGNvdYNP4P3Gc/+tbyl3wr0XuCB6j44iA8rngCl7
	bhZMgu8XBxYjElF3/ZSQfVyVTIFNSaL29x0lfos+GdSCWkkDmineFia0qxQs1oiO6fWQI/
	1UWRsdXoJKYRpd18GlU0PeQyN5+nZnjVMtgHHjcwGK+MAwGA+b+tT4G8kN53muTnoAesiI
	PL5FhBbG4AzH/a+n5yMcCktOFevjFgCC+TTmEaaLJC1rFr/j7gyQrfjfd24t8Q==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Wed, 14 Aug 2024 10:47:00 +0200
Subject: [PATCH 3/3] drm/vkms: Add documentation
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240814-google-clarifications-v1-3-3ee76d7d0c28@bootlin.com>
References: <20240814-google-clarifications-v1-0-3ee76d7d0c28@bootlin.com>
In-Reply-To: <20240814-google-clarifications-v1-0-3ee76d7d0c28@bootlin.com>
To: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>, 
 Melissa Wen <melissa.srw@gmail.com>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mairacanal@riseup.net>, 
 Haneen Mohammed <hamohammed.sa@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>
Cc: dri-devel@lists.freedesktop.org, arthurgrillo@riseup.net, 
 linux-kernel@vger.kernel.org, jeremie.dautheribes@bootlin.com, 
 miquel.raynal@bootlin.com, thomas.petazzoni@bootlin.com, 
 seanpaul@google.com, marcheu@google.com, nicolejadeyee@google.com, 
 Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=6986;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=aSuk2mWiTdVUJuBeR3o8G61bWGivtH+IEI1Je9+zlOk=;
 b=owEBbQKS/ZANAwAIASCtLsZbECziAcsmYgBmvG8D2bxpdTOBZKWkasIlq9cPBEXyLdvxEs7Xa
 Ro3ieEmMo+JAjMEAAEIAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCZrxvAwAKCRAgrS7GWxAs
 4kHaEADWsuy4j3Dw9nb0hNAkqxAC+ONbsQLL6x6nPJ1JwALS6ilapqlNqRTyvgRYIb4IyWMGSGH
 RxolxgsdFNIa78HGPqJbG3Lk7QF4i2ae9ViOi1kPDye5N/mNxPw8658mrjSkrMMw8mJUFMv3jx2
 jziBG9dtzw3RAiiZ1bHutgl2KKHTe0H7VGDgnIgBDDS5gK2jDCV7HikBuZmZFSJ8e3h/dd3Qz3s
 hs6pOShZkIfpM5p6zQYNMtKy8TEKAQw93iwaS9vb+Oy+Y2j8iarGTWVcFxg7Adno6DAgn+mbEO2
 BPTAdZObIgaldHa6zGKqFnfu8GdzVi2oGD5U2OObeXo2AO579ySKT5KcUQUjJ1sX6fjdORFaiVG
 UGPnnc6ZhonwW/76Mpd/nG8yAoAUCt9LDaP6FtngZ/2LeMSH/yGl5OuabXBQvPYD8KUC8fQ/wTN
 Pl7XLSqDhP06zuBIvLt4MsfOPElcYNyTOM9vpZ6izLGoOckj/FpQRQ7uMNmwHJr9OIpwecjFd/D
 XuCiNwVhWxJJ8nTftoHVW4mkkYMeV8A4lcYk4BHBsCFa58mT5uietJwZpQhw9vK7CAmax/xB7ru
 6rQ43TkA7wLaQPIFJ7lTBSjrhUHAO250V9pYatMMKdhOJIB665AteIT6ag7I+WzdU6ceFwuFpW6
 TyqajSxxK3UY03A==
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
X-GND-Sasl: louis.chauvet@bootlin.com

Add documentation around vkms_output and its initialization.

Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 drivers/gpu/drm/vkms/vkms_drv.h    | 81 ++++++++++++++++++++++++++++++++------
 drivers/gpu/drm/vkms/vkms_output.c | 12 +++++-
 2 files changed, 80 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_drv.h b/drivers/gpu/drm/vkms/vkms_drv.h
index 3028678e4f9b..8f6c9e67e671 100644
--- a/drivers/gpu/drm/vkms/vkms_drv.h
+++ b/drivers/gpu/drm/vkms/vkms_drv.h
@@ -147,29 +147,51 @@ struct vkms_color_lut {
 };
 
 /**
- * vkms_crtc_state - Driver specific CRTC state
+ * struct vkms_crtc_state - Driver specific CRTC state
+ *
  * @base: base CRTC state
  * @composer_work: work struct to compose and add CRC entries
- * @n_frame_start: start frame number for computed CRC
- * @n_frame_end: end frame number for computed CRC
+ *
+ * @num_active_planes: Number of active planes
+ * @active_planes: List containing all the active planes (counted by
+ *  @num_active_planes). They should be stored in z-order.
+ * @active_writeback: Current active writeback job
+ * @gamma_lut: Look up table for gamma used in this CRTC
+ * @crc_pending: Protected by @vkms_output.composer_lock.
+ * @wb_pending: Protected by @vkms_output.composer_lock.
+ * @frame_start: Protected by @vkms_output.composer_lock.
+ * @frame_end: Protected by @vkms_output.composer_lock.
  */
 struct vkms_crtc_state {
 	struct drm_crtc_state base;
 	struct work_struct composer_work;
 
 	int num_active_planes;
-	/* stack of active planes for crc computation, should be in z order */
 	struct vkms_plane_state **active_planes;
 	struct vkms_writeback_job *active_writeback;
 	struct vkms_color_lut gamma_lut;
 
-	/* below four are protected by vkms_output.composer_lock */
 	bool crc_pending;
 	bool wb_pending;
 	u64 frame_start;
 	u64 frame_end;
 };
 
+/**
+ * struct vkms_output - Internal representation of all output components in vkms
+ *
+ * @crtc: Base crtc in drm
+ * @encoder: DRM encoder used for this output
+ * @connector: DRM connector used for this output
+ * @wb_connecter: DRM writeback connector used for this output
+ * @vblank_hrtimer:
+ * @period_ns:
+ * @composer_workq: Ordered workqueue for composer_work
+ * @lock: Lock used to project concurrent acces to the composer
+ * @composer_enabled: Protected by @lock.
+ * @composer_state:
+ * @composer_lock: Lock used internally to protect @composer_state members
+ */
 struct vkms_output {
 	struct drm_crtc crtc;
 	struct drm_encoder encoder;
@@ -177,28 +199,38 @@ struct vkms_output {
 	struct drm_writeback_connector wb_connector;
 	struct hrtimer vblank_hrtimer;
 	ktime_t period_ns;
-	/* ordered wq for composer_work */
 	struct workqueue_struct *composer_workq;
-	/* protects concurrent access to composer */
 	spinlock_t lock;
 
-	/* protected by @lock */
 	bool composer_enabled;
 	struct vkms_crtc_state *composer_state;
 
 	spinlock_t composer_lock;
 };
 
-struct vkms_device;
-
+/**
+ * struct vkms_config - General configuration for VKMS driver
+ *
+ * @writeback: If true, a writeback buffer can be attached to the CRTC
+ * @cursor: If true, a cursor plane is created in the VKMS device
+ * @overlay: If true, NUM_OVERLAY_PLANES will be created for the VKMS device
+ * @dev: Used to store the current vkms device. Only set when the device is instancied.
+ */
 struct vkms_config {
 	bool writeback;
 	bool cursor;
 	bool overlay;
-	/* only set when instantiated */
 	struct vkms_device *dev;
 };
 
+/**
+ * struct vkms_device - Description of a vkms device
+ *
+ * @drm - Base device in drm
+ * @platform - Associated platform device
+ * @output - Configuration and sub-components of the vkms device
+ * @config: Configuration used in this vkms device
+ */
 struct vkms_device {
 	struct drm_device drm;
 	struct platform_device *platform;
@@ -206,6 +238,10 @@ struct vkms_device {
 	const struct vkms_config *config;
 };
 
+/*
+ * The following helpers are used to convert a member of a struct into its parent.
+ */
+
 #define drm_crtc_to_vkms_output(target) \
 	container_of(target, struct vkms_output, crtc)
 
@@ -218,12 +254,33 @@ struct vkms_device {
 #define to_vkms_plane_state(target)\
 	container_of(target, struct vkms_plane_state, base.base)
 
-/* CRTC */
+/**
+ * vkms_crtc_init() - Initialize a crtc for vkms
+ * @dev: drm_device associated with the vkms buffer
+ * @crtc: uninitialized crtc device
+ * @primary: primary plane to attach to the crtc
+ * @cursor plane to attach to the crtc
+ */
 int vkms_crtc_init(struct drm_device *dev, struct drm_crtc *crtc,
 		   struct drm_plane *primary, struct drm_plane *cursor);
+/**
+ * vkms_output_init() - Initialize all sub-components needed for a vkms device.
+ *
+ * @vkmsdev: vkms device to initialize
+ * @possible_crtc_index: Crtc which can be attached to the planes. The caller must ensure that
+ * possible_crtc_index is positive and less or equals to 31.
+ */
 
 int vkms_output_init(struct vkms_device *vkmsdev, int possible_crtc_index);
 
+/**
+ * vkms_plane_init() - Initialize a plane
+ *
+ * @vkmsdev: vkms device containing the plane
+ * @type: type of plane to initialize
+ * @possible_crtc_index: Crtc which can be attached to the plane. The caller must ensure that
+ * possible_crtc_index is positive and less or equals to 31.
+ */
 struct vkms_plane *vkms_plane_init(struct vkms_device *vkmsdev,
 				   enum drm_plane_type type, int possible_crtc_index);
 
diff --git a/drivers/gpu/drm/vkms/vkms_output.c b/drivers/gpu/drm/vkms/vkms_output.c
index d42ca7d10389..36db2c8923cb 100644
--- a/drivers/gpu/drm/vkms/vkms_output.c
+++ b/drivers/gpu/drm/vkms/vkms_output.c
@@ -21,6 +21,7 @@ static int vkms_conn_get_modes(struct drm_connector *connector)
 {
 	int count;
 
+	/* Use the default modes list from drm */
 	count = drm_add_modes_noedid(connector, XRES_MAX, YRES_MAX);
 	drm_set_preferred_mode(connector, XRES_DEF, YRES_DEF);
 
@@ -58,8 +59,13 @@ int vkms_output_init(struct vkms_device *vkmsdev, int possible_crtc_index)
 	int writeback;
 	unsigned int n;
 
+	/*
+	 * Initialize used plane. One primary plane is required to perform the composition.
+	 *
+	 * The overlay and cursor planes are not mandatory, but can be used to perform complex
+	 * composition.
+	 */
 	primary = vkms_plane_init(vkmsdev, DRM_PLANE_TYPE_PRIMARY, possible_crtc_index);
-
 	if (IS_ERR(primary))
 		return PTR_ERR(primary);
 
@@ -96,6 +102,10 @@ int vkms_output_init(struct vkms_device *vkmsdev, int possible_crtc_index)
 		DRM_ERROR("Failed to init encoder\n");
 		goto err_encoder;
 	}
+	/*
+	 * This is an hardcoded value to select crtc for the encoder.
+	 * 1 here designate the first registered CRTC, the one allocated in [1]
+	 */
 	encoder->possible_crtcs = 1;
 
 	ret = drm_connector_attach_encoder(connector, encoder);

-- 
2.44.2


