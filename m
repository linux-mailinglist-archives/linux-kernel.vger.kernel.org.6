Return-Path: <linux-kernel+bounces-342370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 81084988E0E
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 08:54:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD7481C20E2E
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 06:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77B0E19A282;
	Sat, 28 Sep 2024 06:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b="b0Vz7rmu"
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E621537D7
	for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2024 06:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727506470; cv=none; b=B0kBLVqeJfOQDC3S9C0QxVwmpD9eUVhoOZhoMIxi/qDB25z9bLuMlsQ6ODsbTMhyCVvvgo3hXJFeMlLEIHZkxpNQ8FX05OQ5HxEfvJGlI2/7BmQNoWVsmJcBa5lXVu9BN9R7XxoBmHExMDRobaoBJ5SiYSmu45HgkbWe4f6jz80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727506470; c=relaxed/simple;
	bh=FyK1UT2kKLEtWV22jilqugWmDUI+PIiVzxgAW8iI9V8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Nz+7RCdRmzdyhzUWL0PGY/AzdSADkVmc+1+5oQrjCUM9f/hiDmtTytSjbZwn6Qrs9Mcr1bIjG0GszRRavZPquCcwAtvzBb50YLlFSXNGrIutGIU7AghseMRRnvmz2ItiactlmirohvWTqxitLFFgEyytXTDb5rUZ0+2U7lJ+iqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org; spf=pass smtp.mailfrom=cknow.org; dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b=b0Vz7rmu; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cknow.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow.org; s=key1;
	t=1727506465;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=N/ve3pnXDKZbzYHAOFPE/dzau+YjyATV+0kZoaLGUmA=;
	b=b0Vz7rmuHOHUrxm7FxiNsXUooJWQB/SdbZqwtXjpw2s6BwdpJV86xqEFisTnUFFDUfmlvI
	yJoB5VWLAhwT+fq2/Nkh6lTY84NU2nMK4zlxcPAa4REOKf9pqehY/RQEIV/iUbFSNF1Hvj
	41cW5UamvHOWqEfCfAlpRBJkNfcSJP7+XrHaeMDpaMAMsmFWvkShaapNmoJsU+YYn6oY2w
	612ge6Hb+lwldQNenKpDgOsaXdk+kAlfRj5e2MsPxK9jgkcHSGRh9+z9jeiKJbq6V4ZNei
	j1t+Bb7cEJj0OK6f9agzQPZGHbruoc1eq0j9pQZiRSF5atS02rTuw3sFPs2Trg==
Content-Type: multipart/signed;
 boundary=cfd3c3afaff839dbcdcc8144397420e9c5125dae20b348a12ed9b6623dd4;
 micalg=pgp-sha256; protocol="application/pgp-signature"
Date: Sat, 28 Sep 2024 08:54:12 +0200
Message-Id: <D4HPXGCB5GGE.1KQFZR61CHMVF@cknow.org>
Cc: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Arnd Bergmann"
 <arnd@arndb.de>, "Armin Wolf" <W_Armin@gmx.de>, "Guenter Roeck"
 <linux@roeck-us.net>, "Vinod Koul" <vkoul@kernel.org>, "Diederik de Haas"
 <didi.debian@cknow.org>, <linux-kernel@vger.kernel.org>
Subject: Re: Error "ee1004 3-0050: probe with driver ee1004 failed with
 error -5" since 6.11
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Diederik de Haas" <didi.debian@cknow.org>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
References: <D4G7XD1WU5GY.D22KFST6MHIT@cknow.org>
 <2024092616-showing-fragrance-f70a@gregkh>
 <D4H312REVAZ3.3JWUT4NMWDA7C@cknow.org>
 <sr6p4lwnlznee73t4jof537dcwdl6m6vxriwk3pk4dnlxyaih4@6wv52esrfpyq>
In-Reply-To: <sr6p4lwnlznee73t4jof537dcwdl6m6vxriwk3pk4dnlxyaih4@6wv52esrfpyq>
X-Migadu-Flow: FLOW_OUT

--cfd3c3afaff839dbcdcc8144397420e9c5125dae20b348a12ed9b6623dd4
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi Uwe,

On Fri Sep 27, 2024 at 11:59 PM CEST, Uwe Kleine-K=C3=B6nig wrote:
> On Fri, Sep 27, 2024 at 02:57:30PM +0200, Diederik de Haas wrote:
> > On Thu Sep 26, 2024 at 2:44 PM CEST, Greg Kroah-Hartman wrote:
> > > On Thu, Sep 26, 2024 at 02:35:05PM +0200, Diederik de Haas wrote:
> > > > I updated an amd64 machine to (Debian's) 6.11 kernel and got this e=
rror:
> > > > ``ee1004 3-0050: probe with driver ee1004 failed with error -5``
> > > >=20
> > > > which I didn't get with 6.10.9.
> > >
> > > bisect would be great, thanks!
> >=20
> > $ git bisect log
> > git bisect start
> > # status: waiting for both good and bad commits
> > # good: [6150e5e1ae2d8ad72f52217f8f41fe446cae9e27] eeprom: ee1004: Inst=
antiate jc42 devices for DIMMS implementing Rev.1 SPD
> > git bisect good 6150e5e1ae2d8ad72f52217f8f41fe446cae9e27
> > # status: waiting for bad commit, 1 good commit known
> > # bad: [8400291e289ee6b2bf9779ff1c83a291501f017b] Linux 6.11-rc1
> > ... [omitted for brevity] ...
> > # bad: [7a46b17d4c00c2547b5bd82eec9489b19128fd65] Merge tag 'dmaengine-=
6.11-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine
> > git bisect bad 7a46b17d4c00c2547b5bd82eec9489b19128fd65
> > # first bad commit: [7a46b17d4c00c2547b5bd82eec9489b19128fd65] Merge ta=
g 'dmaengine-6.11-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/vko=
ul/dmaengine
>
> The following is completely generic. Note I didn't try to to understand
> the problem, just giving some hint how to further improve the bisection
> result.
>
> [ extensive description on what to do when git bisect results
>   in a merge commit as 'first bad commit' ]
>

This is awesome, thank you very much :)

I already thought that this git bisect result wasn't very useful as I
failed to see the logic of dmaengine changes being relevant for this
issue.
And I (indeed) didn't know what to do when a git bisect resulted in a
merge commit as 'first bad commit', so your description will surely come
in handy (someday).

I haven't made up my mind yet whether I'll apply it to this specific
issue. It doesn't cause any actual problems (AFAICT) and most
importantly, it seems to be fixed in 6.12(-rc1) already.
And the 6.11 kernel is only a 'temporary' one which I don't care (much)
about, while it is fixed in the kernel I do care about (6.12).

So if there isn't a follow up from me on this issue, it certainly is NOT
related to your message, which I appreciate a LOT :-)
(And I'm pretty sure there'll be other instances where a git bisect
results in a merge commit ...)

Cheers,
  Diederik


--cfd3c3afaff839dbcdcc8144397420e9c5125dae20b348a12ed9b6623dd4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQT1sUPBYsyGmi4usy/XblvOeH7bbgUCZveoGQAKCRDXblvOeH7b
bnTtAQCGgg5XDAzQsP4/1SYV6AoOufdTACCaRLMM9H0V2UhhSwD/ZfqwnFGyeVvo
DTebpUW57HamITbxd12Isscrs/Z+/g4=
=0KJi
-----END PGP SIGNATURE-----

--cfd3c3afaff839dbcdcc8144397420e9c5125dae20b348a12ed9b6623dd4--

