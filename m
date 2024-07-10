Return-Path: <linux-kernel+bounces-248390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9210792DC90
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 01:21:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3ED61C2265E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 23:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59D1F154BE8;
	Wed, 10 Jul 2024 23:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hwyqFvL3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A4D12C489;
	Wed, 10 Jul 2024 23:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720653678; cv=none; b=eK8gaj5Mkkf4aD4D6kszIUqwWEGuusa30P51/sS/igw2aVCHkyvf8iAOxq55bPcJEiZU6IRMGxfetYldusYO3EBE86WqNgP6pyNZoTxhi1Xdd60dcOTohgCNDhHwfWU83C6VVLkbOrWPLTDI4DutC13ePuB8SGlZPyCg7hjLf4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720653678; c=relaxed/simple;
	bh=eCaFT3/kRTqxtksiSHjtW7/iheSU9qRWbGpJZIcucMY=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=hwjqXpnmLhjLKpYG64a1PTXqp3FnN781/peHZiYAIA/J8P2geV4pU2Dt1LYOM0PzcCFbLEkJUg011WBZaA8vT+59aGB+O28WqJai7PiAsgjHxnupmwmEyJO8Fg2hszzp76z6CKvO600N+fEIho60LrwC3515PLVkiP1LSshotC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hwyqFvL3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BCC8C32781;
	Wed, 10 Jul 2024 23:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720653678;
	bh=eCaFT3/kRTqxtksiSHjtW7/iheSU9qRWbGpJZIcucMY=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=hwyqFvL3uSKjrmCdyQQa4cq13kGOEJSEy2fkv2CKEDlZ5UMFNwKLgGMVZsgYHeYu9
	 bBi8O03DbNfXd5Xid+5FjPy7cdpiYU2WKD1qoumUyhQTkMuIXMeb3nj0lK6aihOE5z
	 2uZhahCucrQX9GuuXBymgbs5n7Gri8ly1kAIES4843NAlsfrFFvBtdJxOS1gLCl4iL
	 oNcYTZtywrjftE5tJlqNIPWIOPHic2VmbhVgb4d7j728FUWe7fJnbokE3l3JEu1OVP
	 99JoOsaBQoWiQsZlGA2nGl72MvoscnAHqoaikGe8rVqKF4t871gCC1ukaPGn/yJuIf
	 0tFBwbzjAvA8w==
Message-ID: <68f6dc44a8202fd83792e58aea137632.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <21244242.0c2gjJ1VT2@diego>
References: <20240709123121.1452394-1-heiko@sntech.de> <20240709123121.1452394-2-heiko@sntech.de> <12478313.O9o76ZdvQC@steina-w> <21244242.0c2gjJ1VT2@diego>
Subject: Re:  Re: [PATCH 1/6] dt-bindings: clocks: add binding for generic clock-generators
From: Stephen Boyd <sboyd@kernel.org>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, quentin.schulz@cherry.de, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org
To: Alexander Stein <alexander.stein@ew.tq-group.com>, Heiko =?utf-8?q?St=C3=BCbner?= <heiko@sntech.de>, mturquette@baylibre.com
Date: Wed, 10 Jul 2024 16:21:15 -0700
User-Agent: alot/0.10

Quoting Heiko St=C3=BCbner (2024-07-10 00:45:17)
> Am Mittwoch, 10. Juli 2024, 09:02:34 CEST schrieb Alexander Stein:
> >=20
> > So essentially only enable-gpios and vdd-supply is added in comparison =
to
> > fixed-clock. Does it make sense to add that to the fixed-clocks instead?
> > Similar to fixed-regulator.
>=20
> I wasn't that sure which way to go in the first place.
> The deciding point was reading that line about the fixed clock not
> being gateable, so I opted to not touch the fixed-clock.
>=20
> But you're definitly right, this _could_ live inside the fixed-clock
> as well, if we decide to get rid of the not-gateable thing above.

It's probably more complicated to combine it with the fixed-clock
binding after making properties required like vdd-supply. I'd just make
a new binding and look at combining later.

