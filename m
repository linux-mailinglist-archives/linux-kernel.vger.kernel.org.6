Return-Path: <linux-kernel+bounces-206113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE5C4900469
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 15:15:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36491288325
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 13:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D71A196C72;
	Fri,  7 Jun 2024 13:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=diogo.ivo@siemens.com header.b="Hts1WagL"
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1410E1940AA
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 13:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717766064; cv=none; b=GDBqGJbzuC9FD/bYTsA86HFyzXM7sXMQZjKRyaVe9La2csl+iWkE5g8B81dsehy83Aa6TreOn6j1mbb1QF/3yxlBQGHhMxfOlwwiyGOOt3weaVdDwZgnOPQkGMyGfw1Df/L74UeEAY+jvbBlzsQc3Bok1Fu8N0X4sPeEKnzwsCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717766064; c=relaxed/simple;
	bh=NUfirnAzHuSC6GjuRr39bgT7xFG/QnrzxnLmvJJpzEw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ItYJeTUDceG/fJW7cZtkFzjLaDM3SxilIbm769e0cyoJPiDjrc017fdtJEbjjayIeALoQVuvCqkkd4KXLpODi8T7KHt5yC+any+1K6h8QJUNOMDHCmFlBzNoSLobKpJN0qbR29EOL0YiI3Hwt9ZrAdd7ty4hAcwOKTXWdOipwXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=diogo.ivo@siemens.com header.b=Hts1WagL; arc=none smtp.client-ip=185.136.65.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 2024060713141457bce1ce04e0f45061
        for <linux-kernel@vger.kernel.org>;
        Fri, 07 Jun 2024 15:14:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=diogo.ivo@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=Oycy2PZfe8iU4x5Oth2BIpAhAkhezYYXv0lKcaObIIg=;
 b=Hts1WagL1MoKxWIov/Ui/vCscCONTxpJxont7fwKKkWi4/LEr1IgyYETl3y4aAIffX3Dfs
 Za366X+F14Axcc8C8u0iCOgjcTzG8zvcdr7+WHpXwHLOzTCZ33lA9yN3GDPNerzTVvaCBwO1
 PFg55mpnDIsG2uoPPQ92d5kI7TSQQ=;
From: Diogo Ivo <diogo.ivo@siemens.com>
Date: Fri, 07 Jun 2024 14:02:45 +0100
Subject: [PATCH net-next v3 4/4] arm64: dts: ti: iot2050: Add IEP
 interrupts for SR1.0 devices
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240607-iep-v3-4-4824224105bc@siemens.com>
References: <20240607-iep-v3-0-4824224105bc@siemens.com>
In-Reply-To: <20240607-iep-v3-0-4824224105bc@siemens.com>
To: MD Danish Anwar <danishanwar@ti.com>, Roger Quadros <rogerq@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>, Nishanth Menon <nm@ti.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jan Kiszka <jan.kiszka@siemens.com>, 
 Jacob Keller <jacob.e.keller@intel.com>, Simon Horman <horms@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Diogo Ivo <diogo.ivo@siemens.com>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717766048; l=952;
 i=diogo.ivo@siemens.com; s=20240529; h=from:subject:message-id;
 bh=NUfirnAzHuSC6GjuRr39bgT7xFG/QnrzxnLmvJJpzEw=;
 b=JVJ6rTXzt+GHz1gD+Z/N30MZ/Qv8SCnhwWgduEiiF8LG4ZtsMShKgGLII5IOD6cKr94fXXe3Y
 uJmuByrQNPOB6tv5M516Ai3M1S9WSzouzitgYH6cNU14D0KAquJIvov
X-Developer-Key: i=diogo.ivo@siemens.com; a=ed25519;
 pk=BRGXhMh1q5KDlZ9y2B8SodFFY8FGupal+NMtJPwRpUQ=
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1320519:519-21489:flowmailer

Add the interrupts needed for PTP Hardware Clock support via IEP
in SR1.0 devices.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Diogo Ivo <diogo.ivo@siemens.com>
---
 arch/arm64/boot/dts/ti/k3-am65-iot2050-common-pg1.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am65-iot2050-common-pg1.dtsi b/arch/arm64/boot/dts/ti/k3-am65-iot2050-common-pg1.dtsi
index ef7897763ef8..0a29ed172215 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-iot2050-common-pg1.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-iot2050-common-pg1.dtsi
@@ -73,3 +73,15 @@ &icssg0_eth {
 		    "rx0", "rx1",
 		    "rxmgm0", "rxmgm1";
 };
+
+&icssg0_iep0 {
+	interrupt-parent = <&icssg0_intc>;
+	interrupts = <7 7 7>;
+	interrupt-names = "iep_cap_cmp";
+};
+
+&icssg0_iep1 {
+	interrupt-parent = <&icssg0_intc>;
+	interrupts = <56 8 8>;
+	interrupt-names = "iep_cap_cmp";
+};

-- 
2.45.2


