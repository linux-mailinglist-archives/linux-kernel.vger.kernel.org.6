Return-Path: <linux-kernel+bounces-410535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C89C39CDCF1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 11:44:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43008B2259E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 10:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC28C1AF0BF;
	Fri, 15 Nov 2024 10:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M3Fe0QwG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A19118D625
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 10:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731667457; cv=none; b=Jpsh2a8qfAmETUCDz3R+mP2mdcYnBHNbWUOigNumS4lHkwE6vk5G9BJqRARdm89dMNsxjOmK4bjX1o5f+fITZ/ojfrCyskoAEIzq7XSbHfkonJxx6tfykNtwMUjpjKG3bqhftVBkAigiBE0KEzRwPDZblXkgx16hzvyOQoSa188=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731667457; c=relaxed/simple;
	bh=TwjOkkjf/FnUrDNkUNWwxxa5arcM9kBk3/6zSkzAHjs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=izPSDyODREYUFZie/yy7f0nphhnsBYPlbnUQV7QqGQAmkZ4VgZ6P/lS2LU6qzRywCMXa1k2VRNqHBgW9V07wS1GkJ1KBFsNOtqz55iQvke4LOMprxG9qzjv9es3Cv+1/UCGgkMyAwdordkK3qOtycnDdsNekBIjUfwNUuizfKOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M3Fe0QwG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41973C4CECF;
	Fri, 15 Nov 2024 10:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731667456;
	bh=TwjOkkjf/FnUrDNkUNWwxxa5arcM9kBk3/6zSkzAHjs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M3Fe0QwGM6/OqA2qKu7d1cD8pzvKcXbCcNTo4/IFl4RLTwQKh5viGsujTexiaNJQF
	 kPB+kPNxRZSsUAS6zeegRe3s9pyW7A6CPLD/oiXpyDYVxD+MWcBBs2HGwY+9YIhDm0
	 REH8wNfAkePKYoNM1vaT6XM5bHXM3nukmJdDNKqL9gZENvNBkwNh++PZjw5Xt9CHfl
	 K5OMw3zc8X+DbKWKhonaSp3O3l4Ncr/v5sgC+B9D3a3zKLA28cZzqKTrhKQGamhI/+
	 sRA3Ns4abWNKn7F+CRB5TXh4aqXVK+YNCUsw0a0B55ZcjetVE62mZIyoMY+WY6YTv2
	 9pobRLfoDQx3A==
Date: Fri, 15 Nov 2024 11:44:14 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Werner Sembach <wse@tuxedocomputers.com>
Cc: Christoph Hellwig <hch@infradead.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Christoffer Sandberg <cs@tuxedo.de>
Subject: Re: EXPORT_SYMBOL_GPL with GPLv3
Message-ID: <bpnl6godljzxtzatg7juobvitx6dhnpzayaljqlyq7tnbpzou7@odpzrosrpvq7>
References: <17276996-dcca-4ab5-a64f-0e76514c5dc7@tuxedocomputers.com>
 <ZzLg2etoX94Nb0yk@infradead.org>
 <1fcb3716-308f-49b8-b84f-2225aa2a1fb8@tuxedocomputers.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="e2xq76xgvhzoopk6"
Content-Disposition: inline
In-Reply-To: <1fcb3716-308f-49b8-b84f-2225aa2a1fb8@tuxedocomputers.com>


--e2xq76xgvhzoopk6
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: EXPORT_SYMBOL_GPL with GPLv3
MIME-Version: 1.0

Hello Werner,

On Tue, Nov 12, 2024 at 09:34:29AM +0100, Werner Sembach wrote:
> Am 12.11.24 um 06:00 schrieb Christoph Hellwig:
> > On Mon, Nov 11, 2024 at 07:40:25PM +0100, Werner Sembach wrote:
> > > Hi,
> > >=20
> > > asking at the source: Can EXPORT_SYMBOL_GPL-exports be used with out =
of tree
> > > GPLv3 licensed modules?
> > No.  The kernel as whole is licencsed as GPLv2, not GPLv2+.
>
> Yes, but the documentation for EXPORT_SYMBOL_GPL only talks about
> "GPL-compatible" and external linking for EXPORT_SYMBOL-exports is even
> legal with proprietary code.

AFAIK there is no agreement about the legality of proprietary code using
symbols published with EXPORT_SYMBOL. EXPORT_SYMBOL_GPL was created with
the intend to at least have a way to express a symbol to be used by
GPL(v2) code only.

So the safe assumption about EXPORT_SYMBOL functions and variables is
only: "The copyright holder did not expressively prohibit proprietary
callers. This might be because they are ok with proprietary callers,
but maybe they just didn't consider it necessary to share their
opinion.".

> So to my understanding, it comes down to what EXPORT_SYMBOL_GPL means
> and not what's the license of the code behind it is.

Here my approach to clearify the meaning:
https://lore.kernel.org/linux-kernel/20241115103842.585207-2-ukleinek@kerne=
l.org

Best regards
Uwe

--e2xq76xgvhzoopk6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmc3JfoACgkQj4D7WH0S
/k47DQf/Qrxa3iKehnWpomsUP5oEkqma/KK4qzUqeE7IhEPnaJhfm4fsMXZHoOmX
SUDSqSRXwQ2JtySsa+qIo56RERsranvWXe7TVq5rLDxeuCyOG7iZB8FoY0GEBTu/
Mjrklo//To6P7e5/t8dTAEN+zUivwRYarkGIrf24/v5vFPZC1wZiK0XVhgPsbNuZ
2b3P21AQQNfziXFzjavoG7XAE7rX9BsuOC0VDGWKJEq7wBYvH4dxxG911ndCIZTB
++oT3aQZo0FN1Qg50VVyioGixWxmEOCMH4xpAHlRTazBjvaTjBipE3L+5tC0t4DH
+pi2iFs9VI/ctBdOs9Ofe9F9lfUrIA==
=Qf06
-----END PGP SIGNATURE-----

--e2xq76xgvhzoopk6--

