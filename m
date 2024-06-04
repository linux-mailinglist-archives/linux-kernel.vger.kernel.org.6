Return-Path: <linux-kernel+bounces-200761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A5198FB499
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 15:59:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 525CB28341B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 13:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E585B15E85;
	Tue,  4 Jun 2024 13:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NHjc8q9/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E53E8F45;
	Tue,  4 Jun 2024 13:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717509589; cv=none; b=hg7qgOCuboF8B9PRY6bysv5T+eq81Cy7xc8WFfSzO41fKwbVm9H9hhJ4RHE181WscUEzRVetZrJPQVtu/vP1dakZ59pT5osKmNAg9r9qu6SaoqhIlUFByZ4naFuSqMoklsDRyE64wU0E4pQInt0D5VLw8snLH29xzzjIKFMkCcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717509589; c=relaxed/simple;
	bh=Oks7u0V0GRUE1LscejXLJ4mzQyDwSRY9QOfDXyayBXk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QK92SuaY47S9dFBSNNJFgCjPHjVf3Fi+ADoivkiIM8E5vr2YVpT7/NRa17ChUbLRtIXidlqcjniULShhHEXWEYmjs0alX6ixX1Euks2gpaVBH7nkDi7LqAU0I15ovljEijq5tlgkpPB4LClXlBgujX2/qL3BGRK+nlbev6bdjhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NHjc8q9/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2505C2BBFC;
	Tue,  4 Jun 2024 13:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717509588;
	bh=Oks7u0V0GRUE1LscejXLJ4mzQyDwSRY9QOfDXyayBXk=;
	h=From:To:Cc:Subject:Date:From;
	b=NHjc8q9/y8jHLEzxbKjQipECGKVoFTsPaKrCCBSmMenmGmYvjWXwICKxptBbZdV4w
	 JGp+LCsTM2pObvzbq9fkZ/JzrkVJDwN9GTpeO7PxSb2BN7aU2x9uKxh3TWDIKubadO
	 ePV1+rZkBLEE0qQiju2WJE/LEfZovbzsn5rxbODHAkS60nGW0Nce+nt1wapJQJF5X5
	 wCRSq4zQ4CK0JXk7gbewUUZAevRfxOrlFewXikX3/QsubXfQ8qjwm2GVK7TR+EP+a1
	 Qq0NQIiTnGQXxdc+tFQwq4ze9+gQpMP4VT73aANCgfyTpTEpH+nBZq6iMG8Y+vhdYm
	 eamalYtLtIzHQ==
From: Michael Walle <mwalle@kernel.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Li Yang <leoyang.li@nxp.com>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Priit Laes <plaes@plaes.org>,
	Michael Grzeschik <m.grzeschik@pengutronix.de>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	Michael Walle <mwalle@kernel.org>
Subject: [PATCH 00/10] ARM: dts: kontron-samx6i: various fixes
Date: Tue,  4 Jun 2024 15:59:24 +0200
Message-Id: <20240604135934.1951189-1-mwalle@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While working on a new PHY support for this board I've noticed quite
a few errors. Fix these and introduce an actual board for the
module. For now, there was just a dtsi and no actual user of it.

Michael Walle (10):
  ARM: dts: imx6qdl-kontron-samx6i: fix phy-mode
  ARM: dts: imx6qdl-kontron-samx6i: fix PHY reset
  ARM: dts: imx6qdl-kontron-samx6i: fix board reset
  ARM: dts: imx6qdl-kontron-samx6i: cleanup the PMIC node
  ARM: dts: imx6qdl-kontron-samx6i: fix SPI0 chip selects
  ARM: dts: imx6qdl-kontron-samx6i: fix product name
  ARM: dts: imx6qdl-kontron-samx6i: always enable eMMC
  ARM: dts: imx6qdl-kontron-samx6i: add SDIO_PWR_EN support
  dt-bindings: arm: fsl: document Kontron SMARC-sAMX6i boards
  ARM: dts: imx6qdl-kontron-samx6i: add actual device trees

 .../devicetree/bindings/arm/fsl.yaml          |  12 ++
 arch/arm/boot/dts/nxp/imx/Makefile            |   2 +
 .../nxp/imx/imx6dl-kontron-samx6i-ads2.dts    |  12 ++
 .../dts/nxp/imx/imx6dl-kontron-samx6i.dtsi    |   2 +-
 .../dts/nxp/imx/imx6q-kontron-samx6i-ads2.dts |  12 ++
 .../dts/nxp/imx/imx6q-kontron-samx6i.dtsi     |  25 +---
 .../nxp/imx/imx6qdl-kontron-samx6i-ads2.dtsi  | 121 ++++++++++++++++++
 .../dts/nxp/imx/imx6qdl-kontron-samx6i.dtsi   |  41 ++++--
 8 files changed, 190 insertions(+), 37 deletions(-)
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6dl-kontron-samx6i-ads2.dts
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6q-kontron-samx6i-ads2.dts
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6qdl-kontron-samx6i-ads2.dtsi

-- 
2.39.2


