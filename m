Return-Path: <linux-kernel+bounces-184214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 941F08CA46D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 00:27:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1480281B48
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 22:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C54381C2A3;
	Mon, 20 May 2024 22:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fibF9cUo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ECFB2137F;
	Mon, 20 May 2024 22:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716244022; cv=none; b=ms29MlTvgwSaLRuepm2l8gHKk3i53wlVApx+fEEVGDwTxS7xYgg2LhjYzM93aOpMRWTeQSzsgnuPNaFRNOjwE+rrmgzujsOtF9U9Kbuv+92TJc3u2gK2sT629l6pCPFmzcHexLQIMqPlN1LD7dksYhY8MJEK8+ftSWbIqkRPcCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716244022; c=relaxed/simple;
	bh=7gWt7LsLSDaZc2+yYF/VnkLMLi3Ehjxm/3v59DcqnCE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JZjnGWDtqWhMgm1Y7NUElvFweCY9qU8c+51LPI1SK+fiDeV54eFiDlibcZhKio5qF5COA/B0YvuB7bdDYHKHr2pQRh/1KcpcDUY/2Xi6K5B9a33BW4+SaUF8pZIIcDMXiMmKtGHmiqLb1Jj7CP24tQz/BCGZpfZ1iQp4QJislFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fibF9cUo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B796C2BD10;
	Mon, 20 May 2024 22:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716244021;
	bh=7gWt7LsLSDaZc2+yYF/VnkLMLi3Ehjxm/3v59DcqnCE=;
	h=From:To:Cc:Subject:Date:From;
	b=fibF9cUofd3mzERt4Mz1GFfQtob0x1Mak33/LzXHHtwJ1bURMaAmMDwZ+Dq5S0U2P
	 bYyrUekrdt9DFnSoxPA8Uax3Wj/hQ2xwceagSx3xMABkZDNzMtP6CDo5pQ8iY/Hgve
	 3gG8j1GQNBgWsDVb0qUsmUiy3tnoNKebGEnaDTEKMVVIu/Hk668OIciOVimB6eH8GH
	 /tZxplN22NMcb/tkKimGbTr46kzKMDJN2oM05dzrZKkzO6cUN9gi4lYUhWOdoeIJvb
	 +CDtlqF8Zs6iz2jcgmc73TxN/PTeaMKFAyhFcQp83/UVnBajBDEqoyb1sZVoMnEzfg
	 8PqazOu5GHyqA==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Taichi Sugaya <sugaya.taichi@socionext.com>,
	Takao Orito <orito.takao@socionext.com>
Cc: linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: clock: milbeaut: Drop providers and consumers from example
Date: Mon, 20 May 2024 17:26:45 -0500
Message-ID: <20240520222646.1741958-1-robh@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convention for examples is to only show what's covered by the binding,
so drop the consumer "socionext,milbeaut-usio-uart" and input clock
provider "fixed-clock" from the example. "socionext,milbeaut-usio-uart"
is also not documented by a schema which caused a warning.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../bindings/clock/milbeaut-clock.yaml        | 29 +------------------
 1 file changed, 1 insertion(+), 28 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/milbeaut-clock.yaml b/Documentation/devicetree/bindings/clock/milbeaut-clock.yaml
index 0af1c569eb32..d786f1e2d007 100644
--- a/Documentation/devicetree/bindings/clock/milbeaut-clock.yaml
+++ b/Documentation/devicetree/bindings/clock/milbeaut-clock.yaml
@@ -40,38 +40,11 @@ required:
 additionalProperties: false
 
 examples:
-  # Clock controller node:
   - |
-    m10v-clk-ctrl@1d021000 {
+    clock-controller@1d021000 {
         compatible = "socionext,milbeaut-m10v-ccu";
         reg = <0x1d021000 0x4000>;
         #clock-cells = <1>;
         clocks = <&clki40mhz>;
     };
-
-  # Required an external clock for Clock controller node:
-  - |
-    clocks {
-        clki40mhz: clki40mhz {
-            compatible = "fixed-clock";
-            #clock-cells = <0>;
-            clock-frequency = <40000000>;
-        };
-        /* other clocks */
-    };
-
-  # The clock consumer shall specify the desired clock-output of the clock
-  # controller as below by specifying output-id in its "clk" phandle cell.
-  # 2: uart
-  # 4: 32-bit timer
-  # 7: UHS-I/II
-  - |
-    serial@1e700010 {
-        compatible = "socionext,milbeaut-usio-uart";
-        reg = <0x1e700010 0x10>;
-        interrupts = <0 141 0x4>, <0 149 0x4>;
-        interrupt-names = "rx", "tx";
-        clocks = <&clk 2>;
-    };
-
 ...
-- 
2.43.0


