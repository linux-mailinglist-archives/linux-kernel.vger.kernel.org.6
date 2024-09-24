Return-Path: <linux-kernel+bounces-337064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 59E0E9844DA
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 13:35:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04A081F26FBB
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 11:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 287361A7AF6;
	Tue, 24 Sep 2024 11:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="IQPPA/Q8"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F471AC8AB;
	Tue, 24 Sep 2024 11:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727177470; cv=none; b=g0eTEThtIOwOsbArd8jK8bGR8TNvWtKbBEQxViS6kBurCf96Xxp29F/MnoLUgJ8aCQLGT2GjBP1Og4IrgO9xdT8Beik30BJX0MK1rMdMBtksDzNdeiAn/O5wRJ43tadJ2j7kKTQg1jeTeGeM4fepgyqNruf1K7zeFJ0G/6m4Lpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727177470; c=relaxed/simple;
	bh=9AGh2e/KWjPMH4zNXUUqdUAnvugOvM8w/uKu8iWTqmY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=sFQQJ69J261w/EYPCz3QxL8zdVBXoDX41F1NpX/ZqXKFU5YwAgE9r4GBJERfLEx32YTKbnzkfaYTT/lVXtFvpx6+jU4vMtYYzdbwNDX3esrRnwQbnu1qTZJqJzKMNQWARRwg2JKzJo/AEONBYWauMy95m7UWkDCiQzctx3878R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=IQPPA/Q8; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 1D5FC1FA23;
	Tue, 24 Sep 2024 13:30:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1727177457;
	bh=0v5f1fjph3X6q4fm3ummzDikhRtFPTP55Kr2tXN1pz4=; h=From:To:Subject;
	b=IQPPA/Q8nTfz0q0pv0J9EvPCUolcSA8QU+BLZeqxFZaKWc5xLGuCiz67NKqZSS1Rb
	 aLbbU4bK8osPb11Dooj4V+iVPC7tPuwwGLCmVg9t0uLyzEEkVxwjalfAzm75Xw7xTf
	 fQ7uoXCpSgMLSQnTNyoDKgByDznCL8U9qKN020GENgKPHIvWuOcqCBmBurIHaMzXEC
	 CwaDGnGvKZjR3U61c3qkegzC6cpaZByA4eMLfX9xrnjI60j5A1mcOa7Jt5XT4jBqnL
	 4d5APu9PqqVRwl0nzC+RyepCDJ/ItTF1x9XhyXzgckVVoCw7t3cYxdxRwaw5+og59G
	 K7T1m95+d46Kw==
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
Subject: [PATCH v1 0/3] arm64: dts: freescale: imx8mm-verdin: Add Ivy carrier board
Date: Tue, 24 Sep 2024 13:30:45 +0200
Message-Id: <20240924113048.125761-1-francesco@dolcini.it>
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

Add support for the Toradex Verdin iMX8MM Ivy carrier board. Ivy is a carrier
board designed for industrial environments, supporting industrial
I/O interfaces such as CAN, RS485, RS232, Gigabit Ethernet, 0-25mA analog
inputs, relays, PCIe and more. The board also includes a TPM for security
applications.

https://www.toradex.com/products/carrier-board/ivy-carrier-board

João Paulo Gonçalves (3):
  dt-bindings: arm: freescale: Add verdin imx8mm ivy board
  arm64: dts: freescale: imx8mm-verdin: add label to som adc node
  arm64: dts: freescale: imx8mm-verdin: Add Ivy carrier board

 .../devicetree/bindings/arm/fsl.yaml          |   2 +
 arch/arm64/boot/dts/freescale/Makefile        |   2 +
 .../boot/dts/freescale/imx8mm-verdin-ivy.dtsi | 471 ++++++++++++++++++
 .../freescale/imx8mm-verdin-nonwifi-ivy.dts   |  18 +
 .../dts/freescale/imx8mm-verdin-wifi-ivy.dts  |  18 +
 .../boot/dts/freescale/imx8mm-verdin.dtsi     |   3 +-
 6 files changed, 513 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-verdin-ivy.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-verdin-nonwifi-ivy.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-verdin-wifi-ivy.dts

-- 
2.39.5


