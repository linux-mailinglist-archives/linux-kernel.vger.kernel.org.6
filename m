Return-Path: <linux-kernel+bounces-281346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE8F794D5D4
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 19:56:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 867502820A4
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 17:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6BFF167DB9;
	Fri,  9 Aug 2024 17:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="noe8nZwN"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E901474C3;
	Fri,  9 Aug 2024 17:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723226110; cv=none; b=g5aO6UbHRnlf80Ugcxi/ZLJAz+JuWQpWav/O6CgdvL6tZm5+R2P9PrLpAv6iKA3zSIUfbKSdKwGv53U8NDP3VtzFhurrHExI9VU/ZJ4KJneFHa0CYJMXSa7Y/nJcGbAG/FqRykvXsGkLyD/SBlUR/q9tlYP+O9J/LdNvuL5d5Oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723226110; c=relaxed/simple;
	bh=67AzauCTT9V030b8lHOORZDJ/apjJFt/9Y/QoLVErGQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OoUmLAuJiHFdPTX+tYfCRx+ogC9uZWRCkyD0yy8uCtMzjGZcLTuZ9efrWhOf1EODgC9wTH/xCoDthDH76oGagpKc8JiFTb/UWPBlaq3KJIlfmjVKemPB1Ch4hzCOW79L80dKIqyb9mbtyycUbZ12qEDRMdZmOusd8XX9ZJUQNMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=noe8nZwN; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8327EFF806;
	Fri,  9 Aug 2024 17:54:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1723226100;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yjDm1L5O4ZvSA60vA3nCHfi52fzBA7+F6RbZjFt/Lb0=;
	b=noe8nZwNlvNw0/Co0LuV4jgnWIg8U2vYi0KwmUCbQuOW8Zh55hI5FrksOL3JELzehEaYje
	BwoziCbMEPzkbt5N0ro/1s6cT5vu1QGQnB3GNJiIhH/bHwpHbZr7mqr8UcH8KI12AzgCgp
	qpAdR9w+cpOxGjsP9xn5MPQXCxdHMl/S78h7OCdPmLMgOpy60GscZ6kjSED+pS/FHtB526
	voZsE83EYju2h5WKSZlIhTodRLJ4bCZ6hcw6hL6/HuYc9Ms4OrDO5NRiip7W2BnZLwrWGB
	p0AQxHxk6eF+phXfXpfRwetc7OCOMGnFDo9CnldNMYmBr+xvMiUY9dUxGviJtQ==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Fri, 09 Aug 2024 19:54:44 +0200
Subject: [PATCH v10 03/16] drm/vkms: write/update the documentation for
 pixel conversion and pixel write functions
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240809-yuv-v10-3-1a7c764166f7@bootlin.com>
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
 Louis Chauvet <louis.chauvet@bootlin.com>, 
 Pekka Paalanen <pekka.paalanen@collabora.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=7624;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=67AzauCTT9V030b8lHOORZDJ/apjJFt/9Y/QoLVErGQ=;
 b=owEBbQKS/ZANAwAIASCtLsZbECziAcsmYgBmtlfpZnNbFXQXTwfBATfMndlT3t7nkqM+l0Xx2
 H//HasAUyGJAjMEAAEIAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCZrZX6QAKCRAgrS7GWxAs
 4gNkD/9lIl3l67yGS4zksAf+2sxxCaRK5GIwh3rprfLEm0QOgSjbZr3i+0ZX2z6S25a8pE2YIRB
 ZFxYQcdn/Mjl8Vdw7XLkPdFU+LakiYmL7vBXr14XCs2JVwBRNaf72HdTTBaKQZAdvDHE3JOtAP+
 Fxvfl0EblIF2hbvxO7iflzcua0+vd6m8VRk21HGTUAp8D4wRJ6veU5CPUrRCLl/5rX+rTajp0E7
 LT/a2smaBozeWSj4/w6HzF/yuGFwp10pjfwKI+hLuMKZap1uGvNeBXDMy0EfcN7yMQw/KU/RE+L
 xjCzNfY+gvgRXQGvr34Rpn1IFX+KYxbOF8UJpbY0kC+yip5/hEk4v/U5/1IRzUPJtU6JJmn3rKS
 gO6X1daAPvEutyS3hVRoBFszwACtLfkd9tRdf3b6ZjTWk5XaZpZ7NK/QbJbOeC64M/OWw/TslLO
 JuW89HXWDxsgjS9JakJhyS76TayTjTzLTlogaQdGILQZj4v6IPmGK1nZp1KzsL4e3z+EBrPqAVP
 T9YOuC/9YIf4Ak95RP6oL4TzYXt6ehE/p94AiHS2HDc2bwL2bh/oQMsqhGUBaEYqF63yZQ0C3sn
 pa4yy8AjVxK+X3lfc0YD+4BhMa/xAkUHDyr1B9MBTi+s9Eaj2F01qXyALjHZ2f5JQrUBbQnWOMW
 EZvulsi3e1CCiCw==
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
X-GND-Sasl: louis.chauvet@bootlin.com

