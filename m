Return-Path: <linux-kernel+bounces-412989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F380F9D1206
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 14:36:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B22A9286839
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 13:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 351991AA1CD;
	Mon, 18 Nov 2024 13:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=imgtec.com header.i=@imgtec.com header.b="jX77FvyM"
Received: from mx07-00376f01.pphosted.com (mx07-00376f01.pphosted.com [185.132.180.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C87DB1991C6;
	Mon, 18 Nov 2024 13:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.180.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731936709; cv=none; b=fR8Y/ZgGxY7m/Qyq4O73ivdyo6a/6vNMQaYAWNusjDB7orl/3MCNey9IHwauN51SDXjplf95rs6SLhtEUTPtdcX4ByR8VFhVfh0s0aTr4b2cmaN868aw6WbkoUtmM5WTfcv9zvO/0eG1nxneoCUjARqFtW40EqmKl/WotuoMqAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731936709; c=relaxed/simple;
	bh=rWy61drYG1g8qJQXmbkjbOprY32kpIq9NVAI4UaSGco=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=e1cAG2GuuLTPGahtyBcEv966+Omk/IiSKkNxmSO3HhGOg6YMLQyVFT4UpeCt2CrUNNrAJlD6nJUElApV+4h/Wo7tm4oI5DvFaNXYd8W76QD6foaYe5KPe3y3owEPI+ZajOlO4OLmn7Oeyjiokg8lVzJQLhph+Aa25Wa2tStxnIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=imgtec.com; spf=pass smtp.mailfrom=imgtec.com; dkim=pass (2048-bit key) header.d=imgtec.com header.i=@imgtec.com header.b=jX77FvyM; arc=none smtp.client-ip=185.132.180.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=imgtec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=imgtec.com
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
	by mx07-00376f01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AICKePm029230;
	Mon, 18 Nov 2024 13:02:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=dk201812; bh=V
	n1Fmy5jg9YT1plb2/PuY9/HTzQ7Xtj5GuosuHWLuOI=; b=jX77FvyMwXh8VGXct
	xRwMJClWShfec3y/DEmOpbE73DJCQjuDQRwp0a4mXhWAgbu/1xu/cYj3PPral8lS
	6wetd8ga/vKArQ75jKS9LPNH3A3A8cA7TiOxdEztMy0cJL+kYy4o/zGuZXFvGrkv
	QDaL5zZoYhpDj/bYIEG4AHu74ll6ENEPw+pTU4lqEQGoLRXplStleIvBB7vWU/LJ
	d7HpCtwy05P7/smKAXJ1Ve5gssKj3Z3Xxl+QBKx8cEebsj/1GyS6jlER6s2bs75W
	NJW5s8M3KFRc2dnNAeq2+619lNeywEuSf/181ApImdW4eAiWb5T4hK17uPqg3VSW
	1x0lQ==
Received: from hhmail05.hh.imgtec.org (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
	by mx07-00376f01.pphosted.com (PPS) with ESMTPS id 42xmc1hmj2-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 18 Nov 2024 13:02:39 +0000 (GMT)
Received: from
 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa
 (172.25.16.114) by HHMAIL05.hh.imgtec.org (10.100.10.120) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.37; Mon, 18 Nov 2024 13:02:38 +0000
From: Matt Coster <matt.coster@imgtec.com>
Date: Mon, 18 Nov 2024 13:02:03 +0000
Subject: [PATCH v2 11/21] drm/imagination: Rename event_mask -> status_mask
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241118-sets-bxs-4-64-patch-v1-v2-11-3fd45d9fb0cf@imgtec.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2990;
 i=matt.coster@imgtec.com; h=from:subject:message-id;
 bh=rWy61drYG1g8qJQXmbkjbOprY32kpIq9NVAI4UaSGco=;
 b=owGbwMvMwCFWuUfy8817WRsYT6slMaRbWz1dorCpjyecP8NjwUmBPQ8ut87yFE7vKyrqETq0l
 MfC44hcRykLgxgHg6yYIsuOFZYr1P6oaUnc+FUMM4eVCWQIAxenAEzkFy8jw/TFnzvFMr/fmFz0
 a9K7yXoPznNWiXz8e8xYJ/i9Rdt9e2mG32yJMfy5r9LDNhrVsx89tc54qdvCS0YpsSJLovs/qDH
 38QMA
X-Developer-Key: i=matt.coster@imgtec.com; a=openpgp;
 fpr=05A40CFCE7269D61D97100A1747F0A9036F90DFA
X-EXCLAIMER-MD-CONFIG: 15a78312-3e47-46eb-9010-2e54d84a9631
X-Proofpoint-ORIG-GUID: eZR7j0PLhdbcxUbfD0S7SSaiENFpHz3-
X-Authority-Analysis: v=2.4 cv=E4efprdl c=1 sm=1 tr=0 ts=673b3aef cx=c_pps a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17 a=hzDjp0mCheYA:10 a=IkcTkHD0fZMA:10 a=VlfZXiiP6vEA:10 a=VwQbUJbxAAAA:8 a=r_1tXGB3AAAA:8 a=p4D1_cOVMSrVH2uAJTwA:9
 a=QEXdDO2ut3YA:10 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-GUID: eZR7j0PLhdbcxUbfD0S7SSaiENFpHz3-

Now that enable_reg isn't used, rename the previously shared event_mask to
status_mask since it's only used with status_reg.

Signed-off-by: Matt Coster <matt.coster@imgtec.com>
---
Changes in v2:
- None
- Link to v1: https://lore.kernel.org/r/20241105-sets-bxs-4-64-patch-v1-v1-11-4ed30e865892@imgtec.com
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


