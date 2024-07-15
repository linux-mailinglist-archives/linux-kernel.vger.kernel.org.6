Return-Path: <linux-kernel+bounces-251983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A6615930C89
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 04:13:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C1941F212AF
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 02:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 753C110A1A;
	Mon, 15 Jul 2024 02:12:35 +0000 (UTC)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D47BA955;
	Mon, 15 Jul 2024 02:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721009555; cv=none; b=h8zfD7XzPNDKt37Pk9t+2NNZEQMMt+8Ig7S274YNZs/V3S4Jolt6K1mYOyRpvPKtQK3VjNvzTCxkU0SMBDFpuaeSeqwS83ZoO5AB5zFbt35HsUlwtqzGBDJB9uVv1nMjqviBWlIBKuP4NL+sbL08FfAqQfOhBX3Js364khiKcok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721009555; c=relaxed/simple;
	bh=fziYL4CIfY/7an2ZQNNiJpLMAF856wozBe3sz7xw0DI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=kWnOf+1m+UmfZG0RTVprOJPZ8cadnrvusS7Fn89t9dkriRmNau74n6CDFtrk0207YSP1STFTzUs4ZYy0j/v1mTHKY+cN0e0Fo69MSEUrSXJkHFozCQl/Wlef2nF2F14vbzMu8acw1YfuizZpNLV8PWNpd7UdeoMsQmItbrDn+6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 6E8C82013FF;
	Mon, 15 Jul 2024 04:12:25 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 34C482003AA;
	Mon, 15 Jul 2024 04:12:25 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 89231183ACAC;
	Mon, 15 Jul 2024 10:12:23 +0800 (+08)
From: Richard Zhu <hongxing.zhu@nxp.com>
To: tj@kernel.org,
	dlemoal@kernel.org,
	cassel@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	festevam@gmail.com
Cc: linux-ide@vger.kernel.org,
	stable@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	kernel@pengutronix.de,
	Richard Zhu <hongxing.zhu@nxp.com>
Subject: [PATCH v2 4/4] ata: ahci_imx: Correct the email address
Date: Mon, 15 Jul 2024 09:53:56 +0800
Message-Id: <1721008436-24288-5-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1721008436-24288-1-git-send-email-hongxing.zhu@nxp.com>
References: <1721008436-24288-1-git-send-email-hongxing.zhu@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Correct the email address of driver author.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 drivers/ata/ahci_imx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/ahci_imx.c b/drivers/ata/ahci_imx.c
index 12d69a6429b6a..c909668bf7204 100644
--- a/drivers/ata/ahci_imx.c
+++ b/drivers/ata/ahci_imx.c
@@ -1039,6 +1039,6 @@ static struct platform_driver imx_ahci_driver = {
 module_platform_driver(imx_ahci_driver);
 
 MODULE_DESCRIPTION("Freescale i.MX AHCI SATA platform driver");
-MODULE_AUTHOR("Richard Zhu <Hong-Xing.Zhu@freescale.com>");
+MODULE_AUTHOR("Richard Zhu <hongxing.zhu@nxp.com>");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS("platform:" DRV_NAME);
-- 
2.37.1


