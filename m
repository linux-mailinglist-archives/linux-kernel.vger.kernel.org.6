Return-Path: <linux-kernel+bounces-194257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E7738D3905
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 16:22:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E862C2828C8
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 14:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A735157A56;
	Wed, 29 May 2024 14:22:19 +0000 (UTC)
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B5D15749C;
	Wed, 29 May 2024 14:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716992538; cv=none; b=fMEbEluHbZdZzcauKeoMAVIRnfFOnDFM5B3UBNgd9BnpVEmcjr9UAKO8BSxv+yp7IR7J6296q7YzfupkuWLHQz4vGHJCsND6eZjSdwNpS+76dI2COl5cbLv8sNIGs0jFiWcYFVIkUk1bExv6dXQi3w3Ck3nHqFd3zpf5cvt/yLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716992538; c=relaxed/simple;
	bh=83fhoTPqRXviCa7cwFvUF2P6d4xJekaavUgYbIg7Mjg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kd+5WXWEzUvjxDBisWl5Rpy8dwKZnH4VmD/T9mJpBMKwMn5zQ/STchqXm9EKClFD7C+/nkqVxYphz8mI9/RJHGtFSvP9ijfeuNsm/QKnwRODaMBffV+avd54MupF+F47lOJfdbgY8aFeNDLEG/TMwlo/yCSD1p0xVV5An8RmaNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-62a0873c6e4so21655307b3.3;
        Wed, 29 May 2024 07:22:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716992535; x=1717597335;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZhFBRfdhny2Bdj9xeQJ2Gk+dh8Rw9f9PCqy5yikLoYY=;
        b=f8ta4ZIgAqkne64YVimFI6flj1aBFTF/x5taio4I/xzAR7kD1PowsQcV+ZRD7yn946
         LhIo1/DA6KMpUncEhyEyJWt/gcFbMq0JOxCzd7wGrjKf4J8iYVqp5H/e7cwHP56jDy0D
         7WKuy7Jlez3M3CyBc0D9VB3VOVfBmfylIsnggbP+DOOXv1Vq/QWYrdHddLcMUokZpSSG
         GxLH6Wx+H3MMqqmuTK5mRIbaW4nA8cgeDy3/UgtG8Q/+KwCInKhWKVTpktX465+K/0gk
         SC8bPnQaer0So/sdaO27AoEOxt9ECebN18XG7XdjlXriautvQNTpJEEu8PQa1Zi5ohke
         3EBg==
X-Forwarded-Encrypted: i=1; AJvYcCUzMOyNSYjpNxGP+MRF1m4vIiGcgRycmEGcm4imXIpspyT/9lo2sUMUnQ7SsWO/6ljVxIwn+aY/TskARaIKXZkHn7d3cTkKIbcVngFKUwoFML43UkwMwzNkARHwrN0PWRncIwvEBySbOA==
X-Gm-Message-State: AOJu0YwD2nONmR5ff38Um7AKwp+FHFA8yzMdsWlUUIIYV/cp5TtOgFuU
	0Ptf1oCXuJTVPdYosYrTFh1Jdu0pOgiOHBCbKawA7tctxzeLGdyV3dL2QVKH
X-Google-Smtp-Source: AGHT+IHGWy9z5cGj4tv60xmxcj5U2z/MaLI7Ss9lpBnz8waGjh2OEeTOFnucOw5ygoXGNFsWVa4mvg==
X-Received: by 2002:a05:690c:802:b0:627:7871:e172 with SMTP id 00721157ae682-62a08fdc095mr173307547b3.51.1716992534587;
        Wed, 29 May 2024 07:22:14 -0700 (PDT)
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com. [209.85.219.173])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-62a0a37d5d0sm24494997b3.16.2024.05.29.07.22.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 May 2024 07:22:14 -0700 (PDT)
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-df771b6cc9cso2184191276.3;
        Wed, 29 May 2024 07:22:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUpYJg6HB8Zj41djCVjmLQmvPVNq1of/dRJZDDmNpfU4qyNerXky2h3hA7GhfqcSqSgNzvaSNPshtceDnf0o10xZ1FjfuMfokHF7qKkmzKR9AOfnMTKSu576SNTEEvpIK8khsXr+pjHbg==
