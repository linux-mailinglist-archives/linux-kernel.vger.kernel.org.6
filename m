Return-Path: <linux-kernel+bounces-519305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9CBFA39B54
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 12:45:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9437D3B43C1
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 11:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41BC822D4C3;
	Tue, 18 Feb 2025 11:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b="ZX3Yoy1h"
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B99122E00E
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 11:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739879150; cv=none; b=hitXPefaqD3bx57n7pIHqtaB5SbjC/kYsufBJiAd3U3I0PTR9l7ZHVaYuuXokUng7acFLOAX63WDsg5cR5Ye/M+vcoyzKI2oeedly6QHmXQfxp7a2q1ZDMpYHLw1TseTtdh8Uv7WrhzdA/mlajJ8ETFgfjK3mbD6IkfCu8emi1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739879150; c=relaxed/simple;
	bh=biSmkjdSDhlpZN/I7l/DOYkVG93NJtI+LINfMs20WxQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=TYsNQXG5Evtx5czgEu2J/DYneg4kdxwHRU4SZXyFGIrh9iVWp1H7q2EdHTgsvWo6q0LHJd9/g3FkBsxBkJVd/VJC8Z/Y4IXI9CC0UsgVQQ6RjWAO1oGvTMWtMdflQBNgKb8MeTWKg14KpuIEZBeFdVHp12iYMowuV15xswQ8ilY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org; spf=pass smtp.mailfrom=cknow.org; dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b=ZX3Yoy1h; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cknow.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow.org; s=key1;
	t=1739879143;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iRTNT+VF0BGjlKwvapjWppDo17j+1iwhkQPE23/uMVo=;
	b=ZX3Yoy1hXUuD/+bt2TDsEfH9YNFyiuE1hX3gIbcpAC9o8USRJ5Li6rm7ZNk+R4Dw4VMfNU
	DlJIFuiVnBIa4sM2wBQ3W8Sh8uesjMI6rq244GrrMuk/nJNQqPNgie1HPW0D0iUHs12vQU
	lq2FCMy6RLxs0eyyGg90bKfbW7E0c6RPyyiEcjRbTvuhHs3GNK1GOX+z3p31ueTyqvMcAd
	ERpiUk7Cmbii1XDuH/YkYQfPOaZ0vILGoTEEtoAxLZ2+gg+x4zjhV28MnyIJWihL1HbvRe
	R5194W54/SZCartzQcvVv6CRKHnhrrBo//MnCxCqcUXt9Td1E/LRcwRaH2XRGw==
Content-Type: multipart/signed;
 boundary=f698ee32381bf21d68a66030e7e7436323d6482d1504fe3e32b177e1a04d;
 micalg=pgp-sha256; protocol="application/pgp-signature"
Date: Tue, 18 Feb 2025 12:45:34 +0100
Message-Id: <D7VJOFXU540M.2PAC1RFXAH19B@cknow.org>
To: "Valentin Kleibel" <valentin@vrvis.at>, "Vinod Koul" <vkoul@kernel.org>,
 "Chukun Pan" <amadeus@jmu.edu.cn>
Cc: "Heiko Stuebner" <heiko@sntech.de>, "Philipp Zabel"
 <p.zabel@pengutronix.de>, "Kishon Vijay Abraham I" <kishon@kernel.org>,
 "Jianfeng Liu" <liujianfeng1994@gmail.com>,
 <linux-arm-kernel@lists.infradead.org>,
 <linux-rockchip@lists.infradead.org>, <linux-phy@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>, "Jonas Karlman" <jonas@kwiboo.se>
Subject: Re: [PATCH v2 0/1] phy: rockchip: naneng-combphy: compatible reset
 with old DT
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Diederik de Haas" <didi.debian@cknow.org>
References: <20250106100001.1344418-1-amadeus@jmu.edu.cn>
 <173831716590.670164.5196739962949646746.b4-ty@kernel.org>
 <f64ee4ee-7e56-4423-813e-b87e023e893d@vrvis.at>
In-Reply-To: <f64ee4ee-7e56-4423-813e-b87e023e893d@vrvis.at>
X-Migadu-Flow: FLOW_OUT

--f698ee32381bf21d68a66030e7e7436323d6482d1504fe3e32b177e1a04d
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Tue Feb 11, 2025 at 2:03 PM CET, Valentin Kleibel wrote:
>>> Chukun Pan (1):
>>>    phy: rockchip: naneng-combphy: compatible reset with old DT
>>=20
>> Applied, thanks!
>>=20
>> [1/1] phy: rockchip: naneng-combphy: compatible reset with old DT
>>        commit: bff68d44135ce6714107e2f72069a79476c8073d
>
> Thanks for your work!
> We found your patch after NVMes stopped working on a rock 3A with newer=
=20
> kernels and successfully applied it to kernel 6.1.128 (currently in debia=
n).

FTR: I've reported it in Debian here: https://bugs.debian.org/1098250

I confirmed it (also) broke on kernel 6.12.8-1.

Cheers,
  Diederik

--f698ee32381bf21d68a66030e7e7436323d6482d1504fe3e32b177e1a04d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQT1sUPBYsyGmi4usy/XblvOeH7bbgUCZ7Ry4AAKCRDXblvOeH7b
bhFLAQC1JglGt4aR9lUVkEV0fmRuMzSi31E8LahoJr3zdw31DAD+P5bkgVowQQlh
kiTJtgRPL9URTebUfZf6ug/4nSIEOgo=
=FLpA
-----END PGP SIGNATURE-----

--f698ee32381bf21d68a66030e7e7436323d6482d1504fe3e32b177e1a04d--

