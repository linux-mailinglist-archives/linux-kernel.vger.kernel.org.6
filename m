Return-Path: <linux-kernel+bounces-258604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C877938A5E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 09:49:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDB5A280F86
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 07:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03D9C1607B7;
	Mon, 22 Jul 2024 07:48:53 +0000 (UTC)
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877741607A8
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 07:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721634532; cv=none; b=GF0r8ODJYNPBiMvsQEtOAjSUoaCYw35Vt0El+DJPco6NPI0mAGTCQwjmGqHF8U9aMmE/l9CIX/pYMfGwYFyFDZOrc+CX+AQL94KY14S5s11ELMSEh41UGNR+e3rrRIkkOxsjDTxkJnPVZVNZD4OdJhso9TQNn0eooTpOCkxjnYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721634532; c=relaxed/simple;
	bh=Fi9l7cvMS1N/rrW+7ejHVp2TyKDXOtDjp1hUa5Rl28g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sU1B3PACKjqTQ4N6eZNTAcETA3qIQ2Yei4D98ZBjnOQM3DJtcqLtLiqGIUNnRs9ju+jME6A/ENFtCPWAizQIf9PixoPIDY4VGsJC1/EWU7dVBwwwPwS8kNs+4aZbDIFAESSbqfH+kYHnDOi3Rjy2q9ktjL6T+qHh6uBFon1QZfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e05f2adab8bso3800463276.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 00:48:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721634529; x=1722239329;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k0sQ5XRZBfD55xDMn0aVgeSX6fwhqOHYRYZxYiFb1nU=;
        b=GC+9z3WVFHSwLYZn67WmpqeYfBR55GchbcB6Pkf0X+zaqcS4DnotGo1s+vF6tjfFOh
         6gISdEdJT6M93tPm8r96eteRUXblEflmCspAsFui2Kt/bxJXXCmtyFxSau3bdxAyB216
         dNhJhAXLcEWONYsYRT/ozlHbKM5F1EOjhdux4dVmvL5Gt6FKMkJZg3MLpCby5Igasb9u
         VsJwVCl06gZhxPfRDzPUFGhNN62aJ1FgfGDJYWUgJyiVeac9NAyRuysl2YFF4DKk8y12
         5WsW8emeHX6UAGWXHt26q+ZYsPxNuWc1iLep/a/KeVyb2yYtWeT/tTiRTGWGwrcn7dAg
         HgBg==
X-Forwarded-Encrypted: i=1; AJvYcCXyNsYqTYk4nF4fmpNxnOvhApDdXQWIiSf/Z9NU3p7vN383DNMIkDmKsGHTfXDxk9aPWqm3q/v50Oaw/e2zVCxpKiU1MieljcUJyBKo
X-Gm-Message-State: AOJu0YyffjXSIlWzqj/Cg2Bmw/xMm2nvBPzXJq7l0lFhzftVQO2mW2XS
	ddzbgJlHAyH0RmU/1Ko+cgU+SMaBjS2zD50ojKjA2qLNYV3TBHAPFgI3j14p
X-Google-Smtp-Source: AGHT+IEGjWo/Hw5An0UPLyNcSCpaVVxlyC2SPGpQVA44CnUXJRUTWY/3FhRFjiyi1NZB0SRKVptelA==
X-Received: by 2002:a05:6902:2b08:b0:e05:6cdc:c36f with SMTP id 3f1490d57ef6-e087b8f11bemr6740189276.45.1721634528675;
        Mon, 22 Jul 2024 00:48:48 -0700 (PDT)
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com. [209.85.128.182])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e086096b00bsm1455345276.10.2024.07.22.00.48.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jul 2024 00:48:47 -0700 (PDT)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6510c0c8e29so37950637b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 00:48:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVDRcn9rwSwcfWOaD2ujLH9PZZfH8TcLNMww2++/HqrwKjaH1EFMQuLbEKInWbVdQaD0fZG2UaeRCSM2UzL17eEUQH0CaqdrwnnR7Ew
X-Received: by 2002:a05:690c:3146:b0:643:9333:9836 with SMTP id
 00721157ae682-66ad9fed5d0mr57401517b3.38.1721634527076; Mon, 22 Jul 2024
 00:48:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202407200330.Mgxnq2Dq-lkp@intel.com> <420e09ad-f43f-4734-bc06-fee7a54f2eda@suse.cz>
In-Reply-To: <420e09ad-f43f-4734-bc06-fee7a54f2eda@suse.cz>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 22 Jul 2024 09:48:34 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWMSpv1BbvCqf0Abfxf0sGp+5it-m1GtFR2nGuQ5-ZCAg@mail.gmail.com>
Message-ID: <CAMuHMdWMSpv1BbvCqf0Abfxf0sGp+5it-m1GtFR2nGuQ5-ZCAg@mail.gmail.com>
Subject: Re: include/linux/slab.h:663:78: error: subscripted value is neither
 array nor pointer nor vector
To: Vlastimil Babka <vbabka@suse.cz>
Cc: kernel test robot <lkp@intel.com>, Kees Cook <kees@kernel.org>, oe-kbuild-all@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Vlastimil,

On Mon, Jul 22, 2024 at 9:15=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
> On 7/19/24 10:02 PM, kernel test robot wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.=
git master
> > head:   4305ca0087dd99c3c3e0e2ac8a228b7e53a21c78
> > commit: 72e0fe2241ce113cbba339ca8c2450b167774530 mm/slab: Introduce kme=
m_buckets typedef
> > date:   2 weeks ago
> > config: m68k-alldefconfig (https://download.01.org/0day-ci/archive/2024=
0720/202407200330.Mgxnq2Dq-lkp@intel.com/config)
> > compiler: m68k-linux-gcc (GCC) 14.1.0
> > reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/arc=
hive/20240720/202407200330.Mgxnq2Dq-lkp@intel.com/reproduce)
> >
> > If you fix the issue in a separate patch/commit (i.e. not just a new ve=
rsion of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202407200330.Mgxnq2Dq-l=
kp@intel.com/
> >
> > All errors (new ones prefixed by >>):
>
> Hm the new error ettributed to slab seems just a consequence of the broke=
n
> PAGE_SHIFT? Although it's not listed here in the errors for some reason, =
I
> assume without PAGE_SHIFT we don't have KMALLOC_SHIFT_HIGH thus we don't
> have kmem_buckets typedef and thus kmalloc_caches is who knows what and t=
hus
> doesn't look like an array? And the broken PAGE_SHIFT has to be cause by
> something else.
>
> >    arch/m68k/include/asm/page.h:10:25: error: 'CONFIG_PAGE_SHIFT' undec=
lared here (not in a function); did you mean 'CONFIG_LOG_BUF_SHIFT'?
> >       10 | #define PAGE_SHIFT      CONFIG_PAGE_SHIFT
> >          |                         ^~~~~~~~~~~~~~~~~

It's a known issue since commit 5394f1e9b687bcf2 ("arch: define
CONFIG_PAGE_SIZE_*KB on all architectures"): m68k-alldefconfig does
not select any CPU types, hence no MMU type, and as a consequence no
page size is selected.

Arnd and I couldn't come up with a good solution to enforce a valid config,
so this is still broken...

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

