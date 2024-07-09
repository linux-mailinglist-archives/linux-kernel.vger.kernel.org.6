Return-Path: <linux-kernel+bounces-245122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C36AA92AE99
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 05:20:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DD941F22FB2
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 03:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B020839E4;
	Tue,  9 Jul 2024 03:20:27 +0000 (UTC)
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D655B1E0;
	Tue,  9 Jul 2024 03:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720495226; cv=none; b=JgwEubybRl5kQo2t5O2W3frewulgXTrViUvwdbFsl89XpeLLu/WGnBM2aIgL7EMpVjqjblhndI1iY+TEbOXwSZOfOnvJfkEsvNyLUZyZ1OxqhiUoEviKDuXwnIrVNw/FjdoaHYaFJVhOi2XNn+6yscq6A4cS0pGMNz1xsdEmrgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720495226; c=relaxed/simple;
	bh=KaVNf+l+Sp1bJ7NI/f9O19r9vkAzuFGqmjcJN1OME2g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kkB3kViCl42cQx/bjs8cUE8N2aMam+Tmrk1bNs6QHrCmB0PDhamJq23nYiwyCOC+0hMqERRd9sCgxePGOKfXhABc1lcjVKnB1iFJ268rkOgtTaM6FyAye0hUSlyFKtrOQ9uqCh5+iWyqDqUtn/miZdBwGBsQd2qPFPsrXqAMATU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
From: Yixun Lan <dlan@gentoo.org>
Date: Tue, 09 Jul 2024 03:18:48 +0000
Subject: [PATCH v4 05/10] dt-bindings: interrupt-controller: Add SpacemiT
 K1 PLIC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240709-k1-01-basic-dt-v4-5-ae5bb5e56aaf@gentoo.org>
References: <20240709-k1-01-basic-dt-v4-0-ae5bb5e56aaf@gentoo.org>
In-Reply-To: <20240709-k1-01-basic-dt-v4-0-ae5bb5e56aaf@gentoo.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Conor Dooley <conor@kernel.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, 
 Thomas Gleixner <tglx@linutronix.de>, 
 Samuel Holland <samuel.holland@sifive.com>, 
 Anup Patel <anup@brainfault.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Lubomir Rintel <lkundrak@v3.sk>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-riscv@lists.infradead.org, linux-serial@vger.kernel.org, 
 Jesse Taube <jesse@rivosinc.com>, Jisheng Zhang <jszhang@kernel.org>, 
 Inochi Amaoto <inochiama@outlook.com>, Icenowy Zheng <uwu@icenowy.me>, 
 Meng Zhang <zhangmeng.kevin@spacemit.com>, 
 Meng Zhang <kevin.z.m@hotmail.com>, Yangyu Chen <cyy@cyyself.name>, 
 Yixun Lan <dlan@gentoo.org>, Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=991; i=dlan@gentoo.org;
 h=from:subject:message-id; bh=uv26Rjh9IKMB5x/gGwi/qL4b2tY6fy8LbhopCFjMJXU=;
 b=owEBzQIy/ZANAwAKATGq6kdZTbvtAcsmYgBmjKwstwzcUEYU8NlT2gqRSHmCNdfMUwr/ZpvA9
 tC+o5qz+z2JApMEAAEKAH0WIQS1urjJwxtxFWcCI9wxqupHWU277QUCZoysLF8UgAAAAAAuAChp
 c3N1ZXItZnByQG5vdGF0aW9ucy5vcGVucGdwLmZpZnRoaG9yc2VtYW4ubmV0QjVCQUI4QzlDMzF
 CNzExNTY3MDIyM0RDMzFBQUVBNDc1OTREQkJFRAAKCRAxqupHWU277WuDD/4vHfXbieC7cc7EMY
 0AZYSeXlIzq7OUSDl9ewqlJIR7Q5+qslh7U7IsAkEOGJu2pChIZ4aMFBwwNv84lzVU3pScwacDl
 Lm0662CZqVTZwmatcXWeu9ZEHKC03wxit7haeBTnzbJ30XOk9bWCDZHlKaW5PE8pNKycufI7HuB
 4juHWrUw+tWnwVdCOaucC8K8Icw6wgVeTqwLAqO6ZwnWPH4Yh6XmQQGbUwXdyPWII48muNoM2Qf
 L01tG243KTIug1i2s6Gxr6zUI8dPDcnvPAj8Se4ETJn5yblh6LjYM88LjK2hJMllxKcy73EKbEs
 dOkQfc4P7b5A6dn2NZJXGhpPEd5umWwVcgHyCqLJ6nHIiLJOkL02GfqNsy+J6H1rwvPpdISvg6L
 xHFCU3gc7e+maKmvpF/DHLqDw/FDl4fVUeCqp/tEoNx4mrM5umU4cz6ZDryyA6BgfyhcZH/1yFe
 5ggomIhUtYMnjRxrhM3tOJboJrqa9iwGYIeiRWhBwETJbZ4epOlbxO/2aOcb8bSs0BOs4VXRVGa
 nFwUciiPcPsGFiVSmaKxHehji220OxbccmmT4RZMbdxGrT+IPAdW6N2+uHdS2nJmV3KiXCLSbbb
 hFi+h7tlfgYbZpQcwa8VTan8ZE+011n6SH47BgN8lDznQRF0DGJbQY7ps4arjIZhAvRQ==
X-Developer-Key: i=dlan@gentoo.org; a=openpgp;
 fpr=50B03A1A5CBCD33576EF8CD7920C0DBCAABEFD55

From: Yangyu Chen <cyy@cyyself.name>

Add compatible string for SpacemiT K1 PLIC.

Signed-off-by: Yangyu Chen <cyy@cyyself.name>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Yixun Lan <dlan@gentoo.org>
---
 .../devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml      | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
index 709b2211276bd..f473ca3479efd 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
@@ -59,6 +59,7 @@ properties:
           - enum:
               - canaan,k210-plic
               - sifive,fu540-c000-plic
+              - spacemit,k1-plic
               - starfive,jh7100-plic
               - starfive,jh7110-plic
           - const: sifive,plic-1.0.0

-- 
2.45.2


