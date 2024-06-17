Return-Path: <linux-kernel+bounces-216979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C1DC90A950
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 11:17:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B94831F250EE
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 09:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48E441922EF;
	Mon, 17 Jun 2024 09:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kCm6AaBm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882D8194A43;
	Mon, 17 Jun 2024 09:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718615652; cv=none; b=fHFY4FYrOEuyNZQ4M/ecjLIIIEzAQWYjFjCeJU0OZDscAFN8JOKt8nEOuEcICgNk03zroWaC5yx0ejdeV+CYS6bkqoo8iLS1tn6ytnGeeVkVOffH+bGw/cBYV89jSEX0K604H4Gb7tzy2j2pEtqMcIowN11JipIbswi0UsxjvoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718615652; c=relaxed/simple;
	bh=cP7uD/wG7u91xicq/qibn/jCrRGqs0slZIoz+5q3tuk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pCGs+60x75b0dKJjrRd9ZAlattv5PVXya/7gaeU2I94H68NrtUtsf0KQZ6extUtWfyTZWoBYY9L4jHLxhANkbTsxOQ+4EoVVQGV8HTploC+ELvENZ9oaPQX1AhahA6eh6lG7Dpo+WcXue+uSCVCg6DyM9f0bzvt7NBh7sZ4mPDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kCm6AaBm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47742C3277B;
	Mon, 17 Jun 2024 09:14:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718615652;
	bh=cP7uD/wG7u91xicq/qibn/jCrRGqs0slZIoz+5q3tuk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kCm6AaBmez7X1vwAKAWGnf189sB/Xi+Sjvf0hxI9KY8IHvb6TnYThlMbYERr7vMLs
	 OgwauOmGXNfHOwrTcq1E7nPSaAKgAbqfOojb8Ax6pG1fh/K/uMETP9ma+TLFhu40aQ
	 cf0qTCjVp82rZBDineucSrUtq+m4TUO2HD+ovDXq48P+5tDQjZTykBf3yP/FDOkRI5
	 GhslGnuTtC2CoVEDc6N5pH/dQndFHxUMmkgQ9FTXTFooHsVX1XtrMC/uZZHJSFPOkc
	 R7Hm9GcdnfQOpcyICrtpRGBuPEeHyD3aKJwVT3Nv3BuMLi5dDg6apGauqGU/nRzIhH
	 Ra59IfNbhWQFQ==
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
	Marco Felsch <m.felsch@pengutronix.de>,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	Michael Walle <mwalle@kernel.org>
Subject: [PATCH v3 06/13] ARM: dts: imx6qdl-kontron-samx6i: fix product name
Date: Mon, 17 Jun 2024 11:13:34 +0200
Message-Id: <20240617091341.2375325-7-mwalle@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240617091341.2375325-1-mwalle@kernel.org>
References: <20240617091341.2375325-1-mwalle@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The correct name of the product is "Kontron SMARC-sAMX6i". See also
https://www.kontron.com/en/products/smarc-samx6i/p89810

Signed-off-by: Michael Walle <mwalle@kernel.org>
---
 arch/arm/boot/dts/nxp/imx/imx6dl-kontron-samx6i.dtsi | 2 +-
 arch/arm/boot/dts/nxp/imx/imx6q-kontron-samx6i.dtsi  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6dl-kontron-samx6i.dtsi b/arch/arm/boot/dts/nxp/imx/imx6dl-kontron-samx6i.dtsi
index a864fdbd5f16..5a9b819d7ee8 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6dl-kontron-samx6i.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6dl-kontron-samx6i.dtsi
@@ -7,6 +7,6 @@
 #include "imx6qdl-kontron-samx6i.dtsi"
 
 / {
-	model = "Kontron SMARC sAMX6i Dual-Lite/Solo";
+	model = "Kontron SMARC-sAMX6i Dual-Lite/Solo";
 	compatible = "kontron,imx6dl-samx6i", "fsl,imx6dl";
 };
diff --git a/arch/arm/boot/dts/nxp/imx/imx6q-kontron-samx6i.dtsi b/arch/arm/boot/dts/nxp/imx/imx6q-kontron-samx6i.dtsi
index ff062f4fd726..e76963436079 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6q-kontron-samx6i.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6q-kontron-samx6i.dtsi
@@ -7,6 +7,6 @@
 #include "imx6qdl-kontron-samx6i.dtsi"
 
 / {
-	model = "Kontron SMARC sAMX6i Quad/Dual";
+	model = "Kontron SMARC-sAMX6i Quad/Dual";
 	compatible = "kontron,imx6q-samx6i", "fsl,imx6q";
 };
-- 
2.39.2


