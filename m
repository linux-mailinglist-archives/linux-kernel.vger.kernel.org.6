Return-Path: <linux-kernel+bounces-336856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ACF89841CA
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 11:14:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B2E01C23127
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 09:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B7FE154C0E;
	Tue, 24 Sep 2024 09:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Za+zMia/"
Received: from out-185.mta1.migadu.com (out-185.mta1.migadu.com [95.215.58.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC4814F102
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 09:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727169262; cv=none; b=XwSsZ8KOdsVVUz9ZgGcr3vmGuEU0das73+yTZD8rv+/zo5tO3NUpA4qhYqrexcmO79jRId8504r5sgICyWVVr56IhuxmqCd1yBoKtuTBLt938CdgVH/V8yslWqiZeBjAsvnJmDe8v9Or4ZAjkYcqAZELyea3IA38Q4XR4fHqg+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727169262; c=relaxed/simple;
	bh=gpafSpem4HB2dPyhl/6Bj9nqfP/ORi7C7BNrIIUafno=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HoXMUua/+GmyxZo3CLbt9WCLG3mGTWb84PlnQPw1nMunJX9exCq1UKNY+ewpYcEMgp7Wc9i7uI2lnRXMcw7CSbW5msaWkClUKl3FtzA+WYeTbZ8bXBXH9EGAylVJywPd0jhNgF6pugcAU7fIeEAl5KxiZ/a7jRIbsJW9DnaDdyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Za+zMia/; arc=none smtp.client-ip=95.215.58.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1727169258;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=nFHd29R/rsH2fVSDacZDI+gbua1g6h18VtoviUxOb4g=;
	b=Za+zMia/NZyUlnhNsw1eNO9V47VIshtv/BeOEChBcxEdrgMZIc0SL99zvA2EAlBjF3ZN0d
	eUDDT0gaE7HV7E3w1+/ExD13aD7c/kAYQrm5Cy9118xsTV+CAUaD7i+2J4VrLvJKU536uM
	3Rj6HdLaS4QAfe+Rosd9dTfIFSDXnpM=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] MAINTAINERS: Add kernel hardening keywords __counted_by{_le|_be}
Date: Tue, 24 Sep 2024 11:12:49 +0200
Message-ID: <20240924091248.238698-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

In addition to __counted_by, also match the keywords __counted_by_le and
__counted_by_be.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 911d573f7779..aff8b04b5eac 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12293,7 +12293,7 @@ F:	lib/usercopy_kunit.c
 F:	mm/usercopy.c
 K:	\b(add|choose)_random_kstack_offset\b
 K:	\b__check_(object_size|heap_object)\b
-K:	\b__counted_by\b
+K:	\b__counted_by(_le|_be)?\b
 
 KERNEL JANITORS
 L:	kernel-janitors@vger.kernel.org
-- 
2.46.1


