Return-Path: <linux-kernel+bounces-521065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 51B30A3B37E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 09:20:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC17818916D1
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 08:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F6A91C700A;
	Wed, 19 Feb 2025 08:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="aEZY12FS";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="hpGWHKpT"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 102D11C5D5A;
	Wed, 19 Feb 2025 08:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739953113; cv=none; b=Rk/rx4AQ9eCyvMtncw6RVGd3lyX6I05Cg1IzZUeS2PEgUk3+xdbWJXvEJQW1v4AHG3L9Xg6AxRrwm24EET2HqjIFQ172ECQPOPnelTAoTGMifPOOwO7vwNKZg1ZG+M6FvoDrQ+AwhYWevYMoQeB43cU0tAEmQvtXhe4YetSETbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739953113; c=relaxed/simple;
	bh=wB1J2sGSb9yTxtlqIFEmH6qf7LbWMk7G/5Osd07ZyTw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CRTU/cyUuDMzPDW5nqMZ6reH/CLJTamepY8N2Di5MWgmHMK/luany8mAwt7xHqIh4z95Fxy6UzLPF/Boqw2rGnWcCg7whhu28QRX4kjIZybc5V8Gsjzyn4P8PoMTsDR1i4I06SHEgwLegjeoSxjubhweIQ35nHfo9ScxaJI8mVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=aEZY12FS; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=hpGWHKpT reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1739953107; x=1771489107;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mgTv0R1ppnT7IOn1i1PAmOOJxoWXJpDOFFz9jf3JakM=;
  b=aEZY12FSYl+XnulYXNKvG4zgGXm0lDnPs2uz3dshQ0Euo5ZnpEB/zLIV
   mTvVwYqQQESdmDyLYtxQmlxeJkubwBRRZJ259kVLGy/6Jblb0LmVLWW1M
   Yj+Hrdr3emvMrzRnGx8ELuXGSz1QDvw49dJmNU2QVMcJBgTqKtyGhQSFU
   4DGbgODokEXI5ZE7V8rD8OAeaZ5LcMHL71L4nVa1JfQ0ZHs2L+6BiXWIU
   7KUlTobSaMUEUUneDZPYdJuTpn1VNpB+htcfSRNXOltsSSJcEWhRrTlqD
   B35jO4TAdC0T5qqxRIoNh/UY7OzU+f1bFI/wK8BYuxju3qVJEVIuJ338J
   Q==;
X-CSE-ConnectionGUID: npr4UZyKQ0e5NJTF79faFg==
X-CSE-MsgGUID: iBZ9GZ24RWuEK4Jq+xtujw==
X-IronPort-AV: E=Sophos;i="6.13,298,1732575600"; 
   d="scan'208";a="41945142"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 19 Feb 2025 09:18:24 +0100
X-CheckPoint: {67B593D0-46-EBA888C4-C1AC8B84}
X-MAIL-CPID: 92A129BAF551DBE314B1BFCC27C2662D_0
X-Control-Analysis: str=0001.0A00212C.67B593D1.004A,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 271F6163F68;
	Wed, 19 Feb 2025 09:18:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1739953100;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mgTv0R1ppnT7IOn1i1PAmOOJxoWXJpDOFFz9jf3JakM=;
	b=hpGWHKpTirC1rh1/mZYQCWfXGRCD1MYyOiNVsVFT5jogwup38LQ7fG51XjooOzAQOs7KqE
	J9run0GufbGmz8ZpUkrSEWtUSisnPq8gAE1GeXdA/v6Pj6zLisjaIprdpZQjazbtk4+9S3
	QAeWkLig//xKK4v1nCfaME0UoymrwCfisfL/5akF7v6n6KEF8FHxypQg0g7KmymSEa9C9d
	WL8P4qP4y+IgbltHOTj3c/ovY6DRE+K0idBkx7iCPce8QjZOOnkM810hIF0I6ErIpT8QAW
	hMHcANrXjigOMNCX/lmdH5pyV1RCJtYSRvOGRThvIEIkRR1g3ouBvZu0lpES8A==
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
	linux-kernel@vger.kernel.org
Subject: [PATCH 5/9] ARM: dts: imx6ul-tqma6ul: Order DT properties
Date: Wed, 19 Feb 2025 09:17:40 +0100
Message-ID: <20250219081748.1181507-6-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250219081748.1181507-1-alexander.stein@ew.tq-group.com>
References: <20250219081748.1181507-1-alexander.stein@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

'compatible' and 'reg' are put first.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 arch/arm/boot/dts/nxp/imx/imx6ul-tqma6ul-common.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6ul-tqma6ul-common.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ul-tqma6ul-common.dtsi
index c9c0794f01a2b..d63229d8b4655 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6ul-tqma6ul-common.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6ul-tqma6ul-common.dtsi
@@ -162,13 +162,13 @@ &qspi {
 	status = "okay";
 
 	flash0: flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0>;
 		#address-cells = <1>;
 		#size-cells = <1>;
-		compatible = "jedec,spi-nor";
 		spi-max-frequency = <33000000>;
 		spi-rx-bus-width = <4>;
 		spi-tx-bus-width = <1>;
-		reg = <0>;
 	};
 };
 
-- 
2.43.0


