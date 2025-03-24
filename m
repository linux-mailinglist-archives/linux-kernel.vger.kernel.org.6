Return-Path: <linux-kernel+bounces-573489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48C2FA6D822
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 11:16:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4AD116E23B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 10:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FEE225D52D;
	Mon, 24 Mar 2025 10:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b="e8oLKMJj"
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5A319C542
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 10:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.252.153.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742811361; cv=none; b=cEm8H2DaohM75wza8rJlopNPgfL7WqJHTkL0R3TPcnNkgUybznB43xa73ZMv+uINg94RD9GWn/jPG5mFeOG5OrdhK1iwIOGNPr/4/3ez2p6VQqMy6TlvoULVEbyNNRvv3xsXbCh5iPJ+sMhVGw2pA6AnahPxhs3SN5mAWsjb544=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742811361; c=relaxed/simple;
	bh=4coeVSMlWhq8flDE17tW57vdOw/bxO/eXKUyKubmi9w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UPC5VgIXVmQom5FuM7QD2byDRF/UWyMckCePz/+h31LZ4yDQd23xsob63WnhshBczsPSQLNebVaIAExTY4x03jIaZ/EPgoPUF3jSLUd9bXif4NIkELSn45T6TDMfA/16fOXdgAmeKAFt7xjMNKDFrnhjls9la7BQqjy0DbC6gHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net; spf=pass smtp.mailfrom=riseup.net; dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b=e8oLKMJj; arc=none smtp.client-ip=198.252.153.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riseup.net
Received: from fews01-sea.riseup.net (fews01-sea-pn.riseup.net [10.0.1.109])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1.riseup.net (Postfix) with ESMTPS id 4ZLpq26bQ8zDrJK;
	Mon, 24 Mar 2025 10:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
	t=1742811359; bh=4coeVSMlWhq8flDE17tW57vdOw/bxO/eXKUyKubmi9w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=e8oLKMJjVr4tD9sSOGA1077yEj+a4JiUqS1ZXv/V8XxQ2uspMAa/JXWFHj5C13KHo
	 7T+GhFbrnSc55kP017YbfDzFIb2kk8bPFUlIuajY4lhaJ1MVmOdSUyf9YHPieBDkm2
	 Y9G6QGEJ/f/+bGv+vEIFTlvEa8G/xqov39IAUENM=
X-Riseup-User-ID: 1146F1986AF6DD693E91D94C7D208D88AA7AE2CA6E8887444F89406F7EA8F3BA
Received: from [127.0.0.1] (localhost [127.0.0.1])
	 by fews01-sea.riseup.net (Postfix) with ESMTPSA id 4ZLpq11xRFzJmr3;
	Mon, 24 Mar 2025 10:15:57 +0000 (UTC)
Message-ID: <b5b12fbb-eaee-4285-b70e-fa874e930cbd@riseup.net>
Date: Mon, 24 Mar 2025 11:15:55 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] x86/i8253: fix possible deadlock when turning off the PIT
To: Ingo Molnar <mingo@kernel.org>
Cc: x86@kernel.org, tglx@linutronix.de, linux-kernel@vger.kernel.org,
 dwmw@amazon.co.uk, mhkelley@outlook.com
References: <20250323150924.3326-1-ffmancera@riseup.net>
 <Z-B6ob0zLZr81e8i@gmail.com>
