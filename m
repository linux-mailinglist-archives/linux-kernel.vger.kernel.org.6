Return-Path: <linux-kernel+bounces-278013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DF6294A965
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 16:07:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1647280A73
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 14:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C68872BCFF;
	Wed,  7 Aug 2024 14:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HdAZwuvp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42E21DDEB;
	Wed,  7 Aug 2024 14:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723039642; cv=none; b=j9INneCU9J8QYD8mdc18bTBFEswdT6+9rNhAsV0VJxZL8AeVWYHvpJOvK1TuHOaEzLdltH6pbWQs987t5mA+G0Q4lDg71HKmaEm3h7ZA0TPX3BsLaqGJNXSn+ifwxwKz6JALPclHeL/BSjHb7K191W9R6999pNMJt/CZJTuSPfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723039642; c=relaxed/simple;
	bh=qqVeEqsrCcmewoP0WAXwDudKGHI90bIbM4RAK2gdd24=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W0NsuaCZz/e4+NyP9eklOanP5YeWGi1CqV9TpNF9UXb1BErLZujiInZhCyIVn/iTQlE268Jfp/ebsbBLfX9YdHqun3BudlRjav/Wkr9Z9d8ONJYxGlxUd1k5YZBxkw1j6XOAGuK2Lsh5qDUBoVTVvsQyHzIXp/MSv9EhyJj/5ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HdAZwuvp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 817F3C32782;
	Wed,  7 Aug 2024 14:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723039641;
	bh=qqVeEqsrCcmewoP0WAXwDudKGHI90bIbM4RAK2gdd24=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=HdAZwuvpa4sb5B1IHztgfoeL4x3eIKZeKQpX5IljSs0sy5q8EFq63LXbymXu1KI4M
	 DVL4UCGMBnOZJUG64DxDSCAIR5ert7tw5FpZjGS4Ecwo2lqOmC7MB21nX4MOxF3qwC
	 t7oXdKnOcZCN7Din1O3kTX7AkQRbXZXHMEFylSS+9meXOScZyc/VsdonaZnpQFKf+/
	 YA73jam/UsGFOrlSujiG/hUx2WfWw0kVlA8xu9anGNXicMnReJAcHrlPEhBCzR0JOV
	 So6dymUQBn8yjAYlqVhhhIFmUJWvTnEvsF62GOpgeGnynNchxCNkaIPLupvH/RePOb
	 CT4l7iJ67GhHg==
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2f149845d81so22751951fa.0;
        Wed, 07 Aug 2024 07:07:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXuLYaSGPTB+N2aSatxKmxHD2skntdEmpX7cBkpsccJapjlcqe9qskOS/UJU9TADGI98iBNGO4TXzvJ1CUY/ZR+yzRX4bOU8dyTQ+mB7l8gOOT00Ia2uRb1DfiRr5J2eA/4tgezSSn4xw==
X-Gm-Message-State: AOJu0YzjW8/6dReaCBwcYeiL1SEOTNL2fbQ9KcuUQXLzMvh6J7ShDGAw
	qRLv/2G8PxYPSuhEQv0ucIAQirp0C5aLK7g1i3tTmv3BzKQ7ZV4VTeqUgNySL/cSXwphiSFA+Ms
	Na75SPM4c5SgpacsrwXyE9IXybg==
X-Google-Smtp-Source: AGHT+IHpozyU0Z7FIdFJ3BGe4HpmfanDVWMyyT/fY2I/p1GVhPRMBH1xX2J/1J+ECmDTGp5KVYzIy3jUTUZ6BPeGjAE=
X-Received: by 2002:a2e:8015:0:b0:2ec:54ec:1741 with SMTP id
 38308e7fff4ca-2f15aa99206mr112138211fa.18.1723039639802; Wed, 07 Aug 2024
 07:07:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240807120153.1208858-2-stefan.wiehler@nokia.com>
