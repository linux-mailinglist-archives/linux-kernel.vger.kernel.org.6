Return-Path: <linux-kernel+bounces-367667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B18B9A0521
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 11:13:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93AC81C23A88
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 09:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9A00205142;
	Wed, 16 Oct 2024 09:13:01 +0000 (UTC)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D5B717D378;
	Wed, 16 Oct 2024 09:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729069981; cv=none; b=LjjNNJOXjMOe/oPtg0DUQwHYxsSXjhcnGR4UZ3QR8FopmdJ328GYtCDU2YKbtICLfYzqQPh9wzQMHrVK6FaIq5d5VjOiLUTxKZsZHKOQzVtxsd4dCh1OtXkQhcOOEDEgTeaxejY6yiebpjt5R/oZ3rfJcM2SRBxpxOS4D/If4vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729069981; c=relaxed/simple;
	bh=DvPiipgM8t01V2OrJWOwY1E8bBBxNqO+uolRB4fOHFg=;
	h=From:To:Subject:Date:Message-Id; b=KG8vyo6xjT/1qa4ev2oDAqboCpr8uA+oadswwgoYJcIuI4Y2Kpfo4xXs4ogyC66xH1VeNgmSZ7AnhenzPKOFHHID2zJX8xiG2mcAKe8v96yg6EeUGKHSRPFJqSGLE3hZy1fLe66FZ/o85mNHjtkNnCHGcADysZZ+iqgba2bhYlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva020.nxp.com (localhost [127.0.0.1])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 93F001A0FA4;
	Wed, 16 Oct 2024 11:12:53 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 5BBC11A0F98;
	Wed, 16 Oct 2024 11:12:53 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id ADB091939E61;
	Wed, 16 Oct 2024 17:12:51 +0800 (+08)
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
Subject: [PATCH v3 0/3] arm64: dts: imx93-9x9-qsb: Add sound card support
Date: Wed, 16 Oct 2024 16:49:14 +0800
Message-Id: <1729068557-10073-1-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Add sound card support:
wm8962 sound card, bt-sco sound card, pdm microphone.

changes in v3:
- use audio-codec as node name

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


