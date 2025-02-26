Return-Path: <linux-kernel+bounces-535019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 081CAA46DE0
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 22:48:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B23F2188A82A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 21:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3A7C25EF9A;
	Wed, 26 Feb 2025 21:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z3SWNmOj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D40125E45E;
	Wed, 26 Feb 2025 21:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740606490; cv=none; b=frqvVYlwd3Ug1cxx6SQTw10sDqkuv+JdvTssbJ/aovg0DNvvl9n33rR8UN0S5UosIJUADkZ6Gew2EBqbxVpsr1kPQPcl3KXlEQwdRyjGc77KaL5CDail7xqlozSmEtHilhv3nZmmJ04u3Z8NVKRAYJrOOdC0fjR8pooN9Sg8QcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740606490; c=relaxed/simple;
	bh=82kYuqeQF4R2/TZndohz5T6rtlxiysXvknNQ+xYTXkY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fwoUpCf22HY4EaVuN2I3zRJJizAhkMMntxhHIi/Opd36MLBsayD8E1rjjZC0qTThjZL2sq3Q3SR1DXA5efqU2/Nq9uwRxJ6m2SqvkR9D+bueNn4ONpgaoEwiSy7ntfK+0bUEog+N6fxaFUc0+2FjondaJmQCj9JrqJJw6u1jn74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z3SWNmOj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97680C4CED6;
	Wed, 26 Feb 2025 21:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740606489;
	bh=82kYuqeQF4R2/TZndohz5T6rtlxiysXvknNQ+xYTXkY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z3SWNmOjgQVTaZPw6vTmYYxHVNe7pMDk/O97umAWUKJAPVFc1+PqXsd8Viy7ALmUw
	 PU+9RkHbwcIk5zp5qed9myqLGNLU2XQMFLqbx3UMYEfKdi34Gnb8SsmcnMCWu2pETb
	 D0D9e5At8Vak/FQLgYWBEV27rKBQmzUJUnLrKrHK+JNvEmhd8I7xrDRpqdMLwSStAM
	 YKhLrnOTPRYyTBqPyXY5KEnaQRjYBQJgREepppBtVpYpQhMpsPXX3D3s9P+HmQPLL0
	 /GO7TWp9bXenhz+uv/vaZXfOh4WIRIrJRzH3GnecnE2pOote5wFoPR+XRw9/ogx4am
	 R5+L87bnGIoJA==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@bootlin.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] arm64: dts: marvell: Drop unused CP11X_TYPE define
Date: Wed, 26 Feb 2025 15:47:48 -0600
Message-ID: <20250226214751.3751865-2-robh@kernel.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250226214751.3751865-1-robh@kernel.org>
References: <20250226214751.3751865-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The CP11X_TYPE define is not used anywhere, remove it.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 arch/arm64/boot/dts/marvell/armada-cp110.dtsi | 4 ----
 arch/arm64/boot/dts/marvell/armada-cp115.dtsi | 4 ----
 2 files changed, 8 deletions(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-cp110.dtsi b/arch/arm64/boot/dts/marvell/armada-cp110.dtsi
index 4fd33b0fa56e..e3cfd168becc 100644
--- a/arch/arm64/boot/dts/marvell/armada-cp110.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-cp110.dtsi
@@ -5,8 +5,4 @@
  * Device Tree file for Marvell Armada CP110.
  */
 
-#define CP11X_TYPE cp110
-
 #include "armada-cp11x.dtsi"
-
-#undef CP11X_TYPE
diff --git a/arch/arm64/boot/dts/marvell/armada-cp115.dtsi b/arch/arm64/boot/dts/marvell/armada-cp115.dtsi
index 1d0a9653e681..ec6432c8db7c 100644
--- a/arch/arm64/boot/dts/marvell/armada-cp115.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-cp115.dtsi
@@ -5,8 +5,4 @@
  * Device Tree file for Marvell Armada CP115.
  */
 
-#define CP11X_TYPE cp115
-
 #include "armada-cp11x.dtsi"
-
-#undef CP11X_TYPE
-- 
2.47.2


