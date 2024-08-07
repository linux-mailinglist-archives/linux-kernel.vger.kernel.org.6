Return-Path: <linux-kernel+bounces-278306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B583194AE93
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 19:01:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77602B24C33
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 16:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD1EC13D8B8;
	Wed,  7 Aug 2024 16:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KA0U/0S2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B955A13D2BB;
	Wed,  7 Aug 2024 16:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723049950; cv=none; b=e+0iOgBu0j2ql2uUq996vjmfafoE0nQRjJ0u4t9x/xhwL9+RQFFUhywpT1Y9OE5lDKi7OwVFC5vht4g1hhN4NENxv+R6fiTZEJ1MI1ZXGf6VfQ1incFfwX30H7tuYTBhdU4LRMBOduP79gxl67mgzAk6j+4zVKGagDAbOQM99gA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723049950; c=relaxed/simple;
	bh=vbdFAWEiqj6ShPAUeJoHxn0X1+oKzNYipb6Dvnup3Ng=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=h4efHmut41nsDAzCtpX7mLak8+FVdIrK6G5m4eGrdtsptXueV8bIeviLpx5L1CVPlDoq5LmS63QdeF3FuIUmfDi3PZeQCw/Qgf2rmWIR5QtO9X+Qmum8Ki+TCk/Fqi5jZPci0CIAo/JXEd9hg8KMAt0QL/1fVz+9/hEEFeJEG8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KA0U/0S2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEE6BC4AF0F;
	Wed,  7 Aug 2024 16:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723049949;
	bh=vbdFAWEiqj6ShPAUeJoHxn0X1+oKzNYipb6Dvnup3Ng=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=KA0U/0S20BdjnuW6Uoxyzkic6oh78rNPddLXcgEF1JljObhi44cgkqbQriB4M1pDb
	 YfEjv5nSDpc61QTI1SLOnE4ZK+7Z9mU/x25chUe8NgINndOK7DHSLeWJGw9g+7+QnK
	 JTmZd3w8RzGZuNYfu0i3aa7/gV3jYeXw/msAeXqxpJYOONtAS4lL+mvv59/e3qL8S5
	 arURPuCmx4XzdA/+BwuKcJHkGL8LnSDBWVbfntEITsOFdBYupZLicCkMIYC9OGiFVb
	 FFhUwX+XwrnC4xRoDDnJ2HuT9oVrMEp249tu3dMxRyjal7CvpDcFTM3MLtDt8cYaS3
	 pjro68RqpFP5w==
From: "Rob Herring (Arm)" <robh@kernel.org>
Date: Wed, 07 Aug 2024 10:58:54 -0600
Subject: [PATCH 2/3] dt-bindings: Move Mediatek clock controllers to
 "clock" directory
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240807-dt-mediatek-clk-v1-2-e8d568abfd48@kernel.org>
References: <20240807-dt-mediatek-clk-v1-0-e8d568abfd48@kernel.org>
In-Reply-To: <20240807-dt-mediatek-clk-v1-0-e8d568abfd48@kernel.org>
To: Stephen Boyd <sboyd@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Chun-Jie Chen <chun-jie.chen@mediatek.com>, 
 Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org
X-Mailer: b4 0.15-dev

The "arm" binding directory is for architecture specific and top-level
board bindings. Move all the MediaTek bindings implementing clock
providers from "arm/mediatek/" to "clock/" binding directories.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../devicetree/bindings/{arm/mediatek => clock}/mediatek,infracfg.yaml  | 2 +-
 .../bindings/{arm/mediatek => clock}/mediatek,mt8186-clock.yaml         | 2 +-
 .../bindings/{arm/mediatek => clock}/mediatek,mt8186-sys-clock.yaml     | 2 +-
 .../bindings/{arm/mediatek => clock}/mediatek,mt8192-clock.yaml         | 2 +-
 .../bindings/{arm/mediatek => clock}/mediatek,mt8192-sys-clock.yaml     | 2 +-
 .../bindings/{arm/mediatek => clock}/mediatek,mt8195-clock.yaml         | 2 +-
 .../bindings/{arm/mediatek => clock}/mediatek,mt8195-sys-clock.yaml     | 2 +-
 .../devicetree/bindings/{arm/mediatek => clock}/mediatek,pericfg.yaml   | 2 +-
 8 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,infracfg.yaml b/Documentation/devicetree/bindings/clock/mediatek,infracfg.yaml
