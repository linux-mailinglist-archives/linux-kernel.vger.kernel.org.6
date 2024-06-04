Return-Path: <linux-kernel+bounces-200062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55A698FA9FD
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 07:30:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B295DB228ED
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 05:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C5B913DB9F;
	Tue,  4 Jun 2024 05:29:54 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A3DA13D517;
	Tue,  4 Jun 2024 05:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717478994; cv=none; b=afk3E4GboyXmNJ1DdZ+CGX21HMWxXUjtLISg7SOOqsrqVKRYyczEYrDOMFZAG/Wv9QLaq/+0DX7VrEdnKYJmjopeyDBNVDbVO3TfrXZCG972UhhO7lEFQ/eJ8YbUQiDpmTvpKnnThAgN91nl5F+otbs5N7IvUbYZUmmAdMWqyIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717478994; c=relaxed/simple;
	bh=8id9w4ITeGKoMSzcnkdj/XODTSZ3CBhBl9FFEYzRhqc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SFC56IHws/hySRPDvuyo4LcxMnnKSwt89pEC2Q3GwxCXxNdytbvjq4GecHLH7VofLCOaji+OLpWXdxuvzNZSDLH1AXMzqnK9ibCfMDcIiqrJe2YFI3EMrmbmu5nxVhuJ2p5juJNgaDOO1dnD7XJ4AK0y+vCBDKlFnFnBpRfD3Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F091C1042;
	Mon,  3 Jun 2024 22:30:14 -0700 (PDT)
Received: from e116581.blr.arm.com (e116581.arm.com [10.162.41.24])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3AE113F762;
	Mon,  3 Jun 2024 22:29:45 -0700 (PDT)
From: Dev Jain <dev.jain@arm.com>
To: linux-arm-kernel@lists.infradead.org,
	catalin.marinas@arm.com,
	will@kernel.org,
	corbet@lwn.net,
	linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	mark.rutland@arm.com,
	suzuki.poulose@arm.com,
	broonie@kernel.org,
	ryan.roberts@arm.com,
	James.Morse@arm.com,
	Anshuman.Khandual@arm.com,
	Dev Jain <dev.jain@arm.com>
Subject: [PATCH] Documentation: Add ARM64 for reserving ZONE_MOVABLE
Date: Tue,  4 Jun 2024 10:58:56 +0530
Message-Id: <20240604052856.546183-1-dev.jain@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kernelcore and movablecore kernel command line works for ARM64. Update
the Documentation to reflect the same.

Signed-off-by: Dev Jain <dev.jain@arm.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index b600df82669d..7282d6057e32 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2544,7 +2544,7 @@
 
 	keepinitrd	[HW,ARM] See retain_initrd.
 
-	kernelcore=	[KNL,X86,IA-64,PPC,EARLY]
+	kernelcore=	[KNL,X86,IA-64,PPC,ARM64,EARLY]
 			Format: nn[KMGTPE] | nn% | "mirror"
 			This parameter specifies the amount of memory usable by
 			the kernel for non-movable allocations.  The requested
@@ -3612,7 +3612,7 @@
 	mousedev.yres=	[MOUSE] Vertical screen resolution, used for devices
 			reporting absolute coordinates, such as tablets
 
-	movablecore=	[KNL,X86,IA-64,PPC,EARLY]
+	movablecore=	[KNL,X86,IA-64,PPC,ARM64,EARLY]
 			Format: nn[KMGTPE] | nn%
 			This parameter is the complement to kernelcore=, it
 			specifies the amount of memory used for migratable
-- 
2.34.1


