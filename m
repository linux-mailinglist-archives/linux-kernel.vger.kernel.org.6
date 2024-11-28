Return-Path: <linux-kernel+bounces-424653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58DB99DB78B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 13:28:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D492BB23262
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 12:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAB9319C54F;
	Thu, 28 Nov 2024 12:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lwRDFCNg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A025156661
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 12:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732796900; cv=none; b=Wuo+mh5wfSrqFIweYd1TpkLQjQPiL7kW0hKVAXJJBjFNG0uz3nmC/RJI65Jlc7VbkNJTYNCMwTdcg1VNi27z/tbY9FCcIsMnkuSDzUSyXEc4qfWKveR53mze1aYqcpVGVDJswRKC/KXiAzU1DSKvYGxHnFYf9/wq+m+Fo/+7Vgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732796900; c=relaxed/simple;
	bh=bNrQTCZEcaUgo5FjBCbBrDG2yXY96CZgzMJbK9wmtmU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PYw5DNKdwTTtHr7kqD5Tz5fXuF/BVRUGuh0jakNaHoVUOdEYcPhIwRpcnVB7qBc/rGmgvrRQ8Y5va/j31IW2QNNNIhc48nyu1yI4Ur276dce/MLzB5cabBvdr0uvbn2aHwp1Gmn/ABYFA8VNgf42oWe/6eR/PI1EFDySlutQbJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lwRDFCNg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2A12C4CECE;
	Thu, 28 Nov 2024 12:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732796899;
	bh=bNrQTCZEcaUgo5FjBCbBrDG2yXY96CZgzMJbK9wmtmU=;
	h=From:To:Cc:Subject:Date:From;
	b=lwRDFCNg0cuGe7Oy1l1rZnHwuRrXt5uKq916ZD3W9qxOhp64Ak63kdNC1d3ceujht
	 dHifWks7Sk6EieJCC9VggvD9wbV0or9zZOY37Lk5LU+l7YXm9LMyFqxDsd3tU6lIjB
	 eartioY0loZFhGiHf/E0YKUEJ2rC64eQDJENShTvUD5eWCW3FJXyzrYxC4+V3Eill3
	 VaEXmWyVWLJ+qNKBz2SVFxRCxjxGQ4jtIbUrFMiHd9Rxm9CzPpoYYSX1Pbl2LkJgiv
	 rumjhHiS/ojB5jPjiJ7p2MSClI80DFopXhtb5KDM3tmoo2GYfNXNt3P2785Xh7pV33
	 Sj8OJnlidnywg==
From: Borislav Petkov <bp@kernel.org>
To: X86 ML <x86@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	"Borislav Petkov (AMD)" <bp@alien8.de>
Subject: [PATCH] x86/boot/compressed: Remove unused module.h include from kaslr.c
Date: Thu, 28 Nov 2024 13:28:15 +0100
Message-ID: <20241128122815.2943-1-bp@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Borislav Petkov (AMD)" <bp@alien8.de>

Nothing needs it.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 arch/x86/boot/compressed/kaslr.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
index f4d82379bf44..1b0300366d79 100644
--- a/arch/x86/boot/compressed/kaslr.c
+++ b/arch/x86/boot/compressed/kaslr.c
@@ -25,7 +25,6 @@
 #include "efi.h"
 
 #include <generated/compile.h>
-#include <linux/module.h>
 #include <linux/uts.h>
 #include <linux/utsname.h>
 #include <linux/ctype.h>
-- 
2.43.0


