Return-Path: <linux-kernel+bounces-412969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A17E89D11E1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 14:30:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61115284AD6
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 13:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DD2D1A9B3D;
	Mon, 18 Nov 2024 13:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=imgtec.com header.i=@imgtec.com header.b="adq82mf8"
Received: from mx07-00376f01.pphosted.com (mx07-00376f01.pphosted.com [185.132.180.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB861A08A4;
	Mon, 18 Nov 2024 13:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.180.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731936589; cv=none; b=adX9Hgqw5PlyKbjOV/boLzC0/pZa/tUTywIpmzOFQ+mey9UNiGEwSz0AY6KfMEU80YfRAuJz95jn96C1jU6XKTSndm/IrIzpQFqtYUyYzjpZKM7l3ZJyf42UHrurCdudVqT0H56olrVvFIniBYMjG1Y0L0Ry7pI9CVy6+nn8lNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731936589; c=relaxed/simple;
	bh=fHj5SUJX98oTI0Lq7eQ/770V1/Ls+9Q5P+UrUicuRrc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=RSD9MVPpsZaVpR+5UIroWaFpBwvsJR0M5BSZWUNMCCwrlsAU51ym6+uKVzrfsIe5gl/3LdmKX0woNovrfg+HBf+eCTfR+oZNRWh7ZAF3Kht0dVQd0yNbkxNreEkLyGI8qyk2AeFpoWsunUpfQ+CtW8bsgj1hYybmAdx3MrIfY/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=imgtec.com; spf=pass smtp.mailfrom=imgtec.com; dkim=pass (2048-bit key) header.d=imgtec.com header.i=@imgtec.com header.b=adq82mf8; arc=none smtp.client-ip=185.132.180.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=imgtec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=imgtec.com
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
	by mx07-00376f01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AICK2Ap027968;
	Mon, 18 Nov 2024 13:02:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=dk201812; bh=2
	IKe+I9uZeIuSgyOafwq9J+0/n9X+I04Mh6gdPIr52o=; b=adq82mf8/ZfaJB9Sf
	WyV+jG1o2KhmTn2J+Ib98oICmLdWuOnu5CC0FvT7ilVRd0KSGq1fOG6nFITiEHUF
	VISiswTL0vhyluLky9PuK+j+UF0Pz+eJr5BIWRgaxmus5OJCaoe8VOOvBOEsBIS/
	Ae7uc9tfUlRK8PIT2xtvppVdXO3kEx1iT9+uACt5t496IBcXw286FjJU0hhHWvoP
	u5NGyqUR1A568sjvRNtEBblW+1aDdwLFUzkyCrHexsF6Dbdb84Z6eFbWniqyrLjX
	GNYaOYz/8lxB4BYDvXdHd2daWoqY9bvaIpr6x+HGLs4lpJ3FpqEvh63atrGJYoY+
	hYiQQ==
Received: from hhmail05.hh.imgtec.org (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
	by mx07-00376f01.pphosted.com (PPS) with ESMTPS id 42xmc1hmj6-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 18 Nov 2024 13:02:45 +0000 (GMT)
Received: from
 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa
 (172.25.16.114) by HHMAIL05.hh.imgtec.org (10.100.10.120) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.37; Mon, 18 Nov 2024 13:02:44 +0000
From: Matt Coster <matt.coster@imgtec.com>
Date: Mon, 18 Nov 2024 13:02:12 +0000
Subject: [PATCH v2 20/21] drm/imagination: Add support for TI AM68 GPU
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241118-sets-bxs-4-64-patch-v1-v2-20-3fd45d9fb0cf@imgtec.com>
References: <20241118-sets-bxs-4-64-patch-v1-v2-0-3fd45d9fb0cf@imgtec.com>
In-Reply-To: <20241118-sets-bxs-4-64-patch-v1-v2-0-3fd45d9fb0cf@imgtec.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1758;
 i=matt.coster@imgtec.com; h=from:subject:message-id;
 bh=fHj5SUJX98oTI0Lq7eQ/770V1/Ls+9Q5P+UrUicuRrc=;
 b=owGbwMvMwCFWuUfy8817WRsYT6slMaRbWz1j2nqbJdvuwZ9qZsNzV1xNjBhPfMuVty/nemumb
 +nsKFvZUcrCIMbBICumyLJjheUKtT9qWhI3fhXDzGFlAhnCwMUpABM5foGRofHa9QMxHXvrb4Qr
 KhY9PzNl5smJ2e+WlVictHVhnG/n3sjwTyl55ykWyym7ZMwuMyvZ85WYrZrGO2399V8S7yNSP2w
 rYgcA
X-Developer-Key: i=matt.coster@imgtec.com; a=openpgp;
 fpr=05A40CFCE7269D61D97100A1747F0A9036F90DFA
X-EXCLAIMER-MD-CONFIG: 15a78312-3e47-46eb-9010-2e54d84a9631
X-Proofpoint-ORIG-GUID: Gm9T2arOhYBj5Ykiv0Uqxmb0hqgGbpsl
X-Authority-Analysis: v=2.4 cv=E4efprdl c=1 sm=1 tr=0 ts=673b3af5 cx=c_pps a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17 a=hzDjp0mCheYA:10 a=IkcTkHD0fZMA:10 a=VlfZXiiP6vEA:10 a=VwQbUJbxAAAA:8 a=r_1tXGB3AAAA:8 a=pgiMTOZqGIwqrSltCJAA:9
 a=QEXdDO2ut3YA:10 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-GUID: Gm9T2arOhYBj5Ykiv0Uqxmb0hqgGbpsl

Add the new compatible string recently introduced in the dt bindings
("img,img-bxs-4-64") to the dt_match table and link the appropriate
firmware.

Signed-off-by: Matt Coster <matt.coster@imgtec.com>
---
Changes in v2:
- None
- Link to v1: https://lore.kernel.org/r/20241105-sets-bxs-4-64-patch-v1-v1-20-4ed30e865892@imgtec.com
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


