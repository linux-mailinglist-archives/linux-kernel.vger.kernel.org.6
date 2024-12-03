Return-Path: <linux-kernel+bounces-428571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A35829E10BA
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 02:20:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18B9FB225F4
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 01:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E5F64594C;
	Tue,  3 Dec 2024 01:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p2oZ6GQY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828882AEE4;
	Tue,  3 Dec 2024 01:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733188809; cv=none; b=N1fEPDj/gQTp0EfZUmYZzGI2KEKpKuvqbMetojGzVMK9gzUaerUFR5UPAqhH9Vgno11HK2typs4PWufwpPpumAzOLSuIa1EmAMbWQPDwhHnfdZIiznT9oXe1a+ZVVpJCn7z4lLvWufRbRMwTW5NBjlrA7MDtCeJNLNjD07uNfvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733188809; c=relaxed/simple;
	bh=MlLe+tQnKFPxKjr103hSotPdb7+hcXhDgSGjZw8wjYw=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=FzhJB4TB0vbaAciMlsrI14mMkw2+M1KVzoMOFBFNiz8eD/N2GIguasx2Flgg3VyiegZFxV/m8bti0B6x2qUVdxAErnE6iwF+BLlVk4/sapSRqDjudb33p91LR43SzJmRdHz9xZaajMEyR7xQOM+S4HkqZ59I0PMMRk2NAPBsvt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p2oZ6GQY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF276C4CED1;
	Tue,  3 Dec 2024 01:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733188809;
	bh=MlLe+tQnKFPxKjr103hSotPdb7+hcXhDgSGjZw8wjYw=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=p2oZ6GQYhnDuqmez6879D5czXf0H6LNu6J1eW3rs+MvGQWnBsoKGf0BaTXYQ56GFH
	 WDxPxrlOAZ3B7Wd//3Zaiyjotmz/MVtlFWsB4WQGrYJWORihiDILquwT7mfTNA6P8t
	 3aAGOVbKNId3LYEiBZ3SVAUJ+U5lo/cDjVRDn91RnE87qZIFXWfCf8PYoK2zHRU/TZ
	 SpoqmRYpyVNbwUe+qoQc1spQtpOF9Ti46eOJiu/uUA4TcralsI5BA7UgfDHmL4pfoM
	 qKJ5B5cxUEtKwOD/NP54U5V6GdTv+oripnJjQR1ln4KiOgHASDb0CdwX5CCrzvvOcz
	 LHjoKZnNbPdOQ==
Message-ID: <3fd004add188460bf2bdd1a718387c7f.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20241202100621.29209-1-johan+linaro@kernel.org>
References: <20241202100621.29209-1-johan+linaro@kernel.org>
Subject: Re: [PATCH] Revert "clk: Fix invalid execution of clk_set_rate"
From: Stephen Boyd <sboyd@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, regressions@lists.linux.dev, Johan Hovold <johan+linaro@kernel.org>, Aishwarya TCV <aishwarya.tcv@arm.com>, Chuan Liu <chuan.liu@amlogic.com>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Johan Hovold <johan+linaro@kernel.org>
Date: Mon, 02 Dec 2024 17:20:06 -0800
User-Agent: alot/0.12.dev1+gaa8c22fdeedb

Quoting Johan Hovold (2024-12-02 02:06:21)
> This reverts commit 25f1c96a0e841013647d788d4598e364e5c2ebb7.
>=20
> The offending commit results in errors like
>=20
>         cpu cpu0: _opp_config_clk_single: failed to set clock rate: -22
>=20
> spamming the logs on the Lenovo ThinkPad X13s and other Qualcomm
> machines when cpufreq tries to update the CPUFreq HW Engine clocks.
>=20
> As mentioned in commit 4370232c727b ("cpufreq: qcom-hw: Add CPU clock
> provider support"):
>=20
>         [T]he frequency supplied by the driver is the actual frequency
>         that comes out of the EPSS/OSM block after the DCVS operation.
>         This frequency is not same as what the CPUFreq framework has set
>         but it is the one that gets supplied to the CPUs after
>         throttling by LMh.
>=20
> which seems to suggest that the driver relies on the previous behaviour
> of clk_set_rate().

I don't understand why a clk provider is needed there. Is anyone looking
into the real problem?

>=20
> Since this affects many Qualcomm machines, let's revert for now.
>=20
> Fixes: 25f1c96a0e84 ("clk: Fix invalid execution of clk_set_rate")
> Reported-by: Aishwarya TCV <aishwarya.tcv@arm.com>
> Link: https://lore.kernel.org/all/e2d83e57-ad07-411b-99f6-a4fc3c4534fa@ar=
m.com/
> Cc: Chuan Liu <chuan.liu@amlogic.com>
> Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---

Applied to clk-fixes

