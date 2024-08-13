Return-Path: <linux-kernel+bounces-284224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DB8694FE9D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 09:22:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBC431F217BA
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 07:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C943136320;
	Tue, 13 Aug 2024 07:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="jvxkAy+L";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="VzJUzHSq"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F200613B5B7;
	Tue, 13 Aug 2024 07:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723533649; cv=none; b=AJf4usfOUxaaECuRMfKv+2r3wOI0psdZCtbxd0GEckcWV3ou9v+rsk40WsEffqkgLa+HgeSxe6vL72CnKKZzVIZyHNm9N7AbA1xAOtLbhqRNeNC4YCDyBhnVHwbJokLImrjPqq8qChZA6vOXj6MsoYDrqsfpNL6evx4C6C2Wz00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723533649; c=relaxed/simple;
	bh=mR8582UXOfeF560BtgrIREXy31lSZ0XGoqRuixexRj4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bnp972Ytg6gdY2JrOG0w+Zxc3FE2fo5PD5Y7KoNVh7KhKO+h/L0wdVYdwQurkVAQ5fY5/XjgcW1FekbLMrrW/B6xlgsY70PgkH60aNoP9ORx8fhoJpyi7ES9Pls5TXucYR+sv56/WebYPO3JANDBkgmFqy4TzjGpMfDJX5AQZ6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=jvxkAy+L; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=VzJUzHSq reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1723533647; x=1755069647;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hLkJKRXyNI16qbDvdglULKUp+13S55pr1aJNCXscNAk=;
  b=jvxkAy+LSwI2VKL3T5jajSSQ6Mo8Zv2UgzacB3RfkDbfIsbqzR7MFfQP
   fInmgDOU/FagzHSXX2IGS2+mGIH8khuHniKDH0hE2+iFtArq11FJ5PdCB
   dvULcGIexCB613Awky7Zms/sSjyxzYztiOWcZc1YgbXzny9TNj+qPqvO9
   mZrjboPILO3mH6d8XL8LnDtjMg1CSWKlpStCpBRPitsZS91XZEMOKobM3
   L3YZbqRfORnmwr98mG1ZLKQDVoco8n0WpBG1s3Ic8HcAe46hQEwGnwLkD
   ut+sCFY4meaj3rIljT1LHmohDC7yGA7DSZeDKGOtdaCe7KfE/HQdx3B+q
   g==;
X-CSE-ConnectionGUID: XJk+nZjRRb+/ly1OgJuqCw==
X-CSE-MsgGUID: L/LC8sj1RoaN7B3FaC2QBA==
X-IronPort-AV: E=Sophos;i="6.09,285,1716242400"; 
   d="scan'208";a="38375996"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 13 Aug 2024 09:20:46 +0200
X-CheckPoint: {66BB094E-1B-45EF2B36-F6E28480}
X-MAIL-CPID: CD705A875DD3D56D6F919F19FE18D227_0
X-Control-Analysis: str=0001.0A782F23.66BB094E.0136,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E1DBA16A20D;
	Tue, 13 Aug 2024 09:20:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1723533642; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=hLkJKRXyNI16qbDvdglULKUp+13S55pr1aJNCXscNAk=;
	b=VzJUzHSqKFJ7lcQnKcl6QsErf4sYgFNjwOTU58V5HPcfUq1CyzZs1bqqS2AsgRxksXuwWE
	Hbfj62Z8ZEiMFylAQ0qSJvdAuiJDVGMEW7aH9jrRNzcc2I9xiM4bWU5gna2ZzNXS/1KHZC
	+cJa0J2NPRhXofubiMP/NDtBdrtqWOgZZoVlLYjraoSnFfMFfjKCilEQ4TilJB7XgKi030
	oVCVpJrfOVS412Y2VaCQMTV9YvFCq+yXq4LMXCDRyuhrq2vjE8NTTWE7AXBjkijh8Vt920
	bO03ACavyuxejAe293IuF2c/J+JNddXI/IH1iDUyIPcCRBhmAQNYWnv/bfA/oQ==
From: Max Merchel <Max.Merchel@ew.tq-group.com>
To: Shawn Guo <shawnguo@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: Max Merchel <Max.Merchel@ew.tq-group.com>,
	linux@ew.tq-group.com,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH 1/7] arm64: dts: tqmlx2160a: correct spelling of TQ-Systems
Date: Tue, 13 Aug 2024 09:20:13 +0200
Message-Id: <20240813072019.72735-2-Max.Merchel@ew.tq-group.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240813072019.72735-1-Max.Merchel@ew.tq-group.com>
References: <20240813072019.72735-1-Max.Merchel@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

TQ-Systems is written with a hyphen. The incorrect spelling with spaces
is therefore corrected.

Signed-off-by: Max Merchel <Max.Merchel@ew.tq-group.com>
---
 .../boot/dts/freescale/fsl-lx2160a-tqmlx2160a-mblx2160a.dts     | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a-tqmlx2160a-mblx2160a.dts b/arch/arm64/boot/dts/freescale/fsl-lx2160a-tqmlx2160a-mblx2160a.dts
index da0f58e26b9a..368ea563f00b 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx2160a-tqmlx2160a-mblx2160a.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a-tqmlx2160a-mblx2160a.dts
@@ -14,7 +14,7 @@
 #include "fsl-lx2160a-tqmlx2160a.dtsi"
 
 / {
-	model = "TQ Systems GmbH MBLX2160A Starterkit";
+	model = "TQ-Systems GmbH MBLX2160A Starterkit";
 	compatible = "tq,lx2160a-tqmlx2160a-mblx2160a", "tq,lx2160a-tqmlx2160a",
 		     "fsl,lx2160a";
 
-- 
2.33.0


