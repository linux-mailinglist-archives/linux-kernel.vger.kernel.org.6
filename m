Return-Path: <linux-kernel+bounces-312467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DA3396970A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 10:28:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FE571C23A96
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 08:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C378720FABB;
	Tue,  3 Sep 2024 08:28:23 +0000 (UTC)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E792A205E07;
	Tue,  3 Sep 2024 08:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725352103; cv=none; b=JLxn2A+zpzt3U95TxmDhdd81o/qMtFY84/AM7jlNMsS9hsmh1MXEuzTLqHVOjo1jz1w2L6huw5TCs7mnKdUdlEc1XyVI9OGWfQOQBbMQ7RM0tvqBipo41VLqSU/eyGgmqUadTUcWIcREkDjBuwao9jZe87IzuwcBuhFkn1xGowA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725352103; c=relaxed/simple;
	bh=8oFiYCS5Ioy2hxq4sF3xkTJ/UPpmhNLp2U2xYW3Ieio=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=uH+aYEStL30qdJ+UWzqG3X7U2hbloKWAsoDYpTRGhRhluBxV3FQdYPSICXsON89ByiD7ovm3g00ekr4yMrolKeJf4Sa+g6NQkrVdbhIG+d1ooldjOzIoauuQ0psbuhnP7JmtG27OVJbK7NOJtq/vrwjf0fpYRi8tANG1c3R4Lz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 94CCA203174;
	Tue,  3 Sep 2024 10:21:11 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 571C4201D69;
	Tue,  3 Sep 2024 10:21:11 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 9AE821834898;
	Tue,  3 Sep 2024 16:21:09 +0800 (+08)
From: Richard Zhu <hongxing.zhu@nxp.com>
To: abelvesa@kernel.org,
	peng.fan@nxp.com,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	festevam@gmail.com
Cc: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-clk@vger.kernel.org,
	imx@lists.linux.dev,
	kernel@pengutronix.de,
	Richard Zhu <hongxing.zhu@nxp.com>
Subject: [PATCH v1 1/2] dt-bindings: clock: nxp,imx95-blk-ctl: Add compatible string for i.MX95 HSIO BLK CTRL
Date: Tue,  3 Sep 2024 15:59:56 +0800
Message-Id: <1725350397-19527-2-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1725350397-19527-1-git-send-email-hongxing.zhu@nxp.com>
References: <1725350397-19527-1-git-send-email-hongxing.zhu@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Add compatible string "nxp,imx95-hsio-blk-ctl" for iMX95.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 Documentation/devicetree/bindings/clock/nxp,imx95-blk-ctl.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/clock/nxp,imx95-blk-ctl.yaml b/Documentation/devicetree/bindings/clock/nxp,imx95-blk-ctl.yaml
index 2dffc02dcd8b..638241f6749f 100644
--- a/Documentation/devicetree/bindings/clock/nxp,imx95-blk-ctl.yaml
+++ b/Documentation/devicetree/bindings/clock/nxp,imx95-blk-ctl.yaml
@@ -17,6 +17,7 @@ properties:
           - nxp,imx95-display-csr
           - nxp,imx95-camera-csr
           - nxp,imx95-vpu-csr
+          - nxp,imx95-hsio-blk-ctl
       - const: syscon
 
   reg:
-- 
2.37.1


