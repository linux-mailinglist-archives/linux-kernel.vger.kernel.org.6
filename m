Return-Path: <linux-kernel+bounces-396754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3B509BD192
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 17:03:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01DF81C2210F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 16:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 250061E885A;
	Tue,  5 Nov 2024 15:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=imgtec.com header.i=@imgtec.com header.b="xY7A9+/6"
Received: from mx07-00376f01.pphosted.com (mx07-00376f01.pphosted.com [185.132.180.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3508C166F25;
	Tue,  5 Nov 2024 15:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.180.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730822391; cv=none; b=n5AlPLx7O1TpvH9uaGgtKv5DAwhWfB7gM9rGUOzsKnxx2B7ObRFzmv0UM1im45RCumnow3xLgCNvDJTi9AGhk1v7UEE6KQp2cnLNnQYSnTMQW9yBevi2RvlDv0PvB6Sn3jy+nU2dRHUz1vDLoElxEAeP74LttEz93KDR9O4TWPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730822391; c=relaxed/simple;
	bh=OZVGgc8hLLq0l4OrdMvxHF8MYZOQdKdzg5JiDqdO5e4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=OfybcwXdyL17O7kVpWprQ7GoL5/Cg2knMLsIdPtCkDhBbI2OluSHdCuBOWU8ZgkbRziY/6QFqmC9SGi80I4dPOlYoa+t9lFE7+4xpgrlWMKcJomHi/L9EQLz18tUm+lb/8Yrp2A/1gJluSFh9ssh0Q3jCfrvp2PaJ7imupoxXMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=imgtec.com; spf=pass smtp.mailfrom=imgtec.com; dkim=pass (2048-bit key) header.d=imgtec.com header.i=@imgtec.com header.b=xY7A9+/6; arc=none smtp.client-ip=185.132.180.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=imgtec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=imgtec.com
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
	by mx07-00376f01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A58CTKa021812;
	Tue, 5 Nov 2024 15:58:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=dk201812; bh=p
	nyS/qr7yXjDVVSPTyP/1yiwNThF0zJQHksf118gXs4=; b=xY7A9+/6ABLbUoF3B
	IF24KoOoqxztdAZoElnsb41XYVi1BAlPUXOtpfWk7mSkMPkgGB+o1PKlfWBu2uYV
	V4GCwXloLMLvCFus4qUyOuklQgcsyR6wtlAhtUUQkrFudArXgWe0gz/csvb6Wvw1
	BvSqA7hTSE/CNHdv/K3FairMMecDveib3NhEVS9uMRsr6ntX24iSAj/UEWiW0Dzy
	hsh8+gtf4rsKtQlqNmDvo2nztrVoRWH6pwXbXE4m4ZYcsxKrIc2BYb59e2SWjrVS
	aW9WYWFsG34fSuqfZseXyTHSPjDz5kpv6CU8yojgh3ppI1/JU/lrUpft/erE5nsX
	3EBvQ==
Received: from hhmail05.hh.imgtec.org (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
	by mx07-00376f01.pphosted.com (PPS) with ESMTPS id 42nd212ju3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 05 Nov 2024 15:58:40 +0000 (GMT)
Received: from
 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa
 (172.25.16.114) by HHMAIL05.hh.imgtec.org (10.100.10.120) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.37; Tue, 5 Nov 2024 15:58:38 +0000
From: Matt Coster <matt.coster@imgtec.com>
Date: Tue, 5 Nov 2024 15:58:26 +0000
Subject: [PATCH 20/21] drm/imagination: Add support for TI AM68 GPU
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241105-sets-bxs-4-64-patch-v1-v1-20-4ed30e865892@imgtec.com>
References: <20241105-sets-bxs-4-64-patch-v1-v1-0-4ed30e865892@imgtec.com>
In-Reply-To: <20241105-sets-bxs-4-64-patch-v1-v1-0-4ed30e865892@imgtec.com>
To: Frank Binns <frank.binns@imgtec.com>,
        Matt Coster
	<matt.coster@imgtec.com>,
        David Airlie <airlied@gmail.com>, Simona Vetter
	<simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
        "Vignesh
 Raghavendra" <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>
CC: <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        Randolph Sapp <rs@ti.com>, Darren Etheridge <detheridge@ti.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1626;
 i=matt.coster@imgtec.com; h=from:subject:message-id;
 bh=OZVGgc8hLLq0l4OrdMvxHF8MYZOQdKdzg5JiDqdO5e4=;
 b=owGbwMvMwCFWuUfy8817WRsYT6slMaRrOcz/P53nWPKS/t+usr90OXdVRLxd7Dt1lc45gZA9H
 HVfA/gKO0pZGMQ4GGTFFFl2rLBcofZHTUvixq9imDmsTCBDGLg4BWAirgcZ/peamYspTGt4t2aV
 sXGa3COtKb8vPqoW+xBQKebOPilZK5aRYfPBgPk7vy5R2m0UfXuXNgtXzBSuFs/FEx8eqLE7uMQ
 uih0A
X-Developer-Key: i=matt.coster@imgtec.com; a=openpgp;
 fpr=05A40CFCE7269D61D97100A1747F0A9036F90DFA
X-EXCLAIMER-MD-CONFIG: 15a78312-3e47-46eb-9010-2e54d84a9631
X-Authority-Analysis: v=2.4 cv=Q9aA4J2a c=1 sm=1 tr=0 ts=672a40b0 cx=c_pps a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17 a=hzDjp0mCheYA:10 a=IkcTkHD0fZMA:10 a=VlfZXiiP6vEA:10 a=r_1tXGB3AAAA:8 a=G3R7v66XuqknrrS5BZUA:9 a=QEXdDO2ut3YA:10
 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-GUID: PWOKNB7M5R3BIVhXr528Nl2IpSHRnmi-
X-Proofpoint-ORIG-GUID: PWOKNB7M5R3BIVhXr528Nl2IpSHRnmi-

Add the new compatible string recently introduced in the dt bindings
("img,img-bxs-4-64") to the dt_match table and link the appropriate
firmware.

Signed-off-by: Matt Coster <matt.coster@imgtec.com>
---
 drivers/gpu/drm/imagination/pvr_drv.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/imagination/pvr_drv.c b/drivers/gpu/drm/imagination/pvr_drv.c
index e074cfb0d2055b5387dbb142ca972108977f9854..044321cab1114864aefa2ca0024f326ac52d4dd6 100644
--- a/drivers/gpu/drm/imagination/pvr_drv.c
+++ b/drivers/gpu/drm/imagination/pvr_drv.c
@@ -44,6 +44,7 @@
  * This driver supports the following PowerVR/IMG graphics cores from Imagination Technologies:
  *
  * * AXE-1-16M (found in Texas Instruments AM62)
+ * * BXS-4-64 MC1 (found in Texas Instruments J721S2/AM68)
  */
 
 /**
@@ -1501,6 +1502,12 @@ static const struct of_device_id dt_match[] = {
 
 	/* All supported GPU models */
 	{ .compatible = "img,img-axe-1-16m", .data = &pvr_device_overrides_default },
+	{ .compatible = "img,img-bxs-4-64", .data = &pvr_device_overrides_default },
+
+	/* Vendor integrations which require overrides */
+	{ .compatible = "ti,j721s2-gpu", .data = &(struct pvr_device_overrides){
+		.device_memory_force_cpu_cached = true,
+	} },
 
 	/*
 	 * This legacy compatible string was introduced early on before the more specific GPU
@@ -1532,3 +1539,4 @@ MODULE_DESCRIPTION(PVR_DRIVER_DESC);
 MODULE_LICENSE("Dual MIT/GPL");
 MODULE_IMPORT_NS(DMA_BUF);
 MODULE_FIRMWARE("powervr/rogue_33.15.11.3_v1.fw");
+MODULE_FIRMWARE("powervr/rogue_36.53.104.796_v1.fw");

-- 
2.47.0


