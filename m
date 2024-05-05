Return-Path: <linux-kernel+bounces-169086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8FC08BC2E7
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 19:55:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 937241F2136A
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 17:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0912F5FDA5;
	Sun,  5 May 2024 17:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=holesch.de header.i=simon@holesch.de header.b="woWiK8s0"
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B67A1E861;
	Sun,  5 May 2024 17:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714931706; cv=none; b=j10wrWHHxfiiKm7U1RMNUS9lAMWGIr5whC2ORBJpJcoxafTpJ0usQ9ELagzm4KIK3wJ4pgJq94C8uvmH8u7R5GuUHncW0GYdtX1q/LWWxV24sKMxbl8/zBqzERnpJvQGKsj/fu4aYtjMiutATiEalVl06mj3LE4a5Qi0VMEmLK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714931706; c=relaxed/simple;
	bh=rIgBau9/jOMDPPORyP5ZcAPOLT9dTV9Oi1ob3WkgI2E=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=U2OHY4QY1Y4EwghGq6qnh+s8RR4f7LdHJHnTJx5WpA2NWlHljCXe+dj5nPgLyekTPZj8g2xct/qDMvPNMyZe+vejL57Q/tNVY37mbO0p2D7+S5zaSyxx4jO/QG/jSUNUkGWJixuYk4Q9A1nqaXq7235507axduL6EeDoitpyP3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holesch.de; spf=pass smtp.mailfrom=holesch.de; dkim=pass (2048-bit key) header.d=holesch.de header.i=simon@holesch.de header.b=woWiK8s0; arc=none smtp.client-ip=217.72.192.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holesch.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=holesch.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=holesch.de;
	s=s1-ionos; t=1714931679; x=1715536479; i=simon@holesch.de;
	bh=D8yZS40uvjiFal83TDgtbWp7BPRYiBD18deONZm1ueM=;
	h=X-UI-Sender-Class:Mime-Version:Content-Transfer-Encoding:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:cc:content-transfer-encoding:content-type:date:from:
	 message-id:mime-version:reply-to:subject:to;
	b=woWiK8s0KrUNO0aG48/OWpRqEDPSs6eIRGhBXxSKyVtCNKG+FNW3VZcJkiPkH9rj
	 4QuKK5PYttrIpQwybV81Efgve5h/MLxlcKtSILcGEnxzWgnEMj4X0zQciDdbUym4C
	 HDorMacx50/aduVH4daNFfxCRe3bdS/j0yfe6tyrIfERWhdB1JlbiBI2ICS7PwVTH
	 FhOX/ISdXZ7WjAqtQuVX8SajdTNcbrkaBgRYcBrPExqxqZp4TKBwFMmy0qCHPHse7
	 k4A3NkEeZ2TivWvrBBhtRJ6gGnEjy3G/tQUpwBfL47nWSrnb6NFih8h4pYeUW9y+k
	 2ET7x0+JnC9ui93Qqw==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from localhost ([80.209.217.248]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1M5Q6l-1s2IUU0vCv-001Pt6; Sun, 05 May 2024 19:54:39 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 05 May 2024 19:54:36 +0200
Message-Id: <D11WJK47MBWS.3795S2OL21M7R@holesch.de>
Cc: "Valentina Manea" <valentina.manea.m@gmail.com>, "Shuah Khan"
 <shuah@kernel.org>, "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Shuah Khan" <skhan@linuxfoundation.org>, <linux-usb@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4] usbip: Don't submit special requests twice
From: "Simon Holesch" <simon@holesch.de>
To: "Hongren Zheng" <i@zenithal.me>
X-Mailer: aerc 0.17.0
References: <20231217194624.102385-1-simon@holesch.de>
 <ZjemYB6CpAx4Kx5f@Sun>
