Return-Path: <linux-kernel+bounces-183710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5CB68C9CD9
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 14:05:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C2811F2229A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 12:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAD8C54670;
	Mon, 20 May 2024 12:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NW353wGB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E93E147F64;
	Mon, 20 May 2024 12:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716206748; cv=none; b=Mv1IFEUQ+v8J8WxuCs/IeU11VykXAl85qW2432+CVC1D4+yrqv9wvO8ZeNLwNpnIBzvtcgK3TGGtA31W/WwZTPaQL5Px5YymlZvs6VNvrKqUb4knmWwwfYygg9B9BnKXpNIreBgdUreA5ov048RQFk1TO9kanW3WixJN5cDQZ+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716206748; c=relaxed/simple;
	bh=ihphf3e+2xoqjMycX7UjOAanljK01aQaycW292KC3Ew=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=YKoivFFm5AlfeF1kGOGsJIzXVtIp6C//2cDxHMalG+QXLZZKSzZ6dgrk/7r6eNGYtIW+z1JOeeCYh/PUl3pF99WkpiulnfMCA4bCnrQWqX6QxRFD/lk9qgy4hJn+i73XCS8vY+Ae2+zBGRzAg8wNXLB5RFPFldDajpiqQnQKkns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NW353wGB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A91A8C2BD10;
	Mon, 20 May 2024 12:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716206747;
	bh=ihphf3e+2xoqjMycX7UjOAanljK01aQaycW292KC3Ew=;
	h=From:Date:Subject:To:Cc:From;
	b=NW353wGBz//sqIPuFiU0kLKhZe2yu5PTD4UB84EsVyeZbflUkizsvHj4AyHUxJtq/
	 vXDu5tum8/6mZmhQFxQQ8U1x9vv5LNjPvx0z6S5CfojpsdEL7J8T2RTnuA9bNRh1DK
	 xRO+yh/+6gzsAESxVA0K6Lk1wZwZvpiOMHGLBsbAR9rOjmfvoWW2xcx394Hun2SqHf
	 7DHc3Pe4eQF/7O9lCqNM+KcnPANgCvFrulRUE68HGMNsORenuIKOEzfZkSSgmMjNCu
	 8NRRsCJOcccsLMCCLshW3zaEN6bHx+7XuUesV4Ota/Dpg7T7ZQUVrj2CSpKDZ3OvvJ
	 CHYI5rtMrUPyQ==
From: Roger Quadros <rogerq@kernel.org>
Date: Mon, 20 May 2024 15:05:41 +0300
Subject: [PATCH] dt-bindings: soc: ti: Move ti,j721e-system-controller.yaml
 to soc/ti
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240520-for-v6-11-j721e-syscon-v1-1-f57a93e12cad@kernel.org>
X-B4-Tracking: v=1; b=H4sIAJQ8S2YC/x3MPQqAMAxA4atIZgNt/cWriIOtqcahlQZEEe9uc
 fyG9x4QSkwCQ/FAopOFY8jQZQFum8NKyEs2GGVq1RiFPiY8W9Qa985oQrnFxYCd9a3rK29rZSH
 HRyLP1z8ep/f9AOaC3QtoAAAA
To: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Abraham I <kishon@kernel.org>, 
 Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Tero Kristo <kristo@kernel.org>
Cc: "Andrew F. Davis" <afd@ti.com>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Roger Quadros <rogerq@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1693; i=rogerq@kernel.org;
 h=from:subject:message-id; bh=ihphf3e+2xoqjMycX7UjOAanljK01aQaycW292KC3Ew=;
 b=owEBbQKS/ZANAwAIAdJaa9O+djCTAcsmYgBmSzyYloFG0cbNYoIvsMeschthmd/vhp1TpuXm2
 1CgDcsy/OGJAjMEAAEIAB0WIQRBIWXUTJ9SeA+rEFjSWmvTvnYwkwUCZks8mAAKCRDSWmvTvnYw
 k+mjEADBkrgshJf8w/RM1hI/HIBC00dlgNdQwaPBHGmdwQcbI/ceY8CHGgx67jK//UtYTlbd+O2
 wMYnoh+Xidv5+FATS9RK3LAEVIlmLtqnDcTxVB/Az6p4I8gOcxPK4COEl9XyoisdSPk7j+Hmdlj
 cEJQebHr8EYcRA6DXPt41221zjqmkGdp4wL/GJ7aJaUNqv9RuRMwDvrOsDfFZ8pXn2rpvo2OfA2
 bZUvD9m+2uGc6J8oPf+ShlTxKeVd8LNtgnwWnAEjltw11bESqMGIjEF9SbVPLXCBJ83eTiTn3vM
 2qZpBfia5daaE42IYbwr4rh03d9E0FQqQx30SA9ULBkItjd01rirYii3Eg2rIwTvhSQ7kzw0Wux
 /8zwZdNkq7JRUDmkc0gQyHgoYwuc8dn2/9an5KxOxbFf6omBeh3vRPenTXu+9Zfii8165Gqr4RP
 ofbVY8HFZInh+7ZlN2L0U/oXX9AlaWMpf/RBAeFif3EDWO7RmLJWucDKHhVksQBWQRZwlmROeQd
 /uzewpiwcLs9QXbrz8rc2GcWmQlDLUPjBpauVrDujakrk8V2X1pGFodAhX8zdzRpP+wDYY5sp4z
 m/zv8fBG2v2dRoH5v0PZ47OT+ibqX5TWoZo7N+dM37ySfKkxaCK5gAjkUj49LbRNttSD/5fE73u
 DzF+FkoEq/ooEow==
X-Developer-Key: i=rogerq@kernel.org; a=openpgp;
 fpr=412165D44C9F52780FAB1058D25A6BD3BE763093

soc/ti is the more appropriate location for the system controller
device tree binding documentation so move there.

Update Kishon's email address to a working one.

Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
 .../bindings/{mfd => soc/ti}/ti,j721e-system-controller.yaml          | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/ti,j721e-system-controller.yaml b/Documentation/devicetree/bindings/soc/ti/ti,j721e-system-controller.yaml
similarity index 96%
rename from Documentation/devicetree/bindings/mfd/ti,j721e-system-controller.yaml
rename to Documentation/devicetree/bindings/soc/ti/ti,j721e-system-controller.yaml
index e6289fbe6907..378e9cc5fac2 100644
--- a/Documentation/devicetree/bindings/mfd/ti,j721e-system-controller.yaml
+++ b/Documentation/devicetree/bindings/soc/ti/ti,j721e-system-controller.yaml
@@ -2,7 +2,7 @@
 # Copyright (C) 2020 Texas Instruments Incorporated - http://www.ti.com/
 %YAML 1.2
 ---
-$id: http://devicetree.org/schemas/mfd/ti,j721e-system-controller.yaml#
+$id: http://devicetree.org/schemas/soc/ti/ti,j721e-system-controller.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: TI J721e System Controller Registers R/W
@@ -19,7 +19,7 @@ description: |
   and access the registers directly.
 
 maintainers:
-  - Kishon Vijay Abraham I <kishon@ti.com>
+  - Kishon Vijay Abraham I <kishon@kernel.org>
   - Roger Quadros <rogerq@kernel.org>
 
 properties:

---
base-commit: dd5a440a31fae6e459c0d6271dddd62825505361
change-id: 20240520-for-v6-11-j721e-syscon-7bf6c83fb40b

Best regards,
-- 
Roger Quadros <rogerq@kernel.org>