similarity index 96%
rename from Documentation/devicetree/bindings/arm/mediatek/mediatek,infracfg.yaml
rename to Documentation/devicetree/bindings/clock/mediatek,infracfg.yaml
index 230b5188a88d..252c46d316ee 100644
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,infracfg.yaml
+++ b/Documentation/devicetree/bindings/clock/mediatek,infracfg.yaml
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: http://devicetree.org/schemas/arm/mediatek/mediatek,infracfg.yaml#
+$id: http://devicetree.org/schemas/clock/mediatek,infracfg.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: MediaTek Infrastructure System Configuration Controller
diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8186-clock.yaml b/Documentation/devicetree/bindings/clock/mediatek,mt8186-clock.yaml
similarity index 94%
rename from Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8186-clock.yaml
rename to Documentation/devicetree/bindings/clock/mediatek,mt8186-clock.yaml
index 7cd14b163abe..f4e58bfa504f 100644
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8186-clock.yaml
+++ b/Documentation/devicetree/bindings/clock/mediatek,mt8186-clock.yaml
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: http://devicetree.org/schemas/arm/mediatek/mediatek,mt8186-clock.yaml#
+$id: http://devicetree.org/schemas/clock/mediatek,mt8186-clock.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: MediaTek Functional Clock Controller for MT8186
diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8186-sys-clock.yaml b/Documentation/devicetree/bindings/clock/mediatek,mt8186-sys-clock.yaml
similarity index 94%
rename from Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8186-sys-clock.yaml
rename to Documentation/devicetree/bindings/clock/mediatek,mt8186-sys-clock.yaml
index 64c769416690..1c446fbc5108 100644
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8186-sys-clock.yaml
+++ b/Documentation/devicetree/bindings/clock/mediatek,mt8186-sys-clock.yaml
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: http://devicetree.org/schemas/arm/mediatek/mediatek,mt8186-sys-clock.yaml#
+$id: http://devicetree.org/schemas/clock/mediatek,mt8186-sys-clock.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: MediaTek System Clock Controller for MT8186
diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8192-clock.yaml b/Documentation/devicetree/bindings/clock/mediatek,mt8192-clock.yaml
similarity index 98%
rename from Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8192-clock.yaml
rename to Documentation/devicetree/bindings/clock/mediatek,mt8192-clock.yaml
index dff4c8e8fd4b..b8d690e28bdc 100644
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8192-clock.yaml
+++ b/Documentation/devicetree/bindings/clock/mediatek,mt8192-clock.yaml
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: http://devicetree.org/schemas/arm/mediatek/mediatek,mt8192-clock.yaml#
+$id: http://devicetree.org/schemas/clock/mediatek,mt8192-clock.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: MediaTek Functional Clock Controller for MT8192
diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8192-sys-clock.yaml b/Documentation/devicetree/bindings/clock/mediatek,mt8192-sys-clock.yaml
similarity index 94%
rename from Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8192-sys-clock.yaml
rename to Documentation/devicetree/bindings/clock/mediatek,mt8192-sys-clock.yaml
index 8d608fddf3f9..bf8c9aacdf1e 100644
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8192-sys-clock.yaml
+++ b/Documentation/devicetree/bindings/clock/mediatek,mt8192-sys-clock.yaml
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: http://devicetree.org/schemas/arm/mediatek/mediatek,mt8192-sys-clock.yaml#
+$id: http://devicetree.org/schemas/clock/mediatek,mt8192-sys-clock.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: MediaTek System Clock Controller for MT8192
diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8195-clock.yaml b/Documentation/devicetree/bindings/clock/mediatek,mt8195-clock.yaml
similarity index 98%
rename from Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8195-clock.yaml
rename to Documentation/devicetree/bindings/clock/mediatek,mt8195-clock.yaml
index d17164b0b13e..fcc963aff087 100644
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8195-clock.yaml
+++ b/Documentation/devicetree/bindings/clock/mediatek,mt8195-clock.yaml
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: http://devicetree.org/schemas/arm/mediatek/mediatek,mt8195-clock.yaml#
+$id: http://devicetree.org/schemas/clock/mediatek,mt8195-clock.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: MediaTek Functional Clock Controller for MT8195
diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8195-sys-clock.yaml b/Documentation/devicetree/bindings/clock/mediatek,mt8195-sys-clock.yaml
similarity index 95%
rename from Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8195-sys-clock.yaml
rename to Documentation/devicetree/bindings/clock/mediatek,mt8195-sys-clock.yaml
index 066c9b3d6ac9..69f096eb168d 100644
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8195-sys-clock.yaml
+++ b/Documentation/devicetree/bindings/clock/mediatek,mt8195-sys-clock.yaml
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: http://devicetree.org/schemas/arm/mediatek/mediatek,mt8195-sys-clock.yaml#
+$id: http://devicetree.org/schemas/clock/mediatek,mt8195-sys-clock.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: MediaTek System Clock Controller for MT8195
diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,pericfg.yaml b/Documentation/devicetree/bindings/clock/mediatek,pericfg.yaml
similarity index 96%
rename from Documentation/devicetree/bindings/arm/mediatek/mediatek,pericfg.yaml
rename to Documentation/devicetree/bindings/clock/mediatek,pericfg.yaml
index 33c94c491828..2f06baecfd23 100644
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,pericfg.yaml
+++ b/Documentation/devicetree/bindings/clock/mediatek,pericfg.yaml
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: http://devicetree.org/schemas/arm/mediatek/mediatek,pericfg.yaml#
+$id: http://devicetree.org/schemas/clock/mediatek,pericfg.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: MediaTek Peripheral Configuration Controller

-- 
2.43.0


