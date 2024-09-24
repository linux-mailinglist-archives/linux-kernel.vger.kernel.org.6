Return-Path: <linux-kernel+bounces-337078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B6B21984500
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 13:41:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50D81B248B9
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 11:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3FD9126BF7;
	Tue, 24 Sep 2024 11:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="C+ghwE1Y"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7946B19ADB9;
	Tue, 24 Sep 2024 11:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727178061; cv=none; b=hZ3vb2tVNMSQbgdTAs2Irz07KVewFjDXT4aErRvcrRszjl2CtM7trUz6Z4kWNcGKbE8YZsd4Tg9Gy/byU/FLYu0smEVThAsj7lbAOJ2lLOPv5cSTF17fZILYOgcJePMaH2Va1aVYRa+7L8zU4+458yMdQexC/02oiSOTSBJGSL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727178061; c=relaxed/simple;
	bh=IiUCI3JZ4g4DcG0KIxqW45jhj6Um0lGhaqn65JVO4ME=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Xw9b2dJ1czwAWCRoZjk6aUBTvJgSgdcw+oieFGh9jYKwLGTFaU0MF6fJwlO7/UeTi0MP0csVgvjvwT4MfevuBr7gjAV0cwe9mBZ3ggRUhv+z+xDo45yxqlZG6cB9Slxy5cZ6URb8NXiXXCbFpTq+MaIhntAuHuCRb9mnjcswQ1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=C+ghwE1Y; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 3597E1FA23;
	Tue, 24 Sep 2024 13:40:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1727178057;
	bh=9co741zr2UlRWeCN4eaEPEYNCnJ8DvVN0AUhGdl/5O0=; h=From:To:Subject;
	b=C+ghwE1YOGzd+xT7EI34lk66l2/E/JDvkXdC/yjYE1FRdO0nExlAGlRLF6nByBS0e
	 a4HwMm4b8sZkuCcysk905RZRdyDgWkoG4VBaOSihayZeK7BR0hyK6XlSinLVUyOb/4
	 rC10GWQFV9JtQUf7mr+nCS4MqqAcGHX8L3OQKI2rhcf5sWvMNa6cfasBcFdVTHoas8
	 WFwk/2KCmBlpUIgqvw8c7DhkDEdsI2RUziha4qzOqD98yG27HSDBn9c4qLtWXGBD9X
	 Z4VcyaudlJnYE6fHwoA/VF9IhMUPlw4LjB7igICVvoahzRdkj2tqF5/x7T+p0fshEa
	 fjR19DAUJ7umg==
From: Francesco Dolcini <francesco@dolcini.it>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v1 0/3] arm64: dts: freescale: imx8mp-verdin: Add Ivy carrier
Date: Tue, 24 Sep 2024 13:40:50 +0200
Message-Id: <20240924114053.127737-1-francesco@dolcini.it>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Francesco Dolcini <francesco.dolcini@toradex.com>

Add support for the Toradex Verdin iMX8MP Ivy carrier board. Ivy is a carrier
board designed for industrial environments, supporting industrial
I/O interfaces such as CAN, RS485, RS232, Gigabit Ethernet, 0-25mA analog
inputs, relays, PCIe and more. The board also includes a TPM for security
applications.

https://www.toradex.com/products/carrier-board/ivy-carrier-board

João Paulo Gonçalves (3):
  dt-bindings: arm: freescale: Add verdin imx8mp ivy board
  arm64: dts: freescale: imx8mp-verdin: add labels to som nodes
  arm64: dts: freescale: imx8mp-verdin: Add Ivy carrier board

 .../devicetree/bindings/arm/fsl.yaml          |   2 +
 arch/arm64/boot/dts/freescale/Makefile        |   2 +
 .../boot/dts/freescale/imx8mp-verdin-ivy.dtsi | 512 ++++++++++++++++++
 .../freescale/imx8mp-verdin-nonwifi-ivy.dts   |  18 +
 .../dts/freescale/imx8mp-verdin-wifi-ivy.dts  |  18 +
 .../boot/dts/freescale/imx8mp-verdin.dtsi     |   5 +-
 6 files changed, 555 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-verdin-ivy.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-verdin-nonwifi-ivy.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-verdin-wifi-ivy.dts

-- 
2.39.5


