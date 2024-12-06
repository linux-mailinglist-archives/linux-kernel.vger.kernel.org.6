Return-Path: <linux-kernel+bounces-435688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7BB09E7AE9
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 22:28:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99CC92853A9
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 21:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFD0721506F;
	Fri,  6 Dec 2024 21:26:43 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2578221481C;
	Fri,  6 Dec 2024 21:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733520403; cv=none; b=f9BKa3ajxCXIXgD6we8OSewWdkVDJvin1+qiXAaLGWCmzbtR6u1fABy8aUhkb4H8Lx27wpABjtVNfp5E8bbIczsS9GDElsNcyUwx3ow66xJY06SQHj550Rfoi6DFAUqLgnfgVy0yAXJXwj+DH9G2fo0w0kgH6UuJ3E/Zbq5JdQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733520403; c=relaxed/simple;
	bh=e1zKWvsTOn8zPt8xgy9OOiPARAixFSQ4U8ldbVQL4o0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iT8ZCyWMLU3GdD45ldSKJrn7wunYhj/ciHIkzdXvRoyTOikVuNWzeKov4cP7u07XQYsJt2Qe8iZ4oWw93fxRQPWo2WDsNkaiin1dqBFsenP52/VxotaBaau6G+9wejECBCn2PQd+XM5uRt/FukwIke+UzGRkjCcUPYc1JERCSV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: HHba4YwvR1+JZIQjKzy3qw==
X-CSE-MsgGUID: UB/whBH2Ss6z5fJomR9oaw==
X-IronPort-AV: E=Sophos;i="6.12,214,1728918000"; 
   d="scan'208";a="231123934"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 07 Dec 2024 06:26:37 +0900
Received: from ubuntu.adwin.renesas.com (unknown [10.226.92.246])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 428CE40913B2;
	Sat,  7 Dec 2024 06:26:26 +0900 (JST)
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
Subject: [PATCH 5/5] arm64: dts: renesas: r9a09g057: Add syscon compatibility to sys node
Date: Fri,  6 Dec 2024 22:25:59 +0100
Message-ID: <20241206212559.192705-6-john.madieu.xa@bp.renesas.com>
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

Add syscon compatibility to the RZ/V2H(P) system controller node to enable
it to be used as a generic system controller.

Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a09g057.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g057.dtsi b/arch/arm64/boot/dts/renesas/r9a09g057.dtsi
index 1c550b22b164..1288503ba444 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g057.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a09g057.dtsi
@@ -245,7 +245,7 @@ cpg: clock-controller@10420000 {
 		};
 
 		sys: system-controller@10430000 {
-			compatible = "renesas,r9a09g057-sys";
+			compatible = "renesas,r9a09g057-sys", "syscon";
 			reg = <0 0x10430000 0 0x10000>;
 			clocks = <&cpg CPG_CORE R9A09G057_SYS_0_PCLK>;
 			resets = <&cpg 0x30>;
-- 
2.25.1


