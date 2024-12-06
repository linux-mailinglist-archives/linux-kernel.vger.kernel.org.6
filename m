Return-Path: <linux-kernel+bounces-435685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 630059E7B06
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 22:30:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D26B188A62E
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 21:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9450212FB0;
	Fri,  6 Dec 2024 21:26:38 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2177D22C6C4;
	Fri,  6 Dec 2024 21:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733520398; cv=none; b=IFHTsiy9mocOvhCiR4Lp4gO8F5XNE7jEey8x3o/Za9ujw8xAT8eahA1HE8fnzTO228ra0TDQJtdBDicBM7PyiqVDAxajmiKZ6cuWh14PCge0cDmWzjNto2Sdqk+JMyML5yjhbzf8876YnhIZrVes2QRrtJppAGwJ8Tah4GIMmsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733520398; c=relaxed/simple;
	bh=03+iccnirrvJIf29HRzBN+74L0FywGIeM1/V0+s64BU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ACaz6pDc1lCltvfHVUPnrcy3/ZXj1Rj9i+ickCfNDvO5NTks8bYKXrGdQ6MXkY7tgUFb0wJa9t93lZK/EjySvC0/mkOPRRFw5U5+VBGfdOKKc340S10Xppz26/DW9pb5yctbXT6dJ+kCYVyjEHDGCtek8O+SOPRsTPWSv1d09nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: j91sHxr/QWONiEbjsgx0uQ==
X-CSE-MsgGUID: dsIEV3OvS7+LLHP1rNAJow==
X-IronPort-AV: E=Sophos;i="6.12,214,1728918000"; 
   d="scan'208";a="231123925"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 07 Dec 2024 06:26:29 +0900
Received: from ubuntu.adwin.renesas.com (unknown [10.226.92.246])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 3BB7E40913D0;
	Sat,  7 Dec 2024 06:26:12 +0900 (JST)
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
Subject: [PATCH 2/5] dt-bindings: soc: renesas: Document Renesas RZ/G3E SoC variants
Date: Fri,  6 Dec 2024 22:25:56 +0100
Message-ID: <20241206212559.192705-3-john.madieu.xa@bp.renesas.com>
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

Document RZ/G3E (R9A09G047) SoC variants.

Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
---
 .../devicetree/bindings/soc/renesas/renesas,r9a09g057-sys.yaml   | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/soc/renesas/renesas,r9a09g057-sys.yaml b/Documentation/devicetree/bindings/soc/renesas/renesas,r9a09g057-sys.yaml
index 8e6aa7e44857..2760e3ea85fb 100644
--- a/Documentation/devicetree/bindings/soc/renesas/renesas,r9a09g057-sys.yaml
+++ b/Documentation/devicetree/bindings/soc/renesas/renesas,r9a09g057-sys.yaml
@@ -24,6 +24,7 @@ properties:
   compatible:
     items:
       - enum:
+          - renesas,r9a09g047-sys # RZ/G3E
           - renesas,r9a09g057-sys # RZ/V2H
       - const: syscon
 
-- 
2.25.1


