Return-Path: <linux-kernel+bounces-527835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9E73A41057
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 18:03:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDDF716DB88
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 17:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 449A3142903;
	Sun, 23 Feb 2025 17:03:29 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D662243ABC;
	Sun, 23 Feb 2025 17:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740330208; cv=none; b=UobB2yVOniWfU8cY3bjy/TnfL1ItvZDflXzW8lxJ5CD19i3ljpEm+AjXylwONWwGxf0aEp7vtoAxYcDYJQsirtGz+1bjWhxPiaXraxeNf3j/t57UGbGI85h2fxlKqNhHDuLN8fmUOZ7b8akX0xPgGbdo/JXZJWJdbCwfRkjU/RQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740330208; c=relaxed/simple;
	bh=PWCFCQ/T5g668OH6p7aI1iAwePp1QD64+FkFE7rzkbg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=JJc4x1S7X5pj1QVe1gMt52NAnTDjwA7JgyRyRafFDOe1Lw0QiS6X5JXYKBofGp0LTrdVaLQ5bBvv6WLFAuVMxePxhpHV83mn1Mha3zCFt122u2+t+SF0v48W1me0wEfcfkJMFSVpvVKdOQDHc67nvgQlNvuma9mY+HAOy1IIO4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 351EEC4CEDD;
	Sun, 23 Feb 2025 17:03:28 +0000 (UTC)
Received: from wens.tw (localhost [127.0.0.1])
	by wens.tw (Postfix) with ESMTP id 97A795FCC4;
	Mon, 24 Feb 2025 01:03:25 +0800 (CST)
From: Chen-Yu Tsai <wens@csie.org>
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, linux-clk@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
 linux-kernel@vger.kernel.org, Philippe Simons <simons.philippe@gmail.com>
Cc: Andre Przywara <andre.przywara@arm.com>
In-Reply-To: <20250220113808.1122414-2-simons.philippe@gmail.com>
References: <20250220113808.1122414-1-simons.philippe@gmail.com>
 <20250220113808.1122414-2-simons.philippe@gmail.com>
Subject: Re: [PATCH v3 1/1] clk: sunxi-ng: h616: Reparent GPU clock during
 frequency changes
Message-Id: <174033020559.3257225.10440748576870743856.b4-ty@csie.org>
Date: Mon, 24 Feb 2025 01:03:25 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Thu, 20 Feb 2025 12:38:08 +0100, Philippe Simons wrote:
> The H616 manual does not state that the GPU PLL supports
> dynamic frequency configuration, so we must take extra care when changing
> the frequency. Currently any attempt to do device DVFS on the GPU lead
> to panfrost various ooops, and GPU hangs.
> 
> The manual describes the algorithm for changing the PLL
> frequency, which the CPU PLL notifier code already support, so we reuse
> that to reparent the GPU clock to GPU1 clock during frequency
> changes.
> 
> [...]

Applied to clk-for-6.15 in git@github.com:linux-sunxi/linux-sunxi.git, thanks!

[1/1] clk: sunxi-ng: h616: Reparent GPU clock during frequency changes
      commit: eb963d7948ce6571939c6875424b557b25f16610

Best regards,
-- 
Chen-Yu Tsai <wens@csie.org>


