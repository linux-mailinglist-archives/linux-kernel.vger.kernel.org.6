Return-Path: <linux-kernel+bounces-396768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6E109BD1B6
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 17:08:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E6A71F24B50
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 16:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E704C14E2DF;
	Tue,  5 Nov 2024 16:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yoseli.org header.i=@yoseli.org header.b="SE8ncYxW"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C9F113AD0F
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 16:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730822840; cv=none; b=pkMQudKcLdpqIbDJd3Xnd4UjBWIcLQ3xdH75ftNzsqyq0g9afTmv1kABUPNBtKHogVIY9vzwHNR5yfh23si7627pqEgYyHy/VoDK3GHSkCNXb2BqezEmEgSY08UVWZST8WpjMMFtjuvNtK/Rom0pRo79A0JFAqqgOUWk2bCYiYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730822840; c=relaxed/simple;
	bh=VH1r4tp0wlXRUl7tT3hgyqFtHRjHf6kl1GsN1Iq7udU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rr5IRFjUXgihLuHsBYbKSu3r5Ivby6HxBh0c9J0MVxAZYd7wcMHgFiIeZOSZR3FxCSoqxp0WeCavAq/xdcPDO7jwrPv34/fomNsZqtu9FnUj8/mZL7EAnvfOz3uqaC6UtRGhxzOm8u4UETNgrdffHTj7zH7PC6Wge6Q9ZxUaXsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yoseli.org; spf=none smtp.mailfrom=yoseli.org; dkim=pass (2048-bit key) header.d=yoseli.org header.i=@yoseli.org header.b=SE8ncYxW; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yoseli.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=yoseli.org
Received: by mail.gandi.net (Postfix) with ESMTPSA id D5AB6FF80B;
	Tue,  5 Nov 2024 16:07:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yoseli.org; s=gm1;
	t=1730822835;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ShBL4rae52nwdlUNSSt2YAy/Zfp87HFRvmZTPlGPJf8=;
	b=SE8ncYxWCkpREZvlAVF4Ze3C8spPMFmlBOwvk7cBa/pNgnJEOqjUUFJCkvATT42YTUMHM6
	i3yjnZoUvT7HnjLA1n5fShjofsjBVt0LifFFLCMeEGyB3F1M+F/DlsfB5UT+4m+ClzApk1
	+NKMLsifpjYtybbv9Pa5Z8QT4jEyOKSnUSVAwhbcuFPrT0pwrs5bgRNmFTD9HF5mnMkrDu
	zMisK6DvcFYEe5RkErEg6lKjZg0On0jN3qNzrbzlKLvWJF0TK4XqkfaCbxmY4e9+D5swSr
	2qA3Mb1fRattCISNRLtm4EeMyua2knTEuzejrkpP4CNCMgZdrmuG18OZdygHVQ==
Message-ID: <5a4f485b-51e7-47de-abe9-ede18e1e6643@yoseli.org>
Date: Tue, 5 Nov 2024 17:07:14 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] m68k: Initialize jump labels early during setup_arch()
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
References: <20241016-fix-jump-label-v1-1-eb74c5f68405@yoseli.org>
 <CAMuHMdULfk-_VGXBsnD+Gc7h4c5PRAYDdgx1zEeW=4+1fA0N_Q@mail.gmail.com>
 <d8d99f60-7a51-4b5f-b281-11fe6322a01e@yoseli.org>
 <CAMuHMdWV9aAV89gB-57e9cmFYax=BUbg0k2m7R1+t9E5YSySvw@mail.gmail.com>
Content-Language: en-US, fr
From: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
In-Reply-To: <CAMuHMdWV9aAV89gB-57e9cmFYax=BUbg0k2m7R1+t9E5YSySvw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: jeanmichel.hautbois@yoseli.org

Hi Geert,

