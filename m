Return-Path: <linux-kernel+bounces-264981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A904F93EAD4
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 03:59:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4ED2A1F21BE7
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 01:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4168A762D7;
	Mon, 29 Jul 2024 01:59:21 +0000 (UTC)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5083514293;
	Mon, 29 Jul 2024 01:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722218360; cv=none; b=t4muA2ypaiuCq8/DeXJHCyWrtHyLFPQPr8zzrgFEt1tHX7CHFudeOpMt1XQge9gE0O9iuEBVwq7AqWjpWDOwgxWJpzsENwzMHelypZvgcJsVfMCvhgoNkICZhng7Sjsql8Mtjo8F+3LE3uoKJCvQyb/0Efz8+p+nyLsU7GODQww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722218360; c=relaxed/simple;
	bh=+soWNMXY0svAwuuBqkMCARCz1bxLzhumzGOU8axk7ec=;
	h=From:To:Cc:Subject:Date:Message-Id; b=nLjJrjGYstjFp5QsBxXB26Nzy13KeZhgCx2DnYsfmQauzXobt3yjqZqPGLCVaMfaz7DzAPZLYBTNuBi9wBNgQiyK3jaGNvs954DQd5PghtBCAMdZBEDh1scqqADkcH6E87Vv1Jjnd5h0Bs3qZ6lc3Pa8U0rGPKgu+/Sw6QKYVaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 5137720062A;
	Mon, 29 Jul 2024 03:59:12 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 19D18200134;
	Mon, 29 Jul 2024 03:59:12 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 6DF34181D0F9;
	Mon, 29 Jul 2024 09:59:10 +0800 (+08)
From: Shengjiu Wang <shengjiu.wang@nxp.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	imx@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: shengjiu.wang@gmail.com
Subject: [PATCH v2 0/4] arm64: dts: imx93-11x11-evk: Add several sound cards
Date: Mon, 29 Jul 2024 09:39:55 +0800
Message-Id: <1722217199-10640-1-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Add bt-sco, PDM microphone, XCVR sound card support.

changes in v2:
- move #sound-dai-cells to i.mx93.dtsi
- fix some coding style issue
- fix CHECK_DTBS issue

Shengjiu Wang (4):
  arm64: dts: imx93: Add #sound-dai-cells property
  arm64: dts: imx93-11x11-evk: add bt-sco sound card support
  arm64: dts: imx93-11x11-evk: Add PDM microphone sound card support
  arm64: dts: imx93-11x11-evk: Add audio XCVR sound card

 .../boot/dts/freescale/imx93-11x11-evk.dts    | 132 ++++++++++++++++++
 arch/arm64/boot/dts/freescale/imx93.dtsi      |   5 +
 2 files changed, 137 insertions(+)

-- 
2.34.1


