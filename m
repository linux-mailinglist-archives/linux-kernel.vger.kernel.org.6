Return-Path: <linux-kernel+bounces-433234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B2949E5569
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 13:28:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 200BA167D0D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 12:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 024CC218AA3;
	Thu,  5 Dec 2024 12:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Eamc60rF"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83195217F5D;
	Thu,  5 Dec 2024 12:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733401625; cv=none; b=cYV4Zw5DD2vncHGso2Y0Swj5vR1nKk/qSGPZeQgOMeyEG7ib7q6tUqMR1aZzzhazWTARbPNodrH9ewszohvB/4J4uTsX1fkXuyaif8nHocYjzoOtCMAhU8OglvkpYzFfzDJfp6qD458Wm1GLel1TkOBeMDwS0l2Dn+GkjBI5F/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733401625; c=relaxed/simple;
	bh=nrfocU40C1E7t1lw39FQ7R9127iSar+XPZLXnMOKwaw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X/xFGyD8LK5rwFnUtrvSs7d+uzQdS6w9KzQ94WcRvfBOYJdoGC9TaxKx6lmHR82Eotzz2tXcVNUiB7gMmIPwxfQfMJkr5v9zr3FfwmdmfjRSCOISBBTslW1uz/UbpHdGZX6z2M/raXRXUbVEe3++zGKUAm1TYOwc5eQk+UitfXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Eamc60rF; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1733401621;
	bh=nrfocU40C1E7t1lw39FQ7R9127iSar+XPZLXnMOKwaw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Eamc60rFbmbDye+pCeVNeRdxskiQYCdcVUz7cFt9Gumvi659rxVMlH8OOewIuQXag
	 HzO8IKY7g2qGJ7OhYB3Iew5Bg77qu6jp52MEh562r2kvFdiy3/CpoHW8XKL/qqv9Hb
	 daOhbOIqkrHlbGGP4Em25pgi9o0OjrCA/0XvnU0v2YNa2pz59rbi+ehilOGXaXT2TD
	 1eWOu1WMmRUwQCVpMOGQS1UVjLvlN9dRRHDrK85xzX7rGjES4yQGnAlBDYbtfl9m4L
	 CdWGcQwsHC+d5JpLvdGFomyrQeZ4A4nkAVfVMs/5xa3X/8GD9ry/+WOHxXqcOU5f7n
	 2hJqC1GBjS14Q==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 6B8C617E366D;
	Thu,  5 Dec 2024 13:27:01 +0100 (CET)
Message-ID: <7bf536a5-30c1-43d8-9ea3-3aaea65c6b0a@collabora.com>
Date: Thu, 5 Dec 2024 13:27:01 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] MT8516/MT8167 dtsi fixes
To: Val Packett <val@packett.cool>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, Fabien Parent <fparent@baylibre.com>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20241204190524.21862-1-val@packett.cool>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20241204190524.21862-1-val@packett.cool>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 04/12/24 20:05, Val Packett ha scritto:
> Hi everyone,
> 
> I've been working on mainline bringup on an MT8167 tablet I found at a
> junkyard sale (lenovo,tb7304f) for postmarketOS :3
> 
> This first series consists of basic device tree fixes for the MT8516
> dtsi that the MT8167 one inherits from.
> 

...Yes, but I don't see any patch that is introducing your TB7304F device here.

I strongly suggest you to also send one that achieves basic boot with UART console
as a first step for upstreaming your board, and then go for incremental changes
everytime you get a new feature working.

> The changes that follow add support for the MT6392 PMIC, and that's
> mostly been implemented by Fabien Parent back in 2020 and not merged:
> 
> <https://patchwork.kernel.org/project/linux-arm-kernel/patch/20201027181157.862927-3-fparent@baylibre.com/>
> <https://patchwork.kernel.org/project/linux-arm-kernel/patch/20201024200304.1427864-2-fparent@baylibre.com/>
> 
> but I have a couple changes on top of those patches (like adding the
> missing mt6392_set_buck_vosel_reg). I'm wondering what the best way to
> get this in would be, should I squash my changes and submit the "final"
> patches with a Co-developed-by tag?
> 

Generally, if the patches are only simple additions, you could send the original
patches without any author variation (and fixing that MT6392_IRQ_numbers enum
in the original ones because lower case please!) and then your patches on top
with your additions.

Otherwise, if you're "changing a lot of stuff" it makes sense to grab authorship
and add the Co-Developed-by... but I don't think you're changing much, honestly.

Of course, you'll have to drop the TXT additions, as now they are YAML (where the
YAML additions go to a separated dt-bindings patch!).

In the end, it's your choice - that's more or less a gist of how to do it.

> (Similar situation with DRM nodes, not merged due to "concerns about
> the driver architecture" in 2021, now missing GCE/CMDQ mailbox props:
> <https://lore.kernel.org/df4c57f9-115b-c4da-e656-e4bdec62c2d7@gmail.com/>)
> 

The upstream driver just gained support for configuring the display paths
entirely in the devicetree as those are obviously device specific.

You can make use of that for upstreaming your tablet after adding the display
nodes (and bindings, if required) as if you go for the default configuration
that's probably not going to work because it's for the pumpkin boards which
will most probably have a different display pipeline compared to your board.

> By the way, is anyone familiar with PSCI cpuidle/hot-unplug issues on
> Mediatek Android devices from around this time? Specifically on this
> tablet, I can't make the cores come back from suspend. I have
> investigated local-timer-stop and arm,no-tick-in-suspend, Fabien pointed
> me to the mediatek timer and its required clocks, but nothing helped.
> Trying the psci_checker, I realized that it's not just suspend: they
> do not come back from hot-unplug either. Initial CPU_ON on boot is fine,
> but then after a CPU_OFF they do not actually come back when CPU_ON
> supposedly turns them on. Now I can't help but notice that the only DTS
> in mainline for a device that came with Android, mt6795-sony-xperia-m5,
> does not have any cpuidle nodes in its SoC's dtsi either..
> 

I did have some issues with an older bootloader on the Xperia M5 smartphone
and would even lock up at boot, because on the old firmwares the power
domains for the CPUs are not managed automatically by FW.

Before discovering that there was new FW (and this stuff is signed so you
cannot cross-flash...) I did engineer a solution, but never upstreamed it
because I did effectively lack time to clean it up and make it proper.

This solution is not upstreamable, as it makes the mtk-pm-domains driver
to be usable only as built-in and not as module anymore... so that would
probably need a separated driver or something like that.

Here's the (rather dirty, but working) code: 
https://gitlab.collabora.com/google/chromeos-kernel/-/commit/ae8f7048aadac03037391a64d9d79ca5af7b7a77

Cheers!
Angelo

> Val Packett (5):
>    arm64: dts: mediatek: mt8516: fix GICv2 range
>    arm64: dts: mediatek: mt8516: fix wdt irq type
>    arm64: dts: mediatek: mt8516: add i2c clock-div property
>    arm64: dts: mediatek: mt8516: reserve 192 KiB for TF-A
>    arm64: dts: mediatek: mt8516: add keypad node
> 
>   arch/arm64/boot/dts/mediatek/mt8516.dtsi      | 21 +++++++++++++++----
>   .../boot/dts/mediatek/pumpkin-common.dtsi     |  2 --
>   2 files changed, 17 insertions(+), 6 deletions(-)
> 




