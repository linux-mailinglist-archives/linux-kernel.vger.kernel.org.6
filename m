Return-Path: <linux-kernel+bounces-519597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94E87A39E70
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 15:14:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FA47188D71D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 14:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C4C1269D04;
	Tue, 18 Feb 2025 14:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="PUo5Z3Qc"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB000269B09;
	Tue, 18 Feb 2025 14:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739888032; cv=pass; b=byr5twpToDdvWHa+cyo/0zMqLHo8EeqyAzxAxhrvk7XJsl94MPAgEKjkcErPQuqxdaDuFqx+f4Yn5XqbxveqmDuGCP02DBT1vycD2M9ZbnFREqXd5qPlIxUDs+Os0dYqBaSjPRgMQ0xsoL9HFSZhmRlhpb3oUnR8b9jEvBsPKCI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739888032; c=relaxed/simple;
	bh=orvdZ6rfos7GHWYAa4az5hgohkFnpmixbGo7NhY6zxo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LRxE60D/y6RStZIdcA7xFOlF/NzTIwCDIGAGpOn1jO3lkPWLfSlx50+i70T04E6bngjzrGjBjHC+RNSvk6J7gLxWvasRihgYu/k7m2RqeQf0aWxqCKX7bL+h+0BcNI7DKgCIFKxEUGp2MwPjA6zQ35Lr4rac0s8BwtyWexKPKag=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=PUo5Z3Qc; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1739887995; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=GvMQldWV3zNgBH0W1WQvTV8ETdM7NjWiixES/hCNbEbWpo78JVr5nrJbPx/dsf/GWa1ud+2Thg1RhhMQ/X4ZmXNHf0Ct+fItEOeT6sdoJLdhVyqTzmIe188zbK6CDHY6oDlr4UyCb4UfyYtyYfo10bAbkLV9ni3Ezw2jgcwyVyY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1739887995; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=+UEs0On8LdgTczquU0moZNxa98iW4ahd2cBsmI73D/k=; 
	b=MdIgTvEw5k8KrW8JpKdP3ijIX1JKsCNbPxl9vRMfI1dvLGuXK6S4aO2zSHTJuWY7PPKKKQWNf7rxddEZeLPBeK32p5v4IpDxy0H6urK+C3Vm9mJn2iVZl9ata9dCyvTHeB13nrLj6JoXTQh2SSdlz+HiVw8/naPGoRNqsHvhb+Q=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1739887995;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=+UEs0On8LdgTczquU0moZNxa98iW4ahd2cBsmI73D/k=;
	b=PUo5Z3QcF+6AH59D1QNdQe5VkQguLbMqTY9hdzKRFuNNB245eOt/j0+ykI6PrMUn
	lCjpCiwPNdz6h6QC0mLFDBC0E8lEvLJZEO0jHq2Sllmsjgugn4KxE/t33h9t75sujOi
	R9nNN51+10++GajS7Ky2DVvKOfl0db9FLfHyX17I=
Received: by mx.zohomail.com with SMTPS id 173988799275793.35650379360004;
	Tue, 18 Feb 2025 06:13:12 -0800 (PST)
Received: by venus (Postfix, from userid 1000)
	id 6CA8F1807FB; Tue, 18 Feb 2025 15:13:07 +0100 (CET)
Date: Tue, 18 Feb 2025 15:13:07 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Jianfeng Liu <liujianfeng1994@gmail.com>
Cc: heiko@sntech.de, airlied@gmail.com, andy.yan@rock-chips.com, 
	conor+dt@kernel.org, cristian.ciocaltea@collabora.com, devicetree@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, hjc@rock-chips.com, kernel@collabora.com, krzk+dt@kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, robh@kernel.org, simona@ffwll.ch, 
	tzimmermann@suse.de
Subject: Re: [PATCH 3/4] arm64: dts: rockchip: Add HDMI1 PHY PLL clock source
 to VOP2 on RK3588
Message-ID: <lnuceofdwm6lgibworaghcujp6rrncvn4e2xc2vzltimjw3rqu@jur7x5cxt5ue>
References: <1919367.CQOukoFCf9@diego>
 <20250218121749.1382322-1-liujianfeng1994@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tg65zwayhilbnpfx"
Content-Disposition: inline
In-Reply-To: <20250218121749.1382322-1-liujianfeng1994@gmail.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-1.4.2/239.824.9
X-ZohoMailClient: External


--tg65zwayhilbnpfx
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 3/4] arm64: dts: rockchip: Add HDMI1 PHY PLL clock source
 to VOP2 on RK3588
