Return-Path: <linux-kernel+bounces-281949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB4A994DD61
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 16:55:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7641E1F218AB
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 14:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A27F15FCEA;
	Sat, 10 Aug 2024 14:55:11 +0000 (UTC)
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0E41C28E
	for <linux-kernel@vger.kernel.org>; Sat, 10 Aug 2024 14:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723301710; cv=none; b=F8gdudOaisfQGOHlpJdnt6mLnlTaB1jUTc4z7U1Y54thOSYOMg+oje0Ix7RRxlpL5DOuoPiEBi5b5NSQaxaY96bO0xx8ofBWYNSQz+DNOETJvco9TEUAYy7flOyEM3BE7sinKgeXu/acjFVSqwGojzG1l4s7qkQA6yw6tTWwi/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723301710; c=relaxed/simple;
	bh=ROi86op9+HhiiZfwGZqTkNsrz7ISpudg5uB31tBrbBo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G6i8++zNEeVkelphPbtkpdk0Z3wcCIyPCK9+01iIlRJPoK1H8aqbgpB3yPn6VyJ2R2dQvqT7DErveLZ0+hCcm5+UAkwtZL/wTT6DvGiFdXRDaGqaRja4fcwRp9pUNvEs9gB5sLQaKupTZJlaAcEUiPoQPvevYghhOxbN5qx9Qqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-690af536546so30397087b3.3
        for <linux-kernel@vger.kernel.org>; Sat, 10 Aug 2024 07:55:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723301707; x=1723906507;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dRACj4wO9O3XggjnuGoh49or/oZGkIBmwwrO7YmkKcs=;
        b=oEZEaLc4uiGQAhbUS4QINgsegxbZW1U3siEIzsckYFRdnQ2Ve6yWkMk2KL5QYpCjr3
         N51a2nfa2WzgLrhE+lvZWuDNGxI8j1dIlLSeiRFoHZ7fh1cYZuOQr2Vex94Jhl8eJgdu
         +uWPXzXVMDq5FubCHVgaNmrLgNHbYynuIKI4toWjIXU3hWCJOCecevMYpFoA/TO/rZ/i
         1rvj034ywBFU962Sug/tNdaTdTgP7GmeVsUdwk7PbZ6dTfRrnX4zLOxxqOqZ56aGBgTH
         uwAu+WmPUoAhvJ1kC91q/WkJNF2cf4pFOY3LxeTCvChPH200WYEJrr7xO3xkDaA7l0A3
         yjIg==
X-Forwarded-Encrypted: i=1; AJvYcCV+6NPXk2TS5apH+RXkdoPTmxaXgh2q7aoZRoYlp2NkN37dlINYrLb95xKo+ZskMeIo1fYbaT7TvYLWMAW1bJxm5isSF/Tb7VrK0sFx
X-Gm-Message-State: AOJu0YyPT60etC4i+5WMtxhnUIWv8vKrVWpdJt/A+zpgQRruf2FNZi9U
	PXxabtwQbhqajAkDXcAPJj9CxwDg6A5sHEHhY3cgpnaR5qAX49JQfaewy/XE
X-Google-Smtp-Source: AGHT+IGBWnLVWcDnuxZu7sz8bVEb0V0U0YLLoRO10r6HarkfrRDZPynk/zhlt9dKIfSw7ALLxofJpQ==
X-Received: by 2002:a05:6902:2849:b0:e0b:e28c:b4f4 with SMTP id 3f1490d57ef6-e0eb9a3669dmr5706261276.38.1723301706654;
        Sat, 10 Aug 2024 07:55:06 -0700 (PDT)
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com. [209.85.219.169])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e0ec8bc88ffsm356876276.1.2024.08.10.07.55.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Aug 2024 07:55:06 -0700 (PDT)
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e0b7efa1c1bso2576518276.3
        for <linux-kernel@vger.kernel.org>; Sat, 10 Aug 2024 07:55:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUi7bekch+/e6j6u4X++ziQ7TXF/ZgqSKsYbA2jBGtCqH7sFRfXmoSf8FIu5+K/PIeefKzrBbGX4ujhzEJQL+1KfApajjRM76DHoHdV
