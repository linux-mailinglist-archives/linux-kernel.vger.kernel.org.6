Return-Path: <linux-kernel+bounces-432003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 250589E43BC
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 19:51:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99E942853C3
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 18:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CAFF1A8F9A;
	Wed,  4 Dec 2024 18:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="DuZHHq97"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48AE91B395D
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 18:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733338238; cv=pass; b=py3XMO7RTUObFDPvtOw7AMdbPQzv5eiQVMGZBhBPPudoBsULXY+2AuJVePGzA7Awo3eCnNXNTcW43ja5+cOuDvcb65QsbxwfpvzvopVEp4n10miH/otDAvn6YNTR/lNT8duPVIaucPehJLhZnwVj5WmfDXogGz1oWtZPzU4hzPQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733338238; c=relaxed/simple;
	bh=0vAis1+9Iur4U7JyeJ4ywRTB8A0fnL0rvs6QK2NOuuM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uehy4Tho8AlQjmF9qLYECAOH//hpDqI/HCsO71qdvsvh7IMc+Y4OZXmAsu//+fthljeCbneL+sYuURip6JIFCYhCJsqFa47W40MYdnvqCMORkYz2chhZTS79DIEqcysGHpY6qm3OM2qBJ2DKmA7i3WnMU5NBLNXFcui40/i47+4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b=DuZHHq97; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1733338216; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=iEI1bfMMruzPfJ6/0atm1MUxOgMXB6Hn5hTgVCYtJdcs5Y/4JbgsVMZAhMq7XB7FeKodCyQjGRURy10xkJtVLRRNJqH3e8Gt0XYoNWfrvS3+SzJqerm/IRCtzPrcxJazNpM/y81qrI5kVaX5m+dBF5tFMpZgJ9epn5XvxiopHf4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1733338216; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=ttdCHXLB8sd6tHbLHmHbCUNcVhrUROqKuRsqIlLsEfs=; 
	b=lCrTLIwfiAltfPlLICnSEVHrMe3+W9W3cYQiK1N+sBllwVjvRMZHsXMM9HmXPH/bTP4SitAh12lVpfyaH5ow6oweR+N7FbTMGOKZdnwP7LuKUyM5fhb8eLVHFrBERtqRAW1Zu/ZSFJD5Pdk8PghyN/boNI+jrzQYBhskXxDQ4mc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
	dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1733338216;
	s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=ttdCHXLB8sd6tHbLHmHbCUNcVhrUROqKuRsqIlLsEfs=;
	b=DuZHHq97v8Lqhb05c0l45V1Ms6CyBedZGo9waSERKQjOrfc0p5QoFYdRTQiJplMe
	z7Ry0uUd4NET4c/hycnqfOQgXs2yzbgIe3YEjInOU9Ect5cx5sN08pL0idOsu8HeGgs
	Y6rWG0pZt7xhhZswzx1bobjIyC0UtdX+c5D55iWc=
Received: by mx.zohomail.com with SMTPS id 1733338215510420.7367774673804;
	Wed, 4 Dec 2024 10:50:15 -0800 (PST)
From: =?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>
To: Boris Brezillon <boris.brezillon@collabora.com>,
	Rob Herring <robh@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: kernel@collabora.com,
	=?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/9] drm/panfrost: Handle job HW submit errors
Date: Wed,  4 Dec 2024 18:49:32 +0000
Message-ID: <20241204184945.1477677-4-adrian.larumbe@collabora.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241204184945.1477677-1-adrian.larumbe@collabora.com>
References: <20241204184945.1477677-1-adrian.larumbe@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Avoid waiting for the DRM scheduler job timedout handler, and instead, let
the DRM scheduler core signal the error fence immediately when HW job
submission fails.

That means we must also decrement the runtime-PM refcnt for the device,
because the job will never be enqueued or inflight.

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
---
 drivers/gpu/drm/panfrost/panfrost_job.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_job.c b/drivers/gpu/drm/panfrost/panfrost_job.c
index f640d211cc3a..83bc74f6044e 100644
--- a/drivers/gpu/drm/panfrost/panfrost_job.c
+++ b/drivers/gpu/drm/panfrost/panfrost_job.c
@@ -195,7 +195,7 @@ panfrost_enqueue_job(struct panfrost_device *pfdev, int slot,
 	return 1;
 }
 
-static void panfrost_job_hw_submit(struct panfrost_job *job, int js)
+static int panfrost_job_hw_submit(struct panfrost_job *job, int js)
 {
 	struct panfrost_device *pfdev = job->pfdev;
 	unsigned int subslot;
@@ -207,10 +207,11 @@ static void panfrost_job_hw_submit(struct panfrost_job *job, int js)
 
 	ret = pm_runtime_get_sync(pfdev->base.dev);
 	if (ret < 0)
-		return;
+		goto err_hwsubmit;
 
 	if (WARN_ON(job_read(pfdev, JS_COMMAND_NEXT(js)))) {
-		return;
+		ret = -EINVAL;
+		goto err_hwsubmit;
 	}
 
 	cfg = panfrost_mmu_as_get(pfdev, job->mmu);
@@ -261,6 +262,12 @@ static void panfrost_job_hw_submit(struct panfrost_job *job, int js)
 			job, js, subslot, jc_head, cfg & 0xf);
 	}
 	spin_unlock(&pfdev->js->job_lock);
+
+	return 0;
+
+err_hwsubmit:
+	pm_runtime_put_autosuspend(pfdev->base.dev);
+	return ret;
 }
 
 static int panfrost_acquire_object_fences(struct drm_gem_object **bos,
@@ -382,6 +389,7 @@ static struct dma_fence *panfrost_job_run(struct drm_sched_job *sched_job)
 	struct panfrost_device *pfdev = job->pfdev;
 	int slot = panfrost_job_get_slot(job);
 	struct dma_fence *fence = NULL;
+	int ret;
 
 	if (unlikely(job->base.s_fence->finished.error))
 		return NULL;
@@ -400,7 +408,11 @@ static struct dma_fence *panfrost_job_run(struct drm_sched_job *sched_job)
 		dma_fence_put(job->done_fence);
 	job->done_fence = dma_fence_get(fence);
 
-	panfrost_job_hw_submit(job, slot);
+	ret = panfrost_job_hw_submit(job, slot);
+	if (ret) {
+		dma_fence_put(fence);
+		return ERR_PTR(ret);
+	}
 
 	return fence;
 }
-- 
2.47.0


