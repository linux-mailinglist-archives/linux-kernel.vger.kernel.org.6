Return-Path: <linux-kernel+bounces-232107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0620E91A388
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 12:11:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FA4D1F234CE
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 10:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9AE813D260;
	Thu, 27 Jun 2024 10:10:42 +0000 (UTC)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD7B13C83C;
	Thu, 27 Jun 2024 10:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719483042; cv=none; b=Puh1TlOVGZOgCSHzSnhB5L+XatDg3E3l461pjbVvbwMbrh1LiSJywYaDTXpi4mHDAytPx7WANGvFWw6LFb84xgKME0XMNo5CWG0KJ1SjTv4JB5F5BAhDSL1IInpBm/3uSsVBldHDYYWj9I9l+G8F3cE3qGKkDMmDSepJevHZt8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719483042; c=relaxed/simple;
	bh=Fu70GtrJHO5py+//DRB2JUJJpuyey7Gfe5fGukdcygY=;
	h=From:To:Subject:Date:Message-Id; b=RPqQ2pO8dcd6u9M0IVQJOE4KP0Uyr3zm+rP8LuoXFabM+eXTAtFZMGbCEumo6Kt9yZ/2x+zkZuF8MX4SLAWexYGwJDvK/VkEmPKf9lpZEtzEDGhkROh5waLtORX7j7k49scqfRLYqxyEUvH4kZwv75IJecqmebisUGKHnyR4bpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva020.nxp.com (localhost [127.0.0.1])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id A22D61A19DE;
	Thu, 27 Jun 2024 12:10:32 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 6A49F1A0868;
	Thu, 27 Jun 2024 12:10:32 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 8D872180222F;
	Thu, 27 Jun 2024 18:10:30 +0800 (+08)
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
Subject: [PATCH v2 0/3] arm64: dts: imx8mp: add audio XCVR sound card
Date: Thu, 27 Jun 2024 17:52:58 +0800
Message-Id: <1719481981-4069-1-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Add audio XCVR sound card, which support SPDIF TX & RX,
eARC RX and ARC RX.

changes in v2:
- use minItems:3 for i.MX8MP and update example

Shengjiu Wang (3):
  ASoC: dt-bindings: fsl,xcvr: Adjust the number of interrupts
  arm64: dts: imx8mp: Add audio XCVR device node
  arm64: dts: imx8mp-evk: Add audio XCVR sound card

 .../devicetree/bindings/sound/fsl,xcvr.yaml   | 11 +++++---
 arch/arm64/boot/dts/freescale/imx8mp-evk.dts  | 27 +++++++++++++++++++
 arch/arm64/boot/dts/freescale/imx8mp.dtsi     | 26 ++++++++++++++++++
 3 files changed, 61 insertions(+), 3 deletions(-)

-- 
2.34.1


