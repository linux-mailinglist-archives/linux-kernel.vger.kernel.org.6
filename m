Return-Path: <linux-kernel+bounces-389723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 420949B7079
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 00:28:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED3D61F21D1F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 23:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5BE921764B;
	Wed, 30 Oct 2024 23:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="KVOmoll6"
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51DF71BD9E5;
	Wed, 30 Oct 2024 23:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730330901; cv=none; b=Mj7jRObZT7be5Vm+Rd0BPDTlnyuVBL+ISA2+nriZoS5Qe2eSZTxwzyGvapz6DhyVU66x/McjQvZfcEioX7T+6XGMT8HpImgx1+TC4KR5CZgJ7THzRXSEZxP4UMLy1QaXS/1pg8DL06MxQhb4ho+Z633EdbIRdFQyTk1U5NDRzbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730330901; c=relaxed/simple;
	bh=+VgptE/dVgJZFkkXR3/0i+wD/OC7M623YZFzl2pdBL4=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=CuQAqlVL98Lq22Eibb8z3lKqpfoDECaw9G70qGJGGv5QQrzG6rGi/YUGse3IphJ76QGAZ4c4gKxk4IcB7KiBY34rgCUYQ15IKcYtmcDi93wyG1ToHqyUa58JGoTYFj0XwPEgK0VUoADS4H52EqA5TUexHZLSOkcY/CQmWgBwo8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=KVOmoll6; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=Cc:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=SbWlkHet4fXP9lFl2lD6ycOmmj0PFUZzrw6kS0LFEug=; b=KVOmoll6AHbqhfSE/mpmM8HuHO
	+bLk3wedBks3wno9lzrogh/rOE3gStbXHDb6n+SkZYtD+j95xT/vXBydgOzCkoJUq04YqJSTGU1SV
	jDntm8wWs9URx4XZML4+FFxhovaePaLAQppdKPxzVObVpCcd6f359sB7J21xZHeM9jP817OsoBgEj
	l6XNHxDxRg4N945zf1yllwO4RiRKX5ixoJLS62kFFhG9WWA/Fasrta8ESAi9SAOHWdmu+PjhvtAfQ
	eFTAlGFgLKCo3Gri/9n5cGL5vzIuJDmRP1qp0ZfIodv6HYjmB0m9WTNK8xrj8QNGw8dQz3/1/1E0j
	a0DS8wAQ==;
From: Andreas Kemnade <andreas@kemnade.info>
To: Conor Dooley <conor+dt@kernel.org>,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-kernel@vger.kernel.org,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	devicetree@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Shawn Guo <shawnguo@kernel.org>
Cc: Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH v3 0/3] ARM: dts: add Kobo Clara 2E
Date: Thu, 31 Oct 2024 00:27:43 +0100
Message-Id: <20241030232746.2644502-1-andreas@kemnade.info>
X-Mailer: git-send-email 2.39.5
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a basic device tree for the Kobo Clara 2E Ebook reader.
It is equipped with an i.MX6SLL SoC. EPDC PMIC drivers
are not ready for mainline yet.

Changes in V3:
- removed 30MegaOhm current sense resistor nonsense

Changes in V2:
- improved commit message about devices without binding

Andreas Kemnade (3):
  dt-bindings: arm: fsl: add compatible strings for Kobo Clara 2E
  ARM: dts: imx: Add devicetree for Kobo Clara 2E
  ARM: imx_v6_v7_defconfig: Enable drivers for Kobo Clara 2E

 .../devicetree/bindings/arm/fsl.yaml          |   8 +
 arch/arm/boot/dts/nxp/imx/Makefile            |   2 +
 .../dts/nxp/imx/imx6sll-kobo-clara2e-a.dts    |  23 +
 .../dts/nxp/imx/imx6sll-kobo-clara2e-b.dts    |  23 +
 .../nxp/imx/imx6sll-kobo-clara2e-common.dtsi  | 514 ++++++++++++++++++
 arch/arm/configs/imx_v6_v7_defconfig          |   2 +
 6 files changed, 572 insertions(+)
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6sll-kobo-clara2e-a.dts
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6sll-kobo-clara2e-b.dts
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6sll-kobo-clara2e-common.dtsi

-- 
2.39.5