Content-Language: en-US
From: "Fernando F. Mancera" <ffmancera@riseup.net>
In-Reply-To: <Z-B6ob0zLZr81e8i@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 23/03/2025 22:18, Ingo Molnar wrote:
> 
> * Fernando Fernandez Mancera <ffmancera@riseup.net> wrote:
> 
>> As the PIT could be disabled during the init, it can possibly cause a
>> deadlock when resuming from suspend due to a lock dependency created at
>> pcspkr_event(). This new dependency connect a HARDIRQ-irq-safe to a
>> HARDIRQ-irq-unsafe.
>>
>> Solve this warning by using the raw_spin_lock_irqsave() variant when
>> turning off the PIT.
>>
>> [   45.408952] =====================================================
>> [   45.408970] WARNING: HARDIRQ-safe -> HARDIRQ-unsafe lock order detected
>> [   45.408974] 6.14.0-rc7+ #6 Not tainted
>> [   45.408978] -----------------------------------------------------
>> [   45.408980] systemd-sleep/3324 [HC0[0]:SC0[0]:HE0:SE1] is trying to acquire:
>> [   45.408986] ffffffffb2c23398 (i8253_lock){+.+.}-{2:2}, at: pcspkr_event+0x3f/0xe0 [pcspkr]
>> [   45.409004]
>>                 and this task is already holding:
>> [   45.409006] ffff9c334d7c2230 (&dev->event_lock){-.-.}-{3:3}, at: input_dev_resume+0x21/0x50
>> [   45.409023] which would create a new lock dependency:
>> [   45.409025]  (&dev->event_lock){-.-.}-{3:3} -> (i8253_lock){+.+.}-{2:2}
>> [   45.409043]
>>                 but this new dependency connects a HARDIRQ-irq-safe lock:
>> [   45.409045]  (&dev->event_lock){-.-.}-{3:3}
>> [   45.409052]
>>                 ... which became HARDIRQ-irq-safe at:
>> [   45.409055]   lock_acquire+0xd0/0x2f0
>> [   45.409062]   _raw_spin_lock_irqsave+0x48/0x70
>> [   45.409067]   input_event+0x3c/0x80
>> [   45.409071]   atkbd_receive_byte+0x9b/0x6e0
>> [   45.409077]   ps2_interrupt+0xb2/0x1d0
>> [   45.409082]   serio_interrupt+0x4a/0x90
>> [   45.409087]   i8042_handle_data+0xf8/0x280
>> [   45.409091]   i8042_interrupt+0x11/0x40
>> [   45.409095]   __handle_irq_event_percpu+0x87/0x260
>> [   45.409100]   handle_irq_event+0x38/0x90
>> [   45.409105]   handle_edge_irq+0x8b/0x230
>> [   45.409109]   __common_interrupt+0x5c/0x120
>> [   45.409114]   common_interrupt+0x80/0xa0
>> [   45.409120]   asm_common_interrupt+0x26/0x40
>> [   45.409125]   pv_native_safe_halt+0xf/0x20
>> [   45.409130]   default_idle+0x9/0x20
>> [   45.409135]   default_idle_call+0x7a/0x1d0
>> [   45.409140]   do_idle+0x215/0x260
>> [   45.409144]   cpu_startup_entry+0x29/0x30
>> [   45.409149]   start_secondary+0x132/0x170
>> [   45.409153]   common_startup_64+0x13e/0x141
>> [   45.409158]
>>                 to a HARDIRQ-irq-unsafe lock:
>> [   45.409161]  (i8253_lock){+.+.}-{2:2}
>> [   45.409167]
>>                 ... which became HARDIRQ-irq-unsafe at:
>> [   45.409170] ...
>> [   45.409172]   lock_acquire+0xd0/0x2f0
>> [   45.409177]   _raw_spin_lock+0x30/0x40
>> [   45.409181]   clockevent_i8253_disable+0x1c/0x60
>> [   45.409186]   pit_timer_init+0x25/0x50
>> [   45.409191]   hpet_time_init+0x46/0x50
>> [   45.409196]   x86_late_time_init+0x1b/0x40
>> [   45.409201]   start_kernel+0x962/0xa00
>> [   45.409206]   x86_64_start_reservations+0x24/0x30
>> [   45.409211]   x86_64_start_kernel+0xed/0xf0
>> [   45.409215]   common_startup_64+0x13e/0x141
>> [   45.409220]
>>                 other info that might help us debug this:
>>
>> [   45.409222]  Possible interrupt unsafe locking scenario:
>>
>> [   45.409224]        CPU0                    CPU1
>> [   45.409226]        ----                    ----
>> [   45.409228]   lock(i8253_lock);
>> [   45.409234]                                local_irq_disable();
>> [   45.409237]                                lock(&dev->event_lock);
>> [   45.409243]                                lock(i8253_lock);
>> [   45.409249]   <Interrupt>
>> [   45.409251]     lock(&dev->event_lock);
>> [   45.409257]
>>                  *** DEADLOCK ***
>>
>> Fixes: 70e6b7d9ae3c ("x86/i8253: Disable PIT timer 0 when not in use")
>> Signed-off-by: Fernando Fernandez Mancera <ffmancera@riseup.net>
>> ---
>>   drivers/clocksource/i8253.c | 6 ++++--
>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/clocksource/i8253.c b/drivers/clocksource/i8253.c
>> index 39f7c2d736d1..9a91ce66e16e 100644
>> --- a/drivers/clocksource/i8253.c
>> +++ b/drivers/clocksource/i8253.c
>> @@ -103,7 +103,9 @@ int __init clocksource_i8253_init(void)
>>   #ifdef CONFIG_CLKEVT_I8253
>>   void clockevent_i8253_disable(void)
>>   {
>> -	raw_spin_lock(&i8253_lock);
>> +	unsigned long flags;
>> +
>> +	raw_spin_lock_irqsave(&i8253_lock, flags);
>>   
>>   	/*
>>   	 * Writing the MODE register should stop the counter, according to
>> @@ -133,7 +135,7 @@ void clockevent_i8253_disable(void)
>>   
>>   	outb_p(0x30, PIT_MODE);
>>   
>> -	raw_spin_unlock(&i8253_lock);
>> +	raw_spin_unlock_irqrestore(&i8253_lock, flags);
>>   }
> 
> That's a nice one - and in general the clockevent shutdown/disable
> handlers are called with IRQs off: hpet_time_init()->pit_timer_init()
> being the odd one out post-70e6b7d9ae3c that introduced this bug.
> 
> So the real bug is that hpet_time_init() just blindly assumes that
> clockevent_i8253_disable() is IRQ-safe, which it isn't and never was.
> 
> So the slightly better fix would be to save-disable interrupts in
> pit_timer_init() around the clockevent_i8253_disable() call. This would
> avoid the IRQ disable/enable dance for all the other callers. (Not that
> it really matters for the PIT driver, but it's the principle.)
> 

Thanks for the suggestion and clarification. I will send a V2.

> Thanks,
> 
> 	Ingo


