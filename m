Return-Path: <linux-kernel+bounces-521780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41157A3C233
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 15:32:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25C7A189B185
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 14:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38D9B1F3B85;
	Wed, 19 Feb 2025 14:31:10 +0000 (UTC)
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC1B1EFFA7;
	Wed, 19 Feb 2025 14:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739975469; cv=none; b=l4YwnGT9xBPQRPgh0yVW1p528GE4jTIt2EqvzCKK7j+M/+yPm/qUzJZigE9eaMkYFLPpXO3V/xsOLbPSyFH52oRtwngNQNzFFdEvsglKJbDvgB/7uZmuZrIcgA3jkcW0LEilgDR2Tz5XWgnaA9FJJG01MN1I/N+3HSOjgmefsWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739975469; c=relaxed/simple;
	bh=xfKXXLwRuUlkoia2+3OnSbJipVII2jZrBsMVFyp8nVQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VVINu7Wr+fvzJOp64D8Ie9a6/z+3D17JSRJqnhvRUD+ZDCxKasG2zKO34s/ctcN5500kOh+TOqHZBiIuUhu4joGWehLe2UwJl4njcMtEncQHWvLJ9jGBRutxxaTle8iWB8Kte4az12YpbN58w8jpvnizGcz+7W8rIqswBjt69NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-520b872d13cso917316e0c.3;
        Wed, 19 Feb 2025 06:31:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739975465; x=1740580265;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o+U1Ccue1bhBxPmApsgmqMneskFCST8/Za4NkTSJezM=;
        b=GrTZ00zbHZLkYM5qVmKL7hDaVdgEDRoFPNg+OEmeIEGDnFrEpgKVd382/acRU7kzei
         jtHTNWeK2EDSd0K4rXRUKiiqOb2XNhNmUnswL9RIGfFBglpZMGDL9IJc4QPl2BBmvcFV
         HvczBFXfTJfieNndqMtmbz35+ptzafmG0hDejlXQmjmhPl4RzSeUHCy32mdDGM5FI/pz
         jJqRO+D3G8+d9hdSUsYumCVNjilNOfg/7DVbEHM7+aMp1WAA8rhFemeofiGSthfILQZS
         86lTJdGzhgVPGgn6yoqqmCTJVImzI/aoe81LVzHV+wB2UFvfZEs3CEFGOj2uxNnnmgvp
         YJrA==
X-Forwarded-Encrypted: i=1; AJvYcCV2OGwLwdp168fr51SU1lUOK4VShkfSFVICA9IcgoU/Z7h3atU5ktjpal2f1vQgVMvcICVUiFIPhP3Z4So=@vger.kernel.org, AJvYcCWojyER+jMlv/NIHnSUG+fa2s+/O9ILdk082mx/l3BWIPf7UIRdUgj79TT2rHuh4n/TTYcmT5UNfUu1+Ldb57U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxznE6gXGnrNAKIsOVJhh+pftiud7q9MvVaoxSbS/y7i34EBPQB
	F80heb490jdSYmzrFkl0fiNkuB8BXkrLlsRyAn63QZFJ1oqhBJSThr1sWElc
X-Gm-Gg: ASbGnctMGtYxPDdtlqlVMHArCvxg7/U/CliH5xsuGjGloNKFqf0N98JVaqSISbEBpa3
	Cbaq9rKI4Cjc2v59ELbHdosBMG9Zr6YSIEAlAJWjDIqU6GoU+U1hP31827VtdZDs99J30/K7JLS
	QKJeDkQe8ozihw93DcdUAbeM4tt4Rn62lyEm9XsS0orUz38f55EdDMHbMK1MOngarB1+rT8xFIG
	SvwGVul0D+yPjap5+voQaqJpRXheJAxUmK7bx0LMblVKWKtwbzgac0mHhyMdeFiNIdm+QtuoGay
	EtidiZVbpjrNgwGi/PWIPS3A2zbQ3eDZlLlo1iHsarWLRCSfnoiRpA==
