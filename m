Return-Path: <linux-kernel+bounces-257943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CACD938129
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 14:02:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9CF028296C
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 12:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE39F12EBCE;
	Sat, 20 Jul 2024 12:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="quc1Sl5e"
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C1C13C3F2;
	Sat, 20 Jul 2024 12:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721476916; cv=none; b=R8+wSB4D0cLS+EBk+IBH8nW/guXPK1WA/+GQfeV/Ny6n97ZSVqNJWSE4MX6A7WT5FhOXk1lkrbnsbiMOmu4SgcOro8Kf1vnUbEnf2LYYUrwp/C/9j+EMQlebfy+A293aaARjqP52jMuRJsm3cl7lfU3haDypHILrODLSoc145ZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721476916; c=relaxed/simple;
	bh=NXiWrMlglO+jV4HG3GXIVCq1Shf2uRUl+8u6GCWLBZY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JXrLp6de/YasU04+VNaRQWv+0Hsd9rIgg8WZ4psnp926su1v2k17pew0BnEEp3dWXmr/BBKRQtBzkE2rjQM+Pe1+G0m4jdlrNc4eu0g6862H3EUu01FTdpl9ZKZ2Va6xT6iOd7N6VYdZ9pt0TwyG9pY2MsSi4ggObnWleXO2D8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=quc1Sl5e; arc=none smtp.client-ip=185.70.40.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1721476912; x=1721736112;
	bh=76gEJnvO3xNi3cRiBp1SHitOr2BhJ+lM7n6PxJ9UohA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=quc1Sl5ebiLBJhnTFiuIaLNXizPTm6wXMq8zg2u27VIyfIk4mmmzmoLS46ANxMlSg
	 1JxcFCjmU9r9lYFYIz8+Lzt4BvT0fLnPd/0tB+9GyomiRTzgX2hZKjun5NDjZiTLPw
	 T732rTi0fFg7IBDoAhOzCSUrsvgpWt9pU+sAIzDm6MHlqWheQW2DVPxyULiOpzWlxu
	 P4K8rTWeIxwbNp0Or5s7/Z5DzzJ72fzK0tSuPMg97/mnVWa6JtJA7eiT9HS3s+ilCG
	 h63HtAwHxzK5Vwx/I2H/XyEiLphsB35peZpdhj+VH0W62OtYC8SLF91ATF1YsTCdWg
	 iNtlvC4+IkN8Q==
Date: Sat, 20 Jul 2024 12:01:48 +0000
To: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Michal Simek <michal.simek@amd.com>
From: Harry Austen <hpausten@protonmail.com>
Cc: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Harry Austen <hpausten@protonmail.com>
Subject: [PATCH 4/7] dt-bindings: clock: xilinx: add description of user monitor interrupt
Message-ID: <20240720120048.36758-5-hpausten@protonmail.com>
In-Reply-To: <20240720120048.36758-1-hpausten@protonmail.com>
References: <20240720120048.36758-1-hpausten@protonmail.com>
Feedback-ID: 53116287:user:proton
X-Pm-Message-ID: 4eb3f6f89171b8375c8b180dfe39b4ed3a8f8191
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

This Xilinx clocking wizard IP core outputs this interrupt signal to
indicate when one of the four optional user clock inputs is either
stopped, overruns, underruns or glitches.

This functionality was only added from version 6.0 onwards, so restrict
it to particular compatible strings.

Signed-off-by: Harry Austen <hpausten@protonmail.com>
---
 .../bindings/clock/xlnx,clocking-wizard.yaml  | 22 ++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/clock/xlnx,clocking-wizard.y=
aml b/Documentation/devicetree/bindings/clock/xlnx,clocking-wizard.yaml
index 9d5324dc1027a..4609bb56b06b5 100644
--- a/Documentation/devicetree/bindings/clock/xlnx,clocking-wizard.yaml
+++ b/Documentation/devicetree/bindings/clock/xlnx,clocking-wizard.yaml
@@ -62,17 +62,37 @@ required:
   - xlnx,speed-grade
   - xlnx,nr-outputs
=20
+allOf:
+  - if:
+      properties:
+        compatible:
+          enum:
+            - xlnx,clocking-wizard-v6.0
+            - xlnx,versal-clk-wizard
+    then:
+      properties:
+        interrupts:
+          items:
+            - description: user clock monitor interrupt
+
+        interrupt-names:
+          items:
+            - const: monitor
+
 additionalProperties: false
=20
 examples:
   - |
+    #include <dt-bindings/interrupt-controller/irq.h>
     clock-controller@b0000000  {
-        compatible =3D "xlnx,clocking-wizard";
+        compatible =3D "xlnx,clocking-wizard-v6.0";
         reg =3D <0xb0000000 0x10000>;
         #clock-cells =3D <1>;
         xlnx,speed-grade =3D <1>;
         xlnx,nr-outputs =3D <6>;
         clock-names =3D "clk_in1", "s_axi_aclk";
         clocks =3D <&clkc 15>, <&clkc 15>;
+        interrupts-extended =3D <&intc 52 IRQ_TYPE_EDGE_RISING>;
+        interrupt-names =3D "monitor";
     };
 ...
--=20
2.45.2



