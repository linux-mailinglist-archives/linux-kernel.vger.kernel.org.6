Return-Path: <linux-kernel+bounces-567011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F608A67FD1
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 23:32:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A98617FBC0
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 22:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ABC5205E14;
	Tue, 18 Mar 2025 22:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DLwOJVD8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9739A18E25;
	Tue, 18 Mar 2025 22:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742337166; cv=none; b=FFj8HO763nwS601aBuPD40l2cGm9sjrBgr6LgCyQA+d4KYzKEAp0nTXR0ca1WwSISjTVKyIS1IevYTa+z/lTRlV1wk9kuO/qL+HVKFTTT3qXfChbhgVxSMkg2iN1js4enMrGttewD10kmU+N1dSH4pBq/RjXG4XWI0iTvAzg+Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742337166; c=relaxed/simple;
	bh=j1mnXEe9xJfk5P6wQxhe+3cDKh4bM2ddu4bdvZ4iJmw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=hdQDwPq1tVw7SVq9C6Qx7maQO36wtCVOvVmaBKVvm4WLetHmlwssz35CgJpwloc3/pdj0fkAQGpTaZb2zQKQ4o5QT7EsXTuKprvR9CYXoe5a9CZFBZHekw7JQTEg3V1dyStdnrSs/XbcNovIDtOj1z1o4Enc+R95kiaFXxeVSq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DLwOJVD8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B007AC4CEDD;
	Tue, 18 Mar 2025 22:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742337166;
	bh=j1mnXEe9xJfk5P6wQxhe+3cDKh4bM2ddu4bdvZ4iJmw=;
	h=From:Date:Subject:To:Cc:From;
	b=DLwOJVD8oIy5nEJTXUeTA7Cia8nFmSTZqZXhFZ1YWfVFfeuh6MN5AQPJVDRmF33LP
	 lZtALYokio2wRuaTEpC+97SDViDDyFn/inZYIcAn2PvAvA7oe53UUVjdvsNvuOQOLX
	 73A4T7IAEMrJ0h5FgrI1VvYTk9ax6H5CwBy27+S7r/YUtjC0jt4oq53YjnZyB8bqNX
	 0s4QUSBLN+80unVK3NC9/FAQOyEDwDUJsY+VRXobZxZ4HWRshwoTYDunlmqWKe9Cp8
	 9K/gGiMRjf1zXPROqHqjpYU6g/n0YpB9JyGCV4ujPszAJ4Ajid+c8A65Mz8Yy7gCmQ
	 cwuf4hVwGgP3A==
From: Nathan Chancellor <nathan@kernel.org>
Date: Tue, 18 Mar 2025 15:32:30 -0700
Subject: [PATCH] x86/tools: Drop unlikely definition from insn_decoder_test
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250318-x86-decoder-test-fix-unlikely-redef-v1-1-74c84a7bf05b@kernel.org>
X-B4-Tracking: v=1; b=H4sIAH302WcC/x2NwQqDMBAFf0X23AWjbUz7K+KhmJe6KLFsVBTx3
 xt6HBhmTkpQQaJXcZJikyRzzGBuBfXDO37A4jNTVVaPsjaOd2fZo589lBekhYPsvMZJRkwHKzw
 CG1tb92xwD2gol76KbP0vbXddP/tNTSV1AAAA
X-Change-ID: 20250318-x86-decoder-test-fix-unlikely-redef-1636897e4fe7
To: Shuah Khan <skhan@linuxfoundation.org>, x86@kernel.org
Cc: Rae Moar <rmoar@google.com>, 
 =?utf-8?q?Sergio_Gonz=C3=A1lez_Collado?= <sergio.collado@gmail.com>, 
 David Gow <davidgow@google.com>, linux-kernel@vger.kernel.org, 
 llvm@lists.linux.dev, Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1509; i=nathan@kernel.org;
 h=from:subject:message-id; bh=j1mnXEe9xJfk5P6wQxhe+3cDKh4bM2ddu4bdvZ4iJmw=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDOk3v/Qo2nxMkmkKO/HzZpHs+4ffiq6/YFmouUCdTWkV8
 2ROgVn1HaUsDGJcDLJiiizVj1WPGxrOOct449QkmDmsTCBDGLg4BWAi7PMZ/umuv57z8Kep1KVN
 s16c2jvHSKrOaeURxz6n47krrCP3Z25lZFi2d+7vWab5ZeuFl27WEhGMfewz74nJ7u0lLv2aOQ2
 LF/MBAA==
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716

After commit c104c16073b7 ("Kunit to check the longest symbol length"),
there is a warning when building with clang because there is now a
definition of unlikely from compiler.h in tools/include/linux, which
conflicts with the one in the instruction decoder selftest.

  arch/x86/tools/insn_decoder_test.c:15:9: warning: 'unlikely' macro redefined [-Wmacro-redefined]
     15 | #define unlikely(cond) (cond)
        |         ^
  tools/include/linux/compiler.h:128:10: note: previous definition is here
    128 | # define unlikely(x)            __builtin_expect(!!(x), 0)
        |          ^
  1 warning generated.

Remove the second unlikely definition, as it is no longer necessary,
clearing up the warning.

Fixes: c104c16073b7 ("Kunit to check the longest symbol length")
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 arch/x86/tools/insn_decoder_test.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/x86/tools/insn_decoder_test.c b/arch/x86/tools/insn_decoder_test.c
index 6c2986d2ad11..08cd913cbd4e 100644
--- a/arch/x86/tools/insn_decoder_test.c
+++ b/arch/x86/tools/insn_decoder_test.c
@@ -12,8 +12,6 @@
 #include <stdarg.h>
 #include <linux/kallsyms.h>
 
-#define unlikely(cond) (cond)
-
 #include <asm/insn.h>
 #include <inat.c>
 #include <insn.c>

---
base-commit: 2e0cf2b32f72b20b0db5cc665cd8465d0f257278
change-id: 20250318-x86-decoder-test-fix-unlikely-redef-1636897e4fe7

Best regards,
-- 
Nathan Chancellor <nathan@kernel.org>


