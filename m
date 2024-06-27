Return-Path: <linux-kernel+bounces-232597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 648F191AB63
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 17:34:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D4F51F25577
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 15:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9DD5199E89;
	Thu, 27 Jun 2024 15:33:08 +0000 (UTC)
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31DB91990C8;
	Thu, 27 Jun 2024 15:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719502388; cv=none; b=AmjYURdAqRt1yl61CEFzzTW07oXr1iNsYVwY3Lq1aeQj1ifwkaCG4rqEv6oqhn4Iq+S5jzQOF1wVERifQOXE/dLUP7XPc3JDNWbtatJ3eG0/g527F8XD0Oj+PqpJOwzN+tvw/E7lwrk7BaiZ4LqpVEf7M5u8KXlYWmkqXJxEJbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719502388; c=relaxed/simple;
	bh=PY2po3Bj1ntABWK9fjq/vZkGFvJuu4tsugdfHT2EW8c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ERHotu1Yo8tdLem2g7xnvBAll55OLlIGhXaseAGXMW5caLLLCS46jPz7I6MN5VpiSORml4mYbe8y+MpBXROii3bUfmLPZ1tOSGYsJvODDhNFa1vqI/M+YuNHymrkJYPr+lnIaehq2a3b7km6vg4TTfc74x6BBRCo/kWgRBWnVnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
From: Yixun Lan <dlan@gentoo.org>
Date: Thu, 27 Jun 2024 15:31:20 +0000
Subject: [PATCH v2 06/10] dt-bindings: serial: 8250: Add SpacemiT K1 uart
 compatible
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240627-k1-01-basic-dt-v2-6-cc06c7555f07@gentoo.org>
References: <20240627-k1-01-basic-dt-v2-0-cc06c7555f07@gentoo.org>
In-Reply-To: <20240627-k1-01-basic-dt-v2-0-cc06c7555f07@gentoo.org>
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
 Palmer Dabbelt <palmer@sifive.com>, linux-riscv@lists.infradead.org, 
 linux-serial@vger.kernel.org, Inochi Amaoto <inochiama@outlook.com>, 
 Meng Zhang <zhangmeng.kevin@spacemit.com>, Yangyu Chen <cyy@cyyself.name>, 
 Yixun Lan <dlan@gentoo.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=912; i=dlan@gentoo.org;
 h=from:subject:message-id; bh=PY2po3Bj1ntABWK9fjq/vZkGFvJuu4tsugdfHT2EW8c=;
 b=owEBzQIy/ZANAwAKATGq6kdZTbvtAcsmYgBmfYXw/GQEZbe7eW7M8+DhxCJ+QctBkEXA5bFaA
 iwAqjq4eJeJApMEAAEKAH0WIQS1urjJwxtxFWcCI9wxqupHWU277QUCZn2F8F8UgAAAAAAuAChp
 c3N1ZXItZnByQG5vdGF0aW9ucy5vcGVucGdwLmZpZnRoaG9yc2VtYW4ubmV0QjVCQUI4QzlDMzF
 CNzExNTY3MDIyM0RDMzFBQUVBNDc1OTREQkJFRAAKCRAxqupHWU277WgPD/4+Xbup6V8OAAoD4k
 qsXY9JGINTyKvqveMpMIKBwYjhSI2xFLL6fQ5o/Qd5uVBa6NuyZnHSwXUqnKeVWnSa7nQ9AL6Li
 RRpZdXw9951HgEpzQwu93CUMha05DHboE+tgPOTKWiJZQ7w4sSUpX+X1Xm+uBupzejqXiARkMRM
 HPm00GsJtlXHPHIBdMNucOq6Vojshvt+bGldVGmncB6yjwMqIYmraJYAdhSSFxK2nWo1s2mW5aj
 v0V8UdidueFQM32jH8Eq0J/zfJ/hj7Cv3Shgrmw/xfA8C4MqD9H1PiT4i/kdQTKtF99cPTrN4QV
 pCcGKhKu58alylHYsf+4yw7vyfExK7TkhhuCylLOp2rRl73UM20OVokfG8EYUJLujBK4bs+xJUo
 QkoaPnBoK/pKp9J7i9VAzKGsaMSjZgkAYcS03exdLpbebNTykf8jTX3UuaaS/EthFTTSk+qhnJh
 eSU8relM4j7kbYb4fJSEY8kOyWUX4YxaYGc0RK0BP2F9BMvXxLyyviFzGrANrZg6TUI7rTph5lX
 p0WrOM2L0ptY3TS30TacRg8I2uwm0/U9dzheSh8V5Cf9wBFUsCcYX1NvmmtMjq31Rp3EYHea27Q
 ST3galSSdgOcT53TaAQTJDMQQ7sdXZUCT4Pj5+fAodawZig2K3sGNIm+npRfoDmSKVTQ==
X-Developer-Key: i=dlan@gentoo.org; a=openpgp;
 fpr=50B03A1A5CBCD33576EF8CD7920C0DBCAABEFD55

Found SpacemiT's K1 uart controller is compatible with
Intel's Xscale uart, but it's still worth to introduce a new compatible.

Signed-off-by: Yixun Lan <dlan@gentoo.org>
---
 Documentation/devicetree/bindings/serial/8250.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/serial/8250.yaml b/Documentation/devicetree/bindings/serial/8250.yaml
index 692aa05500fd5..0bde2379e8647 100644
--- a/Documentation/devicetree/bindings/serial/8250.yaml
+++ b/Documentation/devicetree/bindings/serial/8250.yaml
@@ -111,7 +111,9 @@ properties:
               - mediatek,mt7623-btif
           - const: mediatek,mtk-btif
       - items:
-          - const: mrvl,mmp-uart
+          - enum:
+              - mrvl,mmp-uart
+              - spacemit,k1-uart
           - const: intel,xscale-uart
       - items:
           - enum:

-- 
2.45.2


