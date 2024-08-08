Return-Path: <linux-kernel+bounces-279020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A35494B7FD
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 09:38:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F36582865D7
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 07:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1624D18757F;
	Thu,  8 Aug 2024 07:38:29 +0000 (UTC)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D2E7464;
	Thu,  8 Aug 2024 07:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723102708; cv=none; b=AV0JzyvT5Dw/sqor09+ngIzihiVJILWMj/t+DLJhUfw1b8DGylcjB5XV4KNa3uu1RLJZnzvkrDfCn+zPDMNTnaIRPVtoAa0/HTyXdFAuFvQ3ddYlz/TJfXFtsLIn+cCEEr6UDmkqGZ1JNZRBMXoK5HZdsj2pZUJ0ZAkbCLBAxxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723102708; c=relaxed/simple;
	bh=hc5j+myHdlqI4TvbsXgmby9c342TeQNxoIXR9MdPZt8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AJ1UZYVh1M5qm9h7UeeoOsHjXY7PbCHmIgvwaZCWL78f8ykT+rJQ5f2JaHvmqfYV2Cf6AsBm0PQ16WCAXRi2XCYwkAfpoe4zpuLUdQRGjn7brhXPPmu3ZLVQLMLPEbKcm9B8ZnXgyki39dxlGMVFr2Ntt1PTlpWTNvlnH0JjRlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gompa.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gompa.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a7aa212c1c9so86543066b.2;
        Thu, 08 Aug 2024 00:38:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723102704; x=1723707504;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4HBmbqk9ms7in+UR7tka+4chrV1ZmoOVr9gG0UPaa1E=;
        b=okir+Z8AAOXSZdRWvK7oUgbeepJcRdbPmjgQZLavd6ReM2nIiIC8WReCwZpgqPoA05
         KbDj7jqpD08HM4AakoSoR/cgF39qWPURiOSDjoyd7cerpZKZhV1CugTB6C+PzTHqvx0d
         zEyh397122RNpQQ01S88Np4KShRPCs/u/dNzOFkgh3Q9h3NlLuj2ssonwSp4Bx3z0El1
         2BIa1bwmKOAdo3cWVf24YD7yrxKpZ8/weSjH52qoF2zPtxForo37//jA/OeYcozxI+Qw
         k1ikZt0lFp3nocoJIj22t1E5bsiTQ5erJjwmToSziP6CgARiZcyYuT7B1WtLqDEQmcUe
         dnCg==
X-Forwarded-Encrypted: i=1; AJvYcCWm6byVQbeRA1LPNJJkPKeG6QlImqnDFs1KzHkQ8SRk7gIZygK9Jro1cpRRPqrJdiwApt8z1/Jq5D+Lq/OESupqlYarK4fBnROCKuACkVRwDlLkeBXYP6nY5FlXUYG1svKPEYMhQnCC1AVGt5Y=
X-Gm-Message-State: AOJu0YwptXA+lRat8R9peb9woPn+N+gFawIu+MnsjBU0JpYViFvszLZj
	ks8EWhkyKb0AHGVPz5c1adVhAikvh1+byf7SaKNYR8oUxwObrpjKYUYbM/UbMa0=
X-Google-Smtp-Source: AGHT+IFMncklZr3LZ6mN1e6VkBP5kQa42R44Fjt8A27gX936k/QTk8MZsfc8W5yLM7AvA2S+Frzrbw==
X-Received: by 2002:a17:906:6a05:b0:a7a:a138:dbd2 with SMTP id a640c23a62f3a-a8090e6304amr65770466b.50.1723102704133;
        Thu, 08 Aug 2024 00:38:24 -0700 (PDT)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com. [209.85.218.42])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9c0cae0sm708145366b.56.2024.08.08.00.38.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Aug 2024 00:38:24 -0700 (PDT)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a7d2a9a23d9so73172866b.3;
        Thu, 08 Aug 2024 00:38:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUUzy2wf4OyCA8l87Dxf2e4T4Iau2hby85SnTt8j9SPKl6zYZmvI8zo8jBgQLAR11XHu5hVxcsfJ6fkkFGi8FVSYzB2IvDt3P92tc1RP5670FP+PhR1eSsqZ60CA2mHoPogZXVs930gb3jNTos=
