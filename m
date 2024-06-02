Return-Path: <linux-kernel+bounces-198443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DE858D783F
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 23:19:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4028D28130C
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 21:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 834A978C6E;
	Sun,  2 Jun 2024 21:19:50 +0000 (UTC)
Received: from mail-m107.netease.com (mail-m107.netease.com [154.81.10.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 293B31DDEE;
	Sun,  2 Jun 2024 21:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=154.81.10.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717363190; cv=none; b=jv3BMKaZikuRmZSxYOzPimbTaPUBWSpm2MUwV0kMYBJ3fmWmEsC7TthLW0buQ8EKhgnTO6ydKv9JfNWROYSY6KVguYYw3JE7CRO0/nLMZhGsul9j/seclzGXCTkDAOERTBfERs6oHTGcIbVlxRthy8wcQcbJDDsGyckBI+KrIaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717363190; c=relaxed/simple;
	bh=yMTUzVMmWBVXoH0tox65JM0lEHQugjIej/w2nV2KW8E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lCaIrR8VHkNXeBAktSuwiiv4gDJ27Go6KQ9RyJU32+PlI8swuPPscE7ccm1ESel2h9ZGFAQ4gObuzTg2M15hQLd/jF6dSH9S0vz4LHOPJ0Znu4zdkQPqkpe8lmkQYgowbT2oH3wjcRgafIjSZB5EvyQWrgWGOzF5VS+Y0qNhhQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn; spf=pass smtp.mailfrom=jmu.edu.cn; arc=none smtp.client-ip=154.81.10.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmu.edu.cn
Received: from amadeus-Vostro-3710.lan (unknown [IPV6:240e:3b3:2c01:69f0:352b:5c48:c47b:2d45])
	by smtp.qiye.163.com (Hmail) with ESMTPA id E50F37E016A;
	Sun,  2 Jun 2024 18:40:24 +0800 (CST)
From: Chukun Pan <amadeus@jmu.edu.cn>
To: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Chukun Pan <amadeus@jmu.edu.cn>
Subject: [PATCH 1/2] dt-bindings: arm: mediatek: Add Bananapi BPI-R3 mini
Date: Sun,  2 Jun 2024 18:40:20 +0800
Message-Id: <20240602104021.387713-1-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCHUwYVk1MSEpJHkIYGU0eTVUTARMWGhIXJBQOD1
	lXWRgSC1lBWUlPSx5BSBlIQUkYS0pBTUIdS0FITkkZQU4YT0NBGE9MGUFJH09OWVdZFhoPEhUdFF
	lBWU9LSFVKTU9JSklVSktLVUpCWQY+
X-HM-Tid: 0a8fd889428d03a2kunme50f37e016a
X-HM-MType: 10
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Nwg6ESo4IjNMA0MoTw1JTx1C
	FhYwChFVSlVKTEpMSElPQ0lOTktKVTMWGhIXVRoWGh8eDgg7ERYOVR4fDlUYFUVZV1kSC1lBWUlP
	Sx5BSBlIQUkYS0pBTUIdS0FITkkZQU4YT0NBGE9MGUFJH09OWVdZCAFZQUlLTkk3Bg++

Add compatible for Bananapi BPI-R3 mini Router (Filogic 830).

Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>
---
 Documentation/devicetree/bindings/arm/mediatek.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Documentation/devicetree/bindings/arm/mediatek.yaml
index 09f9ffd3ff7b..12946e9dcd12 100644
--- a/Documentation/devicetree/bindings/arm/mediatek.yaml
+++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
@@ -91,6 +91,7 @@ properties:
           - enum:
               - acelink,ew-7886cax
               - bananapi,bpi-r3
+              - bananapi,bpi-r3-mini
               - mediatek,mt7986a-rfb
           - const: mediatek,mt7986a
       - items:
-- 
2.25.1


