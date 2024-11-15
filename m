Return-Path: <linux-kernel+bounces-411245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D5A109CF518
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 20:41:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D4841F2866E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 19:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A96CA1E2846;
	Fri, 15 Nov 2024 19:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rxa5j3sC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E0A21E2018;
	Fri, 15 Nov 2024 19:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731699512; cv=none; b=HnANQcSvsXiKcm1zAeCcrpmtatbcHtEq4OUteOM/q1yqRawcORbU8nVDSzWuWCBqnK2+CNO2C1OYu0rvtd6ycfb4lx9bFpFQjUUPyykeAKk/86iMjj21PzfWlyAvXq+9oYaCd44jffaTDqraFgHc+WMA6ulW1bJ6feRMSdCbcM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731699512; c=relaxed/simple;
	bh=OOXt1u+7Gv2rIhsndrPEWHumh1NZ4Sbz1Tzwe2ljWFM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Elsjy78OYrg8d10fJ39FSpNDsHC4BNf2/riBcOQRp9grjl6Kecir5xH/451AE+EYxj8nKuU8QttgMYa9Qltc0PIfLTtpd7uc34VKHM9k2vJRh0tokPn5RhksEMUAR/M66QRkuxUF25AaEPRKSYqlJ9heDGO3FiYpVwvRBIguXh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rxa5j3sC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63981C4CECF;
	Fri, 15 Nov 2024 19:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731699511;
	bh=OOXt1u+7Gv2rIhsndrPEWHumh1NZ4Sbz1Tzwe2ljWFM=;
	h=From:To:Cc:Subject:Date:From;
	b=Rxa5j3sCwWialkpSo0ePt61YPXynjq08Bm4Gl2hSOnmsswnSChbpm3m9rW8QEHRT7
	 EBe2ACVm5uDzyDtkp0kkBFMKqAP6vYahsxoEuVrSy6SD0obxzeABuIsfDYlt4Rp3Bg
	 XMEIeTz5+t6LBL1+yTiC2QWTPqU5ovoiQ3p4TV+QcLt5zEXzI4ewgDHD8UckXIFHg/
	 TkmyRZPDAEXXGTHTPTwpVGR7JwrNu1LJpQQCE3tnmGPfDUJDIbgwKnBc3VjgwYhlbQ
	 x30T9oY6VU9gQNbBAbUy8ir+7KNMB7SsBqCYvSzYK9H9+qduPEq8qJep2QkrlxM1Pz
	 HeZtddUdGwHDQ==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Dinh Nguyen <dinguyen@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: altera: Remove unused and undocumented "snps,max-mtu" property
Date: Fri, 15 Nov 2024 13:38:21 -0600
Message-ID: <20241115193822.3623434-1-robh@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove "snps,max-mtu" property which is both unused in the kernel and
undocumented. Most likely they are leftovers from downstream.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 arch/arm64/boot/dts/altera/socfpga_stratix10_swvp.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/altera/socfpga_stratix10_swvp.dts b/arch/arm64/boot/dts/altera/socfpga_stratix10_swvp.dts
index 0d837d3e65a5..34ccf8138f7b 100644
--- a/arch/arm64/boot/dts/altera/socfpga_stratix10_swvp.dts
+++ b/arch/arm64/boot/dts/altera/socfpga_stratix10_swvp.dts
@@ -63,7 +63,6 @@ &gmac0 {
 	status = "okay";
 	phy-mode = "rgmii";
 	phy-addr = <0xffffffff>;
-	snps,max-mtu = <0x0>;
 };
 
 &gmac1 {
-- 
2.45.2


