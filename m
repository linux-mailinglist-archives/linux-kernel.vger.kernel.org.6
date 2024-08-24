Return-Path: <linux-kernel+bounces-300031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B8AC95DDD5
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 14:35:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8ED11F22368
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 12:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD97715B0FE;
	Sat, 24 Aug 2024 12:34:53 +0000 (UTC)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B84CEAD2;
	Sat, 24 Aug 2024 12:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724502893; cv=none; b=temQ1qTwvUtrhdncvBsfcAZ0olKBjbwxF1ovFSdx0zbiwEBegqz9ionJ01QXz8+UdS74OpPCQiWRuDxsuL7TQOs20RZvWTtsnda9ax1mqWflwsu8Z/XIFT8V4UfmFpTWjPIk0ZY7LDKD1B1TF3yFT5nZjwJbh4AN+IJIfnZAMyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724502893; c=relaxed/simple;
	bh=QwXiEAjwEXoAE6zGlVy7wCnl4gDD0wbHdryjStKwejE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jXnGrAr8OamkBtJLHTQxL/V34J/gV0Xozpc7kSR7LpBuIg8l4LUZfqc9dxrqEy9iXDyYtNkaLkUrPQccFBN9HpCuAz4LHnBvWw+WnbxOb7bjx9VZT93w030I1DIbYWr50MkqqiiE99FKWPIJgkhW2ci3LDk/lMx83X/BuglPeaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2f3f25a1713so31101121fa.2;
        Sat, 24 Aug 2024 05:34:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724502888; x=1725107688;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QwXiEAjwEXoAE6zGlVy7wCnl4gDD0wbHdryjStKwejE=;
        b=EdMOxVkwOwDdZJtbaCuVdT8VJX/FkKxAcMLlEAhxUfLD+f6L6TsdhXZ13eHH0ok1j/
         3VnV89SEkSpt2nn4gfOnbTjXavSXYPq/Xo+sjn/NVfpwfzTq8UHGdNtDkDZnjYWzWTzS
         0fUolT1EZiZ8Ev6nPNBUOPKHOlLIO9iOopBv2wh1U2hLtwpgdabn619JcuOmvw6sVS41
         4rhnMZ9yjaxw56rquNv0XPPNFu4eG+bhKyVARqjQv1AjFk7Zt2THDjiLvDXHyhOnkxaS
         aNrcSc8fe7skD85+WoGzG3Ut5OzxGNosi2wJXE9fw/ZEp/aK+j0wmUTsuyCuAY9qJn7m
         zcoQ==
X-Forwarded-Encrypted: i=1; AJvYcCVHTB4PE1bv52D65A2pL57i5OOzLZYX9WPUao0mBlQv5We1B6dhzZ86xla9ct93uYAd7jquJLuTdBEVFzfX@vger.kernel.org, AJvYcCVl6lmlUGKkLVG3/AAJMaGuTZW55LsBgn4r6VznssiR8NX4u4H9+2l1S5E2TgF0lO7PGtpBEDEvGmGs@vger.kernel.org
X-Gm-Message-State: AOJu0YxNwNGBkbm3CSVa3DndMHpmjQKJq8bDL6GjpVuF8IH/OBSuVkPP
	NRF8xLWVPk3ip3unRUQUKLbADyoBTShRe4oE7baFjssmoqeju+6G23pPe0L8
X-Google-Smtp-Source: AGHT+IEL59n43hKVxd71HEFoe31D4O3Zu3KEPOXyNUERPWI5keSe6ZmfSohPP7QCiINhp3DMHDgtJw==
X-Received: by 2002:a05:6512:b85:b0:52e:f367:709b with SMTP id 2adb3069b0e04-534387bb201mr3337946e87.42.1724502887137;
        Sat, 24 Aug 2024 05:34:47 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5334ea5d938sm845913e87.199.2024.08.24.05.34.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Aug 2024 05:34:46 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2f43de7ad5eso30877271fa.1;
        Sat, 24 Aug 2024 05:34:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV0d1hicd/GKBxIShNHlrcmAnodz4/Gx2o3eovxMVx/4CN5/ljtGeKZxZNJ9Rvq47KVz4yJ7qf0mHU9@vger.kernel.org, AJvYcCV3o40zWXr5UE5awaaTpBT18DjcaBnhtIX05Df1XByuBjKSztW9xBsAQ+oLgENCILZIZF4Pjhxeqyd1Wj1N@vger.kernel.org
X-Received: by 2002:a2e:4a12:0:b0:2f3:df8f:bfaa with SMTP id
 38308e7fff4ca-2f4f4927f82mr28693001fa.36.1724502885863; Sat, 24 Aug 2024
 05:34:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240824-b4-fix-nanopineoplus2-pio-regs-v1-1-7c5f7da445af@gmail.com>
 <761f18d4-9274-4983-a128-94efb96e1c59@kernel.org> <51f28d92-f670-47de-8e2d-53cbecfac081@gmail.com>
In-Reply-To: <51f28d92-f670-47de-8e2d-53cbecfac081@gmail.com>
Reply-To: wens@csie.org
From: Chen-Yu Tsai <wens@csie.org>
Date: Sat, 24 Aug 2024 20:34:32 +0800
X-Gmail-Original-Message-ID: <CAGb2v65M6Zz7=TfRwF0urbELNaaazMZYsd3dtHYzwdJvzoho3A@mail.gmail.com>
Message-ID: <CAGb2v65M6Zz7=TfRwF0urbELNaaazMZYsd3dtHYzwdJvzoho3A@mail.gmail.com>
Subject: Re: [PATCH PATCH] arm64: dts: sunxi: nanopi-neo-plus2: Add pio regulators
To: =?UTF-8?B?S3J5xaF0b2YgxIxlcm7DvQ==?= <cleverline1mc@gmail.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Aug 24, 2024 at 5:08=E2=80=AFPM Kry=C5=A1tof =C4=8Cern=C3=BD <cleve=
rline1mc@gmail.com> wrote:
>
> I am sorry if the message is wrong, this is my first patch ever sent to
> the Linux kernel. I have checked the schematic of the board and it
> shares the same power line with mmc0, so I assumed I can use the same
> regulator. Thanks for your feedback and I would be glad for your further
> response.

So some of the pin groups do have dedicated supplies, and should thus be
described, but not all of them. The schematic only shows dedicated
supplies for PD and PG pingroups. So just add those. PD supply is from
2.5V ethernet PHY I/O regulator supply, so you would need to add that
as well.

The datasheet also mentions a separate supply pin for PC pingroup, but
it is not shown in the schematic. I would just omit that.

And as Krzysztof mentioned, device tree changes should be to model
the hardware, not to work around some operating system warning. At
least most of the time that is. So your commit message should also
be about fixing the description or providing more detail, and not
about the operating system.


ChenYu

> Dne 24. 08. 24 v 9:40 Krzysztof Kozlowski napsal(a):
> > On 24/08/2024 09:09, Kry=C5=A1tof =C4=8Cern=C3=BD wrote:
> >> The board does not have a dedicated regulator for pio and r_pio,
> >> but this fixes the kernel warning about dummy regulators being used.
> >> Tested on the actual board.
> >>
> > Judging by commit msg these are not correct regulators. Please do not
> > add incorrect hardware description to silence some warnings coming from
> > OS. Either you need proper (correct) hardware description or fix the
> > problem other way, assuming there is anything to fix in the first place=
.
> >
> > Best regards,
> > Krzysztof
> >

