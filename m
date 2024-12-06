Return-Path: <linux-kernel+bounces-435686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 329B79E7AE6
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 22:27:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E85B82816B2
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 21:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F68922C6DB;
	Fri,  6 Dec 2024 21:26:41 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0991212FAD;
	Fri,  6 Dec 2024 21:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733520400; cv=none; b=ILRftlL89BKc/jqHeAAZSH1g3GtTU/n5H3NIwalpjcLNA4Bc4f829d8+Qf93d33yOjFNcAPHt7N85F5biMA1+tCoC5KommJkyW95JtSoU2gq/Nf/ypLC2SjFb9He0x31VTEiXcWjyhYQXnVPgemmZQY/08rPrKRh2ghjyNUIDfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733520400; c=relaxed/simple;
	bh=If+hxuV/AC2sQyiCuwMmjI2ympNCxf/g/6BhqtJ5KDk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FpeIzDYGJ8HZiOt6jehKsxwip5wAvIjNgTdzBeVgSdHo96/9Yk1T9vonsxX8ooWi3TC3i1THMnSWXkUVYFx28z3sjRpZAXLQmHnCzV0q9xcQBWIZ2rqAQyWs3+KNaB8pAchodSNmEG9jQubweOemClyx/qhny/yimYsl+eLKIGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: nSwXJUaxTCeUlwfzK7pU8A==
X-CSE-MsgGUID: 0AcsKAiFSce/nfHeTTeicA==
X-IronPort-AV: E=Sophos;i="6.12,214,1728918000"; 
   d="scan'208";a="231123931"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 07 Dec 2024 06:26:34 +0900
Received: from ubuntu.adwin.renesas.com (unknown [10.226.92.246])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 7353F40913A6;
	Sat,  7 Dec 2024 06:26:22 +0900 (JST)
From: John Madieu <john.madieu.xa@bp.renesas.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Cc: john.madieu@gmail.com,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	John Madieu <john.madieu.xa@bp.renesas.com>
Subject: [PATCH 4/5] arm64: dts: renesas: r9a09g047: add sys node
Date: Fri,  6 Dec 2024 22:25:58 +0100
Message-ID: <20241206212559.192705-5-john.madieu.xa@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241206212559.192705-1-john.madieu.xa@bp.renesas.com>
References: <20241206212559.192705-1-john.madieu.xa@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add system controller node to RZ/G3E (R9A09G047) SoC DTSI.

Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a09g047.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g047.dtsi b/arch/arm64/boot/dts/renesas/r9a09g047.dtsi
index 17bc95fb111f..5f65e652a413 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g047.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a09g047.dtsi
@@ -154,6 +154,13 @@ cpg: clock-controller@10420000 {
 			#power-domain-cells = <0>;
 		};
 
+		sys: system-controller@10430000 {
+			compatible = "renesas,r9a09g047-sys", "syscon";
+			reg = <0 0x10430000 0 0x10000>;
+			clocks = <&cpg CPG_CORE R9A09G047_SYS_0_PCLK>;
+			resets = <&cpg 0x30>;
+		};
+
 		scif0: serial@11c01400 {
 			compatible = "renesas,scif-r9a09g047", "renesas,scif-r9a09g057";
 			reg = <0 0x11c01400 0 0x400>;
-- 
2.25.1


