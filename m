Return-Path: <linux-kernel+bounces-414966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CD259D2FC5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 21:52:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CB661F2312D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 20:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 210DC1D3195;
	Tue, 19 Nov 2024 20:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=ijzerbout.nl header.i=@ijzerbout.nl header.b="ZhATvMrh"
Received: from bout3.ijzerbout.nl (bout3.ijzerbout.nl [136.144.140.114])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A15CA1D2F55
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 20:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.144.140.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732049515; cv=none; b=Rg9MX/k5RWI16PJieH+Z1nJGCYhsyVrQeW5SBVernkiecn9BDTHFtz/iDPae/gdpsJt38XrtcwLVHEYdjsshhL1hMHsbwAhJgYKWt3wwKJ7dWd7J2oAWXIBoBiPqx9KRhuVNBS7afDb/CYM6nAhxmdEGelKx22DAQi3VJ01u+kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732049515; c=relaxed/simple;
	bh=C4BPLPJf9+eOsNRffuQEGy06zHXU0e7gd8uZYO3GxZ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rgL2Ph6JsuQw53NvyQddBvoBpIyj242IYkq2AbXbLvL0S1K9GjhhRQc3OkTvrVH8xpPbgamPKVcagE93PMrOfWLMOJLOL+/93uu5mBHVkw4ee92WhLu5lJ2JAHBu0o38v+1lvFHkoFc1h7CZEw2ps+PJn9j5trI2AMauXlW9KSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ijzerbout.nl; spf=pass smtp.mailfrom=ijzerbout.nl; dkim=pass (4096-bit key) header.d=ijzerbout.nl header.i=@ijzerbout.nl header.b=ZhATvMrh; arc=none smtp.client-ip=136.144.140.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ijzerbout.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ijzerbout.nl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ijzerbout.nl; s=key;
	t=1732049502; bh=C4BPLPJf9+eOsNRffuQEGy06zHXU0e7gd8uZYO3GxZ4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ZhATvMrhufPP4JA3s0Ain7Jln5ZbYsVKrYtAthtk4lXwbZFzFMNzdkKkQ9NleUXz1
	 PXZ5gw9zkmA8qRFKdySdfvc+Cv1dGvZ7apJwfrgjCoKsPpiaezD334ADRDaOG89yXQ
	 EzFSpQ9K4TLHObZwv+oaDg9xhZfcj3CfTsbzHtA/L/DZ2t8gPdsNWAFOgseiK/xnlF
	 zeH28p4yzix80MQzFQfCcGplpuowZK3Yicku5cCHPl9OhrSZV08TcSA3tMV1Rck+Qp
	 cNiCyjFMfYsQyjLrduF5uTeI3O6og5UTpsmb2z0gDW6qgwfQPyk5F+4Pb+U6Ry9mSt
	 8NY7fdFnPlKk38x1QWyRwX5zZeW+A5UjMqp/myzY7xl4L1N8i3gtuogtyVI7HdfHsQ
	 qFMgju8hHApMNg8zH/Vx/cQXZ2lKwIqTGDgezJVwJizLmomVkn+MabQiDGR4ousf4r
	 xlyCQSITQWejsntuwkYhOaFUiB4Lg/t5vwstsP5j2j2kZKUuCgrwxvO8VmBrY19e2X
	 lQYDagwNHL6qbwfPAZo8RL9gCyLi1kY0I3xaUfyyp8CTrFAB8I32sOGbKEmv5KHxer
	 svwOTs4n68sI0c7yN8KUsAqM1VurOKDwEdf32M18WwwsgPac/rGWKVWSGiaLZpb1WA
	 88CcjKS0tZgp22eLl96Grgno=
Received: from [IPV6:2a10:3781:99:1:1ac0:4dff:fea7:ec3a] (racer.ijzerbout.nl [IPv6:2a10:3781:99:1:1ac0:4dff:fea7:ec3a])
	by bout3.ijzerbout.nl (Postfix) with ESMTPSA id 5713816029D;
	Tue, 19 Nov 2024 21:51:42 +0100 (CET)
Message-ID: <72410501-657b-40ec-b959-a736c913c486@ijzerbout.nl>
Date: Tue, 19 Nov 2024 21:51:39 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] i3c: Use i3cdev->desc->info instead of calling
 i3c_device_get_info() to avoid deadlock
To: mtk25126 <defa.li@mediatek.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 wsd_upstream@mediatek.com, mingchang.jia@mediatek.com,
 yuhan.wei@mediatek.com, hao.lin@mediatek.com
