Return-Path: <linux-kernel+bounces-512922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1450FA33F4C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 13:38:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB7BF7A29C6
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 12:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EB84221563;
	Thu, 13 Feb 2025 12:38:32 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59E7720C48E
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 12:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739450311; cv=none; b=bUoZBbC8MzdI+79INZMsdXhO/QKFkpC9OPwvfCaLvOSgmkJGh2oBJlm1UfcdxOLZ4XJO3rGC2ssRW0wpuiEZBzMj1wWjjdJtXmDPv5YfmR6ezj2be13m6OiD6GWFiAbSPUSCiOypViSllfYbbVcSIMx32e3OVIWQHHhAuqBo550=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739450311; c=relaxed/simple;
	bh=o0LpgFDNpDUZNib8tQhCPESwGWjJy7YNbOMkCSYDmug=;
	h=Subject:To:References:Cc:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=FWEEtuDt+C2uQKW+aH9HnDQ1DECoOxL9xoMyc9kW8MQawbf5QmSxzdut+4nUeu6b6JZ999KWrIUrSrnGaMWUv6CtB4z/e/RQTWeFnJplgBhRyGzNdhU1j20YPpzojIPlSJbrvamFcTmElh/A+RHQyJpludUMSzDCdzzn7sbQ7z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8CxLGvA561nHih0AA--.5239S3;
	Thu, 13 Feb 2025 20:38:24 +0800 (CST)
