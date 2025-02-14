Return-Path: <linux-kernel+bounces-514949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C62AAA35DE2
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 13:51:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BC7D3AD18D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 12:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91B3F230985;
	Fri, 14 Feb 2025 12:51:46 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D02717555
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 12:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739537506; cv=none; b=u+8ZXxMdGAzCTCuPJqMlCD9JM2lyiRPdZptjKpgb4dSvmL8BY50L3cg34Y7iw95Gdr3B0O8LJZFn64eirO+Z0WdBMZObs3iH/HGNfVc+64JXbEUDbnbiX0bH1iww5DKz2BwMWSHIPrHA0L+ETuvny34ZzwIV7u/mzHN22HjXr1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739537506; c=relaxed/simple;
	bh=aUU/pYofqO2pPpvSNHOgvPqy+8bSVxy8MyCpD4EEYFQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EbwCksc0Fvh4sZrReArKK8EZG1zUFbBmnTWO8gjo6LvmrB3sluBaVL7KCA68UAqcB7WaGvVzCIOQUDLHdm2Ye4BDFLHtmbxVm3wiO92Uau2neMx2Enib77Y7XEj3e8nFfWPN/aBl3ZrTm+cF+oN4DNK4dOMxETXlfATn0V8TEW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8DxOGpbPK9ngVJ1AA--.7448S3;
	Fri, 14 Feb 2025 20:51:39 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowMCxPsdYPK9nOA0SAA--.5383S2;
	Fri, 14 Feb 2025 20:51:37 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Huacai Chen <chenhuacai@kernel.org>
Cc: loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] objtool: Rename ".rodata..c_jump_table" to "..rodata.c_jump_table"
Date: Fri, 14 Feb 2025 20:51:35 +0800
Message-ID: <20250214125135.2172-1-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMCxPsdYPK9nOA0SAA--.5383S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxGw1DJr48KF15tr4fZw4xuFX_yoWrZFW3pF
	Wq9r92grs0gFyagw4xGr1Y9rW3Jw43Kr1UKrWDJ34jyw4avF1vqFs2ka12yFyvgws5WayI
	qFs2grWUGFWkZ3gCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4
	xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v2
	6r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x0EwI
	xGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480
	Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7
	IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k2
	6cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07j5WrAUUUUU=

Specify the attribute like ".rodata..c_jump_table,\"a\",@progbits #"
explicitly works for GCC, but this hack apparently doesn't work with
Clang, the generated section name is wrong, resulting in a warning
and missing ORC for x86. This is because there is only one arg for
section name in LLVM, even if the so called attribute is specified,
it will be recognized as a whole for section name, so it is not a
good way to specify the attribute for this section.

In the top Makefile, there is "-fno-PIE" build flag. For x86, there
is no "-fPIE" build flag in arch/x86/Makefile for 64 bit kernel. But
for LoongArch, there is "-fPIE" build flag in arch/loongarch/Makefile
to override "-fno-PIE" in top Makefile. After some test with GCC and
Clang on x86 and LoongArch, it shows that the generated "W" (writable)
attribute of the section ".rodata..c_jump_table" is related with the
compiler option "-fPIE", and then lead to the GNU assembler warning:
"setting incorrect section attributes for .rodata..c_jump_table".

Based on the above analysis, in order to avoid changing the behavior
of GNU assembler and silence the GNU assembler warning, it is better
to rename ".rodata..c_jump_table" to "..rodata.c_jump_table" without
section attribute, it works well with GCC and Clang, no GNU assembler
warning for GCC and the section name is normal for Clang.

Fixes: c5b1184decc8 ("compiler.h: specify correct attribute for .rodata..c_jump_table")
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---

This patch is based on tip/tip.git objtool/urgent branch:
https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/log/?h=objtool/urgent

 include/asm-generic/vmlinux.lds.h       | 2 +-
 include/linux/compiler.h                | 2 +-
 tools/objtool/check.c                   | 5 +++--
 tools/objtool/include/objtool/special.h | 2 +-
 4 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 54504013c749..91a7e824ed8b 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -457,7 +457,7 @@ defined(CONFIG_AUTOFDO_CLANG) || defined(CONFIG_PROPELLER_CLANG)
 	. = ALIGN((align));						\
 	.rodata           : AT(ADDR(.rodata) - LOAD_OFFSET) {		\
 		__start_rodata = .;					\
-		*(.rodata) *(.rodata.*)					\
+		*(.rodata) *(.rodata.*) *(..rodata.*)			\
 		SCHED_DATA						\
 		RO_AFTER_INIT_DATA	/* Read only after init */	\
 		. = ALIGN(8);						\
diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index b087de2f3e94..3d013f1412e0 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -110,7 +110,7 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
 /* Unreachable code */
 #ifdef CONFIG_OBJTOOL
 /* Annotate a C jump table to allow objtool to follow the code flow */
-#define __annotate_jump_table __section(".rodata..c_jump_table,\"a\",@progbits #")
+#define __annotate_jump_table __section("..rodata.c_jump_table")
 #else /* !CONFIG_OBJTOOL */
 #define __annotate_jump_table
 #endif /* CONFIG_OBJTOOL */
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 497cb8dfb3eb..1398ffc20b16 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2471,12 +2471,13 @@ static void mark_rodata(struct objtool_file *file)
 	 *
 	 * - .rodata: can contain GCC switch tables
 	 * - .rodata.<func>: same, if -fdata-sections is being used
-	 * - .rodata..c_jump_table: contains C annotated jump tables
+	 * - ..rodata.c_jump_table: contains C annotated jump tables
 	 *
 	 * .rodata.str1.* sections are ignored; they don't contain jump tables.
 	 */
 	for_each_sec(file, sec) {
-		if (!strncmp(sec->name, ".rodata", 7) &&
+		if ((!strncmp(sec->name, ".rodata", 7) ||
+		    !strncmp(sec->name, "..rodata", 8)) &&
 		    !strstr(sec->name, ".str1.")) {
 			sec->rodata = true;
 			found = true;
diff --git a/tools/objtool/include/objtool/special.h b/tools/objtool/include/objtool/special.h
index e7ee7ffccefd..34acf4ae5fab 100644
--- a/tools/objtool/include/objtool/special.h
+++ b/tools/objtool/include/objtool/special.h
@@ -10,7 +10,7 @@
 #include <objtool/check.h>
 #include <objtool/elf.h>
 
-#define C_JUMP_TABLE_SECTION ".rodata..c_jump_table"
+#define C_JUMP_TABLE_SECTION "..rodata.c_jump_table"
 
 struct special_alt {
 	struct list_head list;
-- 
2.42.0


