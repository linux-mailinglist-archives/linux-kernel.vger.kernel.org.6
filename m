Return-Path: <linux-kernel+bounces-195394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EEBB48D4C1E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 14:56:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0D2028448C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 12:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4061132129;
	Thu, 30 May 2024 12:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DqE6JWqp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B0317C9F7
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 12:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717073777; cv=none; b=Kc2731ycWtrXiNXMqzbpO3ZiTNnrJd5CecA11UDsE9utUmfmcxMcm4Ac+f0HIkhWNXj3RcYX990yFaqhfS4ePGAEAtkojOR9TzbNb0hNO19IGkOqZPvyCBv209YGl+BhQ6Eg6oGB50ffHwsf8Qchvh0I3RKZKaUGt3NAsgLb5Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717073777; c=relaxed/simple;
	bh=fsnxpKnK/dlxWWWsjtLsWeAOx3cPZET9AH/1W/3mlbI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EpzqIEbJcqU5N/QDzifTsF6Ionpzt2KI2aaUBvUI4O9TYgG0z+l30sfuY67HFqVk0byrB/3lSd1iVGLcH9GNukz5l9d4DpleaFNuI/kjDcpWXiw01hhbQZmt0pDf35z+TUfTBRrwQtEKBqPr53ZNpMZqNNacdgaVgocK64Lze88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DqE6JWqp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 981A5C2BBFC;
	Thu, 30 May 2024 12:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717073776;
	bh=fsnxpKnK/dlxWWWsjtLsWeAOx3cPZET9AH/1W/3mlbI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DqE6JWqp0ZrTYpu5j/dX8k+gOJrxABXsQK70A8Utq0IDd5IbPCxXkvw7e9Hxrska+
	 orUrEWMZamWsSlhT59cVWgo2cwDraxcLbfcNsXMro+PBeJwe7u4/jeBo7z8ZT7o/2u
	 DxSMxean22hwcE6sQNjseBHDDO1bmi7cQRec9X7AjyF1oRYG9TMAZ6MZFPr7uVJVYg
	 tjXRk1ZFYdlZw5nA/eNnBlNly8sHIhOL2mny0nd0eSFT76+V7mIZwRJ4zMzXSUks/7
	 5B/gqybwqmVmtyslQ0RRVdi/Oegk0iywpa0DRU0PiL5fPK+8pWJUrSmDQYbFECycFA
	 AlIyjs1t4Vwdw==
Date: Thu, 30 May 2024 13:56:11 +0100
From: Mark Brown <broonie@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Lee Jones <lee@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 10/10] regulator: bd96801: Add ERRB IRQ
Message-ID: <b058a65a-4508-4bc3-8804-114127064c79@sirena.org.uk>
References: <cover.1716533790.git.mazziesaccount@gmail.com>
 <3ebba7116380a65666b5b05835dff8c8f565c473.1716533790.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="1Y9LzQYPWsxGeflV"
Content-Disposition: inline
In-Reply-To: <3ebba7116380a65666b5b05835dff8c8f565c473.1716533790.git.mazziesaccount@gmail.com>
X-Cookie: To err is human, to moo bovine.


--1Y9LzQYPWsxGeflV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 24, 2024 at 11:19:47AM +0300, Matti Vaittinen wrote:
> The ROHM BD96801 "scalable PMIC" provides two physical IRQs. The ERRB
> handling can in many cases be omitted because it is used to inform fatal
> IRQs, which usually kill the power from the SOC.

Reviewed-by: Mark Brown <broonie@kernel.org>

--1Y9LzQYPWsxGeflV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZYd2sACgkQJNaLcl1U
h9CSNwf+L5hko8ETA3YC7UY/upvy7LnBgFmSp+vrTOrVHImUawar1LI5H3DuCmUP
aEAbYsdyl5eyGq6B+EKGUQfHKogI+TlKikuDlQMZIPFtThIoKGLtRxRtl1YPqn+G
HULvWtUy7DMnjOrmFheFJm2STHQ+aMTREbvK69sfoMv3iDN/2bJclaSiT+r+dxSi
3d4lWnZAbO1ivuFDKbrnfBZBjGU3j0PWjAhYVsPKuUjg2eyeqkHlQKJTlD9WDRbl
tIqTWDJce5qhNIzRixJ2ys+Jum1Cz8jlowPVZnsTMLGW7J1CRuplCV7Yzl+ezwOg
81WhUA8mEJSg6/n/5dAsO72QP4RhNA==
=WJN6
-----END PGP SIGNATURE-----

--1Y9LzQYPWsxGeflV--

