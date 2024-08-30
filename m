Return-Path: <linux-kernel+bounces-308381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ABF47965C3A
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 10:59:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C6961F249DC
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 08:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9A6F16DC34;
	Fri, 30 Aug 2024 08:59:38 +0000 (UTC)
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5CFC16DC3C
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 08:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725008378; cv=none; b=eH7l7zCmLVWg7PjACNAQILHk2wB0HdTcsHTD6uOinNCVzUNobTz8hy1L8oZCLCGne64nlDtx1BaLfaRuaYv6upyLMXlU3ZOubUTT+X7uBFyw4dyQLVH4zF18B7tcU2BjqUZnej1DGZo8ouNsr69riakt8B0Lmh+NtN/hcbbIaeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725008378; c=relaxed/simple;
	bh=TN+oQyZCH35OY8m14Uu+GdJSiFWUD86vHlGKtCe6r0Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SdOOqvhFe819F9VHvb4s3llHvsX17KJp9WUSHo/D6ptP6uEzmYtWGu6LB3WleArNB6ZDoNVdSGIN3YPPtduf8tbNSxo9UQnY5jAkB5CiK2pmW0dF2v+M6Fb1W+UNFELV4iOUmXonWhwmivDBXwDdyZNnbzFbX65LADoA0HbOS+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6bada443ffeso13788697b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 01:59:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725008374; x=1725613174;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5sy+VggCqE5ZQFv6S3QPo1m00aK4PzCBfE22ypnHep4=;
        b=Ns6HK1721J6osJK07GHqXaLZCsznJiOthSL18dHfZwUvg0yreHMhDmKs952BqJnxqa
         8Hhi3iCi6VRd4ZOqgD7YagxUk1hcMq/kiguk26kMGv1Ts8Ft10KqmqRjeUQXeQk9Rmht
         wPinC9dycRdtGkwdUYoEcg9qMS+nV3Ix/gJddsNRG952rPjy3kSziUcv4rwta0NRnkel
         euIB4NZUFlZvswEqnA6BR9Hgvq1QTNEV9h9ezbGkQxBRorEO6O39PLJ9e88z9AgKF38j
         wZUTR3QmHh3oZL/6NedhI8tfVGr3dHyFRIi67DHpLihOQN3zZzyY5pZpqiHYlteLwspM
         epxg==
X-Forwarded-Encrypted: i=1; AJvYcCVXfdV17OvTba5qeLVQ9aP18TVdIvGaUgfIUm21sqBh3Si96zK5pahbKgNfROTE0/eAHK3djfNUAaMMNC0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHZV75kiwqNRwjZ528/H6+Q+4ry+V771zs3ZdkHabULf+sgdQ+
	Hr+z9wvatu2FDTi2Z8ovxIzNnW+rfAY2VcCAyt9UgXq8cwNZYZ6HZ+JMDAx/
X-Google-Smtp-Source: AGHT+IFsaup2fH2V/ZR/D4jAGufuZXqxME59/9Q773Pz+HoaPW4UK0748StlJFsKCTCb6MivoKvZAg==
X-Received: by 2002:a05:690c:f02:b0:6c7:a120:e104 with SMTP id 00721157ae682-6d3f7fabc73mr14046697b3.4.1725008374435;
        Fri, 30 Aug 2024 01:59:34 -0700 (PDT)
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com. [209.85.128.175])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6d2d39c78besm5601257b3.16.2024.08.30.01.59.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Aug 2024 01:59:34 -0700 (PDT)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6cdae28014dso13078157b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 01:59:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUpeJU2te7rXiXkNP9C7UgUNKpG8c2DqTPcy7pkuaDNWXc4pIdFCgcwVrbxjww9d5IrUa3yGsLfJ1QDNys=@vger.kernel.org
X-Received: by 2002:a05:690c:6609:b0:6b2:7494:455c with SMTP id
 00721157ae682-6d3f7facc50mr13558897b3.1.1725008373673; Fri, 30 Aug 2024
 01:59:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240822071056.1342551-1-11162571@vivo.com>
In-Reply-To: <20240822071056.1342551-1-11162571@vivo.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 30 Aug 2024 10:59:20 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWpXqbZqv9DnjHQouxOiqQcMy4qxj42PEYkPrUdm_xszg@mail.gmail.com>
Message-ID: <CAMuHMdWpXqbZqv9DnjHQouxOiqQcMy4qxj42PEYkPrUdm_xszg@mail.gmail.com>
Subject: Re: [PATCH v1] drivers:smumgr:Variable names should be consistent
 with other modules
To: Yang Ruibin <11162571@vivo.com>
Cc: Kenneth Feng <kenneth.feng@amd.com>, Alex Deucher <alexander.deucher@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Xinhui Pan <Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Stephen Rothwell <sfr@canb.auug.org.au>, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	opensource.kernel@vivo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Yang,

Thanks for your patch!

On Thu, Aug 22, 2024 at 9:11=E2=80=AFAM Yang Ruibin <11162571@vivo.com> wro=
te:
> The variable highest_pcie_level_enabled is named
> hightest_pcie_level_enabled in other modules.
> Please ensure the consistency of variable naming
> and use min macros instead of the triadic operator.

"hightest_pcie_level_enabled" is the wrong spelling, so the other modules
should be fixed instead:

drivers/gpu/drm/amd/pm/powerplay/smumgr/fiji_smumgr.c
drivers/gpu/drm/amd/pm/powerplay/smumgr/polaris10_smumgr.c
drivers/gpu/drm/amd/pm/powerplay/smumgr/vegam_smumgr.c

> Signed-off-by: Yang Ruibin <11162571@vivo.com>

> --- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/iceland_smumgr.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/iceland_smumgr.c

> @@ -1012,19 +1012,18 @@ static int iceland_populate_all_graphic_levels(st=
ruct pp_hwmgr *hwmgr)
>                 lowest_pcie_level_enabled++;
>         }
>
> -       while ((count < highest_pcie_level_enabled) &&
> +       while ((count < hightest_pcie_level_enabled) &&
>                         ((data->dpm_level_enable_mask.pcie_dpm_enable_mas=
k &
>                                 (1 << (lowest_pcie_level_enabled + 1 + co=
unt))) =3D=3D 0)) {
>                 count++;
>         }
>
> -       mid_pcie_level_enabled =3D (lowest_pcie_level_enabled+1+count) < =
highest_pcie_level_enabled ?
> -               (lowest_pcie_level_enabled+1+count) : highest_pcie_level_=
enabled;
> +       mid_pcie_level_enabled =3D min(lowest_pcie_level_enabled + 1 + co=
unt,
> +                                       hightest_pcie_level_enabled);

This is an unrelated change; please create a separate patch for this.

> -
> -       /* set pcieDpmLevel to highest_pcie_level_enabled*/
> +       /* set pcieDpmLevel to hightest_pcie_level_enabled*/
>         for (i =3D 2; i < dpm_table->sclk_table.count; i++) {
> -               smu_data->smc_state_table.GraphicsLevel[i].pcieDpmLevel =
=3D highest_pcie_level_enabled;
> +               smu_data->smc_state_table.GraphicsLevel[i].pcieDpmLevel =
=3D
> +                                       hightest_pcie_level_enabled;
>         }
>
>         /* set pcieDpmLevel to lowest_pcie_level_enabled*/

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

