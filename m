Return-Path: <linux-kernel+bounces-345030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9313A98B146
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 02:06:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C876B220EA
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 00:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35974645;
	Tue,  1 Oct 2024 00:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b="kmzpxzoi"
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100DD173
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 00:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727741168; cv=none; b=e0T3a0hFhpI+oLxSOJMfdHN9cFPwQwa9/QRDDuyt3WdksAMjCq/bkEs7zm9G4hqDlFoUjsDJVmeFRgq/FwZGa6bfvXsh8K2KsZd91ZqcbLvqN1/BZJszr3qPXC6gAwDHn9ibAq9OMKiCturEjH3Xc/EskMkzjbiebl1+B/CWeas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727741168; c=relaxed/simple;
	bh=vmfw5bgy2DOgFTuYKyG6cQl9Abp6Os1alTQllCY5SJg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=kR15M+82ed3Ab5UUw+zm1LajysajXtI0gAvOkLpq6j/cevVKrIspowtnjqBgisj7hMfG2Ulltl+jiBoWp08tJVD/Febyd3MUiTO6dR/QhZthDIK3ssloe4l+iWgquzTZPulmw8HuoAyw2/OXmS9AWddI6SOGFNemQ4D+UUa35bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org; spf=pass smtp.mailfrom=cknow.org; dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b=kmzpxzoi; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cknow.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow.org; s=key1;
	t=1727741163;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OLYSl3uPz9uWh2oK2ezbGeqOKbGm3+dSSTg0u5EoJYo=;
	b=kmzpxzoi2vMTGjAcBTezW69XgEdjKsbGAG0UFu/ykgU6u1A45R+QPScqDAsCsNjx4DJgDn
	rlYDtQdnFfjBinz5lUj9jSDMjyDRjGUBZ2TCMdp1AFwS8AIPOxFosJQERnur8v9YH6BkNs
	bVlit91rf1xvhXmrqy6UhQ7t6ABMb/A7q4koWEM/LHyaoeRY41EvlVBjJ99HYiwRlAOY3j
	3HovYJJ7KduTdfppy1gXREgZFFjLSo63Xd5rvQ1L3G93udqmfkZbHaBQ6LuDth/JhhkGHs
	COON6C1Fn8uWAAwITmVCoWoUzdTBRUzZKMRblwng70VtTEAC95Sgsi127c6kDg==
Content-Type: multipart/signed;
 boundary=c4ca35aad4119c62b8c875a33b152758ce7c211678c87d53274b64774749;
 micalg=pgp-sha256; protocol="application/pgp-signature"
Date: Tue, 01 Oct 2024 02:05:48 +0200
Message-Id: <D4K14E2EOSC6.1VYBGSQKSIRW1@cknow.org>
Cc: <heiko@sntech.de>, <oss@helene.moe>,
 <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: (subset) [PATCH 0/5] Improve error handling in Rockchip SPI
 drivers
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Diederik de Haas" <didi.debian@cknow.org>
To: "Mark Brown" <broonie@kernel.org>, <linux-spi@vger.kernel.org>,
 <linux-rockchip@lists.infradead.org>, "Dragan Simic" <dsimic@manjaro.org>
References: <cover.1727337732.git.dsimic@manjaro.org>
 <172774028424.2264837.4595727034314147956.b4-ty@kernel.org>
In-Reply-To: <172774028424.2264837.4595727034314147956.b4-ty@kernel.org>
X-Migadu-Flow: FLOW_OUT

--c4ca35aad4119c62b8c875a33b152758ce7c211678c87d53274b64774749
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Tue Oct 1, 2024 at 1:51 AM CEST, Mark Brown wrote:
> On Thu, 26 Sep 2024 10:38:11 +0200, Dragan Simic wrote:
> > This is a small series that improves error handling in the probe path
> > of the Rockchip SPI drivers, by using dev_err_probe() properly in multi=
ple
> > places.  It also removes one unnecessary check of a function return val=
ue,
> > and performs a bunch of small, rather trivial code cleanups, to make th=
e
> > code neater and a bit easier to read.
> >=20
> > Dragan Simic (5):
> >   spi: rockchip: Perform trivial code cleanups
> >   spi: rockchip-sfc: Perform trivial code cleanups
> >   spi: rockchip: Don't check for failed get_fifo_len()
> >   spi: rockchip: Use dev_err_probe() in the probe path
> >   spi: rockchip-sfc: Use dev_err_probe() in the probe path
> >=20
> > [...]
>
> Applied to
>
>    https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-ne=
xt
>
> Thanks!
>
> [1/5] spi: rockchip: Perform trivial code cleanups
>       commit: d87ec94e48dd2da27fbe948f2dc6c8fedc98fff4
> [2/5] spi: rockchip-sfc: Perform trivial code cleanups
>       commit: 6c510eac1528d8939bad8b6df72c7b23ffec8c25
> [5/5] spi: rockchip-sfc: Use dev_err_probe() in the probe path
>       commit: 1482c40b440fa58f956bc3e1ef3426e0cdbc09e0

It looks like you applied some patches from v1 of this series while the
current version is v3.

https://lore.kernel.org/linux-rockchip/cover.1727601608.git.dsimic@manjaro.=
org/

--c4ca35aad4119c62b8c875a33b152758ce7c211678c87d53274b64774749
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQT1sUPBYsyGmi4usy/XblvOeH7bbgUCZvs83wAKCRDXblvOeH7b
bmmBAQC5Sqa/wMVjVF0L1VQOzUAOomq+fDixzHpirzQlQECPAQEApOOwS/CvnD+R
E/elHbuA0L+DfIavm489OHIApIpidAE=
=8ucX
-----END PGP SIGNATURE-----

--c4ca35aad4119c62b8c875a33b152758ce7c211678c87d53274b64774749--

