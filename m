Return-Path: <linux-kernel+bounces-407706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D34199C715E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 14:50:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99260284E43
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 13:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AF32200CA7;
	Wed, 13 Nov 2024 13:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b="oJAzufwb"
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B658B1EF955
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 13:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731505651; cv=none; b=tCI6EQEabnfrjCI8H61HNm+YO3hVSrDyfmDx/SwQlAULwe4TzQQ/rbAO/EaaalbwcXuP+yx2YX0DA5kG408Bg6Ye6kjgOZpf1moAv8Bpa0TtMVeAxdTMfyZ0ZI5adVbL6sbnGO+0Up6cLAlVBCznnv14NGGPgLqKqSTNPk9rz64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731505651; c=relaxed/simple;
	bh=X/qpTewFe4YwHFtx9JVnzn/Hz8SShkM9vR3bRa8jYs0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=su8/xzPt3C7uGmQ9mJTicM56AweGlxpKtADr4Le/5pVjgllG8c1ONYLn+sB6kQv0vZScniw57NSQHDtMRtqXcEWyXv+ZEn7UMFQ15QO4KGprol4AUzKOpZSmHPaumrFRPrJRUz0tay6oMG92+qzRnW8Z8lGKcI2SjHBz46m4wg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org; spf=pass smtp.mailfrom=cknow.org; dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b=oJAzufwb; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cknow.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow.org; s=key1;
	t=1731505643;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gHzgNJeIjaZvOxUJjdGqYlYVOhgCdeNHnJS5Tf5gqqo=;
	b=oJAzufwbQyl9R6AI9N6hKcQr1xZ7g917yk55W+o+iBq+F/6J8dDKSYoHOuGyXniCw1c0aH
	j1MELuP7eScci6PRS70Wd/QmT+lf9DJuovkNUfEEnAH9ktCkECh0Tdz07ow31JIM4+JO/x
	CMZEEqThq7seu+hjoeOoa6ddl5v5zGNuun1YOtZgCOKWRFZHEQy3VEyhKCIUC9nKu8PBJr
	roX7HkWwXJ7wF0RNlxSYpdfdoaGQ765LB1iTBqljN4lJ4fVhSVucFMVpXhH8ruHycyrNsa
	qIa51jRTdHN71BT7aANfTr4PV6dcC0yMiygo8gf0fEYLnVU61d33va7pud+cAw==
Content-Type: multipart/signed;
 boundary=d6058cffb12ad5bd71cc704a8a30ec90289c25b15f02e290b59919e252dc;
 micalg=pgp-sha256; protocol="application/pgp-signature"
Date: Wed, 13 Nov 2024 14:47:12 +0100
Message-Id: <D5L3IQFBCNBQ.1Z5OB2COPA7C5@cknow.org>
Cc: <linux-kernel@vger.kernel.org>, <linux-rockchip@lists.infradead.org>,
 "Shawn Lin" <shawn.lin@rock-chips.com>
Subject: Re: Q: Kconfig: 'If unsure, say N'
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Diederik de Haas" <didi.debian@cknow.org>
To: "Sudeep Holla" <sudeep.holla@arm.com>
References: <D5GVI1Q30BTS.1ZVQ4YC4OJYEL@cknow.org>
 <20241112054623.7zxte2nny7h4st3h@bogus>
In-Reply-To: <20241112054623.7zxte2nny7h4st3h@bogus>
X-Migadu-Flow: FLOW_OUT

--d6058cffb12ad5bd71cc704a8a30ec90289c25b15f02e290b59919e252dc
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Thanks for your response.

On Tue Nov 12, 2024 at 6:46 AM CET, Sudeep Holla wrote:
> On Fri, Nov 08, 2024 at 03:39:30PM +0100, Diederik de Haas wrote:
> > In quite a number of Kconfig help text entries I see this:
> > "If unsure, say N."
> >
> > But that raises the question: How can I be sure?
>
> If you don't know about the feature and it is not having any user-interfa=
ce
> why do you want to enable it. You must understand the feature to enable i=
t
> and use it IMO.

Ok, understood.

> You seem to contradict yourself here. If you have understood the help
> text and think it is useful, it seems to me as an indication that you
> are not unsure really. So you can enable it if you want TBH.
>
> > Not to discuss these specifically, but just for illustration:
> > ``drivers/firmware/arm_scmi/transports/Kconfig`` has this
> > option: ``ARM_SCMI_TRANSPORT_SMC_ATOMIC_ENABLE``
> > which IIUC enables an *optional* feature for an atomic transaction.
> >
>
> "If you want the SCMI SMC based transport to operate in atomic
> mode, avoiding any kind of sleeping behaviour for selected
> transactions on the TX path, answer Y.
>
> Enabling atomic mode operations allows any SCMI driver using this
> transport to optionally ask for atomic SCMI transactions and operate
> in atomic context too, at the price of using a number of busy-waiting
> primitives all over instead."
>
> So you read the above text, understood and find it useful. You must be
> not unsure of this feature then, so what does that text bother you.

In this case I was wondering whether this was related to Table 1 in
"Power and Performance Management using Arm SCMI Specification"
whitepaper.
And I do think that I understand most of the Help text, but I'm not/less
sure about the part starting with "at the price of ...".

> It is just a caution to users who are just build and not looked at the
> code, or have no idea about the feature or doesn't understand the help
> text.

And my question was exactly about "just a caution", which raises the
question with me "caution for what?" ... which is an unspecified risk.
So to be on the safe side, I will not enable modules with "If unsure,
say N" unless I fully understand the source code.

Cheers,
  Diederik

--d6058cffb12ad5bd71cc704a8a30ec90289c25b15f02e290b59919e252dc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQT1sUPBYsyGmi4usy/XblvOeH7bbgUCZzSt4wAKCRDXblvOeH7b
boRiAQDx8Eh2ofEVih95M/okFMQsvSV2EcKZw8mMPdo8wV8lsgEA8/3y5avIppoN
+/q44cpCGJSZQaSLsydKu9Uq+boaxQY=
=qLuS
-----END PGP SIGNATURE-----

--d6058cffb12ad5bd71cc704a8a30ec90289c25b15f02e290b59919e252dc--