Add some documentation on pixel conversion functions.
Update of outdated comments for pixel_write functions.

Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
Acked-by: Pekka Paalanen <pekka.paalanen@collabora.com>
---
 drivers/gpu/drm/vkms/vkms_composer.c |  7 ++++
 drivers/gpu/drm/vkms/vkms_drv.h      | 15 ++++++++-
 drivers/gpu/drm/vkms/vkms_formats.c  | 62 ++++++++++++++++++++++++++++++------
 3 files changed, 74 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_composer.c b/drivers/gpu/drm/vkms/vkms_composer.c
index c6d9b4a65809..931e214b225c 100644
--- a/drivers/gpu/drm/vkms/vkms_composer.c
+++ b/drivers/gpu/drm/vkms/vkms_composer.c
@@ -189,6 +189,13 @@ static void blend(struct vkms_writeback_job *wb,
 
 	size_t crtc_y_limit = crtc_state->base.crtc->mode.vdisplay;
 
+	/*
+	 * The planes are composed line-by-line to avoid heavy memory usage. It is a necessary
+	 * complexity to avoid poor blending performance.
+	 *
+	 * The function vkms_compose_row() is used to read a line, pixel-by-pixel, into the staging
+	 * buffer.
+	 */
 	for (size_t y = 0; y < crtc_y_limit; y++) {
 		fill_background(&background_color, output_buffer);
 
diff --git a/drivers/gpu/drm/vkms/vkms_drv.h b/drivers/gpu/drm/vkms/vkms_drv.h
index 8ac320564334..d6851f1f9c38 100644
--- a/drivers/gpu/drm/vkms/vkms_drv.h
+++ b/drivers/gpu/drm/vkms/vkms_drv.h
@@ -25,6 +25,17 @@
 
 #define VKMS_LUT_SIZE 256
 
+/**
+ * struct vkms_frame_info - Structure to store the state of a frame
+ *
+ * @fb: backing drm framebuffer
+ * @src: source rectangle of this frame in the source framebuffer, stored in 16.16 fixed-point form
+ * @dst: destination rectangle in the crtc buffer, stored in whole pixel units
+ * @map: see drm_shadow_plane_state@data
+ * @rotation: rotation applied to the source.
+ *
+ * @src and @dst should have the same size modulo the rotation.
+ */
 struct vkms_frame_info {
 	struct drm_framebuffer *fb;
 	struct drm_rect src, dst;
@@ -49,9 +60,11 @@ struct vkms_writeback_job {
 };
 
 /**
- * vkms_plane_state - Driver specific plane state
+ * struct vkms_plane_state - Driver specific plane state
  * @base: base plane state
  * @frame_info: data required for composing computation
+ * @pixel_read: function to read a pixel in this plane. The creator of a struct vkms_plane_state
+ *	        must ensure that this pointer is valid
  */
 struct vkms_plane_state {
 	struct drm_shadow_plane_state base;
diff --git a/drivers/gpu/drm/vkms/vkms_formats.c b/drivers/gpu/drm/vkms/vkms_formats.c
index e03470879ae9..2a0fbe27d8b2 100644
--- a/drivers/gpu/drm/vkms/vkms_formats.c
+++ b/drivers/gpu/drm/vkms/vkms_formats.c
@@ -9,6 +9,18 @@
 
 #include "vkms_formats.h"
 
+/**
+ * pixel_offset() - Get the offset of the pixel at coordinates x/y in the first plane
+ *
+ * @frame_info: Buffer metadata
+ * @x: The x coordinate of the wanted pixel in the buffer
+ * @y: The y coordinate of the wanted pixel in the buffer
+ *
+ * The caller must ensure that the framebuffer associated with this request uses a pixel format
+ * where block_h == block_w == 1.
+ * If this requirement is not fulfilled, the resulting offset can point to an other pixel or
+ * outside of the buffer.
+ */
 static size_t pixel_offset(const struct vkms_frame_info *frame_info, int x, int y)
 {
 	struct drm_framebuffer *fb = frame_info->fb;
@@ -16,18 +28,22 @@ static size_t pixel_offset(const struct vkms_frame_info *frame_info, int x, int
 	return fb->offsets[0] + (y * fb->pitches[0]) + (x * fb->format->cpp[0]);
 }
 
-/*
- * packed_pixels_addr - Get the pointer to pixel of a given pair of coordinates
+/**
+ * packed_pixels_addr() - Get the pointer to the block containing the pixel at the given
+ * coordinates
  *
  * @frame_info: Buffer metadata
- * @x: The x(width) coordinate of the 2D buffer
- * @y: The y(Heigth) coordinate of the 2D buffer
+ * @x: The x (width) coordinate inside the plane
+ * @y: The y (height) coordinate inside the plane
  *
  * Takes the information stored in the frame_info, a pair of coordinates, and
  * returns the address of the first color channel.
  * This function assumes the channels are packed together, i.e. a color channel
  * comes immediately after another in the memory. And therefore, this function
  * doesn't work for YUV with chroma subsampling (e.g. YUV420 and NV21).
+ *
+ * The caller must ensure that the framebuffer associated with this request uses a pixel format
+ * where block_h == block_w == 1, otherwise the returned pointer can be outside the buffer.
  */
 static void *packed_pixels_addr(const struct vkms_frame_info *frame_info,
 				int x, int y)
@@ -52,6 +68,13 @@ static int get_x_position(const struct vkms_frame_info *frame_info, int limit, i
 	return x;
 }
 
+/*
+ * The following functions take pixel data from the buffer and convert them to the format
+ * ARGB16161616 in @out_pixel.
+ *
+ * They are used in the vkms_compose_row() function to handle multiple formats.
+ */
+
 static void ARGB8888_to_argb_u16(u8 *src_pixels, struct pixel_argb_u16 *out_pixel)
 {
 	/*
@@ -144,12 +167,11 @@ void vkms_compose_row(struct line_buffer *stage_buffer, struct vkms_plane_state
 }
 
 /*
- * The following  functions take an line of argb_u16 pixels from the
- * src_buffer, convert them to a specific format, and store them in the
- * destination.
+ * The following functions take one &struct pixel_argb_u16 and convert it to a specific format.
+ * The result is stored in @dst_pixels.
  *
- * They are used in the `compose_active_planes` to convert and store a line
- * from the src_buffer to the writeback buffer.
+ * They are used in vkms_writeback_row() to convert and store a pixel from the src_buffer to
+ * the writeback buffer.
  */
 static void argb_u16_to_ARGB8888(u8 *dst_pixels, struct pixel_argb_u16 *in_pixel)
 {
@@ -215,6 +237,14 @@ static void argb_u16_to_RGB565(u8 *dst_pixels, struct pixel_argb_u16 *in_pixel)
 	*pixels = cpu_to_le16(r << 11 | g << 5 | b);
 }
 
+/**
+ * vkms_writeback_row() - Generic loop for all supported writeback format. It is executed just
+ * after the blending to write a line in the writeback buffer.
+ *
+ * @wb: Job where to insert the final image
+ * @src_buffer: Line to write
+ * @y: Row to write in the writeback buffer
+ */
 void vkms_writeback_row(struct vkms_writeback_job *wb,
 			const struct line_buffer *src_buffer, int y)
 {
@@ -228,6 +258,13 @@ void vkms_writeback_row(struct vkms_writeback_job *wb,
 		wb->pixel_write(dst_pixels, &in_pixels[x]);
 }
 
+/**
+ * get_pixel_conversion_function() - Retrieve the correct read_pixel function for a specific
+ * format. The returned pointer is NULL for unsupported pixel formats. The caller must ensure that
+ * the pointer is valid before using it in a vkms_plane_state.
+ *
+ * @format: DRM_FORMAT_* value for which to obtain a conversion function (see [drm_fourcc.h])
+ */
 void *get_pixel_conversion_function(u32 format)
 {
 	switch (format) {
@@ -246,6 +283,13 @@ void *get_pixel_conversion_function(u32 format)
 	}
 }
 
+/**
+ * get_pixel_write_function() - Retrieve the correct write_pixel function for a specific format.
+ * The returned pointer is NULL for unsupported pixel formats. The caller must ensure that the
+ * pointer is valid before using it in a vkms_writeback_job.
+ *
+ * @format: DRM_FORMAT_* value for which to obtain a conversion function (see [drm_fourcc.h])
+ */
 void *get_pixel_write_function(u32 format)
 {
 	switch (format) {

-- 
2.44.2


