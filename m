Return-Path: <linux-kernel+bounces-429899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B23149E2AC8
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 19:27:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3BE8B34E8A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 16:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D91F1F9418;
	Tue,  3 Dec 2024 16:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YA/+5FUC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6591304BA;
	Tue,  3 Dec 2024 16:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733245109; cv=none; b=ElSi9ucc25wlB22d+3Gmf0+Eii8XOhunFrh/BJCTBw+Lw3/mRUORBvFfWPQhvHzBZ7Y19DsGsYtvTQsqj/dJt9l9OvJb1utUPQP+el8pHAllxqF2fr9Jy4LxCjpFM/ExRKvJrrmhAh9uOMHaoKgdH4hXrJ2n1gaQlpoh5SeQusA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733245109; c=relaxed/simple;
	bh=arF+AUtSeu6ScqKrFJj4z1B2pVwQCLt63eW9K0h113I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lcdM6S/vynftENeOYTJsPKyzCTxH0e3GxIuvlO+oHxNcl6O+GnpiyokyuFivrAK8WxaA0xowVVAngM/itQYSA04ixXAPsB3hCQtyTzqki09+s4+01gR1h3mss0fNrCBqObb/54ylWQ+iKOeWBYc/bBVEUcCGOFBT4Lz6K8ZFkmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YA/+5FUC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDD3DC4CECF;
	Tue,  3 Dec 2024 16:58:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733245109;
	bh=arF+AUtSeu6ScqKrFJj4z1B2pVwQCLt63eW9K0h113I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YA/+5FUCNsnzc7OLhztiJaztpx3YVhqilIZltxUkySH8DqVvnFKO/OXroDo3LgeWn
	 uE8dW8TU8STjU4G3thzdB8bI2m7LSqs1TlH0rahyfAt2Ok5J0pZO4UMMSRIogcgJh9
	 FI2tGRgC//SEy3MVb/TGxsLK6kahOu3BPmkeZkUmHwUFIfkERsKMN+ZRszO4q6LyF8
	 DRKgCORo7yHFban6Du/ieT/y1Bzi5WI+xhsOwX6zDdR5tvnVdyb2F/Vn+3fEQbT/Q1
	 LUfN4eTq6DIdmmjvfZuHVgQHZVvizSHYxgmD6D/D36aELHM/cDPt6xDUQPxslOU0UE
	 k0d+YW0B12Xew==
Date: Tue, 3 Dec 2024 10:58:27 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Damon Ding <damon.ding@rock-chips.com>
Cc: sebastian.reichel@collabora.com, cristian.ciocaltea@collabora.com,
	krzk+dt@kernel.org, rfoss@kernel.org, devicetree@vger.kernel.org,
	linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
	l.stach@pengutronix.de, algea.cao@rock-chips.com,
	linux-arm-kernel@lists.infradead.org,
	dri-devel@lists.freedesktop.org, hjc@rock-chips.com,
	conor+dt@kernel.org, vkoul@kernel.org, kever.yang@rock-chips.com,
	linux-rockchip@lists.infradead.org, andy.yan@rock-chips.com,
	heiko@sntech.de
Subject: Re: [PATCH v1 07/10] dt-bindings: display: rockchip: Fix label name
 of hdptxphy for RK3588 HDMI TX Controller
Message-ID: <173324510682.1955832.14077962445640350158.robh@kernel.org>
References: <20241127075157.856029-1-damon.ding@rock-chips.com>
 <20241127075157.856029-8-damon.ding@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241127075157.856029-8-damon.ding@rock-chips.com>


On Wed, 27 Nov 2024 15:51:54 +0800, Damon Ding wrote:
> The hdptxphy is a combo transmit-PHY for HDMI2.1 TMDS Link, FRL Link, DP
> and eDP Link. Therefore, it is better to name it hdptxphy0 other than
> hdptxphy_hdmi0, which will be referenced by both hdmi0 and edp0 nodes.
> 
> Signed-off-by: Damon Ding <damon.ding@rock-chips.com>
> ---
>  .../bindings/display/rockchip/rockchip,rk3588-dw-hdmi-qp.yaml   | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


