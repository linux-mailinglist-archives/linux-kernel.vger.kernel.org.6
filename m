Return-Path: <linux-kernel+bounces-370479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E60D99A2D58
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 21:09:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 651B2B21FB3
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 19:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C84121D16F;
	Thu, 17 Oct 2024 19:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="M+zAVI2M"
Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A937219CA6
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 19:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729192136; cv=none; b=DvtYDY11p7r9xKhuVmLQEklEX/ZYhtata+0qX4OfLPpxq0Sm2TstXoJ1rjrZfWK8lHLzvIMR8wbmZ632+TOxqupj0aJ54D9oGalC4t5y1gmH1tIzw0aQFioErHiq57TWQjEGzHbPuT4Qf1YRtiuG2vQd3XSrO+VP+bbKuAEW8bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729192136; c=relaxed/simple;
	bh=XNbrH+PzGJnR1/M+mgzMDxkoQIDaLcgkvgT5zLemzak=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=H6CtI11SHhFqzLCDQGWrv2DXdDm07V709GtUpks6bI2E2Cb9mNrJ15vuIC3f4b8SHxiIIbXdVdHH2XChwJF1BOEdufqi9STN6Hg8MfdLfEsYmRVBuaUuiw0hUo5aNNrd823TvFkJ8siLX8+b2WPihib/pSWQIkbgiAyZK8kJsJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=M+zAVI2M; arc=none smtp.client-ip=185.70.40.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1729192123; x=1729451323;
	bh=O++mAf3y6UG64ocUCmqLlzP2zNaHJlUb0xjtjNehFU4=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=M+zAVI2MV4KODpU0wFeFKtpOCP0uvlvK5FlWSEqXhXZW7kYwsyKnp9brFQf+7KmMQ
	 c15dWoTly7xa5pD3/PD6ttABQKf1CIuJA8RjJSZZSbKKfJ1VhhkktPEz8ZlFhJ1quW
	 vaiPv0oTH4kjFun8/2d8GEB0wjuB2M4E2M19pWKgUW5Y98d6Nu7s/w6MrR1JcwBsc+
	 CYTJrPWmi50OvRPvRTLvNMNVOhs6bMnIihwHcLKLEwEUj1CfEn9LCa13KRUy6k6nDD
	 gDTZ9Dzgg/XE+p+BWx9ISMCsK7CLYJX/D63AmFLegkpj3Ep6eBlwVOZ1xVa0SwyBJX
	 IQBsqCIy/kwAg==
Date: Thu, 17 Oct 2024 19:08:39 +0000
To: gregkh@linuxfoundation.org, dpenkler@gmail.com
From: =?utf-8?Q?Dominik_Karol_Pi=C4=85tkowski?= <dominik.karol.piatkowski@protonmail.com>
Cc: linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev, =?utf-8?Q?Dominik_Karol_Pi=C4=85tkowski?= <dominik.karol.piatkowski@protonmail.com>
Subject: [PATCH v3] staging: gpib: Add TODO file
Message-ID: <20241017190732.82176-1-dominik.karol.piatkowski@protonmail.com>
Feedback-ID: 117888567:user:proton
X-Pm-Message-ID: 6bcbac51b5f7e11e3abe22314cf4f7c29781cef9
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Add a TODO file for the gpib driver.

Signed-off-by: Dominik Karol Pi=C4=85tkowski <dominik.karol.piatkowski@prot=
onmail.com>
---
v2: Remove maintainers from TODO, as they can be found in MAINTAINERS file
v3: Add things other than checkpatch fixes spotted in the code

 drivers/staging/gpib/TODO | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)
 create mode 100644 drivers/staging/gpib/TODO

diff --git a/drivers/staging/gpib/TODO b/drivers/staging/gpib/TODO
new file mode 100644
index 000000000000..bf2c39742548
--- /dev/null
+++ b/drivers/staging/gpib/TODO
@@ -0,0 +1,21 @@
+TODO:
+- checkpatch.pl fixes
+- fix device drivers that are broken ("depends on BROKEN" in Kconfig)
+- tidy-up comments:
+  - there are some "//comments" and "// comments" scattered around
+  - sometimes they are misaligned
+  - sometimes "// comments" are interleaved with "/* comments */"
+  - multiline comments should start with initial almost-blank line:
+    /*
+     * Good
+     * multiline
+     * comment
+     */
+    /* Bad
+     * multiline
+     * comment
+     */
+- resolve XXX notes where possible
+- fix FIXME notes
+- clean-up commented-out code
+- fix typos
--=20
2.34.1



