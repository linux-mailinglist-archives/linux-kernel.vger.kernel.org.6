Return-Path: <linux-kernel+bounces-294034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 18BFC9587FE
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 15:33:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82418B220DE
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 13:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A0F718FDD0;
	Tue, 20 Aug 2024 13:32:51 +0000 (UTC)
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0816F1AACB
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 13:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724160770; cv=none; b=kLpOM1d1ZeBnxkTXXtiKExNKPigxQAYgairixUltAPfmyaXCLeVJRRw0aaEIZEwvMfAKoSFuKbVw7Nd/vq7EAvayGT7zcJFIW9yOjbs4QhaypBhUiXrsp0KSIwyGl9XANEvS3FkBgEom8fqpq/+Z1Rp+GZMfMbaqsde2BZc0elc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724160770; c=relaxed/simple;
	bh=5uAl3SxFfDAenizgyWVNpNSZLThLhjLDnTmtB8v+v/U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mPsbIYBPKazpdsNhVOpv/WJUstXKgZuWg1Lens/0mtGScHDbQnAUFq/1jqenVvWUm+cDdEEFUJiaE4shKiiePOde3QCNnxWCsP9mtRt5V1rDk9/e03BZ88YG6Gk5bK0ZOXqw68UV0prLH0wlSpIU5PgXCtGimVHiSB2PK1gvlhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6b6b9867f81so22073237b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 06:32:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724160765; x=1724765565;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JWC4HyjlPZcSaONQgngCuvoMtl8bQCn+NggSNu6rHEU=;
        b=aR89zKX/iM9lW4ZxbnOOJsqh086fy3zqJgnpmu15mzwJzRXMXjoBVEktxcKG3e5r2+
         +CeCeVvzTBmLveOT3VqTslvKmqppsI+lFRkIdSdEfIxxURkSbU9Oo0MmtmOIIXpI+EIz
         bpzx1r3Aamt1bqgbMIZ5cJ297RQV98vSGN0VTvi/FwALmh0tWQG0D6T6XCNcgjnrFgQr
         WNn1T/wZACDSvU0wBhM6fZkGJ4F8gzR1ARrbA9hJveE3MRJnWY3zc8ASF+z5U2Ef669M
         McIjxeY9XvQNxF5PfU1xHEsLIrMQue8cLxfMb25Cl5rsrxucGFAz2yn9fxHPcfsCEsBy
         OfQA==
X-Forwarded-Encrypted: i=1; AJvYcCXDcf8ZCYwHa6MJdaonTKgn9wbPo0waX1PdceCuYDOUMewfQvFZWUuHKIg6ZnOSNe5vfYMyMYgcLJqmBRw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj3VwznjOpbdYsdyjkvTJywPBMKB1+8otcCNAdwWFwHvYp35NB
	4TlpDk7dyrpC7/bqxdPDUfqVFCgz6t6yMuWeAK+dCBT/ZB/hiChCFzsnaCQpXPs=
X-Google-Smtp-Source: AGHT+IE9D6EDfXaAS9ZQn5ZQJMTi07hU0rXAhKh92yUO5wiaMfeJDIw5wX5zmzKhUTdGwPwraWxmKQ==
X-Received: by 2002:a05:690c:7407:b0:6b0:7203:f0ed with SMTP id 00721157ae682-6b1b871cddamr167363267b3.20.1724160765521;
        Tue, 20 Aug 2024 06:32:45 -0700 (PDT)
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com. [209.85.128.172])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6af9d82757esm19146207b3.104.2024.08.20.06.32.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Aug 2024 06:32:45 -0700 (PDT)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6b6b9867f81so22072907b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 06:32:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWq0U2qpxrsO+12XLthBk9r8I6jDzAyvnJyUSw0ydLyNAdujbFSt6HLesxj0PjF+pm4hOQVW6dkGJkFx2c=@vger.kernel.org
X-Received: by 2002:a05:690c:4c90:b0:6b0:cad5:2239 with SMTP id
 00721157ae682-6b1ba9db49dmr137643567b3.31.1724160764751; Tue, 20 Aug 2024
 06:32:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240622114217.2158495-1-stuart.menefy@codasip.com>