On 11/5/24 17:04, Geert Uytterhoeven wrote:
> Hi Jean-Michel,
> 
> On Tue, Nov 5, 2024 at 3:56 PM Jean-Michel Hautbois
> <jeanmichel.hautbois@yoseli.org> wrote:
>> On 11/5/24 15:03, Geert Uytterhoeven wrote:
>>> On Wed, Oct 16, 2024 at 6:18 PM Jean-Michel Hautbois
>>> <jeanmichel.hautbois@yoseli.org> wrote:
>>>> The jump_label_init() should be called from setup_arch() very
>>>> early for proper functioning of jump label support.
>>>>
>>>> Signed-off-by: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
>>>
>>> Thanks for your patch!
>>>
>>>> --- a/arch/m68k/kernel/setup_mm.c
>>>> +++ b/arch/m68k/kernel/setup_mm.c
>>>> @@ -249,7 +249,11 @@ void __init setup_arch(char **cmdline_p)
>>>>           process_uboot_commandline(&m68k_command_line[0], CL_SIZE);
>>>>           *cmdline_p = m68k_command_line;
>>>>           memcpy(boot_command_line, *cmdline_p, CL_SIZE);
>>>> -
>>>> +       /*
>>>> +        * Initialise the static keys early as they may be enabled by the
>>>> +        * cpufeature code and early parameters.
>>>> +        */
>>>> +       jump_label_init();
>>>>           parse_early_param();
>>>>
>>>>           switch (m68k_machtype) {
>>>
>>> This is indeed what some (but not all) other architectures are doing, so
>>> Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
>>>
>>> I assume you saw some "static key used before call to jump_label_init()"
>>> warning[1]? Since I never saw such a message, can you please elaborate
>>> and explain your use case, so I can add that to the patch description
>>> when applying?
>>
>> Indeed ! I saw this when I was passing the "threadirqs" parameter to the
>> kernel commandline and the "select IRQ_FORCED_THREADING" line to the
>> Kconfig.
> 
> Thanks, I can reproduce it using that method.
> 
>> I suspect this might be true for other keys.
> 
> Indeed. But m68k and its configs don't enable much code that uses keys.
> The only one I found was "thread_backlog_napi". Adding that to the
> kernel command line gives:
> 
>      WARNING: CPU: 0 PID: 0 at include/linux/jump_label.h:322
> setup_backlog_napi_threads+0x40/0xa0
>      static_key_enable(): static key '0x5ceec0' used before call to
> jump_label_init()
> 
> so I'll add that to the patch description.

Great news !

> 
>> BTW, threaded IRQs work fine ;-).
> 
> On Atari (ARAnyM), they blow up spectacularly:
> 
>      Unable to handle kernel NULL pointer dereference at virtual address 00000000
>      Oops: 00000000
>      Modules linked in:
>      PC: [<00040baa>] try_to_wake_up+0x90/0x1b8
>      SR: 2701  SP: (ptrval)  a2: 0055b660
>      d0: 00000003    d1: 00000003    d2: 00000000    d3: 00002700
>      d4: 00000008    d5: 00000000    a0: 00558000    a1: 00558000
>      Process swapper (pid: 0, task=(ptrval))
>      Frame format=7 eff addr=00000000 ssw=0505 faddr=00000000
>      wb 1 stat/addr/data: 0000 00000000 00000000
>      wb 2 stat/addr/data: 0000 00000000 00000000
>      wb 3 stat/addr/data: 0000 00000000 00000000
>      push data: 00000000 00000000 00000000 00000000
>      Stack from 00559ea8:
>      00000000 0000000f 00007874 01006140 00559ef0 00050ec6 0000000f 00559ed8
>      00040ce6 00000000 00000003 00000000 00559f14 0003b9b6 00000000 00000000
>      00592710 010040c0 00000000 00559ef4 00559ef4 0003ba26 00051cd2 010040c0
>      ffffffff 004fc9a1 00559f2c 00559ff8 00050ef8 00051cd2 010040c0 ffffffff
>      004fc9a1 0000000f 004f9268 00000000 00592710 010040c0 00051566 010040c0
>      0000000f 00000000 00000000 0000000f 00007874 00000000 010040c0 00592710
>      Call Trace: [<00007874>] stdma_int+0x0/0x1c
>       [<00050ec6>] setup_irq_thread+0x0/0x98
>       [<00040ce6>] wake_up_process+0x14/0x18
>       [<0003b9b6>] __kthread_create_on_node+0xca/0x11e
>       [<0003ba26>] kthread_create_on_node+0x1c/0x26
>       [<00051cd2>] irq_thread+0x0/0x184
>       [<00050ef8>] setup_irq_thread+0x32/0x98
>       [<00051cd2>] irq_thread+0x0/0x184
>       [<00051566>] __setup_irq+0x172/0x582
>       [<00007874>] stdma_int+0x0/0x1c
>       [<00051a34>] request_threaded_irq+0xbe/0x14e
>       [<0003ab86>] parse_args+0x0/0x202
>       [<0000556e>] m68k_setup_irq_controller+0x0/0x48
>       [<00255bda>] __is_suppressed_warning+0x0/0x42
>       [<005da080>] stdma_init+0x2a/0x42
>       [<00007874>] stdma_int+0x0/0x1c
>       [<00200080>] ksys_shmctl+0x420/0x5f8
>       [<00007874>] stdma_int+0x0/0x1c
>       [<005d9f82>] atari_init_IRQ+0xc0/0x194
>       [<00412cc8>] _printk+0x0/0x18
>       [<00255bda>] __is_suppressed_warning+0x0/0x42
>       [<005d62b0>] start_kernel+0x40e/0x618
>       [<005d5344>] _sinittext+0x344/0x9e8
> 
>      Code: 0008 5281 2341 0008 b6fc fc3c 6700 011e <2213> c280 6700
> 0108 202b 0018 4bf9 0004 05a6 6700 0096 486e fffc 2f0b 4eb9 0004
>      Disabling lock debugging due to kernel taint
>      Kernel panic - not syncing: Attempted to kill the idle task!
>      ---[ end Kernel panic - not syncing: Attempted to kill the idle task! ]---

I needed to make my nfc driver (vf610_nfc) be hardirq though using 
IRQF_NO_THREAD but ethernet and all work fine on coldfire.

Thanks !
JM


