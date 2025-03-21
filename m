Return-Path: <linux-kernel+bounces-570870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CF5EA6B59E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 09:00:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4C4B4828BC
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 08:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F87E1EE7D8;
	Fri, 21 Mar 2025 08:00:30 +0000 (UTC)
Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 229191E5B67;
	Fri, 21 Mar 2025 08:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.201.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742544029; cv=none; b=iwLUrerReDgsxfCFrtxgUC3mOj25x50MLUD7cxtcDRPpud2WMlyM+VikHj02VdqZhq37RVCJJlj/93d0yhI9nvqyHuKk4MgZeDwqETJMN3mulqwi3rIMmi6q8WJg0TUxgIGm6IaSXNnPLEaVwFtsLonkntoLnRgiHSFVhipyMHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742544029; c=relaxed/simple;
	bh=hy3JSQIvjz/Z9j/8BaLWo/1xB0IRgIAwR+XkT0LjHKk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=f5HcBbnOFmHgnX9swUSc/FJAerdW3rGGqhrMGmXcu/wYqiIFKh4ZjU2MMY1YFxHlA6WmDHSKKUxxh14XDyCniN5xtziWtEAD4xV7TgM3Xh0UInvCSHKaoD86JWffHJB5rrgESL9a9i/8ifBZxr/RefWDehPHiXWO+MAJgthAUm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=walle.cc; arc=none smtp.client-ip=159.69.201.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=walle.cc
Received: from localhost (unknown [IPv6:2a02:810b:4320:1000:4685:ff:fe12:5967])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.3ffe.de (Postfix) with ESMTPSA id C13764CF;
	Fri, 21 Mar 2025 09:00:18 +0100 (CET)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 21 Mar 2025 09:00:18 +0100
Message-Id: <D8LSAUU0358V.2H1D7QXB9WBOF@kernel.org>
Subject: Re: [PATCH 2/3] mtd: spi-nor: use rdid-dummy-ncycles DT property
Cc: "Takahiro Kuwano" <tkuw584924@gmail.com>, "Pratyush Yadav"
 <pratyush@kernel.org>, "Miquel Raynal" <miquel.raynal@bootlin.com>,
 "Richard Weinberger" <richard@nod.at>, "Vignesh Raghavendra"
 <vigneshr@ti.com>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>, <linux-mtd@lists.infradead.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Bacem
 Daassi" <Bacem.Daassi@infineon.com>, "Takahiro Kuwano"
 <Takahiro.Kuwano@infineon.com>, "Mark Brown" <broonie@kernel.org>
From: "Michael Walle" <mwalle@kernel.org>
To: "Tudor Ambarus" <tudor.ambarus@linaro.org>, "Rob Herring"
 <robh@kernel.org>
X-Mailer: aerc 0.16.0
References: <20250319-snor-rdid-dummy-ncycles-v1-0-fbf64e4c226a@infineon.com> <20250319-snor-rdid-dummy-ncycles-v1-2-fbf64e4c226a@infineon.com> <20250319233024.GA2625856-robh@kernel.org> <a3818477-5a67-43ad-8961-88fa02916968@linaro.org> <CAL_JsqKtz5+R1kjEzjo6bVicOX2c=UauC0_STAF0T02rSDqO+w@mail.gmail.com> <50de19f7-2021-433e-b8f8-d928ed7d5d57@linaro.org>
In-Reply-To: <50de19f7-2021-433e-b8f8-d928ed7d5d57@linaro.org>

Hi,

