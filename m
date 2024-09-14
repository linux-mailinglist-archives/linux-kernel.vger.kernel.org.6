Return-Path: <linux-kernel+bounces-329190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3AA8978E81
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 08:49:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92212288EC0
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 06:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 855AF1CCEF6;
	Sat, 14 Sep 2024 06:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="CYolCl4b"
Received: from sender4-op-o14.zoho.com (sender4-op-o14.zoho.com [136.143.188.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2988C14B06E;
	Sat, 14 Sep 2024 06:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726296556; cv=pass; b=Il5RQoCxyeYkN2sv5QJsIV8X2pzmxWRt9ehrY8Y6MJGeR8wkG2fqwpbJBPpyShtLHSBayyeQZS0hxbeRarl/M5ZsILdlV5PbFKK9tm3erRqpUzXEmCWMOit8gnl7wZB3gSifpa4P5gBNVRuf6LR616mcKZ2Ym8hJZjgjx2PbY4U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726296556; c=relaxed/simple;
	bh=LxLl+jt6a1cFarK/A7F3eLTkaLDjBwNcMoQXNDKPga4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h0K+AyRQf4bE4EZ5SjJ+RcK1i+EUQyVEJPRciJ02UEJnFhCnHvwWrPpxNUsbaJMXASYbrKzJhFzdsFTZBHpnlrMcspE9xhzjmN3tzBGlatsW2QTipmbPwlCUxmge35VE4d8U0kNOHNF6U/qHSkT9qN5p3zPVNHgfIAvm6QzNeuo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=CYolCl4b; arc=pass smtp.client-ip=136.143.188.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1726296544; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=RcTWi4xf8yqOXR/pufhdq1HnW6R5fgVpKkkpetfTbOql4nqJxC9rPdWmo5fBpgtlXS7R6JcH0rY7r3KIBQQLCaS9dMQgvtZIsLQCd76zNWLfYfwv//Ig0/DS8m9pUKdXkIU1pk8UMgVdkpALn1CfW5kgwnFB0g3DmyyzrJ/3Dgs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1726296544; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=RgXdvaPZb4LTwePNyALjB+9zqhsamJvle0AcX7j8Ed0=; 
	b=U32uIjrtBUhl+a7moY8GJG2ZJ53HvHUYpy2bLLaUQxWMY4+c/lAAZreXNZv2HCvNcEQyyVJHDXRzvqdLTk9mG9RoCsnaoqFp4/1SjJ4kGuuWCD0bnHacIIrNN0y0CaoGWNKhm7/wNB+p09KJX2xdOnheMQ4C6DMqkFn4mK7IKtw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1726296544;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=RgXdvaPZb4LTwePNyALjB+9zqhsamJvle0AcX7j8Ed0=;
	b=CYolCl4byS04MLUwtRGfHuOepe52c97yxFkD1zSwHJGdwP8mXZ8c6+SPNLEbwEEK
	5OAltc7NxV+IGaYa5ykMJ2or5YeeNC2tcytWxU+f+jdsJ3WtdzZnHAp9Y3WYwjcvNNN
	GgSrAKYJ3iIv/zbnkkpQ1G4GHkXmEJ7owS52Rp6U=
Received: by mx.zohomail.com with SMTPS id 1726296542003336.1673560833053;
	Fri, 13 Sep 2024 23:49:02 -0700 (PDT)
Received: by mercury (Postfix, from userid 1000)
	id 417051060578; Sat, 14 Sep 2024 08:48:53 +0200 (CEST)
Date: Sat, 14 Sep 2024 08:48:53 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Heiko Stuebner <heiko@sntech.de>, Yao Zi <ziyao@disroot.org>
Cc: Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: rockchip: fix finding of maximum clock ID
Message-ID: <fmfvorsje7fjto3c4bwyqxsa6xrs234xlse4whcsu3ebm3lrvs@oyppckftaeok>
References: <20240912133204.29089-2-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5qfaa5s3wvu2phrp"
Content-Disposition: inline
In-Reply-To: <20240912133204.29089-2-ziyao@disroot.org>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-1.3.1/223.982.64
X-ZohoMailClient: External


--5qfaa5s3wvu2phrp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Sep 12, 2024 at 01:32:05PM GMT, Yao Zi wrote:
> If an ID of a branch's child is greater than current maximum, we should
> set new maximum to the child's ID, instead of its parent's.
>=20
> Fixes: 2dc66a5ab2c6 ("clk: rockchip: rk3588: fix CLK_NR_CLKS usage")
> Signed-off-by: Yao Zi <ziyao@disroot.org>
> ---

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>

oops, good catch. Note, that the function returns the correct value
for RK3588, since the clocks with the highest IDs are of GATE_LINK
type and do not have their child field set. I have not checked all
the Rockchip SoCs converted for 6.12, so I suggest sending this as
fixes material for 6.12.

Greetings,

-- Sebastian

>  drivers/clk/rockchip/clk.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/clk/rockchip/clk.c b/drivers/clk/rockchip/clk.c
> index 73d2cbdc716b..0972e9f87470 100644
> --- a/drivers/clk/rockchip/clk.c
> +++ b/drivers/clk/rockchip/clk.c
> @@ -439,7 +439,7 @@ unsigned long rockchip_clk_find_max_clk_id(struct roc=
kchip_clk_branch *list,
>  		if (list->id > max)
>  			max =3D list->id;
>  		if (list->child && list->child->id > max)
> -			max =3D list->id;
> +			max =3D list->child->id;
>  	}
> =20
>  	return max;
> --=20
> 2.46.0
>=20

--5qfaa5s3wvu2phrp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmblMdEACgkQ2O7X88g7
+pqCcQ/7BBOlOBVuqXxJ7PhV3mZkLax8DMG6MNac+iOSnSf4BXmPaOZHU1JE8fPh
7T2/O3yNA6M6CfmCMwomZ/3JXRdNadPV2lAo+EERHf7FgV2KL7peadkIrEHf/Aqp
gvaEun29rO5iY4bYrKaEgxt02u5Oq5fws7gdcv1mB6Vk+Bg2pNes1iwxIRHJVv+r
VnKpK2bHEzxBr4Xaft3PUfFsx+qedzaLPemicyzN++TqnlFPLFdzQm+rjA1G3sr8
OQR7USdeym/StJs5IjEI/ymW/fK1HG0qtC8HG5O+we+CtIQDmPM8XrWe8dox0y21
m2R/tChp/PAGtoXOnBtnUZ6YtNk/JZg5TRkEfPbeJncVlHg+Gb1acEnxLET82MRq
qhKeaqzUzCf0PHttjRNrhldgZC2MQjzfecF/a0XJqawy/4Z/5jOH8YdyKzUck8W9
+diEkTb1AhfL9PX6ym5J0qONSkn86dp8H7tXh9MNQ5iq14joInbBSvR6nPxr9EPm
l+m046WRN+knsFDi2zliLzYX9iTTU8sGxhMj8199cMhpVLKxVwFSPL6m9azJxqbi
AGQWO6s9ngM23lDVbnfn5JWCfulMx4Nj9fciHMUDcYEduFB0FKkTi5GnR8fKnz6q
roDKiyVhzHmxSmu+9MZ6myzrzPrZdBELn1XQmu5N9UBP92i/Yug=
=LiYC
-----END PGP SIGNATURE-----

--5qfaa5s3wvu2phrp--

