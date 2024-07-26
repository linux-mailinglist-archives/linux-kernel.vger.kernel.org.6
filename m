Return-Path: <linux-kernel+bounces-263804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A370093DAAB
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 00:21:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D161A1C2234D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 22:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15EC714E2E2;
	Fri, 26 Jul 2024 22:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qYcPziJA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51895149DEF;
	Fri, 26 Jul 2024 22:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722032507; cv=none; b=W16yIDfPrD4kdUpjCA3mrQoOeXTC5Jr6rj0fnPGxgAWpu55oNQ4E1RyswEg+1M4AyVAUoKONx7dCX/ybQW+hbX5EMbuH5eFINSqKxc/7EdCh1GWtpslBqzeOCaHuQIAapczmiaTrk+XiM9n0JYYFtYtu7myU4G5bneCzgAKRGTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722032507; c=relaxed/simple;
	bh=sdQCLSxH2SZWba0zwiskrjW/AKOsVQ4oOsTR42AxIpA=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=u9tVFDqrBqKaTY+JoJ7lfPGRAKDwkNXgDWkC8TnTliDRE0Fo+k/7Ji8m3gLtAzwS9DQ+lc4mYBS8NFpPO6L6mo83mqhqqHQUE1rXryg08kotW1kafRt13+StZeEB8n5d3AdUbSEh7Qqbwd/H7XVAOlpJD5WxISGll6MMP+g30TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qYcPziJA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C092FC32782;
	Fri, 26 Jul 2024 22:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722032506;
	bh=sdQCLSxH2SZWba0zwiskrjW/AKOsVQ4oOsTR42AxIpA=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=qYcPziJAIqn+i+6SiIwlNUSR6tpl2/6m9Czqsk9Rx592FeNev+M3hE87g2zPYasJg
	 6KYrXi+ou6/IZ74k+yKDX45CZjIehQnBZZ6L1ZuPUdMZxEqOHEuzmowFR3ugIXmrIm
	 +q+DuQESSSgjAnEpnGwArxI4pKLOaEq7i/GIbzUm/d1WgZFBIF8C0roOt6pb3JO/CT
	 T+d6IFfTuPubF1yR/MuRZzwh2Z3HQ8IJeK1rUBRHcPZm1vaQvW+v3RKHxsUc9EhOg2
	 sA/lnGkZI2q2XDpbcZfEYJx82CFa6cyttI/Jhv9Pz7VihrWyhC1Sv3wgyzBFWt1p8F
	 8Btv1HeQQGnog==
Message-ID: <00f9f4b8722d97b1c6fcec27d53bc06d.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240718-prozac-specks-6b5fd8b83e3e@spud>
References: <20240715110251.261844-1-heiko@sntech.de> <20240715110251.261844-2-heiko@sntech.de> <20240716-deceiving-saucy-851fb2303c1f@spud> <3178118.zE8UqtGg2D@diego> <20240718-prozac-specks-6b5fd8b83e3e@spud>
Subject: Re: [PATCH v2 1/3] dt-bindings: clocks: add binding for voltage-controlled-oscillators
From: Stephen Boyd <sboyd@kernel.org>
Cc: mturquette@baylibre.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org
To: Conor Dooley <conor@kernel.org>, Heiko =?utf-8?q?St=C3=BCbner?= <heiko@sntech.de>
Date: Fri, 26 Jul 2024 15:21:44 -0700
User-Agent: alot/0.10

Quoting Conor Dooley (2024-07-18 08:59:50)
>=20
> FWIW, I wouldn't classify this as device-specific. "enable-gpios" and
> "vdd-supply" are pretty generic and I think the latter is missing from
> the vast majority of real* "fixed-clocks". I would expect that devices
> where the datasheet would call
>=20
> * Real because there's plenty of "fixed-clocks" (both in and out of tree)
> that are used to work around the lack of a clock-controller driver for an
> SoC.

I agree!

>=20
> > I think generic power-sequences
> >   were the topic back then, though that might have changed over time?
> > - There are places that describe "fixed-clock" as
> >   "basic fixed-rate clock that cannot gate" [1]
>=20
> I think that that is something that could be changed, it's "just" a
> comment in some code! Sounds like Stephen disagrees though :)

It's more about making a clear break from the fixed-clock binding so
that the extra properties are required.

>=20
> > - Stephen also suggested a separate binding [2]
>=20
> I liked your "gated-oscillator" suggestion in another reply, but
> "gated-fixed-clock" might be a better "thematic" fit since this is a
> special case of fixed-clocks?
>=20

It looks to me like we've arrived at the hardest problem in computer
science, i.e. naming. Any of these names is fine. I'd look to see what
those parts on mouser are called and use that to drive the compatible
name decision if you can't decide. The description section in the
binding could be verbose and link to some parts/pdfs if that helps too.
In the past I've seen EEs call these things clock buffers. I'm not a
classically trained EE myself but it usually helps to use similar names
from the schematic in DT because DT authors are sorta translating
schematics to DT.

