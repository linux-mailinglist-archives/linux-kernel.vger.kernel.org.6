Return-Path: <linux-kernel+bounces-307119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BB2796488E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 16:33:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48E591F21B00
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 14:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 506151AF4E3;
	Thu, 29 Aug 2024 14:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=detlev.casanova@collabora.com header.b="kbmEBoKk"
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F9316A931;
	Thu, 29 Aug 2024 14:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724942010; cv=pass; b=KvDSSAUb5YrxljoQmwF5jKDnjors8rQ5MZ65q9WdLE9Tq7k2OKTyhhSAvxw7yfQYADFT1hxp69kuBvdqoaYgnktKSjifn7ZaVGzgVH23uZs3DIMI3Q2LpTsKvZCUO0qZrNNRDw1+TSyrGwjPod9+L4lsSaiiRruAJVlsYcFVfxA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724942010; c=relaxed/simple;
	bh=79g6wzVHWxuIS4vbKAR4WZIBjs/ix7ihVs4GmG2HFz0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cPgWMbakRtRdVCRgOQ5b70y+tT2a3s2TADymIQELtXYcBKCsfHO4OfsN9os5+5EFeJGY5KKme4VetvGe7L+Xkc+icZQDJyR7L4aRlxXEI5GdA39VsIjkMudBZS0j4eLHR8JZ+WkCW+MmC4aarPGy5XyktdZrVHyiD4+/bdouU5E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=detlev.casanova@collabora.com header.b=kbmEBoKk; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Delivered-To: kernel@collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1724941982; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=U4R+g1V33H2IEPO8IV8CQYJuZE1R4hj+pYK1gV82v14y9txfyhdnkfl3SqRvZq0te59uKXZV7zIspCNGrtS01Un3QHMtUnAJOrxjoDHyEpzZoU/J4tjnNbO+KM0I6Jz00Jxhrlj/EItGiPnrA2JzAjQgzfwMWbmM3dhjGLr2EIc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1724941982; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=jQ1p6/xWG9wPSPmBp6CqV03Yn+MZ5TccQldtwHM5cGQ=; 
	b=XOIcr6p1KDF+uCwvgEs76GQ0HZNVWzNuJzfogOzw700Jqr1JoWawetj71k0SZKw8aJRmFwLQRzdZ2W4l7XnwtMRDjNIG+CAOsyE/TeDHChqtZCKwehrml+k9vQPBLUvmKjRKo7G7k5wcMpmaiTW5YpwOV2s10f1lvlm3a/N2o3U=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=detlev.casanova@collabora.com;
	dmarc=pass header.from=<detlev.casanova@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1724941982;
	s=zohomail; d=collabora.com; i=detlev.casanova@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
	bh=jQ1p6/xWG9wPSPmBp6CqV03Yn+MZ5TccQldtwHM5cGQ=;
	b=kbmEBoKkt8cOIiPVZG0YMrcRUgQfy/DpKs1BQ/9n/RLWWHOs4ExoKyAbBJ2hgmHo
	wGZ6Yoyqu6Y1CkR6VuBVe3caoO5JpJemd1lPC1qfv1AWcaxl370Frwixf0UlZ0kJ/yh
	eAC3nWD5yaR594qYuIuq41Yi194bhR61nQQPEod4=
Received: by mx.zohomail.com with SMTPS id 1724941980408747.3126115905559;
	Thu, 29 Aug 2024 07:33:00 -0700 (PDT)
From: Detlev Casanova <detlev.casanova@collabora.com>
To: linux-kernel@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>,
 devicetree@vger.kernel.org
Cc: Rob Herring <robh@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>,
 Elaine Zhang <zhangqing@rock-chips.com>,
 Sugar Zhang <sugar.zhang@rock-chips.com>, linux-rockchip@lists.infradead.org,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>, kernel@collabora.com,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v7 1/3] dt-bindings: clock, reset: Add support for rk3576
