Return-Path: <linux-kernel+bounces-523936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 770BAA3DD12
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 15:39:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF072164477
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 14:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8A241FC7F1;
	Thu, 20 Feb 2025 14:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NhM6oLP6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14C8C1F8BAA
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 14:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740062309; cv=none; b=G+pXfgVeRNOJcBl97EdzloPbu32Qu8VjUQv8vUfJUOPyFFMCfzk+r3+9HDgZcxRyVNJUkk3fZGmVRS9xYbUY8WtUG11VUnyJxkZaWR06d1ZVLjeI/oXDgDu8yNMB8OrLkG+PyDmF2IouMrHiC4LBpymnYYvNc6oI8A0Vacg0CEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740062309; c=relaxed/simple;
	bh=PWmPBLuDRgye1gNs6Wx8IS7+hGhGH+EAlo2QUipgP7k=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=QClhaKJTS2prB0ECuoEket6r+yT+WWuOvpwtCYZCl491z/JQmkMGWWMMVeByO2XOkHy2dyuQhoBFNfpV08GNDAQJilcTgcuV2yIUKp17cF+1yr4IeNCq5ZSVD05ybw3+8ZPhVIW+94TQSWTHs0z9ij/kMlN++Ir6ekVD+pZjHU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NhM6oLP6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF12DC4CEDD;
	Thu, 20 Feb 2025 14:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740062308;
	bh=PWmPBLuDRgye1gNs6Wx8IS7+hGhGH+EAlo2QUipgP7k=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=NhM6oLP6dHojmfS2MKVxw10ds1n09pnulGlH8FAaHF+n1D8Ze7ZPu5KV55mtTZpOi
	 gNFexXEpm01CLGBA1eur1r3DvGsTr9sjD+Q6QPMegZepUF0mL6104oRkWbSOzijuK5
	 AAYiR5ZnFO5hMHNdtkqpHPXssFdZ5AsnXHGS7RliEdwpXx5apSrRZgXPq3LI37Lj9E
	 ofnbxWmXhL4yTJ8DYUb+RmATi4XlQSj+Wy3+EtS/a1PuGDyR9yRudWCRR7qBcmmLrT
	 JRAppELBEvM5b2+g3Qe4oHxa9MEBldZKdW19ZiKeSTJERQflINItXWN4wm5l4JKe+T
	 1efH9S0kaQ6xw==
From: Lee Jones <lee@kernel.org>
To: Lee Jones <lee@kernel.org>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20250212170403.36619-2-u.kleine-koenig@baylibre.com>
References: <20250212170403.36619-2-u.kleine-koenig@baylibre.com>
Subject: Re: (subset) [PATCH] mfd: lp3943: Drop #include <linux/pwm.h> from
 header
Message-Id: <174006230763.778030.7610774481769488318.b4-ty@kernel.org>
Date: Thu, 20 Feb 2025 14:38:27 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev-510f9

On Wed, 12 Feb 2025 18:04:03 +0100, Uwe Kleine-König wrote:
> The header doesn't make use of any symbols declared in <linux/pwm.h>.
> There are tree files that #include <mfd/lp3943.h>. Two of them
> (i.e. drivers/gpio/gpio-lp3943.c and drivers/mfd/lp3943.c) also don't
> use any and the third (drivers/pwm/pwm-lp3943.c) has an explicit include
> of <linux/pwm.h> itself.
> 
> So drop the unused include. The intended side effect is that
> drivers/gpio/gpio-lp3943.c and drivers/mfd/lp3943.c stop importing the
> "PWM" module namespace.
> 
> [...]

Applied, thanks!

[1/1] mfd: lp3943: Drop #include <linux/pwm.h> from header
      commit: 3a7db8a6dee5a2c1858678ddf2d7d38128a9caf3

--
Lee Jones [李琼斯]


