Return-Path: <linux-kernel+bounces-173521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A07538C019F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 18:00:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0EF21C2368B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 16:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFFE6128803;
	Wed,  8 May 2024 16:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lT/PAzn2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 101F98120A
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 16:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715184048; cv=none; b=sCYntXk0xm7s/I7ZeWQAvxOiDKKNC4ZKR7PA8auFKxDuCwSbryP/fJ6WXV6QBnfWTVdYbgsSehj86oHBOrL6984IfZ7J+eqGrQOW9Z2AHzRF8C2VUIIjeNco0+mGj0BkoRqmoNtTUYY+atdK1o1Fvh17jPymXtHyXch57UtFY44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715184048; c=relaxed/simple;
	bh=s1jMyTsA7Ye0HsBT8VZWy21F0PHyAdseWD7TaHSOGVg=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=h8TeSeV7dmrh0TbRx6uSZlw1kvlLvuHSUQljvCrLSOP40pnXA1geYDB+91izO85qSqkPlmFioVIto0j4GNwFP1o0fEnEfnz2zRqH4R5t22qK1wtC3O3rmJSACDIYyGUENhaf4D/+dxZgDeHNpzGVsSjhCubhfzABfT4DQ19VVhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lT/PAzn2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A28EEC113CC;
	Wed,  8 May 2024 16:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715184047;
	bh=s1jMyTsA7Ye0HsBT8VZWy21F0PHyAdseWD7TaHSOGVg=;
	h=Date:From:To:Cc:Subject:From;
	b=lT/PAzn2NPzcqAkpnIg9YY7QMqcE1dmvil8XyowbWozMlC+qUJuRKQvrSRiymj6l1
	 9TrzoFO1AnrvFF9LSUzV/eX9u+bQziVPVezKNbycc3rROb2EGNAaGJBHJwOtG8xsQ/
	 a7lzijbLNVz7sUAxHh3B4t/+sK6NpgeejauqlnADwgy+zWz0yrbsiH0i2L6AkmcHf7
	 iSSW70fEYyeLU7SaIiBx04EtctNGdy/yTINb6AaT8tG+PI/OxC8eWsSlIHMyx5XGb7
	 K1cclprA2xeTOWThxSYvQ4JNc4ge+OKKLX6BXCadYtBLYNDL8I3QfGTMzrSPriOQkT
	 JgdMMdXuQZzsw==
Message-ID: <2089edf5-0257-47ec-82b8-ee61c9430241@kernel.org>
Date: Thu, 9 May 2024 01:00:39 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Chanwoo Choi <chanwoo@kernel.org>
Content-Language: en-US
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Chanwoo Choi <cw00.choi@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>,
 MyungJoo Ham <myungjoo.ham@samsung.com>, Chanwoo Choi <chanwoo@kernel.org>
Subject: [GIT PULL] devfreq next for 6.10
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Dear Rafael,

This is devfreq-next pull request for v6.10. I add detailed description of
this pull request on the following tag. Please pull devfreq with
following updates.

Best Regards,
Chanwoo Choi


The following changes since commit dd5a440a31fae6e459c0d6271dddd62825505361:

  Linux 6.9-rc7 (2024-05-05 14:06:01 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git tags/devfreq-next-for-6.10

for you to fetch changes up to ccad360a2d415447bd6f0de9e873eec05442d159:

  PM / devfreq: exynos: Use DEFINE_SIMPLE_DEV_PM_OPS for PM functions (2024-05-09 00:30:37 +0900)

----------------------------------------------------------------
Update devfreq next for v6.10

Detailed description for this pull request:
- Convert to platfrom remove callback to .remove_new ops for following drivers
: exyno-nocp.c/exynos-ppmu.c/mtk-cci-devfreq.c/sun8i-a33-mbus.c/rk3399_dmc.c

- Use DEFINE_SIMPLE_PM_OPS for exyno-bus.c driver
----------------------------------------------------------------
Anand Moon (1):
      PM / devfreq: exynos: Use DEFINE_SIMPLE_DEV_PM_OPS for PM functions

Uwe Kleine-König (5):
      PM / devfreq: exynos-nocp: Convert to platform remove callback returning void
      PM / devfreq: exynos-ppmu: Convert to platform remove callback returning void
      PM / devfreq: mtk-cci: Convert to platform remove callback returning void
      PM / devfreq: sun8i-a33-mbus: Convert to platform remove callback returning void
      PM / devfreq: rk3399_dmc: Convert to platform remove callback returning void

 drivers/devfreq/event/exynos-nocp.c | 6 ++----
 drivers/devfreq/event/exynos-ppmu.c | 6 ++----
 drivers/devfreq/exynos-bus.c        | 9 +++------
 drivers/devfreq/mtk-cci-devfreq.c   | 6 ++----
 drivers/devfreq/rk3399_dmc.c        | 6 ++----
 drivers/devfreq/sun8i-a33-mbus.c    | 6 ++----
 6 files changed, 13 insertions(+), 26 deletions(-)

