Return-Path: <linux-kernel+bounces-511111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F0052A3260E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 13:42:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E03387A301A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 12:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 790E120CCC2;
	Wed, 12 Feb 2025 12:42:33 +0000 (UTC)
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8535CF4FA;
	Wed, 12 Feb 2025 12:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739364153; cv=none; b=fX0nz+g1RkE7qVSw45eJmLfMXd4X0+0ZOl4x3WjaXHsa7vARx355sJ593lyD066Gxbnv6CFOnbkZ49GFjo3UyRUhzIw57xeCPgAzrpSVqXeIpNl63QlaDzxEonKGjGnayZjofVE84sIeoKa4mA6a7KgXp4DtwbumY2S68FiOSRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739364153; c=relaxed/simple;
	bh=gfnQfZvbBycEH6mze+hbX+x3Vkhgqjl25sZUdQySYsY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IAT62d6N34s9LhrQAVGVKPOVogtokYLfh+AGaHqeX25/3+/EJ/hpG+Oca7/7ShuL21tHJaMWjWG31AEZtBobJlIAJhW16ZHOWtt8MFxDEj+8jlgjWKtzQqZcbK/OzuFp4M6FcoUSw6OaA1XZq3ABLlgKRDkqUkXOpxhvNFTJKpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-4bb0e7e6cceso992995137.1;
        Wed, 12 Feb 2025 04:42:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739364148; x=1739968948;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FFJmWf9PLC2VPPWNEyS3sjZLQaSoXbf39gWYrpDNH+k=;
        b=AAu0I1JFr5D4gqCjPl47rx3eCQcqm4Vck+WyJX93F8a1TDCz28J4R26yAPueOgGnMq
         7EYo/OVLtXsU84IEClkMNTS4hDUzXyuvghFGaIgOrMhJz7cqB8khC9OEVOcVhd5K2qn/
         aGTgjr/A+z6Z67heY6r9OODXMwiwpvugAMO9RR96BuJ4YjIsZY3i9qEwwojy9YGNhK4X
         yEtH2shamBnJo3ucLOw/ED16os+4Osj2+JFFXaB7W36JMD8236IBxaO0fBi103Uyg2h8
         X29nawIyrDmrYANLK8OcOjIfySYu2FCt/Y83H1QmubQQD1+OlHVbU9n+i9JkI7fsI3O7
         G77g==
X-Forwarded-Encrypted: i=1; AJvYcCUFBq5r/cbK2ZWDEqSqVQXj5gxF2rip04OfwgvFKbIQWLoaD9PzeUkrwsGD5sFqoRMtwLvEwwFmWzYE@vger.kernel.org, AJvYcCXpX2eOQJ0l4o1DUeQGrL4uRGiFQcElZeObOuec/dFHtjt6Gr2RTQzddg6BFwInbWxiE/UxoQHgv2Csl28=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5PGe4VNBlStlye+SmZVzqu2Vw/uJOBeQ9XlsKInuFLst0Yyku
	etoCjZV7af/pk5g0cpKtT3Ex0XZot9C+jgtMBPRG835WHmR6YtukdH7WtZvt
X-Gm-Gg: ASbGncs9OAGBm1uqgjE2ZNURyO8UW0V17XlvPxnQbvkZ13m9Q4NvH7117LkF5EMrttP
	fn7F5/NWAEiP5r4p630jA22dfRva/C0jkiivHZeM9X3VTgFFd2qXef9CaWYHu0iuQL2KukDGOz8
	n70/Qqfy8QeIzcZ1vjjeJDoJRi1pMHUDAUO5/ce4msYnpPJGAq+grrekD0ND4E19j4Wh/0thXXb
	FnoiR8FSqy0bUI3l3yLhTcXfb6hZtJ+7kC5NUlPd13+k9Er9TVBT6fbiAfOqTjBbCEsQZmtMvIT
	pWANDQIzbRU/oaRCf3oFPZmY+IrqPLqrq2VgU1MbAjR7+NnlZwPYVg==
