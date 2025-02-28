Return-Path: <linux-kernel+bounces-538989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA7D0A49F9D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 17:59:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 309A13AC4DB
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 16:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDC7E1E884;
	Fri, 28 Feb 2025 16:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b="YnP5ml4l"
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978B81F09B1
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 16:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740761768; cv=none; b=p77bd0Wsx0UbBLLpC+W46wFRVnGyf80qm9M8g/KGGwcI2ARwpfrDJPnECnanjNqkjxPp62gTj7HZ9KkTaRkovKdRH7BzSEuXToI4REohRozASfZjEWnJMimAZ2DbgSAwnYDQbmgcafFMmvDtIIh++iWsgDgW0LhXOawN+pwfjkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740761768; c=relaxed/simple;
	bh=9uTSHLNgnbRt5Lsag5q7P+lfzkBEMtaYH2Jt6mYNjBg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=TJMXuXwKSb2ajasWgY9720lUKpty4rOMfyluLuwmv86kUeQSUbMwZGGsk0Z3aHOdhXLEj2YA+LfCxlGk1K9g6fXJuMd+3B2TvFJ9p2hwDWYhe+VOe/HY2D/xhZLkph9bolxHvR4F5IvnouUJebhOhUMUWE7/mUdgIk5ak/DPCRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org; spf=pass smtp.mailfrom=cknow.org; dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b=YnP5ml4l; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cknow.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow.org; s=key1;
	t=1740761759;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CK2+2eTKEOuhyBSMGk3107aiSfJh4IB6MZYp2fX2orA=;
	b=YnP5ml4lSpqZvZxXgRMBOB/tXJezBC6B6VFzwlj9SWokVPcyO2HSn0JrITrq3scrHkWXu8
	P2NlPxV4wh2Snwo8S/3TIX7B3S2tlkZ08AymOj//GP3SX1QbQtvC5ZDvEyRAooPgUoeE64
	j9eoZQB1dqHlTMSUJR458UWPER81onHKg512NWLcZyq3TV78EYMKPnnZn/z/TtccALiS/4
	FgMyo5ZC4U2AtDv3xw/k0ZMOmSg7xa2IFYFVk+Wk4Zij2dFBBQmzZrsFy9PWe1nl4NWeYK
	QE+jt2V+SrPhMP4k1JT3W3EAYP09vjRoBDLFCADQPhfmDZhD0jJuawYHjtvfqg==
Content-Type: multipart/signed;
 boundary=9db44123ad8e24452ea89acc1d1803313fb749feac7e1c6887c874175b10;
 micalg=pgp-sha256; protocol="application/pgp-signature"
Date: Fri, 28 Feb 2025 17:55:47 +0100
Message-Id: <D848JET5TDL6.2L4ZQR0YHYQU6@cknow.org>
Cc: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-rockchip@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: dts: rockchip: Remove undocumented sdmmc
 property from lubancat-1
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Diederik de Haas" <didi.debian@cknow.org>
To: "Yao Zi" <ziyao@disroot.org>, "Rob Herring" <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley"
 <conor+dt@kernel.org>, "Heiko Stuebner" <heiko@sntech.de>, "Dragan Simic"
 <dsimic@manjaro.org>, "Johan Jonker" <jbx6244@gmail.com>, "Wenhao Cui"
 <lasstp5011@gmail.com>, "Yuteng Zhong" <zonyitoo@gmail.com>
References: <20250228163117.47318-2-ziyao@disroot.org>
In-Reply-To: <20250228163117.47318-2-ziyao@disroot.org>
X-Migadu-Flow: FLOW_OUT

--9db44123ad8e24452ea89acc1d1803313fb749feac7e1c6887c874175b10
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Fri Feb 28, 2025 at 5:31 PM CET, Yao Zi wrote:
> Property "supports-cd" isn't documented anywhere and is unnecessary for

s/supports-cd/supports-sd/ ?

Cheers,
  Diederik

> mainline driver to function. It seems a property used by downstream
> kernel was brought into mainline.
>
> This should be reported by dtbs_check, but mmc-controller-common.yaml
> defaults additionalProperties to true thus allows it. Remove the
> property to clean the devicetree up and avoid possible confusion.
>
> Fixes: 8d94da58de53 ("arm64: dts: rockchip: Add EmbedFire LubanCat 1")
> Signed-off-by: Yao Zi <ziyao@disroot.org>
> ---
>  arch/arm64/boot/dts/rockchip/rk3566-lubancat-1.dts | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/rockchip/rk3566-lubancat-1.dts b/arch/ar=
m64/boot/dts/rockchip/rk3566-lubancat-1.dts
> index 61dd71c259aa..ddf84c2a19cf 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3566-lubancat-1.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3566-lubancat-1.dts
> @@ -512,7 +512,6 @@ &sdhci {
> =20
>  &sdmmc0 {
>  	max-frequency =3D <150000000>;
> -	supports-sd;
>  	bus-width =3D <4>;
>  	cap-mmc-highspeed;
>  	cap-sd-highspeed;


--9db44123ad8e24452ea89acc1d1803313fb749feac7e1c6887c874175b10
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQT1sUPBYsyGmi4usy/XblvOeH7bbgUCZ8HqmAAKCRDXblvOeH7b
brBnAQDYQlWpCi07tRhXA4WUv7ubZmIyzqkjeaOSH8mLwC7m9wEAhEKazw8l4USI
CuStlAfbvqiFxfbuBJrPLhrrU8ag6A0=
=EyJp
-----END PGP SIGNATURE-----

--9db44123ad8e24452ea89acc1d1803313fb749feac7e1c6887c874175b10--

