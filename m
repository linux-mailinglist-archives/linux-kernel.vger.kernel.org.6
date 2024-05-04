Return-Path: <linux-kernel+bounces-168593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D657C8BBA96
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 12:51:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C7A0B21917
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 10:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D839C1BF3F;
	Sat,  4 May 2024 10:51:42 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E2C45258;
	Sat,  4 May 2024 10:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714819902; cv=none; b=nxZk9XLBdpSR3sXuqpx8uTuOyG3u3rzKzKLDBfzDVJUvOdGN860aHsP0gqpf2js02FpRWHwzPIOnjgG/EFtLQNEHn6PRO3zHC9FxoAX83/EobocZBmrChjYdlwyDRV5AkzwL67M+MklxNru2wFnewfy5/BHyyiWuOz7GKDX9PRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714819902; c=relaxed/simple;
	bh=X4Il8DnsZvuxyI5MynZ0dTBzMmmyjgraR9bTmVYz6dE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Na4YP6i8FKXVT1+QkTUelDsIF3jz6oU7sQU4gkUtz4o68brzptAy84jkqcwGFvAFaqYcK1Xnk/csr8jvzs3Egc95QcVbypOPhEVYjyvBcwa42K5dHIrrXN3WgDOGH6ZAT6VJF1MKkXl1kDVUt5inQo6wCmKU3JuPUmAWnRxPdHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i53875b5d.versanet.de ([83.135.91.93] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1s3CzM-0001m9-Ud; Sat, 04 May 2024 12:51:33 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Stephen Boyd <sboyd@kernel.org>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Michael Turquette <mturquette@baylibre.com>
Cc: Heiko Stuebner <heiko@sntech.de>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kernel-janitors@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-clk@vger.kernel.org
Subject: Re: [PATCH] clk: rockchip: Remove some unused fields in struct rockchip_mmc_clock
Date: Sat,  4 May 2024 12:51:30 +0200
Message-Id: <171481988029.3538483.14745694145472160421.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <410bc0f86c7b9f1c80f8a4e9a2a028a9a6ee1ec0.1713970085.git.christophe.jaillet@wanadoo.fr>
References: <410bc0f86c7b9f1c80f8a4e9a2a028a9a6ee1ec0.1713970085.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 24 Apr 2024 16:48:29 +0200, Christophe JAILLET wrote:
> In "struct rockchip_mmc_clock", the 'id' field is unused.
> Remove it.
> 
> Found with cppcheck, unusedStructMember.
> 
> 

Applied, thanks!

[1/1] clk: rockchip: Remove some unused fields in struct rockchip_mmc_clock
      commit: 947b8f2a8b5155f6e9560af07ed65b3cc9aecd75

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

