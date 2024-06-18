Return-Path: <linux-kernel+bounces-218788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08BB690C609
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 12:13:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D14F8283863
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 10:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6740B139D0E;
	Tue, 18 Jun 2024 07:39:36 +0000 (UTC)
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F33977102
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 07:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718696376; cv=none; b=SU0KsDiKKA9WbuVCSCbKOhbQl1AYGAAlGoDwbiDXHaLhKSyOIgoWl72FaBry6wUgxFQIa7OaaLXEHt9LEHVncDa34BcP4ewd8tN+K6Ba7I+YumAyO3d0IMeh/JMNdlj4HxzErnqIsHfp/dXImWEI3kHVPJFRrRvPmDbHRJn5rrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718696376; c=relaxed/simple;
	bh=iFj1EOLNRi8OEe3awn9Vs/G2Qc1FpXOws35aK5rTw9A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qFEDrzPYKXd9VpzO6Hxvk/gBD7K7Og28uxDMmbSL5Fb5KQ9l5v+ey5yShtNzVz7aZwhkZbBB/GNOy4YTO09rCd//9cQ/uy3zvUlZW+T8AsJT76r6S35xSHqXZFPCloj8CKEA7MAUbxexzl/CNQDmjLBTKnJMomSB1wVntYWa0ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-632597a42b4so28909007b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 00:39:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718696373; x=1719301173;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TC99j/wOMG6xkn/KBJaP1XjEqr4S+ZxXwwULNYN4qNM=;
        b=pc5vJFRBkrEyGRp9gmqRPz5QD4WmcCbcRV3djW8hBnNpTvCQcF8e4K+TwmjafEQPw8
         BKfOP3LdMA0Hi7WdkNsOpFb+yzVBH3y2baCr2pNFcBBOBnMNSRtiOtTMceiZhV5jNJo4
         q3ixudXKEjPPYrchpxaMB/GmAzuJU8MF2fzKwSjDs84ZG4xrN9/zjAi/2nzh2ZPeYTwd
         Auwmca3rpirjJq3yRhEECwpURUlXc+EUSZrJSWgIXgekSsZ01NZJdu5Mq4YtICI8lO0G
         fPviptkgakikcv5oJxTqpslgonTrbKO49MHY8/QlJ5YXCdXbDrZfvSgyCCf6nzEpGZew
         5tfw==
X-Forwarded-Encrypted: i=1; AJvYcCXyXMrqjn70aqujhtjPbVC1LMofsNlNoL/6ThFj+MNyc7/V4vCmtFhmx2sp3baegBORDv/A7f9D3O659Jzdnrfpr2GEdZrJEjsdU1+M
X-Gm-Message-State: AOJu0YyatWgUVd0y98ohNYzFQhlbLBeE9GXz8LShNF7IXd3VkllOSsJB
	28LsvINF1rnOf33xRGjrI6GHCnx9kKRPMN6Tcw6tJOD3G+SV5YTJkzAKHqZ/
X-Google-Smtp-Source: AGHT+IH8u2h8LgEi3v+cXLgfB/gRGxcwdtslsRyiwUruq2UdHkx/5TS78KaOqsV+jsX056Q8Zz55Vg==
X-Received: by 2002:a81:dc07:0:b0:62f:19da:a53f with SMTP id 00721157ae682-6394522ae53mr11867387b3.0.1718696372961;
        Tue, 18 Jun 2024 00:39:32 -0700 (PDT)
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com. [209.85.128.179])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-631183d7d41sm16995087b3.29.2024.06.18.00.39.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jun 2024 00:39:32 -0700 (PDT)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-632597a42b4so28908867b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 00:39:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVTGYL60vkAWRd/e7/yxMCrDDuydViOfMfoMo6pTsu9kkvI0LQ3WwCQvE/ZJBMg5YDhb9eiiA8u170jWKLmOLxzCx3aPB2+1N0v9ZOz
X-Received: by 2002:a81:e30d:0:b0:61b:e61e:8988 with SMTP id
 00721157ae682-63949fecfc4mr12300737b3.18.1718696372575; Tue, 18 Jun 2024
 00:39:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240618073205.65303-1-jiapeng.chong@linux.alibaba.com>
In-Reply-To: <20240618073205.65303-1-jiapeng.chong@linux.alibaba.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 18 Jun 2024 09:39:19 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVJ9e=HTgZA=4A_7kG4y4sDVCz4ooYHrhGHweR473ME8w@mail.gmail.com>
Message-ID: <CAMuHMdVJ9e=HTgZA=4A_7kG4y4sDVCz4ooYHrhGHweR473ME8w@mail.gmail.com>
Subject: Re: [PATCH] zorro: Use str_plural() in amiga_zorro_probe()
To: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc: linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org, 
	Abaci Robot <abaci@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 18, 2024 at 9:32=E2=80=AFAM Jiapeng Chong
<jiapeng.chong@linux.alibaba.com> wrote:
> Use existing str_plural() function rather than duplicating its
> implementation.
>
> ./drivers/zorro/zorro.c:155:22-39: opportunity for str_plural(zorro_num_a=
utocon).
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=3D9350
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
i.e. will queue in the m68k tree for v6.11.

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