X-Google-Smtp-Source: AGHT+IFi3bXWgxPTyX9VTmvSdEkYlItjbOFvghWUcwdjfCR7eaUVBztz4VAeNrMHA2VEBM0wBgb4cw==
X-Received: by 2002:a05:6122:1825:b0:520:42d3:91bc with SMTP id 71dfb90a1353d-5209da2db63mr9341543e0c.2.1739975465111;
        Wed, 19 Feb 2025 06:31:05 -0800 (PST)
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com. [209.85.217.43])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-520b800fa5csm1725236e0c.43.2025.02.19.06.31.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Feb 2025 06:31:04 -0800 (PST)
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-4b68cb2abacso1965709137.3;
        Wed, 19 Feb 2025 06:31:04 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUSVisrT+zfHDFOSZbUxDaGHCbcT4qo2G0a3CRlbZRCH//6L2411BLfTCGMoh72gI99BfIkcq4sNePfDTM=@vger.kernel.org, AJvYcCX/QKcahcQ9tROc+/8ysFHxl5OBrqY10A2uYY+nED4I3NmnyAWYQ/TOpHuzvvRzhtEpwwxsIFWxqaGaQvs07Ng=@vger.kernel.org
X-Received: by 2002:a05:6102:3fa8:b0:4bb:e6bc:e164 with SMTP id
 ada2fe7eead31-4bd3fe8d0d1mr10493845137.25.1739975464222; Wed, 19 Feb 2025
 06:31:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANiq72m-R0tOakf=j7BZ78jDHdy=9-fvZbAT8j91Je2Bxy0sFg@mail.gmail.com>
 <Z7SwcnUzjZYfuJ4-@infradead.org> <b7a3958e-7a0a-482e-823a-9d6efcb4b577@stanley.mountain>
 <2bcf7cb500403cb26ad04934e664f34b0beafd18.camel@HansenPartnership.com>
In-Reply-To: <2bcf7cb500403cb26ad04934e664f34b0beafd18.camel@HansenPartnership.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 19 Feb 2025 15:30:50 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXcBKpiCPE7b4UR9TdmqT_4D8_iptAczYX7XE0Xn7hr=w@mail.gmail.com>
X-Gm-Features: AWEUYZmdGuQ19HJ0giDqUtCD9bdUS5S-NFaDx72LYhzhau0l0yfW-E_DDpKNmz4
Message-ID: <CAMuHMdXcBKpiCPE7b4UR9TdmqT_4D8_iptAczYX7XE0Xn7hr=w@mail.gmail.com>
Subject: Re: Rust kernel policy
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, Christoph Hellwig <hch@infradead.org>, 
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, 
	rust-for-linux <rust-for-linux@vger.kernel.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Greg KH <gregkh@linuxfoundation.org>, 
	David Airlie <airlied@gmail.com>, linux-kernel@vger.kernel.org, ksummit@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hi James,

On Wed, 19 Feb 2025 at 15:20, James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
> On Wed, 2025-02-19 at 11:05 +0300, Dan Carpenter wrote:
> > On Tue, Feb 18, 2025 at 08:08:18AM -0800, Christoph Hellwig wrote:
> > > But that also shows how core maintainers are put off by trivial
> > > things like checking for integer overflows or compiler enforced
> > > synchronization (as in the clang thread sanitizer).
> > > How are we're going to bridge the gap between a part of the kernel
> > > that is not even accepting relatively easy rules for improving
> > > safety vs another one that enforces even strong rules.
> >
> > Yeah.  It's an ironic thing...
> >
> >         unsigned long total = nr * size;
> >
> >         if (nr > ULONG_MAX / size)
> >                 return -EINVAL;
> >
> > In an ideal world, people who write code like that should receive a
> > permanent ban from promoting Rust.
>
> I look at most of the bugfixes flowing through subsystems I watch and a
> lot of them are in error legs.  Usually around kfree cockups (either
> forgetting or freeing to early).  Could we possibly fix a lot of this
> by adopting the _cleanup_ annotations[1]?  I've been working in systemd
> code recently and they seem to make great use of this for error leg
> simplification.

Sure!
https://elixir.bootlin.com/linux/v6.13.3/source/include/linux/cleanup.h

Unfortunately these may cause a new bunch of cockups, due to
forgetting to call no_free_ptr() when needed...

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

