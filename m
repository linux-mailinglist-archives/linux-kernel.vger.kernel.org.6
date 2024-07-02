Return-Path: <linux-kernel+bounces-238053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 038059242B5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 17:45:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2E7728732E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 15:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F2091BC096;
	Tue,  2 Jul 2024 15:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de header.b="VHYqLSid"
Received: from mail.fris.de (mail.fris.de [116.203.77.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F201BC07D;
	Tue,  2 Jul 2024 15:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.77.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719935092; cv=none; b=cPltKYntjBEm67o6Xu5YsDwhzlE7ZB+voCm5zAYhSbA5JMHJ0DqnuKlcMDl/eyvuUk04NwB6bkAvkYDoN1kHyd/MeOvrAQghbjTjqoNlQsJ11t0GmeOhQ91kD/LIVK0yPMcxLXCGdRcjNSw1lQlLxpYQU4NkWPcl7M+npDLBCx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719935092; c=relaxed/simple;
	bh=+B5HFZZzPNn2JmY4lkyPmQPkOj2DqJDKtWdUCztVPkw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rkEoeuHo2FP2Ju3dYrJELLvWEr7v2CF981RCOB6KDhOAP2AjqguZVikIjFk+zBhsHM3HpZpIw2hTd+ffXD1hakoiaNv+T1tBx+H3BfONcuHHZi5p0gifQbpGwDOvY36ohBcVJOa2ecm9FhKdA/I5AH/OXBm8JJp187yyCajvgsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fris.de; spf=fail smtp.mailfrom=fris.de; dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de header.b=VHYqLSid; arc=none smtp.client-ip=116.203.77.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=fris.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 19E50BFB06;
	Tue,  2 Jul 2024 17:44:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
	t=1719935087; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=CBORLJR9aM7cMwsJ5VoFFFTmCJUb5MCP6fApLxgN76E=;
	b=VHYqLSidx9XZxGm0XQ8WvkbUTiDGFWnj8DPr6Ygt5KJU9rQQism1V9bbZYou0uIExwjypV
	XYRvwpsWZZ5WXgxStFicF6lB2KpgtjXodBDbW2xDlj3A0vYv9WXaqhsS+y0H/mEl53rgas
	fM5T9sJttWYT7JvKnhlhsaWvMKFjKYZSsgvb+R8ydv7hjwtz2xG3FABt4dTh3zLocB0+GM
	6Ry5u6DQYZ/qQsRZ6KdwpuceGkBgn+JRxtXfdlk23Khnt0MFdR9g87tAiYZwUppjyVvF7W
	s6OxCqcH2dfst2wqeyHENhZkDSrLuM9fB6Kvfqn6zWizSCIbZllyiRbCv21HXg==
From: Frieder Schrempf <frieder@fris.de>
To: Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Li Yang <leoyang.li@nxp.com>,
	Rob Herring <robh@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>
Cc: Frieder Schrempf <frieder.schrempf@kontron.de>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Fabio Estevam <festevam@gmail.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	Gregor Herburger <gregor.herburger@ew.tq-group.com>,
	Hiago De Franco <hiago.franco@toradex.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Joao Paulo Goncalves <joao.goncalves@toradex.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Marco Felsch <m.felsch@pengutronix.de>,
	Markus Niebel <Markus.Niebel@ew.tq-group.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH 0/3] Add support for Kontron OSM-S i.MX8MP SoM and carrier boards
Date: Tue,  2 Jul 2024 17:43:18 +0200
Message-ID: <20240702154413.968044-1-frieder@fris.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

From: Frieder Schrempf <frieder.schrempf@kontron.de>

Patch 1: board DT bindings
Patch 2: OSM-S i.MX8MP SoM and BL carrier board devicetrees
Patch 3: i.MX8MP SMARC module and eval carrier board devicetrees

Frieder Schrempf (3):
  dt-bindings: arm: fsl: Add Kontron i.MX8MP OSM-S based boards
  arm64: dts: Add support for Kontron OSM-S i.MX8MP SoM and BL carrier
    board
  arm64: dts: Add support for Kontron i.MX8MP SMARC module and eval
    carrier

 .../devicetree/bindings/arm/fsl.yaml          |  13 +
 arch/arm64/boot/dts/freescale/Makefile        |   6 +
 .../dts/freescale/imx8mp-kontron-bl-osm-s.dts | 307 ++++++
 .../boot/dts/freescale/imx8mp-kontron-dl.dtso | 112 +++
 .../dts/freescale/imx8mp-kontron-osm-s.dtsi   | 908 ++++++++++++++++++
 .../imx8mp-kontron-smarc-eval-carrier.dts     | 224 +++++
 .../dts/freescale/imx8mp-kontron-smarc.dtsi   | 271 ++++++
 7 files changed, 1841 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-kontron-bl-osm-s.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-kontron-dl.dtso
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-kontron-osm-s.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-kontron-smarc-eval-carrier.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-kontron-smarc.dtsi

-- 
2.45.2


