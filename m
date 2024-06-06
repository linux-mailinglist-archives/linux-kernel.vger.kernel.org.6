Return-Path: <linux-kernel+bounces-203935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F8D38FE220
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 11:09:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF1CA28BE8F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 09:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47CF315572C;
	Thu,  6 Jun 2024 09:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MG/iONmL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8775414E2D5;
	Thu,  6 Jun 2024 09:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717664560; cv=none; b=Er1Gd8OIHl+aSXmWqDPVdi9qjhm5OcFqsGJJXmLXFalnBGh/JK90u99KVZpvy/VjLJGkIP4HfpjRdC8Hp4XFQMOc13M6Vw7ydZQDt9f2W5W1A4UcJ8UfsI1jSDgHF6+oKJagSTp6AcahEDanw1B9MB1mfGSAIrTBSgQNVvRxuJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717664560; c=relaxed/simple;
	bh=cP7uD/wG7u91xicq/qibn/jCrRGqs0slZIoz+5q3tuk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=M7td6vdPsq56LMAaM+zA6+GWzPBJ4657UMFU2QKsioRVVFmk3v/Fz3clPJX7j9Ec+WkxINfOdpCCwq+zT36OfXrb94EH3OAI3o0pVHiRQsh74+UOJdtSOA8as5YuU5K31NZVFx4wud6iqx8rIysRstEEkSzHxrer+u1J9327eS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MG/iONmL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55A01C4AF65;
	Thu,  6 Jun 2024 09:02:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717664560;
	bh=cP7uD/wG7u91xicq/qibn/jCrRGqs0slZIoz+5q3tuk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MG/iONmLCzdhh6DeijCIdYqCArLblx3CfaO5+e8eMqEmlFQIpWgMus3s1tz4UM1zu
	 xd/ylO+yxqSznQB5aE8GS5+cxmxZLrb9iMKyklfB4YgfQ5DGXJSe5hL1V5BbXhodHk
	 0ek9BF6uYPlz568hoyV3Y9EACWdz/4XvJz3i1xL+rU/cDGWvpKVZV2rzHFuVmxkl7p
	 gRVmoNgpl5uW3d+f771Nn5TCfsDhQzWHyXzBhIfwxklwyjDgzuERZAr7KRthIid5di
	 0JfSOkDUYQCcz1cQDSunO3uwcfyrRHjoSsfQ2yJM6FyYSac1Ws4fXepp0lR6PG3CAi
	 c47wm20AQWzWw==
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
	Marco Felsch <m.felsch@pengutronix.de>,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	Michael Walle <mwalle@kernel.org>
Subject: [PATCH v2 06/13] ARM: dts: imx6qdl-kontron-samx6i: fix product name
Date: Thu,  6 Jun 2024 11:01:59 +0200
Message-Id: <20240606090206.2021237-7-mwalle@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240606090206.2021237-1-mwalle@kernel.org>
References: <20240606090206.2021237-1-mwalle@kernel.org>
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


