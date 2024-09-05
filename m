Return-Path: <linux-kernel+bounces-316676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED6C696D2A5
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 11:00:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2ADAB1C2179B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 09:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11DE8195FFA;
	Thu,  5 Sep 2024 09:00:22 +0000 (UTC)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26DE5192B67;
	Thu,  5 Sep 2024 09:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725526821; cv=none; b=pw1VhNtalDhGSVHYgChnhY6sMFjkV0kcqKkV0guHSt26HQzHxrmgxjDawlBb6hmIVT6tJuvIwSgeImYhOK2/uLT5vYjgIOg1DnFCRVddzB7mkG0wAe8xhmUfGTR/ShbsTKAOaa/qP2iZsUiAYNLewyT7BUmT/2QwMmoi1+xDr5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725526821; c=relaxed/simple;
	bh=E1K8UhBsCJCs8Ojb3UyXrdSCVQ5PYwg25G95bkNNnjI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=KAOq5lZRcJifEvR/iQXdNPNqp+OLwyR4WYMRMlbNIj19iUA2yEw5IxtgduXl5u03lhTr4TmgD60Nz5c0O5Z0KyJ9IYs7bOA6nhC7hZrSfhjU5jdk5Tdtbe0zEragNoqaH67y2ldGkprHmSVtasIm9AVZE0PHsIfEBrYIPQiBPg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id AE1FF200D70;
	Thu,  5 Sep 2024 11:00:18 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 73E3F202342;
	Thu,  5 Sep 2024 11:00:18 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id BBE7D1834890;
	Thu,  5 Sep 2024 17:00:16 +0800 (+08)
From: Richard Zhu <hongxing.zhu@nxp.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	abelvesa@kernel.org,
	peng.fan@nxp.com,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	festevam@gmail.com
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-clk@vger.kernel.org,
	imx@lists.linux.dev,
	kernel@pengutronix.de,
	Richard Zhu <hongxing.zhu@nxp.com>
Subject: [PATCH v4 1/2] dt-bindings: clock: nxp,imx95-blk-ctl: Add compatible string for i.MX95 HSIO BLK CTRL
Date: Thu,  5 Sep 2024 16:38:54 +0800
Message-Id: <1725525535-22924-2-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1725525535-22924-1-git-send-email-hongxing.zhu@nxp.com>
References: <1725525535-22924-1-git-send-email-hongxing.zhu@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Sort compatible entries by alphabetical order.
Then, add compatible string "nxp,imx95-hsio-blk-ctl" for i.MX95.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/clock/nxp,imx95-blk-ctl.yaml         | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/nxp,imx95-blk-ctl.yaml b/Documentation/devicetree/bindings/clock/nxp,imx95-blk-ctl.yaml
index 2dffc02dcd8b..244fe7b95fd6 100644
--- a/Documentation/devicetree/bindings/clock/nxp,imx95-blk-ctl.yaml
+++ b/Documentation/devicetree/bindings/clock/nxp,imx95-blk-ctl.yaml
@@ -13,9 +13,10 @@ properties:
   compatible:
     items:
       - enum:
-          - nxp,imx95-lvds-csr
-          - nxp,imx95-display-csr
           - nxp,imx95-camera-csr
+          - nxp,imx95-display-csr
+          - nxp,imx95-hsio-blk-ctl
+          - nxp,imx95-lvds-csr
           - nxp,imx95-vpu-csr
       - const: syscon
 
-- 
2.37.1


