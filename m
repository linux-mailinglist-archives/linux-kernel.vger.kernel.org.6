Return-Path: <linux-kernel+bounces-364854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FDCE99DA3C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 01:39:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2BBD0B21FA8
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 23:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32A511E2009;
	Mon, 14 Oct 2024 23:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="SEE6VbQV"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C62A1E2018
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 23:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728949133; cv=pass; b=gKeXRLjvXot43bzbiaJn0i3Wyk7YPJefz/Nz0PVrj3zZGCYHfm9oQcnQB3cXHvYZmndBc+t1AfbFTkR6Hl0dU2s+pQuA8VZ+3ktgxuaFhd4zV1NMaG5ebTt7gO+KKZ+3az5FrsqDgFpg2sFr3sBHDf4OkxFZ6WYXuNK8L4XBiB4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728949133; c=relaxed/simple;
	bh=oHfHcLdsCuBCJomwYVgifI2WyMHpZwzYP6pla9zAQa4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iE2Ys9v7aX+bFJG0WQMpgfgSvred6HBxcaPAxwTXX/VqDHiTJfcCgF0zvLlM67Bmgb1/xHXswHYUh8wFuz3O7wQkEOOJMQg1RABvpHXHbU7OpLMAV4KwEu5DbB74JwJp1kfn56J/Tkjcib93f+dCunALitDfxyGZ2lvOrHl0x9I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b=SEE6VbQV; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1728949116; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=FgooGi3tB+HCP9A60qmsG3RQp0hkVtctbRl2aBMMY7LB+/z2gt+oGHOpFJEsEVh8B/CVJA0jB4IXnmn90b+OKgV9++3Zts/cjeLZx+60QpijG0BiSrgP+aBd1mJOL1swj0BVDODnzoz2SIQupey0unfDeCC4+Id8hQtX7b63XLI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1728949116; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=/I5+u6uM0kelR4wmg++rrt/HFJwg726T85fu1Pbc6iw=; 
	b=BgWqkUR+ex4n2Rl7mbALGsWD6bVGo4O1J+UVFNUHbfAr2mTYwe050VKEYFnHgLRAb/ojPp4jSdg7gsth4D8/6o7br2x+mkYk7U2z2ymKluCaSaCBCcdqdo9gmkw8J57PC11szyTFR+nlyeJBo+v/9XCSJgMI876fh1IhKawD86c=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
	dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1728949116;
	s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=/I5+u6uM0kelR4wmg++rrt/HFJwg726T85fu1Pbc6iw=;
	b=SEE6VbQV9fMhl7HoiWk39nm9g4J1cUK9+8T6yNqxyasBDKJ4njELFwJ67Qz5Pc9z
	VhQ1BvFai1s2MSGAoGgkLnK7DOWNuaAm3Iud09J2AKVweAmZqH95Ei5HZ+7RqiR8ApH
	7TAdY/9krLzKsyWQcID+pmEMCnzFoOaD+Baz4xrs=
Received: by mx.zohomail.com with SMTPS id 1728949114359752.7258108563636;
	Mon, 14 Oct 2024 16:38:34 -0700 (PDT)
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
Subject: [PATCH 7/9] drm/panfrost: Refactor job IRQ enabling sequence
Date: Tue, 15 Oct 2024 00:31:42 +0100
Message-ID: <20241014233758.994861-7-adrian.larumbe@collabora.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241014233758.994861-1-adrian.larumbe@collabora.com>
References: <20241014233758.994861-1-adrian.larumbe@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Just a convenience macro to avoid reduplication.

Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
---
 drivers/gpu/drm/panfrost/panfrost_job.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_job.c b/drivers/gpu/drm/panfrost/panfrost_job.c
index 68be555c6c52..5d83c6a148ec 100644
--- a/drivers/gpu/drm/panfrost/panfrost_job.c
+++ b/drivers/gpu/drm/panfrost/panfrost_job.c
@@ -27,6 +27,11 @@
 #define job_write(dev, reg, data) writel(data, dev->iomem + (reg))
 #define job_read(dev, reg) readl(dev->iomem + (reg))
 
+#define enable_job_interrupts(pfdev)				\
+	job_write((pfdev), JOB_INT_MASK,			\
+		  GENMASK(16 + NUM_JOB_SLOTS - 1, 16) |		\
+		  GENMASK(NUM_JOB_SLOTS - 1, 0))
+
 struct panfrost_queue_state {
 	struct drm_gpu_scheduler sched;
 	u64 fence_context;
@@ -741,9 +746,7 @@ panfrost_reset(struct panfrost_device *pfdev,
 		drm_sched_start(&pfdev->js->queue[i].sched, 0);
 
 	/* Re-enable job interrupts now that everything has been restarted. */
-	job_write(pfdev, JOB_INT_MASK,
-		  GENMASK(16 + NUM_JOB_SLOTS - 1, 16) |
-		  GENMASK(NUM_JOB_SLOTS - 1, 0));
+	enable_job_interrupts(pfdev);
 
 	dma_fence_end_signalling(cookie);
 }
@@ -816,9 +819,7 @@ static irqreturn_t panfrost_job_irq_handler_thread(int irq, void *data)
 
 	/* Enable interrupts only if we're not about to get suspended */
 	if (!test_bit(PANFROST_COMP_BIT_JOB, pfdev->is_suspended))
-		job_write(pfdev, JOB_INT_MASK,
-			  GENMASK(16 + NUM_JOB_SLOTS - 1, 16) |
-			  GENMASK(NUM_JOB_SLOTS - 1, 0));
+		enable_job_interrupts(pfdev);
 
 	return IRQ_HANDLED;
 }
-- 
2.46.2


