Return-Path: <linux-kernel+bounces-569639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00E91A6A586
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 12:55:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 848F31B61307
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 11:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D52F2227E8B;
	Thu, 20 Mar 2025 11:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=imgtec.com header.i=@imgtec.com header.b="NqZOMXYH"
Received: from mx07-00376f01.pphosted.com (mx07-00376f01.pphosted.com [185.132.180.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A6EF225768;
	Thu, 20 Mar 2025 11:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.180.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742471398; cv=none; b=WroRz5wwTahppCfk3ubZvf6ZFF0uk4XOyEXzwIpEkxe+6frJvg5Iqwt+LenT43ueS/DgTfdK/7KEZ16DSNgwK+UCHJVV+fMfPq8rZCgxkPlgmvwaRWcJlHHAR40KwS2DZfW4QE+3maqEA1cmLaq8HqzXrBBqZG0PHXrW7NR9URQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742471398; c=relaxed/simple;
	bh=zspinsC/V9sAeyQBJpZd7CawZjK+6F8C1ZetDcURwDw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=BvWo9dcVWHtUJBHUx+WT4mwOmuGNSO2w7zJsKahZ+FHcgSvQuFar+5BRj4G30ap36t0qkF+47xbcHU3ROC0oeZ/8bKaAvOgOw3OZWwjl3LOabdGashGVF8Bf9zwCg6yCQwrjeQtPEU8UzFP4P1D0mvG2VusOGBblCHfI8jzD16s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=imgtec.com; spf=pass smtp.mailfrom=imgtec.com; dkim=pass (2048-bit key) header.d=imgtec.com header.i=@imgtec.com header.b=NqZOMXYH; arc=none smtp.client-ip=185.132.180.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=imgtec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=imgtec.com
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
	by mx07-00376f01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52K5Ntge021993;
	Thu, 20 Mar 2025 11:32:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=dk201812; bh=2
	sWM2kcnUK5OS4tpefAKNycEYEdbj45XoOmmPmFeHXc=; b=NqZOMXYHjZU9w62nK
	GDK2UjWlP++mqDCMvuyn9GOT84+wVDEJt3Jc3SQ3CFhe6pRj/OMzBrWuNE7WLQaO
	K/RaLA7xv8RZYVqaMUUXBHSV7HawCUAn5loUVOiOfISmmSe0o6y1I7Po+gW6U706
	3rxHNbOcYl/PZIkBTcq3Pjbc9R1fV9Mu3jGcz88ZuX3S5WrEVPkqdPthdpzuF/Nj
	QuW7ExjWPHdStSf6d4W/mOoAoGj4uPMkBX+RgUrLK8Txpr+po0qAv8yhcr9QTNcl
	zpf5/ydEcS4x1GuVwqjcc3QE0mJ7J3poAfdWXdwZDOTVIVUvHtrHdEYfHeUH3vxD
	o6WvA==
Received: from hhmail05.hh.imgtec.org (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
	by mx07-00376f01.pphosted.com (PPS) with ESMTPS id 45d2h1kwg5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 20 Mar 2025 11:32:30 +0000 (GMT)
Received: from
 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa
 (172.25.0.133) by HHMAIL05.hh.imgtec.org (10.100.10.120) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 20 Mar 2025 11:32:28 +0000
From: Matt Coster <matt.coster@imgtec.com>
Date: Thu, 20 Mar 2025 11:32:18 +0000
Subject: [PATCH v4 08/18] drm/imagination: Remove firmware enable_reg
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250320-sets-bxs-4-64-patch-v1-v4-8-d987cf4ca439@imgtec.com>
References: <20250320-sets-bxs-4-64-patch-v1-v4-0-d987cf4ca439@imgtec.com>
In-Reply-To: <20250320-sets-bxs-4-64-patch-v1-v4-0-d987cf4ca439@imgtec.com>
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
        Randolph Sapp <rs@ti.com>, Darren Etheridge <detheridge@ti.com>,
        "Michal
 Wilczynski" <m.wilczynski@samsung.com>,
        Alessio Belle
	<alessio.belle@imgtec.com>,
        Alexandru Dadu <alexandru.dadu@imgtec.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4388;
 i=matt.coster@imgtec.com; h=from:subject:message-id;
 bh=zspinsC/V9sAeyQBJpZd7CawZjK+6F8C1ZetDcURwDw=;
 b=owGbwMvMwCFWuUfy8817WRsYT6slMaTf/nMk/9oJr6vHfcQP8i35e/Zibcjrpj+t+6ud97rOv
 KdcceDf445SFgYxDgZZMUWWHSssV6j9UdOSuPGrGGYOKxPIEAYuTgGYiLQvwz+t9e/n80y/0x+v
 79LPZcouqHu4eYvYr4bPAnMPdxcd4VjL8D9XddZRz79Xv1gvvifTESr6dw+31vFfs15GOYhP2t2
 16xUPAA==
X-Developer-Key: i=matt.coster@imgtec.com; a=openpgp;
 fpr=05A40CFCE7269D61D97100A1747F0A9036F90DFA
X-EXCLAIMER-MD-CONFIG: 15a78312-3e47-46eb-9010-2e54d84a9631
X-Proofpoint-GUID: tOcimysPUDsv8iPYyVCsMfP5nuiCm6NX
X-Proofpoint-ORIG-GUID: tOcimysPUDsv8iPYyVCsMfP5nuiCm6NX
X-Authority-Analysis: v=2.4 cv=V8Z90fni c=1 sm=1 tr=0 ts=67dbfcce cx=c_pps a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17 a=ETbM1kImDFEA:10 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=VwQbUJbxAAAA:8 a=r_1tXGB3AAAA:8 a=f_O7cd1dQeFu8-5Qt7YA:9
 a=QEXdDO2ut3YA:10 a=t8nPyN_e6usw4ciXM-Pk:22

After a previous commit ("drm/imagination: Mask GPU IRQs in threaded
handler"), this register is now only used to enable firmware interrupts at
start-of-day. This is, however, unnecessary since they are enabled by
default.

In addition, the soon-to-be-added RISC-V firmware processors do not have
an equivalent register.

Signed-off-by: Matt Coster <matt.coster@imgtec.com>
---
Changes in v4:
- None
- Link to v3: https://lore.kernel.org/r/20250310-sets-bxs-4-64-patch-v1-v3-8-143b3dbef02f@imgtec.com
Changes in v3:
- Reference a different commit removing use of enable/disable ops.
- Link to v2: https://lore.kernel.org/r/20241118-sets-bxs-4-64-patch-v1-v2-10-3fd45d9fb0cf@imgtec.com
Changes in v2:
- None
- Link to v1: https://lore.kernel.org/r/20241105-sets-bxs-4-64-patch-v1-v1-10-4ed30e865892@imgtec.com
---
 drivers/gpu/drm/imagination/pvr_device.c  |  1 -
 drivers/gpu/drm/imagination/pvr_fw.h      | 11 +----------
 drivers/gpu/drm/imagination/pvr_fw_meta.c |  1 -
 drivers/gpu/drm/imagination/pvr_fw_mips.c |  1 -
 4 files changed, 1 insertion(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/imagination/pvr_device.c b/drivers/gpu/drm/imagination/pvr_device.c
index a47dd1dd82432f1d66ff90aca26b7b264f4068df..1e488a30c7840466574c7fc3648ab93edfb46354 100644
--- a/drivers/gpu/drm/imagination/pvr_device.c
+++ b/drivers/gpu/drm/imagination/pvr_device.c
@@ -311,7 +311,6 @@ pvr_device_irq_init(struct pvr_device *pvr_dev)
 
 	/* Clear any pending events before requesting the IRQ line. */
 	pvr_fw_irq_clear(pvr_dev);
-	pvr_fw_irq_enable(pvr_dev);
 
 	if (pvr_dev->has_safety_events)
 		pvr_device_safety_irq_clear(pvr_dev);
diff --git a/drivers/gpu/drm/imagination/pvr_fw.h b/drivers/gpu/drm/imagination/pvr_fw.h
index b7966bd574a924862b7877c175fa2b5d757d89db..29bae4bc244a243a6a95bcf838d924060cc043e2 100644
--- a/drivers/gpu/drm/imagination/pvr_fw.h
+++ b/drivers/gpu/drm/imagination/pvr_fw.h
@@ -188,9 +188,6 @@ struct pvr_fw_defs {
 	 * processor backend in pvr_fw_funcs::init().
 	 */
 	struct {
-		/** @enable_reg: FW interrupt enable register. */
-		u32 enable_reg;
-
 		/** @status_reg: FW interrupt status register. */
 		u32 status_reg;
 
@@ -202,7 +199,7 @@ struct pvr_fw_defs {
 		 */
 		u32 clear_reg;
 
-		/** @event_mask: Bitmask of events to listen for. */
+		/** @event_mask: Bitmask of events to listen for in the status_reg. */
 		u32 event_mask;
 
 		/** @clear_mask: Value to write to the clear_reg in order to clear FW IRQs. */
@@ -412,12 +409,6 @@ struct pvr_fw_device {
 #define pvr_fw_irq_clear(pvr_dev) \
 	pvr_fw_irq_write_reg(pvr_dev, clear, (pvr_dev)->fw_dev.defs->irq.clear_mask)
 
-#define pvr_fw_irq_enable(pvr_dev) \
-	pvr_fw_irq_write_reg(pvr_dev, enable, (pvr_dev)->fw_dev.defs->irq.event_mask)
-
-#define pvr_fw_irq_disable(pvr_dev) \
-	pvr_fw_irq_write_reg(pvr_dev, enable, 0)
-
 extern const struct pvr_fw_defs pvr_fw_defs_meta;
 extern const struct pvr_fw_defs pvr_fw_defs_mips;
 
diff --git a/drivers/gpu/drm/imagination/pvr_fw_meta.c b/drivers/gpu/drm/imagination/pvr_fw_meta.c
index 6d13864851fc2e83bdaa94f16435b97841e5de94..a51eec867884b24767f23b3b34cd7029cb660f48 100644
--- a/drivers/gpu/drm/imagination/pvr_fw_meta.c
+++ b/drivers/gpu/drm/imagination/pvr_fw_meta.c
@@ -548,7 +548,6 @@ const struct pvr_fw_defs pvr_fw_defs_meta = {
 	.wrapper_init = pvr_meta_wrapper_init,
 	.has_fixed_data_addr = pvr_meta_has_fixed_data_addr,
 	.irq = {
-		.enable_reg = ROGUE_CR_META_SP_MSLVIRQENABLE,
 		.status_reg = ROGUE_CR_META_SP_MSLVIRQSTATUS,
 		.clear_reg = ROGUE_CR_META_SP_MSLVIRQSTATUS,
 		.event_mask = ROGUE_CR_META_SP_MSLVIRQSTATUS_TRIGVECT2_EN,
diff --git a/drivers/gpu/drm/imagination/pvr_fw_mips.c b/drivers/gpu/drm/imagination/pvr_fw_mips.c
index 0bed0257e2ab75f66d8b8966b2ceac6342396fb5..c810a67eeecf1016064e76baf534e31a44c859b5 100644
--- a/drivers/gpu/drm/imagination/pvr_fw_mips.c
+++ b/drivers/gpu/drm/imagination/pvr_fw_mips.c
@@ -243,7 +243,6 @@ const struct pvr_fw_defs pvr_fw_defs_mips = {
 	.wrapper_init = pvr_mips_wrapper_init,
 	.has_fixed_data_addr = pvr_mips_has_fixed_data_addr,
 	.irq = {
-		.enable_reg = ROGUE_CR_MIPS_WRAPPER_IRQ_ENABLE,
 		.status_reg = ROGUE_CR_MIPS_WRAPPER_IRQ_STATUS,
 		.clear_reg = ROGUE_CR_MIPS_WRAPPER_IRQ_CLEAR,
 		.event_mask = ROGUE_CR_MIPS_WRAPPER_IRQ_STATUS_EVENT_EN,

-- 
2.49.0


