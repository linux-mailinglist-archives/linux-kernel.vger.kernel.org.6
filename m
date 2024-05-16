Return-Path: <linux-kernel+bounces-181575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66F4A8C7DD3
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 22:49:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D50528287B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 20:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC9FD157E9B;
	Thu, 16 May 2024 20:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="NAoYzGbq"
Received: from mxout3.routing.net (mxout3.routing.net [134.0.28.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA49315CB;
	Thu, 16 May 2024 20:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.0.28.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715892543; cv=none; b=KD77K3r+np2IjQFT5bkrGd1bV1DLoPKqehME5s4/2fAhcggnaAumdzqPyMweQ8PAEa34IPw6CTBgtaNXJRo3mhi0ifMbkPsZ63+TF5WFuUCRrxDPvmRrRODt1BBOfZqcz1yzq6B2EV9eU79KIrHNgqZBPQAJAE3Vr3gMMGKZXkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715892543; c=relaxed/simple;
	bh=IhbzVCScejN+uy4eriSpL6mMKt93sIYcmotB80A9HVo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EJYxQ9d/Pm+pZoOi30h8ruct674oh4EO1/7ac5WwLuPhtbtm9dwVdbPEFD+1luidFr+eDTmXUoMpMJGi2MfpyZi+tXccwXaDCGxPGtd6gU5UztKOWKjnZiEamh6ZymD/Eigk5FtgudLje97s01/JhiuL2s1LeoUziUu8GU/N5Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de; spf=pass smtp.mailfrom=fw-web.de; dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b=NAoYzGbq; arc=none smtp.client-ip=134.0.28.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fw-web.de
Received: from mxbox3.masterlogin.de (unknown [192.168.10.78])
	by mxout3.routing.net (Postfix) with ESMTP id 1B73461658;
	Thu, 16 May 2024 20:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
	s=20200217; t=1715892533;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=tR8y4TTXWd6kXPaYF35icLZ9jxpPFrPwkSYPwNH+R38=;
	b=NAoYzGbq3DCCUtMwezrvwC+hOXbGmm2xTa6+LzZD9Cr16erduYCqRoJow9RzvCAN9i8vAh
	tt4uMFWSkLb5GY++LbUw8a2tX/TuLSTTDBx23nt8F8nx6ZqgmOG4BEfUF1/NkNs1OB36+O
	BJKfzE6OOY5SxPZU5wys7V8Wf/2m+vY=
Received: from frank-G5.. (fttx-pool-80.245.75.58.bambit.de [80.245.75.58])
	by mxbox3.masterlogin.de (Postfix) with ESMTPSA id 290DD36005E;
	Thu, 16 May 2024 20:48:52 +0000 (UTC)
From: Frank Wunderlich <linux@fw-web.de>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Frank Wunderlich <frank-w@public-files.de>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Daniel Golle <daniel@makrotopia.org>,
	=?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>
Subject: [PATCH] arm64: dts: mt7622: fix switch probe on bananapi-r64
Date: Thu, 16 May 2024 22:48:47 +0200
Message-Id: <20240516204847.171029-1-linux@fw-web.de>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mail-ID: 33360a91-7797-4ed3-a399-1e50c12d7bc1

From: Frank Wunderlich <frank-w@public-files.de>

After commit 868ff5f4944a
("net: dsa: mt7530-mdio: read PHY address of switch from device tree")
the mt7531 switch on Bananapi-R64 was not detected.

mt7530-mdio mdio-bus:00: reset timeout
mt7530-mdio mdio-bus:00: probe with driver mt7530-mdio failed with error -110

Fix this by adding phy address in devicetree.

Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
 arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts b/arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts
index 224bb289660c..811b227d6f50 100644
--- a/arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts
+++ b/arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts
@@ -149,9 +149,9 @@ mdio: mdio-bus {
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		switch@0 {
+		switch@1f {
 			compatible = "mediatek,mt7531";
-			reg = <0>;
+			reg = <0x1f>;
 			interrupt-controller;
 			#interrupt-cells = <1>;
 			interrupts-extended = <&pio 53 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.34.1