X-Received: by 2002:a25:2f91:0:b0:dcd:a9ad:7d67 with SMTP id
 3f1490d57ef6-df772166ff3mr17433131276.8.1716992534038; Wed, 29 May 2024
 07:22:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240222094006.1030709-1-apatel@ventanamicro.com> <20240222094006.1030709-2-apatel@ventanamicro.com>
In-Reply-To: <20240222094006.1030709-2-apatel@ventanamicro.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 29 May 2024 16:22:01 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVYFFR7K5SbHBLY-JHhb7YpgGMS_hnRWm8H0KD-wBo+4A@mail.gmail.com>
Message-ID: <CAMuHMdVYFFR7K5SbHBLY-JHhb7YpgGMS_hnRWm8H0KD-wBo+4A@mail.gmail.com>
Subject: Re: [PATCH v14 01/18] irqchip/sifive-plic: Convert PLIC driver into a
 platform driver
To: Anup Patel <apatel@ventanamicro.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Frank Rowand <frowand.list@gmail.com>, 
	Conor Dooley <conor+dt@kernel.org>, Marc Zyngier <maz@kernel.org>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	Atish Patra <atishp@atishpatra.org>, Andrew Jones <ajones@ventanamicro.com>, 
	Sunil V L <sunilvl@ventanamicro.com>, Saravana Kannan <saravanak@google.com>, 
	Anup Patel <anup@brainfault.org>, linux-riscv@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, Emil Renner Berthing <kernel@esmil.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Anup,

On Thu, Feb 22, 2024 at 10:41=E2=80=AFAM Anup Patel <apatel@ventanamicro.co=
m> wrote:
> The PLIC driver does not require very early initialization so convert
> it into a platform driver.
>
> After conversion, the PLIC driver is probed after CPUs are brought-up
> so setup cpuhp state after context handler of all online CPUs are
> initialized otherwise PLIC driver crashes for platforms with multiple
> PLIC instances.
>
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>

