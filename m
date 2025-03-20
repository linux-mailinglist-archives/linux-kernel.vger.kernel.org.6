Return-Path: <linux-kernel+bounces-569544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A2E7A6A467
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 12:04:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C7DB7A8404
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 11:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CF06216392;
	Thu, 20 Mar 2025 11:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=postmarketos.org header.i=@postmarketos.org header.b="Y/wumE1i"
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C337D1581F0
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 11:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742468651; cv=none; b=LIUgCiv6EBxvOuEbmItqnsEka+pEKT4b0vZrob6xpJEO16tpJItzEts0FK/IuKjBt0tg6ftM9C7oaDVld1Y+xXwbKc42F8Jf1FW1Pi0Lu9K+gK/yZtpbRAe7T9ewJBH0RGQUNKVxw+JTJSoMyx+9UdRfhzxgvealZ7X3yM4Jit0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742468651; c=relaxed/simple;
	bh=ucJYb/gc6ZLSiwQSHzfHTQR1htqpfXlcCBjssluhfnY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:Cc:To:
	 References:In-Reply-To; b=LJTOaa6Ou6RietDsKCCzvOFt6dzz36Eq+Gx+bzX2PtuebBMh7GZzmGvw5BYaguRtBv5Letl96IzneP7mQYqkLlCK4LxKqW1t2DQ2ADbFSi9fMbi6huQTCdtgNrO+4CEsSgWosrl1z6gNULLRy2yLEKul0rjEYGbi8lxFcx6AUsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=postmarketos.org; spf=pass smtp.mailfrom=postmarketos.org; dkim=pass (2048-bit key) header.d=postmarketos.org header.i=@postmarketos.org header.b=Y/wumE1i; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=postmarketos.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=postmarketos.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
	s=key1; t=1742468646;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GvO6U5e3ou7cohuaaLtiVKLu/0FNfSOPql7f4CQNZ20=;
	b=Y/wumE1iWwGTzwcOYHCaxujevsLP2sVF0WD0JCoz2y6HfR5rRs0AGGm47M+kkVy047HPVX
	WugwszOrVFVU9ySFiHnHRQz1EZsIz5gNxS63sDEH6qyenzgbEQj6WuCqqacEKHM26sRpSo
	RmcAb8zo+DJtS3dtY0/S0h4g6jayJlpU7mt/fU1/vpj8EWA+M1UvFXy4oW91TwJtWH/bdi
	s080GE/cSXSw2J9UENTHlmLfLtDKOYBLVF4acbnbuL/PGcHrSabeMDBK4V+rDhBIGIBqGW
	VWcRzLT/7q7secuqVx0Whe2UUvZVQSmGK5rGspeTCAKiE7lX3EiWgChPDnhINA==
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 20 Mar 2025 11:03:38 +0000
Message-Id: <D8L1KOJC0NJD.3QJBLQ0Z1FI62@postmarketos.org>
Subject: Re: [PATCH v5 2/2] arm64: dts: amlogic: add support for
 xiaomi-aquaman/Mi TV Stick
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Ferass El Hafidi" <funderscore@postmarketos.org>
Cc: "Neil Armstrong" <neil.armstrong@linaro.org>, "Kevin Hilman"
 <khilman@baylibre.com>, "Jerome Brunet" <jbrunet@baylibre.com>, "Rob
 Herring" <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
 "Conor Dooley" <conor+dt@kernel.org>, <linux-amlogic@lists.infradead.org>,
 <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <~postmarketos/upstreaming@lists.sr.ht>,
 "Artur Weber" <aweber.kernel@gmail.com>, "Karl Chan"
 <exxxxkc@getgoogleoff.me>, "Christian Hewitt" <christianshewitt@gmail.com>
To: "Martin Blumenstingl" <martin.blumenstingl@googlemail.com>
References: <20250319190150.31529-2-funderscore@postmarketos.org>
 <20250319190150.31529-4-funderscore@postmarketos.org>
 <CAFBinCArRO-F59tOv9m27f+DV+qhy69OGUunGOAbDdfOdd5_Xg@mail.gmail.com>
In-Reply-To: <CAFBinCArRO-F59tOv9m27f+DV+qhy69OGUunGOAbDdfOdd5_Xg@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Wed Mar 19, 2025 at 10:36 PM UTC, Martin Blumenstingl wrote:
> Hello,
>
> thanks for your contribution and sorry for the late reply!
>
> On Wed, Mar 19, 2025 at 8:02=E2=80=AFPM Ferass El Hafidi
> <funderscore@postmarketos.org> wrote:
> [...]
> > +       au2: analog-amplifier {
> > +               compatible =3D "simple-audio-amplifier";
> > +               sound-name-prefix =3D "AU2";
> > +               VCC-supply =3D <&vcc_5v>;
> > +               enable-gpios =3D <&gpio GPIOH_5 GPIO_ACTIVE_HIGH>;
> > +       };
> I couldn't find any pictures online that show an analog audio output
> (typically a 3.5mm socket).
> Can you confirm that this is really present?
>
> [...]
> > +       sound {
> > +               compatible =3D "amlogic,gx-sound-card";
> > +               model =3D "XIAOMI-AQUAMAN";
> > +               audio-aux-devs =3D <&au2>;
> > +               audio-widgets =3D "Line", "Lineout";
> > +               audio-routing =3D "AU2 INL", "ACODEC LOLN",
> > +                               "AU2 INR", "ACODEC LORN",
> > +                               "Lineout", "AU2 OUTL",
> > +                               "Lineout", "AU2 OUTR";
> If there's no analog audio in/out then this section can be cleaned up
> as well - together with the references to acodec in the dai-links
> below.

Oops, completely overlooked those.  Will fix in v6.  There indeed is no=20
analog audio output.

>
> [...]
> > +/* Wireless SDIO Module (Amlogic W155S1 / Realtek RTL8821CS) */
> > +&sd_emmc_b {
> question to Neil: since we know that there's two board variants out
> there (with different wifi chipsets) - are dt overlays down the road
> enough (to enable Bluetooth / wifi - depending on the chipset or board
> revision) or do we need to split the whole .dts?
>

So far W155S1 and RTL8821CS are the *known* chipsets used, but there may=20
be others.  Right now it's not my main concern, as W155S1 is not
supported in Mainline, as far as I know, and I can't test RTL8821CS
because my variant seems to have the former.

>
> Best regards,
> Martin

Regards.

