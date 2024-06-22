Return-Path: <linux-kernel+bounces-225630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8172913315
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 12:55:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 150E01C2132B
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 10:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8AE814F106;
	Sat, 22 Jun 2024 10:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jVPLaRtE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142474A20;
	Sat, 22 Jun 2024 10:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719053702; cv=none; b=UvVzsbMOR8Bt5lgz/ZQZZ4fjCr/DWUj74Us6I0O3Q008kgyHktXlEOBFhGpd8a973O7/rEUO5FfB1CeG9EB8d5n5N8ZddT8jU+qUxfQ/ZJriednTpkKE6/WIAQnGmK8P5RkGoOi//O8kkj9j3buykkRaozfqutlsI17NN53NvrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719053702; c=relaxed/simple;
	bh=ghRmvrEvOiSialvO++pAQ6nMBlo3rUttQzCbac/3M9E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y8ZBYHT/WPqmhGtRFvBgtkIlJiN92wxI1ve2M0PSypBMO63GCWLd3HaZoLIGQws9Ss4EJYEFOpEGJnPSFtf6AzjS42aENqvxwGg+nc5c7CopS+zIJr6bfHSR/t8H1lyCo4D5Msv3CuhJqhGVME9e9XOmOjQ2Z2vj5J2nNdO7VZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jVPLaRtE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6992BC3277B;
	Sat, 22 Jun 2024 10:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719053701;
	bh=ghRmvrEvOiSialvO++pAQ6nMBlo3rUttQzCbac/3M9E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jVPLaRtEMB2WxiNMXNI0hN0UYthBTuasNsnxhuzzbCSs5FEynmOS6P+J2f3uvYU6x
	 CfrTSa3OzL6712Gl/ArCkvIAsyjKVj8PwI3EHJoHtmIfYKR9KpxQ6qhvm6TtlxnW/N
	 WJOgmLqLv3vD4NiCxAXXzl/8YjbWvxdGOJtCB2GwbUSwDicDSx0qJ0I+yoWcSiHaK7
	 eJ9XovAzVq4AzhLTLD2S80/ErkaNT7fAmzVkWpPVnl0+QN4wxB4cPeP8wKXhwuL+1R
	 2MB14/ClFVmfWi1ZBoiT8rnwLyyDwG1K5JT1HFIBb6GTAWoVnVVVUAO4eRp06F9IIY
	 aMR9GwiJbvdcg==
Date: Sat, 22 Jun 2024 11:54:56 +0100
From: Conor Dooley <conor@kernel.org>
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>, Chris Zhong <zyw@rock-chips.com>,
	Zhang Qing <zhangqing@rock-chips.com>,
	Chris Morgan <macromorgan@hotmail.com>,
	Furkan Kardame <f.kardame@manjaro.org>,
	Michael Riesch <michael.riesch@wolfvision.net>,
	kernel@collabora.com, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/5] dt-bindings: mfd: rk817: Merge support for RK809
Message-ID: <20240622-error-ignition-48cc0708d466@spud>
References: <20240622-rk809-fixes-v2-0-c0db420d3639@collabora.com>
 <20240622-rk809-fixes-v2-2-c0db420d3639@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="H/Lq+AIgICuNFnwA"
Content-Disposition: inline
In-Reply-To: <20240622-rk809-fixes-v2-2-c0db420d3639@collabora.com>


--H/Lq+AIgICuNFnwA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 22, 2024 at 12:57:19AM +0300, Cristian Ciocaltea wrote:
> The Rockchip RK809 PMIC is compatible with RK817 and provides the same
> capabilities, except for the battery charger manager.
>=20
> There are also minor regulator related differences: BOOST and OTG_SWITCH
> are specific to RK817, while DCDC_REG5, SWITCH_REG1 and SWITCH_REG2 are
> provided RK809.
>=20
> The current binding for RK809 doesn't document the audio codec
> properties, although it has been already in use by several boards:
> rk3566-quartz64-b, k3566-roc-pc, rk3568-evb1-v10, rk3568-lubancat-2,
> rk3568-odroid-m1, rk3568-rock-3a.
>=20
> Therefore dtbs_check fails for all of them:
>=20
>   DTC_CHK arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dtb
>   rk3568-rock-3a.dtb: pmic@20: '#sound-dai-cells', 'assigned-clock-parent=
s', 'assigned-clocks', 'clock-names', 'clocks', 'codec' do not match any of=
 the regexes: 'pinctrl-[0-9]+'
>     from schema $id: http://devicetree.org/schemas/mfd/rockchip,rk809.yam=
l#
>=20

> Additionally, the example in rockchip,rk809 binding is not able to
> actually test the schema since it uses a wrong compatible
> 'rockchip,rk808' instead of the expected 'rockchip,rk809'.

lol

>=20
> Instead of duplicating even more content, merge the RK809 support into
> the more inclusive RK817 schema and drop the now obsolete rockchip,rk809
> related file.
>=20
> Fixes: 6c38ca03406e ("dt-bindings: mfd: rk808: Convert bindings to yaml")
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

--H/Lq+AIgICuNFnwA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZnatgAAKCRB4tDGHoIJi
0qCLAP9g1jex2+EZ8w+nDXCv9TyqgSCBxRQjgB2Yk52nfJqShwD/dH6EOwuSEix/
r9MXBGao3Vjytvfs79mzQZB3FFSXawA=
=uadC
-----END PGP SIGNATURE-----

--H/Lq+AIgICuNFnwA--

