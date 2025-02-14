Return-Path: <linux-kernel+bounces-514631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6679CA35981
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 09:57:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BC293AD64D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 08:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16AB722A80F;
	Fri, 14 Feb 2025 08:56:53 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F63022A4D2
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 08:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739523412; cv=none; b=dkwIayAEv3JFWCNUzns1ifebpcDxVyRWia5cDWLFUJW3zE/bKzHCZSxj+O4Bv2528wftuKRvWkJ2U8MgfLQxtoBkpSCh9dzr92dDrdw0ue2HNipUiQxBwgzv3uFGzAqHmFLIqYSn/K6XpiLDfU3wP+yrFpdsW/WVCzGY6HoK2FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739523412; c=relaxed/simple;
	bh=BS5VTSANEuMoikRIGcCI8M1TbLeytLcfc+uSnp/pT58=;
	h=Subject:To:References:Cc:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=jV6gyojKTjqu1lGww2VdvNMLjvzwyvx4GB+HMWnvoWDHgsslWzSeAGRQx2e1MIjjVU2utSizJPq+uHBXCgB+LU6fgB0L8PeeCGgGhhegI7gjRo3TeqQnTuD5x9EiRsv8s5eSY/C3JkFktnx9YBxmfyQaWbwPNYviSCBbZ524srk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8BxjaxJBa9n_TN1AA--.39903S3;
	Fri, 14 Feb 2025 16:56:41 +0800 (CST)
Received: from [10.130.0.149] (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowMBx3MRGBa9nmNARAA--.835S3;
	Fri, 14 Feb 2025 16:56:39 +0800 (CST)
Subject: Re: [PATCH] compiler.h: Specify correct attribute for
 .rodata..c_jump_table
To: Josh Poimboeuf <jpoimboe@kernel.org>
References: <20240924062710.1243-1-yangtiezhu@loongson.cn>
 <20250212175023.rsxsw7pno57gsxps@jpoimboe>
 <b1e5e3ea-be4b-5dae-cc0d-34693429d060@loongson.cn>
 <20250213023936.lzbpgou4eallaij3@jpoimboe>
 <045d7e22-672c-b9da-38d6-8897e854f262@loongson.cn>
 <20250213185408.m5aogf2trvhvi2td@jpoimboe>
 <439175dc-caf0-3d38-89ba-ade5a364c9bb@loongson.cn>
 <20250214084415.yrffvbop2f6z3du3@jpoimboe>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, loongarch@lists.linux.dev,
 linux-kernel@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>,
 llvm@lists.linux.dev
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <f4f6d6ef-28cd-922d-fa24-6dd451b44607@loongson.cn>
Date: Fri, 14 Feb 2025 16:56:38 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250214084415.yrffvbop2f6z3du3@jpoimboe>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:qMiowMBx3MRGBa9nmNARAA--.835S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7uFWxXw4UJry7GF15JF1UJwc_yoW8Jw48pa
	nrA3s3Kr4UXF93tanFq3WjgrW7J347tr92qFy3KrykArsFqryFkr4fAayjva47XwnxKFWI
	qF4Sqw4rZF4DZ3gCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1ln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2
	x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17
	McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7
	I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8
	JwCFI7km07C267AKxVWUAVWUtwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14
	v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY
	67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2
	IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jepB-UUUUU=

On 02/14/2025 04:44 PM, Josh Poimboeuf wrote:
> On Fri, Feb 14, 2025 at 10:23:08AM +0800, Tiezhu Yang wrote:
>> I have a draft diff, I will do more test and send it
>> as a formal patch once the other patches are landed
>> because this patch depends on them.
>
> Actually since this is a bug fix, I'm thinking it should be merged in
> the tip/objtool/urgent branch so it can go in an -rc.  Then it should be
> trivial for me to rebase your patches on top.

OK, I will send a patch based on tip/objtool/urgent branch ASAP.

>> The code looks something like this:
>
> Looks good to me.  nit: loongarch can use the C_JUMP_TABLE_SECTION
> define.

Yes, thank you, hope you can amend it when applying my original patch,
maybe like this:

diff --git a/tools/objtool/arch/loongarch/special.c 
b/tools/objtool/arch/loongarch/special.c
index 27c6473608f3..e39f86d97002 100644
--- a/tools/objtool/arch/loongarch/special.c
+++ b/tools/objtool/arch/loongarch/special.c
@@ -131,7 +131,7 @@ static struct reloc 
*find_reloc_of_rodata_c_jump_table(struct section *sec,
                 if (reloc_offset(reloc) > offset)
                         break;

-               if (!strncmp(reloc->sym->sec->name, 
".rodata..c_jump_table", 21)) {
+               if (!strcmp(reloc->sym->sec->name, C_JUMP_TABLE_SECTION)) {
                         *table_size = 0;
                         return reloc;
                 }

Thanks,
Tiezhu


