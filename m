Return-Path: <linux-kernel+bounces-323986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97ADC974679
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 01:44:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B8FF1F21A13
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 23:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5868E1AC45E;
	Tue, 10 Sep 2024 23:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lGfW+LQd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B001A1A4AC6;
	Tue, 10 Sep 2024 23:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726011858; cv=none; b=uha6CCLp9z9H8IHYzox2UwsOFXo+rpa5V2ZxgjqoJO80SBGWmF2vTfNB02MUIEuxM1wJDV9+m1o0ZbTeI+tRFxSkdbGMrp1ILv/tMy6MCavaDfTOAAljBrkhnmFi57FHT2cnGu71K1t+LFE4aCgyey4/HTJE0hm37m2+4G2qvvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726011858; c=relaxed/simple;
	bh=52dbOaQAtE+QBJjRy/7NqFe/CweE7AfpiSDKiTqjnSc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Qrqe18Lju+m70/6idHMOOB0U4eeqoJCH8v5zy230Doer+9r7jP3M+C56lZCvBFSq7Ya5J5DL1Y3ns34xymOioooHEz9LU11OhAhdC7FheXUZfDEKdILygnwHRQnyXeYNIeQj9nKwoJeSd4O0AfosAysTyL1lwPUXxndwxu/t3GI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lGfW+LQd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06D33C4CEC3;
	Tue, 10 Sep 2024 23:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726011858;
	bh=52dbOaQAtE+QBJjRy/7NqFe/CweE7AfpiSDKiTqjnSc=;
	h=From:To:Cc:Subject:Date:From;
	b=lGfW+LQdt7Hvg6FWWW4JPKtvNm9rou75N0NKO51O5If8V8GEQuEzECS7fs+M0Uonl
	 cRzvGS8Sz92Cs2kpZ5ZFCE2xXvaWQ7MHzdgxjxchGlB3vJZfN85WFvRwDNUyX5sNi5
	 EhyXjLXGUQx8ZnNxcdYsWFxUTh80NhM86WTj3d6JvAax2Ni9OkYuNt2sV11aAWfAdf
	 e5a+rICnZ00EwzhbKE5MH066caMpTYGjWeuqNvB1b0QThx4N0vvPzZ93UDUuQQWmU0
	 am8J79XYsiueJyXSC3K8hWByRmW0feoHKN5cxclswiZAjVaHkeSRaL3S5LswD/C1go
	 qr0wQwj+E02ww==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH] dt-bindings: clock: mediatek: Drop duplicate mediatek,mt6795-sys-clock.yaml
Date: Tue, 10 Sep 2024 18:42:37 -0500
Message-ID: <20240910234238.1028422-1-robh@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The compatible strings for mt6795 clocks are also documented in other
schemas:

"mediatek,mt6795-apmixedsys" in clock/mediatek,apmixedsys.yaml
"mediatek,mt6795-topckgen" in clock/mediatek,topckgen.yaml
"mediatek,mt6795-pericfg" in clock/mediatek,pericfg.yaml
"mediatek,mt6795-infracfg" in clock/mediatek,infracfg.yaml

The only difference is #reset-cells is not allowed in some of these,
but that aligns with actual users in .dts files.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../clock/mediatek,mt6795-sys-clock.yaml      | 54 -------------------
 1 file changed, 54 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/clock/mediatek,mt6795-sys-clock.yaml

diff --git a/Documentation/devicetree/bindings/clock/mediatek,mt6795-sys-clock.yaml b/Documentation/devicetree/bindings/clock/mediatek,mt6795-sys-clock.yaml
deleted file mode 100644
index 378b761237d3..000000000000
--- a/Documentation/devicetree/bindings/clock/mediatek,mt6795-sys-clock.yaml
+++ /dev/null
@@ -1,54 +0,0 @@
-# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
-%YAML 1.2
----
-$id: http://devicetree.org/schemas/clock/mediatek,mt6795-sys-clock.yaml#
-$schema: http://devicetree.org/meta-schemas/core.yaml#
-
-title: MediaTek System Clock Controller for MT6795
-
-maintainers:
-  - AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
-  - Chun-Jie Chen <chun-jie.chen@mediatek.com>
-
-description:
-  The Mediatek system clock controller provides various clocks and system
-  configuration like reset and bus protection on MT6795.
-
-properties:
-  compatible:
-    items:
-      - enum:
-          - mediatek,mt6795-apmixedsys
-          - mediatek,mt6795-infracfg
-          - mediatek,mt6795-pericfg
-          - mediatek,mt6795-topckgen
-      - const: syscon
-
-  reg:
-    maxItems: 1
-
-  '#clock-cells':
-    const: 1
-
-  '#reset-cells':
-    const: 1
-
-required:
-  - compatible
-  - reg
-  - '#clock-cells'
-
-additionalProperties: false
-
-examples:
-  - |
-    soc {
-        #address-cells = <2>;
-        #size-cells = <2>;
-
-        topckgen: clock-controller@10000000 {
-            compatible = "mediatek,mt6795-topckgen", "syscon";
-            reg = <0 0x10000000 0 0x1000>;
-            #clock-cells = <1>;
-        };
-    };
-- 
2.45.2


