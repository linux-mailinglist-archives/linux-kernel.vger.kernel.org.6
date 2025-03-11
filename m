Return-Path: <linux-kernel+bounces-555580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98AE5A5B9E2
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 08:34:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46FD91893945
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 07:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D02C22256C;
	Tue, 11 Mar 2025 07:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=einfochips.com header.i=@einfochips.com header.b="XXvdnYHr"
Received: from naesa05.arrow.com (naesa05.arrow.com [216.150.161.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B24B1E9B34;
	Tue, 11 Mar 2025 07:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.150.161.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741678484; cv=none; b=CX964Kz86v72G2PDHoZiPPSpE/oeij55etDeHGcbfo9BVureGEHxqxMX50J7VbvT+GrQOa7V1A50zr29voQx9xK3jCPL9HlQhdaXxYLEE/TDoelq2ya31Pf4oRo7Vb/6kUMQcm1AikkrjKfewThHt/ywxQb0M1FB0UmOyDn9ayI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741678484; c=relaxed/simple;
	bh=aR5wXVzzwCMTGciJgNgFTZx8tZMYxM5ueduU4KTlfJI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UUbEbljEuqyUwMxuhvBi4cwi4KcQAHEk3M1COJFbsOV4bN3M6fEtPaex3NSnGgSJxYUt/XD8BYToSrQrQJ5SNbrUJYqAgYp6oX2cquHdBVkOo9jlrspQtE8UQyTzQ10uK+CnDeCI5qeb/71TIQifxmObQhe3DAj3ZdSuuDo0UHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=einfochips.com; spf=pass smtp.mailfrom=einfochips.com; dkim=pass (2048-bit key) header.d=einfochips.com header.i=@einfochips.com header.b=XXvdnYHr; arc=none smtp.client-ip=216.150.161.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=einfochips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=einfochips.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=einfochips.com; i=@einfochips.com; l=2230; q=dns/txt;
  s=NAESA-Selector1; t=1741678482; x=1773214482;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aR5wXVzzwCMTGciJgNgFTZx8tZMYxM5ueduU4KTlfJI=;
  b=XXvdnYHrlJaX6ww3xegaW4sRMbxVpyjpq+n6nzau5m1aqmvCSC4OqvXk
   AZuWHZYOx41D92pDIwehhxFRf8RsHeHSwZixRndu+GyYXDEH8pLJuYVmP
   +Tf4zIBIt5AGdx4X/t0uelL6UWV5Q0lGS3duYbN4jWpoz6VJlUu+bRnJI
   K437qv+8ptjEkgB1CPSPD8+nUKGOlyM7JYyCLlAC71jPcrhm98bIiez6l
   BGy+1g0fN6fF+PkmbofP69ugRRpuXNXqWG067DcJnOg6wn2hF+/gmH13+
   yloYbAhtQbkloHJ6iyzp7mMIsdMp+vr45uVQa+3lsFHMM63Cdp6P46bSp
   A==;
X-CSE-ConnectionGUID: eDOvZtSlSUedXniG4qKA9w==
X-CSE-MsgGUID: dY/Zu0H5Qu+C+HGVPOGk+Q==
X-IronPort-AV: E=Sophos;i="6.14,238,1736838000"; 
   d="scan'208";a="20386393"
Received: from unknown (HELO eicahmirelay01.einfochips.com) ([10.100.49.50])
  by naesa05out.arrow.com with ESMTP; 11 Mar 2025 01:34:40 -0600
Received: from AHMCPU1888.ap.corp.arrow.com ([172.25.5.100]) by eicahmirelay01.einfochips.com with Microsoft SMTPSVC(10.0.14393.4169);
	 Tue, 11 Mar 2025 13:04:33 +0530
From: Pinkesh Vaghela <pinkesh.vaghela@einfochips.com>
To: Conor Dooley <conor@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Min Lin <linmin@eswincomputing.com>,
	Pinkesh Vaghela <pinkesh.vaghela@einfochips.com>,
	Pritesh Patel <pritesh.patel@einfochips.com>,
	Yangyu Chen <cyy@cyyself.name>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Yu Chien Peter Lin <peterlin@andestech.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Kanak Shilledar <kanakshilledar@gmail.com>,
	Darshan Prajapati <darshan.prajapati@einfochips.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Aradhya Bhatia <a-bhatia1@ti.com>,
	rafal@milecki.pl,
	Anup Patel <anup@brainfault.org>,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 05/10] dt-bindings: cache: sifive,ccache0: Add ESWIN EIC7700 SoC compatibility
Date: Tue, 11 Mar 2025 13:04:27 +0530
Message-Id: <20250311073432.4068512-6-pinkesh.vaghela@einfochips.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250311073432.4068512-1-pinkesh.vaghela@einfochips.com>
References: <20250311073432.4068512-1-pinkesh.vaghela@einfochips.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 11 Mar 2025 07:34:33.0003 (UTC) FILETIME=[0834FFB0:01DB9258]

From: Pritesh Patel <pritesh.patel@einfochips.com>

This cache controller is also used on the ESWIN EIC7700 SoC.
However, it have 256KB private L2 Cache and shared L3 Cache of 4MB.
So add dedicated compatible string for it.

Signed-off-by: Pritesh Patel <pritesh.patel@einfochips.com>
Reviewed-by: Samuel Holland <samuel.holland@sifive.com>
Signed-off-by: Pinkesh Vaghela <pinkesh.vaghela@einfochips.com>
---
 .../bindings/cache/sifive,ccache0.yaml        | 28 +++++++++++++++++--
 1 file changed, 25 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/cache/sifive,ccache0.yaml b/Documentation/devicetree/bindings/cache/sifive,ccache0.yaml
index 7e8cebe21584..11e9df2cd153 100644
--- a/Documentation/devicetree/bindings/cache/sifive,ccache0.yaml
+++ b/Documentation/devicetree/bindings/cache/sifive,ccache0.yaml
@@ -39,6 +39,7 @@ properties:
           - const: cache
       - items:
           - enum:
+              - eswin,eic7700-l3-cache
               - starfive,jh7100-ccache
               - starfive,jh7110-ccache
           - const: sifive,ccache0
@@ -55,10 +56,10 @@ properties:
     enum: [2, 3]
 
   cache-sets:
-    enum: [1024, 2048]
+    enum: [1024, 2048, 4096]
 
   cache-size:
-    const: 2097152
+    enum: [2097152, 4194304]
 
   cache-unified: true
 
@@ -89,6 +90,7 @@ allOf:
         compatible:
           contains:
             enum:
+              - eswin,eic7700-l3-cache
               - sifive,fu740-c000-ccache
               - starfive,jh7100-ccache
               - starfive,jh7110-ccache
@@ -122,11 +124,31 @@ allOf:
         cache-sets:
           const: 2048
 
-    else:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - microchip,mpfs-ccache
+              - sifive,fu540-c000-ccache
+
+    then:
       properties:
         cache-sets:
           const: 1024
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - eswin,eic7700-l3-cache
+
+    then:
+      properties:
+        cache-sets:
+          const: 4096
+
   - if:
       properties:
         compatible:
-- 
2.25.1


