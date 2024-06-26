Return-Path: <linux-kernel+bounces-230350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7988F917B9A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 11:00:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0713BB23296
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 09:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C1ED16849C;
	Wed, 26 Jun 2024 09:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="lz9mEeQW"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E81DA1411EB;
	Wed, 26 Jun 2024 09:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719392439; cv=none; b=Me/H4Lzp8FmbZByUcBVSRIklcNfc825Dmyi5YETL50+ONivAXn+PKVxX9B1l7QJ6KFXaDIlURHPCow6kHLMv/cfj9Ethvu1cgtwsY+x2hKEK09bQ2kYChn6VOayrme5pxmljjsl4btl0zrR8HlnAWsOn4fybmi3gm6XOLnfIfvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719392439; c=relaxed/simple;
	bh=9t/fdHigGO6Nq7Eu+cEzC770cd6v3TbdxHkxKiQA6MM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TWutMs2gq2izN7cggftjFbTiUXqHFbAMlUjJa1UlxBDpoqbYXdXch28fy7XDlLDv9030vG9qvyw02evXvjx2adz+acrq3svZEXgVJ/vrOht31jbYSC8sbR76d0+s9IPwMd5MRnuC7JsyWippag/zvPWKgALxSk0n0suByq/8oh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=lz9mEeQW; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Received: from pecola.lan (unknown [159.196.93.152])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 3EAD9200EE;
	Wed, 26 Jun 2024 17:00:35 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1719392435;
	bh=9t/fdHigGO6Nq7Eu+cEzC770cd6v3TbdxHkxKiQA6MM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=lz9mEeQW6VDYNUrh39xiNOap/CnJitO0Box1ywcY0LxMS5saMhcyfJSOepso81Lpf
	 8QlHXBsXqigabErR8uomdJrpJyN6KJuBHx+OJtXr+1WH5CXWboafRnqcdFBszwNlff
	 aeY37Lu4qUisSwWRvSDWHo1GUXp55ZDW1/VJchynzWRBxvUxP8DWsUYXCBao6ysTJt
	 13lF65GQoo0QH2KmZM92eASjqx28lM396S2OQSRK1A8kGQCQmOzhSZkYllIBrTyEbq
	 bUXINsB6lGQA+0oMlzX9ae0T3yiFdEGv17NrWZJsdr160V7CuK7jyrAppUwq4U0GNq
	 z3CDDIlFbDgow==
Message-ID: <d256cd72ef2011c3bfd045b04fb6509d1ac827e9.camel@codeconstruct.com.au>
Subject: Re: [PATCH 1/2] dt-bindings: i3c: dw: Add property to select IBI ops
From: Jeremy Kerr <jk@codeconstruct.com.au>
To: "Aniket ." <aniketmaurya@google.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Alexandre Belloni
 <alexandre.belloni@bootlin.com>, Joel Stanley <joel@jms.id.au>, Billy Tsai
 <billy_tsai@aspeedtech.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 linux-i3c@lists.infradead.org,  linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
Date: Wed, 26 Jun 2024 17:00:34 +0800
In-Reply-To: <CAMmmMt25nkZTXXLCVGv1baf3azQR0kwbM8LP4EzCQKOPLUhbVQ@mail.gmail.com>
References: <20240626052238.1577580-1-aniketmaurya@google.com>
	 <20240626052238.1577580-2-aniketmaurya@google.com>
	 <e28ba03d1df1c0c5aec987411c40e44fc351ce0d.camel@codeconstruct.com.au>
	 <c15045b4-2e5f-4fcc-b25c-76a5e4973e93@linaro.org>
	 <b4ba5fa7834fdfb1a1e26ff0e01b9bb235de63b5.camel@codeconstruct.com.au>
	 <CAMmmMt25nkZTXXLCVGv1baf3azQR0kwbM8LP4EzCQKOPLUhbVQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Aniket,

> > For cases where no other special behaviour is required, we can
> > represent this just as an entry in the OF match table.
>=20
> Actually I see that IBI support is always present in the HW(DW I3C
> IP). It's just that we have an option in SW to decide whether to
> populate function pointers for IBI or not.

OK, in that case this /definitely/ doesn't belong in the DT then, as
it's purely software configuration.

> So can we remove this selection of ops and always go with ibi ops?

Sounds fine to me, but I don't have direct experience with the non-
ast2600 uses of the dw core.

Cheers,


Jeremy

