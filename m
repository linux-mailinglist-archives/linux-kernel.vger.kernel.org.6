Return-Path: <linux-kernel+bounces-557778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43556A5DD98
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 14:13:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D31D3BACB2
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 13:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BDF324C669;
	Wed, 12 Mar 2025 13:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VGGLrm1L"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67CE3245039;
	Wed, 12 Mar 2025 13:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741785164; cv=none; b=LTzcX2nXvXRhnNS+tvuNEOpJCrbOktzCVXtUr/A3zAVWc1rhsGMHlcDY2fzXPNz2FXJeCGAYA7aJHqvH+iIENkbts8AGBAwLqXziL4VrIU0WorX4kcdBBRh4RvT1BTMJAnJR9R22ydaGJb4PsoFuzWccZdfHBNQ4OAWrTGsKFeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741785164; c=relaxed/simple;
	bh=PBTPbAPIWX+QDh4lvcUtj+0ELhjT53JUuY94iLECXmc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j6E57Gm9MtUPtbOSSsDZHWQD5Me5YeDpwcunqbeRBQMNlkKmJ3rsL/2qwTmOFgptORVvzRlbudVvGc0AuZmWutKsV8udk1OnR6DLncDWmVRJeVCzyD/PmfiNit/o8lwOf3z1B2W6RAxNlNx7P6Nux71stk5FBc3i0APvLgxfRO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VGGLrm1L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 669B9C4CEEC;
	Wed, 12 Mar 2025 13:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741785163;
	bh=PBTPbAPIWX+QDh4lvcUtj+0ELhjT53JUuY94iLECXmc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VGGLrm1LVtWgYEaqxx8UX70HWr0vuPCF7MOVePKeIrgdk5IOqR3avCLoLIfMpFEZ1
	 mHRYnD9ndmPIZJ/8M1PLWvIje7qWHNtidpZG8eZR6+nitH2yLISB/cOONLHcQI8Tde
	 I04Z4Xq0zVeiAkcf0gxnDGQaXFqewWP+Qiq3Zwdq/aAPwSziuU7xsdVLXY3cKdqjiv
	 zYZ3c0lUbyZsj5xyY1WJbbqfyMhH481m8N75lRybM0n98MVnCa0IuieWZGwBYImT8J
	 LQzLcJJrlYqsrvPmxxJ4sf58H5W9NicDIf1S/oBCh2vu+TUkRjIxJkK8R4EUv2D808
	 eCtiLy81ArzXQ==
From: Conor Dooley <conor@kernel.org>
To: linux-riscv@lists.infradead.org
Cc: conor@kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Eric Biggers <ebiggers@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Andy Chiu <andybnac@gmail.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 4/6] dt-bindings: riscv: d requires f
Date: Wed, 12 Mar 2025 13:11:47 +0000
Message-ID: <20250312-perpetual-daunting-ad489c9a857a@spud>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250312-abide-pancreas-3576b8c44d2c@spud>
References: <20250312-abide-pancreas-3576b8c44d2c@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1242; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=dYPhJy02rU+uIlGkMnAKd9ueA9RZPFw8XUqVyW1zPdM=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDOkXO0TM12deOyg7PdYkLU7H03S15o6+6mTHW33qAZ4Ce wrKug53lLIwiHEwyIopsiTe7muRWv/HZYdzz1uYOaxMIEMYuDgFYCIpIQz/jBVzlkVc+nJ5fuh8 i6bDx3cyv/84621o5K5vbAZHF35NmMTIsCKoyyPV96HUJFHfFQoXmo5drP5gfGjJjsWan9y6XUP 5OAA=
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

Per the specifications, the d extension for double-precision floating
point operations depends on the f extension for single-precision floating
point. Add that requirement to the bindings. This differs from the
Linux implementation, where single-precious only is not supported.

Reviewed-by: Clément Léger <cleger@rivosinc.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 Documentation/devicetree/bindings/riscv/extensions.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Documentation/devicetree/bindings/riscv/extensions.yaml
index a63b994e0763..ebb252275ddd 100644
--- a/Documentation/devicetree/bindings/riscv/extensions.yaml
+++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
@@ -639,6 +639,12 @@ properties:
             https://github.com/T-head-Semi/thead-extension-spec/blob/95358cb2cca9489361c61d335e03d3134b14133f/xtheadvector.adoc.
 
     allOf:
+      - if:
+          contains:
+            const: d
+        then:
+          contains:
+            const: f
       # Zcb depends on Zca
       - if:
           contains:
-- 
2.45.2


