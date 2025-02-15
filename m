Return-Path: <linux-kernel+bounces-515867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 84BE8A36A06
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 01:40:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 983F91703D7
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 00:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC7883B1A4;
	Sat, 15 Feb 2025 00:40:03 +0000 (UTC)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 554BB4C8F;
	Sat, 15 Feb 2025 00:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739580003; cv=none; b=Ge5DPCCX5t/i/yOr+rFcVg1CjxtpABEqY26m/AFn+lk+aX+UI/AoIjJtsvg0+wU3XHO4JEF4SvUykfZNxuQpIRANo+deOFPTaycMi/2jilWQyzmp+KGym6tJ5ZWby7m28ZEKG8M/QqbrZsANdHOr8PPWgRmO+dU9aGIn8JRVRqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739580003; c=relaxed/simple;
	bh=0lb+XuejwQ6WJ/rlS82FD9QDxDHkpczO99KyIdSRZVI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p9nn76HOqAJSvsE3IUvA18hsol9tVPR3YGPp2FU3fNTrAhjtHTvbNItA0zCKrZnMhHslX7mHsUvAbhgqUWLPCl6q3rHDIV+l59b8QQnlT7WJxpnsB5hSU9atRkGAHIzWdzy+qZgQG2XWccfeKghyV8C1OW/9wUigE5SPq3JckzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gompa.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gompa.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5de3c29ebaeso3359353a12.3;
        Fri, 14 Feb 2025 16:40:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739579999; x=1740184799;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3luXOCFKIPpMmtbHHxucGGaojmh3uFOnTbaxnuKr2fo=;
        b=JguzF46LNwACiQsMopADg1Lf8Qfr0mZC4gbAXd0wSG84/0dSqpUJbpWyoAWrU33/Dx
         sLuAnz0k9hy2xWuKtHOyDvLBb123rX3s+J5dU54cuJm0/fSrKu5d1ATWy3xy6aagKN3U
         zQ0lHofFmdb+fcNaH0hCzdCHOvDdXU9oJ3G1tDCtvQ0AYe5U86kM9J7X6P5LnRh0Q5R8
         G9sOCCiRh65wkE1DQnUYSLjzg2Kz5y2357jNtczn/1cTijZdLJmIPLbYgrTWyvsaP/MY
         6ip4mJsO5bbRdUtVq+YI+lHS8EEZhtJWMfvwXa5p649JL0IdA5r5CeWK3FQ1qOYXQ2Lp
         SWog==
X-Forwarded-Encrypted: i=1; AJvYcCUQZnBX3VRci9000eCRkm+yZ2+BWM6CIoZTTQ+b3PYLr22INoOp8B2AbpYVi4EGagdZai2EA8bc2j/j@vger.kernel.org, AJvYcCV1OTcSFVXaJtGVEYkhBwULXFzKUN7QsF+PlX+SMk9CrNqU2v8jiW0YjrjhP5ahtJ/3ZakDvNm/yARaf9Y=@vger.kernel.org, AJvYcCWoEABeLdOZ3/Jq5tZeFMZQzSlxvPwGNCEJfWBAjZU6zh/7B3qoJld0nVIQPqraXvLXc2pzP8+M4SkRkRVq@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+ybZzB7s1/VJX6Hm0OdJjGnIo1WxrGyuOvFWo6WZL1iQSg78/
	c+a167N7q8M24YLEENg5+1TsFViCRyZIu3w07YCNJXikQsLT/1mzrN1ToleZMwE=
