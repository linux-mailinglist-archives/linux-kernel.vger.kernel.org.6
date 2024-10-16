Return-Path: <linux-kernel+bounces-367793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D7209A06E4
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 12:20:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C234F284851
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 10:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F01D20696D;
	Wed, 16 Oct 2024 10:20:10 +0000 (UTC)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E65205E05;
	Wed, 16 Oct 2024 10:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729074009; cv=none; b=S5Ra1XGRc3KtVKB9r5tpcA5EJmdqrSV5t/UFHdTTgL9SwvCriLOnD/cgW5CEV0LjPVfkH2TbaV6q5F9nPJtUayOMdBaoJVUSkhECojWhq8i4asfpZyGWOyZvU3ub9HXccN40RLE6cS4EQQbjTCWDE5xbzvj/d7xRuJ62/JJwuG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729074009; c=relaxed/simple;
	bh=OQh8hZWrb0SXQV3naAq8lD1OUyuuo8RCppn4Q/0dhuE=;
	h=From:To:Subject:Date:Message-Id; b=oV/WTXeiWvSoa6UtbMGLUi8hspPcncgoqYQHxWv7hBJoPKWWHA/HZQLZOGXWLDFDtwOd/6Xe8ji4Ivshra1E04YRhpk+uAo46+MlGSeYi4KH8go1hFmvKSoJ6aPJ0nzsOLZ40rPscBNJaQQGaxhhZzlxgR9kltXxpJaUhGQy/hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva020.nxp.com (localhost [127.0.0.1])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id F332B1A0A25;
	Wed, 16 Oct 2024 12:20:05 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id B9BBD1A09D1;
	Wed, 16 Oct 2024 12:20:05 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 17AF1183DC02;
	Wed, 16 Oct 2024 18:20:04 +0800 (+08)
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
Subject: [PATCH 0/3] arm64: dts: imx8ulp-evk: add sound card support
Date: Wed, 16 Oct 2024 17:56:28 +0800
Message-Id: <1729072591-10439-1-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

add bt-sco and spdif sound card support.

Shengjiu Wang (3):
  arm64: dts: imx8ulp: Add audio device nodes
  arm64: dts: imx8ulp-evk: Add bt-sco sound card support
  arm64: dts: imx8ulp-evk: Add spdif sound card support

 arch/arm64/boot/dts/freescale/imx8ulp-evk.dts |  70 ++++++
 arch/arm64/boot/dts/freescale/imx8ulp.dtsi    | 214 ++++++++++++++++++
 2 files changed, 284 insertions(+)

-- 
2.34.1


