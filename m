Return-Path: <linux-kernel+bounces-412981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFF009D11F4
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 14:32:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77493286756
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 13:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FE5A1BD9D5;
	Mon, 18 Nov 2024 13:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=imgtec.com header.i=@imgtec.com header.b="qZLn7I2p"
Received: from mx07-00376f01.pphosted.com (mx07-00376f01.pphosted.com [185.132.180.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E06FD1A9B51;
	Mon, 18 Nov 2024 13:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.180.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731936594; cv=none; b=ecSYOZU8dGxaHsujP5gCAVXkgzjBt6LoGRJhitQEKt/NWwJSNU9/3Ljdx52rANAWulS1d98sAA63uhc2/KTF2hNoX4zybv+R73ihdaCIYYuEfftu8vWpXKr5eWoTUQ8ovPhsD7z5EvU/7BwN0vMi0RJNfEt4L0KcCVEEvi91Ops=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731936594; c=relaxed/simple;
	bh=3Or83jNpwXbaO0NeKSfl6slWC+kAbeyA+TIPsN7OvD4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=cesBb8bLfX5pFODRNqNUteIvulZ/CaZwMa5qYrnAFFX/JzfWwb7vLpvPzDw241V0Sf2cBtUZ4n6YB6e7WQu6kHxGmyMRISbzFx1Wn9DpuDf89wGQ9dz9XvEZcLgOFGAIqCxRb0brQ+xakXatXf2DaPg2HVavO/TkOUWDO0qCGlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=imgtec.com; spf=pass smtp.mailfrom=imgtec.com; dkim=pass (2048-bit key) header.d=imgtec.com header.i=@imgtec.com header.b=qZLn7I2p; arc=none smtp.client-ip=185.132.180.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=imgtec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=imgtec.com
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
	by mx07-00376f01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AICKePg029230;
	Mon, 18 Nov 2024 13:02:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=dk201812; bh=H
	SRLYDr0AL0usXDBAgHrskP1GakCSk1JeYSUCYUyBDI=; b=qZLn7I2pIBB1G45KD
	0UZB7360iOnGebmkK25QoB154q9VnO6I+W+zn3SvMmU4BA7c6ASYOd4H0Wq/MbOD
	A7PpgfACXF37KFOtLWpenIa7YhYxDqJCAkY32vQqqo4RRI50vcZ69yj+Zcb5akiA
	YvZa4h8d1zYnT+LAmDX0+PY0Zl4XbXXPWhbuM+Ni0r73sE8xSXoaIkOe0Ns/iVJy
	RPq8gzq2DeNcSvD5CuR3/IV5fUm4B5YA5tcHfocmqedFYNzoZzk42IEOqBTFg5qD
	TmVdbwXxGxvNJNiZhDWoyRINfvdQshwJXTTMrDlPwYNHhO80J3CDmdtnocA9otnG
	kC47w==
Received: from hhmail05.hh.imgtec.org (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
	by mx07-00376f01.pphosted.com (PPS) with ESMTPS id 42xmc1hmhv-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 18 Nov 2024 13:02:33 +0000 (GMT)
Received: from
 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa
 (172.25.16.114) by HHMAIL05.hh.imgtec.org (10.100.10.120) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.37; Mon, 18 Nov 2024 13:02:32 +0000
From: Matt Coster <matt.coster@imgtec.com>
Date: Mon, 18 Nov 2024 13:01:54 +0000
Subject: [PATCH v2 02/21] dt-bindings: gpu: img: Further constrain clocks
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241118-sets-bxs-4-64-patch-v1-v2-2-3fd45d9fb0cf@imgtec.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1955;
 i=matt.coster@imgtec.com; h=from:subject:message-id;
 bh=3Or83jNpwXbaO0NeKSfl6slWC+kAbeyA+TIPsN7OvD4=;
 b=owGbwMvMwCFWuUfy8817WRsYT6slMaRbWz0R/W9n9emB3hMNZpU0meLN9eeenmcv/VxQeepYU
 2ujzfGkjlIWBjEOBlkxRZYdKyxXqP1R05K48asYZg4rE8gQBi5OAZiI6ieG/15Gujnc/p8m3Nl0
 UvlwYIxEUuPKkCtXtZ65aK2SWL35bzojw6lO4berrBbbztx7aFr3sfZf75kZJidnTO1rPfLtd9V
 XdlYA
X-Developer-Key: i=matt.coster@imgtec.com; a=openpgp;
 fpr=05A40CFCE7269D61D97100A1747F0A9036F90DFA
X-EXCLAIMER-MD-CONFIG: 15a78312-3e47-46eb-9010-2e54d84a9631
X-Proofpoint-ORIG-GUID: 1_2GWLb-HJ1S4agGL_gup0fp_194pibE
X-Authority-Analysis: v=2.4 cv=E4efprdl c=1 sm=1 tr=0 ts=673b3ae9 cx=c_pps a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17 a=hzDjp0mCheYA:10 a=IkcTkHD0fZMA:10 a=VlfZXiiP6vEA:10 a=VwQbUJbxAAAA:8 a=r_1tXGB3AAAA:8 a=cDXhS4k7GDcpIX9mfQgA:9
 a=QEXdDO2ut3YA:10 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-GUID: 1_2GWLb-HJ1S4agGL_gup0fp_194pibE

All Imagination GPUs use three clocks: core, mem and sys. All reasonably
modern Imagination GPUs also support a single-clock mode where the SoC
only hooks up core and the other two are derived internally. On GPUs which
support this mode, it is the default and most commonly used integration.

Codify this "1 or 3" constraint in our bindings and hang the specifics off
the vendor compatible string to mirror the integration-time choice.

Signed-off-by: Matt Coster <matt.coster@imgtec.com>
---
Changes in v2:
- Simplified clocks constraints (P2)
- Link to v1: https://lore.kernel.org/r/20241105-sets-bxs-4-64-patch-v1-v1-2-4ed30e865892@imgtec.com
---
 .../devicetree/bindings/gpu/img,powervr-rogue.yaml   | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml b/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml
index ef7070daf213277d0190fe319e202fdc597337d4..3b5a5b966585ac29ad104c7aef19881eca73ce80 100644
--- a/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml
+++ b/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml
@@ -29,16 +29,16 @@ properties:
   reg:
     maxItems: 1
 
-  clocks:
-    minItems: 1
-    maxItems: 3
+  clocks: true
 
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
@@ -56,11 +56,13 @@ required:
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

-- 
2.47.0


