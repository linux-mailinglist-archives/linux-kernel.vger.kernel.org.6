Return-Path: <linux-kernel+bounces-516889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 02737A37959
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 02:01:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE90518874D6
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 01:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33AF7DDC5;
	Mon, 17 Feb 2025 01:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="dVKCB49I"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03777611E;
	Mon, 17 Feb 2025 01:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739754090; cv=none; b=QH4hIPt4LspxlGHqokBm3qR9TtsjihrL5HitEW9opbMTJ9bcoLlGuRIMDndO1eqIB7rn8+XqVlilzg3gzyPsOpYIgFdkvy6kk9w4CXFXoEBskuMhbQcwceBY1Rptx+4wNraf7pliBpMLJAJlF9Mg7TgKTdPBYQB0zMNIS8KAFYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739754090; c=relaxed/simple;
	bh=197jgArcHmxjLWJHP3d90o+UVqJqNHrwpTlU4PAOVr8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nT7IAU67QAxLtbIuiPLMjpf+/cTRbhxPsHLEeJVesRtVaV+jzS3skUqfkpes4VyhwT5G6f9xbIgL6DUxZlYPIlTE4M9pZ9ZDegqrX8G1nNb9QkgpIlYOVcZRhoGrp9+rpRbIj7iu4ybbz8bmxAX+0/fZnPBhxDhuECopr6QzdF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=dVKCB49I; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1739754086;
	bh=197jgArcHmxjLWJHP3d90o+UVqJqNHrwpTlU4PAOVr8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=dVKCB49IuOAKDBlVaPc9OJo6YDFoJZbcM/73itjicoXBVo6S2sPz98dFefq4uonsz
	 0BOxMYXB3j2NK8CAWrVU1QDuLIi72fkv/qGyupH2DHgDsjVyyLyY/pQ9gcPQVdIRiN
	 gh85us7w3ofG5oaX9OrRJ7r85MgpoDeJbBNtYtpOjLvnB6Sasq++sGDmHN2A0g5cLB
	 lXnfnx/7FBFsUK91O82KNMj+2Py7brat2sbPFe1om68YHwBKdLtp+nTOyEo8RkWIJf
	 hj+Y3J40hjbSES0Y1Q2wl0/HFqwK/O645xee/IlHgmN9ZNkmH5W0rx5iRXBl3vtwAy
	 Z+pURH3shKXwA==
Received: from [192.168.68.112] (ppp118-210-170-58.adl-adc-lon-bras34.tpg.internode.on.net [118.210.170.58])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 0C16364E5C;
	Mon, 17 Feb 2025 09:01:25 +0800 (AWST)
Message-ID: <047ea26fbb5713e852431d0731e21d34af39e1c2.camel@codeconstruct.com.au>
Subject: Re: [PATCH dev 6.6 v3] ARM: dts: aspeed: yosemite4: add I3C config
 in DTS
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: MarshallZhan-wiwynn <marshall_zhan@wiwynn.com>, patrick@stwcx.xyz
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, Rob Herring
	 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	 <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>
Date: Mon, 17 Feb 2025 11:31:23 +1030
In-Reply-To: <24d2d411365004f11498777501da54d6a9c6e758.camel@codeconstruct.com.au>
References: <20250214011556.1891113-1-marshall_zhan@wiwynn.com>
	 <24d2d411365004f11498777501da54d6a9c6e758.camel@codeconstruct.com.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-02-17 at 11:14 +1030, Andrew Jeffery wrote:
> Hi Marshall,
>=20
> On Fri, 2025-02-14 at 09:15 +0800, MarshallZhan-wiwynn wrote:
> > Set I3C config in yosemite4 DTS.
> >=20
> > Test plan:
> > Tested pass with aspeed I3C patches and I3C hub driver.
>=20
> Can you please expand the commit message to provide details? This
> statement is quite vague, and I don't find it terribly helpful as it
> stands. Which aspeed patches? What tests?

Also, you've sent this patch to the upstream lists and maintainers, but
it appears you're intending this to be applied to the OpenBMC kernel
fork. Please understand the difference between the two and review my
recent response to Rush Chen:

https://lore.kernel.org/all/9f0447151e6574d74e7fa9cbbb50d8e970059273.camel@=
codeconstruct.com.au/

Beyond that, for patches to be backported into the OpenBMC fork they
should first be merged upstream, in which case they must be tested
against a recent upstream tag (e.g. v6.14-r3) before they are sent. It
will be worth reviewing the following:

https://docs.kernel.org/process/development-process.html

The "Submitting Patches" documentation provides a more succinct
treatment:

https://docs.kernel.org/process/submitting-patches.html

If you have any questions, please feel free to contact myself or Joel
off-list.

Andrew

