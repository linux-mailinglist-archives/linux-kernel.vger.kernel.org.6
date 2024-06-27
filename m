Return-Path: <linux-kernel+bounces-232898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F33791AFA4
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 21:28:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36492B21650
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 19:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F062219DF9A;
	Thu, 27 Jun 2024 19:27:47 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3556F200DE;
	Thu, 27 Jun 2024 19:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719516467; cv=none; b=Ine9x/fNEV5Z88JkBzjUeiko7WyFcxJeq+RqwZgqmxY1ysWv722UneU6hHQ5I10KhmI44HIRraiSjbHemcnATs6EyvGGaPuuN0YPW/T2Eu039kslWwIvfAVyC6ZOxD9hRR3mbBCdCDVL+zpzJQqlguEAFMoZQl6JquKd3IXXqgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719516467; c=relaxed/simple;
	bh=AIxltvz37z0MwGC04DKhjiq1CH8cPRjkTMiW/gLdTCI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K6E8gr2w+aG6JdqSJUwUfp92BYmvpEp6/wBED0PvaQMJiqzGEzqJtxT1+rCGNjJx7mQvLXq3kwR8vsT+3r3p4Lgnuzukw4oTa3tkp5NyDNmjwaLnBs9x1kN4zAJB/8aoKJoTfL/bX8cKlmnnlOV2DFf8C1G4h+3TZXslUPFRokc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i53875b6a.versanet.de ([83.135.91.106] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sMumM-0000wK-Ex; Thu, 27 Jun 2024 21:27:34 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Johan Jonker <jbx6244@gmail.com>
Cc: Heiko Stuebner <heiko@sntech.de>,
	linux-clk@vger.kernel.org,
	sboyd@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	mturquette@baylibre.com,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v1] clk: rockchip: rk3188: Drop CLK_NR_CLKS usage
Date: Thu, 27 Jun 2024 21:27:30 +0200
Message-Id: <171951643517.1057727.8364188588167296321.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <1cd309fa-a4d3-4283-aa47-1330a40448a7@gmail.com>
References: <1cd309fa-a4d3-4283-aa47-1330a40448a7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 24 Jun 2024 13:40:03 +0200, Johan Jonker wrote:
> In order to get rid of CLK_NR_CLKS and be able to drop it from the
> bindings, use rockchip_clk_find_max_clk_id helper to find the highest
> clock id.
> 
> 

Applied, thanks!

[1/1] clk: rockchip: rk3188: Drop CLK_NR_CLKS usage
      commit: ec2265dc91307622e43a7d602c3ea425da6f5de1

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

