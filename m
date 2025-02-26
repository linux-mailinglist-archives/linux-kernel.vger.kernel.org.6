Return-Path: <linux-kernel+bounces-534485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9B69A46749
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 18:02:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CE1B3A75F9
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 17:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D72DA224B12;
	Wed, 26 Feb 2025 17:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lddC6Qx1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2776722371A;
	Wed, 26 Feb 2025 17:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740589308; cv=none; b=BWOA/+EAt55/h1bztl0M8u3efnHEpsCXIdy5LPIBjaxMo3VFDmIbKA9Ef3xdTiZidKFAHYcgDectvXsnOZo5NLnpozdNoAQwwBiz06kd61nFPzQE3nywCpOnkprQXBEoIFBP9xLTeT4WFnKdNTqmweb7Lm1KiuPOeG+DtB/xYxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740589308; c=relaxed/simple;
	bh=R5tzNYvtjhOaDyxzJC0f6+X4b3pNjCCckOHTIvF9CVA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=HLNF8DxOdgTgEU5AnjQRzEdQymjIu7goo1b4917qQOnG2ZJpHy4jDAUrsOgJKydAtfTVP61kqhVWsbfzSbkvkj6CMolM67h0PnisVZsA38YpjHBWKwJYNTUdVQL2H5KiY3S6+hLlA81EZRPMInI7XF+i28pdE3buafKgF3xC1c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lddC6Qx1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 89349C4CED6;
	Wed, 26 Feb 2025 17:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740589307;
	bh=R5tzNYvtjhOaDyxzJC0f6+X4b3pNjCCckOHTIvF9CVA=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=lddC6Qx1vkIXMTeR3YILpyu/xvH3kvlmnJnELovtHG/P9DT+OpGOp6/r83cboztdY
	 Q2MQcWD26gsTDQ/E8IGcmtNfhYSbGsg4KtPh8vg5PxIN38F+9bGvmNDvOVeOxLtHph
	 E9qn+KYWNZI/TAA/71UYdJJYdhi18Y5MAo4ibPnKZDRRQnidA/gFXf1OOl/ktcUHwp
	 S8cyvl+4aAeKMQLFk0czpqvdXwr4V71nlNwGJwvP2CsylaYgE8cb9OPcv5WU0R5fXI
	 qFnJII17Yph0mBVTV27Hd43ijcGa4U4xUvSjreMZ4Mj0wQY+I5zZiH1LuuOW4RUUg4
	 AUJ+kEy9qdEqQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70F33C021B8;
	Wed, 26 Feb 2025 17:01:47 +0000 (UTC)
From: =?utf-8?q?J=2E_Neusch=C3=A4fer_via_B4_Relay?= <devnull+j.ne.posteo.net@kernel.org>
Subject: [PATCH v3 0/3] Freescale Enhanced Local Bus Controller (eLBC)
 binding YAML conversion
Date: Wed, 26 Feb 2025 18:01:39 +0100
Message-Id: <20250226-ppcyaml-elbc-v3-0-a90ed71da838@posteo.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAPNIv2cC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyjHUUlJIzE
 vPSU3UzU4B8JSMDI1MDIyMD3YKC5MrE3Bzd1JykZN2kJAtTSxPDtCSgpBJQS0FRalpmBdi46Nj
 aWgAMf7h7XgAAAA==
X-Change-ID: 20250220-ppcyaml-elbc-bb85941fb250
To: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Crystal Wood <oss@buserror.net>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 Naveen N Rao <naveen@kernel.org>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-mtd@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, 
 =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740589304; l=1815;
 i=j.ne@posteo.net; s=20240329; h=from:subject:message-id;
 bh=R5tzNYvtjhOaDyxzJC0f6+X4b3pNjCCckOHTIvF9CVA=;
 b=0qKDVcRkFGxCn+NY56CjSspN6QlXp1cLjAOYBuEWa1S1LDEyjDaRCQQz+qML97HvBVtxAhApo
 xKOFpwBpbV8AI8ySIhJklM26eF7se02o22WNERJs3oyIt8wMqvbSs2p
X-Developer-Key: i=j.ne@posteo.net; a=ed25519;
 pk=NIe0bK42wNaX/C4bi6ezm7NJK0IQE+8MKBm7igFMIS4=
X-Endpoint-Received: by B4 Relay for j.ne@posteo.net/20240329 with
 auth_id=156
X-Original-From: =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
Reply-To: j.ne@posteo.net

This series converts the fsl,elbc binding to YAML and adds new bindings
for related devices (particular kinds of chip on the eLBC).

For readability, the existing unit address syntax of <cs>,<offset>
(e.g. nand@1,0) is kept. This results in a few dtc validation warnings,
when combined with other choices in this patchset:

- For compatibility with existing kernels which don't explicitly probe
  under an eLBC controller, the "simple-bus" compatible string is kept
  on eLBC controller nodes. The validation logic requires a linear unit
  address, though (e.g. @100000000 instead of @1,0)

- The eLBC NAND flash binding (fsl,elbc-fcm-nand) references
  raw-nand-chip.yaml, which again requires a linear unit address

The patches in this series were previously part of the following series,
which turned out to be too large and unwieldy:
[PATCH v2 00/12] YAML conversion of several Freescale/PowerPC DT bindings
https://lore.kernel.org/lkml/20250207-ppcyaml-v2-0-8137b0c42526@posteo.net/

Changelogs are present in the individual patches.

Signed-off-by: J. Neuschäfer <j.ne@posteo.net>
---
J. Neuschäfer (3):
      dt-bindings: memory-controllers: Add fsl,elbc-gpcm-uio
      dt-bindings: nand: Add fsl,elbc-fcm-nand
      dt-bindings: memory-controllers: Convert fsl,elbc to YAML

 .../memory-controllers/fsl,elbc-gpcm-uio.yaml      |  59 ++++++++
 .../bindings/memory-controllers/fsl,elbc.yaml      | 158 +++++++++++++++++++++
 .../devicetree/bindings/mtd/fsl,elbc-fcm-nand.yaml |  68 +++++++++
 .../devicetree/bindings/powerpc/fsl/lbc.txt        |  43 ------
 4 files changed, 285 insertions(+), 43 deletions(-)
---
base-commit: 2014c95afecee3e76ca4a56956a936e23283f05b
change-id: 20250220-ppcyaml-elbc-bb85941fb250

Best regards,
-- 
J. Neuschäfer <j.ne@posteo.net>



