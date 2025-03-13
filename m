Return-Path: <linux-kernel+bounces-560393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FD63A60376
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 22:36:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 748E319C52AD
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 21:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 824D91F5858;
	Thu, 13 Mar 2025 21:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UGMGL3X9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12C01F5428;
	Thu, 13 Mar 2025 21:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741901747; cv=none; b=IbSP/XLob/2KGosXBqtoe8NYQxiqJdRVdIw9ef/59GEqg1cz4NOvYijJzjhy+APmPBP5VX3cqfQJuqv+x+9sjty+fkSpEVayqLZavw138xl0l12yQr5bb0iDnj8zHaCxKVzNjKPkSmjRG10G0h4yPysn+TWm/jh6oe9cg6aiCRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741901747; c=relaxed/simple;
	bh=QXdqznCl6zlXKgo7A3qnzu5GYl6y2ulHGCxl1/kb/sM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Mw/wZg5SHAIchtBkOfHBXPANcpg+FzW9n1jC6z2JJOgfcJ3cKqY/peoom1e8zgAULFaCpoah71eBnXYdLUchfH6urkz2mdvT2xnizV9e+KCnqMUcEMSzBiuw2m/PhTep6Xxn3Zswp+lTUSAQN28O7UNBBdNiDtaFGodcRmntjb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UGMGL3X9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2F786C4CEDD;
	Thu, 13 Mar 2025 21:35:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741901747;
	bh=QXdqznCl6zlXKgo7A3qnzu5GYl6y2ulHGCxl1/kb/sM=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=UGMGL3X9r+/+B7Ki1dz7aIIx3BVj6/jw9e3hQejj2HY56lhR90Ei9eMd2ExJnuVl4
	 nhzlqoKVI4s14JjbEOFjHBXKkMxkXm7ztnSIM6zmtw/B/MM017gC+4IJzAvblOZBvg
	 jcPEwT1Gbo5rA9ZOdDQ2rUIE43QDYeqnt+XTQlja/Ae/LwDdtpkj8dojIZeVJLC/Xz
	 fdg5No0SHcndQ9rhJAKCS7lL72cMqE42jrWkP4rzaInu0VF8qHkcJNKl1mmdZNlfjY
	 Fu0shyD2k9+c7DxeVA4OdeTT2ds+GRTACXc1yIcWHX5XPj1WUgZ4CD8s4nCQxb7gAU
	 Hrb0QHhHUK7LQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E5D2C282DE;
	Thu, 13 Mar 2025 21:35:47 +0000 (UTC)
From: =?utf-8?q?J=2E_Neusch=C3=A4fer_via_B4_Relay?= <devnull+j.ne.posteo.net@kernel.org>
Subject: [PATCH v4 0/4] Freescale Enhanced Local Bus Controller (eLBC)
 binding YAML conversion
Date: Thu, 13 Mar 2025 22:35:43 +0100
Message-Id: <20250313-ppcyaml-elbc-v4-0-55903722d9ea@posteo.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAK9P02cC/1XMTQ7CIBCG4as0sxZDoVXqynuYLviZWpJaCBBi0
 3B3sYkLl+9MvmeHiMFihFuzQ8Bso3Vrje7UgJ7l+kRiTW1glPWUMUq815t8LQQXpYlSoh+6dlL
 1CXXiA072fXCPsfZsY3JhO/TMv9cfdPmHMieUyIGiubZGCi7u3sWE7rxigrGU8gF6bWhZqQAAA
 A==
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
Cc: Frank Li <Frank.Li@nxp.com>, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-mtd@lists.infradead.org, 
 linuxppc-dev@lists.ozlabs.org, 
 =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741901745; l=2006;
 i=j.ne@posteo.net; s=20240329; h=from:subject:message-id;
 bh=QXdqznCl6zlXKgo7A3qnzu5GYl6y2ulHGCxl1/kb/sM=;
 b=J/Kgwixg8aMdL6wWzPE1z788ocud2C9oulADJ11L1/1i6gab2H/myIHxU679xZWjMAKxfa4mZ
 mc8dKDOOrNbBF0PZBjh7Pbrdg+VriwAxg4w5LMKXlA9m2IyQfvgVzuB
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

The patches in this series were previously part of the following series,
which turned out to be too large and unwieldy:
[PATCH v2 00/12] YAML conversion of several Freescale/PowerPC DT bindings
https://lore.kernel.org/lkml/20250207-ppcyaml-v2-0-8137b0c42526@posteo.net/

Changelogs are present in the individual patches.

Signed-off-by: J. Neuschäfer <j.ne@posteo.net>
---
Changes in v4:
- Reintroduce patch "dt-bindings: mtd: raw-nand-chip: Relax node name pattern"
- Link to v3: https://lore.kernel.org/r/20250226-ppcyaml-elbc-v3-0-a90ed71da838@posteo.net

---
J. Neuschäfer (4):
      dt-bindings: mtd: raw-nand-chip: Relax node name pattern
      dt-bindings: memory-controllers: Add fsl,elbc-gpcm-uio
      dt-bindings: nand: Add fsl,elbc-fcm-nand
      dt-bindings: memory-controllers: Convert fsl,elbc to YAML

 .../memory-controllers/fsl,elbc-gpcm-uio.yaml      |  59 ++++++++
 .../bindings/memory-controllers/fsl,elbc.yaml      | 158 +++++++++++++++++++++
 .../devicetree/bindings/mtd/fsl,elbc-fcm-nand.yaml |  68 +++++++++
 .../devicetree/bindings/mtd/raw-nand-chip.yaml     |   2 +-
 .../devicetree/bindings/powerpc/fsl/lbc.txt        |  43 ------
 5 files changed, 286 insertions(+), 44 deletions(-)
---
base-commit: 2014c95afecee3e76ca4a56956a936e23283f05b
change-id: 20250220-ppcyaml-elbc-bb85941fb250

Best regards,
-- 
J. Neuschäfer <j.ne@posteo.net>



