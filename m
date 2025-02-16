Return-Path: <linux-kernel+bounces-516502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 23359A3729D
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 09:41:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 317AD7A33C3
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 08:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 742641624E2;
	Sun, 16 Feb 2025 08:41:30 +0000 (UTC)
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91984156F54;
	Sun, 16 Feb 2025 08:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739695290; cv=none; b=JVDnTuJM9CizfLiMfaLs0zFMoHx04pbXwcsr76u/2ELwt2uvKEXU1YzvgZd/gy3qzbovGoR+lsuFIxpb0sxUI6o/MTcUdNgyPEhtlmwG+IhdrG3Xt0TqXoT0m4l6AZ/Bcb8vKfLVkXrEMdWi9eJAAvBq0sBR4qy5UW5HnvBQu/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739695290; c=relaxed/simple;
	bh=NDauxWvP4zGEWLX2W+K6T7Oriu1jvS92cQC6yKTCz44=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rH2xrqlrCiuQVJMqoZxCNVYbDPPCZJJNdWZO56pUMsMKzF9OkHsBhA9qitA/mATs1SxM9O5nRJqC0rgZkrxS6cnkOLZhMKnIKZR2Q349zyc5X43032/pwwaTUrvtujGQcn9r/WMdZ+DeCHpgLEfBwr/+FBMUzmS725U6CXPY8Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3ce915a8a25so11604065ab.1;
        Sun, 16 Feb 2025 00:41:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739695284; x=1740300084;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Dpo5WMvSHiZdUjnCU7ZcgyQ986Sd3fENuocGlx6aSZQ=;
        b=QYLdx1SnFpI8YjzOTKzVtvmV4JSRBd9hMGMMIkD5isKIMc53CMQdm+eHmSqLHooL6m
         dPfAnW0+jx1Qdk0uxZHPE9Om34CRnlNRDUdJ98wc502K8lx4uN1CbVSzs8ReCeQJnVYV
         oiwLepiSNlTSV12NZr8SlZBse13ZKkHZm+ERXsqgoSdnNn6am+OUNaPShr3HXbtvgstR
         q54Wp9WiLUEMn2qAd4JtuAR4Mpw4QthWDsc517eynmgL2z49WGxSDyzKsLSPO7yKPCkn
         0DWFa82NQ/k1Iu2Kou9tIkphXoE9tNN3p9/hPDoEpJmyYfcD3n2ZEvQxBgN1bw9sS6gm
         R1dg==
X-Forwarded-Encrypted: i=1; AJvYcCUHg2I/6wqYQmTD6qhOhBUp9Qo5G/cGElSJCYPRA5OgXGCGuAp2sS4YG7941lgl5JRlhtLDBEg5CvBk@vger.kernel.org, AJvYcCVWjvE9D8bqQ9GbaSduc+LInAGgVd6AsaIdtFwD10BKUUvp4fRlVUS3Cr9LP6z4/lZmPZ8hzP+DyiVQeJN7@vger.kernel.org, AJvYcCXLMWtItB6XHr7jmD1cW7Ht1OpLkCv1qyREXs9+LgWKOC7WOixsuUv1rio2bmV1LOV5Vlt6bpudfs/Q@vger.kernel.org
X-Gm-Message-State: AOJu0YxqwpYmI+kF3kJWIhtuNIaMldfLva2ZE3XXNFrKMMtfkS0iWgiH
	oLGlZh8Z0EcOXdXI+bXqgZby241rW6xIFtXqqkacE4bEIEUlX3ZFuVN6O5kkC5M=
X-Gm-Gg: ASbGnctV8oiDMbx7JXvrzh3lV3YlntanK61C57BpSrVUpgWUrCmsi8jWpzlHaT5dsfg
	KBJ02BaUcz9rrE3T6vM5Gi3rm5wNohMrZ13UoXVj99QMLZyU2Z/lFkDSAX5Fe9Y7ItUE0IHUEce
	uFNki1q+Ya6ZTfQMwtjrJynnIDGVifLXPs+GWWbqgN02qQaNRZcbVfhHdaeBihVsdKm2zb4FGoG
	08wT3Drez/LlKUUV191HhRGH3H8ylLyjHJOGLekW6bXms1jyHgOZAqpxt7XNPIRCdCgJ4hTLppK
	P2aukbRWk0JkaT13pn4ZzEGfXcmyXG6nY9UKFaHt8+XyGJRN
X-Google-Smtp-Source: AGHT+IEKVDADPwVCTb3FSLnPU1iX72waTG61fRTmFYzuq8xw2pYaiQGKbTetx6WGTTxSa+GuKBm3Yw==
X-Received: by 2002:a05:6602:164f:b0:84a:7906:eeb7 with SMTP id ca18e2360f4ac-85579fd83d9mr462459639f.0.1739695283682;
        Sun, 16 Feb 2025 00:41:23 -0800 (PST)
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com. [209.85.166.174])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ee90f53833sm284188173.104.2025.02.16.00.41.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Feb 2025 00:41:22 -0800 (PST)
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3d193fc345aso7772545ab.2;
        Sun, 16 Feb 2025 00:41:22 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUhMb6r5N23EkdEbNVR2A6gKwvQJu+fGU8LUfA4ohcL6GcLzB606vhKFxq3IMOxth3k57scAfv+uRPf@vger.kernel.org, AJvYcCV7+eVEP0n448oY+fAuF3EPAHbpkqJLIyKZk+cYLsY2O3uL8xi6255n4Zm4g4FhS/HysYXJCoEY8QNj@vger.kernel.org, AJvYcCX6egpq7XA/9C4DWoL5jmJnzc7ab12RHKhUOpvP/SObZcSi05Zmk09tsfWeBYdnK/4jVByj7St5GASrmZKs@vger.kernel.org
