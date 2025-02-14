Return-Path: <linux-kernel+bounces-514253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92BABA354A7
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 03:23:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 186071890F90
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 02:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D9A18634A;
	Fri, 14 Feb 2025 02:23:16 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 920C53C17
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 02:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739499796; cv=none; b=Znh16w3BRTDlKdpy5IFlT61qcmxgz42mE+sLq2eoUZagY4I2Uv3vipB/6ZbxbAA6sQMWnMadp2/1ueKpPAaC9IVpACJZTsyzvApcScoUBbQCKczSKLOU8fLUU44rN5up90Z0CSFoCggD4vpVClb8u7E5mQkGhHaK2XhT1ZNxZ4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739499796; c=relaxed/simple;
	bh=K2sW+nCWLQQlXtFqt9fV432uBOm2kyFomu7ox24gfGc=;
	h=Subject:To:References:Cc:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=IFtjG4pp0hXgUF83OKzpUrtAkDmHe9grwA7sy6rnYx/zCfosK8C+sDc/ZKqcmfBXhWiOB6FpLL4/RYvzfQQa2YhFwaODBUVhSsLl2CaroOxmmLGQBEXiVyEberXThjU/ke3dgk5vOg/wKTemeHyhaHwiwoYch2jzXrxM8QFJhL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8CxqmoNqa5nufN0AA--.6842S3;
	Fri, 14 Feb 2025 10:23:09 +0800 (CST)
Received: from [10.130.0.149] (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowMDxH+UMqa5nFkIRAA--.2062S3;
	Fri, 14 Feb 2025 10:23:08 +0800 (CST)
Subject: Re: [PATCH] compiler.h: Specify correct attribute for
 .rodata..c_jump_table
To: Josh Poimboeuf <jpoimboe@kernel.org>
References: <20240924062710.1243-1-yangtiezhu@loongson.cn>
 <20250212175023.rsxsw7pno57gsxps@jpoimboe>
 <b1e5e3ea-be4b-5dae-cc0d-34693429d060@loongson.cn>
 <20250213023936.lzbpgou4eallaij3@jpoimboe>
 <045d7e22-672c-b9da-38d6-8897e854f262@loongson.cn>
 <20250213185408.m5aogf2trvhvi2td@jpoimboe>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, loongarch@lists.linux.dev,
 linux-kernel@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>,
 llvm@lists.linux.dev
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <439175dc-caf0-3d38-89ba-ade5a364c9bb@loongson.cn>
Date: Fri, 14 Feb 2025 10:23:08 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250213185408.m5aogf2trvhvi2td@jpoimboe>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:qMiowMDxH+UMqa5nFkIRAA--.2062S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxJF1xurWkWF1fAFy3GrWrCrX_yoWrCrWrpF
	Wq9r97Krs0qFyfWw1xJ3WYkrW3X3y7Kr1UKryDt34UAr42qr1IgFs7CayUtFyvgwsxXFyI
	qFs2gr4UGF4DZ3gCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUP0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1ln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2
	x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17
	McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7
	I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCF
	x2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWUXVWUAwC20s026c02F40E14v26r
	1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij
	64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr
	0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF
	0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8m9aDUUUUU==

On 02/14/2025 02:54 AM, Josh Poimboeuf wrote:
> On Thu, Feb 13, 2025 at 08:38:22PM +0800, Tiezhu Yang wrote:
>> Based on the above analysis, in order to avoid changing the behavior of
>> GNU assembler and silence the GNU assembler warning, is it possible to
>> rename ".rodata..c_jump_table" to ".c_jump_table"?
>
> Yeah, though for the final vmlinux link we'd still need it to end up in
> .rodata so it remains read-only at runtime.
>
> So we'd basically just have to add it to the RO_DATA() macro in
> include/asm-generic/vmlinux.lds.h.
>
> Does it still work if we call it ..rodata.c_jump_table or so?  Then we
> could just add "*(..rodata.*) to RO_DATA().  That would be somewhat less
> surprising, and would also create a standard way for other code to do
> the same thing by prefixing with "..rodata.".

"..rodata.c_jump_table" works well with GCC and Clang,
there is no assembler warning for GCC and the section
name is normal for Clang.

I have a draft diff, I will do more test and send it
as a formal patch once the other patches are landed
because this patch depends on them.

The code looks something like this:

-- >8 --
diff --git a/include/asm-generic/vmlinux.lds.h 
b/include/asm-generic/vmlinux.lds.h
index 02a4adb4a999..0af80d6627fa 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -457,7 +457,7 @@ defined(CONFIG_AUTOFDO_CLANG) || 
defined(CONFIG_PROPELLER_CLANG)
         . = ALIGN((align));                                             \
         .rodata           : AT(ADDR(.rodata) - LOAD_OFFSET) {           \
                 __start_rodata = .;                                     \
-               *(.rodata) *(.rodata.*)                                 \
+               *(.rodata) *(.rodata.*) *(..rodata.*)                   \
                 SCHED_DATA                                              \
                 RO_AFTER_INIT_DATA      /* Read only after init */      \
                 . = ALIGN(8);                                           \
diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 200fd3c5bc70..9b56788bf3f1 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -110,7 +110,8 @@ void ftrace_likely_update(struct ftrace_likely_data 
*f, int val,
  /* Unreachable code */
  #ifdef CONFIG_OBJTOOL
  /* Annotate a C jump table to allow objtool to follow the code flow */
-#define __annotate_jump_table 
__section(".rodata..c_jump_table,\"a\",@progbits #")
+#define __annotate_jump_table __section("..rodata.c_jump_table")
+#endif
  #else /* !CONFIG_OBJTOOL */
  #define __annotate_jump_table
  #endif /* CONFIG_OBJTOOL */
diff --git a/tools/objtool/arch/loongarch/special.c 
b/tools/objtool/arch/loongarch/special.c
index 27c6473608f3..d3e10ad3a9bf 100644
--- a/tools/objtool/arch/loongarch/special.c
+++ b/tools/objtool/arch/loongarch/special.c
@@ -131,7 +131,7 @@ static struct reloc 
*find_reloc_of_rodata_c_jump_table(struct section *sec,
                 if (reloc_offset(reloc) > offset)
                         break;

-               if (!strncmp(reloc->sym->sec->name, 
".rodata..c_jump_table", 21)) {
+               if (!strncmp(reloc->sym->sec->name, 
"..rodata.c_jump_table", 21)) {
                         *table_size = 0;
                         return reloc;
                 }
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 7174dcb7496e..a8b67b4c5726 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2482,12 +2482,13 @@ static void mark_rodata(struct objtool_file *file)
          *
          * - .rodata: can contain GCC switch tables
          * - .rodata.<func>: same, if -fdata-sections is being used
-        * - .rodata..c_jump_table: contains C annotated jump tables
+        * - ..rodata.c_jump_table: contains C annotated jump tables
          *
          * .rodata.str1.* sections are ignored; they don't contain jump 
tables.
          */
         for_each_sec(file, sec) {
-               if (!strncmp(sec->name, ".rodata", 7) &&
+               if ((!strncmp(sec->name, ".rodata", 7) ||
+                   !strncmp(sec->name, "..rodata", 8)) &&
                     !strstr(sec->name, ".str1.")) {
                         sec->rodata = true;
                         found = true;
diff --git a/tools/objtool/include/objtool/special.h 
b/tools/objtool/include/objtool/special.h
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

Thanks,
Tiezhu


