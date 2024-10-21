Return-Path: <linux-kernel+bounces-374527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9F7D9A6B90
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 16:07:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A953D283C36
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 14:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8133E1F8EE6;
	Mon, 21 Oct 2024 14:06:05 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F0191EF93E
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 14:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729519565; cv=none; b=KOC0zwKNBrhhP+IfH3peo7Tt4PaThsKbQL78ysXcaUGJLz1btnBY1S+6XKKaZ9Ovg4mYdy077H2h13G4wzFLfblaadX4TX0l8jjTdAf6gMqxqXToC1WomRtjV44wWfzYb9GZ+pGgWRLVItp64iPPTzxxC+ZbhDiHXCUty5t1o68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729519565; c=relaxed/simple;
	bh=RdSbHwplxKkRtpn4nU2crh0BEc1V2zUy2aWfL7hIpUo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=f7lZ5PkODDeg4tLtYFy83YsDciJ1iFh0Jvci9+8Oxv1DyNltH1NftevZptda/WChyvfgLFRI7aCYX6swtUZ5Qw413jUHRw5E8P3qHF7OyJe7mLgRecWV8XVyeZTL7jUKiBQvxJXz6mJRGjW0Kl/SO/aO5k7qpw9EGFefVsiH4hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BA75C4CEC3;
	Mon, 21 Oct 2024 14:06:04 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id 1DECF106045D; Mon, 21 Oct 2024 16:06:02 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Andrew Davis <afd@ti.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20241010203622.839625-6-u.kleine-koenig@baylibre.com>
References: <20241010203622.839625-6-u.kleine-koenig@baylibre.com>
Subject: Re: [PATCH] power: Switch back to struct platform_driver::remove()
Message-Id: <172951956208.338778.8570247421746540890.b4-ty@collabora.com>
Date: Mon, 21 Oct 2024 16:06:02 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14.2


On Thu, 10 Oct 2024 22:36:24 +0200, Uwe Kleine-König wrote:
> After commit 0edb555a65d1 ("platform: Make platform_driver::remove()
> return void") .remove() is (again) the right callback to implement for
> platform drivers.
> 
> Convert all platform drivers below drivers/power/ to use .remove(), with
> the eventual goal to drop struct platform_driver::remove_new(). As
> .remove() and .remove_new() have the same prototypes, conversion is done
> by just changing the structure member name in the driver initializer.
> 
> [...]

Applied, thanks!

[1/1] power: Switch back to struct platform_driver::remove()
      commit: 83bce34420eaf91506957703bf9a31d8581ed6cb

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


