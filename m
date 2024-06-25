Return-Path: <linux-kernel+bounces-228315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0C20915E0D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 07:14:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E05A41C222CE
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 05:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AB2A1448C7;
	Tue, 25 Jun 2024 05:14:30 +0000 (UTC)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4807F143C70;
	Tue, 25 Jun 2024 05:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719292469; cv=none; b=FSBHOHafZ4uzPXcHoljn4cqS0ehEVexgOflXnDKMiUBtBEmzjbo85A0I5AJkwUFg6SBNAhoQRewfXE7WcsJ+UmnB+tTDlAVhEWVJv5rQ8oqRkzY/6nAA/TpbV7Zeiowy7kkTe2dm+65SH1y1Zn2jQpfM4TVNj9Vvxt11vp9ksNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719292469; c=relaxed/simple;
	bh=XMMOblrOLF5ByhGA8FgLvk6qk9PWWtZhqbgP38qjasw=;
	h=From:To:Subject:Date:Message-Id; b=CbIDp1APVKcnsDN8ZTNbwMgbw6OW9k2T/YtokCSw6oAaDUxbvvLuqTN0dU50egR5s0DW2EC7VK0xPYKfsJas1eWVqWkWKBSIUkq6QGt/c7SI1SnMd5yaQezNKLFYvWBOdrl6DbSGrIVxUYgrFMHNfyo3jrsHHeioLM4Px22zQY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 49DB5200570;
	Tue, 25 Jun 2024 07:14:21 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id F382B200559;
	Tue, 25 Jun 2024 07:14:20 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id E1C34181D0FB;
	Tue, 25 Jun 2024 13:14:18 +0800 (+08)
From: Shengjiu Wang <shengjiu.wang@nxp.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	shengjiu.wang@gmail.com,
	linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 0/3] arm64: dts: imx8mp: add audio XCVR sound card
Date: Tue, 25 Jun 2024 12:56:52 +0800
Message-Id: <1719291415-1168-1-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Add audio XCVR sound card, which support SPDIF TX & RX,
eARC RX and ARC RX.

Shengjiu Wang (3):
  ASoC: dt-bindings: fsl,xcvr: Adjust the number of interrupts
  arm64: dts: imx8mp: Add audio XCVR device node
  arm64: dts: imx8mp-evk: Add audio XCVR sound card

 .../devicetree/bindings/sound/fsl,xcvr.yaml   |  6 +++--
 arch/arm64/boot/dts/freescale/imx8mp-evk.dts  | 27 +++++++++++++++++++
 arch/arm64/boot/dts/freescale/imx8mp.dtsi     | 26 ++++++++++++++++++
 3 files changed, 57 insertions(+), 2 deletions(-)

-- 
2.34.1


