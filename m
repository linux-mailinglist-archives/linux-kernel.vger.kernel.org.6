Return-Path: <linux-kernel+bounces-563154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BAE68A63799
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 22:53:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA0CB188EE76
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 21:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6217E1A5B89;
	Sun, 16 Mar 2025 21:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="L95Li512"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F1D174EF0
	for <linux-kernel@vger.kernel.org>; Sun, 16 Mar 2025 21:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742161979; cv=pass; b=ImzVUAsnWWNH4SyjRlbyXLh9xgMiYd3E6iBkM45AhHpst0uRei+3Vm3AGLsxPrQQzP5UxrM5o5sVhZLngPpJtxScHEt1CkTB/e7OoE4MSjOB3QtScYkBxYOMvdgV4z4UrtLVYL2mtIDaZsbwiaaPlBVl6gEUYxvdEcX7fdnZb4E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742161979; c=relaxed/simple;
	bh=RkJXO4BSfzEJ4DvmjKZjnmoesLG5YDlx1MR/m8qEV7M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bm0nzUj2VPj0Ei0RetugYdgsbMsO3cw0Lnz2CvlaXKmcHhYc13+RzLniCJdOjUlGTZnfGoBFOzl1BEx2ezznEcJye49ETnGuBiqP7iS80fhC2FmP/KMt6WFxaaYS4c2C3rewncTbCmOT0GBpec97F6+oVrOEMJdSUEfOH7I4Axs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b=L95Li512; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1742161950; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=QM4lk3WSFBoR0EREHCoWX1KEvAcoUUKOoyL5ae2EvA4XWQETJ8wBTD5QXXa0+SOtiv3wDmrioEM/IU7PsUJuJtiEbm9tT7m6FqdDaU4whritSi3qMOynaEGznEJl0PWsy0GSGP0ZrkLeeUqkKHTni6m5RxBI3yc/M134G2wkC4A=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1742161950; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=co/2bjOhFFI9JYAACNKdDs7HWFlxL7wKziZywtJ3Ouw=; 
	b=D7kPSsI5LkZWaBpJGKhWspw0o5ls2hbu6/h941p8mt9eWxpqSjjJodBncM4vjVxrAzZpzuZpmIFpNDg6osi8vZanpkFGT0hMDeigFbVoYAqFOGgqYTXzB1Gf+PBFgOsCMC5D5SpZgv0ZIZck2hb5tJ/JnFCX8VCgklZqZcFocUE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
	dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1742161950;
	s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=co/2bjOhFFI9JYAACNKdDs7HWFlxL7wKziZywtJ3Ouw=;
	b=L95Li5123Zwq136HrwQVpDPn6Drd43a8AGqDlhzb3WRDwj12Uy43stjhkytbgHF6
	FlxnBh8wcvbUjGQFZC04Mpse+co6LWTRxR4f+CsctC7MMAeVVBhD0NPPDX5AKUMq35+
	zlQ4Qxty4G2/kH70C9M2UcSuU9NLG34gdraXmsDI=
Received: by mx.zohomail.com with SMTPS id 1742161948296677.7541862913529;
	Sun, 16 Mar 2025 14:52:28 -0700 (PDT)
From: =?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>
To: Boris Brezillon <boris.brezillon@collabora.com>,
	Steven Price <steven.price@arm.com>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Cc: kernel@collabora.com,
	=?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] drm/panthor: Introduce BO labeling
Date: Sun, 16 Mar 2025 21:51:32 +0000
Message-ID: <20250316215139.3940623-2-adrian.larumbe@collabora.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250316215139.3940623-1-adrian.larumbe@collabora.com>
References: <20250316215139.3940623-1-adrian.larumbe@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add a new character string Panthor BO field, and a function that allows
setting it from within the driver.

Driver takes care of freeing the string when it's replaced or no longer
needed at object destruction time, but allocating it is the responsibility
of callers.

Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
---
 drivers/gpu/drm/panthor/panthor_gem.c | 18 ++++++++++++++++++
 drivers/gpu/drm/panthor/panthor_gem.h | 12 ++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/drivers/gpu/drm/panthor/panthor_gem.c b/drivers/gpu/drm/panthor/panthor_gem.c
index 8244a4e6c2a2..3c58bb2965ea 100644
--- a/drivers/gpu/drm/panthor/panthor_gem.c
+++ b/drivers/gpu/drm/panthor/panthor_gem.c
@@ -18,6 +18,9 @@ static void panthor_gem_free_object(struct drm_gem_object *obj)
 	struct panthor_gem_object *bo = to_panthor_bo(obj);
 	struct drm_gem_object *vm_root_gem = bo->exclusive_vm_root_gem;
 
+	kfree(bo->label);
+	mutex_destroy(&bo->label_lock);
+
 	drm_gem_free_mmap_offset(&bo->base.base);
 	mutex_destroy(&bo->gpuva_list_lock);
 	drm_gem_shmem_free(&bo->base);
@@ -196,6 +199,7 @@ struct drm_gem_object *panthor_gem_create_object(struct drm_device *ddev, size_t
 	obj->base.map_wc = !ptdev->coherent;
 	mutex_init(&obj->gpuva_list_lock);
 	drm_gem_gpuva_set_lock(&obj->base.base, &obj->gpuva_list_lock);
+	mutex_init(&obj->label_lock);
 
 	return &obj->base.base;
 }
@@ -247,3 +251,17 @@ panthor_gem_create_with_handle(struct drm_file *file,
 
 	return ret;
 }
+
+void
+panthor_gem_label_bo(struct drm_gem_object *obj, const char *label)
+{
+	struct panthor_gem_object *bo = to_panthor_bo(obj);
+	const char *old_label;
+
+	mutex_lock(&bo->label_lock);
+	old_label = bo->label;
+	bo->label = label;
+	mutex_unlock(&bo->label_lock);
+
+	kfree(old_label);
+}
diff --git a/drivers/gpu/drm/panthor/panthor_gem.h b/drivers/gpu/drm/panthor/panthor_gem.h
index 5749ef2ebe03..da9268d24566 100644
--- a/drivers/gpu/drm/panthor/panthor_gem.h
+++ b/drivers/gpu/drm/panthor/panthor_gem.h
@@ -46,6 +46,15 @@ struct panthor_gem_object {
 
 	/** @flags: Combination of drm_panthor_bo_flags flags. */
 	u32 flags;
+
+	/**
+	 * @label: Pointer to NULL-terminated string, can be assigned within the
+	 * driver itself or through a specific IOCTL.
+	 */
+	const char *label;
+
+	/** @label_lock: Lock that protects access to the @label field. */
+	struct mutex label_lock;
 };
 
 /**
@@ -91,6 +100,9 @@ panthor_gem_create_with_handle(struct drm_file *file,
 			       struct panthor_vm *exclusive_vm,
 			       u64 *size, u32 flags, uint32_t *handle);
 
+void
+panthor_gem_label_bo(struct drm_gem_object *obj, const char *label);
+
 static inline u64
 panthor_kernel_bo_gpuva(struct panthor_kernel_bo *bo)
 {
-- 
2.48.1


