Return-Path: <linux-kernel+bounces-396750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B52CD9BD18F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 17:03:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 444C11F23CA5
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 16:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE2061E7C2A;
	Tue,  5 Nov 2024 15:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=imgtec.com header.i=@imgtec.com header.b="E1FHgtF6"
Received: from mx07-00376f01.pphosted.com (mx07-00376f01.pphosted.com [185.132.180.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E60114A4DC;
	Tue,  5 Nov 2024 15:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.180.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730822390; cv=none; b=KgBNLmp1vv+skwgMHKwZvCGEg0pjCvE5yK4sqe9yw/XNeqXsEzVKNzLB47yg1Ap7bmJvBGqfQ1xr0UdoLO7fDnRwQ6ZeWU2wNsIhqKqJP9EsAOQl4+d3S5+bcoj7DK61NAOgvuGo3zvGz4q6FFEFFdb5o9T8tJt2l9ItcO0mZVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730822390; c=relaxed/simple;
	bh=YKllC2FPBj79tfeRDTnn/JW4sODYApDae5OtCzP4rKE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=GisJsHCSpo+LGlu234vNF/Otrf1nNHG/zfnDohGwTsWFEdJ4tecskqXs+TQbe0aoiPLjebGMaf1N8zWFd5rsXw6r5CLQOcWW5We4LZ+6P2GTCXbqINfWIEbX/lh7VPJJ3hUZibmqNigSNPj+AxNFIXXl5JF7w18p/tS7GmhNGFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=imgtec.com; spf=pass smtp.mailfrom=imgtec.com; dkim=pass (2048-bit key) header.d=imgtec.com header.i=@imgtec.com header.b=E1FHgtF6; arc=none smtp.client-ip=185.132.180.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=imgtec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=imgtec.com
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
	by mx07-00376f01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A58CTKY021812;
	Tue, 5 Nov 2024 15:58:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=dk201812; bh=J
	M3SnxOHwcOpF8ao6TSQfnDpwCCZUBtJaDvUcBXITKU=; b=E1FHgtF67Il4VK/G6
	mrALPiw5yrnlD+uZ8tpi88CfYeM7eIN1J7ymezBn0pADriSuwdATKKsL0d4WL0Nx
	Mzg6ho8IqBg2aXiIAVUaNuTBi3uUwwmBASQjvGUuDsYjYEQ4UNi1JSAtylUd3oAx
	ijOKYD29RILc4Xkf9FM3fyMoDbkb6FIcdeUTnBh8FDfEMuOp1BJWBTZD+z0CdEGI
	zzE2Kzcp+pdtol7XhSN55jN4kMQ3eQ5yaDqqF9sEiYw+c0wFgUceTMeerYToGJdq
	bUbvqXj2MSRgz3pAkGOXy7S7bP/uDmD5Nc92sL584Mm0KNwk6/ZJw0KIdWfil2bI
	LotDg==
Received: from hhmail05.hh.imgtec.org (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
	by mx07-00376f01.pphosted.com (PPS) with ESMTPS id 42nd212ju0-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 05 Nov 2024 15:58:33 +0000 (GMT)
Received: from
 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa
 (172.25.16.114) by HHMAIL05.hh.imgtec.org (10.100.10.120) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.37; Tue, 5 Nov 2024 15:58:32 +0000
From: Matt Coster <matt.coster@imgtec.com>
Date: Tue, 5 Nov 2024 15:58:18 +0000
Subject: [PATCH 12/21] drm/imagination: Make has_fixed_data_addr a value
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241105-sets-bxs-4-64-patch-v1-v1-12-4ed30e865892@imgtec.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4703;
 i=matt.coster@imgtec.com; h=from:subject:message-id;
 bh=YKllC2FPBj79tfeRDTnn/JW4sODYApDae5OtCzP4rKE=;
 b=owGbwMvMwCFWuUfy8817WRsYT6slMaRrOcz7s2JCzN2GnS3fTh08cGwX19FLNw90z5v735aJt
 /fiuomHH3eUsjCIcTDIiimy7FhhuULtj5qWxI1fxTBzWJlAhjBwcQrARHbaMPwv9UtazTSHNSHH
 7L14+5e6Tsutz3ROmyV+nLcvOme/9wUThr9iHNEVM7iq564vti/+c2Db6sNF21PnBnk9vvFAeom
 H2U8OAA==
X-Developer-Key: i=matt.coster@imgtec.com; a=openpgp;
 fpr=05A40CFCE7269D61D97100A1747F0A9036F90DFA
X-EXCLAIMER-MD-CONFIG: 15a78312-3e47-46eb-9010-2e54d84a9631
X-Authority-Analysis: v=2.4 cv=Q9aA4J2a c=1 sm=1 tr=0 ts=672a40a9 cx=c_pps a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17 a=hzDjp0mCheYA:10 a=IkcTkHD0fZMA:10 a=VlfZXiiP6vEA:10 a=r_1tXGB3AAAA:8 a=AL3HUg9UsffDM1cGjbgA:9 a=QEXdDO2ut3YA:10
 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-GUID: THkoO3cYX8MLkLZgYWpVtJHYvPup68B7
X-Proofpoint-ORIG-GUID: THkoO3cYX8MLkLZgYWpVtJHYvPup68B7

This is currently a callback function which takes no parameters; there's
no reason for this so let's make it a straightforward value in pvr_fw_defs.

Signed-off-by: Matt Coster <matt.coster@imgtec.com>
---
 drivers/gpu/drm/imagination/pvr_fw.c      |  2 +-
 drivers/gpu/drm/imagination/pvr_fw.h      | 23 ++++++++---------------
 drivers/gpu/drm/imagination/pvr_fw_meta.c |  8 +-------
 drivers/gpu/drm/imagination/pvr_fw_mips.c |  8 +-------
 4 files changed, 11 insertions(+), 30 deletions(-)

diff --git a/drivers/gpu/drm/imagination/pvr_fw.c b/drivers/gpu/drm/imagination/pvr_fw.c
index 9c8929d8602ead3390aa5c1b2505845b961b1406..808844eb10b5ccb29ed2b8e9bdfe3be829cc57d1 100644
--- a/drivers/gpu/drm/imagination/pvr_fw.c
+++ b/drivers/gpu/drm/imagination/pvr_fw.c
@@ -663,7 +663,7 @@ pvr_fw_process(struct pvr_device *pvr_dev)
 		return PTR_ERR(fw_code_ptr);
 	}
 
-	if (pvr_dev->fw_dev.defs->has_fixed_data_addr()) {
+	if (pvr_dev->fw_dev.defs->has_fixed_data_addr) {
 		u32 base_addr = private_data->base_addr & pvr_dev->fw_dev.fw_heap_info.offset_mask;
 
 		fw_data_ptr =
diff --git a/drivers/gpu/drm/imagination/pvr_fw.h b/drivers/gpu/drm/imagination/pvr_fw.h
index eead744835726712622d5aba9b3480fe264a089f..180d310074e3585c641e540a9e2576b5ab2a5705 100644
--- a/drivers/gpu/drm/imagination/pvr_fw.h
+++ b/drivers/gpu/drm/imagination/pvr_fw.h
@@ -166,21 +166,6 @@ struct pvr_fw_defs {
 	 */
 	int (*wrapper_init)(struct pvr_device *pvr_dev);
 
-	/**
-	 * @has_fixed_data_addr:
-	 *
-	 * Called to check if firmware fixed data must be loaded at the address given by the
-	 * firmware layout table.
-	 *
-	 * This function is mandatory.
-	 *
-	 * Returns:
-	 *  * %true if firmware fixed data must be loaded at the address given by the firmware
-	 *    layout table.
-	 *  * %false otherwise.
-	 */
-	bool (*has_fixed_data_addr)(void);
-
 	/**
 	 * @irq: FW Interrupt information.
 	 *
@@ -205,6 +190,14 @@ struct pvr_fw_defs {
 		/** @clear_mask: Value to write to the clear_reg in order to clear FW IRQs. */
 		u32 clear_mask;
 	} irq;
+
+	/**
+	 * @has_fixed_data_addr: Specify whether the firmware fixed data must be loaded at the
+	 *                       address given by the firmware layout table.
+	 *
+	 * This value is mandatory.
+	 */
+	bool has_fixed_data_addr;
 };
 
 /**
diff --git a/drivers/gpu/drm/imagination/pvr_fw_meta.c b/drivers/gpu/drm/imagination/pvr_fw_meta.c
index cf86701ca8f14920329ccb4c2811424b0c394b14..4433b04e0adb3684b86a4e90f63d670a81ecd826 100644
--- a/drivers/gpu/drm/imagination/pvr_fw_meta.c
+++ b/drivers/gpu/drm/imagination/pvr_fw_meta.c
@@ -531,12 +531,6 @@ pvr_meta_vm_unmap(struct pvr_device *pvr_dev, struct pvr_fw_object *fw_obj)
 		     fw_obj->fw_mm_node.size);
 }
 
-static bool
-pvr_meta_has_fixed_data_addr(void)
-{
-	return false;
-}
-
 const struct pvr_fw_defs pvr_fw_defs_meta = {
 	.init = pvr_meta_init,
 	.fw_process = pvr_meta_fw_process,
@@ -544,11 +538,11 @@ const struct pvr_fw_defs pvr_fw_defs_meta = {
 	.vm_unmap = pvr_meta_vm_unmap,
 	.get_fw_addr_with_offset = pvr_meta_get_fw_addr_with_offset,
 	.wrapper_init = pvr_meta_wrapper_init,
-	.has_fixed_data_addr = pvr_meta_has_fixed_data_addr,
 	.irq = {
 		.status_reg = ROGUE_CR_META_SP_MSLVIRQSTATUS,
 		.clear_reg = ROGUE_CR_META_SP_MSLVIRQSTATUS,
 		.status_mask = ROGUE_CR_META_SP_MSLVIRQSTATUS_TRIGVECT2_EN,
 		.clear_mask = ROGUE_CR_META_SP_MSLVIRQSTATUS_TRIGVECT2_CLRMSK,
 	},
+	.has_fixed_data_addr = false,
 };
diff --git a/drivers/gpu/drm/imagination/pvr_fw_mips.c b/drivers/gpu/drm/imagination/pvr_fw_mips.c
index f195c602bb112066e88210d0106cb5ffc0a9abc6..2c3172841886b70eb7a9992ec3851f18adcad8d5 100644
--- a/drivers/gpu/drm/imagination/pvr_fw_mips.c
+++ b/drivers/gpu/drm/imagination/pvr_fw_mips.c
@@ -227,12 +227,6 @@ pvr_mips_get_fw_addr_with_offset(struct pvr_fw_object *fw_obj, u32 offset)
 	       ROGUE_FW_HEAP_MIPS_BASE;
 }
 
-static bool
-pvr_mips_has_fixed_data_addr(void)
-{
-	return true;
-}
-
 const struct pvr_fw_defs pvr_fw_defs_mips = {
 	.init = pvr_mips_init,
 	.fini = pvr_mips_fini,
@@ -241,11 +235,11 @@ const struct pvr_fw_defs pvr_fw_defs_mips = {
 	.vm_unmap = pvr_vm_mips_unmap,
 	.get_fw_addr_with_offset = pvr_mips_get_fw_addr_with_offset,
 	.wrapper_init = pvr_mips_wrapper_init,
-	.has_fixed_data_addr = pvr_mips_has_fixed_data_addr,
 	.irq = {
 		.status_reg = ROGUE_CR_MIPS_WRAPPER_IRQ_STATUS,
 		.clear_reg = ROGUE_CR_MIPS_WRAPPER_IRQ_CLEAR,
 		.status_mask = ROGUE_CR_MIPS_WRAPPER_IRQ_STATUS_EVENT_EN,
 		.clear_mask = ROGUE_CR_MIPS_WRAPPER_IRQ_CLEAR_EVENT_EN,
 	},
+	.has_fixed_data_addr = true,
 };

-- 
2.47.0


