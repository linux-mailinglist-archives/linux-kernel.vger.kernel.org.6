Return-Path: <linux-kernel+bounces-200768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EEAC78FB4A8
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 16:01:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96D4A1F21E6A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 14:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D281318028;
	Tue,  4 Jun 2024 14:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RYUL7o6u"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE4513D24F;
	Tue,  4 Jun 2024 14:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717509610; cv=none; b=uUy9BxjchYprYSv+jayxCT8vo4WzRO91EPwsjhsTiTj3+46g/DT5jqfmeznjeBkZ3ZMiVAd4qGfeozNgCD0mk2GoqhnhhprpGDBVg35NKZnH5Ugj+GEFbh6IQSFfDqBafK+eVhuNG5xiHM8gM0gkDQjSRFTFAgIKKuxAJ8ulaOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717509610; c=relaxed/simple;
	bh=cP7uD/wG7u91xicq/qibn/jCrRGqs0slZIoz+5q3tuk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qaSbAwLwnL7tvsUrAcFr41H3SX+PFyJYFM9IUjrC4c4BiG+glOs28cX3TnbxgLurKRllRcGGVzpucKOoso1/LlVSw2rQscvqNVS5rTBtpQg6yb0EtitDUNLrA5La6d7aYUrySZhMvB7klR9Z62T70qKkRDlUW1kS2hVgZUgPW0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RYUL7o6u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEC62C4AF07;
	Tue,  4 Jun 2024 14:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717509609;
	bh=cP7uD/wG7u91xicq/qibn/jCrRGqs0slZIoz+5q3tuk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RYUL7o6uWryWEjlN0rRCAeL587woAKjq97KzFJcTzeBKoUAQbSoMwAAuIifxaB1ey
	 AX8pwjTg4ngTXHHOsVxU6EV3mbV9TBP8xyCAz2D2xTH2+spNZsKUD7CtHLuQeSDUnZ
	 D4X1U4BgDhfhoQew587hNofF7X8J1/tGEV0Z+JUdHk4Ziv+yXiMTM91h8JtPfrJSjE
	 Xlp94kJsIL/NoU0cnBcKStNPxEFD+PyHLfOAQ1eLO40U8iw7JgwG6kXkotUc1LQqGd
	 BNwEzZTlIL0tlDHHp1aB9bZdObI925AA8AGJ+Gf4lZM+gaaoC9/SVGL6f+eCYYYYYq
	 Sgj8DVHk0Jlzg==
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
Subject: [PATCH 06/10] ARM: dts: imx6qdl-kontron-samx6i: fix product name
Date: Tue,  4 Jun 2024 15:59:30 +0200
Message-Id: <20240604135934.1951189-7-mwalle@kernel.org>
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


