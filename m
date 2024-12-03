Return-Path: <linux-kernel+bounces-428626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B292A9E1181
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 03:53:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7742A28341F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 02:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE87514F104;
	Tue,  3 Dec 2024 02:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MDMb89+c"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B37713FD72;
	Tue,  3 Dec 2024 02:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733194413; cv=none; b=Co7yu0WEqANVJZ6CRy/2eeb2XPw5sGUjQ4XBVjdHFroiN3mamsqv+cIo2yh8g1jhpyFiCGpldfU/xL0Ca1vgGQhyWH8PDdVFC3ROQvJaNYSY7m3DEgAqEr5imQwuvWBwtNh46J+lEDTKGjXOiz69Q64VFeU7ncFz7iwqaLfVieg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733194413; c=relaxed/simple;
	bh=5NrfrujeFDf+fSH5kneC5axcRATmJ0Nz3tqBpohP0O4=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=H8GgYY5P+hkakvXKpgOpexKeP2MpQbVCVnQ6Kgxl2mOiYcocVJ+GPBWBzcnDhjuhg7/o7oL6tg+k9MA+phA+VKcRap/tpucm9oBZD7wZDvEXamf0MokzhxL5/bzz7leMY/M36tokA8zgu5bVT6tjBw2c+P2lHhWmKJT4RhzN+jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MDMb89+c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66EE1C4CED1;
	Tue,  3 Dec 2024 02:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733194412;
	bh=5NrfrujeFDf+fSH5kneC5axcRATmJ0Nz3tqBpohP0O4=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=MDMb89+cXWpckQeitaTf+4Fsdz2GcREa0ZeO+jAxqBDf4AoOIZerr12+iiwTXJfJm
	 EwC95pmrY2tOpTHpeMcaus/DE/qIC1pcf4TkH6uEavp1i6l3zu3Q7DjAGRJWoo4aee
	 KfS5xOuGxQ46w0C7bKs8UyWctftKF1sR1ItCFb14YznnkNWp7EYFWDEFgwkfaPwZ07
	 Z7gkyitCytSLX4UOySYqy7S9PhV7e85pRkvmvpdc6ITUdCzBdhvoq4ne8X9QxWQ6H5
	 hx63iPyVu9bjUV+GYRhMcBcpwJbOoeQC49b65w3JbzM6Eff8jcZWxllOTh/VcYGQ9r
	 9UTP8UDzDsJwg==
Message-ID: <df0a53ee859e450d84e81547099f5f36.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <ce67e512-a15b-4482-8194-b917096f4eeb@app.fastmail.com>
References: <20241127-clk-audio-fix-rst-missing-v1-1-9f9d0ab98fce@baylibre.com> <12f29978-c8ce-4bee-a447-dcd086eb936d@app.fastmail.com> <1ja5dk2y5l.fsf@starbuckisacylon.baylibre.com> <f8de4a2a-776f-4c10-b75e-e845bcc38dde@app.fastmail.com> <1j4j3r32ld.fsf@starbuckisacylon.baylibre.com> <306b0b30-5a32-4c7c-86b4-57d50e2307e8@app.fastmail.com> <1jy1131kxz.fsf@starbuckisacylon.baylibre.com> <c06317c6-b2b2-4b6d-96e4-0c2cfc6846de@app.fastmail.com> <1jplmf1jqa.fsf@starbuckisacylon.baylibre.com> <ce67e512-a15b-4482-8194-b917096f4eeb@app.fastmail.com>
Subject: Re: [PATCH] clk: amlogic: axg-audio: select RESET_MESON_AUX
From: Stephen Boyd <sboyd@kernel.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Kevin Hilman <khilman@baylibre.com>, Martin Blumenstingl <martin.blumenstingl@googlemail.com>, linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>, Jerome Brunet <jbrunet@baylibre.com>
Date: Mon, 02 Dec 2024 18:53:30 -0800
User-Agent: alot/0.12.dev1+gaa8c22fdeedb

Happy Thanksgiving!

Quoting Arnd Bergmann (2024-11-28 07:34:46)
> On Thu, Nov 28, 2024, at 16:06, Jerome Brunet wrote:
> > On Thu 28 Nov 2024 at 15:51, "Arnd Bergmann" <arnd@arndb.de> wrote:
> >> On Thu, Nov 28, 2024, at 15:39, Jerome Brunet wrote:
> >>> On Thu 28 Nov 2024 at 15:11, "Arnd Bergmann" <arnd@arndb.de> wrote:
> >>> Eventually that will happen for the rest of the reset implemented
> >>> under drivers/clk/meson.
> >>>
> >>> It allows to make some code common between the platform reset
> >>> drivers and the aux ones. It also ease maintainance for both
> >>> Stephen and Philipp.
> >>
> >> I don't understand how this helps: the entire point of using
> >> an auxiliary device is to separate the lifetime rules of
> >> the different bits, but by doing the creation of the device
> >> in the same file as the implementation, you are not taking
> >> advantage of that at all, but instead get the complexity of
> >> a link-time dependency in addition to a lot of extra code
> >> for dealing with the additional device.
> >
> > My initial rework had the creation in clock (note: that is why I
> > initially used 'imply', and forgot to update when the creation moved to
> > reset).
> >
> > I was asked to move the creation in reset:
> > https://lore.kernel.org/r/217a785212d7c1a5b504c6040b3636e6.sboyd@kernel=
.org
> >
> > We are deviating a bit from the initial regression reported by Mark.
> > Is Ok with you to proceed with that fix and then continue this discussi=
on
> > ?
>=20
> I really don't want to see those stray 'select' statements
> in there, as that leave very little incentive for anyone to
> fix it properly.
>=20
> It sounds like Stephen gave you bad advice for how it should
> be structured, so my best suggestion would be to move the
> the problem (and the reset driver) back into his subsystem
> and leave only a simple 'select RESET_CONTROLLER'.
>=20
> From the message you cited, I think Stephen had the right
> intentions ("so that the clk and reset drivers are decoupled"),
> but the end result did not actually do what he intended
> even if you did what he asked for.
>=20
> Stephen, can you please take a look here and see if you
> have a better idea for either decoupling the two drivers
> enough to avoid the link time dependency, or to reintegrate
> the reset controller code into the clk driver and avoid
> the complexity?

I think the best approach is to add the reset auxilary device with a
function that creates the auxiliary device directly by string name and
does nothing else. Maybe we can have some helper in the auxiliary
layer that does that all for us, because it's quite a bit of boiler
plate that we need to write over and over again. Something like:

  int devm_auxiliary_device_create(struct device *parent, const char *name)

that does the whole kzalloc() + ida dance that
devm_meson_rst_aux_register() is doing today and wraps it all up so that
the device is removed when the parent driver unbinds. Then this clk
driver can register the reset device with a single call and not need to
do anything besides select AUXILIARY_BUS. The regmap can be acquired
from the parent device in the auxiliary driver probe with
dev_get_regmap(adev->parent).

