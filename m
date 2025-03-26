Return-Path: <linux-kernel+bounces-576405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BCBCA70ED7
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 03:16:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45F53189C937
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 02:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 267D714831F;
	Wed, 26 Mar 2025 02:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="VnTfUOjy"
Received: from sender3-pp-f112.zoho.com (sender3-pp-f112.zoho.com [136.143.184.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46F313AA31
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 02:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.184.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742955340; cv=pass; b=Qr4jXVtkwboVUuDQS76hxhu5hDEUdYYSYORIHZs4SRhj2wiC8qcslVDn0zwXE4XEYSvV/5EQMN3gRIfn45z/QvFLfnAWULInq1gcisP8jIOBc8aJJH5ddWMNsWNBG6geaZPmFMLFm7dCQIQSG7zSkjlhgEkz3G0JJEsT5wAJQv0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742955340; c=relaxed/simple;
	bh=m9GD4loYkS9eoifl1EJQIY3WbQjjRF/a0URtsymk1mU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l+6PiX52sDxdQWu/3lEpDScVIgcbhiYsUZ8ulTrM2uHnZjvyf65XD6KudO/lh6qIOL+lBRawLGr8P5LhG/GRI/6mbrSYn6wUEbEr+JNbU8WaUvbYBy/nmBxUt0NH4FSB5amkjAlw8tX63yckUtjobil1yTcIW8uVHpjWTGUkZs0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b=VnTfUOjy; arc=pass smtp.client-ip=136.143.184.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1742955319; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=buHt9+8wJ2ksc9/06QreSVQ1jLvLR69XLdNhzNlGH1n+VdbQzbuUWwwOvf0kZwVPmMEkhBkDBOJYSANDple11op8JHPd9zvpQw1hU1/6VLUQSSII7Y6yjwaGw//3PbGmafz0cU2iGFPBILRDFzSrV2pp5D35LIWt9hmkBeLAjnI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1742955319; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=eDDJBa43wl24zfW0m/nKztfofIyTDy2Iq6m6CG3HtAk=; 
	b=QSMSm9uIWhwqtw6WdRYV6gjbqeUEtU8pc+ID24SdLiYl/uYPRyXbrjnAHxS1cWssNF+gXlf7JtOEkLdJkNmUnN5OvQL7o2ksPoqHPM5JoAWmvax/QesyvxeeCgxp9OTrvUu2NwMstgUGo/BkBj/z9qZo62uYYkovgz4Ps6S1Uzk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
	dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1742955319;
	s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=eDDJBa43wl24zfW0m/nKztfofIyTDy2Iq6m6CG3HtAk=;
	b=VnTfUOjyyEJaAd4e+E2GUEG9Q8ZbsX/4wbg87KRRuZ7DnBZeq14dWpyF+w0oOv6d
	e0abxBxVT5cw7dyBjtIrJQHkJfv5QHxnnf8+rAZDN0kxOXGToZmgS3Q5OwirmEYqtc+
	8tSKQzxRTEJdHxEzzByVlpSav5+PJKS+15KaZbLE=
Received: by mx.zohomail.com with SMTPS id 1742955317701794.8257212544316;
	Tue, 25 Mar 2025 19:15:17 -0700 (PDT)
From: =?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	Rob Herring <robh@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Liviu Dudau <liviu.dudau@arm.com>
Cc: kernel@collabora.com,
	=?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>,
	linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: [RFC PATCH v2 2/6] drm/shmem: Introduce the notion of sparse objects
Date: Wed, 26 Mar 2025 02:14:22 +0000
Message-ID: <20250326021433.772196-3-adrian.larumbe@collabora.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250326021433.772196-1-adrian.larumbe@collabora.com>
References: <20250326021433.772196-1-adrian.larumbe@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Sparse DRM objects will store their backing pages in an xarray, to avoid
the overhead of preallocating a huge struct page pointer array when only
a very small range of indices might be assigned.

For now, only the definition of a sparse object as a union alternative
to a 'dense' object is provided, with functions that exploit it being
part of later commits.

Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
---
 drivers/gpu/drm/drm_gem_shmem_helper.c | 68 +++++++++++++++++++++++++-
 include/drm/drm_gem_shmem_helper.h     | 23 ++++++++-
 2 files changed, 88 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
index d99dee67353a..5f75eb1230f6 100644
--- a/drivers/gpu/drm/drm_gem_shmem_helper.c
+++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
@@ -128,6 +128,31 @@ struct drm_gem_shmem_object *drm_gem_shmem_create(struct drm_device *dev, size_t
 }
 EXPORT_SYMBOL_GPL(drm_gem_shmem_create);
 
+/**
+ * drm_gem_shmem_create_sparse - Allocate a sparse object with the given size
+ * @dev: DRM device
+ * @size: Size of the sparse object to allocate
+ *
+ * This function creates a sparse shmem GEM object.
+ *
+ * Returns:
+ * A struct drm_gem_shmem_object * on success or an ERR_PTR()-encoded negative
+ * error code on failure.
+ */
+struct drm_gem_shmem_object *drm_gem_shmem_create_sparse(struct drm_device *dev, size_t size)
+{
+	struct drm_gem_shmem_object *shmem =
+		__drm_gem_shmem_create(dev, size, false, NULL);
+
+	if (!IS_ERR(shmem)) {
+		shmem->sparse = true;
+		xa_init_flags(&shmem->xapages, XA_FLAGS_ALLOC);
+	}
+
+	return shmem;
+}
+EXPORT_SYMBOL_GPL(drm_gem_shmem_create_sparse);
+
 /**
  * drm_gem_shmem_create_with_mnt - Allocate an object with the given size in a
  * given mountpoint
@@ -173,8 +198,8 @@ void drm_gem_shmem_free(struct drm_gem_shmem_object *shmem)
 			sg_free_table(shmem->sgt);
 			kfree(shmem->sgt);
 		}
-		if (shmem->pages)
-			drm_gem_shmem_put_pages(shmem);
+
+		drm_gem_shmem_put_pages(shmem);
 
 		drm_WARN_ON(obj->dev, shmem->pages_use_count);
 
@@ -196,6 +221,12 @@ static int drm_gem_shmem_get_pages(struct drm_gem_shmem_object *shmem)
 	if (shmem->pages_use_count++ > 0)
 		return 0;
 
+	/* We only allow increasing the user count in the case of
+	 * sparse shmem objects with some backed pages for now
+	 */
+	if (shmem->sparse && xa_empty(&shmem->xapages))
+		return -EINVAL;
+
 	pages = drm_gem_get_pages(obj);
 	if (IS_ERR(pages)) {
 		drm_dbg_kms(obj->dev, "Failed to get pages (%ld)\n",
@@ -231,6 +262,14 @@ void drm_gem_shmem_put_pages(struct drm_gem_shmem_object *shmem)
 
 	dma_resv_assert_held(shmem->base.resv);
 
+	if (!shmem->sparse) {
+		if (!shmem->pages)
+			return;
+	} else {
+		/* Not implemented yet */
+		return;
+	}
+
 	if (drm_WARN_ON_ONCE(obj->dev, !shmem->pages_use_count))
 		return;
 
@@ -404,8 +443,15 @@ void drm_gem_shmem_vunmap(struct drm_gem_shmem_object *shmem,
 {
 	struct drm_gem_object *obj = &shmem->base;
 
+	if (shmem->sparse) {
+		drm_err(obj->dev, "UM unmapping of sparse shmem objects not implemented\n");
+		return;
+	}
+
 	if (drm_gem_is_imported(obj)) {
 		dma_buf_vunmap(obj->dma_buf, map);
+	} else if (obj->import_attach) {
+		dma_buf_vunmap(obj->import_attach->dmabuf, map);
 	} else {
 		dma_resv_assert_held(shmem->base.resv);
 
@@ -541,6 +587,12 @@ static vm_fault_t drm_gem_shmem_fault(struct vm_fault *vmf)
 	struct page *page;
 	pgoff_t page_offset;
 
+	/* TODO: Implement UM mapping of sparse shmem objects */
+	if (drm_WARN_ON(obj->dev, shmem->sparse)) {
+		drm_err(obj->dev, "UM mapping of sparse shmem objects not implemented\n");
+		return VM_FAULT_SIGBUS;
+	}
+
 	/* We don't use vmf->pgoff since that has the fake offset */
 	page_offset = (vmf->address - vma->vm_start) >> PAGE_SHIFT;
 
@@ -566,8 +618,14 @@ static void drm_gem_shmem_vm_open(struct vm_area_struct *vma)
 	struct drm_gem_object *obj = vma->vm_private_data;
 	struct drm_gem_shmem_object *shmem = to_drm_gem_shmem_obj(obj);
 
+	/* TODO: Implement UM mapping of sparse shmem objects */
+	if (drm_WARN_ON(obj->dev, shmem->sparse))
+		return;
+
 	drm_WARN_ON(obj->dev, drm_gem_is_imported(obj));
 
+	drm_WARN_ON(obj->dev, obj->import_attach);
+
 	dma_resv_lock(shmem->base.resv, NULL);
 
 	/*
@@ -690,6 +748,9 @@ struct sg_table *drm_gem_shmem_get_sg_table(struct drm_gem_shmem_object *shmem)
 {
 	struct drm_gem_object *obj = &shmem->base;
 
+	if (drm_WARN_ON(obj->dev, shmem->sparse))
+		return ERR_PTR(-EINVAL);
+
 	drm_WARN_ON(obj->dev, drm_gem_is_imported(obj));
 
 	return drm_prime_pages_to_sg(obj->dev, shmem->pages, obj->size >> PAGE_SHIFT);
@@ -702,6 +763,9 @@ static struct sg_table *drm_gem_shmem_get_pages_sgt_locked(struct drm_gem_shmem_
 	int ret;
 	struct sg_table *sgt;
 
+	if (drm_WARN_ON(obj->dev, shmem->sparse))
+		return ERR_PTR(-EINVAL);
+
 	if (shmem->sgt)
 		return shmem->sgt;
 
diff --git a/include/drm/drm_gem_shmem_helper.h b/include/drm/drm_gem_shmem_helper.h
index cef5a6b5a4d6..00e47512b30f 100644
--- a/include/drm/drm_gem_shmem_helper.h
+++ b/include/drm/drm_gem_shmem_helper.h
@@ -6,6 +6,7 @@
 #include <linux/fs.h>
 #include <linux/mm.h>
 #include <linux/mutex.h>
+#include <linux/xarray.h>
 
 #include <drm/drm_file.h>
 #include <drm/drm_gem.h>
@@ -29,7 +30,10 @@ struct drm_gem_shmem_object {
 	/**
 	 * @pages: Page table
 	 */
-	struct page **pages;
+	union {
+		struct page **pages;
+		struct xarray xapages;
+	};
 
 	/**
 	 * @pages_use_count:
@@ -91,12 +95,18 @@ struct drm_gem_shmem_object {
 	 * @map_wc: map object write-combined (instead of using shmem defaults).
 	 */
 	bool map_wc : 1;
+
+	/**
+	 * @sparse: the object is only partially backed by pages
+	 */
+	bool sparse : 1;
 };
 
 #define to_drm_gem_shmem_obj(obj) \
 	container_of(obj, struct drm_gem_shmem_object, base)
 
 struct drm_gem_shmem_object *drm_gem_shmem_create(struct drm_device *dev, size_t size);
+struct drm_gem_shmem_object *drm_gem_shmem_create_sparse(struct drm_device *dev, size_t size);
 struct drm_gem_shmem_object *drm_gem_shmem_create_with_mnt(struct drm_device *dev,
 							   size_t size,
 							   struct vfsmount *gemfs);
@@ -210,6 +220,10 @@ static inline struct sg_table *drm_gem_shmem_object_get_sg_table(struct drm_gem_
 {
 	struct drm_gem_shmem_object *shmem = to_drm_gem_shmem_obj(obj);
 
+	/* Use the specific sparse shmem get_sg_table function instead */
+	if (WARN_ON(shmem->sparse))
+		return ERR_PTR(-EINVAL);
+
 	return drm_gem_shmem_get_sg_table(shmem);
 }
 
@@ -229,6 +243,10 @@ static inline int drm_gem_shmem_object_vmap(struct drm_gem_object *obj,
 {
 	struct drm_gem_shmem_object *shmem = to_drm_gem_shmem_obj(obj);
 
+	/* TODO: Implement kernel mapping of sparse shmem objects */
+	if (WARN_ON(shmem->sparse))
+		return -EACCES;
+
 	return drm_gem_shmem_vmap(shmem, map);
 }
 
@@ -263,6 +281,9 @@ static inline int drm_gem_shmem_object_mmap(struct drm_gem_object *obj, struct v
 {
 	struct drm_gem_shmem_object *shmem = to_drm_gem_shmem_obj(obj);
 
+	if (shmem->sparse)
+		return -EACCES;
+
 	return drm_gem_shmem_mmap(shmem, vma);
 }
 
-- 
2.48.1


