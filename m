Return-Path: <linux-kernel+bounces-288429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D2F7C953A02
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 20:29:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BCB21F276DC
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 18:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8218A768E1;
	Thu, 15 Aug 2024 18:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BQecz//p"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C24CC7174F;
	Thu, 15 Aug 2024 18:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723746497; cv=none; b=aFvWsD9a6iSUlzBksKb1eUji+ww107HKyVhaIyUwJgZ48IBca4XknKGoJFhWjk5Kdoj6/BPcqlwx5cAtcWt3dKoT9qYEkl9usbKd6NJWSFQZIAs/YTAtxuA5i0a4TjZ126iABmK230bdki2ta5fE/BUiJyaP1Z0gfgKu9UKruGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723746497; c=relaxed/simple;
	bh=nx7Geze/QeN/AJlEWfyn5sYOct2xeknjjYtJtTUJmes=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=BPgV05aph735dJgZ7JhhaP2eOx5yS1ke6hGbGMET83Eqtg2rMT0Wn3YK4MRAgQSU/QtPkxXWiECbXACkJWIyf1iJc5HHb4uSQh2sFcCKHcDW0FYFyhOlVptrxqYsEO60drNhbU7uMUidCwOJ/bwvbaTXDRxeybJ+gUHU8lhOpWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BQecz//p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41C7DC4AF13;
	Thu, 15 Aug 2024 18:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723746497;
	bh=nx7Geze/QeN/AJlEWfyn5sYOct2xeknjjYtJtTUJmes=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=BQecz//pzX3SIPA5QCxbHqcyEpmzafawkl9YJTH5f6CIGl7y1ypiablCYJckFPC24
	 SbOO1xIkRdZGClYkDakFHAhg7opbrpI91iQ4r3qU6n5AFvT8fd8hguOAcqvCOr9POZ
	 pk9oOhu2OrdRGC1hlheQm03JsZak+n5LW6OUBLKla87m+iYXgYJPP07NLU80RPehN5
	 aIMR3rE+Tit057qZ9CaEkgT5tT4I5YPXhIbndJcOg7rHlxbarZMAQ1g4gnhf4lZcnH
	 9WeG5zs+6Xp+cMpDGH100KB1GKNDWGzWoZPWi1Dga+8zdhT5cAZD6hg7KpZucXVXka
	 uKku4bu9imUfQ==
Date: Thu, 15 Aug 2024 12:28:16 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Sergey Bostandzhyan <jin@mediatomb.cc>
Cc: krzk+dt@kernel.org, linux-kernel@vger.kernel.org, heiko@sntech.de, 
 devicetree@vger.kernel.org, conor+dt@kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org
In-Reply-To: <20240814170048.23816-1-jin@mediatomb.cc>
References: <20240814170048.23816-1-jin@mediatomb.cc>
Message-Id: <172374583245.2826928.3280023192030812974.robh@kernel.org>
Subject: Re: [PATCH v3 0/3] Add DTS for NanoPi R2S Plus


On Wed, 14 Aug 2024 17:00:45 +0000, Sergey Bostandzhyan wrote:
> Hi,
> 
> here is version 3 of the NanoPi R2S Plus patchset.
> 
> * a commit which adds mmc-hs200-1_8v in order to improve eMMC performance has
>   been included
> * the licence header has been updated to the newer version, anw now includes
>   optional MIT licensing
> 
> 
> Sergey Bostandzhyan (3):
>   arm64: dts: rockchip: Add DTS for FriendlyARM NanoPi R2S Plus
>   dt-bindings: arm: rockchip: Add NanoPi R2S Plus
>   arm64: dts: rockchip: improve eMMC speed on NanoPi R2S Plus
> 
>  .../devicetree/bindings/arm/rockchip.yaml     |  1 +
>  arch/arm64/boot/dts/rockchip/Makefile         |  1 +
>  .../dts/rockchip/rk3328-nanopi-r2s-plus.dts   | 32 +++++++++++++++++++
>  3 files changed, 34 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2s-plus.dts
> 
> --
> 2.20.1
> 
> 
> 


My bot found new DTB warnings on the .dts files added or changed in this
series.

Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
are fixed by another series. Ultimately, it is up to the platform
maintainer whether these warnings are acceptable or not. No need to reply
unless the platform maintainer has comments.

If you already ran DT checks and didn't see these error(s), then
make sure dt-schema is up to date:

  pip3 install dtschema --upgrade


New warnings running 'make CHECK_DTBS=y rockchip/rk3328-nanopi-r2s-plus.dtb' for 20240814170048.23816-1-jin@mediatomb.cc:

arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2s-plus.dtb: hdmi@ff3c0000: interrupts: [[0, 35, 4], [0, 71, 4]] is too long
	from schema $id: http://devicetree.org/schemas/display/rockchip/rockchip,dw-hdmi.yaml#
arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2s-plus.dtb: /phy@ff430000: failed to match any schema with compatible: ['rockchip,rk3328-hdmi-phy']
arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2s-plus.dtb: /clock-controller@ff440000: failed to match any schema with compatible: ['rockchip,rk3328-cru', 'rockchip,cru', 'syscon']
arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2s-plus.dtb: /clock-controller@ff440000: failed to match any schema with compatible: ['rockchip,rk3328-cru', 'rockchip,cru', 'syscon']
arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2s-plus.dtb: mmc@ff520000: Unevaluated properties are not allowed ('num-slots', 'supports-emmc' were unexpected)
	from schema $id: http://devicetree.org/schemas/mmc/rockchip-dw-mshc.yaml#






