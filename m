Return-Path: <linux-kernel+bounces-340540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B82D09874ED
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 15:58:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24B7EB2519F
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 13:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E6977A13A;
	Thu, 26 Sep 2024 13:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oj7n3S/e"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB6E71750;
	Thu, 26 Sep 2024 13:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727359095; cv=none; b=GpeAxIHps+jqvOsEPReHww/qD4Acy5we9lmgGw3SVsqK4LqqNqsTR5g/hhm+LS98WuOpM4PPk9sJDo2Oay3aGTcTTXwDX+yu11f6wpOOxcaMKwBpuhgtffjdESmkgf3sf/AlWL8Nci6Dsg/NWVzU4D9Aox28TUU/ErAxW7oXMvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727359095; c=relaxed/simple;
	bh=kBvN9cGMEurWhh8TzHMy8VeOxvub6a3MAU2ernR+bag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I9GJ0FvZ1rR0FYt/mUm9E9SvVh9Q03fQT9uXxI8QPPp9Et2gl4hePi3IPakRwM0Wqa7YTAhiasqHYzzLre2F3ksxin0ut2F7BiuSeOM0YfPZPVQ/qUXquXs7ioOdeUFHh4aollhTUHWmxrXpM0SJG49165bzcHi/yVipGWavWIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oj7n3S/e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C997C4CEC6;
	Thu, 26 Sep 2024 13:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727359094;
	bh=kBvN9cGMEurWhh8TzHMy8VeOxvub6a3MAU2ernR+bag=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oj7n3S/eeJ8dhqTRESEi/32JgUN0NAsCjeP8GOfO1w+Gx5SkYLYxKicrTaIh6elRe
	 CzGq2/iTV5dDbS0YKamvbIWUx4YVs43pbAMe/D5NYNjIIkSskjTom8SidUCpdgNRWi
	 LImHnSlF6y3zQGGeb+oqje544CNB0GsKP/mjLvfMIXVRFGKDyfFz7bCoQle/I2jm8s
	 CRaFbkW7PGQf0yS1IliKov3x99KP8we2ssHTRXTG5J43H9Rx/hkzt9lWjQw5iMuOra
	 qLTibnHFikdZvH6uBokn3bfc80l2kyu1HOJ3yWDQxdaEn/b6Yw3qhqNagGIfuWFgv5
	 gN6i6Kj1wU9DQ==
Date: Thu, 26 Sep 2024 15:58:11 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Manikandan.M@microchip.com, neil.armstrong@linaro.org, 
	quic_jesszhan@quicinc.com, airlied@gmail.com, simona@ffwll.ch, 
	maarten.lankhorst@linux.intel.com, tzimmermann@suse.de, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, thierry.reding@gmail.com, sam@ravnborg.org, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Dharma.B@microchip.com
Subject: Re: [PATCH v2 2/2] drm/panel: simple: Add Microchip AC69T88A LVDS
 Display panel
Message-ID: <20240926-foamy-oarfish-of-passion-ec6fa2@houat>
References: <20240919091548.430285-1-manikandan.m@microchip.com>
 <20240919091548.430285-2-manikandan.m@microchip.com>
 <zognzunciriytm3uvoolxjsvu43v3m2lnctsz5swusnmm3aj2z@ag7zkncccdmf>
 <83e9d20d-f294-4303-b570-816ebc989bcf@microchip.com>
 <f4z2egmrcoh7kih2pyr3mq7fzuwtvod6vxlzzim2iw3ly7jcr3@2uxiyzlfixhp>
 <17b5a11c-b9a8-4172-831e-d52f1a4270e9@microchip.com>
 <quxjqmx5yc27cxmjvnq6irltr36josag4yltxbiweh4femqbqo@j34pxmfxglc5>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="nwxok5rybyzngc7q"
Content-Disposition: inline
In-Reply-To: <quxjqmx5yc27cxmjvnq6irltr36josag4yltxbiweh4femqbqo@j34pxmfxglc5>


--nwxok5rybyzngc7q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 26, 2024 at 04:32:59PM GMT, Dmitry Baryshkov wrote:
> On Thu, Sep 26, 2024 at 08:17:09AM GMT, Manikandan.M@microchip.com wrote:
> > On 23/09/24 11:37 am, Dmitry Baryshkov wrote:
> > > EXTERNAL EMAIL: Do not click links or open attachments unless you kno=
w the content is safe
> > >=20
> > > On Mon, Sep 23, 2024 at 05:50:22AM GMT, Manikandan.M@microchip.com wr=
ote:
> > >> On 20/09/24 9:13 pm, Dmitry Baryshkov wrote:
> > >>> EXTERNAL EMAIL: Do not click links or open attachments unless you k=
now the content is safe
> > >>>
> > >>> On Thu, Sep 19, 2024 at 02:45:48PM GMT, Manikandan Muralidharan wro=
te:
> > >>>> Add support for Microchip AC69T88A 5 inch TFT LCD 800x480
> > >>>> Display module with LVDS interface.The panel uses the Sitronix
> > >>>> ST7262 800x480 Display driver
> > >>>
> > >>> AC69T88A seems to be a module name, rather than a panel name. What =
is
> > >>> the actual panel name present on this module?
> > >> Both names, "Microchip AC69T88A" and "MPU32-LVDS-DISPLAY-WVGA" are
> > >> present on the display module
> > >=20
> > > Which panel was used for the module? I don't think that Microchip
> > > produces LVDS panels.
> > Its a new LVDS display from Microchip that uses Sitronix ST7262 TFT LCD=
=20
> > driver
> >=20
> > https://www.crystalfontz.com/controllers/datasheet-viewer.php?id=3D486
>=20
> Ok. Anyway if somebody ends up looking for the panel, they'll probably
> find the module and vice versa.
>=20
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Given that aside from that mail, the module name isn't mentionned
anywhere, I'm not sure they would.

The way we usually deal with controllers is to have a separate driver
for panels based on that controller, even more so since that controller
seems to be able to affect the display.

Maxime

--nwxok5rybyzngc7q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZvVocwAKCRAnX84Zoj2+
dkWSAX9uTIkjmWmHidYR8RI+SHflvLYoq1mHYHmx0FKy/H5CLsNsXxl1N04pR/rl
GbDENO4BgMvc1UyrpreNjD7xtbJ664F0LkjLMBwZHFQUloyUm+10s2oyYzHgkAgp
DNKQgfI3/A==
=4/es
-----END PGP SIGNATURE-----

--nwxok5rybyzngc7q--