X-Gm-Gg: ASbGnctrlTfpdUMAYLcGWkM6FuhC+0MYN9C07rHLAoOOXbmHrNIbb+HNU71XpvEn0CG
	jYe6JBlH3KiWWFkHJTOLxKYKc5cxjNmoOUexb01awaoNeR0of+ZLZhwWnSmCzAjcxwMFvBZT9vK
	gDd1FsKWlO2O7qVYId/q6tIjDpE3STBGyEqQkiy4y3qCTbZXp7OcKp2jtmga+fZDwe8GQGaun72
	Oci8p0J2nb5YY+W/O7DfQVF9E4a8aR0qpbRkhFUPbR9OSkYC4T0dMf+1H7vkO0QSVf4gdQ98kF6
	RDy/IhptqcwxlROc/YTFwLKG+++GiBgmhfDb2AI1pfN1+g==
X-Google-Smtp-Source: AGHT+IF0Uo4xlFR+saGDbMqIcC7mjqRiLm9I1kBAs5eBFL+Ee/Kvj/XnmPdrSeXiCiy4N2JKUwJn2w==
X-Received: by 2002:a05:6402:2805:b0:5d4:4143:c06c with SMTP id 4fb4d7f45d1cf-5e036177f5dmr1365671a12.23.1739579998829;
        Fri, 14 Feb 2025 16:39:58 -0800 (PST)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dece287c7fsm3617901a12.70.2025.02.14.16.39.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Feb 2025 16:39:58 -0800 (PST)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-aaeec07b705so433253866b.2;
        Fri, 14 Feb 2025 16:39:57 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUtL7IGyK5cXuA2nsMHhVDmU2y+w2zpN5qzJq5cLqyqNRUd/PNRgMkrILiMjBKDgiYitiguOUnSctaczjww@vger.kernel.org, AJvYcCVM2/f3l1yKfRPjeSv0DeJGSkysgU86zm+rhSRr7bpIvab3SOXDam03LErcwNQGgz9+mlbFSkL7XZ+ngDQ=@vger.kernel.org, AJvYcCWt65XWAtYlKR2TnMMIw90SR3Q7XdkVgJcTDqYmHDwKXI0BVL0QPZkppMK4+ZSpjmyfzVy3Y9Pra3iD@vger.kernel.org
X-Received: by 2002:a17:906:3118:b0:ab2:faed:f180 with SMTP id
 a640c23a62f3a-abb70b81377mr107070966b.33.1739579997503; Fri, 14 Feb 2025
 16:39:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250215-apple-codec-changes-v1-0-723569b21b19@gmail.com>
In-Reply-To: <20250215-apple-codec-changes-v1-0-723569b21b19@gmail.com>
From: Neal Gompa <neal@gompa.dev>
Date: Fri, 14 Feb 2025 19:39:21 -0500
X-Gmail-Original-Message-ID: <CAEg-Je9az=jLZSLg+4V0XYFzaxW02827+koSBkDd=RoUaiTFFA@mail.gmail.com>
X-Gm-Features: AWEUYZkDDgpalGANAbSSWSDtuS7jiEiBkOjRIsOJW9cVI5i9ylu35HYX48Q62mU
Message-ID: <CAEg-Je9az=jLZSLg+4V0XYFzaxW02827+koSBkDd=RoUaiTFFA@mail.gmail.com>
Subject: Re: [PATCH 00/27] ASoC: tas27{64,70}: improve support for Apple codec variants
To: James Calligeros <jcalligeros99@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Shenghao Ding <shenghao-ding@ti.com>, 
	Kevin Lu <kevin-lu@ti.com>, Baojun Xu <baojun.xu@ti.com>, Dan Murphy <dmurphy@ti.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Shi Fu <shifu0704@thundersoft.com>, Alyssa Rosenzweig <alyssa@rosenzweig.io>, 
	=?UTF-8?Q?Martin_Povi=C5=A1er?= <povik+lin@cutebit.org>, 
	Hector Martin <marcan@marcan.st>, linux-sound@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	asahi@lists.linux.dev, =?UTF-8?Q?Martin_Povi=C5=A1er?= <povik@protonmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 14, 2025 at 7:04=E2=80=AFPM James Calligeros
