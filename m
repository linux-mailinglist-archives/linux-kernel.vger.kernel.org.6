Return-Path: <linux-kernel+bounces-316532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AE0B96D0CC
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 09:51:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD4C21C22F33
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 07:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 691D4193432;
	Thu,  5 Sep 2024 07:51:01 +0000 (UTC)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D69C192D80;
	Thu,  5 Sep 2024 07:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725522661; cv=none; b=IcA3kg2sMTXSOk45K72bvZk2QUgD6mNYVgqS+/UupzbLUtzoYTN7jjH2ypjjCVRFyYPKpvp4eYXmiDT6KvnIBDQC1N1AIvQ+vatTb5xgqXmykvbHm1bCmhEbobJzdhkAz2gdAJB0sy0+MaqKxNHcr8hrv+wvl2eoahoGktqfTu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725522661; c=relaxed/simple;
	bh=E1K8UhBsCJCs8Ojb3UyXrdSCVQ5PYwg25G95bkNNnjI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Oz4g7hzi2LAsuQbgxI5+7AvQ6PGWP6Xtd1ntJ6wxvcCOl5OdHAxpwsy2pNtF4ajuItxnGHExgYcEdrKw2R5dIEQb5euGZM0ZLbuqNLab2Eqjj+17zFCcf3mqIWlyaTyQjL6xreSFYF6UvYhhmD93x7cpLE3BLIYkhZYzhRkxpkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 7684D2022FC;
	Thu,  5 Sep 2024 09:50:57 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 45786200D48;
	Thu,  5 Sep 2024 09:50:57 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 442701834890;
	Thu,  5 Sep 2024 15:50:55 +0800 (+08)
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
Subject: [PATCH v3 1/2] dt-bindings: clock: nxp,imx95-blk-ctl: Add compatible string for i.MX95 HSIO BLK CTRL
Date: Thu,  5 Sep 2024 15:29:36 +0800
Message-Id: <1725521377-22645-2-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1725521377-22645-1-git-send-email-hongxing.zhu@nxp.com>
References: <1725521377-22645-1-git-send-email-hongxing.zhu@nxp.com>
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


