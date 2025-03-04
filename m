Return-Path: <linux-kernel+bounces-545612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FD7DA4EF41
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 22:14:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96B15165314
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 21:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 086F2264FBD;
	Tue,  4 Mar 2025 21:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="p++C3az+"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1DC3264F8C;
	Tue,  4 Mar 2025 21:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741122892; cv=none; b=ixRT0vHUnugbZ604JyhNeqFz0Vy4BD39ANIxr2dRsJXdQo7mVRvzP0Hl/1hLsXB67RVXXAtQkhcNa6wEOeWe2Ih1wlvmAKadzoQtofysV+jXxdBUfbCwph+erINy2wW/Ld/mIyS6G4ZDaHJJJcMgrq7JU6D8TWPI0iwigzNc3PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741122892; c=relaxed/simple;
	bh=efnq8Mr7Ibo3+ZpAROc7hzy9XWIKXwDMX3NADJ+xG2w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oFZMUpBG+bSuvniqHVGJEbLFjdzPQq432NPlHSwXFHifiLwLjYPCC4i4FOMV4mDd8gxOrz3CMXnAEAQ9rn67iO9GXGVkaiDOHyrgays13iwTXdb2DoEOf1RAk/nxU2DfF/s/dJLKZ5KlIrJbiKlOPkQqK3P9GqQWJivoToR+ezY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=p++C3az+; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=0rIfnbOrf1l0fsM5aMUO2r8IAn6taUUuSG0I0y1QBiA=; b=p++C3az+ikBnh5BzwTYj/7f8ki
	hW7fPGnn2rUPRj4xsGpDFTXIJRR86v3jPX583cyWDlGrRFd8Hs4COTw1tGbYAdWn+sNOGqNBEh3fs
	J+ri/KYCqBaJgOkirKuc5lw00mv57MASyI7IiNYA3vqCiBWA75nr9j91/hvbOLgVlJWvoUFj7IBMf
	frDNmARAVI+LLbWWOgtSVPVXA/oh1fMrQDdS9uP0ealKj7+HXbLdeFbhE3P9I7mPoUDmiJMSsFXny
	llOdGrwkTDNAL1Pi/0PVkp07ZKf6DBgSuvnkYGylWwa0L/bio2EvRyzJduX3N4AlgiptwvVJ4k/g7
	JMwYvPOg==;
Received: from i53875a38.versanet.de ([83.135.90.56] helo=localhost.localdomain)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tpZb9-0006Ex-UJ; Tue, 04 Mar 2025 22:14:44 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: Andy Yan <andyshrk@163.com>
Cc: Heiko Stuebner <heiko@sntech.de>,
	detlev.casanova@collabora.com,
	krzk+dt@kernel.org,
	robh@kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	Andy Yan <andy.yan@rock-chips.com>
Subject: Re: [PATCH v3 0/3] Add display subsystem dt node on rk3576
Date: Tue,  4 Mar 2025 22:14:34 +0100
Message-ID: <174112278794.341367.445088781126200714.b4-ty@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20241231095728.253943-1-andyshrk@163.com>
References: <20241231095728.253943-1-andyshrk@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 31 Dec 2024 17:57:17 +0800, Andy Yan wrote:
> As the VOP[0] and HDMI[1] driver have already been submitted for review.
> This series enable hdmi display on sige5 board.
> 
> [0] https://lore.kernel.org/linux-rockchip/20241231090802.251787-1-andyshrk@163.com/T/#t
> [1] https://lore.kernel.org/linux-rockchip/20241231094425.253398-1-andyshrk@163.com/T/#t
> 
> Changes in v3:
> - Split from https://lore.kernel.org/linux-rockchip/3330586.aeNJFYEL58@diego/T/#t
> 
> [...]

Applied, thanks!

[1/3] arm64: dts: rockchip: Add vop for rk3576
      commit: d74b842cab0860e41a45df0dac41e4e56202c766
[2/3] arm64: dts: rockchip: Add hdmi for rk3576
      commit: ad0ea230ab2a3535b186f7fb863b4bca7050e06f
[3/3] arm64: dts: rockchip: Enable hdmi display on sige5
      commit: 2062b91b9f3c6afe9c2a7d1ddf0f3e6af5f3fa31

I've adapted the patches where needed.
- Moved the grf to it's address-related position
- updated the irq names

With all the driver patches in place, dtbscheck for the sige5 is happy.


Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