<jcalligeros99@gmail.com> wrote:
>
> Hi all,
>
> This series introduces a number of changes to the drivers for
> the Texas Instruments TAS2764 and TAS2770 amplifiers in order to
> introduce (and improve in the case of TAS2770) support for the
> variants of these amps found in Apple Silicon Macs.
>
> Apple's variant of TAS2764 is known as SN012776, and as always with
> Apple is a subtly incompatible variant with a number of quirks. It
> is not publicly available. The TAS2770 variant is known as TAS5770L,
> and does not require incompatible handling.
>
> Much as with the Cirrus codec patches, I do not
> expect that we will get any official acknowledgement that these parts
> exist from TI, however I would be delighted to be proven wrong.
>
> This series has been living in the downstream Asahi kernel tree[1]
> for over two years, and has been tested by many thousands of users
> by this point[2].
>
> Regards,
> James
>
> [1] https://github.com/AsahiLinux/linux/tree/asahi-wip
> [2] https://stats.asahilinux.org/
>
> ---
> Hector Martin (14):
>       ASoC: tas2764: Enable main IRQs
>       ASoC: tas2764: Power up/down amp on mute ops
>       ASoC: tas2764: Add SDZ regulator
>       ASoC: tas2764: Add reg defaults for TAS2764_INT_CLK_CFG
>       ASoC: tas2764: Mark SW_RESET as volatile
>       ASoC: tas2764: Fix power control mask
>       ASoC: tas2764: Wait for ramp-down after shutdown
>       ASoC: tas2770: Add SDZ regulator
>       ASoC: tas2770: Power cycle amp on ISENSE/VSENSE change
>       ASoC: tas2770: Add zero-fill and pull-down controls
>       ASoC: tas2770: Support setting the PDM TX slot
>       ASoC: tas2770: Fix volume scale
>       ASoC: tas2764: Set the SDOUT polarity correctly
>       ASoC: tas2770: Set the SDOUT polarity correctly
>
> James Calligeros (2):
>       ASoC: dt-bindings: tas27xx: add compatible for SN012776
>       ASoC: dt-bindings: tas2770: add compatible for TAS5770L
>
> Martin Povi=C5=A1er (11):
>       ASoC: tas2764: Extend driver to SN012776
>       ASoC: tas2764: Add control concerning overcurrent events
>       ASoC: tas2770: Factor out set_ivsense_slots
>       ASoC: tas2770: Fix and redo I/V sense TDM slot setting logic
>       ASoC: tas2764: Reinit cache on part reset
>       ASoC: tas2764: Configure zeroing of SDOUT slots
>       ASoC: tas2764: Apply Apple quirks
>       ASoC: tas2764: Raise regmap range maximum
>       ASoC: tas2770: Export 'die_temp' to sysfs
>       ASoC: tas2764: Export 'die_temp' to sysfs
>       ASoC: tas2764: Crop SDOUT zero-out mask based on BCLK ratio
>
>  .../bindings/sound/ti,tas2770.yaml       |   1 +
>  .../bindings/sound/ti,tas27xx.yaml       |   1 +
>  sound/soc/codecs/Kconfig                 |   1 +
>  sound/soc/codecs/tas2764-quirks.h        | 188 +++++++++++++++
>  sound/soc/codecs/tas2764.c               | 302 +++++++++++++++++++++----
>  sound/soc/codecs/tas2764.h               |  29 ++-
>  sound/soc/codecs/tas2770.c               | 264 +++++++++++++++++----
>  sound/soc/codecs/tas2770.h               |  20 ++
>  8 files changed, 711 insertions(+), 95 deletions(-)
> ---
> base-commit: cc7708ae5e2aab296203fcec774695fc9d995f48
> change-id: 20250214-apple-codec-changes-6e656dc1e24d
>
> Best regards,
> --
> James Calligeros <jcalligeros99@gmail.com>
>
>

After years of iterations, I think this series looks good to me. :)

Reviewed-by: Neal Gompa <neal@gompa.dev>


--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!

