Return-Path: <linux-kernel+bounces-234833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42E6F91CB43
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 07:23:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76FD41C21DC0
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 05:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96F6C24211;
	Sat, 29 Jun 2024 05:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b="g9FEdqjs"
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 725682E3EE
	for <linux-kernel@vger.kernel.org>; Sat, 29 Jun 2024 05:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719638606; cv=pass; b=oWIqhWAa+QrT+vEwJSsxD0SniJl2S2jBpB8GaDUwn+b+CBrBeeurdoOBByLsCBYR21UxbshuGa7RNOyCsknTEnMIRaEYYg2MalJ4NC5z9KWfCxs8sxzcf1PpvgMJtQ8SU42WaImY8vc4dzwyeVQZI73dyWKE6sSh72DsQGiAC48=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719638606; c=relaxed/simple;
	bh=wEzQAUcsqid6unpc2S1DNCyRrmM8XK0E9nvFGHpmU08=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z7SZdcKyDeKfEl1U5j4l/HHKv701PhrpgAfuCQoeQsJmEUtsR8p6KhFLrStxwNVH2p6A8BFe0tpd9AaX2ukx/8ShFb1mTTSFPEkOfUtZg1cJ25efIN7T5u6k4KMcoxYAY4vhXQ6M+z3CKZzol7VGbjyAZWkrrEZyr1oRiOVhItk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me; spf=pass smtp.mailfrom=icenowy.me; dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b=g9FEdqjs; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icenowy.me
Delivered-To: uwu@icenowy.me
ARC-Seal: i=1; a=rsa-sha256; t=1719638592; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=B8ny7U2fot/QheCyb7QbFouManFbpgrbbx4nrLOFktDhIY4QIvJzWrM/6LmkczCd2e7M4g3foU6EVkK2ptlk9ycnkHSBpAgNUih59iUyxk+gKEcvIyPyXOPcwi47s3R+dGbn2kemlr28oLKmCyHVx9bTiUWtMUSTYkg10An4Fak=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1719638592; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=nEsIO0/bRYNax82CMmpXkU6vaStGTkFxGmHNhc3PsQE=; 
	b=I72E2nVNo0sPp9DSCChZpsbnj4+Y55gZLuRHu13SGsv5davs7/I1yyvf01+kyZ19+dwxSSgwdSL4Y8YYb2ZaNibBpx4WkSvkmtq0vGGyCrRCPeU8KKFPEZUbHCEVhd8hSjf68bTUaned94GIuL/v7TOvmPwE6oZ4nb28uHoi/iY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=icenowy.me;
	spf=pass  smtp.mailfrom=uwu@icenowy.me;
	dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1719638592;
	s=zmail2; d=icenowy.me; i=uwu@icenowy.me;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=nEsIO0/bRYNax82CMmpXkU6vaStGTkFxGmHNhc3PsQE=;
	b=g9FEdqjsErMLEr3aIuM6TAYS1MuqVTHIjjx+StbbJIRwK+57usSihxCvvLQAV2ru
	+FQZw6wfVbY2kgbN84ctUIfuwwWjn/wnrsjw8+IwrcrLfZltyfxY4VvEDctK8rTqsF9
	brF3V4nn0rw+g5m73twHGI7b+Zao3PkVEBs2BP4oIYdBPPsNS2aGqXwh/hMlD/FsTxl
	9O5StNdNhovbXHpei7UnHQJZ22czMQQ3m+2P5zC9L8C26Nyes/TF+Y9rozY/xV7UK72
	9CruVTrCfu6HaGWUIJ3yysojiuyfNGWLB1/XpSze3rzjlyyCIlNLSoc0cSueKireKCY
	NgPREyZ+xA==
Received: by mx.zohomail.com with SMTPS id 1719638591260119.47155784716438;
	Fri, 28 Jun 2024 22:23:11 -0700 (PDT)
From: Icenowy Zheng <uwu@icenowy.me>
To: Christian Koenig <christian.koenig@amd.com>,
	Huang Rui <ray.huang@amd.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Icenowy Zheng <uwu@icenowy.me>
Subject: [RFC PATCH 1/2] drm/ttm: save the device's DMA coherency status in ttm_device
Date: Sat, 29 Jun 2024 13:22:46 +0800
Message-ID: <20240629052247.2653363-2-uwu@icenowy.me>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240629052247.2653363-1-uwu@icenowy.me>
References: <20240629052247.2653363-1-uwu@icenowy.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Currently TTM utilizes cached memory regardless of whether the device
have full DMA coherency (can snoop CPU cache).

Save the device's DMA coherency status in struct ttm_device, to allow
further support of devices w/o snooping capability (the capability
missing on at least one part of the transmission between the CPU and the
device).

Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
---
 drivers/gpu/drm/ttm/ttm_device.c | 2 ++
 include/drm/ttm/ttm_device.h     | 5 +++++
 2 files changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/ttm/ttm_device.c b/drivers/gpu/drm/ttm/ttm_device.c
index 434cf0258000e..b923c14861c1a 100644
--- a/drivers/gpu/drm/ttm/ttm_device.c
+++ b/drivers/gpu/drm/ttm/ttm_device.c
@@ -237,6 +237,8 @@ int ttm_device_init(struct ttm_device *bdev, const struct ttm_device_funcs *func
 	list_add_tail(&bdev->device_list, &glob->device_list);
 	mutex_unlock(&ttm_global_mutex);
 
+	bdev->dma_coherent = dev->dma_coherent;
+
 	return 0;
 }
 EXPORT_SYMBOL(ttm_device_init);
diff --git a/include/drm/ttm/ttm_device.h b/include/drm/ttm/ttm_device.h
index c22f30535c848..9daf7f47d6507 100644
--- a/include/drm/ttm/ttm_device.h
+++ b/include/drm/ttm/ttm_device.h
@@ -225,6 +225,11 @@ struct ttm_device {
 	 */
 	const struct ttm_device_funcs *funcs;
 
+	/**
+	 * @dma_coherent: if the device backed is dma-coherent.
+	 */
+	bool dma_coherent;
+
 	/**
 	 * @sysman: Resource manager for the system domain.
 	 * Access via ttm_manager_type.
-- 
2.45.2


