Return-Path: <linux-kernel+bounces-201706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D0408FC1FE
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 04:46:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 976A91F2372C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 02:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A7F153364;
	Wed,  5 Jun 2024 02:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lyndeno.ca header.i=@lyndeno.ca header.b="ftyHEgjD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RlcvAH0K"
Received: from wfhigh8-smtp.messagingengine.com (wfhigh8-smtp.messagingengine.com [64.147.123.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6FD910E5;
	Wed,  5 Jun 2024 02:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717555604; cv=none; b=PllEjRk3EUzK4aKaH0zlJ/M10nTjxkBNzStoUD4SQXsO2sTp3WSBdOQPCpsJcEs0+J4li0Jfc1l3GQvwf7ym9HFF6RbvdAZCgWl1zzxh3lwUoeYp1FM/5FeWaP5La0p0sJEWfW+2t5exWYGnVuRnY40MmEc7ZvhwR5hovuM42Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717555604; c=relaxed/simple;
	bh=mx5oQQDIpZKnQTteAnPD38LpR3Tu7KLeNebCCfqid4s=;
	h=Date:From:Subject:To:Cc:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b2WzpIEUBM0HHsi0Plo4y+Ep02IvcFgRHw1qJ/Dtu4w2KmYOTgJUsOb0FdIqXlg3oYUWGXyCOm+NAhXHuB9oz95G31bCPpvB48mJkRWWSkAxMdDOZnxIOzB3jltghYY81II01nEdr/aWjo/oDDzOoCvSr0VYSJMm8GGxMFpcFrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lyndeno.ca; spf=pass smtp.mailfrom=lyndeno.ca; dkim=pass (2048-bit key) header.d=lyndeno.ca header.i=@lyndeno.ca header.b=ftyHEgjD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RlcvAH0K; arc=none smtp.client-ip=64.147.123.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lyndeno.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lyndeno.ca
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.west.internal (Postfix) with ESMTP id 90CBA18000BD;
	Tue,  4 Jun 2024 22:46:40 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 04 Jun 2024 22:46:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lyndeno.ca; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1717555600;
	 x=1717642000; bh=ZDEaMGjAyUtEyp/oo01G3wTVNw0AXLOJqKr0ugk6K3A=; b=
	ftyHEgjD2ZiPR2W+LuW6uyhoN3ih1KNKq6KeCs6ihbsXP0oouj1OUqjPsahRUghC
	ACD7jYDy7/J7N7xXCE06aQLQSPWEesfXroPJE1PAgxBSVxxcAP8sWG/vIdqCvXnL
	y1rVzkXAS2JW2a+SnX0QBAysZ2eJOFu8qFJhLi2qYVsjRUIpYxyNewRPms+EdGT4
	Z6d8Mpgj23i6yYIJ9Bel8I0hq5+4Jiy4bl9otmyqiJZxm8gtJqWSglfbxmjy0M0g
	P5TKXObJS8C3wYCz8kG3qde9WZlSiycXQ/JMyVqTEXA4AiipZNa25UNCu0LOYyPn
	ILDZienr3E5mqfjuVvUWeA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1717555600; x=
	1717642000; bh=ZDEaMGjAyUtEyp/oo01G3wTVNw0AXLOJqKr0ugk6K3A=; b=R
	lcvAH0K17eyIFiMyTHoJFTwKxG2/zhmnBJ10Ztax4uSwPzG9vFceqk+PYEdpJsJp
	tsKKY2tjPM+4apt22QNULJHUsm9wry5Q0edJKsktDCVbdkPYVMt0D5NTNDPqgW3k
	czyMIjKISqbRDqnrJO4Wgfh1LUrCxx0FD5cdIl7nCCs7X4CrYxTlWG1uiVsSI3rY
	Cs2vp+vWJ7V/j38lIclY85cKoMuiXcNxKjiDQ7r1jwpCr9CXXECDpRRgPzFg/pBN
	KPGn/s7LbmmMFOE1BtlBImmKnndYxyoP9jMBN3x6ByB8vE7XMJFqhYcfWvc7G+XZ
	ABzJWn881+pMNRA7kWl7A==
X-ME-Sender: <xms:j9FfZllVVIqrKEBdXAAItgavtyW_X9brkQbBx5mIuJTYbmyUdfWtXw>
    <xme:j9FfZg1pmM7_E2YBDwR7Hl2DNjCiHnqdNiB6plz05LkvXMn4kckNIcX29iDFB88fp
    2rrJsa80kzkDriFo74>
X-ME-Received: <xmr:j9FfZrrAovrLgFVfwO-Df4a_QrxY5s5BqXzKcepgUwyDr2w_jIytSoTOXI1bSLV0u7cP27--O3toby_QhoYewCta_Vw19WznKq5AtbHUCxc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelhedgiedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhuffvvefkjghfofggtgfgsehtqhertdertddunecuhfhrohhmpefnhihn
    ughonhcuufgrnhgthhgvuceolhhsrghntghhvgeslhihnhguvghnohdrtggrqeenucggtf
    frrghtthgvrhhnpedtvdefvdetfeeggeejgeejvdevteejvdehhedtueeugfelhfeuieff
    ieehffetheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehlshgrnhgthhgvsehlhihnuggvnhhordgtrg
X-ME-Proxy: <xmx:j9FfZlmXzixD8FI0CrUqyQ2AlGQqQ0Q-MpUeZQ-1qh_KuO7e2AHUVw>
    <xmx:j9FfZj0rQKDSIjksGoc6IpW72vrrYz4e204zY2Lez0NKki_k2qmtCQ>
    <xmx:j9FfZkvTTSWrBG_uK_t5wah8VYu9H3HO4A1yZghCs-MTcITfKS3iwA>
    <xmx:j9FfZnXquROSU1Ut8ZmEZ2Lxm6Gtoxt_oefWK5x3QxkP5o6MqKX0gA>
    <xmx:kNFfZj-5kvvr5You9fLpVayeJJEohuQgqvIGBySOZoR3Q_5C7JxdsPoX>
Feedback-ID: i1719461a:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Jun 2024 22:46:37 -0400 (EDT)
Date: Tue, 04 Jun 2024 20:46:29 -0600
From: Lyndon Sanche <lsanche@lyndeno.ca>
Subject: Re: [PATCH] platform/x86: dell-pc: avoid double free and invalid
 unregistration
To: Thomas =?iso-8859-1?q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Hans de Goede <hdegoede@redhat.com>, Ilpo =?iso-8859-1?q?J=E4rvinen?=
	<ilpo.jarvinen@linux.intel.com>, platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Message-Id: <HD6LES.A9HJVAFECS8L3@lyndeno.ca>
In-Reply-To: <20240604-dell-pc-double-free-v1-1-6d81255b2a44@weissschuh.net>
References: <20240604-dell-pc-double-free-v1-1-6d81255b2a44@weissschuh.net>
X-Mailer: geary/46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable



On Tue, Jun 4 2024 at 11:41:24 PM +02:00:00, Thomas Wei=DFschuh=20
<linux@weissschuh.net> wrote:
> If platform_profile_register() fails it does kfree(thermal_handler)=20
> and
> leaves the pointer value around.
> Any call to thermal_cleanup() will try to kfree(thermal_handler)=20
> again.
> This will happen right away in dell_init().
> In addition, platform_profile_remove() will be called although no
> profile is registered.
>=20
> NULL out the thermal_handler, so thermal_cleanup() avoids the double=20
> free.
>=20
> Fixes: 996ad4129810 ("platform/x86: dell-pc: Implement=20
> platform_profile")
> Signed-off-by: Thomas Wei=DFschuh <linux@weissschuh.net>
> ---
> Currently the call to thermal_cleanup() in dell_init() is completely
> unnecessary. But I guess more functionality will be handled by the
> driver and then this structure makes sense.
>=20
> This is untested.
> ---
>  drivers/platform/x86/dell/dell-pc.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/platform/x86/dell/dell-pc.c=20
> b/drivers/platform/x86/dell/dell-pc.c
> index dfe09c463d03..972385ca1990 100644
> --- a/drivers/platform/x86/dell/dell-pc.c
> +++ b/drivers/platform/x86/dell/dell-pc.c
> @@ -261,8 +261,10 @@ static int thermal_init(void)
>=20
>  	/* Clean up if failed */
>  	ret =3D platform_profile_register(thermal_handler);
> -	if (ret)
> +	if (ret) {
>  		kfree(thermal_handler);
> +		thermal_handler =3D NULL;
> +	}
>=20
>  	return ret;
>  }
>=20
> ---
> base-commit: 0da7a954480cc99978e3570c991e3779e56fc736
> change-id: 20240604-dell-pc-double-free-e8cf2aa9b2fb
>=20
> Best regards,
> --
> Thomas Wei=DFschuh <linux@weissschuh.net>

Thank you for this patch. I was able to apply your patch and compile=20
successfully. I have not had a chance to try it on my hardware.

I agree with the change, and it looks good to me.

Thanks,

Reviewed-by: Lyndon Sanche <lsanche@lyndeno.ca>