References: <20241107132549.25439-1-defa.li@mediatek.com>
Content-Language: en-US
From: Kees Bakker <kees@ijzerbout.nl>
In-Reply-To: <20241107132549.25439-1-defa.li@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Op 07-11-2024 om 14:25 schreef mtk25126:
> From: Defa Li <defa.li@mediatek.com>
>
> A deadlock may happen since the i3c_master_register() acquires
> &i3cbus->lock twice. See the log below.
> Use i3cdev->desc->info instead of calling i3c_device_info() to
> avoid acquiring the lock twice.
>
> v2:
>    - Modified the title and commit message
>
> ============================================
> WARNING: possible recursive locking detected
> 6.11.0-mainline
> --------------------------------------------
> init/1 is trying to acquire lock:
> f1ffff80a6a40dc0 (&i3cbus->lock){++++}-{3:3}, at: i3c_bus_normaluse_lock
>
> but task is already holding lock:
> f1ffff80a6a40dc0 (&i3cbus->lock){++++}-{3:3}, at: i3c_master_register
>
> other info that might help us debug this:
>   Possible unsafe locking scenario:
>
>         CPU0
>         ----
>    lock(&i3cbus->lock);
>    lock(&i3cbus->lock);
>
>   *** DEADLOCK ***
>
>   May be due to missing lock nesting notation
>
> 2 locks held by init/1:
>   #0: fcffff809b6798f8 (&dev->mutex){....}-{3:3}, at: __driver_attach
>   #1: f1ffff80a6a40dc0 (&i3cbus->lock){++++}-{3:3}, at: i3c_master_register
>
> stack backtrace:
> CPU: 6 UID: 0 PID: 1 Comm: init
> Call trace:
>   dump_backtrace+0xfc/0x17c
>   show_stack+0x18/0x28
>   dump_stack_lvl+0x40/0xc0
>   dump_stack+0x18/0x24
>   print_deadlock_bug+0x388/0x390
>   __lock_acquire+0x18bc/0x32ec
>   lock_acquire+0x134/0x2b0
>   down_read+0x50/0x19c
>   i3c_bus_normaluse_lock+0x14/0x24
>   i3c_device_get_info+0x24/0x58
>   i3c_device_uevent+0x34/0xa4
>   dev_uevent+0x310/0x384
>   kobject_uevent_env+0x244/0x414
>   kobject_uevent+0x14/0x20
>   device_add+0x278/0x460
>   device_register+0x20/0x34
>   i3c_master_register_new_i3c_devs+0x78/0x154
>   i3c_master_register+0x6a0/0x6d4
>   mtk_i3c_master_probe+0x3b8/0x4d8
>   platform_probe+0xa0/0xe0
>   really_probe+0x114/0x454
>   __driver_probe_device+0xa0/0x15c
>   driver_probe_device+0x3c/0x1ac
>   __driver_attach+0xc4/0x1f0
>   bus_for_each_dev+0x104/0x160
>   driver_attach+0x24/0x34
>   bus_add_driver+0x14c/0x294
>   driver_register+0x68/0x104
>   __platform_driver_register+0x20/0x30
>   init_module+0x20/0xfe4
>   do_one_initcall+0x184/0x464
>   do_init_module+0x58/0x1ec
>   load_module+0xefc/0x10c8
>   __arm64_sys_finit_module+0x238/0x33c
>   invoke_syscall+0x58/0x10c
>   el0_svc_common+0xa8/0xdc
>   do_el0_svc+0x1c/0x28
>   el0_svc+0x50/0xac
>   el0t_64_sync_handler+0x70/0xbc
>   el0t_64_sync+0x1a8/0x1ac
>
> Signed-off-by: Defa Li <defa.li@mediatek.com>
> ---
>   drivers/i3c/master.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
> index 6f3eb710a75d..bb8a8bf0c4c7 100644
> --- a/drivers/i3c/master.c
> +++ b/drivers/i3c/master.c
> @@ -282,7 +282,8 @@ static int i3c_device_uevent(const struct device *dev, struct kobj_uevent_env *e
>   	struct i3c_device_info devinfo;
>   	u16 manuf, part, ext;
>   
> -	i3c_device_get_info(i3cdev, &devinfo);
> +	if (i3cdev->desc)
> +		devinfo = i3cdev->desc->info;
Now you have left devinfo unitialized if i3cdev->desc == NULL
You have to figure out what to do in that case.
>   	manuf = I3C_PID_MANUF_ID(devinfo.pid);
>   	part = I3C_PID_PART_ID(devinfo.pid);
>   	ext = I3C_PID_EXTRA_INFO(devinfo.pid);


