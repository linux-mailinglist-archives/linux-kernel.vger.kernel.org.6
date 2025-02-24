Return-Path: <linux-kernel+bounces-528021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFCE5A41293
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 02:18:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBFBB16F75B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 01:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 134EB2629F;
	Mon, 24 Feb 2025 01:18:16 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBB0328F1
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 01:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740359895; cv=none; b=QVonLMpXR+IFYJ2CkaEdLx5navvzJSOr5tPJ+PEyAUOrz1Ub9VZY4yvaFkkbGOXVEBk2bZEFCUPki5CMOZzt3jmYl/GwlG0bNP7hZlhYuM/zlqANKkHO/rf24UslOEM3sALon9qWmp/jQHjpEUwUS8ONPTrJi7q0RskeND2NTh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740359895; c=relaxed/simple;
	bh=+01fuoxMsFVszPyqwuMr7Map+WPjyYGMYFouhMVMR3s=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=tUwWmXIowji3enXhJTpDX91xBOxyZ0X9ZomanA5K8w1FqfyfHMsS8q3M0ZYOQcLSxsdZi+jyyBsZ+30cbxHnzFD6OEDu5mSML+UO0Lyt0llvqN0M8/XnVZgNIzP5w6EVz+ODqIAyJ5RQnTkvxvbT8cKJGrH6NdNffg4NqRop9Xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.62])
	by gateway (Coremail) with SMTP id _____8DxWOHLyLtnFkSAAA--.23717S3;
	Mon, 24 Feb 2025 09:18:03 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
	by front1 (Coremail) with SMTP id qMiowMDx_MTJyLtnBXslAA--.5865S3;
	Mon, 24 Feb 2025 09:18:03 +0800 (CST)
Subject: Re: [PATCH] LoongArch: Remove unused option with
 HAVE_VIRT_CPU_ACCOUNTING_GEN
To: Huacai Chen <chenhuacai@kernel.org>
Cc: WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20250221073249.481731-1-maobibo@loongson.cn>
 <CAAhV-H6-cH1a-ghgGAp2aOp8MF09YMwj3bCXESLts==d8_4m3Q@mail.gmail.com>
From: bibo mao <maobibo@loongson.cn>
Message-ID: <2a5a2453-0686-efb2-29aa-065797fa1548@loongson.cn>
Date: Mon, 24 Feb 2025 09:17:26 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAAhV-H6-cH1a-ghgGAp2aOp8MF09YMwj3bCXESLts==d8_4m3Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMDx_MTJyLtnBXslAA--.5865S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxJrWDWrWxCr4UtF1rXrykXrc_yoW8Xw13pr
	n2y3Wqgr48Gr4Fva9YyFyrWw47ZryvqrWxWF1fKFy8tryq9ryDZr1jgr1q9FyUJ395J3yI
	gr1fG34avF45CwbCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
	1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv
	67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
	AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
	F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw
	1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
	xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
	1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8j-
	e5UUUUU==



On 2025/2/21 下午9:42, Huacai Chen wrote:
> Hi, Bibo,
> 
> On Fri, Feb 21, 2025 at 3:32 PM Bibo Mao <maobibo@loongson.cn> wrote:
>>
>> Option HAVE_VIRT_CPU_ACCOUNTING_GEN is selected by default in kconfig file
>> arch/Kconfig. It is meaningless in file arch/loongarch/Kconfig, and on the
>> contrast it may bring out misunderstanding. Here remove it on arch
>> specified kconfig file.
>>
>> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
>> ---
>>   arch/loongarch/Kconfig | 1 -
>>   1 file changed, 1 deletion(-)
>>
>> diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
>> index 2b8bd27a852f..7fd5708fe14a 100644
>> --- a/arch/loongarch/Kconfig
>> +++ b/arch/loongarch/Kconfig
>> @@ -175,7 +175,6 @@ config LOONGARCH
>>          select HAVE_STACKPROTECTOR
>>          select HAVE_SYSCALL_TRACEPOINTS
>>          select HAVE_TIF_NOHZ
>> -       select HAVE_VIRT_CPU_ACCOUNTING_GEN if !SMP
> Please see 01f135506e2ed0403512 ("powerpc/32: select
> HAVE_VIRT_CPU_ACCOUNTING_GEN"). Now HAVE_VIRT_CPU_ACCOUNTING_GEN is
> available on both 32BIT and 64BIT, so I think a better solution is
> unconditionally select HAVE_VIRT_CPU_ACCOUNTING_GEN which is
> convenient for the upcoming LoongArch32.
I have no idea about LoongArch32 which is talked about years, however 
there is never actual code posted and no detailed plan. All about 
LoongArch32 is talking on the paper.

Regards
Bibo Mao
> 
> 
> 
> 
> 
> Huacai
> 
>>          select IRQ_FORCED_THREADING
>>          select IRQ_LOONGARCH_CPU
>>          select LOCK_MM_AND_FIND_VMA
>> --
>> 2.39.3
>>
>>


