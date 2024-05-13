Return-Path: <linux-kernel+bounces-177217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 414AC8C3B87
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 08:42:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB2D3B207CE
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 06:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 769B4146A65;
	Mon, 13 May 2024 06:41:52 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F077A145B1D;
	Mon, 13 May 2024 06:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715582512; cv=none; b=d3MWQVTeyo2I9LWD35irkQMoHb34I9Pu95caplF423w5PuJ3gk63Wi4Iwd+MwJ8WW6EZ8AIEX6rAN3wImVYFmQ9nnMIHXhTgXw7FuzRzFaIckxyXSY+5MdsK8AHTKRvCDgj5Y8hkG1m5xMHaIPOcU+y6QP2RsV3PlP5s0E6jbl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715582512; c=relaxed/simple;
	bh=9CNcVsx6GH8f9RXjua1bE7voMwh312ilPJJw8WrRdxU=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=oa43Zli0lwDQArLBX86d5q1TJhHwEZkNh3UkcsUay4GZFkdfJoikr4duzAEiLCGD4H8naGE8Oox1wny7f1DjQ2Clhh6ZSGuB+UNu8HKyuiLutK5Q3LUPY1W2MnqO7/Ko0atOEXfkxx4+YCT6+P/Sy873aOIhJ49Ox1Akqq2URYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.24])
	by gateway (Coremail) with SMTP id _____8AxY+oqtkFm_xIMAA--.17447S3;
	Mon, 13 May 2024 14:41:46 +0800 (CST)
Received: from [10.20.42.24] (unknown [10.20.42.24])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8DxXN4ptkFmoqMcAA--.51510S3;
	Mon, 13 May 2024 14:41:45 +0800 (CST)
Subject: Re: [PATCH 2/2] Loongarch:Support loongarch avec
To: Xi Ruoyao <xry111@xry111.site>, chenhuacai@kernel.org, kernel@xen0n.name,
 tglx@linutronix.de, jiaxun.yang@flygoat.com, gaoliang@loongson.cn,
 wangliupu@loongson.cn, lvjianmin@loongson.cn, yijun@loongson.cn,
 mhocko@suse.com, akpm@linux-foundation.org, dianders@chromium.org,
 maobibo@loongson.cn, zhaotianrui@loongson.cn, nathan@kernel.org,
 yangtiezhu@loongson.cn, zhoubinbin@loongson.cn
Cc: loongarch@lists.linux.dev, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240507125953.9117-1-zhangtianyang@loongson.cn>
 <a0a896fef1aca8958a190801ab5355e22373081d.camel@xry111.site>
From: Tianyang Zhang <zhangtianyang@loongson.cn>
Message-ID: <b38caf8e-b817-7ea2-50e3-eef78909b642@loongson.cn>
Date: Mon, 13 May 2024 14:41:45 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <a0a896fef1aca8958a190801ab5355e22373081d.camel@xry111.site>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:AQAAf8DxXN4ptkFmoqMcAA--.51510S3
X-CM-SenderInfo: x2kd0wxwld05hdqjqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29K
	BjDU0xBIdaVrnRJUUUm0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26c
	xKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vE
	j48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxV
	AFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44
	I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2
	jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62
	AI1cAE67vIY487MxAIw28IcxkI7VAKI48JMxAqzxv262kKe7AKxVWUAVWUtwCF54CYxVCY
	1x0262kKe7AKxVWUAVWUtwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWUAV
	WUtwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF
	1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6x
	IIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvE
	x4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvj
	DU0xZFpf9x07josjUUUUUU=


在 2024/5/7 下午10:20, Xi Ruoyao 写道:
> On Tue, 2024-05-07 at 20:59 +0800, Tianyang Zhang wrote:
>> +static inline void loongarch_avec_ack_irq(struct irq_data *d)
>> +{
>> +}
>> +
>> +static inline void loongarch_avec_unmask_irq(struct irq_data *d)
>> +{
>> +}
>> +
>> +static inline void loongarch_avec_mask_irq(struct irq_data *d)
>> +{
>> +}
> "inline" has no use here because these functions are only called via
> function pointers, thus such calls cannot be inline-able.  I'd suggest
> to remove "inline" for them.
>
Thank you for your feedback. I will make the necessary changes here


