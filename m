Return-Path: <linux-kernel+bounces-200805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA0FB8FB520
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 16:23:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 177041C22FEF
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 14:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 809AE13A25D;
	Tue,  4 Jun 2024 14:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O4BjjGL1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C46721311A1;
	Tue,  4 Jun 2024 14:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717510978; cv=none; b=ptC+lLuY+UFrwvKTBPcrGDfMVjKAQoM9dxkDNMVTgiVgPbOJ+bSBkxYHQaOpcnzc8gRaCDGbg17Skj+N0Ed2TBom9VtCq6TT/SYoUX5jYMlmGDagOlJRk49LahxXrUhsrAuyXdhQPFJDndv8giqCvEN2JE2M4eGDW7znuNYO0+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717510978; c=relaxed/simple;
	bh=Rza3AQe0a3SXtORn/8/XtydHawqSRh9ZUCHPjhrTxJI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EMDGlFoqBOcrFFJHf2sz8g3Em34OXzG2eKVmr7faazQWMCQhGmGKKoo13a12RjKQdR/M2zMQ1uUZZa/IjcuB1edp/Fpim9GrgqXlkirswzrsfF59gpg/LieKJj37qfrrh8pwVUSRWDyqdZjwmeaDSvBBTwOuU2OSYm4/Kq/vJhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O4BjjGL1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE9A7C4AF08;
	Tue,  4 Jun 2024 14:22:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717510978;
	bh=Rza3AQe0a3SXtORn/8/XtydHawqSRh9ZUCHPjhrTxJI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O4BjjGL1G/gcalPFiBU93TwzEpLqHUyyQtI/rjPQJSp2+wZia1/c13dv54hfduGdX
	 TdDNiJStVtMBMcGFVMramwz6q4qIvXr3orkEIDBt3PYeu1WHXy9OT7e/zqHB0DCLtx
	 9P7tt2wm5dWjRKwH66Tkd4ELsjHP7O3cCiArtSZvCrP63tvbRVei+hHE2LAUOYmMsW
	 5F/j0aYOayvSAF6DYMXNOrIgEuHcefS5b+x+n00Jd7/89dxs3H8Se8XaSbasyJQTUy
	 eQJgOt5VdIwHKhJDoVqKPH+iFxgo5E2Aua2NPKjf+kWpriBjwW9wHx4yvIhAzyEoLT
	 v4QhcXDE1uQyQ==
From: Michael Walle <mwalle@kernel.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	Michael Walle <mwalle@kernel.org>
Subject: [RFC PATCH 2/2] dt-bindings: memory: fsl: replace maintainer
Date: Tue,  4 Jun 2024 16:22:49 +0200
Message-Id: <20240604142249.1957762-2-mwalle@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240604142249.1957762-1-mwalle@kernel.org>
References: <20240604142249.1957762-1-mwalle@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Li Yang's mail address is bouncing, replace it with Shawn Guo's one.

Signed-off-by: Michael Walle <mwalle@kernel.org>
---
This is marked as an RFC because it is more of a question for Shawn if
he is willing to take over the maintainership.
---
 .../devicetree/bindings/memory-controllers/fsl/fsl,ifc.yaml     | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/memory-controllers/fsl/fsl,ifc.yaml b/Documentation/devicetree/bindings/memory-controllers/fsl/fsl,ifc.yaml
index 3be1db30bf41..d1c3421bee10 100644
--- a/Documentation/devicetree/bindings/memory-controllers/fsl/fsl,ifc.yaml
+++ b/Documentation/devicetree/bindings/memory-controllers/fsl/fsl,ifc.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: FSL/NXP Integrated Flash Controller
 
 maintainers:
-  - Li Yang <leoyang.li@nxp.com>
+  - Shawn Guo <shawnguo@kernel.org>
 
 description: |
   NXP's integrated flash controller (IFC) is an advanced version of the
-- 
2.39.2


