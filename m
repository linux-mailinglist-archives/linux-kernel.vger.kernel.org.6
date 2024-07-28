Return-Path: <linux-kernel+bounces-264822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E657D93E8D1
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 19:57:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80B67B21360
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 17:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F84A5F873;
	Sun, 28 Jul 2024 17:57:31 +0000 (UTC)
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2BE21DDE9
	for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2024 17:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722189450; cv=none; b=TIGY5knNnj7F2pbsuLZ83Ovw5vhra71gvMj7lFERXDnBv6szQEpdGrTHIL7DcbkPM4e75ruvXsu+fYCQ8q/GsHeeBophbseVMUsHGnNZUGTdqMlFC57Q1AuAwDuNIviPb4ji0ZovtZjFvZVyYzPNhpV/+dl73Hk8xzgazPPyRT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722189450; c=relaxed/simple;
	bh=MF7uqUQrnnHaKcTgTs4jzivn1J/Pg/1eb7JY6+0uSgk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fmn5ugAiGPyWJbeudAXT+Om+ShvueIOk9GWi+PEFSPqeR17jx26Z60qq8mw6NLGMO9PpcLa7lLJ9BwZGPATf2+ECVmUD6OJuv0KeHw9FEF1N63MpDFXqdeO7l46Y6CQB1RKmHhXe7PPwWZmRBxmo+PjcnnmLujrntM2iQDAQUSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e0874f138aeso908751276.2
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2024 10:57:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722189446; x=1722794246;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zcg9LIQXoJDKfkFjcw9/cA1s5xsMs520Cc5HCM8x/aA=;
        b=UEyGQt8TaGbWudLC8S+HbsacdG2KgwKma41aZQ1bn1vgwYlxtnBiyoHB6iDTY09jZh
         t41pfHoGHXUHx7mnpuZ7L9Y+ZqWqCMVLXRrd5I2ytS+DlpU0CabxLOHb+L0bMzXqtkve
         QQZQELzEgljv4w4J3B6Zqw6HbsxgcXR8lcQnk+uHwuKMjP6lEpSb5m9tGGUpPRTSNFoS
         oXSzb4iW9Dv+PIaOHGnSVubPubHCP+i/vfjSCebfObMWniqNDofPI6PlWnf6HCToUXQE
         Ltz7u5y+6WVFdrw0cu/+pwvdLbmIDoCe5lJB0qpoIiSgUeti1ZxbkeufizQIQQmZb/2Y
         z9IQ==
X-Forwarded-Encrypted: i=1; AJvYcCXq8roQnfMi/SKf8ujJZIC7ICUz4Z1/4620QDbkPujvkqvtWg07uMILiroL+Rpe338UTatcqusjWB2UvIu/D4tlVnAuBihL4IlRUWez
X-Gm-Message-State: AOJu0YyOB3eVe66t+fuD3kj9vnZIxfieQuZVZWTzhkFOXaYFG0d1F/OI
	cq1VSnP7K1gBMGCzVVz99W+mMziYxHwv0XU4hxPO6lGC6y/g72uI4WpKsY4M
X-Google-Smtp-Source: AGHT+IEDuzUge6/4PFU6LLI/nqJDasYtX9m7M1LmFm4mb/RaWW5ARkJbi5mt2TkqJ9PzsaWtEAgWtA==
X-Received: by 2002:a05:6902:2d05:b0:dfe:fac8:b890 with SMTP id 3f1490d57ef6-e0b54548bcemr3935651276.28.1722189446375;
        Sun, 28 Jul 2024 10:57:26 -0700 (PDT)
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com. [209.85.128.170])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e0b2a70d174sm1513555276.47.2024.07.28.10.57.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Jul 2024 10:57:24 -0700 (PDT)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-65fe1239f12so8589897b3.0
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2024 10:57:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUyKaZFGw2UQiu9tnaROUpZdt3a5V1kx21sJSjfPFyXFcRIqVzBvkEFh3UQZUOshAlNsMgpT6d0pCeVphDG5WVWcXB5rI0XbDT1848p
X-Received: by 2002:a05:690c:a85:b0:648:857c:1530 with SMTP id
 00721157ae682-67a0919aebcmr45656887b3.34.1722189444496; Sun, 28 Jul 2024
 10:57:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <23bdb6fc8d884ceebeb6e8b8653b8cfe@AcuMS.aculab.com>
 <902a9bf3-9404-44e8-9063-03da3168146a@lucifer.local> <CAHk-=wjCV+RmhWjh2Dsdki6FfqZDkM9JMQ=Qw9zGmGQD=ir6cw@mail.gmail.com>
 <b8722427-cf1e-459f-8bad-04f89fb5ffc6@lucifer.local> <CAHk-=whsMPLro6RDY7GrjvXpy+WYPOL-AW5jrzwZ8P4GPBHxag@mail.gmail.com>
 <137646a7-7017-490d-be78-5bd5627609c3@lucifer.local>
In-Reply-To: <137646a7-7017-490d-be78-5bd5627609c3@lucifer.local>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sun, 28 Jul 2024 19:57:11 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXCuF4ikx7uR_fG=EAPOf+1T0JoHTMOyqfS6eUcvS-piw@mail.gmail.com>
Message-ID: <CAMuHMdXCuF4ikx7uR_fG=EAPOf+1T0JoHTMOyqfS6eUcvS-piw@mail.gmail.com>
Subject: Re: [PATCH 0/7] minmax: reduce compilation time
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Linus Torvalds <torvalds@linuxfoundation.org>, David Laight <David.Laight@aculab.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Christoph Hellwig <hch@infradead.org>, 
	Andrew Morton <akpm@linux-foundation.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Arnd Bergmann <arnd@kernel.org>, 
	"Jason@zx2c4.com" <Jason@zx2c4.com>, "pedro.falcato@gmail.com" <pedro.falcato@gmail.com>, 
	Mateusz Guzik <mjguzik@gmail.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Lorenzo,

On Fri, Jul 26, 2024 at 8:57=E2=80=AFPM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
> On Fri, Jul 26, 2024 at 11:24:09AM GMT, Linus Torvalds wrote:
> > On Fri, 26 Jul 2024 at 11:13, Lorenzo Stoakes
> > <lorenzo.stoakes@oracle.com> wrote:
> > >
> > > 5,447,539       ./arch/x86/xen/setup.o.pre
> >
> > Can you perhaps do some kind of "max expansion" on all the
> > preprocessor files (you seem to have done it by changing the ".c.o"
> > rule to just spit it out as "o.pre", which sounds fine).
>
> Yeah I simply hacked in a gcc -E, ugly but effective, e.g. prepending
> cmd_cc_o_c in scripts/Makefile.build with:
>
> cmd_cc_o_c =3D $(CC) $(c_flags) -E $< > $@.pre; \

Kbuild already knows how to build a preprocessed file (.i),
so making any .o depend on its .i should work, too?

Or am I missing something?

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

