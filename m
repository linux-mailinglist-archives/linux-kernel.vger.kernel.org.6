Return-Path: <linux-kernel+bounces-200771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E36108FB4AE
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 16:02:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CAC62824A6
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 14:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C514145A15;
	Tue,  4 Jun 2024 14:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jjLxrkVx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DCD41448D4;
	Tue,  4 Jun 2024 14:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717509620; cv=none; b=nnpOtiqiFsVbB/sCsuuKvvZpVaOBs7Ax3U36DpTIdnivHm/pSqwwyEvCqR3FMUfrESf7BKtZXpz7VoTfOupkrhK+9J7DXq7onU/LUg5O2uB7svJ6vdDD+xLEfAYLEIPBtguXd1WYjtumz/nKBoQvQc+G61ZdmZScmeFDFIAafXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717509620; c=relaxed/simple;
	bh=hTgdd4VxlXEUeWp19ojj9wjG3qoCtaUyDpv0giCGjYo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dK569zMHFaHHyM4hrVsNYj1FAUcEeULDvTwUvnI83IO4k5MbEFw9DpvI+K1aXDhfQqDC4KuKx8cQYQ0kEruNawHweer41T0Xig8OnPCXBLzIUzIOUDSnPLRUZqo9PWMHLNS53DpzUqGErhhmSVfgvAJp2lj7LNasi4PRFL1l/mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jjLxrkVx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12185C32786;
	Tue,  4 Jun 2024 14:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717509620;
	bh=hTgdd4VxlXEUeWp19ojj9wjG3qoCtaUyDpv0giCGjYo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jjLxrkVx8rhNxbn81JEIiRJS3xk/CEOvBAYj0uN3KJDxLrkyoW57Mo0geQxofjexm
	 sgd8ysO7okVCKeiG6GGahAZNf3pk/DKgbA8BAVNdBFrLcOqPKN59cJawfOkqchJiEj
	 /soPIZxT/OYluCuOyDquntycyaZzZSK9KGT2lNfVXsm1Tp+QSK7uiIo+8ZlCMJD2tm
	 cA9+J6Sgym75E96RFFB3Ft70nTjH9R792BhsQknqbKOnhR4dzfKqMwlBXgRtWj8Sv/
	 MRg/w9trieAbE2Xg3rhVGjoDFnbk0TVeKeP9ew6GSHmrJK6vFYVT3svxF46sE77ZY0
	 Oi+AZBSzexX3A==
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
Subject: [PATCH 09/10] dt-bindings: arm: fsl: document Kontron SMARC-sAMX6i boards
Date: Tue,  4 Jun 2024 15:59:33 +0200
Message-Id: <20240604135934.1951189-10-mwalle@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240604135934.1951189-1-mwalle@kernel.org>
References: <20240604135934.1951189-1-mwalle@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Kontron SMARC-sAMX6i is just a module. There was no device tree for
an actual board for now. Document the binding to use the module on the
evaluation carrier.

Signed-off-by: Michael Walle <mwalle@kernel.org>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 6d185d09cb6a..f731fb5b5e2a 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -363,6 +363,12 @@ properties:
           - const: gw,ventana
           - const: fsl,imx6q
 
+      - description: i.MX6Q Kontron SMARC-sAMX6i on SMARC Eval Carrier 2.0
+        items:
+          - const: kontron,imx6q-samx6i-ads2
+          - const: kontron,imx6q-samx6i
+          - const: fsl,imx6q
+
       - description: i.MX6Q PHYTEC phyBOARD-Mira
         items:
           - enum:
@@ -544,6 +550,12 @@ properties:
           - const: gw,ventana
           - const: fsl,imx6dl
 
+      - description: i.MX6DL Kontron SMARC-sAMX6i on SMARC Eval Carrier 2.0
+        items:
+          - const: kontron,imx6dl-samx6i-ads2
+          - const: kontron,imx6dl-samx6i
+          - const: fsl,imx6dl
+
       - description: i.MX6DL PHYTEC phyBOARD-Mira
         items:
           - enum:
-- 
2.39.2


