Return-Path: <linux-kernel+bounces-560392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 48863A60377
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 22:36:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3430A7AC42B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 21:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B0471F5851;
	Thu, 13 Mar 2025 21:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qi8Mb83D"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C27F61F542A;
	Thu, 13 Mar 2025 21:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741901747; cv=none; b=OJRMSROu8cf4Jd4FgJV7csI+x2OtBqV0ZSiQYId5UPv2hBbZTv/5CxubKeuDkl1AmK6FEkH0cpBUHFlMBbJ72aOoWwPfaATw1DuAEaCRuqEfOagf/2V4R2qV2k5e9M0NBO5AQ8PJNDw1uaUyVnisYLLl7GEnhVvnlCF3Ucz5sMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741901747; c=relaxed/simple;
	bh=29z3wRwOCbrYFJhrHEd02uoJUqdaA1ekxWQFQrQotpk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=i0QyzTlyR1LXrYZasuqwg3KIBtqr/0zX5T+CMud7AsdCb8Av9pXb3rYxFaVDn8YYHQ3y2UyCr0oNtmXHkOevTeU0r7x93H0jeGFzg8fvxnI7rulEtCvzPwca+L2ZkDBMlGfY1QfNDz22yZrjLoOIfCWiXOVXKlapTSoK8thXr0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qi8Mb83D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4A823C4CEEA;
	Thu, 13 Mar 2025 21:35:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741901747;
	bh=29z3wRwOCbrYFJhrHEd02uoJUqdaA1ekxWQFQrQotpk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=qi8Mb83DPQcxOwpJUpOwU451pOwTebiNJrgNeBrTpA63J83AZg30QoQcIkQYSfrhv
	 46oGohIuYsvQic6z6AfrPaIDD684kHCRjF/2Q6zh/DwyWZ9nQGcDY73lFKEF1puK5C
	 rc4O09wp5+NkrwsqZ+WbZuQuF1r0OH3OXnZ2e1FhAO4R2MFrpJvx8ji9yDK8T4Qe/D
	 sUfecbB+ZCvXjKxAzOtJlbGd2ws4t3OdbrNWJNJ2/F7UKnkeHILWUU5rGL4kklMg4Y
	 t8+hERQzWu5cl1c8EiM+K4dmXYpJo/A07MJpBneXJ0rSfTr8m/ylv198gPXsR9oJ0f
	 NEOTN5yFg+buw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3075AC35FF1;
	Thu, 13 Mar 2025 21:35:47 +0000 (UTC)
From: =?utf-8?q?J=2E_Neusch=C3=A4fer_via_B4_Relay?= <devnull+j.ne.posteo.net@kernel.org>
Date: Thu, 13 Mar 2025 22:35:44 +0100
Subject: [PATCH v4 1/4] dt-bindings: mtd: raw-nand-chip: Relax node name
 pattern
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250313-ppcyaml-elbc-v4-1-55903722d9ea@posteo.net>
References: <20250313-ppcyaml-elbc-v4-0-55903722d9ea@posteo.net>
In-Reply-To: <20250313-ppcyaml-elbc-v4-0-55903722d9ea@posteo.net>
To: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Crystal Wood <oss@buserror.net>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 Naveen N Rao <naveen@kernel.org>
Cc: Frank Li <Frank.Li@nxp.com>, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-mtd@lists.infradead.org, 
 linuxppc-dev@lists.ozlabs.org, 
 =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741901745; l=1483;
 i=j.ne@posteo.net; s=20240329; h=from:subject:message-id;
 bh=yPgY1z7mg/3dcZuzAQmURU+bDX68s9E0YWQYCk73u2A=;
 b=TiGBn5/omWDqmmLaDYByMyKwn3FP8MKFA347zo4v6yuRXDARcPhBHg/qDZ7YtYAYDRNFvDA0h
 53muitjhV2cDO/0YZJ+D5+FcGeK2zPgVfVIqJHclzEtsmonRa/ttpQ9
X-Developer-Key: i=j.ne@posteo.net; a=ed25519;
 pk=NIe0bK42wNaX/C4bi6ezm7NJK0IQE+8MKBm7igFMIS4=
X-Endpoint-Received: by B4 Relay for j.ne@posteo.net/20240329 with
 auth_id=156
X-Original-From: =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
Reply-To: j.ne@posteo.net

From: "J. Neuschäfer" <j.ne@posteo.net>

In some scenarios, such as under the Freescale eLBC bus, there are raw
NAND chips with a unit address that has a comma in it (cs,offset).
For reasons of compatibility with historical device trees and
readability of the unit addresses, this format is kept.

Relax the $nodename pattern in raw-nand-chip.yaml to allow such unit
addresses. Unfortunately $nonenames defined in bindings that reference
raw-nand

Signed-off-by: J. Neuschäfer <j.ne@posteo.net>
---

V4:
- reintroduce patch to silence dtc validation error, after discussion
  with Rob Herring and Miquèl Raynal
- add some more detail to the commit message
- remove unit address format rather than extending it
  (old pattern: "^nand@[a-f0-9](,[0-9a-f]*)?$")

V3:
- remove patch after discussion with Miquèl Raynal

V2:
- new patch
---
 Documentation/devicetree/bindings/mtd/raw-nand-chip.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mtd/raw-nand-chip.yaml b/Documentation/devicetree/bindings/mtd/raw-nand-chip.yaml
index 092448d7bfc5ccd246ca4b2341464e18722a2d51..d655f6673fc31b1d9ee7cd734cbe1d310f88090b 100644
--- a/Documentation/devicetree/bindings/mtd/raw-nand-chip.yaml
+++ b/Documentation/devicetree/bindings/mtd/raw-nand-chip.yaml
@@ -25,7 +25,7 @@ description: |
 
 properties:
   $nodename:
-    pattern: "^nand@[a-f0-9]$"
+    pattern: "^nand@"
 
   reg:
     description:

-- 
2.48.0.rc1.219.gb6b6757d772



