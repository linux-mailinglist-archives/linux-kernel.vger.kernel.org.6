Return-Path: <linux-kernel+bounces-199338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 038828D85C4
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 17:08:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9CA31F22F99
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 15:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 029091304AA;
	Mon,  3 Jun 2024 15:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kJl7ltLt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44CB2B65C;
	Mon,  3 Jun 2024 15:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717427290; cv=none; b=cDPwLI9Vy9aArU+XnTBOoIF5J3aW+En8RXnU8qtxHBEJl7RyfVn27+UVMO6T34wferk1mxAq6I51gO/Z4DC3HGkn1e+pdfd8r2lW6XYm9zRvxu/Ohi9OGUcF02sblwy6JX3JHzmqvR0IV498QLMW4ZooY94Txt9Rts3vw378YYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717427290; c=relaxed/simple;
	bh=1LghNGb+MlPDCrG2ALXq6pd4e28ByNfi6yCj4rKbg7U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dP6nysLZTym2rwEaeiy5fLf3zSY6jtI9vxg8RnclN68dVSYS+FZEckdfkZ4Gc7NzC+rrHA03exvm0kqoXItLgCJR06Ewa+63Gqk2PN0VLmXFz6ExZ+38ayqi3T1UbhIOjAW/9o2WbIn1bMiArlkIZ2hFMp9Jk3ky/uUZcQJIMZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kJl7ltLt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23808C2BD10;
	Mon,  3 Jun 2024 15:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717427288;
	bh=1LghNGb+MlPDCrG2ALXq6pd4e28ByNfi6yCj4rKbg7U=;
	h=From:To:Cc:Subject:Date:From;
	b=kJl7ltLtHUBtHw+dr8yY2gqLfLNOC3nQYXX1l7bOoXEf9k7ClSc6CkObMHih0qC4L
	 7L/y0c3JEhyQoCgNuAoYKgEwTFywuKwt2e8H9Tuio7sOG+4m1RCfMQ6uJNO9ymVBYK
	 VM78MLPb0GsBmAufn6njEb6zRypuOG7KsR91/kbrZLFVgtTQxbjnO3HqjrKxM623rY
	 cNp2+kZZx/1v1+KpGDJTV7KlOBNtZgE+5/l75Mjw9u79T7+FqLSKa9HIThHP/VXS2r
	 zsSzr3mZWZzyUQc9X3uDbimh7Wk+so+ppMk8mi+HsehIXoV/J5LIH2i3TlULjwGFMf
	 JrFsewrkg7uXA==
From: matthias.bgg@kernel.org
To: kernel@esmil.dk,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: devicetree@vger.kernel.org,
	aou@eecs.berkeley.edu,
	duwe@suse.de,
	linux-kernel@vger.kernel.org,
	palmer@dabbelt.com,
	heinrich.schuchardt@canonical.com,
	paul.walmsley@sifive.com,
	linux-riscv@lists.infradead.org,
	Matthias Brugger <matthias.bgg@gmail.com>
Subject: [PATCH] riscv: dts: starfive: Update flash partition layout
Date: Mon,  3 Jun 2024 17:07:55 +0200
Message-ID: <20240603150759.9643-1-matthias.bgg@kernel.org>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Matthias Brugger <matthias.bgg@gmail.com>

Up to now, the describe flash partition layout has some gaps.
Use the whole flash chip by getting rid of the gaps.

Suggested-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>

---

 arch/riscv/boot/dts/starfive/jh7110-common.dtsi | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/riscv/boot/dts/starfive/jh7110-common.dtsi b/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
index 8ff6ea64f0489..37b4c294ffcc5 100644
--- a/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
+++ b/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
@@ -321,16 +321,13 @@ partitions {
 			#size-cells = <1>;
 
 			spl@0 {
-				reg = <0x0 0x80000>;
+				reg = <0x0 0xf0000>;
 			};
 			uboot-env@f0000 {
 				reg = <0xf0000 0x10000>;
 			};
 			uboot@100000 {
-				reg = <0x100000 0x400000>;
-			};
-			reserved-data@600000 {
-				reg = <0x600000 0xa00000>;
+				reg = <0x100000 0xf00000>;
 			};
 		};
 	};
-- 
2.45.1