MIME-Version: 1.0

Hi,

On Tue, Feb 18, 2025 at 08:17:46PM +0800, Jianfeng Liu wrote:
> On Tue, 18 Feb 2025 11:00:57 +0100, Heiko St=FCbnerwrote:
> >So I guess step1, check what error is actually returned.
>=20
> I have checked that the return value is -517:
>=20
> rockchip-drm display-subsystem: [drm] *ERROR* failed to get pll_hdmiphy1 =
with -517
>=20
> >Step2 check if clk_get_optional need to be adapted or alternatively
> >catch the error in the vop2 and set the clock to NULL ourself in that ca=
se.
>=20
> I tried the following patch to set the clock to NULL when clk_get_optional
> failed with value -517, and hdmi0 is working now. There are also some
> boards like rock 5 itx which only use hdmi1, I think we should also add
> this logic to vop2->pll_hdmiphy0.
>=20
> @@ -3733,6 +3751,15 @@ static int vop2_bind(struct device *dev, struct de=
vice *master, void *data)
>  		return PTR_ERR(vop2->pll_hdmiphy0);
>  	}
> =20
> +	vop2->pll_hdmiphy1 =3D devm_clk_get_optional(vop2->dev, "pll_hdmiphy1");
> +	if (IS_ERR(vop2->pll_hdmiphy1)) {
> +		drm_err(vop2->drm, "failed to get pll_hdmiphy1 with %d\n", vop2->pll_h=
dmiphy1);
> +		if (vop2->pll_hdmiphy1 =3D=3D -EPROBE_DEFER)
> +			vop2->pll_hdmiphy1 =3D NULL;
> +		else
> +			return PTR_ERR(vop2->pll_hdmiphy1);
> +	}
> +

This first of all shows, that we should replace drm_err in this
place with dev_err_probe(), which hides -EPROBE_DEFER errors by
default and instead captures the reason for /sys/kernel/debug/devices_defer=
red.

Second what you are doing in the above suggestion will break kernel
configurations where VOP is built-in and the HDMI PHY is build as a
module.

But I also think it would be better to have the clocks defined in the
SoC level DT. I suppose that means vop2_bind would have to check if
the HDMI controller <ID> is enabled and only requests pll_hdmiphy<ID>
based on that. Considering there is the OF graph pointing from VOP
to the enabled HDMI controllers, it should be able to do that.

Greetings,

-- Sebastian

>  	vop2->irq =3D platform_get_irq(pdev, 0);
>  	if (vop2->irq < 0) {
>  		drm_err(vop2->drm, "cannot find irq for vop2\n");
>=20
> Best regards,
> Jianfeng

--tg65zwayhilbnpfx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAme0lWwACgkQ2O7X88g7
+prO+w//ckt6/RZRkNYrf65IAuN+VTaPRXyXi81rOGKz/OB7Tk8bKiD1vzLkzwJ6
r0gE1W3oFIcW+mk1nCDf+CdUGqZIi1Fg/j3AmMkeRmrjW6goOpQUfpYtv0kTO696
/Ft3oL45Bw9IozPVM3rUhVyVjBjjXT2I+Hzh5FdAzv1QV1yju6gHViAIumtc8qoW
GZIvTy5Yr9w5+p3c7+r3CVwN/BboYDNcHka9L43y6MHN3sZownPoOYWEqrHJs7YU
jgPKjceBbJQkgy6vaX/TtrZVRP7Z6KLz4/EBSVcjDeR5lpWLEQ2M5UjiYJfbSPPl
nn0Edm40uNUAvmCe1Z/stz1Uym8IRZbCJetJix7FNWiPjMCyf1a4cQVq9ymOamWN
xc0DjB/pMg4tdf4v0bJ14HgaGxhJbm8InMNWLDMDCx/BqRptN+8xbuC4V4Oqh8GX
CVayUBfL2xRVE0M7z0zcvKvWiMD0wvuAEABKrxxlptEAJ4Di/uDnKNkrb0Em8FMk
0iDe4iIQBoZpPraGzH7vhvpBbQZhHjl6jIdIJiGPsat4H0/Yl2lZI26yXktinw5C
ae5U9Ez4zN29o51A4cuGeoJDBFRsl5xqALCfzp/LCe+Hf5hua8V6HIx564WsRcpA
WFzh3h3S0QuRmhRw0kPbRKXE9MdXykY8WkevvyFm4gGDLQ7gDrI=
=Pg8x
-----END PGP SIGNATURE-----

--tg65zwayhilbnpfx--

