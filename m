Return-Path: <linux-kernel+bounces-337062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D04D9844D6
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 13:35:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7046283EA0
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 11:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CE581AC8B4;
	Tue, 24 Sep 2024 11:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="qj09czps"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17EBD1AC8AA;
	Tue, 24 Sep 2024 11:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727177470; cv=none; b=KYthMT6ImjnVtsHm+vs0Ke3XQXevDXmIap0Odi6BwIMoWBTOI2Zu3/x6fqnd+jizlvLBNFPJdi44BELFObRCZ9PfwI2YCeuZpH84QMdCPJm7qHuJgcTpZ+6Yz9+Guf3FvcYfPKTMGmrPtzruJ7/zu16naTMoo6l7ar6zF/szkh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727177470; c=relaxed/simple;
	bh=iZq8+sv4a3IPEaOahXSkkVEg0bVekSIOVDAIbPyepJ4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ANj6fR6okgX8oZ3eThppAR6lyb8rH5yq4HdvJ9NQGuFGJSpBMhQ2bGNK5RMQd6+eXBZSuTKZYvvKiSl1V69EleWcAtur3Xc+abmXZ19dV47c26/mJDFll42MFBu7e00oiX9IrzkXR+MwAbJAsB29bwnfVP110oC2jQh1YhugqW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=qj09czps; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id C35041FA77;
	Tue, 24 Sep 2024 13:30:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1727177458;
	bh=N4pgctqrOskoQnPFXmNi07OrbH9q4gxLkxyhTykt8X0=; h=From:To:Subject;
	b=qj09czpsmoeoqKZxVdoFtqr/lK7+ZdHa/Q5hT7utxzcYfnLZAWGPW+V+H2LhzKuJP
	 egk3fdbhnOPjcI2y3XUNS1mpZkstvt3I2u53WbE1B7yaGNFAy8gzsK/Fao8aZ4zIgQ
	 mqlfsjg/yICbye5pZCggkQiXNZ5iFwunvxkGMPYtCFCsuBvNcVYtW7WrV/0EOms5Qs
	 07XcRtQwh3eteCMuirKif/IN/YQmyuljhKSEgm8wh0qnBF/Uc2q+RZjI6rQXJHv1TR
	 Awkrepg1Sw09dJ92z7ax9YdkFCNtSjpOoalIdwwHN6Ftcgg6s+Z95p7ePzdBCsfqBk
	 7bMI7eLMWdx3A==
From: Francesco Dolcini <francesco@dolcini.it>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>
Cc: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Gon=C3=A7alves?= <joao.goncalves@toradex.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: [PATCH v1 1/3] dt-bindings: arm: freescale: Add verdin imx8mm ivy board
Date: Tue, 24 Sep 2024 13:30:46 +0200
Message-Id: <20240924113048.125761-2-francesco@dolcini.it>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20240924113048.125761-1-francesco@dolcini.it>
References: <20240924113048.125761-1-francesco@dolcini.it>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: João Paulo Gonçalves <joao.goncalves@toradex.com>

Add Toradex Verdin Ivy carrier board support.

https://www.toradex.com/products/carrier-board/ivy-carrier-board

Signed-off-by: João Paulo Gonçalves <joao.goncalves@toradex.com>
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 80747d79418a..fbc588a76c2b 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -996,6 +996,7 @@ properties:
               - menlo,mx8menlo                       # Verdin iMX8M Mini Module on i.MX8MM Menlo board
               - toradex,verdin-imx8mm-nonwifi-dahlia # Verdin iMX8M Mini Module on Dahlia
               - toradex,verdin-imx8mm-nonwifi-dev    # Verdin iMX8M Mini Module on Verdin Development Board
+              - toradex,verdin-imx8mm-nonwifi-ivy    # Verdin iMX8M Mini Module on Ivy
               - toradex,verdin-imx8mm-nonwifi-mallow # Verdin iMX8M Mini Module on Mallow
               - toradex,verdin-imx8mm-nonwifi-yavia  # Verdin iMX8M Mini Module on Yavia
           - const: toradex,verdin-imx8mm-nonwifi     # Verdin iMX8M Mini Module without Wi-Fi / BT
@@ -1007,6 +1008,7 @@ properties:
           - enum:
               - toradex,verdin-imx8mm-wifi-dahlia # Verdin iMX8M Mini Wi-Fi / BT Module on Dahlia
               - toradex,verdin-imx8mm-wifi-dev    # Verdin iMX8M Mini Wi-Fi / BT M. on Verdin Development B.
+              - toradex,verdin-imx8mm-wifi-ivy    # Verdin iMX8M Mini Wi-Fi / BT Module on Ivy
               - toradex,verdin-imx8mm-wifi-mallow # Verdin iMX8M Mini Wi-Fi / BT Module on Mallow
               - toradex,verdin-imx8mm-wifi-yavia  # Verdin iMX8M Mini Wi-Fi / BT Module on Yavia
           - const: toradex,verdin-imx8mm-wifi     # Verdin iMX8M Mini Wi-Fi / BT Module
-- 
2.39.5


