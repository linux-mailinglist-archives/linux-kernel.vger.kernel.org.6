Return-Path: <linux-kernel+bounces-396741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 096019BD17B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 17:02:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA6B6281B56
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 16:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F35717BB3D;
	Tue,  5 Nov 2024 15:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=imgtec.com header.i=@imgtec.com header.b="TtgvvesQ"
Received: from mx08-00376f01.pphosted.com (mx08-00376f01.pphosted.com [91.207.212.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F48714A0B8;
	Tue,  5 Nov 2024 15:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730822387; cv=none; b=Wxn79V45MmolM9oo1iLCaJLKRfJoG1ElEo3YlFJi6DVkzP1AABO12pEFDbrSNIrAHuMwTEMe4D1Fto6U0TGTptJUHVV4Y3ofbrZfG6lK7xqNalfR580K1aW1SubHp0TKmse0SyUmc25m9nhQOoXSJN5AcfrlRD3MPIoTOel2Rsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730822387; c=relaxed/simple;
	bh=gmq1//uzSkip2I9hQnYT5ExcwUyJTx/G8+lls9+QmpE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=h835YYXenn5rHbJr8uk4FVE0HS6EzMonSx/V7G+fK4AFgpW0PWK3Vl6sQyjNWmKcO1BTa54GPL2qwwlOLCHEc1UWvRoP4tp5ianVHsp5Y50+fpcg1o+s4ZoyrIKEKFjqvctCGXR26Ljq5Mb7MxKDVmmkSU6pQ0xdZDUYuB/aLe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=imgtec.com; spf=pass smtp.mailfrom=imgtec.com; dkim=pass (2048-bit key) header.d=imgtec.com header.i=@imgtec.com header.b=TtgvvesQ; arc=none smtp.client-ip=91.207.212.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=imgtec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=imgtec.com
Received: from pps.filterd (m0168888.ppops.net [127.0.0.1])
	by mx08-00376f01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A5EF3v1003827;
	Tue, 5 Nov 2024 15:58:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=dk201812; bh=d
	gFYRKSLCsydHCPYVKboQ9O5kz+xG+4NN+Hl+uD6ovg=; b=TtgvvesQ9wUY75Bu4
	1y5UiEGmfZgNzZP2oykAywYujXkEbRRhcPipvylfEdwwrInW93RHLi0iYi5UT8nW
	fi6e3oUpOdzzsNCW/yjQbjRMJMqYT9cIUTUyPx8p1OcMaajbck78JomlypveixWZ
	Y9Kbp5D3cj5NAEfICTr+0nerSsImjszuxQrCrT9sp7n+TWTZKWfxdBnaRBbJrxow
	CINfwauj8+82cf1APKxukvRaTNX/7lgg1hv1XXV19bphlQCgreWie4yLq1t61/h/
	RUuHrPCtdZv94WMO/owUP0qCTv/pz5f6DbPM2wotD0xkKbR7yrXaAXYQio2gD/Vs
	4pI1Q==
Received: from hhmail05.hh.imgtec.org (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
	by mx08-00376f01.pphosted.com (PPS) with ESMTPS id 42nb7wta0s-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 05 Nov 2024 15:58:26 +0000 (GMT)
Received: from
 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa
 (172.25.16.114) by HHMAIL05.hh.imgtec.org (10.100.10.120) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.37; Tue, 5 Nov 2024 15:58:25 +0000
From: Matt Coster <matt.coster@imgtec.com>
Date: Tue, 5 Nov 2024 15:58:08 +0000
Subject: [PATCH 02/21] dt-bindings: gpu: img: Further constrain clocks
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241105-sets-bxs-4-64-patch-v1-v1-2-4ed30e865892@imgtec.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2010;
 i=matt.coster@imgtec.com; h=from:subject:message-id;
 bh=gmq1//uzSkip2I9hQnYT5ExcwUyJTx/G8+lls9+QmpE=;
 b=owGbwMvMwCFWuUfy8817WRsYT6slMaRrOcyxXRAdu/B5jsbPjkeBrJdc/33s5OBLKFqc9OzdP
 K5YnuA7HaUsDGIcDLJiiiw7VliuUPujpiVx41cxzBxWJpAhDFycAjCR6GZGhgWy0VNV93UxL++O
 CImrXiYsJTD31vdPQhrlZ5avb4rdkszIMFflqP6eOd+0vS5JFUX9mvrwnUTx2S3yjscVU7lmGRw
 6wAMA
X-Developer-Key: i=matt.coster@imgtec.com; a=openpgp;
 fpr=05A40CFCE7269D61D97100A1747F0A9036F90DFA
X-EXCLAIMER-MD-CONFIG: 15a78312-3e47-46eb-9010-2e54d84a9631
X-Authority-Analysis: v=2.4 cv=ddzS3mXe c=1 sm=1 tr=0 ts=672a40a2 cx=c_pps a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17 a=hzDjp0mCheYA:10 a=IkcTkHD0fZMA:10 a=VlfZXiiP6vEA:10 a=r_1tXGB3AAAA:8 a=cDXhS4k7GDcpIX9mfQgA:9 a=QEXdDO2ut3YA:10
 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-GUID: 8l3_6SoqTe74P9tpv2dJ-Exgb2ItxLQy
X-Proofpoint-ORIG-GUID: 8l3_6SoqTe74P9tpv2dJ-Exgb2ItxLQy

All Imagination GPUs use three clocks: core, mem and sys. All reasonably
modern Imagination GPUs also support a single-clock mode where the SoC
only hooks up core and the other two are derived internally. On GPUs which
support this mode, it is the default and most commonly used integration.

Codify this "1 or 3" constraint in our bindings and hang the specifics off
the vendor compatible string to mirror the integration-time choice.

Signed-off-by: Matt Coster <matt.coster@imgtec.com>
---
 .../devicetree/bindings/gpu/img,powervr-rogue.yaml | 27 +++++++++++++++-------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml b/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml
index ef7070daf213277d0190fe319e202fdc597337d4..6924831d3e9dd9b2b052ca8f9d7228ff25526532 100644
--- a/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml
+++ b/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml
@@ -30,15 +30,20 @@ properties:
     maxItems: 1
 
   clocks:
-    minItems: 1
-    maxItems: 3
+    oneOf:
+      - minItems: 1
+        maxItems: 1
+      - minItems: 3
+        maxItems: 3
 
   clock-names:
-    items:
-      - const: core
-      - const: mem
-      - const: sys
-    minItems: 1
+    oneOf:
+      - items:
+          - const: core
+      - items:
+          - const: core
+          - const: mem
+          - const: sys
 
   interrupts:
     maxItems: 1
@@ -56,15 +61,21 @@ required:
 additionalProperties: false
 
 allOf:
+  # Vendor integrations using a single clock domain
   - if:
       properties:
         compatible:
           contains:
-            const: ti,am62-gpu
+            anyOf:
+              - const: ti,am62-gpu
     then:
       properties:
         clocks:
+          minItems: 1
           maxItems: 1
+        clock-names:
+          items:
+            - const: core
 
 examples:
   - |

-- 
2.47.0


