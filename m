Return-Path: <linux-kernel+bounces-390846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BBD59B7F11
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 16:52:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60835281485
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 15:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E81101A4F0C;
	Thu, 31 Oct 2024 15:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HuUkXO/x"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD4B19B59C;
	Thu, 31 Oct 2024 15:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730389903; cv=none; b=FRp8X+uWC4nT+7ZhyCjL8+P+brQLBCf5JdsoAvWf5z0aCjVUabqseMrgzyeHtx+58VxjQfvv2IkiBz16DfN6ao5OcmhUTubVvGDuElLg8lmaLvZN9Yai8284NLfUKUwwg7r60D/gqiA+gi3KTkI6Nny4TfUNfi/q3YtzWqIfjSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730389903; c=relaxed/simple;
	bh=WivZL725Ki/1pUOgmZWpT/+Ixrb99680JnJjkTk1UM8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=hjMc8h4gveKnnB6Zj8z4aJEYx5CmGGY2sr1CscwZmfPXlTSVzzjaY1r6lCNyBvQ4uUFGedXSiGjKzrng0MKm5932sWv0mVmg6gKrtSp+lowG83AdJ8PnSAwZAIsEFGY3x5gIEwPtoV7OTcgtAs7MouWpNgNbqO/W+C4fj1kjSjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HuUkXO/x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B32CC567E3;
	Thu, 31 Oct 2024 15:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730389901;
	bh=WivZL725Ki/1pUOgmZWpT/+Ixrb99680JnJjkTk1UM8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=HuUkXO/xIJ8kZhK8e5Gr+HjAF2w75nBYAj0uypV++3m/LEDVkN+jFixZJ/CNq+8OQ
	 DAJ9ZcZ6nUzO8eAWFV0Je1NWLfIjBlfiVApPuf8sdYl57G9Lsbn9SzpZTGzL1uhr3u
	 bcvCJlTG+Vdho46cDkeShhkHJp7AyoWvURGp1X8ThZNwZFwYzuqYNBa94/UFdE+Yia
	 bYW0lX1nGEm5CmQ1b11z9PoTjOZZycIGPv3nlx/rYU446KhGUt4ztk8lrzqvApsHBY
	 awN6ycAnqx7VrOVLFhmLkoLLP2MZ9qgQavtyPaG8vj+xE8S2ZLpqDJbDRVh2crFaqP
	 2tHk4BuPhHz1w==
From: Lee Jones <lee@kernel.org>
To: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Andre Przywara <andre.przywara@arm.com>
Cc: devicetree@vger.kernel.org, linux-sunxi@lists.linux.dev, 
 linux-kernel@vger.kernel.org, Martin Botka <martin.botka@somainline.org>, 
 Chris Morgan <macromorgan@hotmail.com>
In-Reply-To: <20241007001408.27249-1-andre.przywara@arm.com>
References: <20241007001408.27249-1-andre.przywara@arm.com>
Subject: Re: [PATCH v2 0/5] regulator: add X-Powers AXP323 support
Message-Id: <173038989913.1784644.2617880426369954438.b4-ty@kernel.org>
Date: Thu, 31 Oct 2024 15:51:39 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13.0

On Mon, 07 Oct 2024 01:14:03 +0100, Andre Przywara wrote:
> A small update of version, just changing the regmap cache type to maple
> tree, and adding the accrued tags (thanks to the reviewers!).
> ================================
> The X-Powers AXP323 is a close sibling to the AXP313a PMIC, only that it
> allows to dual-phase the first two DC/DC converters. This is controlled
> via a new register. On the first glance that would sound like a
> compatible extension, but any random AXP313a driver would not know about
> the potential dual-phase nature of the second DCDC rail, so might want
> to turn that off, spoiling the whole setup. So this patchset introduces
> a new compatible string, without any fallbacks.
> 
> [...]

Applied, thanks!

[1/5] dt-bindings: mfd: x-powers,axp152: Document AXP323
      commit: bd91530aee6007a979e52d816779a6e10ed8c00a
[2/5] mfd: axp20x: ensure relationship between IDs and model names
      commit: 697a4001d31a607a72c6297e4eb0f7918c6e6929
[3/5] mfd: axp20x: Allow multiple regulators
      commit: e37ec32188701efa01455b9be42a392adab06ce4
[4/5] mfd: axp20x: Add support for AXP323
      commit: 35fec94afe045856456faca4879b9c560e39d1e3
[5/5] regulator: axp20x: add support for the AXP323
      commit: a0f8a8898e120d5a3f14cd22289daa3709d83f5b

--
Lee Jones [李琼斯]


