Return-Path: <linux-kernel+bounces-396744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 138799BD179
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 17:02:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEACE1F229C6
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 16:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EA9817BB28;
	Tue,  5 Nov 2024 15:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=imgtec.com header.i=@imgtec.com header.b="lph8tXqV"
Received: from mx08-00376f01.pphosted.com (mx08-00376f01.pphosted.com [91.207.212.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F42F1384B3;
	Tue,  5 Nov 2024 15:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730822388; cv=none; b=XYVOmDHhjWbSmaPCczBWYXDfMz0+HZHgtBA6zxwdlPZU2Y4K05L4hC58Yv2PMzZdykNL5LjXdwMVrq461Sm/IEaNfyn+lZeinmFTIHqkwSLs3LWdByIfakVnqBel2AyEkzoURuifxG0RrJ3RJXOzhvO1IR0gSDHLQZmSKv3BH2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730822388; c=relaxed/simple;
	bh=2HpRktmfy1U6jr8J3ea/Pgv7sNS8R2Iklnor8GHoR+8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=WQ3yI7bmk141uSyWE1Vk1wto0QuH0lnNuCJTloHsG8nDIgDP0qvIbRsxN3+JziXhlrPMvryYiOKyF3y1xVMY1yX3alOWSRgAINDd8uxf2Cnk5PJ4PbD7WtL9sPvTKkrBHteids35RdqO+qIEmNBY+6UDJW8EWxCm4mIBZceL1v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=imgtec.com; spf=pass smtp.mailfrom=imgtec.com; dkim=pass (2048-bit key) header.d=imgtec.com header.i=@imgtec.com header.b=lph8tXqV; arc=none smtp.client-ip=91.207.212.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=imgtec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=imgtec.com
Received: from pps.filterd (m0168888.ppops.net [127.0.0.1])
	by mx08-00376f01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A5BvcWo014025;
	Tue, 5 Nov 2024 15:58:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=dk201812; bh=r
	Bg5+36qAG3/U6TCUA7nVYufsOJ9DF8ZQP7Y/0/CzU4=; b=lph8tXqVOWGVH40Fy
	pLzu4cLxFFUm29ewGjAfk6hoThm0AlX8kQAvPirkQVe7iovgrRKV73HhuMGrl6f/
	Uu7cIG517nHkZH2jJxxxeytcYEJPj1cGY0Mm6rLQO2FguUcEtuSNCsM1YzA4/7L2
	CmKVJIp/nRPBd+L5XxHlk2NkH7Q7LeI+wB9JFUngWvlkeow3NWEPD2jD48QztJNu
	btX40fZWi3rpFFM7b+i90vdhtdVTLQ4055TEmg/x3Bj+ZYRhoqoR1re2lCu48zNB
	FXpJjsP5dfn5I8Ix1WgZKPQlQz6lv7wkAStNZWdtHEWUGF0bY6qK7HbcImsACAml
	1IU/A==
Received: from hhmail05.hh.imgtec.org (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
	by mx08-00376f01.pphosted.com (PPS) with ESMTPS id 42nb7wta0w-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 05 Nov 2024 15:58:35 +0000 (GMT)
Received: from
 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa
 (172.25.16.114) by HHMAIL05.hh.imgtec.org (10.100.10.120) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.37; Tue, 5 Nov 2024 15:58:34 +0000
From: Matt Coster <matt.coster@imgtec.com>
Date: Tue, 5 Nov 2024 15:58:21 +0000
Subject: [PATCH 15/21] drm/imagination: Add register required for RISC-V
 firmware
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241105-sets-bxs-4-64-patch-v1-v1-15-4ed30e865892@imgtec.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2059;
 i=matt.coster@imgtec.com; h=from:subject:message-id;
 bh=2HpRktmfy1U6jr8J3ea/Pgv7sNS8R2Iklnor8GHoR+8=;
 b=owGbwMvMwCFWuUfy8817WRsYT6slMaRrOcybuc3cb/W12IWiZiYCXIGP7Gdd7JXo89x+vCBb4
 pLnuuqYjlIWBjEOBlkxRZYdKyxXqP1R05K48asYZg4rE8gQBi5OAZgIgxsjw0kfizPHT/RK8BcV
 RQmpbt+zMKsy5zfHxNRP7wvlJPOWJTH8d08w8Nx/zHCfz6vVz+7xP/tuE/c2qD545YwlglK3ua3
 deAA=
X-Developer-Key: i=matt.coster@imgtec.com; a=openpgp;
 fpr=05A40CFCE7269D61D97100A1747F0A9036F90DFA
X-EXCLAIMER-MD-CONFIG: 15a78312-3e47-46eb-9010-2e54d84a9631
X-Authority-Analysis: v=2.4 cv=ddzS3mXe c=1 sm=1 tr=0 ts=672a40ab cx=c_pps a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17 a=hzDjp0mCheYA:10 a=IkcTkHD0fZMA:10 a=VlfZXiiP6vEA:10 a=r_1tXGB3AAAA:8 a=7nAL0jd3kcEsRNnToT4A:9 a=QEXdDO2ut3YA:10
 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-GUID: GEJNvXW4nWR-VrQzYuyh-Sm4pi7y_bAI
X-Proofpoint-ORIG-GUID: GEJNvXW4nWR-VrQzYuyh-Sm4pi7y_bAI

Add definitions for a register required for a subsequent patch adding
support for RISC-V firmware. ROGUE_CR_FWCORE_DMI_DMCONTROL is used to
control the debug module in the firmware processor.

Signed-off-by: Matt Coster <matt.coster@imgtec.com>
---
 drivers/gpu/drm/imagination/pvr_rogue_cr_defs.h | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/imagination/pvr_rogue_cr_defs.h b/drivers/gpu/drm/imagination/pvr_rogue_cr_defs.h
index 2a90d02796d3e071b18e18dead105e29798bcddc..4e99832a667a2d88ee21469595d3abdad3a07c06 100644
--- a/drivers/gpu/drm/imagination/pvr_rogue_cr_defs.h
+++ b/drivers/gpu/drm/imagination/pvr_rogue_cr_defs.h
@@ -3751,7 +3751,22 @@
 
 /* Register ROGUE_CR_FWCORE_DMI_DMCONTROL */
 #define ROGUE_CR_FWCORE_DMI_DMCONTROL 0x3480U
-#define ROGUE_CR_FWCORE_DMI_DMCONTROL_MASKFULL 0x0000000000000000ULL
+#define ROGUE_CR_FWCORE_DMI_DMCONTROL_MASKFULL 0x00000000D0000003ULL
+#define ROGUE_CR_FWCORE_DMI_DMCONTROL_HALTREQ_SHIFT 31U
+#define ROGUE_CR_FWCORE_DMI_DMCONTROL_HALTREQ_CLRMSK 0x7FFFFFFFULL
+#define ROGUE_CR_FWCORE_DMI_DMCONTROL_HALTREQ_EN 0x80000000ULL
+#define ROGUE_CR_FWCORE_DMI_DMCONTROL_RESUMEREQ_SHIFT 30U
+#define ROGUE_CR_FWCORE_DMI_DMCONTROL_RESUMEREQ_CLRMSK 0xBFFFFFFFULL
+#define ROGUE_CR_FWCORE_DMI_DMCONTROL_RESUMEREQ_EN 0x40000000ULL
+#define ROGUE_CR_FWCORE_DMI_DMCONTROL_ACKHAVERESET_SHIFT 28U
+#define ROGUE_CR_FWCORE_DMI_DMCONTROL_ACKHAVERESET_CLRMSK 0xEFFFFFFFULL
+#define ROGUE_CR_FWCORE_DMI_DMCONTROL_ACKHAVERESET_EN 0x10000000ULL
+#define ROGUE_CR_FWCORE_DMI_DMCONTROL_NDMRESET_SHIFT 1U
+#define ROGUE_CR_FWCORE_DMI_DMCONTROL_NDMRESET_CLRMSK 0xFFFFFFFDULL
+#define ROGUE_CR_FWCORE_DMI_DMCONTROL_NDMRESET_EN 0x00000002ULL
+#define ROGUE_CR_FWCORE_DMI_DMCONTROL_DMACTIVE_SHIFT 0U
+#define ROGUE_CR_FWCORE_DMI_DMCONTROL_DMACTIVE_CLRMSK 0xFFFFFFFEULL
+#define ROGUE_CR_FWCORE_DMI_DMCONTROL_DMACTIVE_EN 0x00000001ULL
 
 /* Register ROGUE_CR_FWCORE_DMI_DMSTATUS */
 #define ROGUE_CR_FWCORE_DMI_DMSTATUS 0x3488U

-- 
2.47.0


