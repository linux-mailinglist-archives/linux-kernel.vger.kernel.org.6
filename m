Return-Path: <linux-kernel+bounces-322571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30DCC972AFB
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 09:41:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F0B0287348
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 07:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAEA5183CA7;
	Tue, 10 Sep 2024 07:41:15 +0000 (UTC)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E363180032;
	Tue, 10 Sep 2024 07:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725954075; cv=none; b=dGOtSWvFuvMvg6iiR6oEOtcGzjUKuTK1ngwxk+u1tc+sExemB8l0Z1g3ZnaxS93LUuPg5XAvFpxdhSWDcmjxpeo7UWUOIbIZAwopQEeJ+1aCql3TsC1APz1sPMjp9iDDg3IB4sP7Wl8raUwhHYI8RyYqBFcmq3g0fJBef0CwPWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725954075; c=relaxed/simple;
	bh=PcOuKkLdV318ux2SfOeH6WRx/invjEp6iYls66ameqw=;
	h=From:To:Subject:Date:Message-Id; b=b6ipoVt8E+Iswm9b6uiHyly1gPCsKSvAA6uc90AVv7MFzg8vcb69p5W84Wv7T+ul1W7H4y11WC85fYzuLOtOjWu5AECBV/hlqkx1Dbx5sTFHFSTxHEvbkm2XUrl8kqmXxsad0tMXISvpCdCo0+xw8sN8JCmmsc903pfDVOwbFYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva020.nxp.com (localhost [127.0.0.1])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id E694A1A22B9;
	Tue, 10 Sep 2024 09:41:06 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id BA6EB1A227B;
	Tue, 10 Sep 2024 09:41:06 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 219B0180031E;
	Tue, 10 Sep 2024 15:41:05 +0800 (+08)
From: Shengjiu Wang <shengjiu.wang@nxp.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	shengjiu.wang@gmail.com
Subject: [PATCH 0/3] arm64: dts: imx93-9x9-qsb: Add sound card support
Date: Tue, 10 Sep 2024 15:19:29 +0800
Message-Id: <1725952772-30357-1-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Add sound card support:
wm8962 sound card, bt-sco sound card, pdm microphone.

Shengjiu Wang (3):
  arm64: dts: imx93-9x9-qsb: Enable sound-wm8962 sound card
  arm64: dts: imx93-9x9-qsb: add bt-sco sound card support
  arm64: dts: imx93-9x9-qsb: Add PDM microphone sound card support

 .../boot/dts/freescale/imx93-9x9-qsb.dts      | 152 ++++++++++++++++++
 1 file changed, 152 insertions(+)

-- 
2.34.1


