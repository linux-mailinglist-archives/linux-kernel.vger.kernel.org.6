Return-Path: <linux-kernel+bounces-396755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13FB29BD197
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 17:04:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 378061C20F28
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 16:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58FEF1EABA6;
	Tue,  5 Nov 2024 15:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=imgtec.com header.i=@imgtec.com header.b="gau3+xvQ"
Received: from mx07-00376f01.pphosted.com (mx07-00376f01.pphosted.com [185.132.180.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93CCE185B5D;
	Tue,  5 Nov 2024 15:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.180.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730822392; cv=none; b=TRLeEN1U2XL4GpK0DzEay8uo9SANDWdVSk73Pt8Lyornwmp3Sjd4/nngAZIjLEPXiVkHn1s3C+IYu6g8d7uPYhDKAHzIUq8piB5CNWXbDahK9vsGy9f7qppREpxzYJRitC4+4a3ZbF6WXo/AtCNAZN+9V4sRrkHpIDsG/HezNqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730822392; c=relaxed/simple;
	bh=qxoos6M/++3gTGsNRjxd7mwcPBDkjFz1O7sWnvPxwsE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=cqN+4jjdozVnLN/zOh3jWb0lF1uXmyL0+p6fkVtQwCCnzXbBC2joHZSLNaeKYSDloT40ZeAbhmTEOO0MvHlhbIPZ2jZ+Ffixdz+o5yorY5X9EAPHZJwMe7Vlhje/1EaUuUBrkQ1rKWjFAIifqZ4LGgyDYOU8ZPQSRS3ozwQGJO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=imgtec.com; spf=pass smtp.mailfrom=imgtec.com; dkim=pass (2048-bit key) header.d=imgtec.com header.i=@imgtec.com header.b=gau3+xvQ; arc=none smtp.client-ip=185.132.180.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=imgtec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=imgtec.com
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
	by mx07-00376f01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A58CTKX021812;
	Tue, 5 Nov 2024 15:58:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=dk201812; bh=4
	qRsFbrEBOarwvgC8H9fFDfbUlQviG0g984iZLcC95U=; b=gau3+xvQA+Pgcpro6
	2C4/lbf8OXCNRfCJj8qNkQPA7g8NgDhADJYT04/3xEC5fDA8sGlWJ7jG36NkZJ+s
	BOj28mc/pxk41wX0UIrivV9qAuVo9qnRTrqpQRLg5FI8EDnfiHJP3R4htpcfNPmM
	zsT6yECFuMI9j9Lxye9wVvF/wBTK7TWAn7QL3OoZmmnieJF4qQu0ZofKIX8FiUzX
	4bT0xrk+6yZfljuM3FUwqHY3Wep1ro3FLL6byHs1Q1CQTgS3OEh9aQLY3wV8INqu
	zekW731nQiAnREg1LYoC7p/Hslo4/uWZvOR2q7VDF74/B8O4ApDH1bV/FDNFNrPf
	jeiDA==
Received: from hhmail05.hh.imgtec.org (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
	by mx07-00376f01.pphosted.com (PPS) with ESMTPS id 42nd212ju0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 05 Nov 2024 15:58:33 +0000 (GMT)
Received: from
 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa
 (172.25.16.114) by HHMAIL05.hh.imgtec.org (10.100.10.120) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.37; Tue, 5 Nov 2024 15:58:31 +0000
From: Matt Coster <matt.coster@imgtec.com>
Date: Tue, 5 Nov 2024 15:58:17 +0000
Subject: [PATCH 11/21] drm/imagination: Rename event_mask -> status_mask
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241105-sets-bxs-4-64-patch-v1-v1-11-4ed30e865892@imgtec.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2858;
 i=matt.coster@imgtec.com; h=from:subject:message-id;
 bh=qxoos6M/++3gTGsNRjxd7mwcPBDkjFz1O7sWnvPxwsE=;
 b=owGbwMvMwCFWuUfy8817WRsYT6slMaRrOcz9r7jn2l395pUvu/b42tmxPK/pFtzuGGqg3qEdv
 VrkvfyijlIWBjEOBlkxRZYdKyxXqP1R05K48asYZg4rE8gQBi5OAZhIzn6GvyJhE+NN1/aXa9Rq
 KR2ZvSMkNX9a7/HFLnsXbgnhfLHQQ5qR4dR9lf0/2oPiqk5e8v9uoPHG72DU0ledoX84Wy74TNk
 qxg0A
X-Developer-Key: i=matt.coster@imgtec.com; a=openpgp;
 fpr=05A40CFCE7269D61D97100A1747F0A9036F90DFA
X-EXCLAIMER-MD-CONFIG: 15a78312-3e47-46eb-9010-2e54d84a9631
X-Authority-Analysis: v=2.4 cv=Q9aA4J2a c=1 sm=1 tr=0 ts=672a40a9 cx=c_pps a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17 a=hzDjp0mCheYA:10 a=IkcTkHD0fZMA:10 a=VlfZXiiP6vEA:10 a=r_1tXGB3AAAA:8 a=05EuaLPLoxKbehKhUMIA:9 a=QEXdDO2ut3YA:10
 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-GUID: xgHZpuMYGy9aOeqS9-s1wHFkBWH-5wVw
X-Proofpoint-ORIG-GUID: xgHZpuMYGy9aOeqS9-s1wHFkBWH-5wVw

Now that enable_reg isn't used, rename the previously shared event_mask to
status_mask since it's only used with status_reg.

Signed-off-by: Matt Coster <matt.coster@imgtec.com>
---
 drivers/gpu/drm/imagination/pvr_fw.h      | 6 +++---
 drivers/gpu/drm/imagination/pvr_fw_meta.c | 2 +-
 drivers/gpu/drm/imagination/pvr_fw_mips.c | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/imagination/pvr_fw.h b/drivers/gpu/drm/imagination/pvr_fw.h
index 29bae4bc244a243a6a95bcf838d924060cc043e2..eead744835726712622d5aba9b3480fe264a089f 100644
--- a/drivers/gpu/drm/imagination/pvr_fw.h
+++ b/drivers/gpu/drm/imagination/pvr_fw.h
@@ -199,8 +199,8 @@ struct pvr_fw_defs {
 		 */
 		u32 clear_reg;
 
-		/** @event_mask: Bitmask of events to listen for in the status_reg. */
-		u32 event_mask;
+		/** @status_mask: Bitmask of events to listen for in the status_reg. */
+		u32 status_mask;
 
 		/** @clear_mask: Value to write to the clear_reg in order to clear FW IRQs. */
 		u32 clear_mask;
@@ -404,7 +404,7 @@ struct pvr_fw_device {
 	pvr_cr_write32((pvr_dev), (pvr_dev)->fw_dev.defs->irq.name ## _reg, value)
 
 #define pvr_fw_irq_pending(pvr_dev) \
-	(pvr_fw_irq_read_reg(pvr_dev, status) & (pvr_dev)->fw_dev.defs->irq.event_mask)
+	(pvr_fw_irq_read_reg(pvr_dev, status) & (pvr_dev)->fw_dev.defs->irq.status_mask)
 
 #define pvr_fw_irq_clear(pvr_dev) \
 	pvr_fw_irq_write_reg(pvr_dev, clear, (pvr_dev)->fw_dev.defs->irq.clear_mask)
diff --git a/drivers/gpu/drm/imagination/pvr_fw_meta.c b/drivers/gpu/drm/imagination/pvr_fw_meta.c
index 76b24ad9aa221b6a384dc7b55ed2e78d2e761550..cf86701ca8f14920329ccb4c2811424b0c394b14 100644
--- a/drivers/gpu/drm/imagination/pvr_fw_meta.c
+++ b/drivers/gpu/drm/imagination/pvr_fw_meta.c
@@ -548,7 +548,7 @@ const struct pvr_fw_defs pvr_fw_defs_meta = {
 	.irq = {
 		.status_reg = ROGUE_CR_META_SP_MSLVIRQSTATUS,
 		.clear_reg = ROGUE_CR_META_SP_MSLVIRQSTATUS,
-		.event_mask = ROGUE_CR_META_SP_MSLVIRQSTATUS_TRIGVECT2_EN,
+		.status_mask = ROGUE_CR_META_SP_MSLVIRQSTATUS_TRIGVECT2_EN,
 		.clear_mask = ROGUE_CR_META_SP_MSLVIRQSTATUS_TRIGVECT2_CLRMSK,
 	},
 };
diff --git a/drivers/gpu/drm/imagination/pvr_fw_mips.c b/drivers/gpu/drm/imagination/pvr_fw_mips.c
index c810a67eeecf1016064e76baf534e31a44c859b5..f195c602bb112066e88210d0106cb5ffc0a9abc6 100644
--- a/drivers/gpu/drm/imagination/pvr_fw_mips.c
+++ b/drivers/gpu/drm/imagination/pvr_fw_mips.c
@@ -245,7 +245,7 @@ const struct pvr_fw_defs pvr_fw_defs_mips = {
 	.irq = {
 		.status_reg = ROGUE_CR_MIPS_WRAPPER_IRQ_STATUS,
 		.clear_reg = ROGUE_CR_MIPS_WRAPPER_IRQ_CLEAR,
-		.event_mask = ROGUE_CR_MIPS_WRAPPER_IRQ_STATUS_EVENT_EN,
+		.status_mask = ROGUE_CR_MIPS_WRAPPER_IRQ_STATUS_EVENT_EN,
 		.clear_mask = ROGUE_CR_MIPS_WRAPPER_IRQ_CLEAR_EVENT_EN,
 	},
 };

-- 
2.47.0


