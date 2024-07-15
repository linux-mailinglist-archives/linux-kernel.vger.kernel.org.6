Return-Path: <linux-kernel+bounces-252407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 230569312B0
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 12:59:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5424283D22
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 10:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 926C71891A1;
	Mon, 15 Jul 2024 10:59:50 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 491B123B1;
	Mon, 15 Jul 2024 10:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721041190; cv=none; b=hfmu3jvgiaE/DqJizcTMlsQHXHVQ8za9pNN2+yHxD7MaamJ4CMLYkQNREJXN/iIhmgpyL29pLtOInbGbZvaYqLxiJ3UAYIwSMV9jFTxjSzU8KGPB45KfDb1s0zgIQQMnszMLzgaBeNUVFtJmdr33b4IanRMI3mnIWrfsLFzJvxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721041190; c=relaxed/simple;
	bh=4PQ0VHYlnUqz6Z1Wt6DgQytrj4AaL1dQwGvWmCFlPAY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Sqjv06RZ7g5TaqGtNl3skM0xDRWPd9YYVITNc4OhfXILcsJrYZg7qLQ1VwFGPQ9HbKE48pbGr1FCuxX2W3kLbC7VrfZK4wujxKGVp+uma9qPbCdrGiUUZEsNFPEwpPetbD362N9lToLr8TgurbtIlBjLWzVbuFtL57y00VZiLpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i5e860d09.versanet.de ([94.134.13.9] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sTJQU-0006Em-K0; Mon, 15 Jul 2024 12:59:26 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: mturquette@baylibre.com, Stephen Boyd <sboyd@kernel.org>,
 Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 quentin.schulz@cherry.de, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org
Subject:
 Re: [PATCH 1/6] dt-bindings: clocks: add binding for generic clock-generators
Date: Mon, 15 Jul 2024 12:59:25 +0200
Message-ID: <3268030.0WQXIW03uk@diego>
In-Reply-To: <1899010.tdWV9SEqCh@steina-w>
References:
 <20240709123121.1452394-1-heiko@sntech.de>
 <68f6dc44a8202fd83792e58aea137632.sboyd@kernel.org>
 <1899010.tdWV9SEqCh@steina-w>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Am Donnerstag, 11. Juli 2024, 07:27:40 CEST schrieb Alexander Stein:
> Am Donnerstag, 11. Juli 2024, 01:21:15 CEST schrieb Stephen Boyd:
> > Quoting Heiko St=FCbner (2024-07-10 00:45:17)
> > > Am Mittwoch, 10. Juli 2024, 09:02:34 CEST schrieb Alexander Stein:
> > > >=20
> > > > So essentially only enable-gpios and vdd-supply is added in compari=
son to
> > > > fixed-clock. Does it make sense to add that to the fixed-clocks ins=
tead?
> > > > Similar to fixed-regulator.
> > >=20
> > > I wasn't that sure which way to go in the first place.
> > > The deciding point was reading that line about the fixed clock not
> > > being gateable, so I opted to not touch the fixed-clock.
> > >=20
> > > But you're definitly right, this _could_ live inside the fixed-clock
> > > as well, if we decide to get rid of the not-gateable thing above.
> >=20
> > It's probably more complicated to combine it with the fixed-clock
> > binding after making properties required like vdd-supply. I'd just make
> > a new binding and look at combining later.
>=20
> Maybe I am missing something IMHO adding optional vdd-supply and
> enable-gpios doesn't seem a big deal.
> Anyway I don't have a hard opinion here. To me fixed-clocks still
> seems very appropriate for having a controlling GPIO and power supply.
> I just would get rid of the (comment only) hint they are ungatable.

I think the main issue is that the fixed-rate code is not limited to the
actual fixed-rate clock.

The clk_fixed_rate_ops is exported and used itself in a number of
completely different clock drivers. The same is true for the
clk_register_fixed_rate function, also exported and used in even more
places throughout the kernel while implicitly using clk_fixed_rate_ops.

=46or just being a simple always-on fixed rate clock, the clk-fixed-rate.c =
is
already pretty complex and adding supply handling will entail modifying
the shared clk-ops, or defining a separate clk-ops and clk-register
function, which is what we're doing here already.


Heiko



