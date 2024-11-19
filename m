Return-Path: <linux-kernel+bounces-413804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A72359D1EF3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 04:46:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 552721F2260A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 03:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F763146A71;
	Tue, 19 Nov 2024 03:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BhV9Za8c"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6162A1863F;
	Tue, 19 Nov 2024 03:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731988003; cv=none; b=dNext894CsTBFGN5VfQXSjJq88e2eLHLpvuXZRyqQleZQWrmM0p64JSbyfMgP9fgDE7k0CgJTp+Dz3qW782z+sK6VMuZqMlomGsGIVsM2TCpxcJBuwPzx6hqxbq+8mCpRHLaw4Btl13LaQA25ig/CN1IkcuGkadwmOjOTZE/KUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731988003; c=relaxed/simple;
	bh=cLg56LdjG00AtMTGY+3z7xIAHqbtHAcB02s1qF9G0eY=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=CtN+W/DDD7DP3bdBGwB2dBWzxTbWiqYH6fFHuTzrhbKWCLVi4TSs7WL98izveTdsmFXbEReLpE7BswjzMvm3Wq5rC0MWDnIeNZ944rNglFRe0NRWPk/5C2MLfcXs7Tfo6KzNv5KRQLNZ+C2vnWXpDVSwS8SHPg0NdkiXeW9GKCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BhV9Za8c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D04A8C4CECF;
	Tue, 19 Nov 2024 03:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731988002;
	bh=cLg56LdjG00AtMTGY+3z7xIAHqbtHAcB02s1qF9G0eY=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=BhV9Za8cmwBje8VvseR7p6vgKJZULF+9gXVR009GGw6YkYUwFEjqFAePo7UyPPlCX
	 bXhnTUj9u/F26RcbdyeWq2W2Jz4L3S9oJRP/sabKlSh/7bTRvI0aGvMlNgQTog7pSK
	 33/vT7qpii+g9TGwJXkUCFRY7sqwacxR2WgQr7kfrEP5503xbhmciyJZ4+oZXPnuAP
	 yRlDNpO7TP21iVFHgTndzfZTZ7Osn83BkbNBWmfby6reie1Eux4Kv0jrR0dD/NQnnM
	 7y2030xHsESGFiuQPm7g72YA6yLoNjqF0BDsmIl6IvylybgDMrmgSEa2sNyFIYLep/
	 FH7ISDqpv6qeA==
Message-ID: <0c757a374f63ab6d47b9abd95261d348.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <2c7789dd-9583-4daa-918a-1bf14635f62e@lechnology.com>
References: <CA+G9fYs+gwu67Y0Tm2FHfNuUA5eLxT2FAWkfKvYrEbXJUXXiiA@mail.gmail.com> <2c7789dd-9583-4daa-918a-1bf14635f62e@lechnology.com>
Subject: Re: drivers/clk/davinci/psc.c:281:10: error: incompatible integer to pointer conversion returning 'int' from a function with result type 'struct davinci_lpsc_clk *' [-Wint-conversion]
From: Stephen Boyd <sboyd@kernel.org>
Cc: hanchunchao@inspur.com, Michael Turquette <mturquette@baylibre.com>, Arnd Bergmann <arnd@arndb.de>, Dan Carpenter <dan.carpenter@linaro.org>, Anders Roxell <anders.roxell@linaro.org>
To: David Lechner <david@lechnology.com>, Linux Regressions <regressions@lists.linux.dev>, Naresh Kamboju <naresh.kamboju@linaro.org>, clang-built-linux <llvm@lists.linux.dev>, linux-clk <linux-clk@vger.kernel.org>, lkft-triage@lists.linaro.org, open list <linux-kernel@vger.kernel.org>
Date: Mon, 18 Nov 2024 19:46:40 -0800
User-Agent: alot/0.12.dev1+gaa8c22fdeedb

Quoting David Lechner (2024-11-18 06:28:21)
>=20
> This is caused by [1]. I looked at it again and the patch is wrong.
> Can you drop it from your tree or should we send another patch to
> fix the bad patch?
>=20

I can drop it from the tree.

