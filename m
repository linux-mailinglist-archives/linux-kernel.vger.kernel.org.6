Return-Path: <linux-kernel+bounces-194994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A5CA8D45BE
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 09:07:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD93F1C21738
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 07:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DB133DAC00;
	Thu, 30 May 2024 07:07:15 +0000 (UTC)
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103D6143727;
	Thu, 30 May 2024 07:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717052834; cv=none; b=B6ad1n81b7jeiyx5UjFz/39If3qb9croY9rHPCnfxcv50jTx0aHs6Tn9n2lE/f3IDNsWLhC1rRRPTnCQFstuv9OC6ve2tk1XHDHULaeR+ziIVCMKpfa3meW0/5ESkoLmaMZ+E952l/uZ6JHde7g3VDj25OHVUr1OL903CiPX+O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717052834; c=relaxed/simple;
	bh=KNiqV7WavJ5PvJYFlyA+wCB6yEoBuyccGApzFRKDKIE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hbJX6m3CkNjz8efLqz5Y3O2oIhzjJlmb8Sp+Pb7ipf1vuUqgFZ6Y+x4awAzbu8luaIdNrDwjDTKKuysLDhvGt3ILIw21ltnnFnNx09ML1m/jUG3aRC1TUKewOSBm+LpzKj32aw/CxIdx0kTqBfbQsLuE58AGsqM/Tl5KLOjUwL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-62a0809c805so6067387b3.0;
        Thu, 30 May 2024 00:07:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717052829; x=1717657629;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vAy8uLPyjowTa0vjGx1V4wDXEpWsDdyakMo2ioajcOI=;
        b=Oz2E5ttuK2devnaAJ9jQm0n0EFb/Zz+1bdnQxndjGz0TyyY11xsMCM5zp9FnP+1ehF
         b89APM1vx/a7LRWWdBDHxGgixTIv/QltE0DVwlYE0R4wqKaQjP4d5BjdBb8CuNK9hNn3
         wvswYNGrAXpuZIL7TZK3VZcWM4U28XoU5oqappZMM4Lv4/AH7z6UZD/D7TEJHeGnV+Kj
         pWcEJyvR+jNvbCXhPpiZud403B8urrvzm/E0Yx7UsC7olDFVUAyic1JgS0k2JHIDS5l2
         ZKxY5XSi9yhEmQp/fHK+j43/yWEJNNZbZaLjObuGAWLqAe4ogujlzn/R1qXrWrW5WKsm
         mPrQ==
X-Forwarded-Encrypted: i=1; AJvYcCWa69Qh246TMBC8Y/bKZSObDD0hWP/ZgUdyhD7DSFTqGG8mMFUzV0DZABet4RU60owrR6gIjT6DhJqo3krULrBzTN4AUpea3WXLCw643blzbHTgp+QyLZAkKbS5x1kytC27RO8Y7Bb/nw==
X-Gm-Message-State: AOJu0Yx4RPq8bMJULGDPyca3qODzRdTe2YAi4UVAH2KsW9RvN1dtiDB0
	6HO9zB6YUl2Fwy6cwj2GVeq9qfldYZme7NaZh0z2yFF1DRe9Wv+T5Es43E17
X-Google-Smtp-Source: AGHT+IGF0kLmyMwcX1RKESir3JFNlfhm400IDr5BBc1sBnUUxdvNnamjhlY5KgxvjFGVwRUuRrSozQ==
X-Received: by 2002:a81:6d17:0:b0:61b:e732:b7bf with SMTP id 00721157ae682-62c6bc77b8bmr13942547b3.31.1717052829443;
        Thu, 30 May 2024 00:07:09 -0700 (PDT)
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com. [209.85.219.180])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-62a0a52cd83sm26733267b3.107.2024.05.30.00.07.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 May 2024 00:07:08 -0700 (PDT)
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-df4df150f29so477919276.0;
        Thu, 30 May 2024 00:07:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVzvrEQpYIQ/J7WrRl7pRnm1UlsyIQfJP5LEPIauh88NXo08wdAduzgloOsEHDNJG1ivJClaTSCoA81qslLmTuzrGpg4Q8o5fobXpHWCjWN++9aPxEu0Y2AkFC7o60Zbf03+KahurpebA==