In-Reply-To: <20240622114217.2158495-1-stuart.menefy@codasip.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 20 Aug 2024 15:32:32 +0200
X-Gmail-Original-Message-ID: <CAMuHMdW0bnJt5GMRtOZGkTiM7GK4UaLJCDMF_Ouq++fnDKi3_A@mail.gmail.com>
Message-ID: <CAMuHMdW0bnJt5GMRtOZGkTiM7GK4UaLJCDMF_Ouq++fnDKi3_A@mail.gmail.com>
Subject: Re: [PATCH] riscv: Fix linear mapping checks for non-contiguous
 memory regions
To: Stuart Menefy <stuart.menefy@codasip.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	David McKay <david.mckay@codasip.com>, Palmer Dabbelt <palmerdabbelt@google.com>, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Damien Le Moal <dlemoal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Stuart,

On Sat, Jun 22, 2024 at 1:43=E2=80=AFPM Stuart Menefy <stuart.menefy@codasi=
p.com> wrote:
> The RISC-V kernel already has checks to ensure that memory which would
> lie outside of the linear mapping is not used. However those checks
> use memory_limit, which is used to implement the mem=3D kernel command
> line option (to limit the total amount of memory, not its address
> range). When memory is made up of two or more non-contiguous memory
> banks this check is incorrect.
>
> Two changes are made here:
>  - add a call in setup_bootmem() to memblock_cap_memory_range() which
>    will cause any memory which falls outside the linear mapping to be
>    removed from the memory regions.
>  - remove the check in create_linear_mapping_page_table() which was
>    intended to remove memory which is outside the liner mapping based
>    on memory_limit, as it is no longer needed. Note a check for
>    mapping more memory than memory_limit (to implement mem=3D) is
>    unnecessary because of the existing call to
>    memblock_enforce_memory_limit().
>
> This issue was seen when booting on a SV39 platform with two memory
> banks:
>   0x00,80000000 1GiB
>   0x20,00000000 32GiB
> This memory range is 158GiB from top to bottom, but the linear mapping
> is limited to 128GiB, so the lower block of RAM will be mapped at
> PAGE_OFFSET, and the upper block straddles the top of the linear
> mapping.
>
> This causes the following Oops:
> [    0.000000] Linux version 6.10.0-rc2-gd3b8dd5b51dd-dirty (stuart.menef=
y@codasip.com) (riscv64-codasip-linux-gcc (GCC) 13.2.0, GNU ld (GNU Binutil=
s) 2.41.0.20231213) #20 SMP Sat Jun 22 11:34:22 BST 2024
> [    0.000000] memblock_add: [0x0000000080000000-0x00000000bfffffff] earl=
y_init_dt_add_memory_arch+0x4a/0x52
> [    0.000000] memblock_add: [0x0000002000000000-0x00000027ffffffff] earl=
y_init_dt_add_memory_arch+0x4a/0x52
> ...
> [    0.000000] memblock_alloc_try_nid: 23724 bytes align=3D0x8 nid=3D-1 f=
rom=3D0x0000000000000000 max_addr=3D0x0000000000000000 early_init_dt_alloc_=
memory_arch+0x1e/0x48
> [    0.000000] memblock_reserve: [0x00000027ffff5350-0x00000027ffffaffb] =
memblock_alloc_range_nid+0xb8/0x132
> [    0.000000] Unable to handle kernel paging request at virtual address =
fffffffe7fff5350
> [    0.000000] Oops [#1]
> [    0.000000] Modules linked in:
> [    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 6.10.0-rc2-gd3b8dd=
5b51dd-dirty #20
> [    0.000000] Hardware name: codasip,a70x (DT)
> [    0.000000] epc : __memset+0x8c/0x104
> [    0.000000]  ra : memblock_alloc_try_nid+0x74/0x84
> [    0.000000] epc : ffffffff805e88c8 ra : ffffffff806148f6 sp : ffffffff=
80e03d50
> [    0.000000]  gp : ffffffff80ec4158 tp : ffffffff80e0bec0 t0 : fffffffe=
7fff52f8
> [    0.000000]  t1 : 00000027ffffb000 t2 : 5f6b636f6c626d65 s0 : ffffffff=
80e03d90
> [    0.000000]  s1 : 0000000000005cac a0 : fffffffe7fff5350 a1 : 00000000=
00000000
> [    0.000000]  a2 : 0000000000005cac a3 : fffffffe7fffaff8 a4 : 00000000=
0000002c
> [    0.000000]  a5 : ffffffff805e88c8 a6 : 0000000000005cac a7 : 00000000=
00000030
> [    0.000000]  s2 : fffffffe7fff5350 s3 : ffffffffffffffff s4 : 00000000=
00000000
> [    0.000000]  s5 : ffffffff8062347e s6 : 0000000000000000 s7 : 00000000=
00000001
> [    0.000000]  s8 : 0000000000002000 s9 : 00000000800226d0 s10: 00000000=
00000000
> [    0.000000]  s11: 0000000000000000 t3 : ffffffff8080a928 t4 : ffffffff=
8080a928
> [    0.000000]  t5 : ffffffff8080a928 t6 : ffffffff8080a940
> [    0.000000] status: 0000000200000100 badaddr: fffffffe7fff5350 cause: =
000000000000000f
> [    0.000000] [<ffffffff805e88c8>] __memset+0x8c/0x104
> [    0.000000] [<ffffffff8062349c>] early_init_dt_alloc_memory_arch+0x1e/=
0x48
> [    0.000000] [<ffffffff8043e892>] __unflatten_device_tree+0x52/0x114
> [    0.000000] [<ffffffff8062441e>] unflatten_device_tree+0x9e/0xb8
> [    0.000000] [<ffffffff806046fe>] setup_arch+0xd4/0x5bc
> [    0.000000] [<ffffffff806007aa>] start_kernel+0x76/0x81a
> [    0.000000] Code: b823 02b2 bc23 02b2 b023 04b2 b423 04b2 b823 04b2 (b=
c23) 04b2
> [    0.000000] ---[ end trace 0000000000000000 ]---
> [    0.000000] Kernel panic - not syncing: Attempted to kill the idle tas=
k!
> [    0.000000] ---[ end Kernel panic - not syncing: Attempted to kill the=
 idle task! ]---
>
> The problem is that memblock (unaware that some physical memory cannot
> be used) has allocated memory from the top of memory but which is
> outside the linear mapping region.
>
> Signed-off-by: Stuart Menefy <stuart.menefy@codasip.com>
> Fixes: c99127c45248 ("riscv: Make sure the linear mapping does not use th=
e kernel mapping")
> Reviewed-by: David McKay <david.mckay@codasip.com>

Thanks for your patch, which is now commit 3b6564427aea83b7 ("riscv:
Fix linear mapping checks for non-contiguous memory regions") in
v6.11-rc2.

This causes the boot to hang on SiPEED MAiX BiT (K210 64-bit nommu):

Linux version 6.11.0-rc1-k210-00008-g3b6564427aea (geert@rox)
(riscv64-linux-gnu-gcc (Ubuntu 11.4.0-1ubuntu1~22.04) 11.4.0, GNU ld
(GNU Binutils for Ubuntu) 2.38) #452 SMP Tue Aug 20 15:02:49 CEST 2024
Machine model: SiPeed MAIX BiT
Forcing kernel command line to: earlycon console=3DttySIF0 rootdelay=3D2
root=3D/dev/mmcblk0p1 ro
earlycon: sifive0 at MMIO 0x0000000038000000 (options '115200n8')
printk: legacy bootconsole [sifive0] enabled
Zone ranges:
  DMA32    [mem 0x0000000080000000-0x00000000807fffff]
  Normal   empty
Movable zone start for each node
Early memory node ranges
  node   0: [mem 0x0000000080000000-0x00000000807fffff]
Initmem setup node 0 [mem 0x0000000080000000-0x00000000807fffff]
Falling back to deprecated "riscv,isa"
riscv: base ISA extensions acdfim
riscv: ELF capabilities acdfim
percpu: max_distance=3D0x1a000 too large for vmalloc space 0x0
percpu: Embedded 13 pages/cpu s20512 r0 d32736 u53248
percpu: wasting 6 pages per chunk
Kernel command line: earlycon console=3DttySIF0 rootdelay=3D2 root=3D/dev/m=
mcblk0p1 ro
Dentry cache hash table entries: 1024 (order: 1, 8192 bytes, linear)
Inode-cache hash table entries: 512 (order: 0, 4096 bytes, linear)
Built 1 zonelists, mobility grouping off.  Total pages: 2048
mem auto-init: stack:off, heap alloc:off, heap free:off
SLUB: HWalign=3D64, Order=3D0-1, MinObjects=3D0, CPUs=3D2, Nodes=3D1
rcu: Hierarchical RCU implementation.
rcu: RCU calculated value of scheduler-enlistment delay is 25 jiffies.
NR_IRQS: 64, nr_irqs: 64, preallocated irqs: 0

Adding a bit of debug info shows:

    setup_bootmem:236: old phys_ram_end =3D 0x80800000
    setup_bootmem:258: max_mapped_addr =3D 0x7fffffff
    setup_bootmem:259: memblock_cap_memory_range(0x80000000, 0xffffffffffff=
ffff)
    memblock_remove_range:857: Removing region at 0x80000000 size 0x20d1e8
    setup_bootmem:281: new phys_ram_end =3D 0x80800000

> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -233,8 +233,6 @@ static void __init setup_bootmem(void)
>          */
>         memblock_reserve(vmlinux_start, vmlinux_end - vmlinux_start);
>
> -       phys_ram_end =3D memblock_end_of_DRAM();
> -
>         /*
>          * Make sure we align the start of the memory on a PMD boundary s=
o that
>          * at worst, we map the linear mapping with PMD mappings.
> @@ -249,6 +247,16 @@ static void __init setup_bootmem(void)
>         if (IS_ENABLED(CONFIG_64BIT) && IS_ENABLED(CONFIG_MMU))
>                 kernel_map.va_pa_offset =3D PAGE_OFFSET - phys_ram_base;
>
> +       /*
> +        * The size of the linear page mapping may restrict the amount of
> +        * usable RAM.
> +        */
> +       if (IS_ENABLED(CONFIG_64BIT)) {
> +               max_mapped_addr =3D __pa(PAGE_OFFSET) + KERN_VIRT_SIZE;
> +               memblock_cap_memory_range(phys_ram_base,
> +                                         max_mapped_addr - phys_ram_base=
);
> +       }
> +
>         /*
>          * Reserve physical address space that would be mapped to virtual
>          * addresses greater than (void *)(-PAGE_SIZE) because:
> @@ -265,6 +273,7 @@ static void __init setup_bootmem(void)
>                 memblock_reserve(max_mapped_addr, (phys_addr_t)-max_mappe=
d_addr);
>         }
>
> +       phys_ram_end =3D memblock_end_of_DRAM();
>         min_low_pfn =3D PFN_UP(phys_ram_base);
>         max_low_pfn =3D max_pfn =3D PFN_DOWN(phys_ram_end);
>         high_memory =3D (void *)(__va(PFN_PHYS(max_low_pfn)));
> @@ -1289,8 +1298,6 @@ static void __init create_linear_mapping_page_table=
(void)
>                 if (start <=3D __pa(PAGE_OFFSET) &&
>                     __pa(PAGE_OFFSET) < end)
>                         start =3D __pa(PAGE_OFFSET);
> -               if (end >=3D __pa(PAGE_OFFSET) + memory_limit)
> -                       end =3D __pa(PAGE_OFFSET) + memory_limit;
>
>                 create_linear_mapping_range(start, end, 0);
>         }

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

