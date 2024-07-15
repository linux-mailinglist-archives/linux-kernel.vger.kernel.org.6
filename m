Return-Path: <linux-kernel+bounces-252965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D33D931AA3
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 21:10:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4B081F229EA
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 19:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 892D882486;
	Mon, 15 Jul 2024 19:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aDmd1VLM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0FDB762D7;
	Mon, 15 Jul 2024 19:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721070634; cv=none; b=Wm2OAeIOc721+gdmoXIlVgqdAP55PW0rYOO29TwMUl0Uc6qMQr3x0+H4gOxj9N+MWVWMaCs8yxkcfAFNTsKLn/Jhlg5jgu2VbqoYq9lUvGDzgrNJGRya0oyfxWwFrbPEDikdXQVSonKEL/0IdUMN7LJxz+ca982BBDFEP24e0bY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721070634; c=relaxed/simple;
	bh=i1YPP8GvnIotxIx3buh+wyZmCmdXEPtkuDjQhHiWPl4=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=Z5Uo5auoDw9qjVlqmo9FQ6pLxMmpaZL93kIsk0asQp8SYvGkVNQfBH/rXC9QZkhVmUtF93REuvgkPRGJpag43YrNA4z5BffCHS2mpRKeQAZiKbEnnSjtmWwOH96zFZ5i9IzAgOrXnJQ/LNeaudN9BbfYXmjekTX3agOVJsaAifw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aDmd1VLM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D881C4AF0D;
	Mon, 15 Jul 2024 19:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721070634;
	bh=i1YPP8GvnIotxIx3buh+wyZmCmdXEPtkuDjQhHiWPl4=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=aDmd1VLMC+Z9X3Q5GUqgh57bYNGh/33JFHUQyxiX2ol+2nYPr0XBOgCPVSPQboAy8
	 PJuC/1NOP0L6lq9hH+HHsJ/qs6Or517HUUOxXzIwNjEJtvhLr5Iwf45QePhwlAe9a1
	 se3QUDf4SlRWFqJFW2b40ykLpKgGFgOQ6Bujx6aQb4IzwWam9NyTwDoxkt2mQfwEJK
	 OUBwjV+xz33oMGmU91E0gVLgl8ydTlHC5mYHoW1jfQvK8JW3s5nKmO5WFpcxcQm8Ei
	 LUYAxEyGoaQabRV4DXKCr/zPxzn9a7ENb499PIqenQfU4MTGT5lsYa31e/+R/R+T47
	 sLpZF+Judc01w==
Message-ID: <b6c9ece6ea9a0a476057ced63669017e.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240711-th1520-clk-v3-0-6ff17bb318fb@tenstorrent.com>
References: <20240711-th1520-clk-v3-0-6ff17bb318fb@tenstorrent.com>
Subject: Re: [PATCH v3 0/7] clk: thead: Add support for TH1520 AP_SUBSYS clock controller
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-riscv@lists.infradead.org, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>, Drew Fustini <dfustini@tenstorrent.com>
To: Albert Ou <aou@eecs.berkeley.edu>, Conor Dooley <conor+dt@kernel.org>, Drew Fustini <dfustini@tenstorrent.com>, Emil Renner Berthing <emil.renner.berthing@canonical.com>, Fu Wei <wefu@redhat.com>, Guo Ren <guoren@kernel.org>, Jisheng Zhang <jszhang@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Michael Turquette <mturquette@baylibre.com>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, Rob Herring <robh@kernel.org>, Thomas Bonnefille <thomas.bonnefille@bootlin.com>, Yangtao Li <frank.li@vivo.com>
Date: Mon, 15 Jul 2024 12:10:32 -0700
User-Agent: alot/0.10

Quoting Drew Fustini (2024-07-11 09:56:18)
> This series adds support for the AP sub-system clock controller in the
> T-Head TH1520 [1]. Yangtao Li originally submitted this series in May
> 2023 [2]. Jisheng made additional improvements and then passed on the
> work in progress to me.
>=20
> Link: https://openbeagle.org/beaglev-ahead/beaglev-ahead/-/blob/main/docs=
/TH1520%20System%20User%20Manual.pdf [1]
> Link: https://lore.kernel.org/all/20230515054402.27633-1-frank.li@vivo.co=
m/ [2]
>=20
> Changes in v3:
>  - dt-binding patch has been applied to clk-next by Stephen but I'm
>    keeping it in the series for completeness.
>  - move dt-bindings include after linux includes in driver
>  - change rate to u64 in th1520_pll_vco_recalc_rate()
>  - replace do_div() with normal division operation in both
>    th1520_pll_vco_recalc_rate() and th1520_pll_postdiv_recalc_rate()
>  - add static to ccu_mux structs: c910_i0_clk, c910_clk, uart_sclk

This didn't happen, so I just did it myself.

