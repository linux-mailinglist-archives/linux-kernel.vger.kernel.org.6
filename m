Return-Path: <linux-kernel+bounces-555013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D62DA5A479
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 21:13:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BEEF16FE09
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 20:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F06E51DE4EA;
	Mon, 10 Mar 2025 20:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PXgsICyE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A5481DE3AE
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 20:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741637581; cv=none; b=Ff1R/0uvckyWRsO6DmMovXygcBKFrzTt338ETt84T9KtWq7yLhx7H4rL1hztxtwNK0HKadhaiY9NiaZSahWCgl1JjxB9I8Zj8QSgFfq8yquC4CSlbpAks5Q86n9fEGs4B9UoLLevVlbOd3uXOFDnRBFrxCR760/JB97hyNnvE9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741637581; c=relaxed/simple;
	bh=xEM6pFjBPHLs4DsygLv6xgvUvNhyjDWD4dquKB53SKw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ok20hMkLBpUePJ5aBzH8AXIVDsCimfc9BIsya2qfPAR0Rk+lLSY5gwy96GoNVAJTtTiaQ0WGPy2nGHT1hPECmXAR7qPo/3pSOD9DxOc5E4+dm1p//RP9ojPKOQMHwZ6vJfJpbKPhsMkZE/cPZn6w0srSWYoMgV+IeuBFkhabr20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PXgsICyE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78140C4CEE5;
	Mon, 10 Mar 2025 20:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741637580;
	bh=xEM6pFjBPHLs4DsygLv6xgvUvNhyjDWD4dquKB53SKw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=PXgsICyE0x+9FM6rPZWMI2kSvKm23bvxf00IUkdgmHflvb5JQuonJ3COzKo3cDsk3
	 e38kgtuQjaJSakJg/LaUDVNB8ReZmowej64+ramCYG5PC8AP7noqXM+5AGbmEOCoer
	 zkGjpeNVMOdHAlkTgfVBtFyFBwN8ftHIppfyw7IWCAp5mhGw5L+wvPDLybzQyCrrGj
	 tN3LaZk8h323+X1M4l+/fM6GtStN4DYzN0vRu9cqobmNaC/ktIXKBOliGvU5wsj3el
	 y6zkmR5tQmuyHsyjlwWXSTNbNYyU/4R87ownu7+7oea73PMcRcDoHK8kaY6M9JhMFC
	 /WwhDxsqc4E4A==
From: Vinod Koul <vkoul@kernel.org>
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>, 
 Heiko Stuebner <heiko@sntech.de>, Andy Yan <andyshrk@163.com>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>, 
 kernel@collabora.com, linux-phy@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20250306-rk3576-hdptx-phy-v1-1-288cc4b0611a@collabora.com>
References: <20250306-rk3576-hdptx-phy-v1-1-288cc4b0611a@collabora.com>
Subject: Re: [PATCH] phy: phy-rockchip-samsung-hdptx: Add support for
 RK3576
Message-Id: <174163757697.467704.14207163796763946102.b4-ty@kernel.org>
Date: Tue, 11 Mar 2025 01:42:56 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Thu, 06 Mar 2025 20:29:23 +0100, Nicolas Frattaroli wrote:
> Despite the compatible already being listed in the bindings, the PHY
> driver never gained explicit support for it. This is especially a
> problem because the explicitly listed PHY addresses need to be specified
> for each SoC.
> 
> To solve this, add the compatible, and a PHY config, with the address
> gleaned from rk3576.dtsi.
> 
> [...]

Applied, thanks!

[1/1] phy: phy-rockchip-samsung-hdptx: Add support for RK3576
      commit: 4a8463ae8d871ccd491d48a371a6789eb7378243

Best regards,
-- 
~Vinod



