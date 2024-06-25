Return-Path: <linux-kernel+bounces-228305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1998915DE0
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 07:00:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D292283E9C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 05:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C293C14389D;
	Tue, 25 Jun 2024 05:00:13 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75BF71428FA
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 05:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719291613; cv=none; b=j4h/mNsSVbYYOaN/mpv4Y+LSATgNIg6wMgGxUDls4z4FEc57gxWlmaqT2pVjNl/w23bV/eMonfOXLn1uWvF82S8OJ2gH+4UyJMkX+DlL9EwV4jhv3KQafl641LjdHRHD94nQhxzN/Vuxjrf3QdZZQRZ/7O7r/vbwjT2wbD5MKkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719291613; c=relaxed/simple;
	bh=cqskFif9wifooZyCCXSZIdmTNWOCNUjY/g4WRpmUwu8=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=BqrjrUXTQ4ylQhdnOV/cBnb8xYQ/cbMPiWBHMvy9j5DL2xjZ3E+4HYGiEbh5aqxK0vfVmVoRs7M4Jo3RXCfM9p/Zrxiw4LH7p3++O+o2qDZWXNCc3W4JQhoP2Pougfap05QYo8lfl0E6ysmha2oeKdCRnyg1qz0rnqRpaoGgy68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.24])
	by gateway (Coremail) with SMTP id _____8AxHuvYTnpmKsEJAA--.39374S3;
	Tue, 25 Jun 2024 13:00:08 +0800 (CST)
Received: from [10.20.42.24] (unknown [10.20.42.24])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8AxDMfTTnpmtxcwAA--.49065S3;
	Tue, 25 Jun 2024 13:00:05 +0800 (CST)
Subject: Re: [tip:irq/core 39/46] drivers/irqchip/irq-loongarch-avec.c:82:17:
 error: implicit declaration of function 'loongson_send_ipi_single'
To: Thomas Gleixner <tglx@linutronix.de>, kernel test robot <lkp@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
 x86@kernel.org, Jianmin Lv <lvjianmin@loongson.cn>,
 Liupu Wang <wangliupu@loongson.cn>
References: <202406240451.ygBFNyJ3-lkp@intel.com> <87sex28nef.ffs@tglx>
From: Tianyang Zhang <zhangtianyang@loongson.cn>
Message-ID: <d1c1bac7-7421-8e17-a364-dc44e77f4315@loongson.cn>
Date: Tue, 25 Jun 2024 13:00:03 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <87sex28nef.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:AQAAf8AxDMfTTnpmtxcwAA--.49065S3
X-CM-SenderInfo: x2kd0wxwld05hdqjqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxJF4ftw4xZr1fKr1rCw47Jrc_yoW5Gr1Dpa
	yUZas0krWrJr18t3srK345ZFyjyayfK342ka97Jw1xurWUAr97WF4SyFZ0gF1xZws7Kw42
	9r12qFyYvF1UAagCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	XVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI4
	8JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
	Jr0_Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
	xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0
	cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8V
	AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E
	14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07jepB-UUUUU=

Hi, Thomas

在 2024/6/24 下午9:45, Thomas Gleixner 写道:
> On Mon, Jun 24 2024 at 05:06, kernel test robot wrote:
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/core
>> head:   c9d269469d2b9a06559cdc84d12dd3fb4d552581
>> commit: 760d7e719499d64beea62bfcf53938fb233bb6e7 [39/46] Loongarch: Support loongarch avec
>> config: loongarch-allnoconfig (https://download.01.org/0day-ci/archive/20240624/202406240451.ygBFNyJ3-lkp@intel.com/config)
>> compiler: loongarch64-linux-gcc (GCC) 13.2.0
>> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240624/202406240451.ygBFNyJ3-lkp@intel.com/reproduce)
>>
>> If you fix the issue in a separate patch/commit (i.e. not just a new version of
>> the same patch/commit), kindly add following tags
>> | Reported-by: kernel test robot <lkp@intel.com>
>> | Closes: https://lore.kernel.org/oe-kbuild-all/202406240451.ygBFNyJ3-lkp@intel.com/
>>
>> All errors (new ones prefixed by >>):
>>
>>     drivers/irqchip/irq-loongarch-avec.c: In function 'loongarch_avec_sync':
>>>> drivers/irqchip/irq-loongarch-avec.c:82:17: error: implicit declaration of function 'loongson_send_ipi_single' [-Werror=implicit-function-declaration]
>>        82 |                 loongson_send_ipi_single(adata->prev_cpu, SMP_CLEAR_VECT);
>>           |                 ^~~~~~~~~~~~~~~~~~~~~~~~
>>>> drivers/irqchip/irq-loongarch-avec.c:82:59: error: 'SMP_CLEAR_VECT' undeclared (first use in this function)
>>        82 |                 loongson_send_ipi_single(adata->prev_cpu, SMP_CLEAR_VECT);
>>           |                                                           ^~~~~~~~~~~~~~
>>     drivers/irqchip/irq-loongarch-avec.c:82:59: note: each undeclared identifier is reported only once for each function it appears in
>>     drivers/irqchip/irq-loongarch-avec.c: In function 'complete_irq_moving':
>>     drivers/irqchip/irq-loongarch-avec.c:173:55: error: 'SMP_CLEAR_VECT' undeclared (first use in this function)
>>       173 |                         loongson_send_ipi_single(cpu, SMP_CLEAR_VECT);
>>           |                                                       ^~~~~~~~~~~~~~
> So this code was never built with CONFIG_SMP=n.
>
> Can the loongson folks please send me a delta patch ASAP, otherwise I'm
> going to revert it.
>
> Thanks,
>
>          tglx

We have also noticed this issue and found that the patch has other 
issues that may cause it to fail to start on a certain model of machine.
If possible, please reverse this patch and we will resend a V2 version 
patch as soon as possible based on this patch

Thanks you

             Tianyang


