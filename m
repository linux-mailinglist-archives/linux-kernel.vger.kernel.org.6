Return-Path: <linux-kernel+bounces-261976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 030A693BEE3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 11:18:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABA7A1F21EFD
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 09:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC17817623F;
	Thu, 25 Jul 2024 09:18:13 +0000 (UTC)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035B081E;
	Thu, 25 Jul 2024 09:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721899093; cv=none; b=r77XMx/SS2cUv9YAYS4P4DKnc+LYrCNGqDOSFxW7HIY5+znMUqJKffU0TGPrcm6jHF8t+3dAF7a30ejqpXsrOPWkAy21Hlrmvs7UYqEHCFbHq7j8jwz+asyFFI/memdyocUkq5DaVa3TLTK5RkrWFk3/EeJEl+Nm6mpyUwlNaEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721899093; c=relaxed/simple;
	bh=k+L2ODByMh7j0vBdICDPxiKB3TnUFhdFjloQ16/ieqc=;
	h=From:To:Cc:Subject:Date:Message-Id; b=ejAEpqMK8E2Be0jYqtAfma4tAJnc5G9wg8j6qG7Csly8Ux+B7bjyc3zKnI9vW0J78U0/B+20QENX+h0+dZuQDq27Ju1GlrihJd206JscMbSB/C+REFT4nntOaqxpzV4vYA2oXkqrac4fQtnSFLubnCeUcrNTd0aVhsmfKqoWRck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 7BEAF2023A8;
	Thu, 25 Jul 2024 11:18:10 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 391D62023A3;
	Thu, 25 Jul 2024 11:18:10 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 8D1F71802183;
	Thu, 25 Jul 2024 17:18:08 +0800 (+08)
From: Shengjiu Wang <shengjiu.wang@nxp.com>
To: robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	linux-imx@nxp.com,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: shengjiu.wang@gmail.com
Subject: [PATCH 0/3] arm64: dts: imx93-11x11-evk: Add several sound cards
Date: Thu, 25 Jul 2024 16:59:05 +0800
Message-Id: <1721897948-6306-1-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Add bt-sco, PDM microphone, XCVR sound card support.

Shengjiu Wang (3):
  arm64: dts: imx93-11x11-evk: add bt-sco sound card support
  arm64: dts: imx93-11x11-evk: Add PDM microphone sound card support
  arm64: dts: imx93-11x11-evk: Add audio XCVR sound card

 .../boot/dts/freescale/imx93-11x11-evk.dts    | 135 ++++++++++++++++++
 1 file changed, 135 insertions(+)

-- 
2.34.1


