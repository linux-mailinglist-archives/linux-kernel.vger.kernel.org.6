Return-Path: <linux-kernel+bounces-537459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17514A48C12
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 23:55:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21F0416D4CF
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 22:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECB7223E32E;
	Thu, 27 Feb 2025 22:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iGTUEjAd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54EFF21CC53;
	Thu, 27 Feb 2025 22:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740696903; cv=none; b=QwVGHeRQXx2IE558gqtlyPZUhZfVE4hjQbyuNnGmW6TxmDglisvWe0ZJPpYdZES8S/HWxhF2LRPUGnkwJhexST28bSSZrVU0MZf4TdWuiuIf+8kb3y0V3fXrAuDhCnmBp6h5EBLCojYxPK9EM2So/LFUfgYV/JF0LHqfpjcfBDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740696903; c=relaxed/simple;
	bh=9M9wgjf5Eku3KGzfU/Spz3evA/7ijTJ6zhkFNKmluts=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=WlQA0FPNPsWCoFa1SWxVHCwLWHJ0oLr+DnQl4zbxZ1Bj4fzJM9S0fWtBR+Jt+H7AFHRNcNtgmoS/SS+br1mKv37h07Omqlgbmbnw3IF5sL4Fwb6EsdNtQG9qKzmXEkfXwi56En3NQdye8Ov/1DQr747qgl1bg+TBzDGtyTZKg5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iGTUEjAd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA2C7C4CEE5;
	Thu, 27 Feb 2025 22:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740696902;
	bh=9M9wgjf5Eku3KGzfU/Spz3evA/7ijTJ6zhkFNKmluts=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=iGTUEjAdoa+AEcKSIz7YTUkqwuibJdq7HdrpnSPAot2i4LDqimrqFLjnOY3uop015
	 OBNS6/3/hyivaNYzAl+skCbD+IFjwVOQ9YaN0sn21wKiCJhlpGv3LDjpSYRqto+zSi
	 R1kjqxgi5Ho1UoJyB9KJqBCvUdC3QsCmo9LHGD8SD5GXABdTWl/wOk/aITHLlX7KvH
	 sKHoltNlmYJaGqhGMV8PRFwb+k1DlBY/orWCp7ERwPK5DJTAXLPRvpqmBqvaNo7vY4
	 95lDTV84TZ6ggRUWc7y6ESsHgacRmawXtXfC50WyUo6326L5mH6lAqjfLnn1ReIf7k
	 1CNGnQiJvj16w==
Message-ID: <5109de7fe1a1a8467118daf80c7b7f8a.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1j4j205ark.fsf@starbuckisacylon.baylibre.com>
References: <20241220-amlogic-clk-drop-clk-regmap-tables-v1-0-96dd657cbfbd@baylibre.com> <20241220-amlogic-clk-drop-clk-regmap-tables-v1-2-96dd657cbfbd@baylibre.com> <9f1d69ebe1ddce5dfc170e986c9213f2.sboyd@kernel.org> <1ja5cp8f87.fsf@starbuckisacylon.baylibre.com> <88fe909ab182d1f17f6ef18161c7f064.sboyd@kernel.org> <1jfrlwb69r.fsf@starbuckisacylon.baylibre.com> <ed20c67e7d1a91d7fd8b921f156f56fb.sboyd@kernel.org> <1jmsg2adgu.fsf@starbuckisacylon.baylibre.com> <697b634770d789ef8ff0e05cec9465f5.sboyd@kernel.org> <1j4j205ark.fsf@starbuckisacylon.baylibre.com>
Subject: Re: [PATCH 2/3] clk: amlogic: drop clk_regmap tables
From: Stephen Boyd <sboyd@kernel.org>
Cc: Kevin Hilman <khilman@baylibre.com>, Martin Blumenstingl <martin.blumenstingl@googlemail.com>, Michael Turquette <mturquette@baylibre.com>, Neil Armstrong <neil.armstrong@linaro.org>, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org
To: Jerome Brunet <jbrunet@baylibre.com>
Date: Thu, 27 Feb 2025 14:55:00 -0800
User-Agent: alot/0.12.dev1+gaa8c22fdeedb

Quoting Jerome Brunet (2025-01-15 07:58:55)
>=20
> I'd like to register controller init hook to apply on all the clocks of
> a particular type. The reason to do that is to drop the big clk_regmap
> table that are a pain to maintain (in addition to be ugly). I hoped it
> would also save a bit of memory.
>=20
> The solutions we've been discussing so far feels like we are moving
> around the problem, recreating the memory saved somewhere else,
> perhaps in a more complicated way. I'd like to find something more
> convinient to use, which does not scale the memory used with the number
> of clock registered. The point is not a different hook for clk_hw after
> all.

What are the goals?

 1. Drop clk_regmap table
 2. Reduce memory
 3. ??

>=20
> Here is an idea, how about list of hook identified by ops and controller ?
>=20
> The node would look like this
>=20
> struct clk_type_init_node {
>        struct list_head         entry;
>       =20
>        struct device_node       *of_node;
>        struct device            *dev;
>        const struct clk_ops     *ops;
>=20
>        int (*init_hook)(struct clk_hw *hw);
> };
>=20
> The change would be minimal in core CCF, just searching the list for a
> match in clk_register. On most platform the list would be empty so there
> is virtually no penalty when it is not used.
>=20
> From the controller, the usage would be very simple, just calling a
> function before registering the clocks, something like:
>=20
> int clk_type_register_dev_hook(struct device *dev,
>                                const struct clk_ops *ops,
>                                int (*init_hook)(struct clk_hw *hw))
>=20
> or the 'of_node' equivalent.

Why can't we register the clk at the same time? I don't understand why
we want to search a list to match something up to what could be another
argument to the clk registration API. Isn't this the same as=20

 clk_hw_register_data(struct device *dev, struct clk_hw *hw, const struct c=
lk_register_data *data)

Why is that hard to maintain? Is that because the clk driver is
registering various different types of clks and it wants to do different
stuff depending on the type of clk? Why wouldn't wrapping the clk_ops
in another struct and then using container_of to find the custom clk_ops
not work there?

>=20
> I admit this is heavily inspired by how devres works :) but it does solve
> the early clock controller problem and does not scale with the number of
> clock registered.
>=20

I don't know if devres is a good model. It's about tracking allocations
and things to undo later, not really to track things to do when called
initially.

