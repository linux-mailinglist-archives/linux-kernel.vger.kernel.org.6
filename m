Return-Path: <linux-kernel+bounces-378931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 025629AD761
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 00:12:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2A131F23433
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 22:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 524FD1FBC81;
	Wed, 23 Oct 2024 22:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ple3/eFh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F7E1D041B;
	Wed, 23 Oct 2024 22:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729721557; cv=none; b=riYdOZYr9fuKskPq5FSOGNrx1sox4qWE0xVIfx5wM2SDVteA3ilCLa0CbPW20Slgjiar0GG+xuSCUwsnab4naPKxuQD29FWnc+/8rI+yGHwha2M/LEgwdRXG/nt8TD/8IGMC7OXXo5wwaySFWsNN5gv3YS3CHE7heQ4ZdxaiVB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729721557; c=relaxed/simple;
	bh=ya9ok5nW1iUWsJB9i5ZUGJbOtt75/dc/ZmVQACOslIY=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=PzKBtjQAGu8gcGYlalnTeHOPpFa/XYKjS/O7R21y3hdsmoXnTGLnRbfdnT0VBwunIoTLO42/iSEFa2u+FSaOc/FClMWcX5SVMGjWqVTlLqhrnFFqzEMIsgFqeUpCIbxYYNzZgKKfQ8AQQOST66Qm1+t6jkl+uE5ru9xVjkn95eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ple3/eFh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30B02C4CEC6;
	Wed, 23 Oct 2024 22:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729721557;
	bh=ya9ok5nW1iUWsJB9i5ZUGJbOtt75/dc/ZmVQACOslIY=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=ple3/eFhwg5tdx7JHtQI9sxTZ/nAW5KzfBySbtozhZ0TeF2FnyfNpBc+/7ZbrNYcI
	 X+lpjXhi4UB0yCjyW3lVQIPz2syoMvTc+7JHDLJpFh9jfm8MAgZWaRRWx2lN/QLMtc
	 0R+9TaICpycm+2MvfLsQd9DnT3baMnH9FICrOXNByieQQ8df6B5k+a5IbITKP2owCd
	 eQZeh4ReGgWOWQcAzGT6YYhL2ueVNaon47lv/G3GPjq83Hd69fjVZohurqvdKisvc+
	 P4vRA0LTfcknDRbi68pfLlBmm9qZ50vYZwDw8TUEtChG1MmtvzA4x9nlzRaLYgn55j
	 df6xgGkF4z/FA==
Message-ID: <02cbfefaf7db9220652c2f9605838f96.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <D534ZSNLN6G0.3HSREQ803OFIQ@bootlin.com>
References: <20241007-mbly-clk-v5-0-e9d8994269cb@bootlin.com> <20241007-mbly-clk-v5-4-e9d8994269cb@bootlin.com> <b3f8bf0e933064a49d1a5e3527646200.sboyd@kernel.org> <D534ZSNLN6G0.3HSREQ803OFIQ@bootlin.com>
Subject: Re: [PATCH v5 4/4] clk: eyeq: add driver
From: Stephen Boyd <sboyd@kernel.org>
Cc: devicetree@vger.kernel.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, =?utf-8?q?Gr=C3=A9gory?= Clement <gregory.clement@bootlin.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Tawfik Bayouk <tawfik.bayouk@mobileye.com>
To: Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Michael Turquette <mturquette@baylibre.com>, Rob Herring <robh@kernel.org>, =?utf-8?q?Th=C3=A9o?= Lebrun <theo.lebrun@bootlin.com>
Date: Wed, 23 Oct 2024 15:12:35 -0700
User-Agent: alot/0.10

Quoting Th=C3=A9o Lebrun (2024-10-23 04:08:31)
> On Thu Oct 17, 2024 at 8:48 PM CEST, Stephen Boyd wrote:
> > Quoting Th=C3=A9o Lebrun (2024-10-07 06:49:19)
> > > +/* Required early for UART. */
> >
> > I still don't get this. UART isn't an early device. It's only the
> > interrupt controller and the timer that matter. Does MIPS do something
> > special for UARTs?
>=20
> Our hardware has a PL011. That is AMBA stuff; they get probed before
> platform devices by of_platform_bus_create(). "pll-per" on EyeQ5 must
> be available at that time.
>=20
> In concrete terms, if we don't register pll-per on EyeQ5 at
> of_clk_init(), we stare at void because the serial fails probing.
> I haven't digged into why EPROBE_DEFER doesn't do its job. Anyway we
> don't want our serial to stall for some time during our boot process.
>=20

Ok thanks for the details. It sounds like there's a bug in there
somewhere. Eventually this should be removed.

Can you dump_stack() in clk_get() when the "pll-per" clk is claimed?

I suspect of_clk_get_hw_from_clkspec() is seeing NULL if
of_clk_hw_onecell_get() is being used and the clk_hw pointer isn't set
yet. NULL is a valid clk and it will be returned to the consumer. You'll
want to write a custom 'get' function for of_clk_add_hw_provider() that
returns -EPROBE_DEFER for any clk that isn't registered early. Then the
AMBA stuff should defer probe until the "full" clk provider is
registered.

