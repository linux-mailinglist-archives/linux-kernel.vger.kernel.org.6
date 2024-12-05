Return-Path: <linux-kernel+bounces-432563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BBAAD9E4CFD
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 05:16:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FF972855D1
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 04:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98F1017F4F6;
	Thu,  5 Dec 2024 04:16:21 +0000 (UTC)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E6C5179A3;
	Thu,  5 Dec 2024 04:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733372181; cv=none; b=tou5JXTQCyC+P4ifO1wdTMkJGXF/E15QlailwDm/P2PpS6O3bzqP+gthwUg+D861TOi8/0opGBS+MN5sQ1/MjC1r8F+TnTtxKpwSW67j6s8fV6XQTB4w7G+OWEgo7mVQyXpynoP5JEE8QJEp+EFw8xBzJB+jAB8dQblDDO3t9vQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733372181; c=relaxed/simple;
	bh=KSxHh4MX6DMW5Fj4irqntnsdy4M8bKuHYO0r/f9HTP8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sceYx+4ufV6+S9S7uxM27n5TEn4S0OtCMwu4+4GwCOHNUe9LF/44joaJhgmofaYyy9LYFBY9pH2YoDa+gH1G1NZCdD8xL5wMgD4nXf5E6Nin+/GbW4k4NS5qzspOZc/h29eeSuPyhOhhWowyqQI6u1R6UYOeMNsjsK6QzBuWCxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2ffc86948dcso4036441fa.2;
        Wed, 04 Dec 2024 20:16:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733372175; x=1733976975;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=piW9kHZgsyQb9cy9HU5rDPdSyIGIWO93TJJ1y0kDyvc=;
        b=CDJ8LkFnN5DsZhgoQScBHlfR45g+BNn55FzSAOXp3OMG3zKrFdVGtWQk/LkGczxNwh
         onkhqU1kGb8NkYC6o37RvoiXf2kF2B3CuNCh70hLSIqHxw0eaiNN+Ga3yJPeuMwxNK6S
         H/aviTIdAktBEcKKe7fpIFlAw7DU/9g85UpZLX/intkWv/eGKiHB0h4WMMv2qoKZpFAR
         SaEBcolPBrq9Kdi9mkhdZfiDgTaIV1kbkP83q4yD5Q1rcZe0pDlLGl8jd+TaVbWKYNac
         Y6Yt4kSXh/LxP7Y39JwGaWIxxmDAYJItXoQlpwZSd3HVYJW0bK94c306VwmSsWK5HgN+
         4o6g==
X-Forwarded-Encrypted: i=1; AJvYcCWZZpMi9sqFPK+L5IQSARB5D3MKyghU0HYHoNdKfFmQKnQRmfw6NNJqd0BJTzSbBt+E1OUuVOsE7vmUA1kX@vger.kernel.org, AJvYcCWzRTFcxqEF8iZAFQHcNdCpEAe94Z5ROXjBwRwxzxztjQ2LkkVljCVCO7LTdhf+gGt+oDhjZWHaQRVy@vger.kernel.org
X-Gm-Message-State: AOJu0YzEdl2hKyRwa/a8MsX35UCw6CKfBJBsjRI7QXnRHZ/qzWCKVrl4
	YVpX878BcM7KQpjVPbZZ1Qvvsf/+tSgrbSfBdBaDw8LU1340AgR3EFzU2Ke+
X-Gm-Gg: ASbGncucJWQhO849ayfJSNc65WpVXgPsjTqBda4QYYphSKMvtbTIafvbG/ZPGTK01G8
	xjQo6idmqtAmAhA5ENkIVrdMe6LVav4sJlns7oYoCpv1zFmGeZ5ISSKKl13VPDoUfQkF2xaS0N3
	chPFg09vjyieywLlv7Qw/OQ08pF8/zgM98qf5Hq8f/jsMo201GSHtBYofo16nM2LiDw51tkZ2HI
	iCd9p8YuuIo5jPgshN2ylBKA2boG6nrbBBWpS4gsd1AXuqps+nUbSzGACzjWFXC1DfDoN57GAjq
	YUiPmag=
