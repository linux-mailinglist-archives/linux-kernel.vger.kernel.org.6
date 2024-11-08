Return-Path: <linux-kernel+bounces-401729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 959459C1E75
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 14:50:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FB031F220B3
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 13:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 575DB1F4288;
	Fri,  8 Nov 2024 13:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="W9zpGI3Y";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="l5zFpuZq"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EDAE1EF0BD;
	Fri,  8 Nov 2024 13:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731073791; cv=none; b=EEZtD6tn8e95Q8/IN1EZ929pRYPIYjq0mTSym4lGL1oXOFrkp9sk4XzGiNGHvUNloZ6u+NAEpFQAQPCvZb12nkSBgHlnAcGy5rUtm8MUWfVp2spF0KifbP0FZgLPVE/Nkfg0m+2+ZHnyr3Mjul9StVaawdacmjLROlj7PxdIz24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731073791; c=relaxed/simple;
	bh=Ex9MTb3tJ08CnuionQ7EI2lw2yPmbVER4d2Xv1+0w8k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JfgsUisyj/ASNEOrOu/iSX8xwpCWShCJ2Gz+Rkn8OvqcKTuFKC/mC8NgLteqYabxutIpEKr0osyNw9p99Y6FAM8hKAmg2FQKWvMhfg81jY4qUhgCqPVba/8K9JipH5wG9AOG7XKMWYQxPNfvbY2Ow4/762owgu9VKoK/5VLXpYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=W9zpGI3Y; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=l5zFpuZq reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1731073789; x=1762609789;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YzG2aK1GVW0ex3YNys5CXQHwFKyU6+m+2ltQfsJR9+M=;
  b=W9zpGI3Ym0+U23rGJjxwZ12p5AKbEtfDEaf6kqbsdL26r6ZLFfLosleW
   6QlL81S64+vi/AZ9IQyyDF7mDQS6wSBHj4NEXoE3k/kaTGuCvM4voDgSR
   RLXnnsQGEin7EMzV04134n0qw1InpWJcsZT6ncDBlOsIVnsfIfAATJ9d7
   gVHC4I1fZ1M2VUrmAUvaZ9uGtmgsFiw2iQKOB9+vPuc+AGBpn0nN+yEOu
   L+glfRX07a29bdELi35fNTODY0+1sXltBLCFNA9V2LnQU3P08/e9x6u7Z
   4a3AUrE+sPh0W4ml7SiVzgquVLG6ZkLHC6goj0cKQLhKpNfK/0pwUaUq4
   w==;
X-CSE-ConnectionGUID: rVST2ef8T7yfeoUOPqNzCw==
X-CSE-MsgGUID: pW64X/1jQyaOKrV5a1hMIw==
X-IronPort-AV: E=Sophos;i="6.12,138,1728943200"; 
   d="scan'208";a="39936926"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 08 Nov 2024 14:49:42 +0100
X-CheckPoint: {672E16F6-0-D31EDE1A-D52D6119}
X-MAIL-CPID: E0BE50821D55E48D00E2880561651115_5
X-Control-Analysis: str=0001.0A682F2A.672E16F6.005C,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1A8BD164DD5;
	Fri,  8 Nov 2024 14:49:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1731073777; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=YzG2aK1GVW0ex3YNys5CXQHwFKyU6+m+2ltQfsJR9+M=;
	b=l5zFpuZq4NY3O0EOniQ0bkFwlI4FSQz0Z0VfKSojNc6BWmhg1DmGgdGVJSw92PsdzAi5Xh
	Wr+KJnynmUsec70uYMnMJe9XEpp/XrXoEvDS/1vZNHCAakdoyF1iQ59lkDunHq8NSb6xGm
	CTfxlvVABIdPeT1/E7hMtzAYHGCmBm55IiH3jizBzQLBz9n+L+aAONQHaPia4x04LyOzQl
	J3W1Hzsf5WW6HkJDROkRu07zdecvE9GQYcCUrCgI/aw79u3cEpTDdvIwHHwMEWHJATw1fH
	EsKy6d6yVSJ77+4Q9TJWKZGD3YGnXyIv7f8VK/+rHGuhKkirr6YY6Fyh5YOpPQ==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	=?UTF-8?q?Jo=C3=A3o=20Rodrigues?= <jrodrigues@ubimet.com>,
	Bruno Thomsen <bruno.thomsen@gmail.com>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
	linux@ew.tq-group.com,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/8] ARM: dts: imx7-mba7: remove LVDS transmitter regulator
Date: Fri,  8 Nov 2024 14:49:19 +0100
Message-Id: <20241108134926.1324626-2-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241108134926.1324626-1-alexander.stein@ew.tq-group.com>
References: <20241108134926.1324626-1-alexander.stein@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

This regulator essentially controls the SHTDN# pin of the LVDS encoder.
Remove it for proper usage with 'lvds-encoder' driver.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 arch/arm/boot/dts/nxp/imx/imx7-mba7.dtsi | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx7-mba7.dtsi b/arch/arm/boot/dts/nxp/imx/imx7-mba7.dtsi
index e1c401f468e16..cc3760fa7d981 100644
--- a/arch/arm/boot/dts/nxp/imx/imx7-mba7.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx7-mba7.dtsi
@@ -162,15 +162,6 @@ reg_mba_12v0: regulator-mba-12v0 {
 		enable-active-high;
 	};
 
-	reg_lvds_transmitter: regulator-lvds-transmitter {
-		compatible = "regulator-fixed";
-		regulator-name = "#SHTDN_LVDS";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		gpio = <&pca9555 1 GPIO_ACTIVE_HIGH>;
-		enable-active-high;
-	};
-
 	reg_vref_1v8: regulator-vref-1v8 {
 		compatible = "regulator-fixed";
 		regulator-name = "VCC1V8_REF";
-- 
2.34.1