X-Google-Smtp-Source: AGHT+IF3YMgEuhS0qIlSgbLp0aZRkg+SNiu/6FAr+7c6EQpSMi02G1rz6Lhad4lFwNkQDPsQ1b389g==
X-Received: by 2002:a05:6102:3f0a:b0:4af:c519:4e7f with SMTP id ada2fe7eead31-4bbf22e8233mr2563004137.18.1739364148443;
        Wed, 12 Feb 2025 04:42:28 -0800 (PST)
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com. [209.85.222.51])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4bbdcf078ccsm695506137.3.2025.02.12.04.42.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Feb 2025 04:42:28 -0800 (PST)
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-8671441a730so1237704241.0;
        Wed, 12 Feb 2025 04:42:28 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU+7EAJ615qD4l6sMQhYEssrJqHaZkud7y7bB00KHwEOv4IzN6NbAsEcpIRcZEobAqTjmUrwLNmX/RhKtg=@vger.kernel.org, AJvYcCXxXe9k0nwxxlGIxpQMHi7DvlV/5SlWEntlPi7fNbM1pJdqBS1dTGgIj0BSnJwwVqXtn0IREQIddlRQ@vger.kernel.org
X-Received: by 2002:a05:6102:418e:b0:4bb:d7f0:6e50 with SMTP id
 ada2fe7eead31-4bbf23288cemr2351909137.25.1739364147818; Wed, 12 Feb 2025
 04:42:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250203-b4-get_maintainer-v2-0-83ba008b491f@suse.cz>
 <20250203-b4-get_maintainer-v2-1-83ba008b491f@suse.cz> <66c2bf7a-9119-4850-b6b8-ac8f426966e1@suse.cz>
In-Reply-To: <66c2bf7a-9119-4850-b6b8-ac8f426966e1@suse.cz>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 12 Feb 2025 13:42:15 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWvTDO6wcLQs1DwrEjj3jDDav5uKU6E-5=TKFK9w1Nb-w@mail.gmail.com>
X-Gm-Features: AWEUYZkJ3_m0j2FOFXfQoG21VRxPr1IQKZ7cn7WkguLKGKkl4S-XxfFtuRcefZU
Message-ID: <CAMuHMdWvTDO6wcLQs1DwrEjj3jDDav5uKU6E-5=TKFK9w1Nb-w@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] get_maintainer: add --substatus for reporting
 subsystem status
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Joe Perches <joe@perches.com>, Andrew Morton <akpm@linux-foundation.org>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	workflows@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>, 
	"Bryan O'Donoghue" <bryan.odonoghue@linaro.org>, Thorsten Leemhuis <linux@leemhuis.info>, 
	Kees Cook <kees@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Vlastimil,

On Tue, 11 Feb 2025 at 17:01, Vlastimil Babka <vbabka@suse.cz> wrote:
> On 2/3/25 12:13, Vlastimil Babka wrote:
> > The subsystem status is currently reported with --role(stats) by
> > adjusting the maintainer role for any status different from Maintained.
> > This has two downsides:
> >
> > - if a subsystem has only reviewers or mailing lists and no maintainers,
> >   the status is not reported (i.e. typically, Orphan subsystems have no
> >   maintainers)
> >
> > - the Supported status means that someone is paid for maintaining, but
> >   it is reported as "supporter" for all the maintainers, which can be
> >   incorrect. People have been also confused about what "supporter"
> >   means.
> >
> > This patch introduces a new --substatus option and functionality aimed
> > to report the subsystem status separately, without adjusting the
> > reported maintainer role. After the e-mails are output, the status of
> > subsystems will follow, for example:
> >
> > ...
> > linux-kernel@vger.kernel.org (open list:LIBRARY CODE)
> > LIBRARY CODE status: Supported
> >
> > In order to allow replacing the role rewriting seamlessly, the new
> > option works as follows:
> >
> > - it is automatically enabled when --email and --role are enabled
> >   (the defaults include --email and --rolestats which implies --role)
>
> With the following fixup, the above changes to:
>
> - it is automatically enabled when --email and --role are enabled and the
>   output is a terminal (the defaults include --email and --rolestats which
>   implies --role)
>
> ----8<----
> From f5523a85c742065fcb88a8aa26831f9dba9faf15 Mon Sep 17 00:00:00 2001
> From: Vlastimil Babka <vbabka@suse.cz>
> Date: Tue, 11 Feb 2025 16:16:11 +0100
> Subject: [PATCH] get_maintainer: add --substatus for reporting subsystem
>  status - fix
>
> The automatically enabled --substatus can break existing scripts that do
> not disable --rolestats. Require that script output goes to a terminal
> to enable it automatically.
>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

Thanks, that fixes the issue for me.
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

