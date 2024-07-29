Return-Path: <linux-kernel+bounces-266404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89A7293FF6B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 22:29:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C34251C22782
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 20:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 293701946B3;
	Mon, 29 Jul 2024 20:21:25 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43608194158;
	Mon, 29 Jul 2024 20:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722284484; cv=none; b=fvcYEPKJFtnJ3oLMG+7f/1I62vsjaqC05aNohRoii6G6DCjLYbSSvuLyAY4sSk5y34GCfwuu2oXVB4qLr3MXK29SahOYxTP3gK0Yn8BBL9tDW/9G5crS+PZvTP52Mm+aboKAzvkWp+w+6uHOxslaHlVGvnK27A/rndhzHmZW/oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722284484; c=relaxed/simple;
	bh=k9KGj+kKNy8NHgo4/ds736QbkWWf2Qqr6fwDZk/bya4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N4apCaNcsSJ7tPHOSzykAGH0Cap5t2N6BrBjm0+Bc2Z8pevWgmMcAOi1dcWA+ojtWyHJPdTSZAVpujdHgwcyrobCpFUfenuQT61Kj3JdWccPgcAJyMt0WrZl2HdB8L2FMHdxJG5fvTsxM4dlik6fXKvcqJOYMiCGJxXurbNKPWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i5e86192c.versanet.de ([94.134.25.44] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sYWro-0007Xp-Sl; Mon, 29 Jul 2024 22:21:12 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: linux-rockchip@lists.infradead.org,
	Dragan Simic <dsimic@manjaro.org>
Cc: Heiko Stuebner <heiko@sntech.de>,
	conor+dt@kernel.org,
	krzk+dt@kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Marek Kraus <gamiee@pine64.org>,
	linux-kernel@vger.kernel.org,
	robh@kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: rockchip: Correct the Pinebook Pro battery design capacity
Date: Mon, 29 Jul 2024 22:21:03 +0200
Message-Id: <172228429362.2312452.9693627001508477448.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <731f8ef9b1a867bcc730d19ed277c8c0534c0842.1721065172.git.dsimic@manjaro.org>
References: <731f8ef9b1a867bcc730d19ed277c8c0534c0842.1721065172.git.dsimic@manjaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 15 Jul 2024 19:44:20 +0200, Dragan Simic wrote:
> All batches of the Pine64 Pinebook Pro, except the latest batch (as of 2024)
> whose hardware design was revised due to the component shortage, use a 1S
> lithium battery whose nominal/design capacity is 10,000 mAh, according to the
> battery datasheet. [1][2]  Let's correct the design full-charge value in the
> Pinebook Pro board dts, to improve the accuracy of the hardware description,
> and to hopefully improve the accuracy of the fuel gauge a bit on all units
> that don't belong to the latest batch.
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: rockchip: Correct the Pinebook Pro battery design capacity
      commit: def33fb1191207f5afa6dcb681d71fef2a6c1293

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

