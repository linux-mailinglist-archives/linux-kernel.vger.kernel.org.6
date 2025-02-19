Return-Path: <linux-kernel+bounces-521213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3507A3B899
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 10:26:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7272F16EC73
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 09:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E838E1E3DC6;
	Wed, 19 Feb 2025 09:15:35 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6B51DFD8C
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 09:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739956535; cv=none; b=gGE4ieg8gMVRx1enG0f7ar7c7gi9lzbWhfM2513SrpVn9MmePMACttb5MzeUYaiUbYgC5I04cxWUDrT95nNgrucmFmNWiAbNaVCexkp3Rb9bKjfuwbmzmHpVuH3SWxgHcl2QQk2b3EK+0zl02SIdjDDVOML9eshdwJcZk9Av1R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739956535; c=relaxed/simple;
	bh=Yv8xAdk0s0Ux0L4VHP9EJmsidabmk7znJSAKxSZw7/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TLjfjm21tOudrbCukrEOr06k7qjbdvo2V7dXC8JMApTKng2ReVYFbEYx28y+Npi7HMHsFUHRhAl4KTVZDul1tz6AM/on0NfDTjcXROYKJLvTJgYKI7znPUyHW7YExkLRXE6XJr9lOr76+0ip7HossdZLc/xhtJ6uTfAw1o65VGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tkgAj-0004wQ-GV; Wed, 19 Feb 2025 10:15:13 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tkgAi-001jpy-1L;
	Wed, 19 Feb 2025 10:15:12 +0100
Received: from pengutronix.de (p5b164285.dip0.t-ipconnect.de [91.22.66.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 1A3343C6741;
	Wed, 19 Feb 2025 09:15:12 +0000 (UTC)
Date: Wed, 19 Feb 2025 10:15:11 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Dimitri Fedrau via B4 Relay <devnull+dimitri.fedrau.liebherr.com@kernel.org>
Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, Dimitri Fedrau <dimitri.fedrau@liebherr.com>, 
	Dimitri Fedrau <dima.fedrau@gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: can: fsl,flexcan: add transceiver
 capabilities
Message-ID: <20250219-huge-zippy-hawk-231ae0-mkl@pengutronix.de>
References: <20250211-flexcan-add-transceiver-caps-v1-0-c6abb7817b0f@liebherr.com>
 <20250211-flexcan-add-transceiver-caps-v1-1-c6abb7817b0f@liebherr.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gkbyirhilgbtjdzq"
Content-Disposition: inline
In-Reply-To: <20250211-flexcan-add-transceiver-caps-v1-1-c6abb7817b0f@liebherr.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--gkbyirhilgbtjdzq
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/2] dt-bindings: can: fsl,flexcan: add transceiver
 capabilities
MIME-Version: 1.0

Hey Dimitri,

thanks for your contribution!

On 11.02.2025 14:12:33, Dimitri Fedrau via B4 Relay wrote:
> From: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
>=20
> Currently the flexcan driver does not support adding PHYs.

That's not 100% correct. The flexcan driver does support PHYs, but via
the old can-transceiver binding.

Can you rephrase the commit message.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--gkbyirhilgbtjdzq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAme1oRwACgkQDHRl3/mQ
kZzKEQf9G/GMWLoCXYME0s3ecvtDdsdK7bJwj9E4tVJ9E5Kie0CwPZMjiDRcLnpC
VMDpkG3etidiZfsLfCbxEI3rRdfdGRVt54Yd4r6Idc8OhTtgAfdUHELk6dp3OORl
/0rnDJ8dMl7Cqy40y4BMw7R7krNpS+FlZ9ya8iAx5V+BcpsYb61L29A6B2do+3Em
KsjSA/kU9QtNnKrNG9iSzcRTUItWkg/YQf3gEuUQULizP7sOlLXUxs5+eOBXoRFS
6zZn/W+JZBlomsKqitCs0v9zpm328pWiKrUyH/strSYkswUtzTGeFSLP8PmyopXJ
CgF4GK+g0mbx/9jWU26Hjl/SiO0n5g==
=U8y+
-----END PGP SIGNATURE-----

--gkbyirhilgbtjdzq--

