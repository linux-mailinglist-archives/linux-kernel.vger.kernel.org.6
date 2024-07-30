Return-Path: <linux-kernel+bounces-266586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D96B9940231
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 02:29:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 942D128350E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 00:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29D4E7464;
	Tue, 30 Jul 2024 00:28:59 +0000 (UTC)
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E12A04A33;
	Tue, 30 Jul 2024 00:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722299338; cv=none; b=eJs8RVNnHGw08KgTjMtU6J1kJ+ZcnO1wMUft+uz2hXJz5dVYh/glCcxhoSbZ8Amc0phCErHkiFot/8IaqmVwwVqJIpAkOnixHG7O/6GEPtaaX8DMvvbVRvjvw5oCq3TTJ6edtsB/5gM6KTBGd0wMUUcYcqTGbDlPUIHzWAhXsto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722299338; c=relaxed/simple;
	bh=3g0q4xfGD/0BPHeKW0E2urRBuyLjwe3orrVmk6S+hYM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Z6hIRMc0m5sD6yTlSmVLajIlAscFcuVca1HCvT9aJAfu1SB4Evw4+jI6DXY3BpMNRE54Bytci+DQ1MX2jpWbi0i06+W8S22RKFn24peTsfbaXk00hPRjtmZOTyJge8lCE2YUfA1v1wU/QsTTkQxRpmwlLfkQO9Esa2oPx00Gep8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
From: Yixun Lan <dlan@gentoo.org>
Date: Tue, 30 Jul 2024 00:28:04 +0000
Subject: [PATCH v5 01/10] dt-bindings: vendor-prefixes: add spacemit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240730-k1-01-basic-dt-v5-1-98263aae83be@gentoo.org>
References: <20240730-k1-01-basic-dt-v5-0-98263aae83be@gentoo.org>
In-Reply-To: <20240730-k1-01-basic-dt-v5-0-98263aae83be@gentoo.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Yangyu Chen <cyy@cyyself.name>, Yixun Lan <dlan@gentoo.org>, 
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
 Meng Zhang <kevin.z.m@hotmail.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=971; i=dlan@gentoo.org;
 h=from:subject:message-id; bh=nHwvYdywHpy9Ex1SC+u0mjF5PBlfctSYARSdCiel5hQ=;
 b=owEBzQIy/ZANAwAKATGq6kdZTbvtAcsmYgBmqDOeACQkmqNz8RccLujgUX0H3zYx9CMmaCSK5
 edxiUR0V/mJApMEAAEKAH0WIQS1urjJwxtxFWcCI9wxqupHWU277QUCZqgznl8UgAAAAAAuAChp
 c3N1ZXItZnByQG5vdGF0aW9ucy5vcGVucGdwLmZpZnRoaG9yc2VtYW4ubmV0QjVCQUI4QzlDMzF
 CNzExNTY3MDIyM0RDMzFBQUVBNDc1OTREQkJFRAAKCRAxqupHWU277QaMEACIVaYkJ/6ugxM3Mc
 IRux6DVrB8QxxjZhp8P4LIpJTDL/M9P7yAdTGl8RmHntSFrL/rEvjjGrTLsSIi19ee0WwltRXXG
 7z0O+gUJPsF5QzhTxd9h9neFjHqHVVLxcPiNdSDAZ1ibVw8z8klQ7hGq3oxstJN7bYWD9Q4z4gG
 5GwxHGpm4aA9YsXHr/GFvk/cwuJ411ndWEAzxbzSVs7mDG+v6JDSJQjbKIUldSVe732JZkL/tVS
 3LlO8J0Z/djnvAb7WDo4GWBho4hJHr0pJhHQsOKgSaA+vzfAcTyCtENLKAjrBH5+hLnwoOv7KnR
 WUf4zZV/lIWXvqlg6NTchNvxB8vYoN/PaGrGCmuJPraHdsYJAfhX3ZKuBwQApAGaI/Y6Ja70e0Y
 XbO5lwiepa3ihDwMEpHlEmvnNiOgbzzD/Pyu9/26MK8nmHWLPZDmSFBoyMAbFKDTrs3wGlJAf6X
 AK+bn2CHEeyh9b1RF+Fy6iMYMXdUFscCDg+l7/7ML1MiWpMlZ96gQ7q3joJVAUM6MB7yP7joczg
 uD/Yvsi+N1ODPFAZ8V6hrDQGf1dj1QPmYPYXsthvH0RXrVTLtCW3T6thGmcQ2pBm77gwtErS9lY
 ZvAmmw4tB5aIS3sPaK4ul+MvTLIGb2QTz15wqN1iAmVHyw6uGCLBmpKsIQO7gFcch0kA==
X-Developer-Key: i=dlan@gentoo.org; a=openpgp;
 fpr=50B03A1A5CBCD33576EF8CD7920C0DBCAABEFD55

From: Yangyu Chen <cyy@cyyself.name>

Add new vendor strings to dt bindings for SpacemiT K1 SoC.

Link: https://www.spacemit.com/en/spacemit-key-stone-2/
Signed-off-by: Yangyu Chen <cyy@cyyself.name>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Yixun Lan <dlan@gentoo.org>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index a70ce43b3dc03..30043488328b8 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1382,6 +1382,8 @@ patternProperties:
     description: Sophgo Technology Inc.
   "^sourceparts,.*":
     description: Source Parts Inc.
+  "^spacemit,.*":
+    description: SpacemiT (Hangzhou) Technology Co. Ltd
   "^spansion,.*":
     description: Spansion Inc.
   "^sparkfun,.*":

-- 
2.45.2


