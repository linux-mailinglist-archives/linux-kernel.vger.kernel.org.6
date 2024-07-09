Return-Path: <linux-kernel+bounces-245121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 721AC92AE96
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 05:20:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A27A11C21CA4
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 03:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 821177D07F;
	Tue,  9 Jul 2024 03:20:17 +0000 (UTC)
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E31A477114;
	Tue,  9 Jul 2024 03:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720495217; cv=none; b=jvgui29kIg0C/QOLQjmvY5bobzgNpjL1XvJHby1QJmuYOXbij8v8c8frCLT11nSm1nlkgTRyxkJgQNe1cPruf/6A1Gx5r9IOCCHCFmh2H37HjQbYhQnj5oNVY6x98g1XU7yBF1To/9ruhCF324Es9QZR0N14owWWaGU9fC47gXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720495217; c=relaxed/simple;
	bh=VvnzgRDmEIAsq9Hf5Ry7MLnNkPx6PUf9JkUVFX7jVz0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UrC0l9yUShezYozFASrVKM4TXuyBqiTp0ZPJpi/g9VbsVTuWhBZDasdkT/4LNiW9NoDlBgwLec0bWMFi/uemLAeww9P1cRO9E7lhQ6jpmgO6VmVQRH7mnDUd+EgNnS8h/L8FDjMRzN1VZ4DboewZOsyjVuRRgXoMOvB4bOruwqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
From: Yixun Lan <dlan@gentoo.org>
Date: Tue, 09 Jul 2024 03:18:47 +0000
Subject: [PATCH v4 04/10] dt-bindings: timer: Add SpacemiT K1 CLINT
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240709-k1-01-basic-dt-v4-4-ae5bb5e56aaf@gentoo.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1027; i=dlan@gentoo.org;
 h=from:subject:message-id; bh=wvQLp2j2KF1DXU6LoDgHk1K3AJ3TNpJmOxUxNu563OM=;
 b=owEBzQIy/ZANAwAKATGq6kdZTbvtAcsmYgBmjKwoJ9JhYzGBCEuNvHOCsyEcGGruZO/c7JUBo
 8TRFLqj+5KJApMEAAEKAH0WIQS1urjJwxtxFWcCI9wxqupHWU277QUCZoysKF8UgAAAAAAuAChp
 c3N1ZXItZnByQG5vdGF0aW9ucy5vcGVucGdwLmZpZnRoaG9yc2VtYW4ubmV0QjVCQUI4QzlDMzF
 CNzExNTY3MDIyM0RDMzFBQUVBNDc1OTREQkJFRAAKCRAxqupHWU277SMBEACGqhJUmsrYkAtBv0
 gYxjSG3KtPXmPY4v83ANmFloGZJ0iT0IW3hhUyHrDPx0oYSObj2h2Qlm34FQ+99wpJnk//0RKDm
 M9tvDl9GyGo3BZI053SZ3KybNR9i7u66BHzgcSyD9R/UhA/AlWDboX/3UFRN+lqM6JBi+daeE17
 grXdqWMwPBFoeUSyejWIAj0eVEaLkvEd0ky/DzTf0lgVRoLux8C3VZzbnyBxZ+5JSjRUqcL+BAc
 b7Pf55QqX5PxtVWKw2amqq76l4+SSFrgrmGqYLaNkbXYlRvIrj9ZT+Lw3A74U+ll/GKr1oYBcel
 6qyf5J64gBJLF7wvq3lcla1i1S4whxgcH7+yRotn2gQyCGrcW+okpsKW7u43NswAulNcYF2gyrn
 kblw2h5c/eES7jR3zr3oQkIPiuqWjZmvHkYsyzYVLmukG3U2NI9xguIJ5hwLJoZk/uMR9vXcXxL
 SrwHsN6vWGq00Gfqz8JPogQcrsP7+tJz509Rtwztd9BNJjCZ2mzfbOLh1XjGQNEEMTJJxEzLiS8
 AMfRWvwfqgmnq8yJKFekiLHvVI2gPdsQeY3X530x155ppHxtYzjxb+To6v68EsrNsRWxSNNAxAJ
 ujU9ON1vKwRuG51nx29Z/qc9g7VqE1i7oj4p1mYjG3EZ+3wt1fA5dkAysSfnLZBG1zmw==
X-Developer-Key: i=dlan@gentoo.org; a=openpgp;
 fpr=50B03A1A5CBCD33576EF8CD7920C0DBCAABEFD55

From: Yangyu Chen <cyy@cyyself.name>

Add compatible string for SpacemiT K1 CLINT.

Signed-off-by: Yangyu Chen <cyy@cyyself.name>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Yixun Lan <dlan@gentoo.org>
---
 Documentation/devicetree/bindings/timer/sifive,clint.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/timer/sifive,clint.yaml b/Documentation/devicetree/bindings/timer/sifive,clint.yaml
index fced6f2d8ecbb..c2e68587a806a 100644
--- a/Documentation/devicetree/bindings/timer/sifive,clint.yaml
+++ b/Documentation/devicetree/bindings/timer/sifive,clint.yaml
@@ -31,6 +31,7 @@ properties:
           - enum:
               - canaan,k210-clint       # Canaan Kendryte K210
               - sifive,fu540-c000-clint # SiFive FU540
+              - spacemit,k1-clint       # SpacemiT K1
               - starfive,jh7100-clint   # StarFive JH7100
               - starfive,jh7110-clint   # StarFive JH7110
               - starfive,jh8100-clint   # StarFive JH8100

-- 
2.45.2