Received: from [10.130.0.149] (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowMCx_ca+561nef0PAA--.63106S3;
	Thu, 13 Feb 2025 20:38:22 +0800 (CST)
Subject: Re: [PATCH] compiler.h: Specify correct attribute for
 .rodata..c_jump_table
To: Josh Poimboeuf <jpoimboe@kernel.org>
References: <20240924062710.1243-1-yangtiezhu@loongson.cn>
 <20250212175023.rsxsw7pno57gsxps@jpoimboe>
 <b1e5e3ea-be4b-5dae-cc0d-34693429d060@loongson.cn>
 <20250213023936.lzbpgou4eallaij3@jpoimboe>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, loongarch@lists.linux.dev,
 linux-kernel@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>,
 llvm@lists.linux.dev
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <045d7e22-672c-b9da-38d6-8897e854f262@loongson.cn>
Date: Thu, 13 Feb 2025 20:38:22 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250213023936.lzbpgou4eallaij3@jpoimboe>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:qMiowMCx_ca+561nef0PAA--.63106S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW3Aw1rJFykZr1kWr1kWFWfJFc_yoWxZF17pr
	yUKFyUKrs5AF15Ca1xKr1Ygr1UtrsrAFy8XF1UJr4UAw15WF1ktF1xtrsrtryDGrn5Xr1Y
	y39rtw17KFWDAabCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUPYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1ln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2
	x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1D
	McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7
	I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCF
	x2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWUXVWUAwC20s026c02F40E14v26r
	1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij
	64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr
	0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF
	0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jzE_NUUUUU=

On 02/13/2025 10:39 AM, Josh Poimboeuf wrote:
> On Thu, Feb 13, 2025 at 10:20:40AM +0800, Tiezhu Yang wrote:
>> On 02/13/2025 01:50 AM, Josh Poimboeuf wrote:
>>>> @@ -133,7 +133,7 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
>>>>  #define annotate_unreachable() __annotate_unreachable(__COUNTER__)
>>>>
>>>>  /* Annotate a C jump table to allow objtool to follow the code flow */
>>>> -#define __annotate_jump_table __section(".rodata..c_jump_table")
>>>> +#define __annotate_jump_table __section(".rodata..c_jump_table,\"a\",@progbits #")
>>>
>>> This caused a regression, this hack apparently doesn't work with Clang:
>>>
>>>   $ readelf -WS kernel/bpf/core.o | grep c_jump_table
>>>     [43] .rodata..c_jump_table,"a",@progbits # PROGBITS        0000000000000000 00d610 000800 00   A  0   0 16
>>>
>>> Notice the section name is literally:
>>>
>>>   .rodata..c_jump_table,"a",@progbits #
>>
>> Yes, I noticed this section name which contains the original name
>> ".rodata..c_jump_table" and the specified attribute compiled with
>> Clang, it should not contain the specified attribute.
>>
>> That is strange but seems no effect due to only compare the first
>> few letters of the section name in objtool.
>
> It actually does have an effect -- objtool doesn't recognize the BPF C
> jump table (see the use of C_JUMP_TABLE_SECTION in
> tools/objtool/arch/x86/special.c), resulting in a bogus warning and
> missing ORC.
>
> I do have a workaround to use strstarts() instead of strcmp(), I'll be
> posting that soon.
>
>> I will keep digging with the GNU and LLVM compiler developers.

Specify the attribute like ".rodata..c_jump_table,\"a\",@progbits #"
explicitly works for GNU toolchains, but this hack apparently doesn't
work with Clang, the generated section name is wrong, resulting in a
bogus warning and missing ORC for x86. This is because there is only
one arg for section name in LLVM, even if the so called attribute is
specified, it will be recognized as a whole for section name, so it
is not proper to specify the readonly attribute for the section.

In the top Makefile, there is "-fno-PIE" build flag. For x86, there
is no "-fPIE" build flag in arch/x86/Makefile for 64 bit kernel. But
for LoongArch, there is "-fPIE" build flag in arch/loongarch/Makefile
to override "-fno-PIE" in top Makefile. After some test with GCC and
Clang on x86 and LoongArch, it shows that the generated "W" (writable)
section attribute of the section ".rodata..c_jump_table" is depent on
the compiler option "-fPIE", and then lead to the assembler warning:
"setting incorrect section attributes for .rodata..c_jump_table".

Note that when running the following steps, x86 and LoongArch have the
same result. If compiled with GCC -fPIE, there is assembler warning for
x86 and LoongArch; if compiled with Clang -fPIE, there is no assembler
warning for x86 and LoongArch.

If just drop the prefix ".rodata" of the section name, that is to say,
rename ".rodata..c_jump_table" to ".c_jump_table", there is no assembler
warning for x86 and LoongArch.

Based on the above analysis, in order to avoid changing the behavior of
GNU assembler and silence the GNU assembler warning, is it possible to
rename ".rodata..c_jump_table" to ".c_jump_table"? Or should it do some
changes for GNU assembler?

https://sourceware.org/git/?p=binutils-gdb.git;a=blob;f=gas/config/obj-elf.c;hb=HEAD#l741
               if (match_p->group_name == NULL)
                 as_warn (_("setting incorrect section attributes for %s"),
                          name);

(1) Here is the simple test code with the original section name:

$ cat test.c
#define __annotate_jump_table 
__attribute__((__section__(".rodata..c_jump_table")))

int main()
{
	static const void * const jumptable[256] __annotate_jump_table = {
		[0 ... 255] = &&default_label,
	};

default_label:
	return 0;
}

(2) Here is the build script:

$ cat build.sh
#!/bin/bash

uname -m
echo ""

rm -f *gcc* *clang*

echo "test with gcc fpie"
gcc -fPIE -E test.c -o test_with_gcc_fpie.i
gcc -fPIE -S test_with_gcc_fpie.i -o test_with_gcc_fpie.s
gcc -fPIE -c test_with_gcc_fpie.s -o test_with_gcc_fpie.o
readelf -S test_with_gcc_fpie.o | grep -A 1 "c_j" | head -2
echo ""

echo "test with gcc fnopie"
gcc -fno-PIE -E test.c -o test_with_gcc_fnopie.i
gcc -fno-PIE -S test_with_gcc_fnopie.i -o test_with_gcc_fnopie.s
gcc -fno-PIE -c test_with_gcc_fnopie.s -o test_with_gcc_fnopie.o
readelf -S test_with_gcc_fnopie.o | grep -A 1 "c_j" | head -2
echo ""

echo "test with clang fpie"
clang -fPIE -E test.c -o test_with_clang_fpie.i
clang -fPIE -S test_with_clang_fpie.i -o test_with_clang_fpie.s
clang -fPIE -c test_with_clang_fpie.s -o test_with_clang_fpie.o
readelf -S test_with_clang_fpie.o | grep -A 1 "c_j" | head -2
echo ""

echo "test with clang fnopie"
clang -fno-PIE -E test.c -o test_with_clang_fnopie.i
clang -fno-PIE -S test_with_clang_fnopie.i -o test_with_clang_fnopie.s
clang -fno-PIE -c test_with_clang_fnopie.s -o test_with_clang_fnopie.o
readelf -S test_with_clang_fnopie.o | grep -A 1 "c_j" | head -2

(3) Here is the test result with the original section name:

$ ./build.sh
x86_64

test with gcc fpie
test_with_gcc_fpie.s: Assembler messages:
test_with_gcc_fpie.s:3: Warning: setting incorrect section attributes 
for .rodata..c_jump_table
   [ 4] .rodata..c_j[...] PROGBITS         0000000000000000  00000060
        0000000000000800  0000000000000000  WA       0     0     32

test with gcc fnopie
   [ 4] .rodata..c_j[...] PROGBITS         0000000000000000  00000060
        0000000000000800  0000000000000000   A       0     0     32

test with clang fpie
   [ 3] .rodata..c_j[...] PROGBITS         0000000000000000  00000050
        0000000000000800  0000000000000000  WA       0     0     16

test with clang fnopie
   [ 3] .rodata..c_j[...] PROGBITS         0000000000000000  00000050
        0000000000000800  0000000000000000   A       0     0     16

(4) Here is the simple test code with the modified section name:

$ cat test.c
#define __annotate_jump_table  __attribute__((__section__(".c_jump_table")))

int main()
{
	static const void * const jumptable[256] __annotate_jump_table = {
		[0 ... 255] = &&default_label,
	};

default_label:
	return 0;
}

(5) Here is the test result with the modified section name:
     (note that build.sh is not changed)

$ ./build.sh
x86_64

test with gcc fpie
   [ 4] .c_jump_table     PROGBITS         0000000000000000  00000060
        0000000000000800  0000000000000000  WA       0     0     32

test with gcc fnopie
   [ 4] .c_jump_table     PROGBITS         0000000000000000  00000060
        0000000000000800  0000000000000000   A       0     0     32

test with clang fpie
   [ 3] .c_jump_table     PROGBITS         0000000000000000  00000050
        0000000000000800  0000000000000000  WA       0     0     16

test with clang fnopie
   [ 3] .c_jump_table     PROGBITS         0000000000000000  00000050
        0000000000000800  0000000000000000   A       0     0     16

Thanks,
Tiezhu


