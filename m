Return-Path: <linux-kernel+bounces-414740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 064949D2CB0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 18:32:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFE05282133
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 17:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B08E81D0F79;
	Tue, 19 Nov 2024 17:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IZQeQnxx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1487E14AD3A;
	Tue, 19 Nov 2024 17:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732037500; cv=none; b=KNGSCiWTgCKuikVeYowI51k9/khwZH6x4u31iclHPC+P+IBirAnKd3Xy+mOfNVw4juLCx8Zfl3VNlGZ2GRA4+lAn6aww5nWIhkHarTxCp0opTpPanoKdRaql1sI4sVyBCjkzfnf1T6Lk0zyEer+PkVKNHq8VDCoE7hQ5mjjp1nM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732037500; c=relaxed/simple;
	bh=40Ii4Ih1KqmFT5zuzSv/DvymQGmG/a5ga66P7ata0S0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JH+8tctf8bALRyekahtC2da2jV/T0b62fPoGsc4R3D4sPKSraq4bM8smLX4w4Tw7zdd+fyS2Hqn3eKRjNHCaIH84ggTT7tnMzJilVZrkYMGqIX/chy0nKrENQtNlbf6vcUZ1Od87VI5rf/s9coB4gfuMTjsyeahqdCgmpwIH2+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IZQeQnxx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F0D6C4CECF;
	Tue, 19 Nov 2024 17:31:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732037499;
	bh=40Ii4Ih1KqmFT5zuzSv/DvymQGmG/a5ga66P7ata0S0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IZQeQnxxstdafeNAMT6sD8X/MdhUScQYTiGKvOH3DJMOfnqSn2XU9RwAX7dmMAiHd
	 FvNrTAj3Iuhk8Vmu93NTXroeg6z//DRsVfG0lU/INkG3vmzquhYyJmkCgSNTNjfsuT
	 A/FtIszbH3tsQRaqHCYa2fE6upz8639qFJRVWdYKFtDJNWRrnMEx516kyhMZGCJk0X
	 /8PknydiKkIiY/iVauIth5w3fVsIlgInhUhVepO85p75eGyKUPOePDBpE9hrouvVFC
	 AkQPtzCcCaQyhqIDGN+TiGLV9lssO7rFvpqQK7FpZe+MWF8F8B71ZqDlXY+JT/6whW
	 h1tqe0wQvow3A==
Date: Tue, 19 Nov 2024 11:31:37 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Heiko Stuebner <heiko@sntech.de>
Cc: krzk+dt@kernel.org, linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, conor+dt@kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: arm: rockchip: Add Firefly
 ROC-RK3576-PC binding
Message-ID: <173203749067.1857292.2755074403775735257.robh@kernel.org>
References: <20241117201855.789945-1-heiko@sntech.de>
 <20241117201855.789945-2-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241117201855.789945-2-heiko@sntech.de>


On Sun, 17 Nov 2024 21:18:54 +0100, Heiko Stuebner wrote:
> Add devicetree binding for the ROC-RK3576-PC SBC.
> 
> The board is based on the RK3576 SoC (4*Cortex-A72 + 4*Cortex-A53).
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  Documentation/devicetree/bindings/arm/rockchip.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


