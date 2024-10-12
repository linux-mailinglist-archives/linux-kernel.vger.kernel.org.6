Return-Path: <linux-kernel+bounces-362643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 039D799B78F
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 00:55:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A16D3282346
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 22:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF1671527BB;
	Sat, 12 Oct 2024 22:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ANxYb79u"
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 490361474C9
	for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 22:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728773736; cv=none; b=HyAfgPaQ8n3DlgZnbB+ckEdbu3DW6a3Tizx8gvtrxPC6Kjq/DeqGQoynuyDI/OCpgbKdrKb5OpxOETLCIyg80qDHy//O8KMIpcc2UTHg6Q34RQ3as6r8bVAOvtfdnIZdrf8qRHbBuomGZzwv0Sj/PT4otkyKsiS2uBw/icu+8Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728773736; c=relaxed/simple;
	bh=hsVkqidi4rW5vsRQmSpgIfzYcXNcVCH1I5JZlW1jiok=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=E0FS1m12FX/SRsd42PysC10n3Y92WbJqhcqtjklWa+TT7DKlnMwUq1UaFCUbnJCOQXhZRzxsbSaaW+azBCIJWH/ITjFgKgAjKH/kqfguUFwvF7/Hc4dPbu1sFIyNbBOPihe89Z/Hr7SXTaBdnUi6LI2J30InLH3FRiG16CG/6h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ANxYb79u; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1728773729;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=CgvZDSVMVRrq8dB5zas4ZxX7JK877fbfChbCjfBWfFg=;
	b=ANxYb79u+l891dJ6t6UEvHA4Q0uNxy9wIGFA+pGngztdi2wLXSa6al6DFUo1bdNZhmlfvk
	e7IEay8OO3sxR5JEBb6+fs5h0WzauYXYgOEyRrUdkympv/BzADWm7AJcwKoYTTZGd6IrR5
	XawRlmsmq3ZLN+gVuoimNRvJTUeA+LQ=
From: andrey.konovalov@linux.dev
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Andrey Konovalov <andreyknvl@gmail.com>,
	Marco Elver <elver@google.com>,
	Alexander Potapenko <glider@google.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	kasan-dev@googlegroups.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] MAINTAINERS: kasan, kcov: add bugzilla links
Date: Sun, 13 Oct 2024 00:55:24 +0200
Message-Id: <20241012225524.117871-1-andrey.konovalov@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Andrey Konovalov <andreyknvl@gmail.com>

Add links to the Bugzilla component that's used to track KASAN and KCOV
issues.

Signed-off-by: Andrey Konovalov <andreyknvl@gmail.com>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7ad507f49324a..c9b6fc55f84a6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12242,6 +12242,7 @@ R:	Dmitry Vyukov <dvyukov@google.com>
 R:	Vincenzo Frascino <vincenzo.frascino@arm.com>
 L:	kasan-dev@googlegroups.com
 S:	Maintained
+B:	https://bugzilla.kernel.org/buglist.cgi?component=Sanitizers&product=Memory%20Management
 F:	Documentation/dev-tools/kasan.rst
 F:	arch/*/include/asm/*kasan.h
 F:	arch/*/mm/kasan_init*
@@ -12265,6 +12266,7 @@ R:	Dmitry Vyukov <dvyukov@google.com>
 R:	Andrey Konovalov <andreyknvl@gmail.com>
 L:	kasan-dev@googlegroups.com
 S:	Maintained
+B:	https://bugzilla.kernel.org/buglist.cgi?component=Sanitizers&product=Memory%20Management
 F:	Documentation/dev-tools/kcov.rst
 F:	include/linux/kcov.h
 F:	include/uapi/linux/kcov.h
-- 
2.25.1


