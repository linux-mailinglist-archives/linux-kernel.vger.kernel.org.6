Return-Path: <linux-kernel+bounces-198746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D89278D7CDF
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 09:54:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50C63B23401
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 07:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6362C53E31;
	Mon,  3 Jun 2024 07:53:57 +0000 (UTC)
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F214EB45;
	Mon,  3 Jun 2024 07:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717401237; cv=none; b=DXaWsqa9DZAeFOZ8UYneqcYMWFJEzKN2BXtgqfvrJFxq+jKwsyM0U2U/vouQTOx+J0JHsfSLllvVWJgUHP1D6dV5vWPVB8/Ek2gK5ef2Oo+MTLRh2QPreSrAP574WMK1/gpkbSfT+8Yof6tLQyPodyeoLLNfAMAgzMna33Q/zCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717401237; c=relaxed/simple;
	bh=MbXdgfo4GVYf9hxgrx9O4oenoDWiR3EkIepvWXa5Ook=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tC3ATYXJUlv24WOL8NWBahLHBm3znCrIhfJ/JNNr8Jj9SgNqHgtesvY3Vz2l3qsOE9Pm0Bbni3LfvGyuF9T9TUcdTRp7DAajuPniOvbzXvx/527uVthU1LbnSKNM8LSvgpKG2HMvHhcEzZlqCkCvYxHgkm1p3XEbVHyolNM6LE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-dfa72e97dfeso2659848276.1;
        Mon, 03 Jun 2024 00:53:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717401234; x=1718006034;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tsq/lHgEr8F0kl5CpCDbtmmcC+g81AnsDXRGMjagNnI=;
        b=pWrdTdZIdtcP58/yWIlczzoRlXRvlVpV1pFqZaiZNJAIkImsnfE+iQCS3azcvJb5mA
         j3LRKCCPI/iiMLkI0nbzulWPzKQxXGim2jRwOnP6e16M+GJHTFtT8GAUtNtLhgN/RrrF
         vjgnqcVvgFNQWCEougS+QIaDPblNjgPslXi4EUl58Tnvc9bqvV86DKpfBH7bPgozabHe
         +hzHaScTB/1vVWQzIqKoPlnw3pm9KlZrzWFJ8x48iqpLlnnOcR3u5q72mKvPIc6SpkGn
         9vT46r32tm0g5RcqCxGBZgPnnjO8gj7HSmLOwkcR0SYrpyH/cArSth3KWGMKqo1QOSgw
         ZlzA==
X-Forwarded-Encrypted: i=1; AJvYcCXLuKut7XNMHXzQ59bUVrquB9tKnd6eQBeHLPrY1f1o9/q+/NiD0LlyRbpLR7YXbMcOX6aGNsWwQT5M1Du5h7GOA8qER6VJl4h/nBaUJCHy2VR6nW5Ib4zD7erAvgBMCJG5QNWm3o8L4DtaPxgn
X-Gm-Message-State: AOJu0Yyc6kw78/MAhG0R1Usgzrxd0LWc8an/2y6dHY9QIELfH+iEH5HW
	lRIoCkGqhfTVRDUj72zoYQyAAh57N46gKgFtFjTG32MwqEhjIFrfWlY6WcMf
X-Google-Smtp-Source: AGHT+IHXMFPN0gEECKS3RnBoZp51UR+BDfhGi6zC/jZAh+kV7f320XJQyRi1Gq7jYa/RmhvhraoMyA==
X-Received: by 2002:a05:6902:1029:b0:dfa:5df3:f57a with SMTP id 3f1490d57ef6-dfa73db8500mr8074917276.58.1717401233817;
        Mon, 03 Jun 2024 00:53:53 -0700 (PDT)
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com. [209.85.128.175])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-dfa6f156fafsm1477719276.63.2024.06.03.00.53.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jun 2024 00:53:53 -0700 (PDT)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-627efad69b4so27933277b3.3;
        Mon, 03 Jun 2024 00:53:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVFLglce0jRoRiGtXDGZeQlaCx3zMs5SG8A22VIOKORbwWMgyvFdbgYpwe9E//5KRCbXFA3dztchlqIv54UnMegkZ5Mi3eRS6RajoGHtGf8mr8WuQlHg/jbXgAlvcKTMqrxr7Z+D2Da202ABfhq
X-Received: by 2002:a25:7dc7:0:b0:dfa:885d:c5e7 with SMTP id
 3f1490d57ef6-dfa885dd05cmr4430491276.30.1717401233407; Mon, 03 Jun 2024
 00:53:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240602-md-drivers-auxdisplay-linedisp-v1-1-9895acebf916@quicinc.com>
In-Reply-To: <20240602-md-drivers-auxdisplay-linedisp-v1-1-9895acebf916@quicinc.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 3 Jun 2024 09:53:40 +0200
X-Gmail-Original-Message-ID: <CAMuHMdV+xKD22ntAeTXUN89agxrjXiu-Nk3uHDvUJDczVpaLgA@mail.gmail.com>
Message-ID: <CAMuHMdV+xKD22ntAeTXUN89agxrjXiu-Nk3uHDvUJDczVpaLgA@mail.gmail.com>
Subject: Re: [PATCH] auxdisplay: linedisp: add missing MODULE_DESCRIPTION() macro
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Andy Shevchenko <andy@kernel.org>, linux-kernel@vger.kernel.org, 
	kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 3, 2024 at 5:02=E2=80=AFAM Jeff Johnson <quic_jjohnson@quicinc.=
com> wrote:
> make allmodconfig && make W=3D1 C=3D1 reports:
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/auxdisplay/line=
-display.o
>
> Add the missing invocation of the MODULE_DESCRIPTION() macro.
>
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

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