In-Reply-To: <ZjemYB6CpAx4Kx5f@Sun>
X-Provags-ID: V03:K1:mnpNGGOlL2uubD6dyHDJFpsrojJv5/+VtadWqjXFzvosraPoM+F
 Rctx+/V/KdSDDhYsXzvmOcSrOxeq4OC4r3Xc40NIQVFki4CdndC3zN1otiTE2DRps9WVxK9
 sz3X4oDDGsnOiAGTXHLQT5KGeiU5+DkkG+As86/iwMA+pH3QAfUWFvXijRF07PrqrAUOE82
 hnIEdXLWGvsbsgO8ut4BA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:yk/FWOXkRlA=;iLTnnr1ujQyNqSdircR1HMBB8wu
 v30hocqDdKtgCXQXfZJRb1O3hUoqzL0TnQivT6OxiKpQm+C72DIJFq+q6TvnKWm1Hxb87ZrYu
 P2OTYRKICVMjmvsiMvboFGYml4m7A1V8wXwqC7H3VbeGbCjcvOo6mxulaGEpwiBgGAO9zcW3q
 ZyCizM/68yzzbfj99yQpzuLoihXJ+liD5EOE3XwDgORAtid3MmSzAr36Ro7JTHOl0sDXxFHiT
 gJerevZJfJN787qT/KS2MynBaSqtKfwLipEHdrtzlYblzEfaL8Yn09ZUBg3GEx1WmZkC5b77i
 bovbV07k8BZ1mX7PcZO8vnDfmvdijKZlxThHLb4z3vyrzeH/Nzb1aMfEYjsmcbxiV8ZavCLKD
 1jlG83o4tv+7tkdS/HrkOS7raV0YtEvQ5KyoKz0VNQ1sMV/scEgN1U5Nv0B2RgY8MyKG/IWLm
 sFQNfw2OygRvyCCPckOp0AmwOpmM7usbBC5r9zNpq2udV/cjnZyX+QwYH5OOTHOc46csfueH9
 7sv5fXDDSXuuu/g5cWvcu/+MaHIyvCqVwDvnnb9m8lkdc+Tg12RRF/t110/9UUNmVF2hI9a+V
 nfVM7ghEeeL07g5xxpsN4zUYipkpDDMXdp07vwNEUDUdvbR4TnA7LO8P183nucsa0KBIXnQWN
 Y9gN7nHjBeBASl+s5i4xWT9N3F753XLN6YUOB69huziFPiDsiMFGWgKDdGbEDBe2KDSfA6V6u
 CeVXSQgmY1GYtuWNDKUeSKcrMkVaOkK/MevMyhF2pmy/dSwMDUbenI=

On Sun May 5, 2024 at 5:31 PM CEST, Hongren Zheng wrote:
> On Sun, Dec 17, 2023 at 08:30:40PM +0100, Simon Holesch wrote:
> > Skip submitting URBs, when identical requests were already sent in
> > tweak_special_requests(). Instead call the completion handler directly
> > to return the result of the URB.
>
> Reproduced the behavior and this patch fixed the bahavior

Thank you for testing.

> > @@ -468,6 +477,7 @@ static void stub_recv_cmd_submit(struct stub_device=
 *sdev,
> >  	int support_sg =3D 1;
> >  	int np =3D 0;
> >  	int ret, i;
> > +	int is_tweaked;
> > =20
> >  	if (pipe =3D=3D -1)
> >  		return;
> > @@ -580,8 +590,7 @@ static void stub_recv_cmd_submit(struct stub_device=
 *sdev,
> >  		priv->urbs[i]->pipe =3D pipe;
> >  		priv->urbs[i]->complete =3D stub_complete;
> > =20
> > -		/* no need to submit an intercepted request, but harmless? */
> > -		tweak_special_requests(priv->urbs[i]);
> > +		is_tweaked =3D tweak_special_requests(priv->urbs[i]);
>
> One question though, if there are mutiple urbs and one of them is
> SET CONFIGURATION, then all of them would not be submitted,
> as is_tweaked is a *global* flag instead of a per-urb flag.
>
> Now it is assumed that when the urb is SET CONFIGURATION then
> num_urbs is 1. I assume it just happens to be the case and I do
> not know if it holds for all scenario.

To be honest, I didn't fully understand the num_urbs > 1 case. I assumed
this is for drivers not supporting SG and a long URB is just broken up
into multiple ones.

