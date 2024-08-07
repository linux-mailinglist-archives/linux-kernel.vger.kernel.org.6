Return-Path: <linux-kernel+bounces-278238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35BD094ADF8
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 18:24:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5144BB2968D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 16:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E074F13A27D;
	Wed,  7 Aug 2024 16:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=mary.guillemard@collabora.com header.b="I34VHeWI"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C76412C473
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 16:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723047006; cv=pass; b=tf0f1ZxmvYu25xRDxrNhNNhHDWd3pGijaJvO32BY4g3PwyWdxR4XHnQ7q4kkvK8/Ztr/cE4ZGNGnpAGrumeuMNjIZxrU4mExUakiuuDiudks98xJA6C7EXbsOUsgYKYFd0FWw4kR+WmTIeojLE1oK+jMjB6kW78NQkk721EXT9w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723047006; c=relaxed/simple;
	bh=qf59TgMWHnh/r9cswsLF0v8ikjSs/CC/tjyrLvL9CTk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pi32ar1uywIkwj4KWtkLCBoPt+RDOC+cg8UqodYCW3UhRf9LNrYn/eUcbIezrRlVeAyDBNfalQXb34cVERbo4R8WCXFnyStAg8j5lNeJtRyVuFE8CdUGCK26TAKkJc/AHWhvYDZgJHpRTF+PckYZ2lVX8bua9rizSOIJuKe3YWc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=mary.guillemard@collabora.com header.b=I34VHeWI; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Delivered-To: kernel@collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1723046991; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=SrUZFIBqOlA9PjeP7JGaw6mBytuA1/g1tCQ9K0peS9/dlEEHXdqRkQ/ii/bTf2r4LyaWuK1OEd8gfwxmZBd1q8IureevQ9a3j6QBvng/vIt9xuQMPsB4ww+yHjbe/tm7/KgArXoAbHXJI2vxeuLFjoB0UzclmMf5kQgA1JYFeUM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1723046991; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=2tbs4O9jIOylAwaDXXbJssc8OYMauxjaFyRX4otVCrY=; 
	b=IASfVySzRLPwcobFwcI74x1POBZJoAggtH1RcuAMPGdmlIxvBwCh8OnCjyjKNCnLwIg4FTwARrCzCSTu4K7/1aQKDbc9RgmZyVpKgPF63rC8x0IPZBMUCMPcRDqr/gZ1X7sWT9a87+2pHhRCcryRLjBuy8Ld8qi4rDygJYtgioo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=mary.guillemard@collabora.com;
	dmarc=pass header.from=<mary.guillemard@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1723046991;
	s=zohomail; d=collabora.com; i=mary.guillemard@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=2tbs4O9jIOylAwaDXXbJssc8OYMauxjaFyRX4otVCrY=;
	b=I34VHeWIv6mLg5s/P1vAemtJUOsVUP2Hlp1kE9RTukKYzM0hAPDCBoBZtYVJWN1H
	H5c1O/4XkGQM0SphHm5FQKGAHOAezCK1uKxa1JsZqHzGepDYW4hgzfnKYYNo99KmKVA
	ybSODF0377SEXB/HmnMwEzBd9gSR3Qsq/MbnqI/Y=
Received: by mx.zohomail.com with SMTPS id 1723046989747697.3393722421491;
	Wed, 7 Aug 2024 09:09:49 -0700 (PDT)
From: Mary Guillemard <mary.guillemard@collabora.com>
To: linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org,
	kernel@collabora.com,
	Mary Guillemard <mary.guillemard@collabora.com>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	Rob Herring <robh@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH 1/3] drm/panfrost: Add SYSTEM_TIMESTAMP and SYSTEM_TIMESTAMP_FREQUENCY parameters
Date: Wed,  7 Aug 2024 18:08:57 +0200
Message-ID: <20240807160900.149154-2-mary.guillemard@collabora.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240807160900.149154-1-mary.guillemard@collabora.com>
References: <20240807160900.149154-1-mary.guillemard@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Expose system timestamp and frequency supported by the GPU.

Mali uses the generic arch timer as GPU system time so we currently
wire cntvct_el0 and cntfrq_el0 respectively to those parameters.
We could have directly read those values from userland but handling
this here allows us to be future proof in case of errata related to
timers for example.

This new uAPI will be used in Mesa to implement timestamp queries and
VK_KHR_calibrated_timestamps.

Signed-off-by: Mary Guillemard <mary.guillemard@collabora.com>
---
 drivers/gpu/drm/panfrost/panfrost_drv.c | 17 +++++++++++++++++
 include/uapi/drm/panfrost_drm.h         |  2 ++
 2 files changed, 19 insertions(+)

diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
index 671eed4ad890..d94c9bf5a7f9 100644
--- a/drivers/gpu/drm/panfrost/panfrost_drv.c
+++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
@@ -69,6 +69,23 @@ static int panfrost_ioctl_get_param(struct drm_device *ddev, void *data, struct
 		PANFROST_FEATURE_ARRAY(JS_FEATURES, js_features, 15);
 		PANFROST_FEATURE(NR_CORE_GROUPS, nr_core_groups);
 		PANFROST_FEATURE(THREAD_TLS_ALLOC, thread_tls_alloc);
+
+	case DRM_PANFROST_PARAM_SYSTEM_TIMESTAMP:
+#ifdef CONFIG_ARM_ARCH_TIMER
+		param->value = __arch_counter_get_cntvct();
+#else
+		param->value = 0;
+#endif
+		break;
+
+	case DRM_PANFROST_PARAM_SYSTEM_TIMESTAMP_FREQUENCY:
+#ifdef CONFIG_ARM_ARCH_TIMER
+		param->value = arch_timer_get_cntfrq();
+#else
+		param->value = 0;
+#endif
+		break;
+
 	default:
 		return -EINVAL;
 	}
diff --git a/include/uapi/drm/panfrost_drm.h b/include/uapi/drm/panfrost_drm.h
index 9f231d40a146..52b050e2b660 100644
--- a/include/uapi/drm/panfrost_drm.h
+++ b/include/uapi/drm/panfrost_drm.h
@@ -172,6 +172,8 @@ enum drm_panfrost_param {
 	DRM_PANFROST_PARAM_NR_CORE_GROUPS,
 	DRM_PANFROST_PARAM_THREAD_TLS_ALLOC,
 	DRM_PANFROST_PARAM_AFBC_FEATURES,
+	DRM_PANFROST_PARAM_SYSTEM_TIMESTAMP,
+	DRM_PANFROST_PARAM_SYSTEM_TIMESTAMP_FREQUENCY,
 };
 
 struct drm_panfrost_get_param {
-- 
2.45.2


