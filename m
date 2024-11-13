Return-Path: <linux-kernel+bounces-407710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAFB19C7167
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 14:51:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7736928BD47
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 13:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AF4C2003CA;
	Wed, 13 Nov 2024 13:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b="O73JTAg/"
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6ECC1FF7C2
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 13:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731505839; cv=none; b=QioYyUb/03Pd9Gk7U3VksNP5AjqIkz+ZbTlH4FPsZafvfoz6xd00tBMQUK334CDDzv0YWh4wuS4EYCYKQLag1Wosl/XPauJWl9ti5vKIYTJ1si0U6w4N9HLR839O1V61iqf5NovlBxm4Oze45+NLARRlqRmEvtW4ztHL1InJIvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731505839; c=relaxed/simple;
	bh=6d0TCAATrTJvLklNJuJFCXHB59t+lCUztzfjePx3hbk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=nmlGmedXgoj75Yd5ej4Jkctls6vDRanaCjxPNxJAo+rutWp8uxRdyNh6lcXUtgFVRNMRAsPhcybQqrDNvJi5MMuqu4ow2cF4KIPJtLwTsiqi8T1KiXcRRaEqlOw9K/tecdgEj1WXSw8SodnyX20J3KY4A1G46HMRv54mpVHa5ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org; spf=pass smtp.mailfrom=cknow.org; dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b=O73JTAg/; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cknow.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow.org; s=key1;
	t=1731505834;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PmllX3O7yxtB5t0j4bQtEHSmJfWKhMTYAv9DCsBoJZM=;
	b=O73JTAg//QJoYdwUErx2lA+B6M7RbBITJFB/W+Frn7zNRqiykvBYaRSZXET1PWmLNuS1rl
	41i9aDd5ejCHTmsc/jw//vLLh/XtaVid4gDBd8rlsInSlmXrtdSFaj99LRyERrHZgKyBQ3
	3YIWI/TIE4A92/J6njCOKCnTOyKNEWIG6ZC3MCshPOv7pZJ/kR2WMc7lGXfTLM5peqvwrD
	1F8AqAGAhrwnSQQWtj53n7UDK+bGzczL5HF4M2vmaquSF6s1iMrUihWg/vSU8jY2q6TmCg
	FOaPnf2kVVXAhL59ocBsKVN6FFkiH0Wa9YjwKrENYt1EMWKNGnvTlGaZa9GqEQ==
Content-Type: multipart/signed;
 boundary=77415465acc9522a1101e182929d3f2ef91789092f296f44cef46464e604;
 micalg=pgp-sha256; protocol="application/pgp-signature"
Date: Wed, 13 Nov 2024 14:50:31 +0100
Message-Id: <D5L3L9M2LZQE.3JV1G0SIVTTZG@cknow.org>
Cc: <linux-rockchip@lists.infradead.org>, "Shawn Lin"
 <shawn.lin@rock-chips.com>, "Sudeep Holla" <sudeep.holla@arm.com>
Subject: Re: Q: Kconfig: 'If unsure, say N'
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Diederik de Haas" <didi.debian@cknow.org>
To: "Harald Arnesen" <linux@skogtun.org>, <linux-kernel@vger.kernel.org>
References: <D5GVI1Q30BTS.1ZVQ4YC4OJYEL@cknow.org>
 <93f4889a-90ed-460d-b5bc-d566031b75d3@skogtun.org>
In-Reply-To: <93f4889a-90ed-460d-b5bc-d566031b75d3@skogtun.org>
X-Migadu-Flow: FLOW_OUT

--77415465acc9522a1101e182929d3f2ef91789092f296f44cef46464e604
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi,

On Fri Nov 8, 2024 at 4:05 PM CET, Harald Arnesen wrote:
> Diederik de Haas [2024-11-08 15:39:30]:
>
> > In quite a number of Kconfig help text entries I see this:
> > "If unsure, say N."
> >=20
> > But that raises the question: How can I be sure?
>
> I usually interpret this as "If you don't know that you need it, you=20
> probably don't".

Yeah, that does sound like a sensible strategy. Thanks :)

Cheers,
  Diederik

--77415465acc9522a1101e182929d3f2ef91789092f296f44cef46464e604
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQT1sUPBYsyGmi4usy/XblvOeH7bbgUCZzSuqgAKCRDXblvOeH7b
bg9sAQCQIhmyfDegBHLU0t/wVSrhFxgdD/qmbad+f4pUjRXpNAD+MEYe3/SOG2c7
xllMMEdS00fO9xp3IP52ZNe6NR5ziQ4=
=713h
-----END PGP SIGNATURE-----

--77415465acc9522a1101e182929d3f2ef91789092f296f44cef46464e604--

