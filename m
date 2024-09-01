Return-Path: <linux-kernel+bounces-310267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64B0696773E
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 17:57:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21BF0281D9F
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 15:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 848AB183CC1;
	Sun,  1 Sep 2024 15:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="HiiY0uiV"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3913117E44A;
	Sun,  1 Sep 2024 15:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725206267; cv=none; b=YLfreMq4ZLLfuPklkZyPuylc9Y9wMQHnKNQ1xJrETULQIR/1XZ7akDHbBeTi7rzCmgaXVmdqSWz1XR1zmZKvcna4hh1hCV1/BhuS6eEqK47//gei1rRRGCwtk6j9tat12LzEIsWxuZsV+6rhrFfe8i4z2Njn1x6LD3noBB2Y4BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725206267; c=relaxed/simple;
	bh=Pz3p6BXkOaHToDqmV2unQYCgJaP4GueoizZQ6wAOk9c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=IStj1KisDk20Unrjs9aBAO+wbmNM3NeIz8MIi5bSiQdAluSQX885oJwn4GNLjfpwurcMpuAxiIlaGKV5U/BGjYcxmO6oeblHq1Y60oQLn+y7oOm7RDzPPgLT895+NiYzhtwKDWhThFdqobwKzmpGwtLNtOox//Iegu0ynS/yIHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=HiiY0uiV; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 74D001F9C4;
	Sun,  1 Sep 2024 17:57:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1725206255;
	bh=AKeiSu4QNwwOqxNa3f8r6M+bdrYx9CoLG51vNSpp5fc=; h=From:To:Subject;
	b=HiiY0uiVY597sFgVSFVDHVKdvNhlkoJD0FJaElUKI+TfVhDzHg5A4QhjrL7UDwWqg
	 qSAv6OQvZ4Jj28QQ+rSdUJC1vCVAwttqwvuac6+zNIWHbAsydA1XII3Dn30nuIaDqY
	 XG+IH4A7zFpWXpGn+chMNngFrkg5qAuLP/dT8iPvgjFnc9PuYnVnwtVarT/7BTFhZa
	 XM9CA8T9yXKQ/nN2qeUmIvdkICkmfkwAO0EARvHX7TplBipARozaLk0vdi8D41FG6X
	 adnuKlXrw2R1uhCrHxntfcUxL8hpG3yFxhcwU5BUC1N+P4bmfbiVRO7W5gJMQlXJUu
	 vHF2caP6PAuiw==
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
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 00/10] arm64: dts: colibri-imx8x: Various improvements and additions
Date: Sun,  1 Sep 2024 17:57:11 +0200
Message-Id: <20240901155721.7912-1-francesco@dolcini.it>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Francesco Dolcini <francesco.dolcini@toradex.com>

This series improves Toradex Colibri iMX8X support adding:
 - working ethernet
 - correct PMIC thermal zones
 - USB support
 - analogue audio
 - ADC
 - PWM
 - VPU

v2: 
 - Fix USB OTG ID GPIO property (s/id-gpio/id-gpios)
 - Keep I2C nodes sorted by address

v1: https://lore.kernel.org/lkml/20240826215922.13225-1-francesco@dolcini.it/

Emanuele Ghidoli (1):
  arm64: dts: colibri-imx8x: Add usb support

Francesco Dolcini (3):
  arm64: dts: colibri-imx8x: Add fxl6408 gpio expander
  arm64: dts: colibri-imx8x: Add PMIC thermal zone
  arm64: dts: colibri-imx8x: Add USB3803 HUB

João Paulo Gonçalves (5):
  arm64: dts: colibri-imx8x: Add analog inputs
  arm64: dts: colibri-imx8x: Add sound card
  arm64: dts: colibri-imx8x: Add vpu support
  arm64: dts: colibri-imx8x: Add adma_pwm
  arm64: dts: colibri-imx8x: Cleanup comments

Philippe Schenker (1):
  arm64: dts: colibri-imx8x: Add 50mhz clock for eth

 .../boot/dts/freescale/imx8dx-colibri.dtsi    |  11 +
 .../dts/freescale/imx8x-colibri-aster.dtsi    |  36 +++
 .../dts/freescale/imx8x-colibri-eval-v3.dtsi  |  36 +++
 .../dts/freescale/imx8x-colibri-iris.dtsi     |  36 +++
 .../boot/dts/freescale/imx8x-colibri.dtsi     | 212 +++++++++++++++++-
 5 files changed, 322 insertions(+), 9 deletions(-)

-- 
2.39.2


