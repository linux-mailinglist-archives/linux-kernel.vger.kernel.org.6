Return-Path: <linux-kernel+bounces-555865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43FE7A5BD92
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 11:19:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A6D71887384
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 10:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B9EC234966;
	Tue, 11 Mar 2025 10:17:38 +0000 (UTC)
Received: from mx1.emlix.com (mx1.emlix.com [178.63.209.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBCDA233141
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 10:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.209.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741688258; cv=none; b=GLMVrEEcO2Ctzxe7aY6MKQm14paRm21GIGJIXZ+IHNWNCEoneFymYS4LLaWnArQKm1zX/NVxiw47LW2Z+BeG7J91uQDO101DLMlDW35MoJYDWLeAFhgKA3sIZSGsd8AFSopCKtWmlxzOVPEilOTnQwTlmLxNR4uar7dTQVABuwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741688258; c=relaxed/simple;
	bh=vwnC4cysFF88dB2KQIGKsdb28HdDbXdSKUnr6pZotdE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YhqnASvEO5AVYMsQIene6pFh6IAu+WcjOpXB73NFEzJq51uULwgc1GWB9v9N8o/qWXC1Vq7oSQtP4CU6Szqhb2yotayLc/Ff6sHCT43aqSxG6z5tg28BSg6JMH6JtojABT5Hloc+6b330LNNAEjZDL+1NS3H8IBi9pxpUCw3WEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=emlix.com; spf=pass smtp.mailfrom=emlix.com; arc=none smtp.client-ip=178.63.209.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=emlix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=emlix.com
Received: from mailer.emlix.com (p5098be52.dip0.t-ipconnect.de [80.152.190.82])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.emlix.com (Postfix) with ESMTPS id DF2925F845;
	Tue, 11 Mar 2025 11:17:32 +0100 (CET)
From: Rolf Eike Beer <eb@emlix.com>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>,
 Yuntao Liu <liuyuntao12@huawei.com>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm32: simplify ARM_MMU_KEEP usage
Date: Tue, 11 Mar 2025 11:17:32 +0100
Message-ID: <2225298.Mh6RI2rZIc@devpool47.emlix.com>
Organization: emlix GmbH
In-Reply-To:
 <CACRpkdaAMu9WtD3a_XXGEwMfyFx6F-a263COna13eUWB0vqbcQ@mail.gmail.com>
References:
 <2200295.irdbgypaU6@devpool47.emlix.com>
 <1811814.VLH7GnMWUR@devpool47.emlix.com>
 <CACRpkdaAMu9WtD3a_XXGEwMfyFx6F-a263COna13eUWB0vqbcQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3678204.R56niFO833";
 micalg="pgp-sha256"; protocol="application/pgp-signature"

--nextPart3678204.R56niFO833
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Rolf Eike Beer <eb@emlix.com>
To: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] arm32: simplify ARM_MMU_KEEP usage
Date: Tue, 11 Mar 2025 11:17:32 +0100
Message-ID: <2225298.Mh6RI2rZIc@devpool47.emlix.com>
Organization: emlix GmbH
MIME-Version: 1.0

On Dienstag, 24. Dezember 2024 20:25:19 Mitteleurop=C3=A4ische Normalzeit L=
inus=20
Walleij wrote:
> On Wed, Dec 18, 2024 at 1:13=E2=80=AFPM Rolf Eike Beer <eb@emlix.com> wro=
te:
> > On Montag, 7. Oktober 2024 15:11:40 Mitteleurop=C3=A4ische Normalzeit R=
olf Eike
> >=20
> > Beer wrote:
> > > All current users need to add a KEEP() around the argument so the val=
ue
> > > is
> > > actually kept, which doesn't feel very natural and is prone to upcomi=
ng
> > > bugs as the name suggests that this macro alone already keeps things.
> > > Move that directly into the definition.
> > >=20
> > > Signed-off-by: Rolf Eike Beer <eb@emlix.com>
> > > ---
> >=20
> > Ping?
>=20
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>=20
> Please put the patch into Russell's patch tracker so he can apply it.

Ping?

It's available in the tracker here:=20
  https://www.armlinux.org.uk/developer/patches/viewpatch.php?id=3D9439/1
=2D-=20
Rolf Eike Beer

We are nominated for the embedded award Visit us at the embedded=20
world 2025 March 11th to 13th, 2025 | Nuremberg Find us in hall 4 at=20
booth 336

emlix GmbH
Headquarters: Berliner Str. 12, 37073 G=C3=B6ttingen, Germany
Phone +49 (0)551 30664-0, e-mail info@emlix.com
District Court of G=C3=B6ttingen, Registry Number HR B 3160
Managing Directors: Heike Jordan, Dr. Uwe Kracke
VAT ID No. DE 205 198 055
Office Berlin: Panoramastr. 1, 10178 Berlin, Germany
Office Bonn: Bachstr. 6, 53115 Bonn, Germany
http://www.emlix.com

emlix - your embedded Linux partner
--nextPart3678204.R56niFO833
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iLMEAAEIAB0WIQQ/Uctzh31xzAxFCLur5FH7Xu2t/AUCZ9ANvAAKCRCr5FH7Xu2t
/PHoA/993Ou2lJsA0KucMXYTORvPiVIyVOFrdJcivrILl9JVVwlu4labkgljU32D
VDA9k1/sWIEo/dSJR5lkZxyGPbx8t70fjEZdjXYGzqvFksHLJJW6sWn9KhPgdlkF
pbfy56d2Jym8q/AzdQJcdAyKdTnEE/vtgzmiMirdcsnQvMzNSg==
=CFUV
-----END PGP SIGNATURE-----

--nextPart3678204.R56niFO833--




