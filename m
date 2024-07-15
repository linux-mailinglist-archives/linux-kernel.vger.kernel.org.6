Return-Path: <linux-kernel+bounces-252375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43189931258
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 12:35:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEE8D28280C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 10:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F07FB188CA9;
	Mon, 15 Jul 2024 10:35:11 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FC4E186E43
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 10:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721039711; cv=none; b=nCu/Gqa6xsGYMzXY3SD9TBRkBI6zCj5lbrzVJbJ8AU6VVHIRGRV9OozQI/d+vK0p07pOxp6TfForkZz1ilrADTDX4GseIm4nZNcD9lQ3bZkSu1WaNMv6G3lYmtjMcMw4F+rhK6tdktHkPlt+KRdFdhbjvLGcx+C2I95XnBqE81c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721039711; c=relaxed/simple;
	bh=qPQFGH0u6p+YaPW1ZggzIXA+gPjm7q0KjJ6rAGcHjJA=;
	h=Subject:To:References:Cc:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Nk0bTLVkfJ2GvhVDSMzKxGJ5DDSw/fDBAmw02yx3hmGNCwITo/zlcH09K0DFohj7lcsGM3g1+FGnuhnK43K4ZpHCzm9stWctL5HhnFWIeMsyiZu4VX+sR4kQyYlAq/Jfuo4tVYJlI2SoU1DRPYRlfo2iRXyLcagpeeeZstQ2Dq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8AxDOta+5RmkpIEAA--.12070S3;
	Mon, 15 Jul 2024 18:35:06 +0800 (CST)
Received: from [10.130.0.149] (unknown [113.200.148.30])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8AxhsVZ+5RmUK5JAA--.24677S3;
	Mon, 15 Jul 2024 18:35:05 +0800 (CST)
Subject: Re: [RFC PATCH 4/4] LoongArch: Remove -fno-jump-tables for objtool
To: Xi Ruoyao <xry111@xry111.site>, Josh Poimboeuf <jpoimboe@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Huacai Chen <chenhuacai@kernel.org>
References: <20240712091506.28140-1-yangtiezhu@loongson.cn>
 <20240712091506.28140-5-yangtiezhu@loongson.cn>
 <0adc4126e7fbb8fcf84bae67ebe39ff6da4721cd.camel@xry111.site>
 <ae3ff9787e9d3f41b71e8e4168610a01d5304371.camel@xry111.site>
Cc: loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <8506fd62-5c48-bbfa-d4ec-4ef237cbe5df@loongson.cn>
Date: Mon, 15 Jul 2024 18:35:04 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ae3ff9787e9d3f41b71e8e4168610a01d5304371.camel@xry111.site>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:AQAAf8AxhsVZ+5RmUK5JAA--.24677S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj9xXoW7XrW8Wr17Gw4DGw4fGF17Jwc_yoWkJrbEka
	s5Zr1vk3y5CwsrXFW7WF4DG3y7K3WUK34rJrWUGw13trn0yFZ7Kr4qkw1FvF4xJF1UGFsI
	9F4DuryDKF4I9osvyTuYvTs0mTUanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUbS8YFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1ln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
	xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q
	6rW5McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr4
	1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwCFI7km07C267AKxVWUAVWUtwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4
	vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IY
	x2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26c
	xKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAF
	wI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jz2NtUUUUU=

On 07/13/2024 05:10 PM, Xi Ruoyao wrote:
> On Fri, 2024-07-12 at 17:49 +0800, Xi Ruoyao wrote:
>> On Fri, 2024-07-12 at 17:15 +0800, Tiezhu Yang wrote:
>>> -ifdef CONFIG_OBJTOOL
>>> -KBUILD_CFLAGS			+= -fno-jump-tables
>>> -endif
>>> +KBUILD_AFLAGS			+= $(call cc-option,-mannotate-tablejump) $(call cc-option,-Wa$(comma)-mannotate-tablejump)
>>> +KBUILD_CFLAGS			+= $(call cc-option,-mannotate-tablejump) $(call cc-option,-Wa$(comma)-mannotate-tablejump)
>>
>> KBUILD_AFLAGS isn't needed, and $(call cc-option,-Wa$(comma)-mannotate-
>> tablejump) will always expand to nothing because the assembler does not
>> have -mannotate-tablejump.
>>
>> The assembler never creates a jump table itself.

Thanks, you are right, I will modify it in the formal v1 series.

> BTW have you discussed with Lulu about the -mannotate-tablejump patch?
> I guess maybe an intra-Loongson discussion would be helpful.

Yes, I have discussed with Loongson compiler team some days ago
and will discuss more to reach an agreement in the next few days.

Thanks,
Tiezhu