X-Received: by 2002:a25:ac8c:0:b0:de5:50a7:bc9a with SMTP id
 3f1490d57ef6-dfa5a595285mr1543101276.5.1717052828033; Thu, 30 May 2024
 00:07:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240222094006.1030709-1-apatel@ventanamicro.com>
 <20240222094006.1030709-2-apatel@ventanamicro.com> <CAMuHMdVYFFR7K5SbHBLY-JHhb7YpgGMS_hnRWm8H0KD-wBo+4A@mail.gmail.com>
 <11b3de44-522b-4638-987c-2ca132e84936@sifive.com>
In-Reply-To: <11b3de44-522b-4638-987c-2ca132e84936@sifive.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 30 May 2024 09:06:54 +0200
X-Gmail-Original-Message-ID: <CAMuHMdV5jcbiHzYx=nqFHLLZ96u614zksSB5Vi9FVaOb_YMeiQ@mail.gmail.com>
Message-ID: <CAMuHMdV5jcbiHzYx=nqFHLLZ96u614zksSB5Vi9FVaOb_YMeiQ@mail.gmail.com>
Subject: Re: [PATCH v14 01/18] irqchip/sifive-plic: Convert PLIC driver into a
 platform driver
To: Samuel Holland <samuel.holland@sifive.com>
Cc: Anup Patel <apatel@ventanamicro.com>, devicetree@vger.kernel.org, 
	Conor Dooley <conor+dt@kernel.org>, Emil Renner Berthing <kernel@esmil.dk>, 
	Saravana Kannan <saravanak@google.com>, Marc Zyngier <maz@kernel.org>, Anup Patel <anup@brainfault.org>, 
	Atish Patra <atishp@atishpatra.org>, linux-kernel@vger.kernel.org, 
	=?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	Rob Herring <robh+dt@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Frank Rowand <frowand.list@gmail.com>, linux-riscv@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, Andrew Jones <ajones@ventanamicro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Samuel,

On Thu, May 30, 2024 at 12:04=E2=80=AFAM Samuel Holland
<samuel.holland@sifive.com> wrote:
> On 2024-05-29 9:22 AM, Geert Uytterhoeven wrote:
> > On Thu, Feb 22, 2024 at 10:41=E2=80=AFAM Anup Patel <apatel@ventanamicr=
o.com> wrote:
> >> The PLIC driver does not require very early initialization so convert
> >> it into a platform driver.
> >>
> >> After conversion, the PLIC driver is probed after CPUs are brought-up
> >> so setup cpuhp state after context handler of all online CPUs are
> >> initialized otherwise PLIC driver crashes for platforms with multiple
> >> PLIC instances.
> >>
> >> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> >
> > Thanks for your patch, which is now commit 8ec99b033147ef3b
> > ("irqchip/sifive-plic: Convert PLIC driver into a platform
> > driver") in v6.9.
> >
> > It looks like this conversion is causing issues on BeagleV Starlight
> > Beta.  After updating esmil/visionfive to v6.10-rc1, the kernel usually
> > fails to boot. Adding "earlycon keep_bootcon" reveals these differences=
:
> >
> > -riscv-plic c000000.interrupt-controller: mapped 133 interrupts with 2
> > handlers for 4 contexts.
> > +------------[ cut here ]------------
> > +WARNING: CPU: 0 PID: 1 at drivers/irqchip/irq-sifive-plic.c:373

> > +Unable to handle kernel NULL pointer dereference at virtual address

> The fact that you hit the warning indicates that plic_handle_irq() was ca=
lled
> before handler->present was set. Previously the PLIC driver was probed ve=
ry
> early, so it is unlikely that some peripheral already had a pending inter=
rupt.
> Now, while platform device drivers would not yet be able to request inter=
rupts
> (because the irqdomain is not registered yet), they could have programmed=
 the
> hardware in a way that generates an interrupt. If that interrupt was enab=
led at
> the PLIC (e.g. by the bootloader), then we could expect plic_handle_irq()=
 to be
> called as soon as irq_set_chained_handler() is called.
>
> So the fix is to not call irq_set_chained_handler() until after the handl=
ers are
> completely set up.
>
> I've sent a patch doing this:
> https://lore.kernel.org/linux-riscv/20240529215458.937817-1-samuel.hollan=
d@sifive.com/

Thanks, that fixed the issue!

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

