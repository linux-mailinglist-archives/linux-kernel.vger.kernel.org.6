Return-Path: <linux-kernel+bounces-232656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC93491AC6D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 18:18:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85D53287B71
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 16:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85AC6199393;
	Thu, 27 Jun 2024 16:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fKjRxvxG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6966197A65;
	Thu, 27 Jun 2024 16:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719505103; cv=none; b=aMN466jMDDSZ0mjLvUcdpjGonymIcFsRF4gAXRrXW8rX+29DosqtgqRHbrH2ZW5Q20D/CiRUdt3SbFqihLydWfh3VtRTZSSJ8zSRqp4peoM9baQGzxWkPfenXF0iQzxKQHOn7lGTGhhuJ8gBvcSSZQCUxETPuAlrygOeBFNy7sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719505103; c=relaxed/simple;
	bh=gmT88TfnjaS2vhKOWeRDOUNUQ6+OhlkFPvnZgNOTto0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q0WP9fdH0lBUXgpS9v0gunVZflu3s/Mu2AaTnenPkXxLZ/XrJAc4SOl7VTRxI7Q2idkdGFXZWujI28mqbPkWr8fxiotnCowN9ot7Z9CyTpGynlKirsC3upBPdCWIeQqxmc5cTALcJ4JBhoGMnWEM/H1jARR/MYWB9okxsHS//Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fKjRxvxG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 153EFC2BBFC;
	Thu, 27 Jun 2024 16:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719505103;
	bh=gmT88TfnjaS2vhKOWeRDOUNUQ6+OhlkFPvnZgNOTto0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fKjRxvxGEPrpl4qtAvlcLOEdC28cCVGWJ+wUUw2a237jDiriozhi8pogh5Aqi+8Vl
	 ut+jywh5Fdnaa29+CZJv38cMz49da/Kfv3vQ/lA+EgEkWKeJyMA4yoKfEim1MbTW8L
	 tzxmQqIytPNoh569tqMgRiEjOyH2+jXtGstW1kWejG4B7S5NN+LHZM7r5Tvwb1zqv0
	 0TPOcI27uB9j8hEuvOqcOOGk5q4c+/oWYucEZdOFg3czx30HbL50bC9lEw8bjXRp/Y
	 iI0LxdluK0HuSzyuroroJFLPlW0U6LJBn4p+YpRpcO48UysLxnC5+sKfeSUAxVBMCI
	 WD1bddLVF7xWA==
Date: Thu, 27 Jun 2024 17:18:18 +0100
From: Conor Dooley <conor@kernel.org>
To: Marco Felsch <m.felsch@pengutronix.de>
Cc: neil.armstrong@linaro.org, quic_jesszhan@quicinc.com, sam@ravnborg.org,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	thierry.reding@gmail.com, kernel@pengutronix.de,
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: display: simple: Add Jiangsu Smartwin
 SMMT043480272A-A19
Message-ID: <20240627-gloating-unsnap-bfe0f45c8715@spud>
References: <20240626161714.4057983-1-m.felsch@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="3zxCmR2rZoVz2I/F"
Content-Disposition: inline
In-Reply-To: <20240626161714.4057983-1-m.felsch@pengutronix.de>


--3zxCmR2rZoVz2I/F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 26, 2024 at 06:17:12PM +0200, Marco Felsch wrote:
> Add compatible to panel-simple for Jiangsu Smartwin Electronics
> SMMT043480272A-A19 4.3" 480x272 LCD-TFT panel.
>=20
> Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--3zxCmR2rZoVz2I/F
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZn2QyQAKCRB4tDGHoIJi
0qUQAQDNtUooY97mEN8EqltkKioCV7gjVL4rr85IfXPhZYFmRwEAmY62ml6PzPJm
bGL3KxkjR7YB/4xDoSzdzyr7bFTbbgU=
=r+Zr
-----END PGP SIGNATURE-----

--3zxCmR2rZoVz2I/F--

