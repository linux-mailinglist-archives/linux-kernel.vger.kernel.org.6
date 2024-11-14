Return-Path: <linux-kernel+bounces-409453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7BAC9C8CE6
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 15:34:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65EE41F22D4A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 14:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71D592943F;
	Thu, 14 Nov 2024 14:33:57 +0000 (UTC)
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3351024B29
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 14:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731594837; cv=none; b=DnHz76GzxMcyg4WmcQQqc5eq1feHaMXcRBge+g4mCf/h3uiuYrZNcBAbdDTXZyt5JdDGL8095/93zHK02JjnDDbRqCodsjVFVjembigdrjaxX675FnEVfKltYXVWSk6KNyWwXWUvJArfDerbKiLOzS7xholswgYl4Y5dTSREi0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731594837; c=relaxed/simple;
	bh=a2t696/tUcI7AGVnuVNMoL6IpwgPM7DTRr7GR5h0jpo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oqh4/fjU9XqabM1w+WV+riIHyvztteDYogEl8NhL/IbU+Idmy9A2Xt9oPn15D/oFL7UZiYMJsywzc5uuyztCWUmxQK/2qGOF/mcvIE6DG4SvYNMimnPNHWgB8ssP+CDUd5CgWMEnrEo5fGaSHOtNierJDv73DXKJkDhMNiauSvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6e5e5c43497so6277897b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 06:33:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731594833; x=1732199633;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qaBor854o0Olb/ajvUp7Qs8qyIpHiwNdHulDZm1imEc=;
        b=ugL7hlAGJXr/MiFmRYXn5J6yyJ69nZ9ZZG2ZQnEuFl9w+jfmn5a7ImX7oFZpPLO94+
         QbyZObSxhsuYdejMjnh27C4xGTJ0gwuqdFAUB7ytFPpSRQ/u6xok4KA3jbYCDPYV1tLC
         uGEVF+H89Rk2qh/i9kvHQJ2mHmGi45ouHfQpFARWBfG229y0pciej44rwWAdBNwn/pW+
         2UbGKKhkviDIG7H8MsTGVyNITxklodhfxJ+rLfj0T+zmP2hSRmnmnc2mCgkZ7Y44nFok
         PiRj4hH0cHWQwPmHx4z2zqAtdPJvfgqaz2u+fkaR6n3zBTZ7bONhd7qpgVcs9HhhJIOo
         XoAw==
X-Forwarded-Encrypted: i=1; AJvYcCXLXGkm4lKvjo12BW/5gKQbmanJAzdK0WsCmZ4glU3CmhkHhgdiLeGy3wp6/XBmUaYIwmw+GCBFiByWrRo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmfBwL5qWUIvI8uhANggnBD5Bg0oddHjs5qvmumFS3TI6ODleQ
	C/o04nJC8y2vrqEDfTwa2ADqF+EH2w5ihbv7p/aqtPUEkpt3U2l5HZ71s4bH
X-Google-Smtp-Source: AGHT+IFhMV4R/CgrMtPd8e3ixKtl3E7R3gqj8ElmkmdIQrnoCl17Qw69xBnbXXU1XZykL9gIvI/lgQ==
X-Received: by 2002:a05:690c:6f87:b0:6e3:4190:ab45 with SMTP id 00721157ae682-6ecb32cb08amr78904787b3.15.1731594832716;
        Thu, 14 Nov 2024 06:33:52 -0800 (PST)
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com. [209.85.128.180])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6ee4400c7dasm2621117b3.24.2024.11.14.06.33.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Nov 2024 06:33:52 -0800 (PST)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6ea85f7f445so7274307b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 06:33:52 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUPg6dGRt9fdJgwQNtnwdgxn0fYGgZr44KbBfR1Kuha5I8i403CAAJKxd15ZLiYnIhe6SPVpicbtSxd3Dc=@vger.kernel.org
X-Received: by 2002:a05:690c:e20:b0:6ee:4d01:b9df with SMTP id
 00721157ae682-6ee4d01bb58mr10698597b3.37.1731594831784; Thu, 14 Nov 2024
 06:33:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241114131114.602234-1-mpe@ellerman.id.au> <20241114131114.602234-6-mpe@ellerman.id.au>
In-Reply-To: <20241114131114.602234-6-mpe@ellerman.id.au>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 14 Nov 2024 15:33:40 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUUV=Rrrg=zJcvS7LNTKJYy6jAa80C+dtehquz7Wt8L0w@mail.gmail.com>
Message-ID: <CAMuHMdUUV=Rrrg=zJcvS7LNTKJYy6jAa80C+dtehquz7Wt8L0w@mail.gmail.com>
Subject: Re: [RFC PATCH 06/10] powerpc: Remove prom_init longtrail work arounds
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, arnd@arndb.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 14, 2024 at 2:11=E2=80=AFPM Michael Ellerman <mpe@ellerman.id.a=
u> wrote:
> Although these work arounds aren't guarded by PPC_CHRP, they should only
> ever have taken effect on CHRP Long Trail machines due to the firmware
> version check. With CHRP support removed they are no longer needed,
> remove them.
>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

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