X-Received: by 2002:a05:6902:a09:b0:e0b:2e04:2c10 with SMTP id
 3f1490d57ef6-e0eb9945d87mr4221061276.18.1723301705611; Sat, 10 Aug 2024
 07:55:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ac8100050f448caa1dc46c131079e615e73021a4.1723273396.git.fthain@linux-m68k.org>
In-Reply-To: <ac8100050f448caa1dc46c131079e615e73021a4.1723273396.git.fthain@linux-m68k.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sat, 10 Aug 2024 16:54:53 +0200
X-Gmail-Original-Message-ID: <CAMuHMdURykHCL1KEvgK=yC5sW-DAkEo+C+bbOBMUsbhD8aPSMw@mail.gmail.com>
Message-ID: <CAMuHMdURykHCL1KEvgK=yC5sW-DAkEo+C+bbOBMUsbhD8aPSMw@mail.gmail.com>
Subject: Re: [PATCH] m68k: Fix kernel_clone_args.flags in m68k_clone()
To: Finn Thain <fthain@linux-m68k.org>
Cc: Christian Brauner <brauner@kernel.org>, Greg Ungerer <gerg@linux-m68k.org>, 
	Stan Johnson <userm57@yahoo.com>, linux-m68k@lists.linux-m68k.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Finn,

On Sat, Aug 10, 2024 at 9:14=E2=80=AFAM Finn Thain <fthain@linux-m68k.org> =
wrote:
> Stan Johnson recently reported a failure from the 'dump' command:
>
>   DUMP: Date of this level 0 dump: Fri Aug  9 23:37:15 2024
>   DUMP: Dumping /dev/sda (an unlisted file system) to /dev/null
>   DUMP: Label: none
>   DUMP: Writing 10 Kilobyte records
>   DUMP: mapping (Pass I) [regular files]
>   DUMP: mapping (Pass II) [directories]
>   DUMP: estimated 3595695 blocks.
>   DUMP: Context save fork fails in parent 671
>
> The dump program uses the clone syscall with the CLONE_IO flag, that is,
> flags =3D=3D 0x80000000. When that value is cast from long int to u64 by
> m68k_clone(), it undergoes sign-extension. The new value includes
> CLONE_INTO_CGROUP so the validation in cgroup_css_set_fork() fails and
> the syscall returns -EBADFD.
>
> Avoid sign-extension by adopting the idiom used in kernel/fork.c when
> casting clone flags.
>
> Cc: Stan Johnson <userm57@yahoo.com>
> Reported-by: Stan Johnson <userm57@yahoo.com>
> Closes: https://lists.debian.org/debian-68k/2024/08/msg00000.html
> Fixes: 6aabc1facdb2 ("m68k: Implement copy_thread_tls()")
> Signed-off-by: Finn Thain <fthain@linux-m68k.org>

Thanks for your patch!

> --- a/arch/m68k/kernel/process.c
> +++ b/arch/m68k/kernel/process.c
> @@ -117,7 +117,7 @@ asmlinkage int m68k_clone(struct pt_regs *regs)
>  {
>         /* regs will be equal to current_pt_regs() */
>         struct kernel_clone_args args =3D {
> -               .flags          =3D regs->d1 & ~CSIGNAL,
> +               .flags          =3D (lower_32_bits(regs->d1) & ~CSIGNAL),

While other architectures (nios2, sparc, generic code) do use
lower_32_bits() in similar code[*], IMHO this is misleading here, as
regs->d1 is never 64-bit.  What you really want is to avoid the sign
extension in the promotion from signed 32-bit to unsigned 64-bit.
So I think a cast to u32 makes more sense?

>                 .pidfd          =3D (int __user *)regs->d3,
>                 .child_tid      =3D (int __user *)regs->d4,
>                 .parent_tid     =3D (int __user *)regs->d3,

[*] The shared sparc32/64 code uses lower_32_bits on unsigned long,
    which is 64-bit on sparc64. Likewise for the generic code in kernel/for=
k.c.
    The nios2 code is a bit moot, as clone_flags is already unsigned, and
    unsigned long is always 32-bit on nios2.

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

