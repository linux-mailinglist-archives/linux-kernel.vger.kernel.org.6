Return-Path: <linux-kernel+bounces-411706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D64459CFEA2
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 12:38:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66E2EB2A9F2
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 11:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F80B192D67;
	Sat, 16 Nov 2024 11:38:39 +0000 (UTC)
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC2B824BD;
	Sat, 16 Nov 2024 11:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731757119; cv=none; b=ZRFo/x9unrnKysTkqDurW8CrgE7m372M/JQ8prAo6XcZChQQ2rGRKzqjPVHM0dIcsNo5Sj5YRcP9ctzgrsudF67Vot9M1JW4OEx038sq2md62fbNfF/J8HBXrtBLfdBXEbINl+n4vI/iDAkE+UhPct2H7kfKBWZIssfFl1CX0lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731757119; c=relaxed/simple;
	bh=Zap2aep+vNFM220ijcUpwGFHEFymziwZf09SUSqZnRQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AJ5vyxy8vqlHOqkNlFSkCV8F2B4UXpkght7qZeFrlnECi7M86LuD0IeV8FVojPDht+oM/UchrqwyczIsXtTe2xlBpnWNZ4iv9nmfwOoHLb4RJR65ZhEp1Z+cgQRvpQsHqBs73Uv2jJ2oLP+M0dtuXpwOZgoxyTz83IRzUUAlLjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e3808e94734so2615930276.1;
        Sat, 16 Nov 2024 03:38:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731757115; x=1732361915;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EDhWc4gXFzI9mAEerZZdD8NdXzb6q6RtVPXmYGUYyVI=;
        b=xNCupFupJEGvL4cat30rODmDnOihNB/Q4moUjKYicNbV7PuqoylocJWmeVHyqP7aDx
         YpDnMstHdCZszIQm0u5QixwR/SJODwslj90x6AEWpWPFfT1kcnoLRpUCQfNb0qrTaHiP
         OB3ID5I4Mut+a/2iiPhfdcUpa9I75WfuweVrGA+LKKqsXeiltUL43IG/RIbdku986TQw
         aDXAsxr8TlNYdOhJsopLOWVGGtU5/Mt/LtpUCEcYZf14vzBn0Ll4F8t5Bp/CZzKeiqrR
         cYbq9y6ePQpjDmZPnMnd3G/yoe5tSsLHGvFZKvhJ5pjwMipi+YX0QMJgfiEyQeAsQJYl
         TorA==
X-Forwarded-Encrypted: i=1; AJvYcCUCBROiKl3wTxO23NjKSQKDFlYoNP5nyZ3zZDuKmzGJmaPY6wKIDdiU0J0QoW4/lrgci/XCmNt1jLZc@vger.kernel.org, AJvYcCVXyBh52Pp6VrwMZuPZFizx5n+rvO2b/jWaPwd2m9SHZpsCans9VMUxGXoi9tEKmKqn+mI+AuRRSjFneTCX@vger.kernel.org, AJvYcCXKFzrTgB8baOu9eWH1SbsygZrWmk55MYlYF4focMzuG9Pt9bdJipiFF9qNLeW9Hqa+2R2a2kcqR64=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDrx0DgDMmIZxhbxkHl3SfMERyKR/dMJRGpIhM3suD3KG73GFv
	AXgDec7kS/78sLv0lTV6dOPzuuNK1o4YJzYn8w30etaq4/ReTw62V18HdKni
X-Google-Smtp-Source: AGHT+IFs41NNri/CgIMxcxXPkX4syZ/3ZmXwPBvKIjHvkZgva9GmqFvzKNizs9/QHF610uJMeSXW9A==
X-Received: by 2002:a05:6902:240e:b0:e38:1233:e9bf with SMTP id 3f1490d57ef6-e38263a8dd6mr3798625276.42.1731757115192;
        Sat, 16 Nov 2024 03:38:35 -0800 (PST)
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com. [209.85.128.177])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e387ea609b7sm411729276.52.2024.11.16.03.38.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Nov 2024 03:38:33 -0800 (PST)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6ea0b25695dso23413357b3.2;
        Sat, 16 Nov 2024 03:38:33 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCURBHqHZLIBMlanJ3WvunCxcyILVre6nhnqoTP8tWUFbP2iVLjhPO2Dkxc6O3g//t9tGg58Wd7hDkQS@vger.kernel.org, AJvYcCV+UNwpw5vU5snPGUlghif0b3AYD1REBYGz5ZNN5M2z2oBLkkx5sOLZpm4hrbjTK3YN467iq0Ahujk=@vger.kernel.org, AJvYcCVrR0qSQ3zhuu0EmwXUbQHeAUNqrLEIYZSs7etLfxhpq0PcPLnKlu+c7UxxnnRr2fO6YGxlb8kVHq56yKbZ@vger.kernel.org
X-Received: by 2002:a05:690c:6386:b0:6ea:8647:d616 with SMTP id
 00721157ae682-6ee55bee948mr67382427b3.15.1731757113344; Sat, 16 Nov 2024
 03:38:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1731749544.git.linux@leemhuis.info> <b7dce8b22a391c2f8f0d5a47bf23bc852eca4e71.1731749544.git.linux@leemhuis.info>
In-Reply-To: <b7dce8b22a391c2f8f0d5a47bf23bc852eca4e71.1731749544.git.linux@leemhuis.info>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sat, 16 Nov 2024 12:38:23 +0100
X-Gmail-Original-Message-ID: <CAMuHMdU5fsLDvwf6-cQhvpNB_7e+KZRrqj1UOMz7YjXRv0cZTg@mail.gmail.com>
Message-ID: <CAMuHMdU5fsLDvwf6-cQhvpNB_7e+KZRrqj1UOMz7YjXRv0cZTg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] docs: clarify rules wrt tagging other people
To: Thorsten Leemhuis <linux@leemhuis.info>
Cc: Jonathan Corbet <corbet@lwn.net>, workflows@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Simona Vetter <simona.vetter@ffwll.ch>, 
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Thorsten,

On Sat, Nov 16, 2024 at 10:39=E2=80=AFAM Thorsten Leemhuis <linux@leemhuis.=
info> wrote:
> The latter is not a theoretical issue, as one maintainer mentioned that
> his employer received a EU GDPR (general data protection regulation)
> complaint after exposing a email address used in bugzilla through a tag
> in a patch description.

And once it's upstream there is not much we can do about that anymore,
right?

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

