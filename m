Return-Path: <linux-kernel+bounces-365286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DA5BB99E000
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 09:58:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B4B1B23B2E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 07:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 712351C57A5;
	Tue, 15 Oct 2024 07:57:46 +0000 (UTC)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 911921B85DF;
	Tue, 15 Oct 2024 07:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728979066; cv=none; b=Ik0yI4OFNREAiXtw0+XiSQy7hJDr48C7LpWQoGhA0kVpVGtC4MyuHAiKmz7GvhUEU2WmN8ASwFj2Efs1UiXXE0gG/QzP5gRBamxbh1HB9anVgO4nq+snyf/E0N9FFJH7YhPLzgLPb3CpppQgQhNVgwI4CMUlfCYZQI/EfGoXj9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728979066; c=relaxed/simple;
	bh=CRACo5uLLYK4ODe5XpUAyBpxdUElx3JGPv/LZXnsxD8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Ydvt4KWtVy2CvfRWuU8BXy+6XCCS8lZb4FhSdgSolc+aCuL+DrvyHqWLe3j0s82AxM7RgpXAMGmaeAVjlatamQlKXw7kwNlM/6f1L3XMKh9+QkFdUgIs1fusHkRkf2wLx8/9v1UMb++xGVMmDzcsOs60C9ExDBRpeyFmYaYi09o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva020.nxp.com (localhost [127.0.0.1])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id E9DBB1A24B4;
	Tue, 15 Oct 2024 09:57:36 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id B1EF81A24BF;
	Tue, 15 Oct 2024 09:57:36 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id ACA62183DC02;
	Tue, 15 Oct 2024 15:57:34 +0800 (+08)
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
Cc: hongxing.zhu@nxp.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-clk@vger.kernel.org,
	imx@lists.linux.dev,
	kernel@pengutronix.de
Subject: [PATCH v5 1/2] dt-bindings: clock: nxp,imx95-blk-ctl: Add compatible string for i.MX95 HSIO BLK CTRL
Date: Tue, 15 Oct 2024 15:34:03 +0800
Message-Id: <1728977644-8207-2-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1728977644-8207-1-git-send-email-hongxing.zhu@nxp.com>
References: <1728977644-8207-1-git-send-email-hongxing.zhu@nxp.com>
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
index 5dc360b2ea4b..d0291bfff23a 100644
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
           - nxp,imx95-netcmix-blk-ctrl
           - nxp,imx95-vpu-csr
       - const: syscon
-- 
2.37.1


