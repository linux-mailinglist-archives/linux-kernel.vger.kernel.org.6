Return-Path: <linux-kernel+bounces-577372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98449A71C5A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 17:51:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A19716F005
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 16:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4520E1F8BA6;
	Wed, 26 Mar 2025 16:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=imgtec.com header.i=@imgtec.com header.b="KAZadBf5"
Received: from mx08-00376f01.pphosted.com (mx08-00376f01.pphosted.com [91.207.212.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F411AF0A4;
	Wed, 26 Mar 2025 16:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743007761; cv=none; b=PbCJrs75Jtl7rs6Bp+mxgPYJOKHkM6R5bJKjcSVZMckFcqc0iMtqnQRG4ilIIVhYO79g2DLvU4EbL9e7ksrIWv86j0o+8MUCeeXd2RqgQJPdqTfWB8nCRPo7Jksdwa7jiMw32ZNB2nhq+TuVyYTy3C4RJJYffD3HnuhCUDhmMXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743007761; c=relaxed/simple;
	bh=JEYWkidvDSgrYrpTmclJfmN36IZj/Cm5OXUDkiVwvjk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=DuSb8ZYcJNe6vpxD20vGZTlNChyGVrRC+PAipX29Vium+neAhpewA65vYADBPee4psMPx8P5ItnZj1Z9uFvBzO/bNArUaNi45jtghlsd6rg5kzLSz3LnkRobA/F+K1DggcM7ydKjok+JWVzmagiDVRR5dyIWLSuHcDWTGJf5Ttw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=imgtec.com; spf=pass smtp.mailfrom=imgtec.com; dkim=pass (2048-bit key) header.d=imgtec.com header.i=@imgtec.com header.b=KAZadBf5; arc=none smtp.client-ip=91.207.212.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=imgtec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=imgtec.com
Received: from pps.filterd (m0168888.ppops.net [127.0.0.1])
	by mx08-00376f01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52QBt2Sa012691;
	Wed, 26 Mar 2025 16:48:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=dk201812; bh=p
	skYsEv645Ou0RGXqLcUbubmRS3Yl8UufdOO4iflIAc=; b=KAZadBf5utNmU4cyT
	j8ioyL88z4TWWxlRpD7ZGXu/7xRDTTPh+woQXw1L4QlRZAbefGUvNITpd3Bhy2Kb
	TsSi974NdoHX0TdTHE4TKQ2fqLTtOXzizjq7B1zKIXQxVhPwTpxRnGztJigESVjQ
	fVzA8QbF+0jxBkVGnbrxSqCaRXrqk2U7Lzcs9090CfEBDxScJDu/lqgk66/R1dhq
	2dew/ufsuWhAHAnULO6CGlUWX3tPoRI7tY414mxvL68ANV8Dy9aGBl1NiDqWICMM
	UuR7AbJ/LtcIHLRhZfxSoNMSKPgpoXu1CiZdyLFEVKxs3CPvz9qbQ+xAUAp+Wamh
	v1zfA==
Received: from hhmail05.hh.imgtec.org (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
	by mx08-00376f01.pphosted.com (PPS) with ESMTPS id 45kbmy9d6d-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 26 Mar 2025 16:48:42 +0000 (GMT)
Received: from
 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa
 (172.25.0.133) by HHMAIL05.hh.imgtec.org (10.100.10.120) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 26 Mar 2025 16:48:40 +0000
From: Matt Coster <matt.coster@imgtec.com>
Date: Wed, 26 Mar 2025 16:48:22 +0000
Subject: [PATCH v5 02/18] dt-bindings: gpu: img: Add BXS-4-64 devicetree
 bindings
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250326-sets-bxs-4-64-patch-v1-v5-2-e4c46e8280a9@imgtec.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2985;
 i=matt.coster@imgtec.com; h=from:subject:message-id;
 bh=JEYWkidvDSgrYrpTmclJfmN36IZj/Cm5OXUDkiVwvjk=;
 b=owGbwMvMwCFWuUfy8817WRsYT6slMaQ/0X+ybWLc68rK6GMCCnqqq9NnREwoC+qbKPAr/VEuP
 9/hx9ujO0pZGMQ4GGTFFFl2rLBcofZHTUvixq9imDmsTCBDGLg4BWAiM/sZ/tkd2xziNeXJPpHD
 u/emb5vyUfWd/Ky90m+rHnyut37fFjyNkWGymcQ25icWhSoZGyQq5877UPhR09Z5rrTLI0uL0KJ
 bnNwA
X-Developer-Key: i=matt.coster@imgtec.com; a=openpgp;
 fpr=05A40CFCE7269D61D97100A1747F0A9036F90DFA
X-EXCLAIMER-MD-CONFIG: 15a78312-3e47-46eb-9010-2e54d84a9631
X-Proofpoint-ORIG-GUID: ZuxPteISf1dga-yqxDqb3KCEmF6OwxmH
X-Authority-Analysis: v=2.4 cv=L+sdQ/T8 c=1 sm=1 tr=0 ts=67e42fea cx=c_pps a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17 a=ETbM1kImDFEA:10 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=VwQbUJbxAAAA:8 a=r_1tXGB3AAAA:8 a=UnZxrO27XcT1wZtnOysA:9
 a=QEXdDO2ut3YA:10 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-GUID: ZuxPteISf1dga-yqxDqb3KCEmF6OwxmH

Unlike AXE-1-16M, BXS-4-64 uses two power domains.

Like the existing AXE-1-16M integration, BXS-4-64 uses the single clock
integration in the TI k3-j721s2.

Signed-off-by: Matt Coster <matt.coster@imgtec.com>
---
Changes in v5:
- Replace anyOf/const with enum
- Link to v4: https://lore.kernel.org/r/20250320-sets-bxs-4-64-patch-v1-v4-2-d987cf4ca439@imgtec.com
Changes in v4:
- Add minItems: 1 to power-domain-names so we don't break single domain
  bindings
- Add back power-domains to conditional constraints to match
  power-domain-names
- Link to v3: https://lore.kernel.org/r/20250310-sets-bxs-4-64-patch-v1-v3-2-143b3dbef02f@imgtec.com
Changes in v3:
- Include adding the second power domain so it's in context
- Remove unnecessary example
- Link to v2: https://lore.kernel.org/r/20241118-sets-bxs-4-64-patch-v1-v2-8-3fd45d9fb0cf@imgtec.com
Changes in v2:
- Use normal reg syntax for 64-bit values
- Link to v1: https://lore.kernel.org/r/20241105-sets-bxs-4-64-patch-v1-v1-8-4ed30e865892@imgtec.com
---
 .../devicetree/bindings/gpu/img,powervr-rogue.yaml | 38 ++++++++++++++++++++--
 1 file changed, 36 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml b/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml
index e1056bf2af84c3eb43733bdc91124a66aaf51d35..0fb2cd939aa45b48b0a6a95ed7f01e0c6f64a4f3 100644
--- a/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml
+++ b/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml
@@ -21,6 +21,11 @@ properties:
           # work with newer dts.
           - const: img,img-axe
           - const: img,img-rogue
+      - items:
+          - enum:
+              - ti,j721s2-gpu
+          - const: img,img-bxs-4-64
+          - const: img,img-rogue
 
       # This legacy combination of compatible strings was introduced early on
       # before the more specific GPU identifiers were used.
@@ -48,11 +53,14 @@ properties:
     maxItems: 1
 
   power-domains:
-    maxItems: 1
+    minItems: 1
+    maxItems: 2
 
   power-domain-names:
     items:
       - const: a
+      - const: b
+    minItems: 1
 
   dma-coherent: true
 
@@ -82,7 +90,33 @@ allOf:
       properties:
         compatible:
           contains:
-            const: ti,am62-gpu
+            const: img,img-axe-1-16m
+    then:
+      properties:
+        power-domains:
+          maxItems: 1
+        power-domain-names:
+          maxItems: 1
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: img,img-bxs-4-64
+    then:
+      properties:
+        power-domains:
+          minItems: 2
+        power-domain-names:
+          minItems: 2
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - ti,am62-gpu
+              - ti,j721s2-gpu
     then:
       properties:
         clocks:

-- 
2.49.0


