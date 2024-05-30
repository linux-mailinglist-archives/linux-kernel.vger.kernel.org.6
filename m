Return-Path: <linux-kernel+bounces-194953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 614568D44D5
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 07:35:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 167EE1F23248
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 05:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE013143C54;
	Thu, 30 May 2024 05:35:51 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BBA9143881
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 05:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717047351; cv=none; b=bO3G2BGJ4zF9O3KfE0Zy1KH/bgWBS2lyJy9GdJzraT36Uf++sy/UQ9ibx9m7F2G7+QeeOl478ixjRNW8YpycvFrXKYv6mwa9qYOv7ea266pXODXafwHvgxWQ8wkGeR33VJ9H0Bc6txBVSIoXuuKL9YI6Ao5Px9SufU4/uRw4uiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717047351; c=relaxed/simple;
	bh=KnUZHp13dS77ruhiqaUUV7kRUy1j62cNhux/gUno07M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LCgaIgM+XfD+nhUNoGX/GGKJcchgQGwr1UUIT1Lgd9Fxsnrf03/Cek+w9R3KiglIUeaaUB+/b8Dj3LH21DsUL3vcsZxhfBhFcEZRmyu69U1oY2bBn8x0bCh+xaUyPeen6WxQoxvE5KQxIlIWlZT9Y6L8H8XgsYKWWWjUsHdFhPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [209.85.222.41])
	by gateway (Coremail) with SMTP id _____8Ax3eoxEFhmmn8BAA--.6460S3;
	Thu, 30 May 2024 13:35:46 +0800 (CST)
Received: from mail-ua1-f41.google.com (unknown [209.85.222.41])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8AxDMctEFhmNOINAA--.36480S3;
	Thu, 30 May 2024 13:35:42 +0800 (CST)
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-804ee8b03afso182360241.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 22:35:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUL5jEsDDL23vm6yXhDetmjZhI1t8Pl8F3VPq+o9HURDj32K7a8i6UJnrET7BoUHJ/zFt2OpN+UTh6dhrI03QnpmoP9L4rDSmco6zvQ
X-Gm-Message-State: AOJu0YxRLaslKwtmvnx1OxGBK5QlZZOB1iD+PCA9C83ux6u2m8MD1Z40
	lskedCWYp0bQwtz9YddLyIrWgn3EPiEl5AOCLKo17U1FpaRRV60hW1NXo4uU+ehqxVn63NJGWIR
	lUxmXyKTDHSqwZqNoGmng5g1oluJPB++p6aN++w==
X-Google-Smtp-Source: AGHT+IHZ8axvx4jJzWGomNL8c+GbmDiaO9PRsPYzYWjOKV+NeSRwIAALP8RQjhFwT0nvL1TaFn2o7uc4LyxEFlKjn9M=
X-Received: by 2002:a25:6986:0:b0:df4:b01b:3d21 with SMTP id
 3f1490d57ef6-dfa5a7db705mr1302353276.49.1717045325049; Wed, 29 May 2024
 22:02:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240522-loongarch-booting-fixes-v3-0-25e77a8fc86e@flygoat.com> <20240522-loongarch-booting-fixes-v3-3-25e77a8fc86e@flygoat.com>
In-Reply-To: <20240522-loongarch-booting-fixes-v3-3-25e77a8fc86e@flygoat.com>
From: WANG Rui <wangrui@loongson.cn>
Date: Thu, 30 May 2024 13:01:54 +0800
X-Gmail-Original-Message-ID: <CAHirt9hbzVxcKzwnSF_5jpwma+kr-WJHBQjc47ojB95Ph9SnqA@mail.gmail.com>
Message-ID: <CAHirt9hbzVxcKzwnSF_5jpwma+kr-WJHBQjc47ojB95Ph9SnqA@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] LoongArch: Fix entry point in image header
To: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: Huacai Chen <chenhuacai@kernel.org>, Binbin Zhou <zhoubinbin@loongson.cn>, 
	loongarch@lists.linux.dev, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CM-TRANSID:AQAAf8AxDMctEFhmNOINAA--.36480S3
