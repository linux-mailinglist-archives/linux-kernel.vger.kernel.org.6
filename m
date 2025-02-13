Return-Path: <linux-kernel+bounces-512193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A916A33573
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 03:20:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C60BD164698
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 02:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55BF91FC0F9;
	Thu, 13 Feb 2025 02:20:53 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C582433AD
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 02:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739413252; cv=none; b=nPI/7TFN1B8Iesa56d0YvinXbhSVnegzxoXP186e+istdIRPhbg2BtegCyoifxGRtEPWe+4QndSNf5RclW7QPQH1SvU0s0J74Sg6G6OKqh6rWmJPgu8C1Sbojp2XfSvY/A0pBHwf4FWkkgsAsUUh0OCByMGH5178T4va1IFKaPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739413252; c=relaxed/simple;
	bh=7yOfSs4iMJZzUnntYhUmEAQd0afxVo7w4k64T6PK0LA=;
	h=Subject:To:References:Cc:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=HU3lHJid0oTyaLp8dR/oY7jeJByvf5PAOoa41gQ+XWapX42ofJ9Q3jRkPEv8JbxBa8bRicxLGcLASTTbIzoq0N+/Sr7J8Y7cTEx88b5FiqEoiPFwCZddMlZe74aEuDCtrweYcBg7tyeMtrVzKGk0gGNgj+G0m42dQkkSgUhYSoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8AxHHL+Vq1nN7tzAA--.4745S3;
	Thu, 13 Feb 2025 10:20:46 +0800 (CST)
Received: from [10.130.0.149] (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowMCxPsf4Vq1nrhAPAA--.59606S3;
	Thu, 13 Feb 2025 10:20:41 +0800 (CST)
Subject: Re: [PATCH] compiler.h: Specify correct attribute for
 .rodata..c_jump_table
To: Josh Poimboeuf <jpoimboe@kernel.org>
References: <20240924062710.1243-1-yangtiezhu@loongson.cn>
 <20250212175023.rsxsw7pno57gsxps@jpoimboe>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, loongarch@lists.linux.dev,
 linux-kernel@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>,
 llvm@lists.linux.dev
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <b1e5e3ea-be4b-5dae-cc0d-34693429d060@loongson.cn>
Date: Thu, 13 Feb 2025 10:20:40 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250212175023.rsxsw7pno57gsxps@jpoimboe>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:qMiowMCxPsf4Vq1nrhAPAA--.59606S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxGFykGFWrWF4fArWfGF47WrX_yoW5uw1fpr
	WDCFyqgFs5Zr1Y9a12qw1akr17tw42yF18WrWDKryjyw15Xr1vgF1ktrsxKayDKr1UJw10
	qw4Iqry5Ka4UZ3gCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUP0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
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

On 02/13/2025 01:50 AM, Josh Poimboeuf wrote:
> On Tue, Sep 24, 2024 at 02:27:10PM +0800, Tiezhu Yang wrote:
>> Currently, there is an assembler message when generating kernel/bpf/core.o
>> under CONFIG_OBJTOOL with LoongArch compiler toolchain:
>>
>>   Warning: setting incorrect section attributes for .rodata..c_jump_table
>>
>> This is because the section ".rodata..c_jump_table" should be readonly,
>> but there is a "W" (writable) part of the flags:
>>
>>   $ readelf -S kernel/bpf/core.o | grep -A 1 "rodata..c"
>>   [34] .rodata..c_j[...] PROGBITS         0000000000000000  0000d2e0
>>        0000000000000800  0000000000000000  WA       0     0     8
>>
>> There is no above issue on x86 due to the generated section flag is only
>> "A" (allocatable). In order to silence the warning on LoongArch, specify
>> the attribute like ".rodata..c_jump_table,\"a\",@progbits #" explicitly,
>> then the section attribute of ".rodata..c_jump_table" must be readonly
>> in the kernel/bpf/core.o file.
>>
>> Before:
>>
>>   $ objdump -h kernel/bpf/core.o | grep -A 1 "rodata..c"
>>    21 .rodata..c_jump_table 00000800  0000000000000000  0000000000000000  0000d2e0  2**3
>>                   CONTENTS, ALLOC, LOAD, RELOC, DATA
>>
>> After:
>>
>>   $ objdump -h kernel/bpf/core.o | grep -A 1 "rodata..c"
>>    21 .rodata..c_jump_table 00000800  0000000000000000  0000000000000000  0000d2e0  2**3
>>                   CONTENTS, ALLOC, LOAD, RELOC, READONLY, DATA
>>
>> By the way, AFAICT, maybe the root cause is related with the different
>> compiler behavior of various archs, so to some extent this change is a
>> workaround for LoongArch, and also there is no effect for x86 which is
>> the only port supported by objtool before LoongArch with this patch.
>
> Right, this sounds like a bug in the GNU assembler.  It should default
> to the same section flags regardless of arch.

I agree with you.

>
>>
>> Cc: stable@vger.kernel.org # 6.9+
>> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
>> ---
>>  include/linux/compiler.h | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/include/linux/compiler.h b/include/linux/compiler.h
>> index ec55bcce4146..4d4e23b6e3e7 100644
>> --- a/include/linux/compiler.h
>> +++ b/include/linux/compiler.h
>> @@ -133,7 +133,7 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
>>  #define annotate_unreachable() __annotate_unreachable(__COUNTER__)
>>
>>  /* Annotate a C jump table to allow objtool to follow the code flow */
>> -#define __annotate_jump_table __section(".rodata..c_jump_table")
>> +#define __annotate_jump_table __section(".rodata..c_jump_table,\"a\",@progbits #")
>
> This caused a regression, this hack apparently doesn't work with Clang:
>
>   $ readelf -WS kernel/bpf/core.o | grep c_jump_table
>     [43] .rodata..c_jump_table,"a",@progbits # PROGBITS        0000000000000000 00d610 000800 00   A  0   0 16
>
> Notice the section name is literally:
>
>   .rodata..c_jump_table,"a",@progbits #

Yes, I noticed this section name which contains the original name
".rodata..c_jump_table" and the specified attribute compiled with
Clang, it should not contain the specified attribute.

That is strange but seems no effect due to only compare the first
few letters of the section name in objtool.

I will keep digging with the GNU and LLVM compiler developers.

Thanks,
Tiezhu


