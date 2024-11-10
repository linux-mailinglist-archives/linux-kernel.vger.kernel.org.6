Return-Path: <linux-kernel+bounces-403300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 551D79C33CC
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Nov 2024 17:22:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0C7A28145D
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Nov 2024 16:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF30884D29;
	Sun, 10 Nov 2024 16:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UqEvglzF"
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB6017C8D
	for <linux-kernel@vger.kernel.org>; Sun, 10 Nov 2024 16:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731255769; cv=none; b=HUwW3oY96Sqyl3L07cJxNMtxerlhZrANa6w3e9SgMOurt2GaW4IBYt2uHZdol17YTTF7F9xynKLW/Qa4djBhbiHQfyWJxbvryO9o/St0F60kv203pQSw05kNvUwn2AOLc/0cYmPCjV0sZgG8plBI9ezrZvDn3Vl8yDnTQOqZ8x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731255769; c=relaxed/simple;
	bh=NLlzz/LVWtRJ0R6hwnxFKEnhYg4IoKIHrAyfwR0WuIc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ck1HUlXkxEh4NYXFEt2ExZYYmuAjB3Fbpz3SYL9t37W1p80MyTelUfI+81wWFwYOuplBNwtA8eJoNR8mpzDCQNu+mvVrPH8sSzLD0IYGvxrOhrrc9gDf4dQvf/LaUbL51as7d3nr/VRE/ys3CbpCECE1Q0BAqECu934WQ4HSUnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UqEvglzF; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1731255764;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=UqFBbtKCvn2uiiJOd1o/KjH4nUtT3WyJ3xfVwaTrNto=;
	b=UqEvglzFeNOhDzYxajvvlX0CDxH15EInV3wh39Dr57bxgbCcRLfzaF8qGFKCZNcoHn+gUI
	mAxVDFiTTPDGDS5LqLvOjKyAOiHd/Lp3KCuEtxEC+4RTivVsd0u3uCkmwSiNdJK6w6Xyse
	M4ZDObUYf/2Vd0uab8AM6ptY/ZbFvzU=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Thorsten Blum <thorsten.blum@linux.dev>
Cc: linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc: Transliterate author name and remove FIXME
Date: Sun, 10 Nov 2024 17:21:37 +0100
Message-ID: <20241110162139.5179-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The name is Mimi Phuong-Thao Vo.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 arch/powerpc/boot/rs6000.h | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/powerpc/boot/rs6000.h b/arch/powerpc/boot/rs6000.h
index a9d879155ef9..16df8f3c43f1 100644
--- a/arch/powerpc/boot/rs6000.h
+++ b/arch/powerpc/boot/rs6000.h
@@ -1,11 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /* IBM RS/6000 "XCOFF" file definitions for BFD.
    Copyright (C) 1990, 1991 Free Software Foundation, Inc.
-   FIXME: Can someone provide a transliteration of this name into ASCII?
-   Using the following chars caused a compiler warning on HIUX (so I replaced
-   them with octal escapes), and isn't useful without an understanding of what
-   character set it is.
-   Written by Mimi Ph\373\364ng-Th\345o V\365 of IBM
+   Written by Mimi Phuong-Thao Vo of IBM
    and John Gilmore of Cygnus Support.  */
 
 /********************** FILE HEADER **********************/
-- 
2.47.0


