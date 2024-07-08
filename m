Return-Path: <linux-kernel+bounces-244652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6C2292A76A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 18:36:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81500280DCE
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 16:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 497FA147C6E;
	Mon,  8 Jul 2024 16:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b="U44a0MWP"
Received: from out-184.mta1.migadu.com (out-184.mta1.migadu.com [95.215.58.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46656145323
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 16:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720456556; cv=none; b=sor4h2WvNFdQV6+vg0+Jbe2AjeQQWPgg0d+1ZKtUJD0dVa6LPS9Unf5d7RdNovgYOiptzdtVHBEXLEPsOtHRZc6iFuKFKPK0nfYl6Onv9kYscCyC9PsxwIFGYp04QMq5SH4lZSpmzvU/6usTjPVvxnRVFa9xsGAU1zuhmGmY2Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720456556; c=relaxed/simple;
	bh=epV5XKr+izWXQUuHLm0+Hd1JdiR9XIiEqS4eTdKApHY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UUPtdMMZgIgcSwcPWQ1rJpH+V84p4fP3cqVdjoImezGQSkTHUdukPF/Jz1QR4EgAWPpJ0BDZPQESl+wMk0tC8VTDrkAEtijse6/dxQDWcnxZEYMwZ6xvkvU3/Ka3z43SxoCg7eSeCbtfFXSFRmcb9YDGf2U/OQhBXEel8GycveM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org; spf=pass smtp.mailfrom=cknow.org; dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b=U44a0MWP; arc=none smtp.client-ip=95.215.58.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cknow.org
X-Envelope-To: macromorgan@hotmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow.org; s=key1;
	t=1720456552;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Q1xLGY2jSIrtPqPZ9NbhDBkO1nnpCkyLaDO8znSKpp4=;
	b=U44a0MWPWvNcZbVouFYU5A9SDhVDTDZA4UcB2WhGSUt87LnPir9tVEsOxbm1QjV3ITL2QN
	ex3G2qsk5edc65UXRRd7GIPsSZYWd1STBVrSVXvCUHK2yi8M+MTzfagvmDfeSKjYJAbyVO
	Yhk9Sc7tF6qQ2s3KW0QSNKj+Ve8uBAohc6pMZKRxMtj/F6EIXofU2MOkTLNrMIBWdqeRqJ
	rOfVlZmvkD56mawtUvu9xHDg8lELcz/1wJJaHW/wPJ2cgqs7KQuNPGYETyzqIierkd1pII
	14Yu7lWMSDhr1pkjwg/ME0Gd0boEj90C8AuAFyiu43dmpiGgio67mGBZubJ4wA==
X-Envelope-To: heiko@sntech.de
X-Envelope-To: mweigand@mweigand.net
X-Envelope-To: dsimic@manjaro.org
X-Envelope-To: linux-rockchip@lists.infradead.org
X-Envelope-To: devicetree@vger.kernel.org
X-Envelope-To: linux-arm-kernel@lists.infradead.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: andyshrk@163.com
X-Envelope-To: jagan@amarulasolutions.com
X-Envelope-To: amadeus@jmu.edu.cn
X-Envelope-To: f.kardame@manjaro.org
X-Envelope-To: michael.riesch@wolfvision.net
X-Envelope-To: wiagn233@outlook.com
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Diederik de Haas <didi.debian@cknow.org>
To: Chris Morgan <macromorgan@hotmail.com>
Cc: Heiko Stuebner <heiko@sntech.de>,
 Maximilian Weigand <mweigand@mweigand.net>,
 Dragan Simic <dsimic@manjaro.org>, linux-rockchip@lists.infradead.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Andy Yan <andyshrk@163.com>,
 Jagan Teki <jagan@amarulasolutions.com>, Chukun Pan <amadeus@jmu.edu.cn>,
 Furkan Kardame <f.kardame@manjaro.org>,
 Michael Riesch <michael.riesch@wolfvision.net>,
 Shengyu Qu <wiagn233@outlook.com>
Subject:
 Re: arm64: dts: rockchip: Add dma-names to uart-bluetooth rk3566 devices
Date: Mon, 08 Jul 2024 18:35:39 +0200
Message-ID: <18704154.NT27xa3IZQ@bagend>
Organization: Connecting Knowledge
In-Reply-To:
 <MN2PR16MB29416FE9165FB72824266667A5DA2@MN2PR16MB2941.namprd16.prod.outlook.com>
References:
 <20240705163004.29678-2-didi.debian@cknow.org>
 <MN2PR16MB29416FE9165FB72824266667A5DA2@MN2PR16MB2941.namprd16.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5757575.N3OQHAa34O";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
X-Migadu-Flow: FLOW_OUT

--nextPart5757575.N3OQHAa34O
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Diederik de Haas <didi.debian@cknow.org>
To: Chris Morgan <macromorgan@hotmail.com>
Date: Mon, 08 Jul 2024 18:35:39 +0200
Message-ID: <18704154.NT27xa3IZQ@bagend>
Organization: Connecting Knowledge
MIME-Version: 1.0

On Monday, 8 July 2024 18:05:05 CEST Chris Morgan wrote:
> > This is a single patch which adds the dma-names property to the uart
> > node with a bluetooth subnode on Pine64's rk356x devices.
> > 
> > But that property can potentially be added to several other devices, but
> > I have zero familiarity with them or their community, so I choose not to
> > add it to those devices, but inform people via this cover letter.
> 
> Thank you, but based on past experience the bluetooth failed to work
> when I had the DMA names present (which is why I removed them on my
> devices). I will however test it again to confirm that is still the
> case or not.

That is very well possible as I had specifically you in mind when I chose to 
only apply it to Pine64 devices (as I could directly contact those people).
I had a vague recollection that there was 'something' with bluetooth on 
devices you added.

Thus it seemed better to inform people of the possibility, but let the actual 
implementation up to them.

Cheers,
  Diederik
--nextPart5757575.N3OQHAa34O
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQT1sUPBYsyGmi4usy/XblvOeH7bbgUCZowVWwAKCRDXblvOeH7b
bvr8AQCR3UX8zsLmcd9BjCPsexTjAxcrLuEqZKdpAGwYqlz/8AEAijpXHym1iyGu
wbw7/ntw95MClGyHkeh4XovtnqM37gc=
=+Whf
-----END PGP SIGNATURE-----

--nextPart5757575.N3OQHAa34O--




