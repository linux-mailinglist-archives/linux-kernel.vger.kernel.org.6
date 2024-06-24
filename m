Return-Path: <linux-kernel+bounces-227904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0A309157F2
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 22:25:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91DE31F215BE
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 20:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FC021A0726;
	Mon, 24 Jun 2024 20:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HiKMBa/k"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7371A01AD;
	Mon, 24 Jun 2024 20:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719260719; cv=none; b=LpeCkamrmEKbEDg+laG2sYlGjO1Yx8l5EZs7dur0XBTYB+vchcZEJ5iGXOUE9XSJNr0StEwXCMYTjhWouRbhchNZFemMqlFwcQwI16Zyb8r1uoPY+RvXhusp4ik1VUR30uXn9KaEWYq8l9/yEahK8j0H34u9lB4hk7YcR9qbxHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719260719; c=relaxed/simple;
	bh=Fdq+OcitQnYEPP9+kNdjQc7D1WlpTYAAifc1gtkVyRM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XQ0iPsAgoi1hWD2r2g/EaXM0/aRb652xMYDiAeG7WM0BN6dj3QWckoWD/8MCgJzIuXmzZhahPtfVYnNmPRseyRjOEhDlj9x9mCq+LPYq3y4ka5nAVDtuLyyzcC7QTAOyDHSDwGn72sB54D3bWBPUluY0VZV+E6Rz2uA4yqsy/rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HiKMBa/k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 177D1C2BBFC;
	Mon, 24 Jun 2024 20:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719260719;
	bh=Fdq+OcitQnYEPP9+kNdjQc7D1WlpTYAAifc1gtkVyRM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HiKMBa/kqOJlHMLOaTWQW6+Yy0lW5X+cwIa+W8iHSg3iUjI2GTBITPqchAm/UK6/u
	 wZU4JozlsKF6V4AXrurrj6OSaspAhNgPs6jLmk4rpHbY7UrPB+xB+QHhMevCYrDdwK
	 1T+3T0MCRvPmCYOT5jc4PsNT4kgRwHdOJgZFbPzBaFTeSktAUuE2e0EooNJ+oAvZvt
	 l04jDONpSkTgVqmZXLdVBXgM+0qbmEMqh52AbOFd4zNi3q+GTAqfSKnbY8AjvzuR8/
	 F2ojkL03CaeLE9h3PurS6faaRZRj+50WYIqE6A2ZbCMi9xnO07D3BAkXf16qyZmXnl
	 I8hkK+/kJ3P9w==
Date: Mon, 24 Jun 2024 14:25:17 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Stanislav Jakubek <stano.jakubek@gmail.com>
Cc: Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
	Michael Turquette <mturquette@baylibre.com>,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] dt-bindings: clock: drop obsolete stericsson,abx500.txt
Message-ID: <171926071549.350046.4840202614412404395.robh@kernel.org>
References: <Zm7I2Zbq1JNPoEJp@standask-GA-A55M-S2HP>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zm7I2Zbq1JNPoEJp@standask-GA-A55M-S2HP>


On Sun, 16 Jun 2024 13:13:29 +0200, Stanislav Jakubek wrote:
> These bindings are already (better) described in mfd/stericsson,ab8500.yaml,
> drop these now obsolete bindings.
> 
> Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>
> ---
>  .../bindings/clock/stericsson,abx500.txt      | 20 -------------------
>  1 file changed, 20 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/clock/stericsson,abx500.txt
> 

Applied, thanks!