X-Received: by 2002:a17:907:c7e0:b0:a7a:8876:4427 with SMTP id
 a640c23a62f3a-a8090c835d0mr65204466b.25.1723102703653; Thu, 08 Aug 2024
 00:38:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240731134346.10630-1-zehuixu@whu.edu.cn> <3695674.9o76ZdvQCi@skuld-framework>
In-Reply-To: <3695674.9o76ZdvQCi@skuld-framework>
From: Neal Gompa <neal@gompa.dev>
Date: Thu, 8 Aug 2024 03:37:46 -0400
X-Gmail-Original-Message-ID: <CAEg-Je9gyR2xKF8Ky8eWTR=6odZbgCRCM6DhYPVTAJTDPDxakg@mail.gmail.com>
Message-ID: <CAEg-Je9gyR2xKF8Ky8eWTR=6odZbgCRCM6DhYPVTAJTDPDxakg@mail.gmail.com>
Subject: Re: [PATCH v3] rust: Kbuild: Skip -fmin-function-alignment in bindgen flags
To: ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com, 
	Zehui Xu <zehuixu@whu.edu.cn>
Cc: boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	benno.lossin@proton.me, a.hindborg@samsung.com, aliceryhl@google.com, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 7, 2024 at 3:52=E2=80=AFAM Neal Gompa <neal@gompa.dev> wrote:
>
> On Wednesday, July 31, 2024 9:43:46=E2=80=AFAM EDT Zehui Xu wrote:
> > GCC 14 recently added -fmin-function-alignment option and the
> > root Makefile uses it to replace -falign-functions when available.
> > However, this flag can cause issues when passed to the Rust
> > Makefile and affect the bindgen process. Bindgen relies on
> > libclang to parse C code, and currently does not support the
> > -fmin-function-alignment flag, leading to compilation failures
> > when GCC 14 is used.
> >
> > This patch addresses the issue by adding -fmin-function-alignment
> > to the bindgen_skip_c_flags in rust/Makefile. This prevents the
> > flag from causing compilation issues.
> >
> > Link:
> > https://lore.kernel.org/linux-kbuild/20240222133500.16991-1-petr.pavlu@=
suse
> > .com/ Signed-off-by: Zehui Xu <zehuixu@whu.edu.cn>
> > ---
> > Since -falign-functions does not affect bindgen output, we do not
> > need logic to add it back to the flags. Thanks to the community's
> > help, especially Miguel Ojeda. Hope this patch is free of problems
> > and can be submitted smoothly : )
> >
> > v1:
> > * https://lore.kernel.org/all/20240730222053.37066-1-zehuixu@whu.edu.cn=
/
> >
> > v2:
> > * Added -falign-functions to bindgen_extra_c_flags when skipping
> >   -fmin-function-alignment to maintain function alignment settings in G=
CC 14
> > * Used reasonable length and moved email content out of the commit mess=
age
> > * Used "Link" tag instead of "Reference:" and removed empty lines betwe=
en
> > tags * Specified the base commit
> > * https://lore.kernel.org/all/20240731034112.6060-1-zehuixu@whu.edu.cn/
> >
> > v3:
> > * Removed logic from patch v2 which adds -falign-functions
> >
> >  rust/Makefile | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/rust/Makefile b/rust/Makefile
> > index 1f10f92737f2..0c8736cce64f 100644
> > --- a/rust/Makefile
> > +++ b/rust/Makefile
> > @@ -227,7 +227,7 @@ bindgen_skip_c_flags :=3D -mno-fp-ret-in-387
> > -mpreferred-stack-boundary=3D% \ -fno-reorder-blocks
> > -fno-allow-store-data-races -fasan-shadow-offset=3D% \
> > -fzero-call-used-regs=3D% -fno-stack-clash-protection \
> >       -fno-inline-functions-called-once -fsanitize=3Dbounds-strict \
> > -     -fstrict-flex-arrays=3D% \
> > +     -fstrict-flex-arrays=3D% -fmin-function-alignment=3D% \
> >       --param=3D% --param asan-%
> >
> >  # Derived from `scripts/Makefile.clang`.
> >
> > base-commit: 8400291e289ee6b2bf9779ff1c83a291501f017b
>
> Looks good to me.
>
> Reviewed-by: Neal Gompa <neal@gompa.dev>
>

To add, can we get this in as a fix for Linux 6.11? I can't build
Fedora kernels with Rust stuff enabled without it since GCC 14 is
shipped in Fedora Linux 40+.


--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!

