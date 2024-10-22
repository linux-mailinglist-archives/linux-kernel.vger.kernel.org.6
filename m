Return-Path: <linux-kernel+bounces-376652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1110F9AB477
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 18:55:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C492A285BD2
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 16:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D2261BC099;
	Tue, 22 Oct 2024 16:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EJny844q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7DF1256D;
	Tue, 22 Oct 2024 16:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729616106; cv=none; b=uhIO2ExmsDHQYpgcgLyj7wKZYStXp2ngLyhUh/IXlU/Tf26t+3We1fY/F9jLyBpO3nIfpBAyCVheCTZeeHUNnaRVxvLYq/4YjeMSZm5e9acXX6C8SfoAwgFYkWMXOyVeTn8R9TsmRavu9KTHkszoPcbxHQB9o2rt4O9bAjR07oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729616106; c=relaxed/simple;
	bh=dFIIm5rhxs9qT/MajtS4EYkcanyHeA4sGE0hYbhvTFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PjcJlXoZeD7yyu76XD5qhe4er8jIHhCh+N29AobRtBqm+mD0FJQYhe+swcwws7D6PZGIwJsr1DvRViTv96C7OvGiyiI7OxOWQcmtHnqwoblsZC39at77Bge+ZvVp/3nP1/81m/63Qm1mKZxRzLNGfAJKot6wEv6LvhPo+asN6Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EJny844q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E72B2C4CEC3;
	Tue, 22 Oct 2024 16:55:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729616104;
	bh=dFIIm5rhxs9qT/MajtS4EYkcanyHeA4sGE0hYbhvTFc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EJny844qGoatCql5qUU/Q4fh8DIy6u3lc7JLAMq5mILuxu7Qg4uY1+ZFPCeHdARm5
	 1jify6tlyKKhXrW1Fy7cpaX3pbshaDsAsHui7wnQMneSf2VvkNq+Nvv4/cWDIWW383
	 bAeLYW8zFI+RNYM8AoBn+ZB/yVXHH6WjJCUw2gQ4PFCmj/jOkMmQ84133NxzSTA7l+
	 QJfelq4HrbwvM+TQqngohC8q5DESZysL8jAPvDEZi9hoAqvsC8XG8K7RaQF2pi9IxM
	 nb8ZL48xzl3BibX88siWOQMGJweVkFS6ZA4L1MWRglx7R/5LkyZ/kbQ64myclut72a
	 1hEdOsDtKdV5Q==
Date: Tue, 22 Oct 2024 17:54:59 +0100
From: Conor Dooley <conor@kernel.org>
To: Jason-Hsu <jasonhell19@gmail.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	joel@jms.id.au, andrew@codeconstruct.com.au, patrick@stwcx.xyz,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	yang.chen@quantatw.com, jerry.lin@quantatw.com
Subject: Re: [PATCH 2/2] ARM: dts: aspeed: ventura: add Meta Ventura BMC
Message-ID: <20241022-prayer-unmanaged-86ea24caf242@spud>
References: <20241022021724.2322506-1-jasonhell19@gmail.com>
 <20241022-clean-rebate-e986d6a82a05@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="fGRR7GdKJMsqfzS2"
Content-Disposition: inline
In-Reply-To: <20241022-clean-rebate-e986d6a82a05@spud>


--fGRR7GdKJMsqfzS2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 22, 2024 at 05:51:45PM +0100, Conor Dooley wrote:
> On Tue, Oct 22, 2024 at 10:17:24AM +0800, Jason-Hsu wrote:
> > Add Linux device tree related to Meta(Facebook) Ventura specific device=
s connected to BMC(AST2600) SoC.
> > Add subject prefix for the patch.
> >=20
> > Signed-off-by: Jason-Hsu <jasonhell19@gmail.com>
>=20
> The indentation in here is very inconsistent. Please fix that.

Also, I don't know what the coding style in aspeed in particular is, but
the node ordering seems very random here. Could you sort nodes in the
dts alphanumerically as the dts coding style suggests?


--fGRR7GdKJMsqfzS2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZxfY4wAKCRB4tDGHoIJi
0g9lAP43/yhfmMpPGE/UTpJbFPS2SOc0ZEN/nLtKSvc25ObaswD+LyRMqnsq87TE
r6zdEguM3482DqDtUmYg4SQEYytUVgE=
=GZrq
-----END PGP SIGNATURE-----

--fGRR7GdKJMsqfzS2--

