Return-Path: <linux-kernel+bounces-325838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B4830975EDA
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 04:21:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E76DB238AF
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 02:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 069C86F30D;
	Thu, 12 Sep 2024 02:21:36 +0000 (UTC)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B2B6A8C1;
	Thu, 12 Sep 2024 02:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726107695; cv=none; b=Ir2DHK8387abyrIrn0H2Hc1oV3STyq6t8VNTWXzebAhTI69teIS4PiqB3ivGGUYxPCDEtgpJjBcCyNUpdebOPK0FSSTCGIbahzIfx3hI398PRc3g8PCw5CxioMFsrVu2r3FayhLShTYXtF/nCaloZk9Bw5WLEQ683cq1LGLJbf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726107695; c=relaxed/simple;
	bh=OwMxa0vZfNdCfcBN3+So0s0M5n2FfphZssLUCSKA2IY=;
	h=From:To:Subject:Date:Message-Id; b=Zi3tGB5a6brm/5CUChtaGu5SrnT2G4S8vEfxrVTH71oqqfvAn37UX382WRvgQCE4Jnm0upvQiHiDZJ4xzLHGX9bFpIw8OR4bQAmDw4LI8xBp52IWZa0cG+CpRe8OoXiKlLzm8wHBcxeIwTybqrspZH5MRnz5KXLLardpz9VELWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva020.nxp.com (localhost [127.0.0.1])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id D828D1A1B12;
	Thu, 12 Sep 2024 04:21:26 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 9EE161A0A6D;
	Thu, 12 Sep 2024 04:21:26 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 011B31840308;
	Thu, 12 Sep 2024 10:21:24 +0800 (+08)
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
Subject: [PATCH v2 0/3] arm64: dts: imx93-9x9-qsb: Add sound card support
Date: Thu, 12 Sep 2024 09:59:38 +0800
Message-Id: <1726106381-1138-1-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Add sound card support:
wm8962 sound card, bt-sco sound card, pdm microphone.

changes in v2:
- sort by node name

Shengjiu Wang (3):
  arm64: dts: imx93-9x9-qsb: Enable sound-wm8962 sound card
  arm64: dts: imx93-9x9-qsb: add bt-sco sound card support
  arm64: dts: imx93-9x9-qsb: Add PDM microphone sound card support

 .../boot/dts/freescale/imx93-9x9-qsb.dts      | 154 ++++++++++++++++++
 1 file changed, 154 insertions(+)

-- 
2.34.1


