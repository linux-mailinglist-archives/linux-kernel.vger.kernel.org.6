Return-Path: <linux-kernel+bounces-397177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 754F19BD7AE
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 22:32:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C45F1F22903
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 21:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09B4F215F52;
	Tue,  5 Nov 2024 21:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K6Gufr97"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65AB7383;
	Tue,  5 Nov 2024 21:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730842362; cv=none; b=Re0m1lIMvDOWVt9ed2UDVFSxDJcwQNOh7rJ7op6dxIvvoTFR0F0u+WMnGODjkPiClJtH8KQjzz3RaDAHVsE/paW7+XLckjiD23RBT07T6dWPwv2W+8Pc/Do/FLi+U1EKxVEO5JcIjj+r0KTLokOBwLC2HPAeLqWCj6mz7X+VNIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730842362; c=relaxed/simple;
	bh=2lYy4wwLf5gykFycxUeyxry6TdOV8SQOoTADXxiKdHU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FbPJ9XYxCV+Ugbi5NQS0v9RjUU4ExfXTXA2447rO9HaFg6orCBFODPJ8ZKTueMBDyApXI2i0AZKasGGL4GkcpwHskQ0XBYGko+ixZjJtrQbX+UMUiZCf9pxAzaWiWwR4A259JGVkzTP+8EXxG4idPlM3TMEbMEUEdfptI5aes6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K6Gufr97; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D04DAC4CECF;
	Tue,  5 Nov 2024 21:32:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730842362;
	bh=2lYy4wwLf5gykFycxUeyxry6TdOV8SQOoTADXxiKdHU=;
	h=From:To:Cc:Subject:Date:From;
	b=K6Gufr97r4qFfFSAgKM39+kCuELZ90YJPxV4Ml+LXRlRC7xV03c2CtUHUo+my3cGr
	 4nmlT8FEe8LzxzhNhMraWcxmlAocoi7EY14MkR7j82BsHtqRlS4daBegB3eh9CFjOo
	 fUa5CE0jFSp1r0TKk/keifgV1F4CGLPTIIn5msnwu73FEUfj9p+jX50sw4orOjp+2h
	 +y7YgPpcsICgN1eEN1Jkck5znvX/Vax4PlAcqnXzew+kMlwwdr0H45MqDVjiES7m6J
	 pOFaoKOFxn/EJxw6DpVydgHEDEKzsjoxFH+zCfZ80nT0G6q1P/5M3FAbrlOKbwpqbv
	 jgjH7l/EY9lmA==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: Enable dtc "interrupt_provider" warnings
Date: Tue,  5 Nov 2024 15:32:32 -0600
Message-ID: <20241105213232.443192-1-robh@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All the warnings from the "interrupt_provider" dtc check are fixed now,
so enable the warning for the examples.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 Documentation/devicetree/bindings/Makefile            | 1 -
 Documentation/devicetree/bindings/example-schema.yaml | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/Makefile b/Documentation/devicetree/bindings/Makefile
index bf7d64632e20..8390d6c00030 100644
--- a/Documentation/devicetree/bindings/Makefile
+++ b/Documentation/devicetree/bindings/Makefile
@@ -56,7 +56,6 @@ DT_DOCS = $(patsubst $(srctree)/%,%,$(shell $(find_all_cmd)))
 override DTC_FLAGS := \
 	-Wno-avoid_unnecessary_addr_size \
 	-Wno-graph_child_address \
-	-Wno-interrupt_provider \
 	-Wno-unique_unit_address \
 	-Wunique_unit_address_if_enabled
 
diff --git a/Documentation/devicetree/bindings/example-schema.yaml b/Documentation/devicetree/bindings/example-schema.yaml
index a41f9b9a196b..484f8babcda4 100644
--- a/Documentation/devicetree/bindings/example-schema.yaml
+++ b/Documentation/devicetree/bindings/example-schema.yaml
@@ -262,4 +262,5 @@ examples:
         reg-names = "core", "aux";
         interrupts = <10>;
         interrupt-controller;
+        #interrupt-cells = <2>;
     };
-- 
2.45.2


