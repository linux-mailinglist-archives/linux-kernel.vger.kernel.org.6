Return-Path: <linux-kernel+bounces-516882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45BE4A3793F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 01:45:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FA1E16CC8F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 00:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD13ADDBE;
	Mon, 17 Feb 2025 00:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="e12xb8n0"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1E99475;
	Mon, 17 Feb 2025 00:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739753101; cv=none; b=Pf/WnTtO/mRFGXxsMEextSnsQWdmvE2oOBqwBFz7tWrWYRghFLxR0bkVoDD1slxexXGzSlurhZu7+DsKj6As0CkLcaPKaqoLnyGKnyu+NRfpfNnNxSoCp5RSDFM+DvVZoXXH/FTuzbH2RGhoszNxT3TtBU4O5ukuNcwYC+Z/TuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739753101; c=relaxed/simple;
	bh=FsLbrEcDHR1CqcdDrTwnQzpK6jcP3o5E5bXCv2mXd5Y=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TkpuaGiF0CCFeujwTNrRqABtQ/FVsZ4ztLqh6dg11/qtzLG0xJVulzSIIesmUWoQZjmmk1yTh0faOzOe+JpM/uqWoRUvAevztn62FGZB7XOZTFdQBy6R0s8gNYDjJVHyDK1a/84E0SVHg3XR+MiJxa31zZdDHIfdCQ/K/sjDjzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=e12xb8n0; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1739753097;
	bh=FsLbrEcDHR1CqcdDrTwnQzpK6jcP3o5E5bXCv2mXd5Y=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=e12xb8n0CJf/RnYIfowfnxv1ZGM+A7mQVlP9zgn8rTq9f1NSNUWQQiC1+0SKi5LZF
	 BpjqJElLlN25eGELSxpbovzmH1pPT/XFbRvbs5PDMgMIl8ojEUeS67GavpurJrry0G
	 UC2EK31KM+F86fSM5j2fYSWDYkqBCd/cAZUcwXT7b/MZB1FAOmLCvj1EgXLEppQDDv
	 gF/8m7Xf78pPYZ/y0yKUo1TSlpNGAYM2lJWxGXe+ygURPUDlOpNkOJAkbvn3v28+cy
	 BPARfhX9p04L45+dl6+JbAev5GJUaQ/1Mlf6ApFXfTPOpeMccWRIeJhV3gth9w/t3A
	 d/BSMCO6hBy1Q==
Received: from [192.168.68.112] (ppp118-210-170-58.adl-adc-lon-bras34.tpg.internode.on.net [118.210.170.58])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id B9F5C64E5C;
	Mon, 17 Feb 2025 08:44:56 +0800 (AWST)
Message-ID: <24d2d411365004f11498777501da54d6a9c6e758.camel@codeconstruct.com.au>
Subject: Re: [PATCH dev 6.6 v3] ARM: dts: aspeed: yosemite4: add I3C config
 in DTS
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: MarshallZhan-wiwynn <marshall_zhan@wiwynn.com>, patrick@stwcx.xyz, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date: Mon, 17 Feb 2025 11:14:56 +1030
In-Reply-To: <20250214011556.1891113-1-marshall_zhan@wiwynn.com>
References: <20250214011556.1891113-1-marshall_zhan@wiwynn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Marshall,

On Fri, 2025-02-14 at 09:15 +0800, MarshallZhan-wiwynn wrote:
> Set I3C config in yosemite4 DTS.
>=20
> Test plan:
> Tested pass with aspeed I3C patches and I3C hub driver.

Can you please expand the commit message to provide details? This
statement is quite vague, and I don't find it terribly helpful as it
stands. Which aspeed patches? What tests?

>=20
> Signed-off-by: MarshallZhan-wiwynn <marshall_zhan@wiwynn.com>
> ---
> =C2=A0.../aspeed/aspeed-bmc-facebook-yosemite4.dts=C2=A0 | 88
> +++++++++++++++++++
> =C2=A01 file changed, 88 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-
> yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-
> yosemite4.dts
> index ab4904cf2c0e..3f98e67674d0 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> @@ -1317,6 +1317,94 @@ eeprom@50 {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
> =C2=A0};
>=20
>=20
...
> =C2=A0&adc0 {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 status =3D "okay";
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pinctrl-0 =3D <&pinctrl_adc0_d=
efault &pinctrl_adc1_default
> --
> 2.25.1
>=20
> WIWYNN PROPRIETARY
> This email (and any attachments) contains proprietary or confidential
> information and is for the sole use of its intended recipient. Any
> unauthorized review, use, copying or distribution of this email or
> the content of this email is strictly prohibited. If you are not the
> intended recipient, please notify the sender and delete this email
> immediately.

Please avoid including these confidentiality clauses:

https://subspace.kernel.org/etiquette.html#do-not-include-confidentiality-d=
isclaimers

Andrew

