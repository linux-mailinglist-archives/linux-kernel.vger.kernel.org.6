Return-Path: <linux-kernel+bounces-396751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BEB869BD193
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 17:03:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 840F72818F3
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 16:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24F6A1E8857;
	Tue,  5 Nov 2024 15:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=imgtec.com header.i=@imgtec.com header.b="N3b687fn"
Received: from mx08-00376f01.pphosted.com (mx08-00376f01.pphosted.com [91.207.212.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8E31791ED;
	Tue,  5 Nov 2024 15:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730822391; cv=none; b=i4wzehIRtHeA2cUfC6WOLVVZ3pLtKB4FJIt9Lr+bqpCSA7yE5u//E/Gb8Vl+/K6xbB2k3yJZTpctTda0nFUqVWk0TwSSvg8dvS95V0gtDwK8a6J2k/oN6QYriamMIrUlbG25DdlcN+f/oHXWK82tv23NjxTnr3874IamRxuEtpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730822391; c=relaxed/simple;
	bh=NdE3XgEBksWM/VvA3K43vqkpgsy84cdJ09dPBGNbu0A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=j7Mmanhfx5rFAmQqg/SPwAfHCvwHJ/5f1++1gFYFPSyLnBYpRgQ4l2oFcauK018dHRSdT2HLODOPU+wjy+OmWz0H6Vuz/Fojg+5KCzJ9O3mdw5gW0ZY1OuggfBN4+q8T8DLx1kN6YBxIYrXKYfh5UCOrHpZr1C6zGDnOwRiMah8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=imgtec.com; spf=pass smtp.mailfrom=imgtec.com; dkim=pass (2048-bit key) header.d=imgtec.com header.i=@imgtec.com header.b=N3b687fn; arc=none smtp.client-ip=91.207.212.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=imgtec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=imgtec.com
Received: from pps.filterd (m0168888.ppops.net [127.0.0.1])
	by mx08-00376f01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A5EF3v0003827;
	Tue, 5 Nov 2024 15:58:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=dk201812; bh=J
	Nfi/wY6f+hx+iwsPIrEjzlSp82/FdjVAkxdyp5AbVo=; b=N3b687fn+WpSFVhfH
	lLJz2wp/eAVs2O94XbX61ttjwOY1SWrrGQBUZuarOZT5Mcao+hVSfvkxKjwaLCFr
	lpv9JazHtomqk1ILCzvH7hz04+GI8uALfwTryfELOYWe8gu7AjjsmATAHygIlqgQ
	XO/gCYa9lifKYlXa7VDhSoLoCnSSF4bUTCRQW9zd4yzKQcPNPL6Fk0nBTLxeiZer
	Z0rjlbZhEdFETFHERREP/EZQlh2TTTwyfq7uoJKK9mMc9hwfO1Csb0yIPzBgmUx1
	LWIqnDkzp9ofUsAGvOf6qp5SJ40YrEU8AcU8TTCWVN4y+s6Xp6Ch2Yw1DFpsunJE
	weAPQ==
Received: from hhmail05.hh.imgtec.org (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
	by mx08-00376f01.pphosted.com (PPS) with ESMTPS id 42nb7wta0s-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 05 Nov 2024 15:58:25 +0000 (GMT)
Received: from
 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa
 (172.25.16.114) by HHMAIL05.hh.imgtec.org (10.100.10.120) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.37; Tue, 5 Nov 2024 15:58:24 +0000
From: Matt Coster <matt.coster@imgtec.com>
Date: Tue, 5 Nov 2024 15:58:07 +0000
Subject: [PATCH 01/21] dt-bindings: gpu: img: More explicit compatible
 strings
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241105-sets-bxs-4-64-patch-v1-v1-1-4ed30e865892@imgtec.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2282;
 i=matt.coster@imgtec.com; h=from:subject:message-id;
 bh=NdE3XgEBksWM/VvA3K43vqkpgsy84cdJ09dPBGNbu0A=;
 b=owGbwMvMwCFWuUfy8817WRsYT6slMaRrOcyxfeB8rGOp+P6UvxOs9y4ziuy877Zj+9u4wkMrp
 cqUjQoOdJSyMIhxMMiKKbLsWGG5Qu2PmpbEjV/FMHNYmUCGMHBxCsBEDG8x/JUWXjPz5OcHnSKL
 OQv0XtRsZ3ZYssZ30aseHq9Uz8dxk2cwMswwm3pjocP9uRN3OkzqfTApKNspUDJnboTmgd+7RTN
 X/GUHAA==
X-Developer-Key: i=matt.coster@imgtec.com; a=openpgp;
 fpr=05A40CFCE7269D61D97100A1747F0A9036F90DFA
X-EXCLAIMER-MD-CONFIG: 15a78312-3e47-46eb-9010-2e54d84a9631
X-Authority-Analysis: v=2.4 cv=ddzS3mXe c=1 sm=1 tr=0 ts=672a40a1 cx=c_pps a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17 a=hzDjp0mCheYA:10 a=IkcTkHD0fZMA:10 a=VlfZXiiP6vEA:10 a=r_1tXGB3AAAA:8 a=nBKxard2HoEgs5BrZHgA:9 a=QEXdDO2ut3YA:10
 a=0zTtX2_PFEtYljZkrEkA:22 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-GUID: TACrFfPJEAhv1iDJNKGha1wf63SlIYim
X-Proofpoint-ORIG-GUID: TACrFfPJEAhv1iDJNKGha1wf63SlIYim

The current compatible strings are not specific enough to constrain the
hardware in devicetree. For example, the current "img,img-axe" string
refers to the entire family of Series AXE GPUs. The more specific
"img,img-axe-1-16m" string refers to the AXE-1-16M GPU which, unlike the
rest of its family, only uses a single power domain.

Work is currently underway to add support for volcanic-based Imagination
GPUs; also add a generic top-level "img,img-rogue" compatible string to
allow for simpler differentiation in devicetrees.

Make these changes now before introducing more compatible strings to keep
the legacy versions to a minimum.

Signed-off-by: Matt Coster <matt.coster@imgtec.com>
---
 .../devicetree/bindings/gpu/img,powervr-rogue.yaml    | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml b/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml
index 256e252f8087fa0d6081f771a01601d34b66fe19..ef7070daf213277d0190fe319e202fdc597337d4 100644
--- a/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml
+++ b/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml
@@ -12,10 +12,19 @@ maintainers:
 
 properties:
   compatible:
-    items:
-      - enum:
-          - ti,am62-gpu
-      - const: img,img-axe # IMG AXE GPU model/revision is fully discoverable
+    oneOf:
+      - items:
+          - enum:
+              - ti,am62-gpu
+          - const: img,img-axe-1-16m
+          - const: img,img-rogue
+
+      # This legacy combination of compatible strings was introduced early on before the more
+      # specific GPU identifiers were used. Keep it around here for compatibility, but never use
+      # "img,img-axe" in new devicetrees.
+      - items:
+          - const: ti,am62-gpu
+          - const: img,img-axe
 
   reg:
     maxItems: 1
@@ -64,7 +73,7 @@ examples:
     #include <dt-bindings/soc/ti,sci_pm_domain.h>
 
     gpu@fd00000 {
-        compatible = "ti,am62-gpu", "img,img-axe";
+        compatible = "ti,am62-gpu", "img,img-axe-1-16m", "img,img-rogue";
         reg = <0x0fd00000 0x20000>;
         clocks = <&k3_clks 187 0>;
         clock-names = "core";

-- 
2.47.0


