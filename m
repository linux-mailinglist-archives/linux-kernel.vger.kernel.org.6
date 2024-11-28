Return-Path: <linux-kernel+bounces-425124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A58219DBDAA
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 23:35:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EA09167213
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 22:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 449411CC8A4;
	Thu, 28 Nov 2024 22:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XSFbvrml";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Gq4RB650"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C7941CC8B0
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 22:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732833069; cv=none; b=oKp74hGxofcw+jZLzdr0Zy/Ek9rWA1LqtjZAHuWx9RzmpIP7fiB3bi9wioPuNs/7NRXM7beb7spLYg56/mc7OwPIYVXiyB4PM8cTT7obMUtwgi0bispFwVZPtwvY12HX6HZIQifwsrm7NKo6pmzCBOK3I43MqVgWCHI6jLzb6wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732833069; c=relaxed/simple;
	bh=ruEYwcRMvtCeOCWaPoYxORqB7MEuxs3dYXq/FLZ6rwg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=plg9UkF8UkqVPCXSqRDNaKZtcHpunzUWt/HEIjgDUXry5BS+cUhxjIbJxePPrvqVAWXFQujfovmOQbitNRvWsWNl67szEZUqbd+/I5UrxF/vl90WUEQHX4zsGP9Qmh0M9aE+TYl3kr9bn7s0VXQleBfPga9LBCGZvuPX66135X4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XSFbvrml; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Gq4RB650; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1732833067;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M62ukQJjMcFvGqmsYCWMCk84CGya3b4Kdgn3irWuPIg=;
	b=XSFbvrmlYdTh+jRTaPW3aK7pbGtGTrG2cRx8ZL9quclddI10gsUGdr//43kuFS3ncICWnm
	bH5UhYYZbqejaiiQk1N3owCECUlfALIw6VhIuvOJiJAEHt8pcQN4pbwIKEJDEvxrGa+POo
	bbcmEYGlVA1jM6yMCjUE+7W7CcP+VBzstAtcQBcEgS3zQDMVvdBf3GD5h4lIqmBEKIVeao
	5Bxdh5DV/1i7voGXJhZvQhXhS5k/qtvgrBSLDa/tgNzL8TKa+TAi6SOc45n19vyF2PjdaL
	lmoJyGbZbnvVjWBrXqNvDXNgYRXkPC7okSwAqHxnf6qD1thW0bJTahL7MsUodg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1732833067;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M62ukQJjMcFvGqmsYCWMCk84CGya3b4Kdgn3irWuPIg=;
	b=Gq4RB650MG/IZMdKh5YXV7NhggEWAMUdubeQnsYsz99y3VVH2VAbPwoJPvtMGshitRCQDD
	DYPG0idThQPM3HAQ==
To: Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	John Ogness <john.ogness@linutronix.de>,
	linux-kernel@vger.kernel.org,
	x86@kernel.org,
	x86-cpuid@lists.linux.dev,
	"Ahmed S. Darwish" <darwi@linutronix.de>
Subject: [PATCH v1 13/13] MAINTAINERS: Include kcpuid under X86 CPUID entry
Date: Thu, 28 Nov 2024 23:29:48 +0100
Message-ID: <20241128222948.579920-14-darwi@linutronix.de>
In-Reply-To: <20241128222948.579920-1-darwi@linutronix.de>
References: <20241128222948.579920-1-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The kcpuid tool ships a cpuid bitfields CSV file which is covered by the
"X86 CPUID DATABASE" maintainers entry.  Recent patches have shown that
changes to this CSV may require updates to the kcpuid code.

Include the entire kcpuid tool under the same maintainers entry.  This
will also ensure that myself and the x86-cpuid mailing list are CCed on
any future kcpuid patches.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index b878ddc99f94..3b95d6fe8e3b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -25093,7 +25093,7 @@ R:	Ahmed S. Darwish <darwi@linutronix.de>
 L:	x86-cpuid@lists.linux.dev
 S:	Maintained
 W:	https://x86-cpuid.org
-F:	tools/arch/x86/kcpuid/cpuid.csv
+F:	tools/arch/x86/kcpuid/
 
 X86 ENTRY CODE
 M:	Andy Lutomirski <luto@kernel.org>
-- 
2.46.2