Thanks for your patch, which is now commit 8ec99b033147ef3b
("irqchip/sifive-plic: Convert PLIC driver into a platform
driver") in v6.9.

It looks like this conversion is causing issues on BeagleV Starlight
Beta.  After updating esmil/visionfive to v6.10-rc1, the kernel usually
fails to boot. Adding "earlycon keep_bootcon" reveals these differences:

-riscv-plic c000000.interrupt-controller: mapped 133 interrupts with 2
handlers for 4 contexts.
+------------[ cut here ]------------
+WARNING: CPU: 0 PID: 1 at drivers/irqchip/irq-sifive-plic.c:373
plic_handle_irq+0xf2/0xf6
+Modules linked in:
+CPU: 0 PID: 1 Comm: swapper/0 Not tainted
6.10.0-rc1-starlight-02342-g0ba4c76ca0e8-dirty #323
+Hardware name: BeagleV Starlight Beta (DT)
+epc : plic_handle_irq+0xf2/0xf6
+ ra : generic_handle_domain_irq+0x1c/0x2a
+epc : ffffffff8033f994 ra : ffffffff8006319a sp : ffffffc800003f50
+ gp : ffffffff812d63f0 tp : ffffffd8800b8000 t0 : 0000000000000040
+ t1 : 0000000000000000 t2 : 0000000000001000 s0 : ffffffc800003fa0
+ s1 : 0000000000000009 a0 : ffffffd880183600 a1 : 0000000000000009
+ a2 : 0000000000000000 a3 : 0000000000000000 a4 : 0000000000000000
+ a5 : 0000000000000000 a6 : ffffffd880400248 a7 : ffffffd8804002b8
+ s2 : ffffffd9f8fac458 s3 : 0000000000000004 s4 : 0000000000000000
+ s5 : ffffffff81293f58 s6 : ffffffd88014ac00 s7 : 0000000000000004
+ s8 : ffffffc800013b2c s9 : ffffffc800013b34 s10: 0000000000000006
+ s11: ffffffd9f8fc1458 t3 : 0000000000000002 t4 : 0000000000000402
+ t5 : ffffffd8800610c0 t6 : ffffffd8800610e0
+status: 0000000200000100 badaddr: ffffffd9f8fac458 cause: 0000000000000003
+[<ffffffff8033f994>] plic_handle_irq+0xf2/0xf6
+[<ffffffff8006319a>] generic_handle_domain_irq+0x1c/0x2a
+[<ffffffff8033d7aa>] riscv_intc_irq+0x26/0x60
+[<ffffffff806c92ee>] handle_riscv_irq+0x4a/0x74
+[<ffffffff806d2346>] call_on_irq_stack+0x32/0x40
+---[ end trace 0000000000000000 ]---
+Unable to handle kernel NULL pointer dereference at virtual address
0000000000000004
+Oops [#1]
+Modules linked in:
+CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W
6.10.0-rc1-starlight-02342-g0ba4c76ca0e8-dirty #323
+Hardware name: BeagleV Starlight Beta (DT)
+epc : plic_handle_irq+0x66/0xf6
+ ra : generic_handle_domain_irq+0x1c/0x2a
+epc : ffffffff8033f908 ra : ffffffff8006319a sp : ffffffc800003f50
+ gp : ffffffff812d63f0 tp : ffffffd8800b8000 t0 : 0000000000000040
+ t1 : 0000000000000000 t2 : 0000000000001000 s0 : ffffffc800003fa0
+ s1 : 0000000000000009 a0 : ffffffd880183600 a1 : 0000000000000009
+ a2 : 0000000000000000 a3 : 0000000000000000 a4 : 0000000000000000
+ a5 : ffffffff8033d72a a6 : ffffffd880400248 a7 : ffffffd8804002b8
+ s2 : ffffffd9f8fac458 s3 : 0000000000000004 s4 : ffffffd880183630
+ s5 : ffffffff81293f58 s6 : ffffffff812948a0 s7 : ffffffff80c4e660
+ s8 : ffffffff80d9eea0 s9 : ffffffc800013b34 s10: 0000000000000006
+ s11: ffffffd9f8fc1458 t3 : 0000000000000002 t4 : 0000000000000402
+ t5 : ffffffd8800610c0 t6 : ffffffd8800610e0
+status: 0000000200000100 badaddr: 0000000000000004 cause: 000000000000000d
+[<ffffffff8033f908>] plic_handle_irq+0x66/0xf6
+[<ffffffff8006319a>] generic_handle_domain_irq+0x1c/0x2a
+[<ffffffff8033d7aa>] riscv_intc_irq+0x26/0x60
+[<ffffffff806c92ee>] handle_riscv_irq+0x4a/0x74
+[<ffffffff806d2346>] call_on_irq_stack+0x32/0x40
+Code: 8b93 d70b 5b17 00f5 0b13 fa8b fc17 00a5 0c13 5a0c (a783) 0009
+---[ end trace 0000000000000000 ]---
+Kernel panic - not syncing: Fatal exception in interrupt
+SMP: stopping secondary CPUs
+---[ end Kernel panic - not syncing: Fatal exception in interrupt ]---

As "mapped 133 interrupts" is no longer printed, it looks like an
unexpected early interrupt comes in while still in plic_probe().

Esmil suggested reverting all of:
a7fb69ffd7ce438a irqchip/sifive-plic: Avoid explicit cpumask allocation on =
stack
abb7205794900503 irqchip/sifive-plic: Improve locking safety by using
irqsave/irqrestore
95652106478030f5 irqchip/sifive-plic: Parse number of interrupts and
contexts early in plic_probe()
a15587277a246c38 irqchip/sifive-plic: Cleanup PLIC contexts upon
irqdomain creation failure
6c725f33d67b53f2 irqchip/sifive-plic: Use riscv_get_intc_hwnode() to
get parent fwnode
b68d0ff529a939a1 irqchip/sifive-plic: Use devm_xyz() for managed allocation
25d862e183d4efeb irqchip/sifive-plic: Use dev_xyz() in-place of pr_xyz()
8ec99b033147ef3b irqchip/sifive-plic: Convert PLIC driver into a platform d=
river

After this, the PLIC is initialized earlier again, and this indeed
seems to fix the issue for me.
Before, the kernel booted fine in only ca. 1 out of 5 tries.
After the reverts, it booted 5/5.

Do you know what's going on? Is there a simpler fix?

Thanks!

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

