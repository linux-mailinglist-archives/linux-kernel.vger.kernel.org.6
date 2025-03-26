Return-Path: <linux-kernel+bounces-577376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AFC1A71C5D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 17:51:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18652177646
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 16:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5666B1A2632;
	Wed, 26 Mar 2025 16:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=imgtec.com header.i=@imgtec.com header.b="CszenRMm"
Received: from mx08-00376f01.pphosted.com (mx08-00376f01.pphosted.com [91.207.212.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985DB1F790F;
	Wed, 26 Mar 2025 16:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743007762; cv=none; b=twatC9ih3ab25TgFssQn/heEzilvaMRdZf2dCXmHwUpez1r7SoN2eQhVad6k6ItsRwJ3zynrHzte3dAnMCVe1goBGfOBQINFsl3lnbsvzIb7YAUaLqcqm3PL7OdPVFIYOL0wv53vV2pMqjs7aB+tJ6L6kkFEOyP4saP7Nc/JbeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743007762; c=relaxed/simple;
	bh=+7b5Io6rpS02LLnQ3QR555uPnpORNjlcmUdL5P3f4xg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=rc2bfeqioNQNtI//guj7/llt+vL94y0VFkUMKg3uZ8EqTMmsn7OfdlkxBnjg3oN0YjBdrIDQ1VKUhbtnFNsFGzysd0rCKmDw54bD0koYCcFObRSi6nPRnritDrdTCQUa1O7L+aLwm+3O5p5jEKq1Qs/y35HGV/vOotjKOHU2bkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=imgtec.com; spf=pass smtp.mailfrom=imgtec.com; dkim=pass (2048-bit key) header.d=imgtec.com header.i=@imgtec.com header.b=CszenRMm; arc=none smtp.client-ip=91.207.212.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=imgtec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=imgtec.com
Received: from pps.filterd (m0168888.ppops.net [127.0.0.1])
	by mx08-00376f01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52QBt2Sc012691;
	Wed, 26 Mar 2025 16:48:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=dk201812; bh=2
	muR04U9rLsVOssB3xj3ruhD4qD6HlDpK8sZlIVSGfg=; b=CszenRMm+4ysEcg+x
	jbu3EV2qHVYRCfTMlQRh7DDuNX2D17KqkzQVR1TXDDFZNvCR4Kxwo0x3M5thFcDK
	l9Be08/Setz5K8GKtyQGEjBS5sMHGT9+KjsC6ew5rygzczQh3fApKJKgYk0OgRmW
	gtCOvyrlOwTkBxN82xzM4Isna/JNILATaRbHX215wn/54KtxceHJGr0tP8cwiD3B
	dehb4TE0Cs6LkbM7o6kwiPk7YDiW16Iw0as1N7nUfUy1mNBTS92nR7DFIookB6qY
	KecEih1mpl7fDIfp7uxX4ii0gz0SB47Cg4WHyxIe2Fngkg4u87k1nNO3ZEkAUhi7
	/u5jQ==
Received: from hhmail05.hh.imgtec.org (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
	by mx08-00376f01.pphosted.com (PPS) with ESMTPS id 45kbmy9d6d-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 26 Mar 2025 16:48:55 +0000 (GMT)
Received: from
 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa
 (172.25.0.133) by HHMAIL05.hh.imgtec.org (10.100.10.120) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 26 Mar 2025 16:48:42 +0000
From: Matt Coster <matt.coster@imgtec.com>
Date: Wed, 26 Mar 2025 16:48:24 +0000
Subject: [PATCH v5 04/18] drm/imagination: Use new generic compatible
 string
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250326-sets-bxs-4-64-patch-v1-v5-4-e4c46e8280a9@imgtec.com>
References: <20250326-sets-bxs-4-64-patch-v1-v5-0-e4c46e8280a9@imgtec.com>
In-Reply-To: <20250326-sets-bxs-4-64-patch-v1-v5-0-e4c46e8280a9@imgtec.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1910;
 i=matt.coster@imgtec.com; h=from:subject:message-id;
 bh=+7b5Io6rpS02LLnQ3QR555uPnpORNjlcmUdL5P3f4xg=;
 b=owGbwMvMwCFWuUfy8817WRsYT6slMaQ/0X8SaW+a1J7U08WmEecg9uNPVZfmucO+LMG2ggsNJ
 k1lYn3bUcrCIMbBICumyLJjheUKtT9qWhI3fhXDzGFlAhnCwMUpABOpDGf47/Rn2mbHjbazD+Q4
 Zj7SaszylnnPYHvgy9sG5VaWvUZZzIwMR5b4au4P2PK2ZLJ7p+n2n/Kzt036FLr7zz7Zpc13o1c
 0sAAA
X-Developer-Key: i=matt.coster@imgtec.com; a=openpgp;
 fpr=05A40CFCE7269D61D97100A1747F0A9036F90DFA
X-EXCLAIMER-MD-CONFIG: 15a78312-3e47-46eb-9010-2e54d84a9631
X-Proofpoint-ORIG-GUID: yCkHIiKTHIUj-jQZz9Lwx3q3B8cYwMvc
X-Authority-Analysis: v=2.4 cv=L+sdQ/T8 c=1 sm=1 tr=0 ts=67e42ff7 cx=c_pps a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17 a=ETbM1kImDFEA:10 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=VwQbUJbxAAAA:8 a=r_1tXGB3AAAA:8 a=6TxX0kamTyKH95WNaFsA:9
 a=QEXdDO2ut3YA:10 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-GUID: yCkHIiKTHIUj-jQZz9Lwx3q3B8cYwMvc

Follow-on from the companion dt-bindings change ("dt-bindings: gpu: img:
More explicit compatible strings"), deprecating "img,img-axe" in favour of
the more explicit combination of "img,img-rogue" and "img,img-axe-1-16m".

Since all relevant details are interrogated from the device at runtime,
we can match on the generic "img,img-rogue" and avoid adding more entries
with NULL data members (barring hardware quirks).

Signed-off-by: Matt Coster <matt.coster@imgtec.com>
---
Changes in v5:
- None
- Link to v4: https://lore.kernel.org/r/20250320-sets-bxs-4-64-patch-v1-v4-4-d987cf4ca439@imgtec.com
Changes in v4:
- None
- Link to v3: https://lore.kernel.org/r/20250310-sets-bxs-4-64-patch-v1-v3-4-143b3dbef02f@imgtec.com
Changes in v3:
- Don't use more specific compatible strings when not required
- Link to v2: https://lore.kernel.org/r/20241118-sets-bxs-4-64-patch-v1-v2-5-3fd45d9fb0cf@imgtec.com
Changes in v2:
- None
- Link to v1: https://lore.kernel.org/r/20241105-sets-bxs-4-64-patch-v1-v1-5-4ed30e865892@imgtec.com
---
 drivers/gpu/drm/imagination/pvr_drv.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/imagination/pvr_drv.c b/drivers/gpu/drm/imagination/pvr_drv.c
index 0639502137b4431dc23a349476572cc898d1f8d0..3130193f8fffc185e630a293be53374bdc4b7ce0 100644
--- a/drivers/gpu/drm/imagination/pvr_drv.c
+++ b/drivers/gpu/drm/imagination/pvr_drv.c
@@ -1473,6 +1473,13 @@ static void pvr_remove(struct platform_device *plat_dev)
 }
 
 static const struct of_device_id dt_match[] = {
+	{ .compatible = "img,img-rogue", .data = NULL },
+
+	/*
+	 * This legacy compatible string was introduced early on before the more generic
+	 * "img,img-rogue" was added. Keep it around here for compatibility, but never use
+	 * "img,img-axe" in new devicetrees.
+	 */
 	{ .compatible = "img,img-axe", .data = NULL },
 	{}
 };

-- 
2.49.0


