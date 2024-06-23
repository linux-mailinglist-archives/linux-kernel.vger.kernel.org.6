Return-Path: <linux-kernel+bounces-226095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38B49913A1E
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 13:31:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF9D2281571
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 11:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B7DA12FB2A;
	Sun, 23 Jun 2024 11:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b="Rw5BM7be"
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1783F5F87D
	for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 11:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719142287; cv=none; b=UL3xYDmExoVM+edMxxAPk4Yy+9+9ntG8NO3IZ7sheXA6wiy6rj/wv23c5z/HYolItZOYurCHEXJBGJVfbSsncOR3mLxcNg97NudRsbZcN/SUyKgK0KpkAemLkppSE/aD0kC87yQijwaK4DiQlRMeIDtA43bwpcxDLelsimZ8IP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719142287; c=relaxed/simple;
	bh=L9dXnhFbrkaYuTfm4DbBIxBmCMz4jM+mrPztKiQskQ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PO/h01KBcLD7csa26VmtUn+CbJWKH3e7jCgBf/ESZI404ArzgcdXzFucEVWHukqRo1rvRKozM2hhcucEcPxDkY+TfCjbnEwfNovSM7bIUH0J0FtX0VheXxiN+N+7xSVc9s0iOYQhxiM079b4s3lYTBPJAdtjkqAhgpnU7e4aWUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org; spf=pass smtp.mailfrom=cknow.org; dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b=Rw5BM7be; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cknow.org
X-Envelope-To: heiko@sntech.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow.org; s=key1;
	t=1719142277;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5sGngLZBqkAE79iidbqyoVY0tRIQ64K5ocj/t6ME7os=;
	b=Rw5BM7beOxfAOo/M/g9Y90xdI/WXTSgfKd8Vcc4N06yn0AbYNv+tyhjF5g/VKBygh3VFk7
	5HGGA+ys9qIY/QpCe60KRNBmHBeu0+yWvbouknppNGdtdjOF6McYoQw+lr37zV7sMlSJmu
	Dk7iGGJOo7gFSWl7O1hsqDOIWObEAqpzAVX0Wc8QAxXi3ja2jWyUBzVKpZxq2ja34Oym5J
	MO/2rn6/MhuyZ7CH/dzqjGf9fFq/darjJ4bWPYBclob7uiCm5mD5FbFNc/sOOyRPfVMdIG
	X0KIwqedDvCxcbBM2U8S73oLAbSLXqMIjPqf36lk8/fln+2QTs8MB2Ej5G6Teg==
X-Envelope-To: linux-rockchip@lists.infradead.org
X-Envelope-To: dsimic@manjaro.org
X-Envelope-To: devicetree@vger.kernel.org
X-Envelope-To: linux-arm-kernel@lists.infradead.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: linux-rockchip@lists.infradead.org
X-Envelope-To: andyshrk@163.com
X-Envelope-To: andyshrk@163.com
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Diederik de Haas <didi.debian@cknow.org>
To: heiko@sntech.de, linux-rockchip@lists.infradead.org
Cc: dsimic@manjaro.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-rockchip@lists.infradead.org, Andy Yan <andyshrk@163.com>,
 Andy Yan <andyshrk@163.com>
Subject:
 Re: [PATCH] arm64: dts: rockchip: Fix the i2c address of es8316 on Cool Pi 4B
Date: Sun, 23 Jun 2024 13:31:02 +0200
Message-ID: <2771372.9AS07kTVam@bagend>
Organization: Connecting Knowledge
In-Reply-To: <20240623083413.2051412-1-andyshrk@163.com>
References: <20240623083413.2051412-1-andyshrk@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4155544.U3QUcyqSlJ";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
X-Migadu-Flow: FLOW_OUT

--nextPart4155544.U3QUcyqSlJ
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Diederik de Haas <didi.debian@cknow.org>
To: heiko@sntech.de, linux-rockchip@lists.infradead.org
Date: Sun, 23 Jun 2024 13:31:02 +0200
Message-ID: <2771372.9AS07kTVam@bagend>
Organization: Connecting Knowledge
In-Reply-To: <20240623083413.2051412-1-andyshrk@163.com>
References: <20240623083413.2051412-1-andyshrk@163.com>
MIME-Version: 1.0

On Sunday, 23 June 2024 10:34:13 CEST Andy Yan wrote:
> According to the hardware design, the i2c address of audio codec es8316
> on Cool Pi 4B is 0x10.
> 
> ...
> ---
> 
>  arch/arm64/boot/dts/rockchip/rk3588s-coolpi-4b.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3588s-coolpi-4b.dts
> b/arch/arm64/boot/dts/rockchip/rk3588s-coolpi-4b.dts index
> 20a0a60acd16..091dee37d068 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3588s-coolpi-4b.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3588s-coolpi-4b.dts
> @@ -302,7 +302,7 @@ &i2c7 {
> 
>  	es8316: audio-codec@11 {

Shouldn't this be `@10` then too?

>  		compatible = "everest,es8316";
> -		reg = <0x11>;
> +		reg = <0x10>;
>  		assigned-clocks = <&cru I2S0_8CH_MCLKOUT>;
>  		assigned-clock-rates = <12288000>;
>  		clocks = <&cru I2S0_8CH_MCLKOUT>;


--nextPart4155544.U3QUcyqSlJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQT1sUPBYsyGmi4usy/XblvOeH7bbgUCZngHdgAKCRDXblvOeH7b
bt3oAQCII30iQ/sfgohv2r+DOosF7UhIE+8oOtI6S/ypnnR5ewD+JVcYqudfLmEs
OWE4JSAnFwNwXgGsOr8QJFLcDpI25gc=
=MCtm
-----END PGP SIGNATURE-----

--nextPart4155544.U3QUcyqSlJ--