In-Reply-To: <20240807120153.1208858-2-stefan.wiehler@nokia.com>
From: Rob Herring <robh@kernel.org>
Date: Wed, 7 Aug 2024 08:07:07 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLciDTxfeKwuNNWEOZjrUDFp9g7ZAzTuY4nQ1GCwPmaow@mail.gmail.com>
Message-ID: <CAL_JsqLciDTxfeKwuNNWEOZjrUDFp9g7ZAzTuY4nQ1GCwPmaow@mail.gmail.com>
Subject: Re: [PATCH] of/irq: Consider device address size in interrupt map walk
To: Stefan Wiehler <stefan.wiehler@nokia.com>
Cc: Saravana Kannan <saravanak@google.com>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 7, 2024 at 6:04=E2=80=AFAM Stefan Wiehler <stefan.wiehler@nokia=
.com> wrote:
>
> When of_irq_parse_raw() is invoked with a device address smaller than
> the interrupt parent node (from #address-cells property), KASAN detects
> the following out-of-bounds read when populating the initial match table
> (dyndbg=3D"func of_irq_parse_* +p"):

You've missed a bunch of people/lists. Use get_maintainers.pl.

>   OF: of_irq_parse_one: dev=3D/soc@0/picasso/watchdog, index=3D0
>   OF:  parent=3D/soc@0/pci@878000000000/gpio0@17,0, intsize=3D2
>   OF:  intspec=3D4
>   OF: of_irq_parse_raw: ipar=3D/soc@0/pci@878000000000/gpio0@17,0, size=
=3D2
>   OF:  -> addrsize=3D3

Can you provide some details on what these nodes look like. The
interrupt provider to an SoC device is a PCI device? That's weird...


>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>   BUG: KASAN: slab-out-of-bounds in of_irq_parse_raw+0x2b8/0x8d0
>   Read of size 4 at addr ffffff81beca5608 by task bash/764
>
>   CPU: 1 PID: 764 Comm: bash Tainted: G           O       6.1.67-484c6135=
61-nokia_sm_arm64 #1

Note that of_irq_parse_raw() was refactored in 6.10, so your patch is
not going to apply.

>   Hardware name: Unknown Unknown Product/Unknown Product, BIOS 2023.01-12=
.24.03-dirty 01/01/2023
>   Call trace:
>    dump_backtrace+0xdc/0x130
>    show_stack+0x1c/0x30
>    dump_stack_lvl+0x6c/0x84
>    print_report+0x150/0x448
>    kasan_report+0x98/0x140
>    __asan_load4+0x78/0xa0
>    of_irq_parse_raw+0x2b8/0x8d0
>    of_irq_parse_one+0x24c/0x270
>    parse_interrupts+0xc0/0x120
>    of_fwnode_add_links+0x100/0x2d0
>    fw_devlink_parse_fwtree+0x64/0xc0
>    device_add+0xb38/0xc30
>    of_device_add+0x64/0x90
>    of_platform_device_create_pdata+0xd0/0x170
>    of_platform_bus_create+0x244/0x600
>    of_platform_notify+0x1b0/0x254
>    blocking_notifier_call_chain+0x9c/0xd0
>    __of_changeset_entry_notify+0x1b8/0x230
>    __of_changeset_apply_notify+0x54/0xe4
>    of_overlay_fdt_apply+0xc04/0xd94

I wonder if it is possible for KASAN to detect this if it is a base DT
given the allocation is done by memblock.

>    ...
>
>   The buggy address belongs to the object at ffffff81beca5600
>    which belongs to the cache kmalloc-128 of size 128
>   The buggy address is located 8 bytes inside of
>    128-byte region [ffffff81beca5600, ffffff81beca5680)
>
>   The buggy address belongs to the physical page:
>   page:00000000230d3d03 refcount:1 mapcount:0 mapping:0000000000000000 in=
dex:0x0 pfn:0x1beca4
>   head:00000000230d3d03 order:1 compound_mapcount:0 compound_pincount:0
>   flags: 0x8000000000010200(slab|head|zone=3D2)
>   raw: 8000000000010200 0000000000000000 dead000000000122 ffffff810000c30=
0
>   raw: 0000000000000000 0000000000200020 00000001ffffffff 000000000000000=
0
>   page dumped because: kasan: bad access detected
>
>   Memory state around the buggy address:
>    ffffff81beca5500: 04 fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>    ffffff81beca5580: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>   >ffffff81beca5600: 00 fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>                         ^
>    ffffff81beca5680: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>    ffffff81beca5700: 00 00 00 00 00 00 fc fc fc fc fc fc fc fc fc fc
>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>   OF:  -> got it !
>
> Signed-off-by: Stefan Wiehler <stefan.wiehler@nokia.com>
> ---
>  arch/powerpc/platforms/fsl_uli1575.c |  2 +-
>  drivers/bcma/main.c                  |  2 +-
>  drivers/of/irq.c                     | 64 ++++++++++++++++------------
>  drivers/pci/of.c                     |  2 +-
>  include/linux/of_irq.h               |  3 +-
>  5 files changed, 41 insertions(+), 32 deletions(-)
>
> diff --git a/arch/powerpc/platforms/fsl_uli1575.c b/arch/powerpc/platform=
s/fsl_uli1575.c
> index b8d37a9932f1b..8da36f72b7b48 100644
> --- a/arch/powerpc/platforms/fsl_uli1575.c
> +++ b/arch/powerpc/platforms/fsl_uli1575.c
> @@ -335,7 +335,7 @@ static void hpcd_final_uli5288(struct pci_dev *dev)
>         oirq.args_count =3D 1;
>         laddr[0] =3D (hose->first_busno << 16) | (PCI_DEVFN(31, 0) << 8);
>         laddr[1] =3D laddr[2] =3D 0;
> -       of_irq_parse_raw(laddr, &oirq);
> +       of_irq_parse_raw(laddr, ARRAY_SIZE(laddr), &oirq);

That's not the right information to parse the address correctly. You
would need the device's #address-cells. However, in most cases we
don't really need to parse the address. The address is not really used
except in cases where interrupt routing matches the bus and so there
is only one size. That's effectively only PCI devices today. In that
case, the address size would always be equal, and the code implicitly
assumes that. It would be better if we could just detect when to use
the address or not. I think we'd have to look at 'interrupt-map-mask'
first to see whether or not to read the address cells. Or maybe we
could detect when the interrupt parent is the device's parent node.
Either way, this code is tricky and hard to change without breaking
something.

A simpler way to fix this is just always pass in an address buffer of
3 cells to of_irq_parse_raw. You would just need to copy the cells in
of_irq_parse_one() to a temporary buffer.

Rob

