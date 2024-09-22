Return-Path: <linux-kernel+bounces-335249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AD5F97E316
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 21:54:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF70028112E
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 19:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17C87482D8;
	Sun, 22 Sep 2024 19:54:15 +0000 (UTC)
Received: from maynard.decadent.org.uk (maynard.decadent.org.uk [65.21.191.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4066F3D0AD
	for <linux-kernel@vger.kernel.org>; Sun, 22 Sep 2024 19:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.21.191.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727034854; cv=none; b=WmvkgKL5tt1aw7yLhb8XnE/A5r02tGIhuhDVzwIfyog8Zbgz3ZSW5/j74fu/ixibMTbJQPighLMepNDKvAQJVMquBeg+Xx/+laX9Z5hhB8D9CMXpAX22Z9K0vPkooQ9xY8p/Uxt6438ihTl1qa3m56/j1rgtNHsl8XLLJV9efUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727034854; c=relaxed/simple;
	bh=Ku9rlVBSDy+FhHpLgE13O06Jgvb193TlgfqFQQ7Bffg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gaCJSvndv6E8oKGfOzNrVhLXdr1y57zUeW3waO6vfBToqBh7SGdMXSKGFDhC+g83jbwt8j+NeitRFjHbynnFYmOCefS2trMDuY5x05tIUtsAFV7XrdXvon9H+PnEuQ4d2TnfTzSsyjrdOIJ87HO1nTgbCyN6ywbVOi0Mv9u0Dz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk; spf=pass smtp.mailfrom=decadent.org.uk; arc=none smtp.client-ip=65.21.191.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=decadent.org.uk
Received: from [2a02:578:851f:1502:391e:c5f5:10e2:b9a3] (helo=deadeye)
	by maynard with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ben@decadent.org.uk>)
	id 1ssSef-009Lvn-2y;
	Sun, 22 Sep 2024 19:54:01 +0000
Received: from ben by deadeye with local (Exim 4.98)
	(envelope-from <ben@decadent.org.uk>)
	id 1ssSef-00000005w4i-1urn;
	Sun, 22 Sep 2024 21:54:01 +0200
Message-ID: <bb1ee774f6b5a00a3a735389b14e8cf86d5ca187.camel@decadent.org.uk>
Subject: Re: kernel: hpet_acpi_add: no address or irqs in _CRS
From: Ben Hutchings <ben@decadent.org.uk>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: 1041484@bugs.debian.org, Al Ma <alma0@ro.ru>, LKML
	 <linux-kernel@vger.kernel.org>
Date: Sun, 22 Sep 2024 21:53:57 +0200
In-Reply-To: <5183ae1168b9661a6c31a15b02802db6@mail.rambler.ru>
References: <5183ae1168b9661a6c31a15b02802db6@mail.rambler.ru>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-fE7iLVxKZGmyrAuNnwoE"
User-Agent: Evolution 3.53.3-1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a02:578:851f:1502:391e:c5f5:10e2:b9a3
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on maynard); SAEximRunCond expanded to false


--=-fE7iLVxKZGmyrAuNnwoE
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2023-07-19 at 15:04 +0000, Al Ma wrote:

> Package: linux-image-6.1.0-10-amd64
> Version: 6.1.37-1
> In the journal of a laptop Lenovo ThinkPad T14s Gen1, connected to a dock=
ing station ThinkPad Thunderbolt 3 Dock Gen 2/Workstation Dock Gen 2 Type 4=
0 AN (which is powered by a 135 W AC Adapter ADL135NCC3A) and to a monitor =
Philips 275B1 via a HMDI cable, we discovered the following warning (last l=
ine is yellow) generated at boot:
[...]

> Jul 19 16:20:34 AnonymizedLenovoThinkPadT14s kernel: hpet_acpi_add: no ad=
dress or irqs in _CRS
[...]

This was also reported as appearing on Lenovo ThinkPad T14 gen 4
running Linux 6.10.  I searched for the warning on lore.kernel.org and
found that it also appeared on:

- Dell XPS 13 9360/0596KF, Linux 6.9-6.11
- Intel NUC12WSHi7/NUC12WSBi7, Linux 6.11
- Lenovo IdeaPad 82MG, Linux 6.1
- Lenovo ThinkPad T480, Linux 6.10
- System76 Pangolin, Linux 6.11

Is this likely to be a bug in the driver, or in the firmware?  If this
is a common case where the HPET isn't available and has an incomplete
description in the ACPI table, should the warning message be downgraded
to info level?

Ben.


--=20
Ben Hutchings
The two most common things in the universe are hydrogen and stupidity.


--=-fE7iLVxKZGmyrAuNnwoE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAmbwddUACgkQ57/I7JWG
EQnGLBAA0ubWXFBTvdGumM/FYCptQQZtdLL/AlXfR29B/XsoA3EWrucwJ07EcSDF
gsV+owSTyx5lfKoc6pGyOK43R4Nv1AV4DSYvpKg7WlAbYCzMbtts6GKNw1LG5X8x
hhMgXoGjDhyR98c7lxvXNQgohyXEZG+AJrlNwSH3NkRYSKMJZvL9NhSF7UrDDF7I
DAqu59p90z890cufonwB6qW9q07wdK/b3+ToXowPdKg2XEE3bGxDwy56EZ0f81aG
WItx4OBoH3onO+ul5gIokLvsb4yZ+8GgwTdwIdeujr8T9Zm3j9/N+rXnvMPSTlax
fDzOPb8PT/pQ9Ma57O4+B5bdwQhUX6hK/AjAf5C0Xu0qsaluPZzVLIEkQ55nfcQd
lzaq8WUgR3Vp/7yA19UvkvheHv9+xj6jG6jCzA9y0c0b5dGeZYDEKGpW29mj1DPV
QR9N1NN4jLOpE4WQprj1Gty1Y0T7xTsbtUYDx46sn7CKoa34ZX0GXHwdrED5t84s
FYEBE0BeIxX2k61q9b708DaRp4ThUmUu5Z1zHLzpe+AHFm15iN8aoepMIdP/dLfD
XS+zEfTU3+yIoMg31cTIZ9shCelmXK/eCieKCTrTrqQku9dZ3QPzFaEjo3+nNmDh
2gIJXH8kj7sLhjA4HH4j4Yj+ImyFpXSiXvehFOlJWingaz8q8gg=
=+PvT
-----END PGP SIGNATURE-----

--=-fE7iLVxKZGmyrAuNnwoE--

