Return-Path: <linux-kernel+bounces-248447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B04F92DD48
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 02:04:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D0A91C21AAB
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 00:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05263801;
	Thu, 11 Jul 2024 00:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HJaV/ZUM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C1B13201;
	Thu, 11 Jul 2024 00:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720656284; cv=none; b=pUBNZxQWg8EgmfHll6tvybxh0odT5522KmyloyDjk3fAWTNBCpXATRafXgKA1r+SW6z/fGKK4u9sc3ovQsDfM4ru1s/zvnT9mW5q2doM3MEAmtp7aMbjty5X+26bRIlOQ4hr4L/Wy6gfRcLBKWISnpv3eiJ7HQODU14NDNn65IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720656284; c=relaxed/simple;
	bh=LoH2ZoYa2mnasOzoozuE/n+8G7gQuYpt7BBzCX/pdtI=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=sKNn3qQWcBlxWtzSUz/ojwPW4qtMApA7/0MlUsMX64QE3gN0bgpJXBLjwAnKZ+/goUj8TjMTp93wFg3XNv06Mdd1vM5V2Vquv/dKZPhZY1fWQTgl3ChJ8PlxGk4DHWb40E0BanZ1zYIIZhhTFUUEpn9dK83WG0yLSJDs3nsJk3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HJaV/ZUM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B460DC32781;
	Thu, 11 Jul 2024 00:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720656283;
	bh=LoH2ZoYa2mnasOzoozuE/n+8G7gQuYpt7BBzCX/pdtI=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=HJaV/ZUMnZTRLGyfiuXbJbUmRL7yDm1gJ9K3gHULJ8mRPiN+iz1B+3NYQZHr8GCME
	 ruwg/2gcwwQTn+7AZDO4le8WS5O+EJFUVLFOqkzYUz9lWzf5b5+HDXpeaYqdaoUCiq
	 nIJeYz/XIm041sjjShE5ftHZUL1cR/iefzPLpimZgYBCW83d6nMG2tyJD6Yb2ljVDu
	 hpTseJ/7C6rtKMENy8IwftS07vgymquHBH4stH1vdZo7FVMv3DJeM73tesNWMPgAvr
	 4/dDEBVg6ub6wunrinM190eKNqZI3tb1rFXoEmi2d7DjZ60ink6PyLV54UnW3EQY7z
	 hVHtO/McBRTKg==
Message-ID: <9cb3f57ed4b41fb51600610a3a1c9437.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAA8EJpqOD-JKGCJiC7yAkiG3oAOEbHQ-_aCmDiP5HdeEVZm8fw@mail.gmail.com>
References: <20240628-gpucc-no-request-v1-0-b680c2f90817@linaro.org> <20240628-gpucc-no-request-v1-1-b680c2f90817@linaro.org> <5153b8f8a6c6ffdc1254e00c47a888ed.sboyd@kernel.org> <CAA8EJpqOD-JKGCJiC7yAkiG3oAOEbHQ-_aCmDiP5HdeEVZm8fw@mail.gmail.com>
Subject: Re: [PATCH 1/2] clk: qocm: add qcom_cc_map_norequest
From: Stephen Boyd <sboyd@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Michael Turquette <mturquette@baylibre.com>, Rob Clark <robdclark@gmail.com>, linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Wed, 10 Jul 2024 17:04:41 -0700
User-Agent: alot/0.10

Quoting Dmitry Baryshkov (2024-07-10 16:32:18)
> On Tue, 9 Jul 2024 at 01:30, Stephen Boyd <sboyd@kernel.org> wrote:
> >
> > Quoting Dmitry Baryshkov (2024-06-27 22:20:22)
> > > The GPU clock controllers use memory region that is a part of the GMU=
's
> > > memory region. Add qcom_cc_map_norequest() to be used by GPUCC, so th=
at
> > > GPU driver can use devm_ioremap_resource for GMU resources.
> >
> > Why does GMU map the gpu clk controller? Does it use those registers? We
> > don't want to allow two different drivers to map the same region because
> > then they don't coordinate and write over things.
>=20
> It's not that GMU maps gpu CC separately. It looks more like gpucc is
> a part of the GMU address space. I think GMU manages some of the
> clocks or GDSCs directly.
>=20

I imagine GMU is a collection of stuff, so the register range is large
because it's basically a subsystem unto itself. Can the range in DT be
split up, or changed so that different devices within GMU are split out?
Or maybe the gpu clk controller can be made into a child of some GMU
node, where the GMU node has a driver that populates devices that match
drivers in different subsystems.

