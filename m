Return-Path: <linux-kernel+bounces-337101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19845984561
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 14:01:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4CC61F24711
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 12:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B028B1A7269;
	Tue, 24 Sep 2024 12:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="ceegyyov"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5631A705B;
	Tue, 24 Sep 2024 12:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727179256; cv=none; b=jRQi3r6iybQGaF6TfNCf4rOs4DlOlx+emBZOKIFPA8BSyuyAA8zxEeMzNLUSxECPN4FwCZzAkhWuT1r+sGNX87aTe2zRYJWPcUFaalW1L4+ze2LppPcsz4LSp9L1n0B+vV7DFpQV/Q/tXfD5xkTJTEui9Spx2SKw3gFu1UcPF+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727179256; c=relaxed/simple;
	bh=iVjaoXAzjsPP/d17j4jkPbJ8IIm6oOmIAjtDqwHVj6o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IYPEh4ZVJUnh9kK3IH+DfljCqDwY91i5/lMFFcSGoHdnid+dxeNYCISGDHOklxmWET3JvNBgPH8dDc1w2LBidtQXRz1cN9726Z3TYOTnzart56PcDq51fPApk2McjxVVvhzToTHmIu7gaT8QKSeTpIfXjIgDSfi4fr1T21HpAlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=ceegyyov; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id EAC751FAA3;
	Tue, 24 Sep 2024 14:00:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1727179251;
	bh=V+swmTvqd/t9RZT5+SFji75XjrVPBPAJd5GtKU0hUjM=; h=From:To:Subject;
	b=ceegyyovWvivNLoopbL2RbfMM41sePS4ECNoIFg0TR+VsSkycID7Vzkwi448K9v8i
	 SftlccJuYN3fgb0uC/a9wyhyCfHNCk+vuZQtB46VX+kakWcsItQhyvZex7uLezvGxh
	 6bgho+znqPFTZq0jQQCpdmgGbMjLMBdFp2iqLD45ZPLWLfB2kzPHh1JwTPnD0b8uuj
	 5m7lJIU4jFRG/IJGKlbbqauPy1IZpvSBHpEZvYwvkq78SHS7krjeEQdOSahq/exjr7
	 W4YrtTn0XRzdubMakXLNvSsVgWP6t67vcGIkvc2Rwkd13s88KzI4vnWWP0ZsX2hBf3
	 tfSk0IiJ+kFew==
From: Francesco Dolcini <francesco@dolcini.it>
To: Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Gon=C3=A7alves?= <joao.goncalves@toradex.com>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: [PATCH v1 1/3] dt-bindings: arm: ti: Add verdin am62 ivy board
Date: Tue, 24 Sep 2024 14:00:42 +0200
Message-Id: <20240924120044.130913-2-francesco@dolcini.it>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20240924120044.130913-1-francesco@dolcini.it>
References: <20240924120044.130913-1-francesco@dolcini.it>
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
 Documentation/devicetree/bindings/arm/ti/k3.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/ti/k3.yaml b/Documentation/devicetree/bindings/arm/ti/k3.yaml
index 5df99e361c21..bccb4d2e31e4 100644
--- a/Documentation/devicetree/bindings/arm/ti/k3.yaml
+++ b/Documentation/devicetree/bindings/arm/ti/k3.yaml
@@ -56,6 +56,7 @@ properties:
           - enum:
               - toradex,verdin-am62-nonwifi-dahlia # Verdin AM62 Module on Dahlia
               - toradex,verdin-am62-nonwifi-dev    # Verdin AM62 Module on Verdin Development Board
+              - toradex,verdin-am62-nonwifi-ivy    # Verdin AM62 Module on Ivy
               - toradex,verdin-am62-nonwifi-mallow # Verdin AM62 Module on Mallow
               - toradex,verdin-am62-nonwifi-yavia  # Verdin AM62 Module on Yavia
           - const: toradex,verdin-am62-nonwifi     # Verdin AM62 Module without Wi-Fi / BT
@@ -67,6 +68,7 @@ properties:
           - enum:
               - toradex,verdin-am62-wifi-dahlia # Verdin AM62 Wi-Fi / BT Module on Dahlia
               - toradex,verdin-am62-wifi-dev    # Verdin AM62 Wi-Fi / BT M. on Verdin Development B.
+              - toradex,verdin-am62-wifi-ivy    # Verdin AM62 Wi-Fi / BT Module on Ivy
               - toradex,verdin-am62-wifi-mallow # Verdin AM62 Wi-Fi / BT Module on Mallow
               - toradex,verdin-am62-wifi-yavia  # Verdin AM62 Wi-Fi / BT Module on Yavia
           - const: toradex,verdin-am62-wifi     # Verdin AM62 Wi-Fi / BT Module
-- 
2.39.5