X-Received: by 2002:a05:6e02:2610:b0:3d1:78f1:8a86 with SMTP id
 e9e14a558f8ab-3d2809471f1mr44082585ab.15.1739695282060; Sun, 16 Feb 2025
 00:41:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250214125359.5204-1-andre.przywara@arm.com> <20250214125359.5204-4-andre.przywara@arm.com>
In-Reply-To: <20250214125359.5204-4-andre.przywara@arm.com>
Reply-To: wens@csie.org
From: Chen-Yu Tsai <wens@csie.org>
Date: Sun, 16 Feb 2025 16:41:07 +0800
X-Gmail-Original-Message-ID: <CAGb2v64z4xVfDkwcgdc6Bp9k1GoN-DWH4vjSEwioMGrmE3Ywsg@mail.gmail.com>
X-Gm-Features: AWEUYZmw3abG4Std0u6pbgvDtbaKDpoG1yzPXqXz-ASh85n4DeWqACoMoRsm03w
Message-ID: <CAGb2v64z4xVfDkwcgdc6Bp9k1GoN-DWH4vjSEwioMGrmE3Ywsg@mail.gmail.com>
Subject: Re: [PATCH v2 03/15] clk: sunxi-ng: mp: provide wrapper for setting
 feature flags
To: Andre Przywara <andre.przywara@arm.com>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 14, 2025 at 8:56=E2=80=AFPM Andre Przywara <andre.przywara@arm.=
com> wrote:
>
> So far our sunxi clock instantiation macros set the required flags
> depending on the clock type, but the new "dual divider MP clock"
> requires us to pass that piece of information in by the user.
>
> Add a new wrapper macro that allows to specify a "features" field, to
> allow marking those dual-divider clocks accordingly.
>
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  drivers/clk/sunxi-ng/ccu_mp.h | 19 ++++++++++++++++---
>  1 file changed, 16 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/clk/sunxi-ng/ccu_mp.h b/drivers/clk/sunxi-ng/ccu_mp.=
h
> index e235fdfde2d36..687bd2ec798e2 100644
> --- a/drivers/clk/sunxi-ng/ccu_mp.h
> +++ b/drivers/clk/sunxi-ng/ccu_mp.h
> @@ -100,11 +100,12 @@ struct ccu_mp {
>                                    _muxshift, _muxwidth,                \
>                                    0, _flags)
>
> -#define SUNXI_CCU_MP_DATA_WITH_MUX_GATE(_struct, _name, _parents, _reg, =
       \
> +#define SUNXI_CCU_MP_DATA_WITH_MUX_GATE_FEAT(_struct, _name, _parents, _=
reg, \
>                                         _mshift, _mwidth,               \
>                                         _pshift, _pwidth,               \
>                                         _muxshift, _muxwidth,           \
> -                                       _gate, _flags)                  \
> +                                       _gate, _flags,                  \
> +                                       _features)                      \
>         struct ccu_mp _struct =3D {                                      =
 \
>                 .enable =3D _gate,                                       =
 \
>                 .m      =3D _SUNXI_CCU_DIV(_mshift, _mwidth),            =
 \
> @@ -112,13 +113,25 @@ struct ccu_mp {
>                 .mux    =3D _SUNXI_CCU_MUX(_muxshift, _muxwidth),        =
 \
>                 .common =3D {                                            =
 \
>                         .reg            =3D _reg,                        =
 \
> +                       .features       =3D _features,                   =
 \
>                         .hw.init        =3D CLK_HW_INIT_PARENTS_DATA(_nam=
e, \
>                                                                    _paren=
ts, \
> -                                                                  &ccu_m=
p_ops, \
> +                                                                  &ccu_m=
p_ops,\

Accidental change?

Otherwise,

Reviewed-by: Chen-Yu Tsai <wens@csie.org>

>                                                                    _flags=
), \
>                 }                                                       \
>         }
>
> +#define SUNXI_CCU_MP_DATA_WITH_MUX_GATE(_struct, _name, _parents, _reg, =
       \
> +                                       _mshift, _mwidth,               \
> +                                       _pshift, _pwidth,               \
> +                                       _muxshift, _muxwidth,           \
> +                                       _gate, _flags)                  \
> +       SUNXI_CCU_MP_DATA_WITH_MUX_GATE_FEAT(_struct, _name, _parents,  \
> +                                            _reg, _mshift, _mwidth,    \
> +                                            _pshift, _pwidth,          \
> +                                            _muxshift, _muxwidth,      \
> +                                            _gate, _flags, 0)
> +
>  #define SUNXI_CCU_MP_DATA_WITH_MUX(_struct, _name, _parents, _reg,     \
>                                    _mshift, _mwidth,                    \
>                                    _pshift, _pwidth,                    \
> --
> 2.46.3
>