> >>>> There are infineon flashes [1] that require 8 dummy cycles for the
> >>>> 1-1-1 Read ID command. Since the command is not covered by JESD216
> >>>> or any other standard, get the number of dummy cycles from DT and us=
e
> >>>> them to correctly identify the flash.
> >>>
> >>> If Read ID fails, then couldn't you just retry with dummy cycles? Or
> >>
> >> I think Read ID won't fail when the op requires 8 dummy cycles, it
> >> probably just reads garbage on the first 8 cycles, so we risk to wrong=
ly
> >> match other flash IDs.
> >>
> >>> would unconditionally adding dummy cycles adversely affect other chip=
s?
> >>
> >> Adding 8 dummy cycles to chips that don't need it, would mean ignoring
> >> the first byte of the flash ID, thus we again risk to wrongly match
> >> against other flash IDs.
> >>
> >>>
> >>> Otherwise, add a specific compatible to imply this requirement. Addin=
g
> >>> quirk properties doesn't scale.
> >>
> >> Do you mean a flash name compatible, like "cyrs17b512,spi-nor"?
> >=20
> > Yes, but that's not the format of compatible strings.
> >=20
> >> The
> >> problem that I see with that is that we no longer bind against the
> >> generic jedec,spi-nor compatible, so people need to update their DT in
> >> case they use/plug-in a different flash on their board.
> >=20
> > This chip is clearly *not* compatible with a generic chip.
>
> I think it is compatible. The chip defines the SFDP (serial flash
> discoverable parameters) tables. At probe time we parse those tables and
> initialize the flash based on them.

I disagree. It's not compatible with "jedec,spi-nor", which is
defined as

      SPI NOR flashes compatible with the JEDEC SFDP standard or which may =
be
      identified with the READ ID opcode (0x9F) do not deserve a specific
      compatible. They should instead only be matched against the generic
      "jedec,spi-nor" compatible.

The first part was recently added and is a bit misleading. The old
definition was:

      Must also include "jedec,spi-nor" for any SPI NOR flash that can be
      identified by the JEDEC READ ID opcode (0x9F).

See my first reply, on how to possibly fix this mess (new
compatible if accepted, just use RDSFDP sequence which is backed by
the standard and do some fingerprinting).

FWIW, a new (or rather different) compatible is needed because we
cannot distinguish between random data returned during the dummy
cycles and a proper manufacturer id. So there is no way we could fix
this in the core itself.

At least if we keep the logic as it is for now, if we use RDSFDP to
fingerprint first and then fall back to RDID, we could get away with
the old compatible.

> We don't even care about the chip ID, if all the flash parameters can be
> discovered via SFDP. Unfortunately these tables do not describe all the
> flash capabilities (block protection being one). Or worse, manufacturers
> mangle these tables.
>
> So vendors need to identify chips to either fix those tables via some
> quirks after the parsing is done, or to specify support that's not
> covered by those tables.
>
> For basic ops, flashes that get the SFDP tables right, don't even need a
> flash entry defined, we don't care about their ID, we just initialize
> the flash solely based on SFDP.
>
> In this particular case, this flash needs identification to fix some
> wrong SFDP field, it corrects just the mode cycles for the FAST READ
> command. All the other commands seem fine according to patch 3/3.
>
> >=20
> > You have the same problem with a property. Users have to add or remove
>
> True. It's the same problem. Even if we specify the dummy cycles via a
> property, the next plugged-in flash will use those. We can of course
> fallback to the SFDP only init if the ID doesn't match any flash entry,
> but the problem is the same.
>
> > the property if the flash changes. Anyone thinking they can use this
> > chip as a compatible 2nd source is SOL.
> >=20
>
> I think the property vs compatible decision resumes at whether we
> consider that the dummy cycles requirement for Read ID is/will be
> generic or not.

It is not generic. Because it will break autodetection. And that is
the whole purpose of this. Adding that property means, we can just
autodetect flashes within this 'group'. And personally, I think this
is a bad precedent.

> I noticed that with higher frequencies or protocol modes (e.g, octal
> DTR), flashes tend to require more dummy cycles. I think with time,
> we'll have more flashes with such requirement. Takahiro can jump in and
> tell if it's already the case with IFX.

But hopefully not with RDID. Again this doesn't play nice with other
flashes (or all flashes for now). Instead of adding random delay
cycles one should rather define a max clock speed for this opcode.

-michael

> Thus instead of having lots of new compatibles for this, I lean towards
> having this property. I'm still open for the compatible idea, I just
> wanted to explain better where we are.
>
> Thanks,
> ta


