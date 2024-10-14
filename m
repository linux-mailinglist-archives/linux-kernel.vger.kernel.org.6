Return-Path: <linux-kernel+bounces-364848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 753BB99DA33
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 01:38:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 974EF1C2124F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 23:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 497241D9A56;
	Mon, 14 Oct 2024 23:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="CI4CTHZs"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4187920323
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 23:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728949118; cv=pass; b=IZ0oTUpJMg17Jku0EnRc2YUDmVr+HFpHvsIqCMUnZjwPD23rWuirCPRkRuBjRuPUzSsbcJOIi8Up0rNADjq48w6MZvSPlW39jj7JISfSQJfCE15PQCkokGsqlTDg4KIKbVm28wIFYivpZ/hdc+25yXQf+VZSe0UGbhn8mGtuJGU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728949118; c=relaxed/simple;
	bh=ldROcKIHRQpTY9zPNVzPtOsW0BJHh3az386UIbGBa2w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ty9VKe6TCCIvLWeKqhFeKy6r6bfZzR3PUm2jEkbOWbyaqW9tnif9QrRun69lm0LcVXVg4kSinqLs0dXylEWWAQyzh4+OiDIsYCvOEQNUBsTzt+bC2pCwxOYi9F7lhd5S2ZLBYA5+bHKtEAWK8HAgv0Us7ixoaXWV2RUXxrZ4I6I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b=CI4CTHZs; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1728949100; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=jo1+obkmoSrUuFd9CNDDJ/1KMC1PCgZjXFn5D7SGy2+IcAZkL+qgDx68vqdsi3SpN47DPUHVVEsPd+AY1YJlqXuGe3siFZ4Fivx7PhM5tsyVp6mE7FzEEJn2ne4Z37GwoMVh5Pap5UenU/pYUxoyuolS8ZE/Pp3XYyVI3TSoqZc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1728949100; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=QfJNlkYOsP4revp1LfkoKS7jiXV0nP1bn9tzG/E/WUY=; 
	b=TtSdqXVlXLldQj3zX/FBYNSkBXB8KFBYIQtuSGlQIiNAGgv6zQH1sCGh3Xeg4eLEhyAg7oEPSNHIJw9SgaCwWUDfv8EWiGYLSd/y9nxTbvegrlBdUJAFDzw8ANyB9+wSmK9aXyPUHVEUxnl2FQVeAgr2RS/2YbKbyaId2Y4cxHA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
	dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1728949100;
	s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=QfJNlkYOsP4revp1LfkoKS7jiXV0nP1bn9tzG/E/WUY=;
	b=CI4CTHZs+J0Xj1eTaRM7Hk6d1BN8LJUDQQAezviS/KT8IN7a4N6xYWb196fzoPXR
	tve2UR3ytQgPSakUzEZDlPYX/0D8jjTahP75cnF6UEjs/38ZoTsFmSAFPq5R22PjAbE
	q0NP6QyQXsyJELNG4q72MFuYhaezz8DBtpwtoyrg=
Received: by mx.zohomail.com with SMTPS id 1728949099746995.1633127918977;
	Mon, 14 Oct 2024 16:38:19 -0700 (PDT)
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
Subject: [PATCH 2/9] drm/panfrost: handle inexistent GPU during probe
Date: Tue, 15 Oct 2024 00:31:37 +0100
Message-ID: <20241014233758.994861-2-adrian.larumbe@collabora.com>
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

Just in case we're dealing with a yet not recognised device.

Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
---
 drivers/gpu/drm/panfrost/panfrost_gpu.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_gpu.c b/drivers/gpu/drm/panfrost/panfrost_gpu.c
index 5a33919fa213..495621324de1 100644
--- a/drivers/gpu/drm/panfrost/panfrost_gpu.c
+++ b/drivers/gpu/drm/panfrost/panfrost_gpu.c
@@ -237,9 +237,10 @@ static const struct panfrost_model gpu_models[] = {
 	 */
 	GPU_MODEL(g57, 0x9003,
 		GPU_REV(g57, 0, 0)),
+	{0},
 };
 
-static void panfrost_gpu_init_features(struct panfrost_device *pfdev)
+static int panfrost_gpu_init_features(struct panfrost_device *pfdev)
 {
 	u32 gpu_id, num_js, major, minor, status, rev;
 	const char *name = "unknown";
@@ -324,6 +325,12 @@ static void panfrost_gpu_init_features(struct panfrost_device *pfdev)
 		break;
 	}
 
+	if (!model->name) {
+		dev_err(pfdev->base.dev, "GPU model not found: mali-%s id rev %#x %#x\n",
+			name, gpu_id, rev);
+		return -ENODEV;
+	}
+
 	bitmap_from_u64(pfdev->features.hw_features, hw_feat);
 	bitmap_from_u64(pfdev->features.hw_issues, hw_issues);
 
@@ -344,6 +351,8 @@ static void panfrost_gpu_init_features(struct panfrost_device *pfdev)
 
 	dev_info(pfdev->base.dev, "shader_present=0x%0llx l2_present=0x%0llx",
 		 pfdev->features.shader_present, pfdev->features.l2_present);
+
+	return 0;
 }
 
 void panfrost_cycle_counter_get(struct panfrost_device *pfdev)
@@ -486,7 +495,9 @@ int panfrost_gpu_init(struct panfrost_device *pfdev)
 	if (err)
 		return err;
 
-	panfrost_gpu_init_features(pfdev);
+	err = panfrost_gpu_init_features(pfdev);
+	if (err)
+		return err;
 
 	err = dma_set_mask_and_coherent(pfdev->base.dev,
 					DMA_BIT_MASK(FIELD_GET(0xff00,
-- 
2.46.2


