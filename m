Return-Path: <linux-kernel+bounces-421511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CBFE9D8C47
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 19:35:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62ED5285ED2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 18:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAC901B87FA;
	Mon, 25 Nov 2024 18:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="abNEet1x"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 506221B81B2;
	Mon, 25 Nov 2024 18:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732559735; cv=none; b=BsWWSodMyHVbUkRZX+yC1VmzZ95ncpUwhrPfHA6ZcqqzbK1KVlBSaj2KpckOz9mVXmUILoGv4rvx3C6hf7YbdVoPiN18pMAEPVX5x9LnRRwcTp152q1QcQZBp0lC+TwcyMA7ceQjv6o2YVsH3SrBCHEPb0u24Ci5/OOy644V0l0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732559735; c=relaxed/simple;
	bh=usQaD7Eq3IgYujbCNmlKd2Yc8sXDWA7yxQ7+EeU7zwk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YXBENYo30W/av8GW8z9Isxpq7TG6cvQogWd5ent32Xacxeg94iDHrQUrDSE495o5v7r6bu4OYoJu/icN/QTH7KqUfGEl6CqsGbiLqnkslyenL1us5szbtzWTIHQgoOW02v5y8XIBt0qO6kgN675sKdVDqZw39y/4TiUFdaivdCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=abNEet1x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DE3BC4CECF;
	Mon, 25 Nov 2024 18:35:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732559735;
	bh=usQaD7Eq3IgYujbCNmlKd2Yc8sXDWA7yxQ7+EeU7zwk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=abNEet1xDw8QTR6AxDj61Z0qYU0YZtgrOFoGseUXP145RfcOUsf9gUP6jYNJ/kMCh
	 S+8R1tNA/uZ8EEB+t9oG23K28T9RuE2MMYsKxa9F2Q6OuziH19BGF57mQ4Eof+bCRF
	 LadD78oqNnQdNSNNdxL3IN68Wz30wrTXYO8spp9YImvA82KOj4DN7AHQDwbXEyPhP8
	 rBbjSGS6l4PKE6/b6MPK46PhtnWHZOxjSILG5uXIxM0ZhQnivCHrS60UyiYTqTD0l/
	 gNWJCER0iYinKmnDeDfgpWwLKFr6Dsr2oYI6T8rhO8m4l9gc/QBqzNr7Tr2ZSjvHJx
	 1l2hauk4HRo7A==
Date: Mon, 25 Nov 2024 18:35:31 +0000
From: Conor Dooley <conor@kernel.org>
To: cleverline1mc@gmail.com
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Stefan Wahren <stefan.wahren@chargebyte.com>,
	Ben Gardner <bgardner@wabtec.com>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v3 3/3] dt-bindings: w1: ds2482: Add vcc-supply propertyy
Message-ID: <20241125-dispose-tiptoeing-0daaa12c6e38@spud>
References: <20241124-ds2482-add-reg-v3-0-806df39c9454@gmail.com>
 <20241124-ds2482-add-reg-v3-3-806df39c9454@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="yTAD+MC5jRLXhu2u"
Content-Disposition: inline
In-Reply-To: <20241124-ds2482-add-reg-v3-3-806df39c9454@gmail.com>


--yTAD+MC5jRLXhu2u
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 24, 2024 at 05:21:37PM +0100, Kry=C5=A1tof =C4=8Cern=C3=BD via =
B4 Relay wrote:
> From: Kry=C5=A1tof =C4=8Cern=C3=BD <cleverline1mc@gmail.com>
>=20
> ds2482 has a VCC pin, accepting 2.9-5.5 V.
>=20
> Signed-off-by: Kry=C5=A1tof =C4=8Cern=C3=BD <cleverline1mc@gmail.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--yTAD+MC5jRLXhu2u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHQEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ0TDcwAKCRB4tDGHoIJi
0o8eAPdzIqH4U9geZIygmLmQweUWLGTJbMKxpMKqVCsIAgKsAQCVPcQeuGHhaBWr
4Vg3VBBjSrAy57YWSxtJWEhqXTN9Bw==
=iMOT
-----END PGP SIGNATURE-----

--yTAD+MC5jRLXhu2u--

