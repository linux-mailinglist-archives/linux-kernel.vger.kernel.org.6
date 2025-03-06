Return-Path: <linux-kernel+bounces-548124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C0E4A54052
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 03:09:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE8073AAFD3
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 02:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A643418DB2C;
	Thu,  6 Mar 2025 02:09:53 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AE2D11713;
	Thu,  6 Mar 2025 02:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741226993; cv=none; b=T6+YJd1jxyrfMFz9BSx1Wm3Ym9CaHgTHij6Z80TiKjkmtbnC1CDb8iultIrjPO27hIgGmmP118ikkmCooreukF3//x7QGiVlMQHHbJcLxBQISc1tPH8b9aL7vnQjs4hV4Je9lSRkFH1OAK7OsIr84wF/DOmXFDeIIILUiS8n+HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741226993; c=relaxed/simple;
	bh=ZrS2fjqKDvivcPGXCgJZ99ad6eZDInBjzV7CgtGYgi4=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=iNyIr/7tSeEDpOhqB7Zwyrxyn2wL86vH5nvzO8TwkQzjlIHT0Uq0wyPtrvqHStn37cwCRiWkl/vIkLyNX0dOVph4wpTeyyi76OR5Y1f59rXJ/b3DzG0wAux8Tnc0CHTU+JuD5OrywJhkwEd7KuBew7vE4iR9Is087akrZIMxwk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.24])
	by gateway (Coremail) with SMTP id _____8DxdWnsA8lnmciLAA--.42734S3;
	Thu, 06 Mar 2025 10:09:48 +0800 (CST)
Received: from [10.20.42.24] (unknown [10.20.42.24])
	by front1 (Coremail) with SMTP id qMiowMBx3MTmA8lnbZ44AA--.11747S3;
	Thu, 06 Mar 2025 10:09:45 +0800 (CST)
Subject: Re: [PATCH 1/2] Docs/LoongArch: Add Advanced Extended-Redirect IRQ
 model description
To: Huacai Chen <chenhuacai@kernel.org>
Cc: kernel@xen0n.name, corbet@lwn.net, alexs@kernel.org,
 si.yanteng@linux.dev, tglx@linutronix.de, jiaxun.yang@flygoat.com,
 peterz@infradead.org, wangliupu@loongson.cn, lvjianmin@loongson.cn,
 maobibo@loongson.cn, siyanteng@cqsoftware.com.cn, gaosong@loongson.cn,
 yangtiezhu@loongson.cn, loongarch@lists.linux.dev,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250303101533.31462-1-zhangtianyang@loongson.cn>
 <20250303101533.31462-2-zhangtianyang@loongson.cn>
 <CAAhV-H5xx7UnM1PpwDEJoq8kw6=uyzuhCiNbokF8tYNx7F1Jeg@mail.gmail.com>
From: Tianyang Zhang <zhangtianyang@loongson.cn>
Message-ID: <4c3d48f9-aa96-4ee9-4718-d4b87fd441a5@loongson.cn>
Date: Thu, 6 Mar 2025 10:09:23 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAAhV-H5xx7UnM1PpwDEJoq8kw6=uyzuhCiNbokF8tYNx7F1Jeg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:qMiowMBx3MTmA8lnbZ44AA--.11747S3
X-CM-SenderInfo: x2kd0wxwld05hdqjqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxJw4UAr1xXF13XF45Zr18WFX_yoWruF4Dpr
	Z3GF93ZF4UJ345WF17Jr4UXr13Jw1fKa1DKF1xKry8Xw1qyr1DJr1UJrykXFW7GryrAr12
	qFW5Gw1DAr1UA3gCm3ZEXasCq-sJn29KB7ZKAUJUUUUf529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUPYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1ln4kS14v26r126r1DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2
	x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q6rW5
	McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7
	I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCF
	x2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWUAVWUtwC20s026c02F40E14v26r
	1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij
	64vIr41lIxAIcVC0I7IYx2IY67AKxVW5JVW7JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr
	0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF
	0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jz5lbUUUUU=

Hi, Huacai

