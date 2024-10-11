Return-Path: <linux-kernel+bounces-361923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B78299AEFD
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 01:00:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 148A7286CB7
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 23:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDFFD1E6316;
	Fri, 11 Oct 2024 22:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="jV6OSLAC"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 871001E5720
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 22:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728687579; cv=pass; b=gKlLxmXeqzbw4n3dQncE+2XuvW+L5LxSK/BSMfDOhUfacGYlH/ySOpLQ0j/IqG3veyO7PNuqNFIlqTwr+VEjKAcuGNgPtJezTLGMZ9PhbwJKNEeCLjnwCqNbObsl998rGFbuDcW2eB2sCrJrTaJzYPDwYKT5ZiMjy+pfdqsFbz8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728687579; c=relaxed/simple;
	bh=WJU3KTTI1ZuAziwzdleWCJiLKUXEp+sj0vCXCcnXb7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KbXULWiD3wPW9ZP9AIX7lrcY6iqB3HhB+sil98qFPAKQ4UJmHZHU6txODO1DjmXnnqNEwYxPhesg+EJCPeWmpbO7hYDcOLlFCtz70TdUGwxlzEB+XO5nlhBL3fxPOWjvN1lSm1WST5Ej2xVVNP2UdsfUSpmfsqH2U7B9CfT9Lnk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b=jV6OSLAC; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1728687565; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=L/DkJbT2fEVZh3m/Sthe5Wrto6eOepPoX/wkMqTiaWKDduRVbcdCEU9cSMsoC5sEYOWTYP+DiX41NpBCLQVdQPUCfnXIOs6jLsc46vo/lhrTgudPOdtUbCTBjMyXoJLzuoXmBnD+e0OZm0zvhSdHcJ9RBrbZe5pLdpJpHcYs2Q8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1728687565; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=yrZlf5QwOEdnfLB/WKbk+uAHUVygWYrAIalCbzVETTc=; 
	b=iH781o8qFyT4VbCsq6j3Jbelou3dRrlftsRuhlvPGt3ichCx7zgbO60YLKkxwWwZ7jNn2hCnzH20na+UJB90TiIEBcG4HNgtAw497nteVmVAKj+YyN6AhRCRFIEGpJsEhNvs6Ui3ls4INofeXei9wsY3SKMAoE6vsTnmV5U+HLY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
	dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1728687565;
	s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=yrZlf5QwOEdnfLB/WKbk+uAHUVygWYrAIalCbzVETTc=;
	b=jV6OSLACowetuJB2r5KCPPMT6tAJDig4MlQM+zeCXflCDO3edBgv0AwKc30wRzN9
	B3JZjbNV/0jJFSxPuvskTUBdm4IuR94GiNou9NL6hRr2S76J//pb6fSLpIm4mFdnc1P
	z3+pjTwuhKJU9+uXgIVjbdO1/ZyPBvWzvL5/eTe4=
Received: by mx.zohomail.com with SMTPS id 1728687563354474.83172060251206;
	Fri, 11 Oct 2024 15:59:23 -0700 (PDT)
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
Subject: [PATCH 3/3] drm/panthor: Rreset device and load FW after failed PM suspend
Date: Fri, 11 Oct 2024 23:57:01 +0100
Message-ID: <20241011225906.3789965-3-adrian.larumbe@collabora.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241011225906.3789965-1-adrian.larumbe@collabora.com>
References: <20241011225906.3789965-1-adrian.larumbe@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On rk3588 SoCs, during a runtime PM suspend, the transition to the
lowest voltage/frequency pair might sometimes fail for reasons not yet
understood. In that case, even a slow FW reset will fail, leaving the
device's PM runtime status as unusuable.

When that happens, successive attempts to resume the device upon running
a job will always fail.

Fix it by forcing a synchronous device reset, which will lead to a
successful FW reload, and also reset the device's PM runtime error
status before resuming it.

Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
---
 drivers/gpu/drm/panthor/panthor_device.c | 10 ++++++++++
 drivers/gpu/drm/panthor/panthor_device.h |  2 ++
 drivers/gpu/drm/panthor/panthor_sched.c  |  7 +++++++
 3 files changed, 19 insertions(+)

diff --git a/drivers/gpu/drm/panthor/panthor_device.c b/drivers/gpu/drm/panthor/panthor_device.c
index 5430557bd0b8..ec6fed5e996b 100644
--- a/drivers/gpu/drm/panthor/panthor_device.c
+++ b/drivers/gpu/drm/panthor/panthor_device.c
@@ -105,6 +105,16 @@ static void panthor_device_reset_cleanup(struct drm_device *ddev, void *data)
 	destroy_workqueue(ptdev->reset.wq);
 }
 
+int panthor_device_reset_sync(struct panthor_device *ptdev)
+{
+	panthor_fw_pre_reset(ptdev, false);
+	panthor_mmu_pre_reset(ptdev);
+	panthor_gpu_soft_reset(ptdev);
+	panthor_gpu_l2_power_on(ptdev);
+	panthor_mmu_post_reset(ptdev);
+	return panthor_fw_post_reset(ptdev);
+}
+
 static void panthor_device_reset_work(struct work_struct *work)
 {
 	struct panthor_device *ptdev = container_of(work, struct panthor_device, reset.work);
diff --git a/drivers/gpu/drm/panthor/panthor_device.h b/drivers/gpu/drm/panthor/panthor_device.h
index 0e68f5a70d20..05a5a7233378 100644
--- a/drivers/gpu/drm/panthor/panthor_device.h
+++ b/drivers/gpu/drm/panthor/panthor_device.h
@@ -217,6 +217,8 @@ struct panthor_file {
 int panthor_device_init(struct panthor_device *ptdev);
 void panthor_device_unplug(struct panthor_device *ptdev);
 
+int panthor_device_reset_sync(struct panthor_device *ptdev);
+
 /**
  * panthor_device_schedule_reset() - Schedules a reset operation
  */
diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
index c7b350fc3eba..9a854c8c5718 100644
--- a/drivers/gpu/drm/panthor/panthor_sched.c
+++ b/drivers/gpu/drm/panthor/panthor_sched.c
@@ -3101,6 +3101,13 @@ queue_run_job(struct drm_sched_job *sched_job)
 		return dma_fence_get(job->done_fence);
 	}
 
+	if (ptdev->base.dev->power.runtime_error) {
+		ret = panthor_device_reset_sync(ptdev);
+		if (drm_WARN_ON(&ptdev->base, ret))
+			return ERR_PTR(ret);
+		drm_WARN_ON(&ptdev->base, pm_runtime_set_active(ptdev->base.dev));
+	}
+
 	ret = pm_runtime_resume_and_get(ptdev->base.dev);
 	if (drm_WARN_ON(&ptdev->base, ret))
 		return ERR_PTR(ret);
-- 
2.46.2


