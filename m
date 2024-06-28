Return-Path: <linux-kernel+bounces-234210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E430C91C3BE
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 18:30:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 570A9B21F90
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 16:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64F8A1C9EAD;
	Fri, 28 Jun 2024 16:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hn8OzUwQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C441D6A8;
	Fri, 28 Jun 2024 16:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719592240; cv=none; b=MXHItFkI5+o2gScoMNREUi/+ApDqwJsZnJ1jabQNMPWa9Ef2V2+6Rd66cVF9Zp06wjMptarbQmctHtEaCzDVhAl7D+ak+kRDCosZVbNOR3MOJPqqoVZkf1k+vV/kArhMW4kSvDG01Jo6FT2dW8LUarBtvubSrWytrwCzoKSPWIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719592240; c=relaxed/simple;
	bh=e75xFRBq/xbtTG9yBdDrHh24XkoiCk2+XBxSyZ8Bin0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mUAzv4nC0fvh3dakmtLGfENaxv9t5P2ESiRB0b5z8gifUXm92dHeRubgdyIUh85pjgX6n1XX+Sx0G0dGUVCacQPPje0redAslegmNsLaFmBpn4XBJUmZGJdSaVQhHWhTIz6NcengqFRBYYarNbE1EKp7lmmrC6OMqwnsb1TyUNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hn8OzUwQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BBF4C116B1;
	Fri, 28 Jun 2024 16:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719592240;
	bh=e75xFRBq/xbtTG9yBdDrHh24XkoiCk2+XBxSyZ8Bin0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Hn8OzUwQquhTLQ6PIeJ86mcII6QkUIx0eM+GsSiC7gIuC6DhKjTb0gFlJxlhQI/gS
	 6a4YaFwk+4QTQ9jLi1IRjSIxM5SeoP6wt+WnnYDKWf34BPmSSF+Y22H7zs34fa5Rp0
	 WaxR30UhBffGqICj0LFortFhAk/6FbyIMsJwNp8tAhJDOiKVMtpP0ndxysC8sCOCVj
	 jnoefxUx7+G6dd1fQgGUNuwPu6WkCdz8XvuceO+y5BX1er+g6458JYk3a0QHQpd/UB
	 A3rUtKBzLsE3XtBIEKTfr+xf7DZ87yxZNz8Zjq2bUDJvLs+pR35xK7eQLvaGo2HHBn
	 314/35mwWoVYA==
Date: Fri, 28 Jun 2024 17:30:36 +0100
From: Conor Dooley <conor@kernel.org>
To: Aniket <aniketmaurya@google.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Jeremy Kerr <jk@codeconstruct.com.au>,
	Joel Stanley <joel@jms.id.au>,
	Billy Tsai <billy_tsai@aspeedtech.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v3 1/3] dt-bindings: i3c: dw: Add apb clock binding
Message-ID: <20240628-primp-recite-6bf752fc5257@spud>
References: <20240624052851.1030799-1-aniketmaurya@google.com>
 <20240628154526.324068-1-aniketmaurya@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ob0bapJuyJEYyaEQ"
Content-Disposition: inline
In-Reply-To: <20240628154526.324068-1-aniketmaurya@google.com>


--ob0bapJuyJEYyaEQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 28, 2024 at 03:45:26PM +0000, Aniket wrote:
> Add dt binding for optional apb clock. Core clock is mandatory.
>=20
> Signed-off-by: Aniket <aniketmaurya@google.com>

Missing a review from Krzysztof:
https://lore.kernel.org/all/e3160411-59e0-4806-a00d-b99564384180@linaro.org/

Also, please do not send a new version of a series as a reply to a
previous version. It'll bury it in people's mailboxes depending on how
they sort.

Cheers,
Conor.

--ob0bapJuyJEYyaEQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZn7lKwAKCRB4tDGHoIJi
0ruUAPkBtFdfU50cjfk8UhQgDwLbvPQeNQB8jG5WUUuLI9GAsAEAxkwmAByLdNck
y39iiS9320Jb4eXj38Oi+Ga9rcI3rAg=
=aXhn
-----END PGP SIGNATURE-----

--ob0bapJuyJEYyaEQ--

