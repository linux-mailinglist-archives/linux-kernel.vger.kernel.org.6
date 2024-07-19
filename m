Return-Path: <linux-kernel+bounces-257268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EAA179377B2
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 14:22:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A06CB1F2260C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 12:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D122813A89A;
	Fri, 19 Jul 2024 12:22:17 +0000 (UTC)
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9C512D76F;
	Fri, 19 Jul 2024 12:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721391737; cv=none; b=GzNBWs3myR/+f1kg7nPmF6sjJcFCkfjt7dyQROM9gO7/c5zvGhCFaHgWfn3Z7bpusRPrprtGfDYgaP4PMNoCVIqrDz/At5UhNT2zkJ1FPUv4gDx3ZU0Ff6Lq2PV5Jq3kXFYjC478KaSy8/y5RnCAMeUZpQCDLdU56jjtx++l2xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721391737; c=relaxed/simple;
	bh=IXxokw4qYtSnbyMY4T9bSgXF/QqjkCxAt8uxZe28KNw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uh7dPVqTmJ50y25Zs9OUFLnzlgayjILr2DIy/NC8I3BBJevliJYvnl7X7YpQG4h+9avDBN76hs9SasV+Wv+C1c6Mbp7wRdnm2FCSyyztAcS8UkG2GN/dR/HsdkLkLr4Bv9wBRegd9gXMe+w0UzmrVi029rFAx1i5EykeL+TMfIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
From: Yixun Lan <dlan@gentoo.org>
Date: Fri, 19 Jul 2024 12:21:40 +0000
Subject: [PATCH 2/2] riscv: dts: spacemit: add pinctrl property to uart0 in
 BPI-F3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240719-02-k1-pinctrl-v1-2-239ac5b77dd6@gentoo.org>
References: <20240719-02-k1-pinctrl-v1-0-239ac5b77dd6@gentoo.org>
In-Reply-To: <20240719-02-k1-pinctrl-v1-0-239ac5b77dd6@gentoo.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Conor Dooley <conor@kernel.org>
Cc: Yangyu Chen <cyy@cyyself.name>, Jesse Taube <jesse@rivosinc.com>, 
 Jisheng Zhang <jszhang@kernel.org>, Inochi Amaoto <inochiama@outlook.com>, 
 Icenowy Zheng <uwu@icenowy.me>, Meng Zhang <zhangmeng.kevin@spacemit.com>, 
 Meng Zhang <kevin.z.m@hotmail.com>, devicetree@vger.kernel.org, 
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Yixun Lan <dlan@gentoo.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=902; i=dlan@gentoo.org;
 h=from:subject:message-id; bh=IXxokw4qYtSnbyMY4T9bSgXF/QqjkCxAt8uxZe28KNw=;
 b=owEBzQIy/ZANAwAKATGq6kdZTbvtAcsmYgBmmlpej2yFgvx2t9dDUL4fj4bTcGGRW54F661BW
 iYGaFVAryOJApMEAAEKAH0WIQS1urjJwxtxFWcCI9wxqupHWU277QUCZppaXl8UgAAAAAAuAChp
 c3N1ZXItZnByQG5vdGF0aW9ucy5vcGVucGdwLmZpZnRoaG9yc2VtYW4ubmV0QjVCQUI4QzlDMzF
 CNzExNTY3MDIyM0RDMzFBQUVBNDc1OTREQkJFRAAKCRAxqupHWU277Wc8EACTVYI3H7nEd7I878
 oMvouenk+DQntt5kSUV55ZJr1FcbatebzNuZnoXJCvJRny2dJ8F1DyOoj4jDQbNmUpicwjWXITU
 Wr4voaVOOsc5q0vq/6/nIn+uAMwXuD5J/q6ENtuvGchL8eyrgeZbwpsAWHeaNgxVnsQ2IbnrAue
 cZebSkNDdK+axEcvrlcTe0U+6SQ9oPbr2qzohH2l7o0GUSkF/JvB20Hq4XaV/SYVdWCQt2QIA/D
 V6/GVSEclM8NSRkQ2kQGz5YEqmRP+IQ2J7p0/5ZL+lZ2KZDliOMqrHGg8m1sTv66zJfitR46XVW
 /1SR00/0NlwE0Ce4EQ5mFlar/WtQaxBHt4OWU+sCyA+PGQg6KF1I5SytGUxr8Rf7S5BZA7EOyq+
 F9aKzvOQ2JxwGDcf1XviV+HHvdJ08oT9IegJpE2a9Q6QDOr6/1TsVvS/5u3VEAfQ0UO18PHoN+R
 nbVj/nOiZyydUHa2fzWyzOgannnlWkVwyrCk/BdwpzGMgYGEPfDhzDurH2HzPBUaQXvJ2/YO+hv
 8nXRfYdCTSGwgRaqaqSHIlaFtyhA8saFy9yZ9/w9P2AmLygW16jYz5HJH90z1S2y7bTL6GD3KrQ
 8z3xkISD0581I9i91lVzGebRbtRodWm7GdQfHAvZtSjUltSiG1qXXEydUfYe1vGl8+AQ==
X-Developer-Key: i=dlan@gentoo.org; a=openpgp;
 fpr=50B03A1A5CBCD33576EF8CD7920C0DBCAABEFD55

Before pinctrl driver implemented, the uart0 controller reply on
bootloader for setting correct pin mux and the configurations.

Now, let's add pinctrl property to uart0 of Bananapi-F3 board as
the pinctrl driver enabled.

Signed-off-by: Yixun Lan <dlan@gentoo.org>
---
 arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts b/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
index 023274189b492..2361269a62217 100644
--- a/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
+++ b/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
@@ -4,6 +4,7 @@
  */
 
 #include "k1.dtsi"
+#include "k1-pinctrl.dtsi"
 
 / {
 	model = "Banana Pi BPI-F3";
@@ -15,5 +16,7 @@ chosen {
 };
 
 &uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart0_2_pins>;
 	status = "okay";
 };

-- 
2.45.2


