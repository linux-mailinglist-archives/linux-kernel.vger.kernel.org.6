Return-Path: <linux-kernel+bounces-292023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 13812956A45
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 14:04:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92B06B242BC
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 12:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AAAC16B3BD;
	Mon, 19 Aug 2024 12:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="CvNOoKMn";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="eads0jDZ"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA5416848B;
	Mon, 19 Aug 2024 12:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724069031; cv=none; b=MPP0cti3Ox8/59e/fjmg3x8odu6PhLdhaIPRywH4dVM1anf8YqUMsLrCg4Ac4Oaj7PvWPWqKYsZWBXFKwVGT2p7C+XYMC9VeIvkWxpTlXa3Y1brxNw6j46AiH/tP1MSNW2YhLOEzLWCw1wjaUmEkle5R/uYPQZHxJYKmZQozfto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724069031; c=relaxed/simple;
	bh=TZGKNT8pAXrY4uqsP3KBRSku5qS1qDrh2E2G/CWctQM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hqiRb9lkIdQzh/n+myulT8TpbGb3ArdCTwgnrf8vJZtCRvz9ymNnRcIsAmrAzfdt/b8Le66B0jwvC7g4RHdUkp8hhLbDyhbSnVsaZTYJFdG6MjAwefxSRVPdL8jLHvv+1EA+cQSeIAnXouHnMrW3JOZLqfi+aHLLCN1QB5f5F1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=CvNOoKMn; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=eads0jDZ reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1724069029; x=1755605029;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5Y9DVM7hHM/EsVr/LYiF7eeoUKm8CmSLc91tkQSSuBM=;
  b=CvNOoKMnL1cri4P03bJ++N6rq5tOMLiEE3Q4AKnCl7j90HhBYypccSlL
   SYhMYqMlNHOhq9FLp20PBtzVYB0pHq3CP5rzxm6gL01EX9HaF4OBp3UPo
   nX3J0ropEtfO4LV916wTG0GY2v9rDYX58MdJqbxghyUnODBKvUeiohzxW
   WzbOUj7PEjHyjs+jZ+Zi35Mc41Y5lJrkDzWJXXaLclqAWChwfY1MzV+cv
   mN7gxFLqaK0lpjan4B7VgSx7xENxjuOu4dtGGJ4PU6VOW9UbI6YIq4sDD
   MiB0pllycLxDWW2AinENWKWbecSKlV2Tmz+q8dvu1BdBgCJdi2GV1txFY
   Q==;
X-CSE-ConnectionGUID: JM3Z0T98TqOqkTqipp9DJg==
X-CSE-MsgGUID: bHdXgtwwQvynAbnLgl4kAg==
X-IronPort-AV: E=Sophos;i="6.10,159,1719871200"; 
   d="scan'208";a="38467104"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 19 Aug 2024 14:03:47 +0200
X-CheckPoint: {66C334A3-11-45EF2B36-F6E28480}
X-MAIL-CPID: EB727F1666CB24F7B6B6843512764821_0
X-Control-Analysis: str=0001.0A782F17.66C334A3.00B2,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7048B1670B3;
	Mon, 19 Aug 2024 14:03:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1724069023; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=5Y9DVM7hHM/EsVr/LYiF7eeoUKm8CmSLc91tkQSSuBM=;
	b=eads0jDZSaOHOUuWXsFviDTn5R0ttJfZCGkB5ZrM+Wgi87NtnqB7LdhJ9L+9cIg5ZZVP82
	pOA6rTkM5BxMTB2TOLjhQem0BkMovuHMaXTERJUQvOv3llW257t3obNi0F/Y6jrSL3RYJk
	U0pSz1H79WgqxTzdG/yRqWdxdcbWbqXruMJfduXD/qV4zEZtcPFwkfQLkbUANkE02BiYTS
	BrQKIE+tPLE7X7wvTzVH3hKwKw+rczIKJB0iXeXA9+p5pmviGJ8jZRTyqIWdt6Wiro9kOk
	ODJEcix06RYfIb9i8qEcyKjmY0f5Sbw8biLKYTVdu2LbZfr4CgUBSOPyjQHdKw==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
	linux@ew.tq-group.com,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Peng Fan <peng.fan@nxp.com>
Subject: [PATCH v2 02/14] arm64: dts: freescale: imx93-tqma9352: add eMMC regulators
Date: Mon, 19 Aug 2024 14:03:16 +0200
Message-Id: <20240819120328.229622-3-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240819120328.229622-1-alexander.stein@ew.tq-group.com>
References: <20240819120328.229622-1-alexander.stein@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

With PMIC node in place, add the correct regulators for eMMC.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx93-tqma9352.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx93-tqma9352.dtsi b/arch/arm64/boot/dts/freescale/imx93-tqma9352.dtsi
index 041389b369af6..48ba60832eb3e 100644
--- a/arch/arm64/boot/dts/freescale/imx93-tqma9352.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx93-tqma9352.dtsi
@@ -217,6 +217,8 @@ &usdhc1 {
 	pinctrl-0 = <&pinctrl_usdhc1>;
 	pinctrl-1 = <&pinctrl_usdhc1>;
 	pinctrl-2 = <&pinctrl_usdhc1>;
+	vmmc-supply = <&buck4>;
+	vqmmc-supply = <&buck5>;
 	bus-width = <8>;
 	non-removable;
 	no-sdio;
-- 
2.34.1


