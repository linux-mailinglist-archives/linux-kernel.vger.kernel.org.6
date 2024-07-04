Return-Path: <linux-kernel+bounces-241579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D9963927CC5
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 20:02:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92324285E39
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 18:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2876137748;
	Thu,  4 Jul 2024 18:01:39 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A2344C7B;
	Thu,  4 Jul 2024 18:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720116099; cv=none; b=p1VQ2PFNz2zgodQPrtGTK1M6boZMIJ2MHTE8AJcavmqhOMtXgqaxmQeF9ae2m0Q34g2svpqvi5LOfxX7D8OPGEqzdGF8YGbpvPBGQtnelbKZIxol0yqJFlQjLI1sEDc+bHYs/BM8GCRBj5VSAD07iix2+V8mwFXL062V6ItFkXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720116099; c=relaxed/simple;
	bh=R+kpNLrPOZ8DFsGHkzXTqCKsfUQl59ug6iudnuDqx4M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UHLhiIjy6dqT21FqUWcWGD/Y8kPL7REpslVlKmD2qwLNGfntGfYjX5+dtVpUL/nA+XerJeb1BBIs68dgXcvAxNXFN6ahoDu4sUBWVbT1SSROsanGSAdPfr2TPs6S2P/KQFXIBoLiwu+KUxFApA98q9wWDpRq+hTIiH3oOut1D+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i53875ac2.versanet.de ([83.135.90.194] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sPQlt-00049m-5j; Thu, 04 Jul 2024 20:01:29 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Dragan Simic <dsimic@manjaro.org>,
	linux-rockchip@lists.infradead.org
Cc: Heiko Stuebner <heiko@sntech.de>,
	linux-kernel@vger.kernel.org,
	robh@kernel.org,
	didi.debian@cknow.org,
	linux-arm-kernel@lists.infradead.org,
	jonas@kwiboo.se,
	krzk+dt@kernel.org,
	devicetree@vger.kernel.org,
	conor+dt@kernel.org
Subject: Re: [PATCH v3 0/2] Add and update GPU OPP voltage ranges in the RK356x SoC dtsi
Date: Thu,  4 Jul 2024 20:01:24 +0200
Message-Id: <172011606369.897267.6994750929052061276.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1719763100.git.dsimic@manjaro.org>
References: <cover.1719763100.git.dsimic@manjaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Sun, 30 Jun 2024 18:00:39 +0200, Dragan Simic wrote:
> The first patch in this series adds support for voltage ranges to the GPU
> OPPs defined in the SoC dtsi for Rockchip RK356x, which is, for example,
> useful for RK356x-based boards designed to use the same power supply for
> the GPU and NPU portions of the SoC.
> 
> The second patch updates the values for the exact GPU OPP voltages and
> the lower limits for the GPU OPP voltage ranges, so they match the most
> conservative values (i.e. the highest per-OPP voltages) found in the
> vendor kernel source.  This is performed in a separate patch to allow
> easier regression tracking, in the unlikely case that some issues are
> discovered later, resulting from these voltage changes.
> 
> [...]

Applied, thanks!

[1/2] arm64: dts: rockchip: Add GPU OPP voltage ranges to RK356x SoC dtsi
      commit: 2e1fae80023a38ea03dfca3eab65b3b46617ef3b
[2/2] arm64: dts: rockchip: Update GPU OPP voltages in RK356x SoC dtsi
      commit: eb665b1c06bcaf16df10018550d8f467ed4b2887

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

