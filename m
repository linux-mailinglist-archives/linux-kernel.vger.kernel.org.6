Return-Path: <linux-kernel+bounces-396740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EA639BD176
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 17:02:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2331A1F23A0E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 16:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A530C176FCE;
	Tue,  5 Nov 2024 15:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=imgtec.com header.i=@imgtec.com header.b="sGfvAXTB"
Received: from mx08-00376f01.pphosted.com (mx08-00376f01.pphosted.com [91.207.212.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F5AE1509AF;
	Tue,  5 Nov 2024 15:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730822387; cv=none; b=FExWfDdx333YD/9kD87g2kA+qDY+hXW2f/kh5nNeLn2tYvGvaiNsvUVU/GDTcdq8gCdnu6Bns6RKzrOO7U+QJ2pUOjMgbj6Cbu5dcj7IrYTYRYVO6tTkKMgveEBC15Phf6cCFRzcHy0XEPnTvQ88bdISZyVgtKySqje1KqR+RNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730822387; c=relaxed/simple;
	bh=xpvmkOGoJ8kLva6fvxTjzOM3lj7B471NHdnui9EiYKg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=p/cIg7Hcy6/Efo+8vFRhXrTjlgOYB4b3NTy44frfPB+iJOh/3Uz00xp8yzd0Jgz8CzmcpXAEwjc2xCKaZyQBZWl10PNqxGq0w0L+K+HKAz8K7+QlKM5T+nUL4s4DMZRAoh44AeKfU6XplnWh7+npzbzz1AfGlB6M31UMLQLkuPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=imgtec.com; spf=pass smtp.mailfrom=imgtec.com; dkim=pass (2048-bit key) header.d=imgtec.com header.i=@imgtec.com header.b=sGfvAXTB; arc=none smtp.client-ip=91.207.212.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=imgtec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=imgtec.com
Received: from pps.filterd (m0168888.ppops.net [127.0.0.1])
	by mx08-00376f01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A5EF3v2003827;
	Tue, 5 Nov 2024 15:58:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=dk201812; bh=m
	8MK1YmMNs1hdmI79eE3tV5JmoW7c58L5kQGDhzJT8o=; b=sGfvAXTBnHssZO2GP
	M3UgXbFzSq3kajMLVoI+lsrTF/oSxZOstban6QQIUaGfPEgKhhE0WJ7stP9/TyEJ
	VF1HBIVUwK6n9lTcMzlYP+ygxqKXZ2YWJnknM/GtBL2cGFd0V3q5CIClRfJBWS34
	YLa8AJR//q48d0CXgyseG1OL8f87QW+u3LCINewXIUubitX5VlExh9/HV0gVTalX
	ELtNYLXEyA6w6bzhJuXcunws66zRg9Szyv7tmvYe4l57o1vKN4SK8lbW9WKJjLh2
	9P2deoChaGtvad95gWhlssbF/stWemW/k37H0CZxockWzjTPW7WQie0vvZiHD9HT
	81e5Q==
Received: from hhmail05.hh.imgtec.org (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
	by mx08-00376f01.pphosted.com (PPS) with ESMTPS id 42nb7wta0s-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 05 Nov 2024 15:58:27 +0000 (GMT)
Received: from
 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa
 (172.25.16.114) by HHMAIL05.hh.imgtec.org (10.100.10.120) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.37; Tue, 5 Nov 2024 15:58:25 +0000
From: Matt Coster <matt.coster@imgtec.com>
Date: Tue, 5 Nov 2024 15:58:09 +0000
Subject: [PATCH 03/21] dt-bindings: gpu: img: Power domain details
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241105-sets-bxs-4-64-patch-v1-v1-3-4ed30e865892@imgtec.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1915;
 i=matt.coster@imgtec.com; h=from:subject:message-id;
 bh=xpvmkOGoJ8kLva6fvxTjzOM3lj7B471NHdnui9EiYKg=;
 b=owGbwMvMwCFWuUfy8817WRsYT6slMaRrOcwJDtW9YnZ1UiZfOp+M491JKk5F3ALme6ZkzLazO
 nZ8zwG7jlIWBjEOBlkxRZYdKyxXqP1R05K48asYZg4rE8gQBi5OAZjI7icM/8MK+9uT+5vOJJ5Y
 qNq/SMr7tYXfv7rrJ/qOFO20LjA+6c7w30dXe9e77VnVTdPKSlTO6D3kkWY1em2pFdFxo6+aNWg
 aJwA=
X-Developer-Key: i=matt.coster@imgtec.com; a=openpgp;
 fpr=05A40CFCE7269D61D97100A1747F0A9036F90DFA
X-EXCLAIMER-MD-CONFIG: 15a78312-3e47-46eb-9010-2e54d84a9631
X-Authority-Analysis: v=2.4 cv=ddzS3mXe c=1 sm=1 tr=0 ts=672a40a3 cx=c_pps a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17 a=hzDjp0mCheYA:10 a=IkcTkHD0fZMA:10 a=VlfZXiiP6vEA:10 a=r_1tXGB3AAAA:8 a=aNuRvPZPtIV8pc9XrW8A:9 a=QEXdDO2ut3YA:10
 a=aimXnJ6PnzgsTu0FwM6W:22 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-GUID: G43ywWuRVUE1PLqMd0PHqt08M6XrxAwv
X-Proofpoint-ORIG-GUID: G43ywWuRVUE1PLqMd0PHqt08M6XrxAwv

The single existing GPU (AXE-1-16M) only requires a single power domain.
Subsequent patches will add support for BXS-4-64 MC1, which has two power
domains. Add infrastructure now to allow for this.

Signed-off-by: Matt Coster <matt.coster@imgtec.com>
---
 .../devicetree/bindings/gpu/img,powervr-rogue.yaml | 29 +++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml b/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml
index 6924831d3e9dd9b2b052ca8f9d7228ff25526532..55f422be1bc5b7564e3e81f24c4b93857f3e12fe 100644
--- a/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml
+++ b/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml
@@ -49,7 +49,16 @@ properties:
     maxItems: 1
 
   power-domains:
-    maxItems: 1
+    minItems: 1
+    maxItems: 2
+
+  power-domain-names:
+    oneOf:
+      - items:
+          - const: a
+      - items:
+          - const: a
+          - const: b
 
 required:
   - compatible
@@ -57,10 +66,27 @@ required:
   - clocks
   - clock-names
   - interrupts
+  - power-domains
+  - power-domain-names
 
 additionalProperties: false
 
 allOf:
+  # Cores with a single power domain
+  - if:
+      properties:
+        compatible:
+          contains:
+            anyOf:
+              - const: img,img-axe-1-16m
+    then:
+      properties:
+        power-domains:
+          minItems: 1
+          maxItems: 1
+        power-domain-names:
+          items:
+            - const: a
   # Vendor integrations using a single clock domain
   - if:
       properties:
@@ -90,4 +116,5 @@ examples:
         clock-names = "core";
         interrupts = <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>;
         power-domains = <&k3_pds 187 TI_SCI_PD_EXCLUSIVE>;
+        power-domain-names = "a";
     };

-- 
2.47.0


