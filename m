Return-Path: <linux-kernel+bounces-348796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5BA998EBF2
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 10:58:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98A111F23FA6
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 08:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF49D146590;
	Thu,  3 Oct 2024 08:58:08 +0000 (UTC)
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C11145FE4
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 08:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727945888; cv=none; b=NANZJzdTs2eVawjLmW4x16y+o2G+QebDpew/QoaWfoRaebVbRXov/Sxb0zwpekfKtfgwEybX/1y4OhzxI1MGq8/HAgqUA+WaYiA7ZLqKKRgQsa2TTcKn/rPikz7YQWu/pYxPuZYC+dXeTa79eUpZguTzWIvMeYA2uto+w5mIOdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727945888; c=relaxed/simple;
	bh=kknH1Rr5WeWJVeU4EADElvVbCKRS1FQqNKt4AHionDE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NQb56klDJJxAnpx5sVkMTOcXfPazEXtOhXKJ9bhEAxoqU0HfFpWtxOfh9Ue/AesMmhFSiY7oOx26mGPWbBzl1cPevlj27zm2AVcs7zx8kOzglKL5whcN0+x3sFJofpFHAfG5NAH8ykbaobURUN1Mz3tt8ozquAp1aTpX08oBhos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6dbb24ee2ebso6462267b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2024 01:58:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727945884; x=1728550684;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SF8YyYy5U2DnA+lnFMoPVEur1qXv/gTvy3XwOLETNjk=;
        b=s/2n/H/FJXJr1UeOMRfu7AF6UOiUvGN9D93IOFRtWXkwcXfQqkur7Tx0XRZTXqHQYp
         G+Aj+zkVMfh/as1uXNhvdeg01PXkOpvSXaNHl12YjA+wSx8FvSLLBLD2Ptc0wxPeuewb
         Dk0siUaoys7TxyAIW5lMPeY9nJnP+zmTLExAdHxa8QdMQl4sEqTPMQDTNzA6+YNf9B1z
         Eki7Radbne9535ET8fZAkqIMmZk9FUxZviEbu3YO8HkVWrg0j9Tcsfvht8uUYxwomrBP
         I2dq0a7wSwBuCJz/wIOoDAiA3Ps74cx0OjnCiGAhu2DyfOOp07BA+FN4CTWIXFO6fYZP
         Tkwg==
X-Forwarded-Encrypted: i=1; AJvYcCVf/t39KFH4h2FE0OBncvV4eNKQ0vDmndnSTjBr+d/Eb3o/frx2jZdlkIPo+lm72HOsxS3ybPxBUI8TlSg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBtwW0BUay36b1iv2ySFvaydFpxAUJ2WHqsBvpOrr1zkFdpxg4
	OEBsdRC5xTXZaSaRLHwLaaxUl7TkfmoEZzm8T8NdtncutOuFTd0IWYo1iCDA8WA=
X-Google-Smtp-Source: AGHT+IF3DH+K2Pj+arwHmlUf45+eXRef5ROKg3xxpeBCxtBZ/qremtb8yo17h5obaIrU9Niriu10lw==
X-Received: by 2002:a05:690c:e19:b0:6e2:e3d:4dda with SMTP id 00721157ae682-6e2a2b2e744mr56013197b3.17.1727945884560;
        Thu, 03 Oct 2024 01:58:04 -0700 (PDT)
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com. [209.85.128.173])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e2bbea4861sm1355427b3.42.2024.10.03.01.58.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Oct 2024 01:58:04 -0700 (PDT)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6dde476d3dfso5004897b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2024 01:58:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVf0GTdaePrLO7qz7Gsx11dbxnN88RClSbEWyauKPJoSw83Ue9BlcHmZoAEdgoQkwLzxXr+7aFBdFVo5lU=@vger.kernel.org
X-Received: by 2002:a05:690c:dcc:b0:6e2:1090:af31 with SMTP id
 00721157ae682-6e2a2ae01c6mr47393317b3.3.1727945883114; Thu, 03 Oct 2024
 01:58:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1e82c551938c32b4dbf8b65dc779c1b772898307.1727853749.git.geert+renesas@glider.be>
 <87zfnmbfu7.fsf@igel.home> <CAMuHMdW-_oowzrzpoeU-=mD1t8P_65cBr4meY-BToYbkyQMXtg@mail.gmail.com>
 <87iku9r300.fsf@linux-m68k.org>
In-Reply-To: <87iku9r300.fsf@linux-m68k.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 3 Oct 2024 10:57:50 +0200
X-Gmail-Original-Message-ID: <CAMuHMdW474PRT3F3qfcJaghoB1NTH0o2xXuuLpQfWPqpSSe-mA@mail.gmail.com>
Message-ID: <CAMuHMdW474PRT3F3qfcJaghoB1NTH0o2xXuuLpQfWPqpSSe-mA@mail.gmail.com>
Subject: Re: [PATCH v2] compiler-gcc.h: Disable __retain on gcc-11
To: Andreas Schwab <schwab@linux-m68k.org>
Cc: Tony Ambardar <tony.ambardar@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	Miguel Ojeda <ojeda@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andreas,

On Thu, Oct 3, 2024 at 10:42=E2=80=AFAM Andreas Schwab <schwab@linux-m68k.o=
rg> wrote:
> On Okt 03 2024, Geert Uytterhoeven wrote:
> > | That ultimately depends on binutils support for SHF_GNU_RETAIN (2.36+=
).
> >
> > So binutils 2.38-4ubuntu2.6 is sufficiently new, but it doesn't work?
>
> It ultimately depends on the binutils version the compiler was built
> against.

Is there an easy way to check that version?

debian/rules for the gcc-11-cross-11ubuntu1.3 source package contains:

    VER_BINUTILS   :=3D 2.37-5
    MIN_VER_BINUTILS   :=3D 2.37-5

so in theory it could have been built again 2.37, which is still
sufficiently new.

"dpkg -s gcc-11-arm-linux-gnueabihf" says:

    Depends: [...] binutils-arm-linux-gnueabihf (>=3D 2.38) [...]

so I guess it was actually built against 2.38, which is OK.

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

