Return-Path: <linux-kernel+bounces-168957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 724AB8BC02D
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 13:03:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12205B20EEF
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 11:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 646D614293;
	Sun,  5 May 2024 11:03:46 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6307DFC1F
	for <linux-kernel@vger.kernel.org>; Sun,  5 May 2024 11:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714907026; cv=none; b=bs5U7wRvyZvCBe/hnPsJwsieoBQ6jREwYzsB+eFeoiR3EfAZX1EmdZIpQtrWiQnj2xcLrP+67UF8Mu3Mp5x6peNW6MSdld3cAL6OqIxuX2FRVguk+0Y9BxNN1lzB8/caXrtZ4cLxWJsureqebD90WsBQG3ccm8Vktcufg+nLSTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714907026; c=relaxed/simple;
	bh=qu0Gf2lVdgr1KDJ4I4DkKK9VpTiGwEWgx2iVGlqq8CM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c2+1Jilde1WKQLM+BzljsnyA4L+M5xZ05YdeX8eMVnl2NcQeUbV6XViBBatd/oy3IFtkkkXrcz1CVEsOBmX5vbikKTxUyiv28ve4DObQURr5yszKKk71/3Mu6XrILQKMKz3DCx5n0stnEKt+eD9NQwhmXcUkCxUN9dees8WtVkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1s3ZeS-0000By-97; Sun, 05 May 2024 13:03:28 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1s3ZeQ-00G432-Ot; Sun, 05 May 2024 13:03:26 +0200
Received: from pengutronix.de (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 5A55D2C9C86;
	Sun,  5 May 2024 11:03:26 +0000 (UTC)
Date: Sun, 5 May 2024 13:03:24 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Harini T <harini.t@amd.com>
Cc: mailhol.vincent@wanadoo.fr, davem@davemloft.ne, edumazet@google.com, 
	pabeni@redhat.com, michal.simek@amd.com, appana.durga.rao@xilinx.com, 
	kuba@kernel.org, linux-can@vger.kernel.org, netdev@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, srinivas.goud@amd.com
Subject: Re: [PATCH 0/2] can: xilinx_can: Document driver description to list
 all supported IPs
Message-ID: <20240505-imported-bizarre-bobcat-0649ff-mkl@pengutronix.de>
References: <20240503060553.8520-1-harini.t@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ezdgdpb3z4ddihnh"
Content-Disposition: inline
In-Reply-To: <20240503060553.8520-1-harini.t@amd.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--ezdgdpb3z4ddihnh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 03.05.2024 11:35:51, Harini T wrote:
> Xilinx CAN driver supports AXI CAN, AXI CANFD, CANPS and CANFD PS IPs.
> 1. Modify the dt-bindings title to indicate that both controllers are
> supported.
> 2. Document all supported IPs in driver comment description.

Applied to linux-can-next.

Thanks,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--ezdgdpb3z4ddihnh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmY3Z3kACgkQKDiiPnot
vG/HZgf8Ci/Xvp5sgUB91ZLfyBEUw6ncROF0DfzTBRBn+bLdSsAvvZc+ARJz8JLT
UfZyTreTf9GAY6L85JMGMU4/f5Y1L6gDt2hh7PMa2pJdkVbNpmczkgd+je4yht+n
DbrCsuC19uKymI00XEzsCqu6qJUfzPw8Wgn2yks708nyYMCOaSPri8SAXSklRYYl
2vroktos+2yREvBuVXQFdEeLPMUBUlkgU355SdjR7YVlaz2hF7jH64/AUAslZDPt
DreLKq3BYqYDQcEc+U7i9I4KB/F/4KnoPoBAYL4PCobr0GQRsOtb8RfSLZIwTOhh
IxuilKCx7C6yAPtC/MWfD8rnkKk7Ow==
=YEvq
-----END PGP SIGNATURE-----

--ezdgdpb3z4ddihnh--

