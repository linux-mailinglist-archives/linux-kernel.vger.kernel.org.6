Return-Path: <linux-kernel+bounces-250261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DE37F92F5C7
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 08:55:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70482B21679
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 06:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B15113E03E;
	Fri, 12 Jul 2024 06:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U1fKW0F5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C1213D622;
	Fri, 12 Jul 2024 06:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720767290; cv=none; b=Ql0d4yjKKZeA3FdKCStHIVovLdIsO+29BvLesF0Gb1faoYUK7pxGcJbhqqftjIzR7gtY9uSksZj1nM8saww0fDXesRVAg9XD0gLp8XVkWulNHNaRBGVr2M6zlP2CAsetvRazZERYdJahXAXv4n2f4xMLC/RffSKZi7m2pFfRg4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720767290; c=relaxed/simple;
	bh=ahmwNoaojs04Fx7mXoQxYzUbWsL7zJCUJ5NMNIOghP4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PuhgsXMtVA1ppwY7NfHEhHn+CjH4/z8JaDeH2yiFIZB1dmpxHhlflygzw6BtkWMeDC/mPKPCRaPzGop9yDPIxbIbBTiaAobUTk2TDJgmZOSSyCj3rB9Bwkkd7pIXXwlbNbO5oaCGxstqhrClAMfwvyZ+UqnzOVhmk224gumTKs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U1fKW0F5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 48DDFC4AF16;
	Fri, 12 Jul 2024 06:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720767290;
	bh=ahmwNoaojs04Fx7mXoQxYzUbWsL7zJCUJ5NMNIOghP4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=U1fKW0F5DBcG3b5WF84lL3lTHiqFQpVEXInO2OJ66bw0rTDSpMTYreJ8+C7Qns8/o
	 vP7XjvUKWWwOlfxMrFrCcYPx1ElWW+EI74OOyHnq/MVLWmFB5GbFvnc9J/aWfsvCku
	 hlTicC789QkgHVASotyGNsJynCP6kcIBloqPcZH/lCqgA2ErCJtDvtpRYYaKlj1Onh
	 Yb+hfKImsKMYjw4fx2TlAwyAXu8dgkgdmWAkpZs+7JBOhL+qY6IoZztJCPr485P9Z7
	 KmkctAa4Lu1lV+FjwhRJ8tjWLGh/nWUfz6dXU1NL10fR02yiUv+NoVbk4m3BEOflem
	 DgqilNMW+qNgA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F95CC3DA4D;
	Fri, 12 Jul 2024 06:54:50 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Date: Fri, 12 Jul 2024 14:54:50 +0800
Subject: [PATCH 5/5] arm64: dts: amlogic: a4: add ao secure node
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240712-soc_info-v1-5-05ba95929d5a@amlogic.com>
References: <20240712-soc_info-v1-0-05ba95929d5a@amlogic.com>
In-Reply-To: <20240712-soc_info-v1-0-05ba95929d5a@amlogic.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Xianwei Zhao <xianwei.zhao@amlogic.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720767288; l=1030;
 i=xianwei.zhao@amlogic.com; s=20231208; h=from:subject:message-id;
 bh=G1LdCWQoDojr4AHtdIqIbyagH63JW7WzRMIuNP5lA+U=;
 b=DNHVyQ25UOpRo1hZdF91lS3hKRMODgmx0y0Pb+JM2DzwvsL2pHvqwtDWu4UG5JUlXyiieHzld
 9fjVWSrmSpkCHyiWehwBCrsEaqvudAjGUkmon5EJCEVNa29ytJ0i0vQ
X-Developer-Key: i=xianwei.zhao@amlogic.com; a=ed25519;
 pk=o4fDH8ZXL6xQg5h17eNzRljf6pwZHWWjqcOSsj3dW24=
X-Endpoint-Received: by B4 Relay for xianwei.zhao@amlogic.com/20231208 with
 auth_id=107
X-Original-From: Xianwei Zhao <xianwei.zhao@amlogic.com>
Reply-To: xianwei.zhao@amlogic.com

From: Xianwei Zhao <xianwei.zhao@amlogic.com>

Add node for board info registers, which allows getting SoC family and
board revision.

For example, with MESON_GX_SOCINFO config enabled we can get the
following information for board with Amlogic A4 SoC:
soc soc0: Amlogic A4 (A113L2) Revision 40:b (1:1) Detected.

Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
---
 arch/arm64/boot/dts/amlogic/amlogic-a4-common.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/amlogic-a4-common.dtsi b/arch/arm64/boot/dts/amlogic/amlogic-a4-common.dtsi
index 496c3a2bcf25..901103a288e4 100644
--- a/arch/arm64/boot/dts/amlogic/amlogic-a4-common.dtsi
+++ b/arch/arm64/boot/dts/amlogic/amlogic-a4-common.dtsi
@@ -67,6 +67,12 @@ uart_b: serial@7a000 {
 				clock-names = "xtal", "pclk", "baud";
 				status = "disabled";
 			};
+
+			sec_ao: ao-secure@10220 {
+				compatible = "amlogic,meson-gx-ao-secure", "syscon";
+				reg = <0x0 0x10220 0x0 0x140>;
+				amlogic,has-chip-id;
+			};
 		};
 	};
 };

-- 
2.37.1



