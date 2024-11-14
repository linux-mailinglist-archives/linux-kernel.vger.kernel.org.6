Return-Path: <linux-kernel+bounces-409454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A04E9C8CEA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 15:34:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C77C2864D3
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 14:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0DB52FE33;
	Thu, 14 Nov 2024 14:34:44 +0000 (UTC)
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F112F9E4
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 14:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731594884; cv=none; b=unXoTRWGqo7UcjZPHNPCDwi5Rg6dy9VtwteSINzWUj7aetIaIFY3xGe/frX8pZ+2MQNCgWDsoxLXnOTncphn1nR3skKDdgs72icstNns0cSzl9858BkbHtbneNTvj37ZIQ9JVamPgyLtpSLmmZzdPINvcZYAQaUHbNBnX1OVJDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731594884; c=relaxed/simple;
	bh=cdYypJcchO1v4yw6byfX6Shr1mcaFr3/1gTCqXWc0qs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kuq1xcyrUj4SztWJ+N3NoGcasdzffg/OdPrjl5jEXdVlrmEoys/9Q4TsZZ9tKqy01yP7mDP0aQjjN2hCsJsdKESiwI3Diky/4A9769M1f9G3IU54CXYJUKZWI2cPSd9iLc043Qra6wYzWrO0FIGqMca2ZueE/CGksY4YFoEjtWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6ee4beee4d1so3675327b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 06:34:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731594881; x=1732199681;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QEAcw9uV3ZgK8E/wHybD7i94tC5TQw6FAbTmmAV3SqA=;
        b=oTOTBZCmq/tc2OhZ8AMxKhgF1e3PAnjTWgDMJYOestYSo3qCA6EB6/+pUJVXO37Ira
         1S6o2V6m9V+A4rkLCNkE3yiT3n9TH/ZqESMO4NGMmnV3A2hxgKDCqSJP1Z1OBUYg/PUA
         pxX6tPF2CIdC4OH7IvZu23TLGlT+9HLWm2SmflHULGvAQeoC9wNFitzgXkrlfIJNXzOB
         g/A325/fuGO5KRtm0vpIsqPWlzQmGdFRzs1PHtKjrY8BWTCebVrp7gpMHiRN9xxZ8KvX
         ycUU0M6ihwXiUfUZBY/8KaSgHylSE3ZVFac/3cOR4+UEzZx+ny5Bvpwi9+DQd2s6p09q
         F/JQ==
X-Forwarded-Encrypted: i=1; AJvYcCVRTHLuKaNekWHRrodhw/k+zU/y8jWzvYvrGilWAqUXAvORJS71hlgNNrX+E/iNEE2kQZvcTdlAN8cfX7A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNDYkP21ofdXFN9lWJ1ztpU1uvxPmJX5rnYcYcP4iOKG8Fc0rh
	8fkwYp22fpI3BA/8S7bIu4VjR495JlFlMREu5PUOHnAbn0oMjR3k6gATIgS6
X-Google-Smtp-Source: AGHT+IH4UC5JNhiXX/UvGaK1GwjDDU7/hsmF5F/8w+OtqtB18/OPB7TCylo42SrKiRxzIfTjZxDOnA==
X-Received: by 2002:a05:690c:998e:b0:6e3:3521:88ff with SMTP id 00721157ae682-6ee433b299amr21224907b3.18.1731594880687;
        Thu, 14 Nov 2024 06:34:40 -0800 (PST)
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com. [209.85.128.174])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6ee440742b8sm2579397b3.64.2024.11.14.06.34.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Nov 2024 06:34:40 -0800 (PST)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6e5a5a59094so7198667b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 06:34:40 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUwQQDUUunSSiK8/n9XXHTma5RYdSAdWTnzGDGKHjW2e0R7QrMi4G9cJQx152yi35KcXA+7RyF0ZiAc5Vs=@vger.kernel.org
X-Received: by 2002:a05:690c:6ac1:b0:6ea:7c35:e2ab with SMTP id
 00721157ae682-6ee433a2b9emr20348327b3.15.1731594879829; Thu, 14 Nov 2024
 06:34:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241114131114.602234-1-mpe@ellerman.id.au> <20241114131114.602234-7-mpe@ellerman.id.au>
In-Reply-To: <20241114131114.602234-7-mpe@ellerman.id.au>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 14 Nov 2024 15:34:28 +0100
X-Gmail-Original-Message-ID: <CAMuHMdW4f_6v-2ZLFxBvazPOEvF+4PG1E1f_Ye2j49y6ixmK_A@mail.gmail.com>
Message-ID: <CAMuHMdW4f_6v-2ZLFxBvazPOEvF+4PG1E1f_Ye2j49y6ixmK_A@mail.gmail.com>
Subject: Re: [RFC PATCH 07/10] powerpc: Remove CONFIG_ISA
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, arnd@arndb.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 14, 2024 at 2:11=E2=80=AFPM Michael Ellerman <mpe@ellerman.id.a=
u> wrote:
> ISA support depended on PPC_CHRP which has now been removed, making
> ISA unselectable, so remove it.
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

