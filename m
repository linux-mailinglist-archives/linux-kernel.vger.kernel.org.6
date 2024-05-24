Return-Path: <linux-kernel+bounces-188257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3382D8CDFCC
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 05:36:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 632191C21A25
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 03:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D9C637707;
	Fri, 24 May 2024 03:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="FIjiSVY2"
Received: from out203-205-221-191.mail.qq.com (out203-205-221-191.mail.qq.com [203.205.221.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47416BA42;
	Fri, 24 May 2024 03:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716521788; cv=none; b=Fw1m+W+w7x/h/7uHeCmYQRPE6f/6iV+UA2/CliccrMVsUTd4FQxmZZDwo0LsWbA/1jT27UkJpLtI+Irqz+ayN112vMDtQ2zYLL5VgD3wQVP7XQJTBX2lrr6Wnn75m8dtb+zjkIY/ehfXAEe8h47Oy5CWE4lNoTydvQKOFxwAIcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716521788; c=relaxed/simple;
	bh=makr7mi3PujEkx3T6CRjnoUCmfzjDacRazwH8OZA0CM=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=DcSNjdokYqnVlq2OlODprS6D/tqeCdq+11GmkhGxCgWcN6+iOMNvNfoo5FlvUx3pEBQANd6ZEMoXTUzvJeKD6nAQR5kNZxwa5vHuYA27zBLszDxQhwCorHpScNO0TQyydqkVvll+XiNLE6gynQ80DZCiX8g88/LbiZvyonkkDNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name; spf=none smtp.mailfrom=cyyself.name; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=FIjiSVY2; arc=none smtp.client-ip=203.205.221.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cyyself.name
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1716521776; bh=PHefl7GbkUI/lnsq5076BDrmwcyZfLe5+uejDUD7Q1Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FIjiSVY2r0wC6UZ+6OArZ1wa9qUpIUtypswrpIvmHLJRELphJXGI+KRrlq7ANmTZI
	 nbLfvqPfplqGd6cgR9lTDESppzCHjVFRKFL+PhSIPuV04NUctb1cHwWIG87PCQkTxU
	 +ktn4eeJc1y3vlTR89LCQu/1RsDi9cicntBi/vsk=
Received: from cyy-pc.lan ([240e:379:2259:4c00:b652:79f2:d4c3:c8a8])
	by newxmesmtplogicsvrszb16-1.qq.com (NewEsmtp) with SMTP
	id 90C8A481; Fri, 24 May 2024 11:36:12 +0800
X-QQ-mid: xmsmtpt1716521772tub1unh7p
Message-ID: <tencent_8BC6BC8798373AF1AD09AE68D338FEE0620A@qq.com>
X-QQ-XMAILINFO: Nci1v0XuD9lFXEbgY5GllxLw4rKsvUSbqDMc2mN0rRE83G6Nz7ghR24HOvk8O1
	 9n5OW8MBMqMNo8ZqA6ZbaM4S/5iTYpUgqFTRu4Ks4Kngl2yEpUa4ZuKZ5988ygxdsitfnHP0kcEL
	 jBQhSC2/lGR4jNyQVTUV/XM72Uv+oT1xsAyvoVHLOXekt0dDEwROZOun7S0RFJCH/nfDyAUgJSVm
	 GRVVPUAIYIK0pGu5a6ov0pAJvNXki9km5euByYAYmtWG4HdGknAUl5nT5JJo4XkWyvrquukdOkqd
	 3VF0g4ZMVV2/ZrgxamHFP6bqVpEN5cn5Hnn3xXMwqYygz/t3Ih+Gloom264HlUjm1h1YpAiYtlUB
	 b9Rq9ZwCdqAEW8cyrVsCmvk8uwOffL0/FlYYmy7LN9sn6qMTyGQsr4jSZKekTSMOoNE+Vwj9AeF2
	 R/Co7YrAA4JEqqU8hktFoqleMAZOu7BQOAefZwKpu8E7JjJ0WBuotrGa/k04weGdELynKlxdltTN
	 xPOWQgG0JfbE/Bqos2J4q4f6hWHcQ5p8GfEYU8CQVbtjGS2L9Jeuvn/ESB6mYM60mggCqqmxNLjn
	 tM1qWT1HxLk8ARvUoz1DhhJQnoCUQoBQeuKPToWI/cDGs4NebFKp55dvmzOIznxibQdPGMPuXAez
	 Dxw/+0IEWFBre/yJzzAo5gc0zyzBPzSCyjSzYNajC4pd7EHdhUYAWtEaH1bguKCHSZRv1j4k9Djn
	 8VbBNTJ9jR8umPGLOanNptzhPvsQLz3vVChYuDSBQqm0PTci4DxbUr8F9evgWKxJQuL4WXp+RqUA
	 rhnkZ2H2/fAahHyntHJ6vJuIq0g213USKj7oF6gS3821OEuDzMQ4QYf7zsdR/l4bSF2yYBn3jJ8T
	 00N+lKHRS21z8Yfou9hbXM2PLfbbCfY14J+Mew9GX23cTQkLppSqEZuYUbR8ccw8OndKdMa+3LOS
	 GP5rGo6wsSvI6kyd/Q2A6AWrdZxmuu4vgngSvQfX5HgG3vVHKNiJ0XWO3m911JtMlKOzluSJ24n/
	 LEcTjDgg==
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
From: Yangyu Chen <cyy@cyyself.name>
To: linux-riscv@lists.infradead.org
Cc: Elliott Hughes <enh@google.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Evan Green <evan@rivosinc.com>,
	=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Yangyu Chen <cyy@cyyself.name>
Subject: [PATCH v2 1/3] docs: riscv: Clarify risc-v hwprobe RISCV_HWPROBE_MISALIGNED_* docs.
Date: Fri, 24 May 2024 11:35:57 +0800
X-OQ-MSGID: <20240524033559.298935-1-cyy@cyyself.name>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <tencent_1E3506F09D08066B8F3BAEE136C4F887540A@qq.com>
References: <tencent_1E3506F09D08066B8F3BAEE136C4F887540A@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: enh <enh@google.com>

These only tell you about scalar accesses, not vector accesses.

Signed-off-by: Elliott Hughes <enh@google.com>
Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>
Signed-off-by: Yangyu Chen <cyy@cyyself.name>
---
 Documentation/arch/riscv/hwprobe.rst | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/Documentation/arch/riscv/hwprobe.rst b/Documentation/arch/riscv/hwprobe.rst
index 204cd4433af5..d720712e9734 100644
--- a/Documentation/arch/riscv/hwprobe.rst
+++ b/Documentation/arch/riscv/hwprobe.rst
@@ -196,21 +196,21 @@ The following keys are defined:
   information about the selected set of processors.
 
   * :c:macro:`RISCV_HWPROBE_MISALIGNED_UNKNOWN`: The performance of misaligned
-    accesses is unknown.
+    scalar accesses is unknown.
 
-  * :c:macro:`RISCV_HWPROBE_MISALIGNED_EMULATED`: Misaligned accesses are
+  * :c:macro:`RISCV_HWPROBE_MISALIGNED_EMULATED`: Misaligned scalar accesses are
     emulated via software, either in or below the kernel.  These accesses are
     always extremely slow.
 
-  * :c:macro:`RISCV_HWPROBE_MISALIGNED_SLOW`: Misaligned accesses are slower
-    than equivalent byte accesses.  Misaligned accesses may be supported
+  * :c:macro:`RISCV_HWPROBE_MISALIGNED_SLOW`: Misaligned scalar accesses are
+    slower than equivalent byte accesses.  Misaligned accesses may be supported
     directly in hardware, or trapped and emulated by software.
 
-  * :c:macro:`RISCV_HWPROBE_MISALIGNED_FAST`: Misaligned accesses are faster
-    than equivalent byte accesses.
+  * :c:macro:`RISCV_HWPROBE_MISALIGNED_FAST`: Misaligned scalar accesses are
+    faster than equivalent byte accesses.
 
-  * :c:macro:`RISCV_HWPROBE_MISALIGNED_UNSUPPORTED`: Misaligned accesses are
-    not supported at all and will generate a misaligned address fault.
+  * :c:macro:`RISCV_HWPROBE_MISALIGNED_UNSUPPORTED`: Misaligned scalar accesses
+    are not supported at all and will generate a misaligned address fault.
 
 * :c:macro:`RISCV_HWPROBE_KEY_ZICBOZ_BLOCK_SIZE`: An unsigned int which
   represents the size of the Zicboz block in bytes.
-- 
2.45.1


