Return-Path: <linux-kernel+bounces-200804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9185C8FB51D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 16:23:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02C7B1F21B7F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 14:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BE3712C54A;
	Tue,  4 Jun 2024 14:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bVboMyeb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADEEB8F68;
	Tue,  4 Jun 2024 14:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717510976; cv=none; b=Scx/3CO/lv3g8XazR59jvuyynkRojfSpfhQx/zQaRCtQDyZt7uO5A2xBrzTkJQs3iEPZbqnd70R9MOiT6ECOchd4glsTvlPIVG8ECRNjSfC0TYJxTKhogPSSMir/XN36Mv4NJ4GmkD64RACxSUcmzm0kCs6FxAAzQdINTSgGEE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717510976; c=relaxed/simple;
	bh=FdTguazvLu4tk48L/f04l3yuEnV7aGDYYNx41+us/Qs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CMNws6FsTu4a9lqgfno6pRy+WCTcJZr3T6sDnl4ggx5qHOt4lejbG16dRq1pBGs5tx4fMEQr2T4IxbPmx1prbi8nLNcZkA48bFhhsdqQiNcodCn1hisKDvum7eviXDij8AXRc3XKsMePj6R3l3Ad/4DUc5afdR8iIIt/D3rnf6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bVboMyeb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F4A1C2BBFC;
	Tue,  4 Jun 2024 14:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717510976;
	bh=FdTguazvLu4tk48L/f04l3yuEnV7aGDYYNx41+us/Qs=;
	h=From:To:Cc:Subject:Date:From;
	b=bVboMyebn/DjvMsctpWLi974VTBEL/aKCCC5I0DgmNuozf1Md35JJCLQktC6Wer3z
	 PByFBdgAa9WtP6+oRMrvboGhnMVIHK5QgsFVEvQERePUsNaLlNNP68HvC6RshNXl/c
	 2coTsbpXsx7hvdRoBOH/jmWg90CqxoypisXTpmr11Ekv4IYKrjKnH/OLWBLBQA+p6F
	 o+V/1qhPlFc+DoXqf2Fh4RdrP54TEvIDz3T2uwng5eEFXmeojosH/V6r2u/n6D264L
	 bTdfmg50w9CbICCssMpgU/wL/CGRUDo8vxZHLWAXahNxe52If3hSJDfx2J+aQSSaP9
	 T6d2LDfn4fIlw==
From: Michael Walle <mwalle@kernel.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	Michael Walle <mwalle@kernel.org>
Subject: [PATCH 1/2] dt-bindings: Drop Li Yang as maintainer for all bindings
Date: Tue,  4 Jun 2024 16:22:48 +0200
Message-Id: <20240604142249.1957762-1-mwalle@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove Li Yang from all device tree bindings because mails to this
address are bouncing.

Commit fbdd90334a62 ("MAINTAINERS: Drop Li Yang as their email address
stopped working") already removed the entry from the MAINTAINERS but
didn't address all the in-file entries of the device tree bindings.

Signed-off-by: Michael Walle <mwalle@kernel.org>
---
 Documentation/devicetree/bindings/arm/fsl.yaml                   | 1 -
 .../devicetree/bindings/interrupt-controller/fsl,ls-extirq.yaml  | 1 -
 .../devicetree/bindings/soc/fsl/fsl,layerscape-dcfg.yaml         | 1 -
 .../devicetree/bindings/soc/fsl/fsl,layerscape-scfg.yaml         | 1 -
 4 files changed, 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index f731fb5b5e2a..8a1f8e387a61 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -8,7 +8,6 @@ title: Freescale i.MX Platforms
 
 maintainers:
   - Shawn Guo <shawnguo@kernel.org>
-  - Li Yang <leoyang.li@nxp.com>
 
 properties:
   $nodename:
diff --git a/Documentation/devicetree/bindings/interrupt-controller/fsl,ls-extirq.yaml b/Documentation/devicetree/bindings/interrupt-controller/fsl,ls-extirq.yaml
index 887e565b9573..199b34fdbefc 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/fsl,ls-extirq.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/fsl,ls-extirq.yaml
@@ -8,7 +8,6 @@ title: Freescale Layerscape External Interrupt Controller
 
 maintainers:
   - Shawn Guo <shawnguo@kernel.org>
-  - Li Yang <leoyang.li@nxp.com>
 
 description: |
   Some Layerscape SOCs (LS1021A, LS1043A, LS1046A LS1088A, LS208xA,
diff --git a/Documentation/devicetree/bindings/soc/fsl/fsl,layerscape-dcfg.yaml b/Documentation/devicetree/bindings/soc/fsl/fsl,layerscape-dcfg.yaml
index ce1a6505eb51..3fb0534ea597 100644
--- a/Documentation/devicetree/bindings/soc/fsl/fsl,layerscape-dcfg.yaml
+++ b/Documentation/devicetree/bindings/soc/fsl/fsl,layerscape-dcfg.yaml
@@ -8,7 +8,6 @@ title: Freescale Layerscape Device Configuration Unit
 
 maintainers:
   - Shawn Guo <shawnguo@kernel.org>
-  - Li Yang <leoyang.li@nxp.com>
 
 description: |
   DCFG is the device configuration unit, that provides general purpose
diff --git a/Documentation/devicetree/bindings/soc/fsl/fsl,layerscape-scfg.yaml b/Documentation/devicetree/bindings/soc/fsl/fsl,layerscape-scfg.yaml
index a6a511b00a12..2a456c8af992 100644
--- a/Documentation/devicetree/bindings/soc/fsl/fsl,layerscape-scfg.yaml
+++ b/Documentation/devicetree/bindings/soc/fsl/fsl,layerscape-scfg.yaml
@@ -8,7 +8,6 @@ title: Freescale Layerscape Supplemental Configuration Unit
 
 maintainers:
   - Shawn Guo <shawnguo@kernel.org>
-  - Li Yang <leoyang.li@nxp.com>
 
 description: |
   SCFG is the supplemental configuration unit, that provides SoC specific
-- 
2.39.2