X-Google-Smtp-Source: AGHT+IGG0dbk1TcuyB8uyB7a2be7Mt9mKtY5/tCmhTGcBCEMT47mdVzYUeNFsdLBVsQTyE3wx2nErg==
X-Received: by 2002:a05:651c:1614:b0:2fb:5a7e:5072 with SMTP id 38308e7fff4ca-30009cb184fmr59300201fa.34.1733372174591;
        Wed, 04 Dec 2024 20:16:14 -0800 (PST)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30020e58200sm910531fa.113.2024.12.04.20.16.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2024 20:16:14 -0800 (PST)
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-3000b64fbe9so3752191fa.1;
        Wed, 04 Dec 2024 20:16:14 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWeeEDOHnDB00ylPwlhuYJWzB+X0e1FHwcyDqDCIYbPjGIXnWBmkIqzSUoG1anlX2GIPeVjyoda/X5M@vger.kernel.org, AJvYcCXnbbsEnU7U0snFMQycgrRfYvkPx+IKoNKkmvTpaRT3KpJ/4fjeMjuJ6UBFPp448bpKJ/2WMjqPc4bLfoZY@vger.kernel.org
X-Received: by 2002:a05:651c:1501:b0:300:1889:6340 with SMTP id
 38308e7fff4ca-30018896590mr21262461fa.13.1733372174094; Wed, 04 Dec 2024
 20:16:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241203203824.23306-1-simons.philippe@gmail.com>
In-Reply-To: <20241203203824.23306-1-simons.philippe@gmail.com>
Reply-To: wens@csie.org
From: Chen-Yu Tsai <wens@csie.org>
Date: Thu, 5 Dec 2024 12:16:00 +0800
X-Gmail-Original-Message-ID: <CAGb2v67Uv3SVQSqox85qt_05aVvX0oCynNRoaN9BA1Nha3eo8w@mail.gmail.com>
Message-ID: <CAGb2v67Uv3SVQSqox85qt_05aVvX0oCynNRoaN9BA1Nha3eo8w@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: allwinner: h616: rg35xx add missing regulator-ramp-delay
To: Philippe Simons <simons.philippe@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Samuel Holland <samuel@sholland.org>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, 
	"moderated list:ARM/Allwinner sunXi SoC support" <linux-arm-kernel@lists.infradead.org>, 
	"open list:ARM/Allwinner sunXi SoC support" <linux-sunxi@lists.linux.dev>, open list <linux-kernel@vger.kernel.org>, 
	Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 4, 2024 at 4:38=E2=80=AFAM Philippe Simons
<simons.philippe@gmail.com> wrote:
>
> AXP datasheet says that ramp delay is 15.625 us/step,
> which is 10mV in our case.

(CC-ing Mark for knowledge on regulators)

If this is the property of the PMIC, it probably belongs in the driver,
in "regulator_desc.ramp_delay".

The "regulator-ramp-delay" in the DT can be used to override this
if the board has excessive ramp delay due to other design reasons.


ChenYu

> add missing regulator-ramp-delay to dcdc regulators accordingly
>
> Signed-off-by: Philippe Simons <simons.philippe@gmail.com>
> ---
>  .../boot/dts/allwinner/sun50i-h700-anbernic-rg35xx-2024.dts    | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h700-anbernic-rg35xx-20=
24.dts b/arch/arm64/boot/dts/allwinner/sun50i-h700-anbernic-rg35xx-2024.dts
> index 80ccab7b5..b6e76a804 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-h700-anbernic-rg35xx-2024.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h700-anbernic-rg35xx-2024.dts
> @@ -238,6 +238,7 @@ reg_dcdc1: dcdc1 {
>                                 regulator-always-on;
>                                 regulator-min-microvolt =3D <900000>;
>                                 regulator-max-microvolt =3D <1160000>;
> +                               regulator-ramp-delay =3D <640>;
>                                 regulator-name =3D "vdd-cpu";
>                         };
>
> @@ -245,6 +246,7 @@ reg_dcdc2: dcdc2 {
>                                 regulator-always-on;
>                                 regulator-min-microvolt =3D <940000>;
>                                 regulator-max-microvolt =3D <940000>;
> +                               regulator-ramp-delay =3D <640>;
>                                 regulator-name =3D "vdd-gpu-sys";
>                         };
>
> @@ -252,6 +254,7 @@ reg_dcdc3: dcdc3 {
>                                 regulator-always-on;
>                                 regulator-min-microvolt =3D <1100000>;
>                                 regulator-max-microvolt =3D <1100000>;
> +                               regulator-ramp-delay =3D <640>;
>                                 regulator-name =3D "vdd-dram";
>                         };
>
> --
> 2.47.1
>

