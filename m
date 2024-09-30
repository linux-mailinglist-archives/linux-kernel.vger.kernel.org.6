Return-Path: <linux-kernel+bounces-343729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B61A9989ED2
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 11:56:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8E861C21CF5
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 09:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C209018C35C;
	Mon, 30 Sep 2024 09:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="VAlrO/dT"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9DD618A924;
	Mon, 30 Sep 2024 09:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727690135; cv=none; b=uT1vhch7N5s093PP7XbGrlaC2QXZbseJGtCtg7uo7tRHKuEpnsEXjZRUAsGZOXYNEt9spcXQj10CMqKlPI6CpsslHTl2s9u19cdA9WcMzTNomZJy7ZHfROOcNtpqS7q1aB1q4bSAEAyJFmtSk0stDFU2Do+6JFX/tvTJ1AFa6c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727690135; c=relaxed/simple;
	bh=d6Utj+JguD6h5aoqdJ+L9X7NxnZGnIVxFRe79x6iqbc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DWCLXpNwREvPm3JCLSodxPM7zLr1zz1lb2JH9iP+nTHjfOXrF3i0WGsZ3K4iPKpdzEddQ2BwH6fZBKi8859D1JS/RK5iXbUy/YM62RGAAzaf/bk5/c8fogu3xPx4z4TFItfZar+DC8smWEBBfMWVNjZnh9pTVdgfItPBVzrod00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=VAlrO/dT; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1727690133; x=1759226133;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=d6Utj+JguD6h5aoqdJ+L9X7NxnZGnIVxFRe79x6iqbc=;
  b=VAlrO/dTKpm93yzm//hc4s/oPtZoheBzOTNowtM700lmKLMSFHX1cCBK
   mUPVjko9fMErLIXgPJTNLin/el0UuWyJa78u8SN/AM2IrGJv4edjifsFi
   UwBsyZ6/UG6c6+uhIc3OGf5crXZYPmioVdGHZB9M+Uv88JXbdkPSJ36DE
   +XnSoXHqK2qr2KR+Mngc4U+3nNHYTBtdoehuC8iPqfbOmGsBw+wvHW4Cd
   afBxlFSeUV7vumN71O1TURi/3bh9E+AxV+sZ3jNcHbfJ3eNPKg7woHiu5
   7DT3bn92xk1Xb11Wh+ceKKy3syXIMn4ybNxI0b50X4IbHXuTJ7iU8zG7J
   w==;
X-CSE-ConnectionGUID: XiGZNwQLQnOpHGCFR5gKFQ==
X-CSE-MsgGUID: 9AoJVu+JS8e8q4pSHU4uWg==
X-IronPort-AV: E=Sophos;i="6.11,165,1725346800"; 
   d="scan'208";a="32248830"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Sep 2024 02:55:23 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 30 Sep 2024 02:55:13 -0700
Received: from ph-emdalo.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 30 Sep 2024 02:55:11 -0700
From: <pierre-henry.moussay@microchip.com>
To: <Linux4Microchip@microchip.com>, Conor Dooley <conor@kernel.org>, "Rob
 Herring" <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, "Paul
 Walmsley" <paul.walmsley@sifive.com>, Samuel Holland
	<samuel.holland@sifive.com>
CC: Pierre-Henry Moussay <pierre-henry.moussay@microchip.com>,
	<devicetree@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
Subject: [linux][PATCH v2 06/20] dt-bindings: cache: sifive,ccache0: add a PIC64GX compatible
Date: Mon, 30 Sep 2024 10:54:35 +0100
Message-ID: <20240930095449.1813195-7-pierre-henry.moussay@microchip.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240930095449.1813195-1-pierre-henry.moussay@microchip.com>
References: <20240930095449.1813195-1-pierre-henry.moussay@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Pierre-Henry Moussay <pierre-henry.moussay@microchip.com>

The PIC64GX use the same IP than MPFS, therefore add compatibility with
MPFS as fallback

Signed-off-by: Pierre-Henry Moussay <pierre-henry.moussay@microchip.com>
---
 Documentation/devicetree/bindings/cache/sifive,ccache0.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/cache/sifive,ccache0.yaml b/Documentation/devicetree/bindings/cache/sifive,ccache0.yaml
index 7e8cebe21584..9d064feb2ab1 100644
--- a/Documentation/devicetree/bindings/cache/sifive,ccache0.yaml
+++ b/Documentation/devicetree/bindings/cache/sifive,ccache0.yaml
@@ -47,6 +47,11 @@ properties:
           - const: microchip,mpfs-ccache
           - const: sifive,fu540-c000-ccache
           - const: cache
+      - items:
+          - const: microchip,pic64gx-ccache
+          - const: microchip,mpfs-ccache
+          - const: sifive,fu540-c000-ccache
+          - const: cache
 
   cache-block-size:
     const: 64
@@ -93,6 +98,7 @@ allOf:
               - starfive,jh7100-ccache
               - starfive,jh7110-ccache
               - microchip,mpfs-ccache
+              - microchip,pic64gx-ccache
 
     then:
       properties:
-- 
2.30.2


