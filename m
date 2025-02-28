Return-Path: <linux-kernel+bounces-538781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C093A49D02
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 16:15:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D2043B4B6C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 15:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD521271815;
	Fri, 28 Feb 2025 15:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="RHhemupf"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2201EF361;
	Fri, 28 Feb 2025 15:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740755644; cv=none; b=ZmDFnmRzoJ2YAMlmtbcS5tdp0cjWjQxPE0nRUPYKH3dqOyAGZ85RQWGRwVnNAuYnZ5nz02YaxZ2mw2/j2N1+Tm0RjC0gN1JwxKYBZrvI0h8aiCqt3jx+kcEVqacnfFuIf3tlhxT5h+ppvIIufFNL4I/iWAQfC0NBH8VNQmerlzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740755644; c=relaxed/simple;
	bh=8Nvd626RQX4d7HBOgnDkI1MlPnb/Qwzpr5HfeCO0wVI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=W3TSRiYDqYBmVdu6eX4GwvYb1wrnmBhYLY7nvsi2SqMnvs7Y8w1vv9vShGD1Vruk3ZFDj8QAGunVxSuKJDD38mN9p5nlLyf1Bo+gdp1diR8v4UJcdO6GBn2BFybDwY1QScAVSVLIDSTYxFVAZ3kFUPtarZ8HfpgjK/TUQYFcIrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=RHhemupf; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 372A61F843;
	Fri, 28 Feb 2025 16:13:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1740755638;
	bh=15iHJagiYHAlmG3scyQwBZ0nHkV94osZRqbySnuXxIw=; h=From:To:Subject;
	b=RHhemupfNu7Fhr2FgTRs/CaWgDNxP+tLaWODFgYN5hZ10SljFGsBs7xCj4/J6ubOY
	 RB8PlU6hyGq5OyMamLbbeNBLKBei5V7/NCV55TFr4gjHXY5AiuSoTqSfa5mQIvbiCs
	 MU0mWxwm/twOfByDokymDLNPizOADcBr579hJa0QYw87rl+kh8Vs0WxicMI7naxeol
	 VmR91noKEpPqksfS46VwbugAM5JE4sD/SNP6cPl9M/zOxn0GfZXvn9zG6sKWLNBZEe
	 6wuy0qkqRMyK727DPvNUeVVB2QUeOd5Jio3hs7FgdOsopV7n+mJdIW1HV+XjxjlYAZ
	 JGsMUQMfoZWKQ==
From: Francesco Dolcini <francesco@dolcini.it>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Stefan Agner <stefan@agner.ch>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 0/4] arm: fsl: drop usage of Toradex SOMs compatible alone
Date: Fri, 28 Feb 2025 16:13:48 +0100
Message-Id: <20250228151352.91768-1-francesco@dolcini.it>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Francesco Dolcini <francesco.dolcini@toradex.com>

The Toradex SOMs cannot be used alone without a carrier board, so drop
the usage of its compatible alone.

Francesco Dolcini (4):
  dt-bindings: arm: fsl: drop usage of Toradex SOMs compatible alone
  ARM: dts: imx6qdl-apalis/colibri: Remove compatible from SoM dtsi
  arm64: dts: imx8qm-apalis: Remove compatible from SoM dtsi
  ARM: dts: vf610-colibri: Remove compatible from SoM dtsi

 Documentation/devicetree/bindings/arm/fsl.yaml   | 16 ----------------
 arch/arm/boot/dts/nxp/imx/imx6qdl-apalis.dtsi    |  1 -
 arch/arm/boot/dts/nxp/imx/imx6qdl-colibri.dtsi   |  1 -
 arch/arm/boot/dts/nxp/vf/vf610-colibri.dtsi      |  1 -
 .../boot/dts/freescale/imx8qm-apalis-v1.1.dtsi   |  2 --
 arch/arm64/boot/dts/freescale/imx8qm-apalis.dtsi |  2 --
 6 files changed, 23 deletions(-)

-- 
2.39.5


