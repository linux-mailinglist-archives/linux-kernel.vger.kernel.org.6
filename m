Return-Path: <linux-kernel+bounces-396885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EB9A9BD3AF
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 18:45:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33467284725
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 17:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEBBA1E1311;
	Tue,  5 Nov 2024 17:45:13 +0000 (UTC)
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8061DD0D1
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 17:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730828713; cv=none; b=ZxIu1h5rdchMyQtNjeaIthkmwtIHdj6zFWnpMK9UEKn47H2/imy7gh5c4bdPatp+PFQA9LkQ9JguZQUnCcnwjQNlMwQpZ7nOhjcSjJq5ubzkew5x9d77xcNIXRcCDqgF4wv5SJb0wIszFcZ0jInZVoPJSjgPCCHRJfuC/M2Xhl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730828713; c=relaxed/simple;
	bh=ecjxMWdhVaLLUuMcptw4/tjpiyom5/R0aaKpCuOg+uE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E6qaNAKMldwVQ5jR9HfcZrnAc+DMbMA4LCg5GZZDOMsjLeS7kLGwKV+7cPGjxV/78ADyPGMWnX6HApBP3JRu5mk7sadOHu0kU/IgnPGPf3kcELPomCupUneW1nVKHmBZ1VlLqzcF6hf7XdFPcsd4W1x7k6C70ZnQU5YNBo9VQ4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e2918664a3fso44652276.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 09:45:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730828710; x=1731433510;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u+3xEu/L4gA3mcrTWrHcuue6i3EHWLMLRjsPz9s2Jcs=;
        b=v5rw0MwmLblTNSPWw2ZlbxVQfesAYz5qusILFJBL+CCS5mQM2lAb6AnyVH0bJPmQA3
         Zp2azcZnsBScG8c+PLzPo1+gEdT3ibaKRRGPvrRRv45Qm6Y5tOA6cug0nH2S/OvotBBv
         5N7y7Tq9LFGErVkF04SrBogHVcjebXEEs+vCl8HZBi2uBFjefj3DOf+4IsUcNxT6CtOx
         q49dhFkAjvpCeruIMbC/iHQMYz6lRpDrn0Lz52Ob/ccBZM65I4tLWb+22kSKUNoXsZKv
         8L2ISa4o+49pCK2qkTrBdTIM3Jk4zqsRQNw6UCfWmvAFZlMLmXIafpKLl/DHDp/d/ic+
         eoWw==
X-Forwarded-Encrypted: i=1; AJvYcCU+5fa/R1vKUzrEMQhp70C8T+unANu3TfxveMlqetMEvHaUT2pZLtmT54xWDrVjmC/oD8fAk/cE09rA5tg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxglN7QPBxby6vJK0XA8o5rRb4WXaPb8MFDe088kNpq3NrYSbIo
	DvBDvhO/tAKZd7Wb+dLvmjR/ELcGRfArZWY58r7Bc8qCZdCnAP91CQfS7jQf
X-Google-Smtp-Source: AGHT+IGZ5npo4PdJLOpBbyVRdvj/KJva27aKqiz2taSs8MtG3RqGV1c2Ul+iVBOIFK7OWD2Ln2UDxg==
X-Received: by 2002:a05:6902:188e:b0:e28:e700:2821 with SMTP id 3f1490d57ef6-e30e8d3c827mr16272777276.25.1730828710025;
        Tue, 05 Nov 2024 09:45:10 -0800 (PST)
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com. [209.85.128.174])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e30e8a92044sm2645282276.30.2024.11.05.09.45.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Nov 2024 09:45:09 -0800 (PST)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6ea11b32ab4so329347b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 09:45:09 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUFGHJSvzHUGfxFcDQ2M3zTB9TpjHvtTI/Gzl29nVOQvirr1HocnZYAQszFyKGq48jDIgmfDH3O5rYDE9Q=@vger.kernel.org
X-Received: by 2002:a05:690c:740a:b0:6db:da0e:d166 with SMTP id
 00721157ae682-6ea55893852mr166474847b3.12.1730828709297; Tue, 05 Nov 2024
 09:45:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240929025506.1212237-1-daniel@0x0f.com>
In-Reply-To: <20240929025506.1212237-1-daniel@0x0f.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 5 Nov 2024 18:44:56 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWz9euGczd0pdEH8=yvK48-TfiQjqDO_RaGsbuuEDHDww@mail.gmail.com>
Message-ID: <CAMuHMdWz9euGczd0pdEH8=yvK48-TfiQjqDO_RaGsbuuEDHDww@mail.gmail.com>
Subject: Re: [PATCH] m68k: mvme147: Make mvme147_sched_init() __init
To: Daniel Palmer <daniel@0x0f.com>
Cc: gerg@linux-m68k.org, linux-m68k@lists.linux-m68k.org, 
	linux-kernel@vger.kernel.org, fthain@linux-m68k.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 29, 2024 at 4:55=E2=80=AFAM Daniel Palmer <daniel@0x0f.com> wro=
te:
> mvme147_sched_init() is only used once at init time
> so it can be made __init and save a few bytes of memory.
>
> Signed-off-by: Daniel Palmer <daniel@0x0f.com>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
i.e. will queue in the m68k tree for v6.13.

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

