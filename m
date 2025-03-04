Return-Path: <linux-kernel+bounces-544498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B53CA4E269
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 16:09:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D93823AF7A2
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 14:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8889525A334;
	Tue,  4 Mar 2025 14:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="kjcW9w3I"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E9E52080C5;
	Tue,  4 Mar 2025 14:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741099672; cv=pass; b=nR0ehfmxbg3qkT+I4bZ3jpnLnzusoq6Ih9bTg6Xkf/UK8hA9y4gQGkhB+7AKZf5h0vxb+2ThiGcbtAk6mva9WwG1njllG43/qt0o38CQ2YCc3Jd/mgsNOHVHQCUkzs0h5BYO3oTH1jhXpN4KUQphawcWU0UXlJYSn6tOOoubjmg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741099672; c=relaxed/simple;
	bh=FBW/wbqGE6qKOvggHh1NzxMyNtr49I6pXi/7InSK2m4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GpatCOh/mszJvPd5HWihlQABs8pTNR3P71BwL++mNUY7aZjnhnjI2wQQM/up9GQRJz+m9ArG9dLFpUBoi7yh2tB4fkbturdZCAHjSl39uGISwgeO8axIjA9vg/dnsdp7rIAV+28LN+jpj5O588BTG7QLuL/I09FfmFZ3YwSUoHY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=kjcW9w3I; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1741099653; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=adb7sgg7W9G+WDvOO09d4jcaENTOno7YdcbjC9pVT4sY7FR9Tb3zPgqP6RziVR/wG3z8nTGXZwJIZHhz9Sw0n/ksOEELfiI7DTfM0PS5ezJa6VgNQ8e6GIYjUhDTDu80uON1YeSSIU5bIIKzYrE6AaNdrJTZWXj/oOrJjvyAM78=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1741099653; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=BL1aGo1UGsl1J9JI77pZ/sTrD4utOFiYs1ftC/8yyg4=; 
	b=l8fNzl9coVm27bpuZ6LZy+V+CJ1n61t4YUftO5/3HKslVsGXE3l+RzmDhnQJskYzWWK1RB8k7K6KtjMvu115vji52yE0V8ZU55NjmDKsRgrLSjN/QJ6awpEa3kB4dACmFheTTnXhWK1VftCgI8gA8jUBIdlENBYpIJDEWshQcgk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1741099653;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=BL1aGo1UGsl1J9JI77pZ/sTrD4utOFiYs1ftC/8yyg4=;
	b=kjcW9w3I7J9pc6REZFBMM2H6k/AdSgvbzhnYxzyC+WRwKfjffElNS9xUx7qEN0IS
	Q1lmsHg2b9FDNnbMT1lRNY9paxdLZD+zTIuSJIYIP5KS7bebdQxL19Z70Ll3QRYuens
	pWmu6qdOEDs6ihkfNaGLlOIp7sMqUPfMZcvsj0rQ=
Received: by mx.zohomail.com with SMTPS id 1741099652409560.2440651683567;
	Tue, 4 Mar 2025 06:47:32 -0800 (PST)
Received: by venus (Postfix, from userid 1000)
	id D3A46180C9F; Tue, 04 Mar 2025 15:47:28 +0100 (CET)
Date: Tue, 4 Mar 2025 15:47:28 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Andy Yan <andyshrk@163.com>, heiko@sntech.de
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
	detlev.casanova@collabora.com, linux-rockchip@lists.infradead.org, 
	Andy Yan <andy.yan@rock-chips.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/3] Add display subsystem dt node on rk3576
Message-ID: <lfmhqurnpjmfy6pfjxd5aczxujislv2p5bsurcbl7capyt7zv3@hy2twvjj53uz>
References: <20241231095728.253943-1-andyshrk@163.com>
 <173564980410.21979.2947276365464229762.robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vffz2usgeazstqu2"
Content-Disposition: inline
In-Reply-To: <173564980410.21979.2947276365464229762.robh@kernel.org>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-1.4.2/238.671.54
X-ZohoMailClient: External


--vffz2usgeazstqu2
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 0/3] Add display subsystem dt node on rk3576
MIME-Version: 1.0

Hello,

On Tue, Dec 31, 2024 at 06:57:21AM -0600, Rob Herring (Arm) wrote:
> On Tue, 31 Dec 2024 17:57:17 +0800, Andy Yan wrote:
> > As the VOP[0] and HDMI[1] driver have already been submitted for review.
> > This series enable hdmi display on sige5 board.
> >=20
> > [0] https://lore.kernel.org/linux-rockchip/20241231090802.251787-1-andy=
shrk@163.com/T/#t
> > [1] https://lore.kernel.org/linux-rockchip/20241231094425.253398-1-andy=
shrk@163.com/T/#t
> >=20
> > Changes in v3:
> > - Split from https://lore.kernel.org/linux-rockchip/3330586.aeNJFYEL58@=
diego/T/#t
> >=20
> > Andy Yan (3):
> >   arm64: dts: rockchip: Add vop for rk3576
> >   arm64: dts: rockchip: Add hdmi for rk3576
> >   arm64: dts: rockchip: Enable hdmi display on sige5
> >=20
> >  .../boot/dts/rockchip/rk3576-armsom-sige5.dts |  47 +++++++
> >  arch/arm64/boot/dts/rockchip/rk3576.dtsi      | 126 ++++++++++++++++++
> >  2 files changed, 173 insertions(+)
>
> [...] (a bunch of warnings due to dependency patch series not yet
> being in linux-next)

I think all dependencies have landed now. But it might be sensible
to do a quick resend considering how old this is.

Would be nice to have initial RK3576 HDMI support in 6.15 :)

Greetings,

-- Sebastian

--vffz2usgeazstqu2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmfHEnwACgkQ2O7X88g7
+ppiuQ//RRlo86q9NugSNDg67poxQpr1XjF9rHdkD08Ma9XBfTSHA8yiRRtS9mKn
hc5+pEzsSrX4gGGgcaYq54YYnZ0L7JXFrkU6uNUjJeTvpibn8pUT9/yRqqDO3vcS
oebj2VbqEN6EbHbe7MTH3qGVtS8L08xLJicxJtDLJyvD7AXMg0H6JeISDS1YAq4V
Del4q56LSDSC1lv4IYkzh0Va8bWQ4cn5b9JR3YPbS+LU9N7saSyG6Q6ZMXhWSZ36
LGiKPrUFtFMeJQRJL2LcmqppsR1KH3i5oGMlNYr8FYY36VI7Js1si9BUE9nAdPBJ
EK5W9hnbO7wyv2Kx6SD5/pqAWw8Jy+XEv0tMzgIZUFnuGiBYXwjJT6yeQH+EABxA
P7TDJBMrLiCrs9YUSx+KT48MRWT1lM0GDrEMRjC0aTbmQL7+3hQ9M0DA+g8mPBlf
ORdraLCzcG+DCL8wX+WJhXuA2WUCx8i97Ku/Jw7SYlAsaIner+QxrApd7LBy3aUb
FtcJhfg+A3aeyNQh+8PZmXC2Pgw2pyiBrnqll8NBzqPoCz25wM5RQT868n5gzg1q
/sdHawvguhRlpisMpxCtvTa06xIL84klcvaOxVoOaytDMk3edhCyOh7vST7kEIb5
9EmZCjMbpp4xFaZIDxkxmhXFzWfKvvcDefp7EFLdz/eZQQsDoq4=
=vW2j
-----END PGP SIGNATURE-----

--vffz2usgeazstqu2--

