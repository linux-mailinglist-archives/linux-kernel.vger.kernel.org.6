Return-Path: <linux-kernel+bounces-317845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B8E696E46A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 22:51:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C22E28A996
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 20:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF4E71A38D8;
	Thu,  5 Sep 2024 20:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qHeSYBzS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 350CD17741;
	Thu,  5 Sep 2024 20:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725569455; cv=none; b=REQdhSBOvdnctLk1w1ew7ujiANAiMwbltzEno5ZrPXzKQ3SXxzSqsA2tE0mzbE9659nuTgKFF+LTCEnOYcEFlk1/VPon4GC9YVXGtvx1rz0PVjOFnfNqoH4822tzV3IuJmp9+OpHX88fQiUmZxs2AsDeGCdLWCCHj2Dp2SSPOoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725569455; c=relaxed/simple;
	bh=1vmL5mtPyaOpl8ZHVtu7u8CQ2WQzQvvG3t6H2fv4ar4=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=UebLPyiJrCd1j0sbSrRpL7CZCs5PexYHAgksQsambHt/QONy1Xzs4bkEvetheJj1CiX0bqJ0MipmZUrsPqNlcVGxw6eXBU4/cBosl4wv32XYAtSlw0fdnQlLyh0yYlh/WT89n2lMbrVCipvH96pg8BxEyUx/nHQuHUxFQm5ENzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qHeSYBzS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98232C4CEC3;
	Thu,  5 Sep 2024 20:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725569454;
	bh=1vmL5mtPyaOpl8ZHVtu7u8CQ2WQzQvvG3t6H2fv4ar4=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=qHeSYBzSVm6AL7049QPQ3mmuIgtP8RIixZ2HHcI4aCvgNgyvT54OtyGiSFlhIBm9I
	 MH3wJGfD9x4JuzSf332ZRVmDVLPcR10Zt5QPLMG8S6/uwfx8aI312+BqoqjWvzU/rZ
	 MceGC5MIq5Ql+7byWfv/Ee64uAXJdO3nsRCj6aPMtlKbR3x3xA1IafwoKam7Q0kk4Z
	 1MNeqoiFQqzfgMJkGAbxBo9h4yLLdtO6RLeRkM4l4jQt03tLUMmOPxZuQpRnUVZ0vk
	 GHVHTgjj9q7xQqiwih9pCcpkxfQZTxr//KkQ6Qj04HnLvvy7bDHX3e5GbILu03ijyX
	 ALtkFILHsxuGQ==
Message-ID: <887d5cfabeccf5dae0538a9c59ba74e4.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <cf18eef44460da71db7e125d91da22f0a78c0375.camel@maquefel.me>
References: <20240715-ep93xx-v11-0-4e924efda795@maquefel.me> <20240715-ep93xx-v11-3-4e924efda795@maquefel.me> <020c15c9939c1c4cfac925942a582cee.sboyd@kernel.org> <a87f99e02f3e9c40c8b9638a8a5a9c5b55aca68c.camel@maquefel.me> <79cb209c6c5a14ae4d6a015f714c58d4.sboyd@kernel.org> <cf18eef44460da71db7e125d91da22f0a78c0375.camel@maquefel.me>
Subject: Re: [PATCH v11 03/38] clk: ep93xx: add DT support for Cirrus EP93xx
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
To: Michael Turquette <mturquette@baylibre.com>, Nikita Shubin <nikita.shubin@maquefel.me>, Nikita Shubin via B4 Relay <devnull+nikita.shubin.maquefel.me@kernel.org>
Date: Thu, 05 Sep 2024 13:50:52 -0700
User-Agent: alot/0.10

Quoting Nikita Shubin (2024-09-02 06:31:59)
> On Fri, 2024-08-30 at 15:27 -0700, Stephen Boyd wrote:
> > Quoting Nikita Shubin (2024-08-30 02:23:12)
> > >=20
> > > Indeed REGMAP is selected by COMMON_CLK, MFD_SYSCON not required,
> > > but
> > > it needs AUXILIARY_BUS.
> >=20
> > I don't see REGMAP selected by COMMON_CLK. Did I miss something?
>=20
> Indeed REGMAP is selected by COMMON_CLK_MESON_REGMAP not COMMON_CLK on
> make tinyconfig + COMPILE_TEST.

The meson driver isn't used here?

>=20
> Then we require REGMAP because we are using regmap_read() in clk
> driver.

I think you're supposed to select REGMAP_<BUS> config option, not the
toplevel REGMAP option. For example, if you're using mmio, then select
REGMAP_MMIO.

