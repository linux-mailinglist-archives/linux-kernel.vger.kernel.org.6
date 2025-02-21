Return-Path: <linux-kernel+bounces-525055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2C83A3EA41
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 02:42:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5358E17767B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 01:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DFB284D2B;
	Fri, 21 Feb 2025 01:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="b5e5smDe"
Received: from sender3-pp-f112.zoho.com (sender3-pp-f112.zoho.com [136.143.184.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 118AE78F20;
	Fri, 21 Feb 2025 01:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.184.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740102121; cv=pass; b=XvsZN/UGUsFQ9Jk5btPnFfQiWDIRRiRb7MaM0KFBN0/RZiaoYq0R4Ufu+pNV/a6uikfVa4M8gZ5O9JaQJqnC0jkrTN7gnIaoGdlK3W/WYSxdBa7BOWg0Z8kQrqf9EKUXPa6H0T00tcC5HaUsi/+dp7nfUbQnmg4QKW8K+Ml0d/4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740102121; c=relaxed/simple;
	bh=u/drrcq0tRMW+dDu5EtV9HFVffzJAWHXL6OLPTF8o1s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F3ZqZRbTjzxd6CYe0Q5qpF/2E1IICpXaLNRAwge0pUukuBgCGhoXIhUFA3adlIzOsE+kErEaxtbdxyBUuDhColLENO4l6BcTpXJE/uaO49GxtmljAlzCTKkQt6JHSCZhpqEl1xi1BxA5rhoE1pGQ/LHC5lJoYAyh51V0f/USwTQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=b5e5smDe; arc=pass smtp.client-ip=136.143.184.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1740102106; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=H9BrAU7IWbxaMN4ydgJdpM6Seacug4G4FfwPIdl5NGiJxoE/bB1Fs5sggwZqTiEXM6EFONEobmcmytCdrD6Dt6nGB+qEFI33y2nSyov1OyLBHW+WnMKUL3xv7cYt2pxy3XSa1ZFmFaJEqJ2AcaIdeTKTXvR/h4pEGCJUcWb1G+8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1740102106; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=kjI9jH3577PL+Qw8lBXddzvXfssk10bWk7N+gsrE/Yw=; 
	b=ma3HnDiyVuwDTwbCRM1OIq56iWU8b6h3YqfO3BupHZwcrazdNIzyHkxfIp4Utoq05QMW2vvmaebwDFxU9RzUnkmVj++q60q2Fu50d/Ea/xor6cW9U2t5k9q9Yg3SQPcUZt78JWqDrfVui9Eyew7/YAKVwVlgKvf2TItY/0oR32A=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1740102106;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=kjI9jH3577PL+Qw8lBXddzvXfssk10bWk7N+gsrE/Yw=;
	b=b5e5smDeGD5pKB39CPlqy/lPuSs2aSRDjnktOk378gbrQAjDJA0fwdxrd4+LugAR
	mntbJTWjj3FAv0JILWP7GAMdarSfk4KE2iauBAd6VmgTz2V/VunB7DilBQOBw0KOGN/
	zJifTQxPIn4cuqWnw8fxvlabchf5+3ag/Uk6R+lk=
Received: by mx.zohomail.com with SMTPS id 1740102103663427.97041222656264;
	Thu, 20 Feb 2025 17:41:43 -0800 (PST)
Received: by venus (Postfix, from userid 1000)
	id 7F64F1835E9; Fri, 21 Feb 2025 02:41:40 +0100 (CET)
Date: Fri, 21 Feb 2025 02:41:40 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Heiko Stuebner <heiko@sntech.de>
Cc: mturquette@baylibre.com, sboyd@kernel.org, linux-clk@vger.kernel.org, 
	linux-kernel@vger.kernel.org, liujianfeng1994@gmail.com, cristian.ciocaltea@collabora.com
Subject: Re: [PATCH] clk: check for disabled clock-provider in
 of_clk_get_hw_from_clkspec
Message-ID: <yd2vhz2rivseulpbw34vhyei5sojz5w7ltnzwgtfn3ywwldgu6@nhktt6iztd4r>
References: <20250220225448.2763166-1-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="awhf732zrnbxpf5n"
Content-Disposition: inline
In-Reply-To: <20250220225448.2763166-1-heiko@sntech.de>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-1.4.2/240.10.19
X-ZohoMailClient: External


--awhf732zrnbxpf5n
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] clk: check for disabled clock-provider in
 of_clk_get_hw_from_clkspec
MIME-Version: 1.0

Hi,

On Thu, Feb 20, 2025 at 11:54:48PM +0100, Heiko Stuebner wrote:
> of_clk_get_hw_from_clkspec checks all available clock-providers by
> compairing their of-nodes to the one from the clkspec. If no matching
> clock-provider is found, the function returns EPROBE_DEFER to cause a
> re-check at a later date.
>=20
> If a matching clock-provider is found, a authoritative answer can be
> retrieved from it whether the clock exists or not.
>=20
> This does not take into account that the clock-provider may never appear,
> because it's node is disabled. This can happen for example when a clock
> is optional, provided by a separate block which just never gets enabled.
>=20
> One example of this happening is the rk3588's VOP, which has optional
> additional display-clock-supplies coming from PLLs inside the hdmiphy
> blocks. These can be used for better rates, but the system will also
> work without them.
>=20
> The problem around that is described in the followups to:
> https://lore.kernel.org/dri-devel/20250215-vop2-hdmi1-disp-modes-v1-3-819=
62a7151d6@collabora.com/
>=20
> As we already know the of-node of the presumed clock-provider, just add
> a check via of_device_is_available whether this is a "valid" device node.
> This prevents ethernal defer-loops.

if there is a respin:

s/ethernal/eternal

> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---

Also seems useful for having a quick final error if a referenced
clock node has not been enabled by accident during board bringup.

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>

Thanks,

-- Sebastian

>  drivers/clk/clk.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index cf7720b9172f..50faafbf5dda 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -5258,6 +5258,10 @@ of_clk_get_hw_from_clkspec(struct of_phandle_args =
*clkspec)
>  	if (!clkspec)
>  		return ERR_PTR(-EINVAL);
> =20
> +	/* Check if node in clkspec is in disabled/fail state */
> +	if (!of_device_is_available(clkspec->np))
> +		return ERR_PTR(-ENOENT);
> +
>  	mutex_lock(&of_clk_mutex);
>  	list_for_each_entry(provider, &of_clk_providers, link) {
>  		if (provider->node =3D=3D clkspec->np) {
> --=20
> 2.47.2
>=20

--awhf732zrnbxpf5n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAme32dQACgkQ2O7X88g7
+podzRAAkNsuxysuCLodNUxcjL0c9vFQxV8jdiLweph03XdvKKwY41xKHnXNyFJG
3gOsh0aYuPp6xbKrRj1FYfcvZKK8qA1I9r4xnamL3bBaMhzZSH2PSVqaBCzwrN5e
vs4sRbDtyB8DAPxdiJbb4IiTzUOY96bjeUfSuC2wL+vCg5FKBAg5vKTprqjHGFws
FrlcLdIb1I+/C7ETjC163wdWSsl82jIAeO54TvzJuPTXGEd2c4pP2JYuR8hxFQxC
4vcN93kmIOwjbCn/z0PKZO7znBDZWC+Czn0c4s5lWpGcP715/CNquCtJyjCTQQBR
5EYmWtMu17r2Df2oPqUsfvJH11fyT7Z0fmgt1hOnCxGtAws43/H10Q+rQL9k6VYd
ZNErNZJF7nuWu2RheUD5rhHyU61rOVbU3J0iiXNzNGD4NHvaPg125OAbL4cHyiMC
6tqzQxsdFakceBr5zK3c6vsqc6i1yGNhOPApd41MZmXelzg6rnAsuSsEDFMx8rb6
V/2dAMl6JfByoxTw+Elr9nZLsjzHQGGIH8K9DDYkMrorprTlIMFDShZXvszu2frR
yYJYIw5ECFcMSvlD76R/RxyTa1AIaVruuK5SZ1BH2mP1I2QEqr8jHsLegXfAKSMq
k1PB1xUYp4iII0ka5D3ovg7Bvc1AihGkuzutBm3BP4qrSShfxGA=
=5yO1
-----END PGP SIGNATURE-----

--awhf732zrnbxpf5n--

