Return-Path: <linux-kernel+bounces-408414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 596029C7E7A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 23:56:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28C221F21B61
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 22:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 805DE18C33C;
	Wed, 13 Nov 2024 22:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jZ2MD6ZO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D294418C01B;
	Wed, 13 Nov 2024 22:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731538599; cv=none; b=K0oAyBzn9mZ3pu1eK32qno1txxeUF7rMzC5s837DyRAcMQb+Wz9NnM9IHHZdJcR8wjpUyQqb+Y6Bod+onZFJHuNqzFpKFUpOPFWOcFLDq/krsN2OomoFQ418ANZtV0h0tyE6HtvSvzJEdOVS0zcGlG/kkwrppV7T3LUiRxOrsCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731538599; c=relaxed/simple;
	bh=04iCwCCCRuAs3errPNW10EDAYykPH5V9SmAAGv4dzm0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rf56KpCy0Y5WLXBwcU3LsHbz3OKCbLtC4pI549BApfHr7cF519XDA5YUIYmkXarhlAXLnCNjEnYrnDs1ijJXbwLARb7VszI78SUQe+/2hlpwdILePiYnFDDigUDOMIv4DUnpJTF2VO3IfH4G7zAaI04TrgPNXm7x8U76Q7yU0Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jZ2MD6ZO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35280C4CEC3;
	Wed, 13 Nov 2024 22:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731538599;
	bh=04iCwCCCRuAs3errPNW10EDAYykPH5V9SmAAGv4dzm0=;
	h=From:To:Cc:Subject:Date:From;
	b=jZ2MD6ZO/vmL+VFDrhvd4vyST4HgnoTGRiiy1tOioOemCoegTA40wYQ1Wgz4dLcLu
	 YcibPkKH/lu4iLG2UpeIzpVIFS81pT8q+z/50Gun/FRuZIBr8a5DpCX4KAiRUqCqKy
	 NzC8oh+ShLgkdwsr2/ByoqzTaEaQ4XkrboWJj40PVifgCDPwsjM6oY5ZMwsMDSK+4E
	 Y80HJoE2UabumFf4/E6jqqvfu9ENCYvA6BPO2ThWTHvDUf4LM4oOdEXASzfoMewSPj
	 HfoAL9HyBYpxcSJbh+S2iLSUizxOYfpBcC22gjfbeMSYRpBe71rO6vGkf5i2USar1z
	 ros8Y0eb+3SLw==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Cc: linux-mtd@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: mtd: fixed-partitions: Fix "compression" typo
Date: Wed, 13 Nov 2024 16:56:31 -0600
Message-ID: <20241113225632.1783241-1-robh@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The example erroneously has "compress" property rather than the
documented "compression" property.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../devicetree/bindings/mtd/partitions/fixed-partitions.yaml    | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mtd/partitions/fixed-partitions.yaml b/Documentation/devicetree/bindings/mtd/partitions/fixed-partitions.yaml
index 058253d6d889..62086366837c 100644
--- a/Documentation/devicetree/bindings/mtd/partitions/fixed-partitions.yaml
+++ b/Documentation/devicetree/bindings/mtd/partitions/fixed-partitions.yaml
@@ -82,7 +82,7 @@ examples:
 
         uimage@100000 {
             reg = <0x0100000 0x200000>;
-            compress = "lzma";
+            compression = "lzma";
         };
     };
 
-- 
2.45.2


