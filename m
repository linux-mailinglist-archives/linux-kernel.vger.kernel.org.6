Return-Path: <linux-kernel+bounces-195000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B292A8D45D8
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 09:13:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 706CE1F2331D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 07:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDE974D8B4;
	Thu, 30 May 2024 07:13:39 +0000 (UTC)
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F307D4D8A1
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 07:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717053219; cv=none; b=Ge4rkdHwDN80oaZJGFL/0mV5MFpHJjF7x+hGGvo2ukl1FtKNwJJwGlG3xIkJaYJo+D0gQTKK21+YpERQ6GUns1qZf+eSqCV1m1YRMh4j8UNGnVS/M/4by4SmAKf3BIO4md2WZNsiGGK33QCYo2H+ySF7wacg+WUiDCmmApRF3y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717053219; c=relaxed/simple;
	bh=ivRWiwAgs5ohrh+4SIA7nks/H1zfgLs/tv0KyDBF7IM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dMi6PCZWv1upU32B0MRN+Zak4Tk8D0gbh6Zc3FzfXjQsEwZQJ9bBWFXsMlFcCIKEn3RKgt9IlnFS8Rx1ZkczDm39kVzzf/z+GMfLgqJRgW4kwwIZs9EiF1SgQgeRuShY0uxKodQwlTmKOuQdztwL/MC59KGRJXcv9DYo/5XWjCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-62a0827316eso5229827b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 00:13:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717053216; x=1717658016;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6F3VqP7Q2oLA+uLC5C8SWEiyXRUAjqkP7GVUyyrZleE=;
        b=KX4fVccgT6CjLFPgTtxPNbLjOcRfo5McsbQzQ7RpHbd6wjY5KIi8oW3CRTxzc9gBTY
         ef3rOggbVOY7a0eob+PWYjxXn6jrF6KGvwtKzE+GzPyw7ssPfozklm5xNRn8Zh5Z0Ftg
         QN4uGRgUXog3BcFp5e8d4Ym3gTKB8oIQYF1iVBgWv/MYVzfnCC54XkoXGYtMvG2ExQH3
         B6jgFeiJg56Tu1L8dad9ILR8ntaz9r3aqdtVLnUvGHnzoALHnXAklvvhLUCIsG7KkDe7
         GbNoTfeL06cH26XoqKVrm/VrHYx2LigiOI5PDocp2iNaKYnumd2wRlvth0/au4oWbMvg
         H6dQ==
X-Forwarded-Encrypted: i=1; AJvYcCWFtHsrd1DEVRGmE11ehIld0qAACL6pvSisTDuEyDxsY30HWYNQ2p4RDEeWyjYB83IQshowqkTCNR14u0z9kcYc39uhIJArY8aQVBJG
X-Gm-Message-State: AOJu0Yz0kmI8qzUjxM7n8x9N/a6GfqD0ONjvz6VFLwC2OmiJKNcwKXt+
	f4g6IlKCSVd+p/MaeF/z/aXeN/XABZbruVNjYRxENlvMTe+WRKGkD6WoYtME
X-Google-Smtp-Source: AGHT+IHve8BW5hpgj5QorPYvzjzo8eFG6blOzxJov1EYhwcMXcxYplLelVcpC5OmkqSYQU9PjBHGsw==
X-Received: by 2002:a0d:d90b:0:b0:619:5176:5e34 with SMTP id 00721157ae682-62c6bbff1a6mr13816357b3.18.1717053216022;
        Thu, 30 May 2024 00:13:36 -0700 (PDT)
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com. [209.85.219.179])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-62a0a40276asm27070037b3.58.2024.05.30.00.13.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 May 2024 00:13:35 -0700 (PDT)
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-dfa49a90146so494281276.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 00:13:35 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWFuIU77OHbXukKBt/sEPKaeYr7VozJNRoPP/DxBmEHwkQ6vog2CEgyv21CpioOemsYTqCoVru7OCrP+ZhNT4XBdN4b/QxH6AAdRxtm
X-Received: by 2002:a25:53c9:0:b0:de5:4ab8:317f with SMTP id
 3f1490d57ef6-dfa5a5da05amr1478827276.20.1717053215497; Thu, 30 May 2024
 00:13:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240529215458.937817-1-samuel.holland@sifive.com>
In-Reply-To: <20240529215458.937817-1-samuel.holland@sifive.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 30 May 2024 09:13:23 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVLgpxPCK0chTY=GvMVPgF5G1Oyj=XXoJZBORvH5shFxQ@mail.gmail.com>
Message-ID: <CAMuHMdVLgpxPCK0chTY=GvMVPgF5G1Oyj=XXoJZBORvH5shFxQ@mail.gmail.com>
Subject: Re: [PATCH] irqchip/sifive-plic: Chain to parent IRQ after handlers
 are ready
To: Samuel Holland <samuel.holland@sifive.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Albert Ou <aou@eecs.berkeley.edu>, 
	Anup Patel <apatel@ventanamicro.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Samuel,

On Wed, May 29, 2024 at 11:55=E2=80=AFPM Samuel Holland
<samuel.holland@sifive.com> wrote:
> Now that the PLIC uses a platform driver, the driver probed later in the
> boot process, where interrupts from peripherals might already be
> pending. As a result, plic_handle_irq() may be called as early as the
> call to irq_set_chained_handler(). But this call happens before the
> per-context handler is completely set up, so there is a window where
> plic_handle_irq() can see incomplete per-context state and crash. Avoid
> this by delaying the call to irq_set_chained_handler() until all
> handlers from all PLICs are initialized.
>
> Fixes: 8ec99b033147 ("irqchip/sifive-plic: Convert PLIC driver into a pla=
tform driver")
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Closes: https://lore.kernel.org/r/CAMuHMdVYFFR7K5SbHBLY-JHhb7YpgGMS_hnRWm=
8H0KD-wBo+4A@mail.gmail.com/
> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>

Thanks for your patch!

This fixes the issue I was seering on Starlight, and does not seem to
cause regressions on RZ/Five, Icicle, K210, or VexRiscV.

Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

