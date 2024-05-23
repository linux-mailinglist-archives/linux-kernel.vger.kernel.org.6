Return-Path: <linux-kernel+bounces-187729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E13A38CD773
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 17:42:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03C4A1C215A0
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 15:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B34B125C9;
	Thu, 23 May 2024 15:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TmTOoMyj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F4811C92;
	Thu, 23 May 2024 15:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716478934; cv=none; b=eSO98gtgaILFvgiBm87dfxEvIZKivW/G1xxv6YW3e5rVf5mbItIt3MczAzJMPXin7Udtap0ZKnZvV4wRLOu+PV55aM916BzLVaWUXXOdL280V4rH+0T9asZ01KkMYNFZJCdzqvDJLrrIoFyhCZ6UDAYpbczefMxdjpPkH43DVyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716478934; c=relaxed/simple;
	bh=OtxukrI3lmyoMlT+l5Ie/gSVMik7bPQsqTVX7bxFcZ8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iJDDH533goVRqAk0xBIOSK0jsTc8cVhh83bFoVktvlGbrK0hjG9Jznxpk60WclvAH7C4/kJiaUSDl3FBsScC+iHM+33Co3T3sROYkjiW34nt+hpTbwfGFzvM85v1wBMB7bab9LDpGOuVsEKsVw5C2KFIlMHaXQoWU4irpP8Knvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TmTOoMyj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51E2EC32782;
	Thu, 23 May 2024 15:42:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716478934;
	bh=OtxukrI3lmyoMlT+l5Ie/gSVMik7bPQsqTVX7bxFcZ8=;
	h=From:To:Cc:Subject:Date:From;
	b=TmTOoMyjoDLo+ENuTeUkDEt6IzrGwVU7KAAkBBXE4Dz3Wx8insM0cZGNIDQc8vYDp
	 kucJWipukZvKjZYEzdEAbI968h51Q+tWTIYJo0oj+zeXvOOoO8xxIlmoxva7TAOLf0
	 N74FlMW2BbZ0xhQPpSM6zrPLB/pjzrdn+eo9ZQWweJ4endQV+ThtABs75DMy2hkF7N
	 O821UKg5s4JqhsV80bEUc2EUe3lH85csw5sfIPjDEYFT4zfD8/JyMORGV6SVlpLhrl
	 sWCZ3WXa81vne1n2zlkI1Xt456DO9J6lWr9+L58hhrWKiDLsYj/y3W+h2P1ZWdlMEq
	 CCk8frkxQIQ4Q==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Fabien Dessenne <fabien.dessenne@foss.st.com>,
	Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
Cc: devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: arm: stm32: st,mlahb: Drop spurious "reg" property from example
Date: Thu, 23 May 2024 10:42:07 -0500
Message-ID: <20240523154208.2457864-1-robh@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

"reg" is not documented nor used for st,mlahb, so drop it from the
example to fix the warning:

Documentation/devicetree/bindings/arm/stm32/st,mlahb.example.dtb: ahb@38000000: Unevaluated properties are not allowed ('reg' was unexpected)
        from schema $id: http://devicetree.org/schemas/arm/stm32/st,mlahb.yaml#

Since "reg" is dropped, the unit-address must be as well.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 Documentation/devicetree/bindings/arm/stm32/st,mlahb.yaml | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/stm32/st,mlahb.yaml b/Documentation/devicetree/bindings/arm/stm32/st,mlahb.yaml
index d2dce238ff5d..3e996346b264 100644
--- a/Documentation/devicetree/bindings/arm/stm32/st,mlahb.yaml
+++ b/Documentation/devicetree/bindings/arm/stm32/st,mlahb.yaml
@@ -54,11 +54,10 @@ unevaluatedProperties: false
 
 examples:
   - |
-    mlahb: ahb@38000000 {
+    ahb {
       compatible = "st,mlahb", "simple-bus";
       #address-cells = <1>;
       #size-cells = <1>;
-      reg = <0x10000000 0x40000>;
       ranges;
       dma-ranges = <0x00000000 0x38000000 0x10000>,
                    <0x10000000 0x10000000 0x60000>,
-- 
2.43.0