Date: Thu, 29 Aug 2024 10:34:50 -0400
Message-ID: <5809907.DvuYhMxLoT@trenzalore>
In-Reply-To: <172492351370.1695089.7443506809997782331.b4-ty@sntech.de>
References:
 <20240828154243.57286-1-detlev.casanova@collabora.com>
 <0102019199a76766-f3a2b53f-d063-458b-b0d1-dfbc2ea1893c-000000@eu-west-1.amazonses.com>
 <172492351370.1695089.7443506809997782331.b4-ty@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-ZohoMailClient: External

On Thursday, 29 August 2024 05:36:47 EDT Heiko Stuebner wrote:
> On Wed, 28 Aug 2024 15:42:50 +0000, Detlev Casanova wrote:
> > Add clock and reset ID defines for rk3576.
> >=20
> > Compared to the downstream bindings written by Elaine, this uses
> > continous gapless IDs starting at 0. Thus all numbers are
> > different between downstream and upstream, but names are kept
> > exactly the same.
> >=20
> > [...]
>=20
> Applied, thanks!
>=20
> [1/3] dt-bindings: clock, reset: Add support for rk3576
>       commit: 49c04453db81fc806906e26ef9fc53bdb635ff39
> [2/3] clk: rockchip: Add new pll type pll_rk3588_ddr
>       commit: e781bffc296766b55dbd048890d558655031e8d1
> [3/3] clk: rockchip: Add clock controller for the RK3576
>       commit: cc40f5baa91bb7b031f5622e11a4e443cb771527

Awesome !

> general remark, please take a look at your mail setup.
> Amazon seems to break the generated message-ids.
>=20
> Your cover-letter is
> =20
> 0102019199a75f9b-aab57db6-806a-474b-8295-e5be5a99d424-000000@eu-west-1.am=
az
> onses.com
>=20
> while the patch (1-3) mails say
>   In-Reply-To: <20240828154243.57286-1-detlev.casanova@collabora.com>
>=20
> So that amazon thing somehow broke the message-ids in your mails.

Yes, sorry, we are working on that. Recent switch in email setup and still=
=20
figuring out all the issues :/
=20
> I've also dropped the whole module part.
>=20
> As always that Android GKI madness was cause for issues.
> The driver claims to be buildable as module, but it looks like nobody
> tried that:
>=20
> First build-failure:
> --------------------
>=20
> ../drivers/clk/rockchip/clk-rk3576.c:1800:36: warning: =E2=80=98struct
> platform_device=E2=80=99 declared inside parameter list will not be visib=
le outside
> of this definition or declaration 1800 | static int clk_rk3576_probe(stru=
ct
> platform_device *pdev)
>=20
>       |                                    ^~~~~~~~~~~~~~~
>=20
> ../drivers/clk/rockchip/clk-rk3576.c: In function =E2=80=98clk_rk3576_pro=
be=E2=80=99:
> ../drivers/clk/rockchip/clk-rk3576.c:1802:38: error: invalid use of
> undefined type =E2=80=98struct platform_device=E2=80=99 1802 |         st=
ruct device_node
> *np =3D pdev->dev.of_node;
>=20
>       |                                      ^~
>=20
> ...
>=20
> missing platform_device header
>=20
> Second build-failure, after fixing the whole module madnes:
> -----------------------------------------------------------
>=20
>   MODPOST Module.symvers
> ERROR: modpost: missing MODULE_LICENSE() in
> drivers/clk/rockchip/rst-rk3576.o ERROR: modpost: "rk3576_rst_init"
> [drivers/clk/rockchip/clk-rk3576.ko] undefined! make[3]: ***
> [../scripts/Makefile.modpost:145: Module.symvers] Fehler 1
>=20
>=20
>=20
> So when applying the series, I simply removed the whole module-part and m=
ade
> the init look like rk3588 for now.
>=20
>=20
> Somehow I always get the impression the whole "clock as a module" thing
> is just there so Rockchip can ship something completely out of tree on
> Android devices.

Mmh, I'll more careful with that, but indeed, I did not try building the cl=
ock=20
driver as a module.

> Best regards,