在 2025/3/3 下午9:36, Huacai Chen 写道:
> Hi, Tianyang,
>
> On Mon, Mar 3, 2025 at 6:15 PM Tianyang Zhang <zhangtianyang@loongson.cn> wrote:
>> Introduce the Redirect interrupt controllers.When the redirected interrupt
>> controller is enabled, the routing target of MSI interrupts is no longer a
>> specific CPU and vector number, but a specific redirected entry. The actual
>> CPU and vector number used are described by the redirected entry.
> You call it "redirect interrupt controller", then don't call
> "redirected interrupt controller" in other place.
OK, I got it
>
>> Signed-off-by: Tianyang Zhang <zhangtianyang@loongson.cn>
>> ---
>>   .../arch/loongarch/irq-chip-model.rst         | 38 +++++++++++++++++++
>>   .../zh_CN/arch/loongarch/irq-chip-model.rst   | 37 ++++++++++++++++++
>>   2 files changed, 75 insertions(+)
>>
>> diff --git a/Documentation/arch/loongarch/irq-chip-model.rst b/Documentation/arch/loongarch/irq-chip-model.rst
>> index a7ecce11e445..45cba22ff181 100644
>> --- a/Documentation/arch/loongarch/irq-chip-model.rst
>> +++ b/Documentation/arch/loongarch/irq-chip-model.rst
>> @@ -181,6 +181,44 @@ go to PCH-PIC/PCH-LPC and gathered by EIOINTC, and then go to CPUINTC directly::
>>                | Devices |
>>                +---------+
>>
>> +Advanced Extended-Redirect IRQ model
> Call it as "Advanced Extended IRQ model (with redirection)" and
> "高级扩展IRQ模型 (带重定向)"
OK, I got it , thanks
>
> Huacai
>
>> +===============
>> +
>> +In this model, IPI (Inter-Processor Interrupt) and CPU Local Timer interrupt go
>> +to CPUINTC directly, CPU UARTS interrupts go to LIOINTC, PCH-MSI interrupts go
>> +to REDIRECT for remapping it to AVEC, and then go to CPUINTC directly, while all
>> +other devices interrupts go to PCH-PIC/PCH-LPC and gathered by EIOINTC, and then
>> +go to CPUINTC directly::
>> +
>> + +-----+     +-----------------------+     +-------+
>> + | IPI | --> |        CPUINTC        | <-- | Timer |
>> + +-----+     +-----------------------+     +-------+
>> +              ^          ^          ^
>> +              |          |          |
>> +       +---------+ +----------+ +---------+     +-------+
>> +       | EIOINTC | | AVECINTC | | LIOINTC | <-- | UARTs |
>> +       +---------+ +----------+ +---------+     +-------+
>> +            ^            ^
>> +            |            |
>> +            |      +----------+
>> +            |      | REDIRECT |
>> +            |      +----------+
>> +            |            ^
>> +            |            |
>> +       +---------+  +---------+
>> +       | PCH-PIC |  | PCH-MSI |
>> +       +---------+  +---------+
>> +         ^     ^           ^
>> +         |     |           |
>> + +---------+ +---------+ +---------+
>> + | Devices | | PCH-LPC | | Devices |
>> + +---------+ +---------+ +---------+
>> +                  ^
>> +                  |
>> +             +---------+
>> +             | Devices |
>> +             +---------+
>> +
>>   ACPI-related definitions
>>   ========================
>>
>> diff --git a/Documentation/translations/zh_CN/arch/loongarch/irq-chip-model.rst b/Documentation/translations/zh_CN/arch/loongarch/irq-chip-model.rst
>> index d4ff80de47b6..d935da47ce3b 100644
>> --- a/Documentation/translations/zh_CN/arch/loongarch/irq-chip-model.rst
>> +++ b/Documentation/translations/zh_CN/arch/loongarch/irq-chip-model.rst
>> @@ -174,6 +174,43 @@ CPU串口（UARTs）中断发送到LIOINTC，PCH-MSI中断发送到AVECINTC，
>>                | Devices |
>>                +---------+
>>
>> +高级扩展-重定向IRQ模型
>> +===============
>> +
>> +在这种模型里面，IPI（Inter-Processor Interrupt）和CPU本地时钟中断直接发送到CPUINTC，
>> +CPU串口（UARTs）中断发送到LIOINTC，PCH-MSI中断首先发送到REDIRECT模块,完成重定向后发
>> +送到AVECINTC，而后通过AVECINTC直接送达CPUINTC，而其他所有设备的中断则分别发送到所连
>> +接的PCH-PIC/PCH-LPC，然后由EIOINTC统一收集，再直接到达CPUINTC::
>> +
>> + +-----+     +----------------------Thomas-+     +-------+
>> + | IPI | --> |        CPUINTC        | <-- | Timer |
>> + +-----+     +-----------------------+     +-------+
>> +              ^          ^          ^
>> +              |          |          |
>> +       +---------+ +----------+ +---------+     +-------+
>> +       | EIOINTC | | AVECINTC | | LIOINTC | <-- | UARTs |
>> +       +---------+ +----------+ +---------+     +-------+
>> +            ^            ^
>> +            |            |
>> +            |      +----------+
>> +            |      | REDIRECT |
>> +            |      +----------+
>> +            |            ^
>> +            |            |
>> +       +---------+  +---------+
>> +       | PCH-PIC |  | PCH-MSI |
>> +       +---------+  +---------+
>> +         ^     ^           ^
>> +         |     |           |
>> + +---------+ +---------+ +---------+
>> + | Devices | | PCH-LPC | | Devices |
>> + +---------+ +---------+ +---------+
>> +                  ^
>> +                  |
>> +             +---------+
>> +             | Devices |
>> +             +---------+
>> +
>>   ACPI相关的定义
>>   ==============
>>
>> --
>> 2.43.0
>>
>>


