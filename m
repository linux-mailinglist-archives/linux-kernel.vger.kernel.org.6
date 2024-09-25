Return-Path: <linux-kernel+bounces-339478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D41F19865B3
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 19:35:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 508C3B20FF5
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 17:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 173A082499;
	Wed, 25 Sep 2024 17:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OV5T7bU4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D9177107;
	Wed, 25 Sep 2024 17:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727285675; cv=none; b=Tef6VRCOMFVzr90pYGJOzPz0R2orN27h5jHwsCi+sHlqjY07LPx8yESkSjCpl65zxCbBQklLt5Ms3UCEimuZBEbkDsBN121CTcGkovXFcrLciUmIJgRKZBlH9JC9rVkXj600cbTyGfq4x+DbmoyGFoYOrOKW70zutlXkGR8GoD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727285675; c=relaxed/simple;
	bh=mLaL6C/kU60ynljr4wTnpHOwmj+CYJ2qX7inQSlCWtY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jFA84RKP1s6XaBWEGwzCM1kwUKcdsqEifvnl46biMwAy8X1Fcd1+msYIcFtXiCDaZ44hdjmkrdl07KBVVvgNqI2Cr6AaHvEM+vrjZc4p+6Qcu7+GnkN9KrozCRGRG/c2wIizsE50VO37dVftlissRQBHGkNXHWZpa3WuQ2PzjvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OV5T7bU4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D03A8C4CEC3;
	Wed, 25 Sep 2024 17:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727285675;
	bh=mLaL6C/kU60ynljr4wTnpHOwmj+CYJ2qX7inQSlCWtY=;
	h=From:To:Cc:Subject:Date:From;
	b=OV5T7bU4f811SgGRYicCvBY0YlULd/t52/yjTTTvj3afDpER7Pw3Q7elawYYEJl+t
	 CgV1cYfr/H7XbsidQz1W0oj6ykbSNXMV/PYcNfaxexyZEHwV4XSEYDkIBj0DQxscVE
	 BD3h+1327pvhGaWKzrX0pC2akIAJyzM+MCa4SnhKA8pWaktrPeban9lseQfnVaymo/
	 GrsP2xf3njtEI76LkAyu9JeUlhTEsyhwSzBCe795B6I3aSSxOnvLvyA5M/vV8zSVLI
	 5p94FpDtIIYIuuZH6yvKgcXX83bMkgRcPq4zfKTulW245DlqCk55qrzJlu+dQv1fM2
	 rehdA2akV0uWw==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Nishanth Menon <nm@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	Santosh Shilimkar <ssantosh@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lokesh Vutla <lokeshvutla@ti.com>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH] dt-bindings: interrupt-controller: ti,sci-inta: Add missing "#interrupt-cells" to example
Date: Wed, 25 Sep 2024 12:34:31 -0500
Message-ID: <20240925173432.1906168-1-robh@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enabling dtc interrupt_provider check reveals the example is missing
the "#interrupt-cells" property as it is a dependency of
"interrupt-controller".

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../devicetree/bindings/interrupt-controller/ti,sci-inta.yaml    | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/ti,sci-inta.yaml b/Documentation/devicetree/bindings/interrupt-controller/ti,sci-inta.yaml
index 6a49d74b992a..5449266f258a 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/ti,sci-inta.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/ti,sci-inta.yaml
@@ -109,6 +109,7 @@ examples:
             compatible = "ti,sci-inta";
             reg = <0x0 0x33d00000 0x0 0x100000>;
             interrupt-controller;
+            #interrupt-cells = <0>;
             msi-controller;
             interrupt-parent = <&main_navss_intr>;
             ti,sci = <&dmsc>;
-- 
2.45.2


