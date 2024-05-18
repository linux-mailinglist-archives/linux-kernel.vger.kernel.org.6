Return-Path: <linux-kernel+bounces-182908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BEC88C9199
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 18:00:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD747B21469
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 16:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8C5342042;
	Sat, 18 May 2024 16:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="BeotOVyf"
Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573906AD7;
	Sat, 18 May 2024 16:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716048038; cv=none; b=tszpH8UKETZKZJ3Afw604eTXJ7KUOArdEfnQC7E4I1j8qAuuZ6eEgvtoIIJU/ODJ2FiJ6iOudd3W+JpSdfn451laduurcoAEfuGd7pX7bRDH3SkJttBDGPJgThU8TNEF845DN/ovh2kgoFWU4Jxqbxhr7bK3JgGFFAQ927aIyQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716048038; c=relaxed/simple;
	bh=bygF6WawJ6ueyBX57zcpvye3rWmVIwdo53C08rU9aPs=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=dJhgK6mMZZ2GwAr8Og/XCMrUHI0WLGrttG4loQVEyRgJXLEIj55WXBx3SFKgC7vHl+RJxy/OXJUWH+QgCoFROfGY7bDp1AIe355MLirbtz2Un8DCh4WpLHkwINvPBfPKIgDlscr3VazYw1lOgrR7k6TB9k5c3wvesPT8ttEDdBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name; spf=none smtp.mailfrom=cyyself.name; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=BeotOVyf; arc=none smtp.client-ip=162.62.57.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cyyself.name
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1716048030; bh=G4b7Gy7au2RGDdIfISCbBgIRap2G195EA9qLAZb1j00=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BeotOVyfXSlQems8W0+Tz8b38pFY3XnZrWbqkmjvXbICw9o+CaJrA0KbxFPAxeutu
	 HFlSyDsU3AQICxoy/ZOdWEdUkpNEPU14hszQqX9tRJuGxfYPmFQ/QaqQazhwtkZYH0
	 UNOTZGEQg26b9aw3OI1qwfE0CxJz2fOhZKDgEPtc=
Received: from cyy-pc.lan ([240e:379:227e:fc00:28c6:7f50:fe33:13fe])
	by newxmesmtplogicsvrsza10-0.qq.com (NewEsmtp) with SMTP
	id 198A620; Sun, 19 May 2024 00:00:25 +0800
X-QQ-mid: xmsmtpt1716048025tb9g5oicz
Message-ID: <tencent_7C21508D6B7C6C824ADA8E8E28B827310908@qq.com>
X-QQ-XMAILINFO: Mee1Vp/QiDAWWkXRv90vh1x1lkAExZPbvkAPEF12ooNqsdf4ptrfkOpg3xq8gA
	 xE1sVpz+ZDPlFvtbiqSl1u3VFgtw0o8lgsV8GL/GnFz1ZaIZyS9Y++AlKlsoH+2LMVNciFYbEubP
	 zoD+61Iwlyqa2lXQcWYAfRohYJamV+fBDvG4FjGoZR+EUueCIjcihNP6sW/EnDnZkqudqLizU14/
	 50nxRuNUKBY6NGK97pKArVRB6BdzrHyOqegrsjqaJ82jWhkjGiCnwySr1aIoURIBZhp25swpINQz
	 8eE7zUTcskMlqGHGhpZl3v1lOJH0pk3zPzO/pKoEi8Xo1Z2TzQbsWApQLli9Bf1WJl7X/VjHCTSW
	 YAiYTwHMYNSqg9QIiOEaf1PWcWW5TykRu06XTfMxTF7yncyqZ6TaYrKJg0fJuzqVQbSlDulNueuE
	 GlWJB3N0kLMerljjpQdeSfeTIppxsl4Eo1/lpnMb/69IFq1QcnlmV/9RBBePTsKXBQ5NyeArNGBv
	 EKRBBhskXbAakmOE5yFEIsisg0j/LUWyQAutsJSfd8Iz10eK9uO3sCPDc1fZbXUINz+EMrKCHURF
	 mXKDs2MP/YiWxtU/A2JVDGM2oQdQEGrfG1ENyOTssXMbin+cPwrIPtp3IQS7am1fvz464kr2Ci4I
	 22U6LQBiETfOI9qrySp8hhaGU5QzUi09xQGSlqiqnCH2w1Suor+NdPMBz+DWUVP6/Qr0byY0BTJe
	 BHT4RjlAp3zZ62rcsAcehBKNvbMPsQ5tOEyQaQQiw3XRuiqX6pIi2WQ0HrfjqJexJqzIlly2f5T3
	 3Q47RtLTmwBu5xOgllfLbq2ZprFfD7mbf+Et19r+TFoIHbm1OgmaR2npuacdd4NBiUQ+mLAOLdyz
	 QEBQExwRT8TG+wWuvQvLCVOOD+O1+35TGcP6ntwuJB46StXeCshtIzPzjhcX7LcpyttrH9xx22F2
	 JKS87RB4lMEjQ2M6boXb3yE7kAOa/EB9bRkZaBC3hLJFz9rmmxkqVRkGZdp7CF
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
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
Subject: [PATCH 1/2] docs: riscv: Clarify risc-v hwprobe RISCV_HWPROBE_MISALIGNED_* docs.
Date: Sun, 19 May 2024 00:00:11 +0800
X-OQ-MSGID: <20240518160012.892135-1-cyy@cyyself.name>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <tencent_9D721BDDF88C04DBB5151D57711D62524209@qq.com>
References: <tencent_9D721BDDF88C04DBB5151D57711D62524209@qq.com>
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
index b2bcc9eed9aa..239be63f5089 100644
--- a/Documentation/arch/riscv/hwprobe.rst
+++ b/Documentation/arch/riscv/hwprobe.rst
@@ -192,21 +192,21 @@ The following keys are defined:
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
2.43.0


