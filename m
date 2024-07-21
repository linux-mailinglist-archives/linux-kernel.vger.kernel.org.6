Return-Path: <linux-kernel+bounces-258179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1A7C9384C7
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2024 15:37:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D7E928109A
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2024 13:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EFD116631A;
	Sun, 21 Jul 2024 13:37:19 +0000 (UTC)
Received: from mailscanner01.zoner.fi (mailscanner01.zoner.fi [84.34.166.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48351161339;
	Sun, 21 Jul 2024 13:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.34.166.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721569038; cv=none; b=N71yo7fG6ztoP4/g3k1LW/fmDtwCnuEXiF0JN4K3tOFCctHHOa8E+xSQ+xYbq2pJl5zec9xw9hAFQAyYxMqT2q6pkcVa5YqhnxvM1CggNKqXpDq1kx+0+4kg8GYZ+Prag8ygWhAw/uf87JRCS8yqDJvTqMbYzV3e9ku01VsYoRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721569038; c=relaxed/simple;
	bh=btuh87Wo1Si4JoyLKgPbaICd08yIQ6Fy/xTh7FmbF1E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WRaJ4UA+2KMu+eqWLKU1rbojJTvgmPQaCoEGoSdStzbXOQrWfpwmEn0HXNzD+gWKZc55FV5e1VptI6nVU77EXmSftNn0g9Z6zPEJ3aNku+xfCj/GWJntKBjUxanal6MrWtFU5b2SyiMfOF2mPgXPxm87OXJB4sbpMvEN4zofaoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tukaani.org; spf=pass smtp.mailfrom=tukaani.org; arc=none smtp.client-ip=84.34.166.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tukaani.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tukaani.org
Received: from www25.zoner.fi (www25.zoner.fi [84.34.147.45])
	by mailscanner01.zoner.fi (Postfix) with ESMTPS id AFEFD42E35;
	Sun, 21 Jul 2024 16:37:14 +0300 (EEST)
Received: from mail.zoner.fi ([84.34.147.244])
	by www25.zoner.fi with esmtp (Exim 4.97.1)
	(envelope-from <lasse.collin@tukaani.org>)
	id 1sVWkR-00000001SmU-1Gdu;
	Sun, 21 Jul 2024 16:37:14 +0300
From: Lasse Collin <lasse.collin@tukaani.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Lasse Collin <lasse.collin@tukaani.org>,
	Sam James <sam@gentoo.org>,
	linux-kernel@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org
Subject: [PATCH v2 08/16] docs: Add XZ_EXTERN to c_id_attributes
Date: Sun, 21 Jul 2024 16:36:23 +0300
Message-ID: <20240721133633.47721-9-lasse.collin@tukaani.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240721133633.47721-1-lasse.collin@tukaani.org>
References: <20240721133633.47721-1-lasse.collin@tukaani.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

include/linux/xz.h uses XZ_EXTERN in function prototypes. It's needed in
the preboot code. Adding XZ_EXTERN c_id_attributes silences warnings and
makes the intradocument links to the xz_dec functions work.

Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Reviewed-by: Sam James <sam@gentoo.org>
Signed-off-by: Lasse Collin <lasse.collin@tukaani.org>
---
 Documentation/conf.py | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/conf.py b/Documentation/conf.py
index 0c2205d536b3..2fc1fea858e1 100644
--- a/Documentation/conf.py
+++ b/Documentation/conf.py
@@ -123,6 +123,9 @@ if major >= 3:
 
             # include/linux/btf.h
             "__bpf_kfunc",
+
+            # include/linux/xz.h
+            "XZ_EXTERN",
         ]
 
 else:
-- 
2.45.2