X-CM-SenderInfo: pzdqw2txl6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxZF1UWF15KF45Gr45GrykJFc_yoW5CryDpa
	1UAF4DAr48Cr4DJas7Jw45uFyUXwnrW34agasrGFyrCFsFvr18Xr109rZruFyvqw4xK3yS
	qFn0gF12v3WDJ3gCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUvKb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1ln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
	xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j
	6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr4
	1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_Jrv_
	JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17
	CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0
	I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I
	8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU
	0xZFpf9x07jbPEfUUUUU=

On Thu, May 23, 2024 at 6:03=E2=80=AFAM Jiaxun Yang <jiaxun.yang@flygoat.co=
m> wrote:
>
> Currently kernel entry in head.S is in DMW address range,
> firmware is instructed to jump to this address after loading
> the image.
>
> However kernel should not make any assumption on firmware's
> DMW setting, thus the entry point should be a physical address
> falls into direct translation region.
>
> Fix by converting entry address to physical and amend entry
> calculation logic in libstub accordingly.
>
> Cc: stable@vger.kernel.org
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
> v2: Fix efistub
> v3: Move calculation to linker script
> ---
>  arch/loongarch/kernel/head.S             | 2 +-
>  arch/loongarch/kernel/vmlinux.lds.S      | 2 ++
>  drivers/firmware/efi/libstub/loongarch.c | 2 +-
>  3 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/arch/loongarch/kernel/head.S b/arch/loongarch/kernel/head.S
> index c4f7de2e2805..2cdc1ea808d9 100644
> --- a/arch/loongarch/kernel/head.S
> +++ b/arch/loongarch/kernel/head.S
> @@ -22,7 +22,7 @@
>  _head:
>         .word   MZ_MAGIC                /* "MZ", MS-DOS header */
>         .org    0x8
> -       .dword  kernel_entry            /* Kernel entry point */
> +       .dword  _kernel_entry_phys      /* Kernel entry point (physical a=
ddress) */
>         .dword  _kernel_asize           /* Kernel image effective size */
>         .quad   PHYS_LINK_KADDR         /* Kernel image load offset from =
start of RAM */
>         .org    0x38                    /* 0x20 ~ 0x37 reserved */
> diff --git a/arch/loongarch/kernel/vmlinux.lds.S b/arch/loongarch/kernel/=
vmlinux.lds.S
> index e8e97dbf9ca4..c6f89e51257a 100644
> --- a/arch/loongarch/kernel/vmlinux.lds.S
> +++ b/arch/loongarch/kernel/vmlinux.lds.S
> @@ -6,6 +6,7 @@
>
>  #define PAGE_SIZE _PAGE_SIZE
>  #define RO_EXCEPTION_TABLE_ALIGN       4
> +#define TO_PHYS_MASK                   0x000fffffffffffff /* 48-bit */
>
>  /*
>   * Put .bss..swapper_pg_dir as the first thing in .bss. This will
> @@ -142,6 +143,7 @@ SECTIONS
>
>  #ifdef CONFIG_EFI_STUB
>         /* header symbols */
> +       _kernel_entry_phys =3D kernel_entry & TO_PHYS_MASK;

 -       _kernel_entry_phys =3D kernel_entry & TO_PHYS_MASK;
 +       _kernel_entry_phys =3D ABSOLUTE(kernel_entry & TO_PHYS_MASK);

>         _kernel_asize =3D _end - _text;
>         _kernel_fsize =3D _edata - _text;
>         _kernel_vsize =3D _end - __initdata_begin;
> diff --git a/drivers/firmware/efi/libstub/loongarch.c b/drivers/firmware/=
efi/libstub/loongarch.c
> index 684c9354637c..60c145121393 100644
> --- a/drivers/firmware/efi/libstub/loongarch.c
> +++ b/drivers/firmware/efi/libstub/loongarch.c
> @@ -41,7 +41,7 @@ static efi_status_t exit_boot_func(struct efi_boot_memm=
ap *map, void *priv)
>  unsigned long __weak kernel_entry_address(unsigned long kernel_addr,
>                 efi_loaded_image_t *image)
>  {
> -       return *(unsigned long *)(kernel_addr + 8) - VMLINUX_LOAD_ADDRESS=
 + kernel_addr;
> +       return *(unsigned long *)(kernel_addr + 8) - TO_PHYS(VMLINUX_LOAD=
_ADDRESS) + kernel_addr;
>  }
>
>  efi_status_t efi_boot_kernel(void *handle, efi_loaded_image_t *image,
>
> --
> 2.43.0
>
>

- Rui


