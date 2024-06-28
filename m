Return-Path: <linux-kernel+bounces-233972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 91D9691C049
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 16:05:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0CB68B2408D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 14:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CDB81BE84F;
	Fri, 28 Jun 2024 14:04:32 +0000 (UTC)
Received: from chessie.everett.org (chessie.fmt1.pfcs.com [66.220.13.234])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46FF21BF320;
	Fri, 28 Jun 2024 14:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.13.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719583471; cv=none; b=A8MB1IOx7U//xBdjPXnT8LE/z4srYwpoMb5iW1bBlmb5rfZC0iF+GCi7LwHHiACOMjfdbokj/a+nGZqvnE5doZMxsdMXQQEPAsZ7iKU5caW3q8TRn9t2tAlpGtX61vt0t4vZXnwNxQJjpC6LvweJ+wMRRGzDJqnnVQzUEgNtK4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719583471; c=relaxed/simple;
	bh=MdgNgRn8q3VbxMI6SqzSPsegSxcWvQzL7F9fijcslNs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gn5kINfvhm56OK0T6WgqdB39pQxKLDL63g62ZuWeENXHgNBUJkG1/nvlCU1dXwWIS75YMiI0vhzF0sOpW8FIT7WCbhWXOwhfci6nzzwgMyjPvjRFiyfawGo1OgoWeEcFJ04WLiiAVgD9eRjbdqN5vuIZ9E6bukzHad7nilXafds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nwtime.org; spf=pass smtp.mailfrom=nwtime.org; arc=none smtp.client-ip=66.220.13.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nwtime.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nwtime.org
Received: from localhost.localdomain (unknown [31.16.248.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by chessie.everett.org (Postfix) with ESMTPSA id 4W9ccV3YWKzMQLS;
	Fri, 28 Jun 2024 14:04:10 +0000 (UTC)
From: Erez Geva <erezgeva@nwtime.org>
To: linux-mtd@lists.infradead.org,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Pratyush Yadav <pratyush@kernel.org>,
	Michael Walle <mwalle@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	devicetree@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Erez Geva <ErezGeva2@gmail.com>
Subject: [PATCH 3/4] dt-bindings: mtd: macronix,mx25l12833f: add SPI-NOR chip
Date: Fri, 28 Jun 2024 16:03:27 +0200
Message-Id: <20240628140328.279792-4-erezgeva@nwtime.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240628140328.279792-1-erezgeva@nwtime.org>
References: <20240628140328.279792-1-erezgeva@nwtime.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Erez Geva <ErezGeva2@gmail.com>

Add Macronix SPI-NOR mx25l12833f.

Signed-off-by: Erez Geva <ErezGeva2@gmail.com>
---
 Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml b/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
index 6e3afb42926e..625a618a7992 100644
--- a/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
+++ b/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
@@ -22,7 +22,7 @@ properties:
               n25q(32b|064|128a11|128a13|256a|512a|164k)))|\
               atmel,at25df(321a|641|081a)|\
               everspin,mr25h(10|40|128|256)|\
-              (mxicy|macronix),mx25l(4005a|1606e|6405d|8005|12805d|25635e)|\
+              (mxicy|macronix),mx25l(4005a|1606e|6405d|8005|12805d|12833f|25635e)|\
               (mxicy|macronix),mx25u(4033|4035)|\
               (spansion,)?s25fl(128s|256s1|512s|008k|064k|164k)|\
               (sst|microchip),sst25vf(016b|032b|040b)|\
-- 
2.39.2


