Return-Path: <linux-kernel+bounces-556713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C933A5CDD4
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 19:25:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05D2D1895BE2
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 18:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8897263F22;
	Tue, 11 Mar 2025 18:24:47 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E6A2263C82;
	Tue, 11 Mar 2025 18:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741717487; cv=none; b=KL0prH6uU0f19RKFH/tL9qXiR/1NvK4aat1pBEu3fESomAXsY58gB7g/bSXQSHpuND0l1DcsEGbF0usuMpkw65yqmKXAVS/FXNSNJTSvrzmBBBuncf7IpWn1szb3nPTXujf+1BCo03fsUjb7x4bAUeYk5544t0mcEXvcB2/yyQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741717487; c=relaxed/simple;
	bh=X/kifDF7vVOvdHV/s2HFBd/9y6wRS9DpCSIfNvNZK1I=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Egv+eUEkm4/rbKkXyiaiY9j/GkjYKrJyz5ZQ9wCsG98Y88/WeDGCWdC02c4FU6GAVM8eRViqGLzWzEILaV/VlbLolz44XgTB/j7U4p4+hfcKqq9Wkj6u10bjYndsmIFskRdzsaaoXYf2TGE89prWI6tVSv3qxa9MWfHqCR6Vm+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA252C4CEEC;
	Tue, 11 Mar 2025 18:24:46 +0000 (UTC)
Received: from wens.tw (localhost [127.0.0.1])
	by wens.tw (Postfix) with ESMTP id 6624F5FA01;
	Wed, 12 Mar 2025 02:24:43 +0800 (CST)
From: Chen-Yu Tsai <wens@csie.org>
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, 
 Andre Przywara <andre.przywara@arm.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <20250307002628.10684-1-andre.przywara@arm.com>
References: <20250307002628.10684-1-andre.przywara@arm.com>
Subject: Re: [PATCH v4 00/14] clk: sunxi-ng: add A523 clock support
Message-Id: <174171748337.1740144.15952522850275241981.b4-ty@csie.org>
Date: Wed, 12 Mar 2025 02:24:43 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Fri, 07 Mar 2025 00:26:14 +0000, Andre Przywara wrote:
> this is the fourth drop of the series introducing basic clock support for
> the Allwinner A523 family of SoCs, comprising A523, A527, T527, H728. [1]
> This times just a small rename of a macro name, and fixing the DT
> binding, where the separate patches for the two CCUs got merged into
> one. For a more detailed changelog, see below.
> 
> *************
> Please note that the clock numbers changed compared to v1 and v2, (but
> not against v3) so DTs from that older era cannot be used anymore with
> this driver: you have to update the DTB. Just copying the binding header
> and recompiling the DTB should do the trick, since the symbols stayed
> mostly the same, at least as far they are used in the basic DTs we use
> today.
> *************
> 
> [...]

Applied to clk-for-6.15 in git@github.com:linux-sunxi/linux-sunxi.git, thanks!

[01/14] clk: sunxi-ng: mp: introduce dual-divider clock
        commit: af7a221c12137271e8c31bc0c205ef4c57e89b4c
[02/14] clk: sunxi-ng: mp: provide wrappers for setting feature flags
        commit: 24ad1a7e8a3eca04dfe225b3e7935ab4ec326bb8
[03/14] clk: sunxi-ng: Add support for update bit
        commit: 38ea575784d3121b9c2e4c0bf425bc669e1c5e1b
[04/14] dt-bindings: clk: sunxi-ng: document two Allwinner A523 CCUs
        commit: 17bed1817f11b7d3c4ea0b38254f1bab78531a3d
[05/14] clk: sunxi-ng: Add support for the A523/T527 CCU PLLs
        commit: 04f6ff49525a8ba8ef3297de3e1a0e15ea3f5102
[06/14] clk: sunxi-ng: a523: Add support for bus clocks
        commit: 2d47dae9398135a48b58da9b059c23027b0e345e
[07/14] clk: sunxi-ng: a523: add video mod clocks
        commit: 4b759de121c46c693b61d6a22bf77d62333838e9
[08/14] clk: sunxi-ng: a523: add system mod clocks
        commit: 9bc061e57b4d97e187a767e45bff06b63f2a3126
[09/14] clk: sunxi-ng: a523: add interface mod clocks
        commit: dd19c52e686eb9f66816cd55fddfae8c7be2e6ea
[10/14] clk: sunxi-ng: a523: add USB mod clocks
        commit: 5fd7421770fb31a1ec35dd2400a849598466ac3b
[11/14] clk: sunxi-ng: a523: remaining mod clocks
        commit: 680f52d723e2ee9d97d167040eacc6a3af0b9cda
[12/14] clk: sunxi-ng: a523: add bus clock gates
        commit: 4548c0414839989be821e106b5128d5e7e13f2a4
[13/14] clk: sunxi-ng: a523: add reset lines
        commit: 9c8d960c13ab41c7e678eab5396b9258eaf8a159
[14/14] clk: sunxi-ng: add support for the A523/T527 PRCM CCU
        commit: 575464821eb0f72c86d93794a79900a853b256b5

Best regards,
-- 
Chen-Yu Tsai <wens@csie.org>


