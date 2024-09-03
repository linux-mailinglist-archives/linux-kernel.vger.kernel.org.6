Return-Path: <linux-kernel+bounces-312252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A09E96940C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 08:45:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 937C8B2217D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 06:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 547FF1D6193;
	Tue,  3 Sep 2024 06:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="o/mo8mPf"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1161CB527;
	Tue,  3 Sep 2024 06:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725345878; cv=none; b=jEfN41Ltj0XcaW2mpiSR+8p+wtNLkk7fJKvwmIUkWBS+TItcYszpBF5fXaFv3z0a09YfbeMEgeO2Gm6LOUlQQ53I7Gq9SLNQUri1OqTx9Nm3+CH/8iLyLXrH6tEt5CQxn13eICnYCX211RtWDqs3CVZV2bLryXp0lm20QB/9MzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725345878; c=relaxed/simple;
	bh=wzt+7xEp4j4/tSfm3TSZdLJYo6wZBtfgRWT/y1EebeY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k2AnpGGWC411ywkFbJQUwsGhtu0Ck7XD0Mad1eiHufmHs2dTA7b8ZABRs5fuHstbhbeZf4MOtHUANcEMt0nWz+n4cm3dABnpT2THFEaoUMpCMdCvwdUQnlYGAhNvrfoSj+Bb+IBSm1e4Ynsz+B9/XKQWRUUxj4btrOv3u88jfZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=o/mo8mPf; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1725345877; x=1756881877;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=wzt+7xEp4j4/tSfm3TSZdLJYo6wZBtfgRWT/y1EebeY=;
  b=o/mo8mPfiZ9F2jG/rRbeQqzXuIjlK/UTP0NODfup8lNFB+RFosjI4J3d
   qecgRTL4NloZaFh8c6wI9smjAmVOFV2A2xXYUE2XMMnlQmSymTp2S7QIH
   UuvqGSW4+zYsWzqeZD2bQQrwsZMmWMhXzhcolIMfXiTwnfci+lDEdv/Qf
   OvSJv4f3n3yKcWSp2mzUT2KdTdbgKNSmTBUneaSkSsGs3v409FVI+hcQ4
   z8Z5us20/2PcehzKrL5wsMLQgfovcI2qfUPTtqwhFFgF+L/vD2DVDaU23
   PUgfLh2hxLpymCtquHmyKmhtcuqFwGZ2SmyjZK83PsvhC63FW8xEG7ey/
   A==;
X-CSE-ConnectionGUID: SANVYYHMQUGeXr/vf0vZjg==
X-CSE-MsgGUID: 8MKGcABvSwC6rDMzsDo/tw==
X-IronPort-AV: E=Sophos;i="6.10,197,1719903600"; 
   d="scan'208";a="34305864"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Sep 2024 23:44:36 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 2 Sep 2024 23:44:34 -0700
Received: from che-lt-i67070.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 2 Sep 2024 23:44:30 -0700
From: Varshini Rajendran <varshini.rajendran@microchip.com>
To: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>, <mihai.sain@microchip.com>,
	<andrei.simion@microchip.com>, <varshini.rajendran@microchip.com>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v7 11/12] dt-bindings: arm: add sam9x75 curiosity board
Date: Tue, 3 Sep 2024 12:14:27 +0530
Message-ID: <20240903064427.49918-1-varshini.rajendran@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240903063913.48307-1-varshini.rajendran@microchip.com>
References: <20240903063913.48307-1-varshini.rajendran@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add documentation for SAM9X75 Curiosity board.

Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
Acked-by: Rob Herring <robh@kernel.org>
Reviewed-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
---
 Documentation/devicetree/bindings/arm/atmel-at91.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/atmel-at91.yaml b/Documentation/devicetree/bindings/arm/atmel-at91.yaml
index 82f37328cc69..7160ec80ac1b 100644
--- a/Documentation/devicetree/bindings/arm/atmel-at91.yaml
+++ b/Documentation/devicetree/bindings/arm/atmel-at91.yaml
@@ -106,6 +106,12 @@ properties:
           - const: microchip,sam9x60
           - const: atmel,at91sam9
 
+      - description: Microchip SAM9X7 Evaluation Boards
+        items:
+          - const: microchip,sam9x75-curiosity
+          - const: microchip,sam9x7
+          - const: atmel,at91sam9
+
       - description: Nattis v2 board with Natte v2 power board
         items:
           - const: axentia,nattis-2
-- 
2.25.1


