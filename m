Return-Path: <linux-kernel+bounces-315400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1190E96C229
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 17:23:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C23B52811EB
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 15:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58AAF1DCB31;
	Wed,  4 Sep 2024 15:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MPGc50lb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B543CDDCD;
	Wed,  4 Sep 2024 15:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725463400; cv=none; b=Uc/ULoeV0XCx/jwchBSq7ei0NFaN76aJjvtabdEMRwi52vIlrxvEjPDvd9MIx/Z7guO4/0e0uegdhfwDf+DYx1c/Mgd8b7BL45NE0t+MZDUJ/1hpKyZz17+JpfyIQsZH6i3N+W1JbM3mKBjirUcXLxk3fITlnphn/OEXAKamJq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725463400; c=relaxed/simple;
	bh=Ne0Xbs1PRSEcuAHWf/+aKg9PM3rr774/phdtOfelanY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n+MSeGAznVUp4No6lQ+V6wlSvTcgBBzkfS4BuEV+ezEngQ+ircD+GvdX/tgx2iCRQH8DFW3tzo8jmqfiFD6+AqdyfSXq1iBa5xe35H8bY+ocGmhZHHCexafMc+Psh6An3ty9AsuES2eIxlSgzkzA0eE3rTCZ5kK5uNUE5OWyD40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MPGc50lb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15488C4CEC6;
	Wed,  4 Sep 2024 15:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725463400;
	bh=Ne0Xbs1PRSEcuAHWf/+aKg9PM3rr774/phdtOfelanY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MPGc50lbURIexu4LjzS5ScZmPKBr0zLGkSAC1kGc0qcyqdU90gn8cwyd1J9AjQxuA
	 QEikGsRpZlNEi4xB/FsolnUcMtoLg8cfK0pI0BF02gav+GanuvP7x+YHTT2KagnMnW
	 Yr0M1OTF6oYj+rgt7sV3FHhPuwMNGciqecDtZ3zrOcuyqIlti3Me+aEdQJv/qcU5qx
	 Ezz5c9Tb53xCu/YGjlLaLTsmTT5sFdb3OzRQoewFA8YarJL5EuU323nkZQmsIcGI1K
	 iqVOOc4UzNnR61N0iWouZztYd9UnuIKI5xlwJsk2w/hM4FFxRBfFkasAZE9rG31YKp
	 6RhH5WVSgoexQ==
Date: Wed, 4 Sep 2024 10:23:19 -0500
From: Rob Herring <robh@kernel.org>
To: Jianeng Ceng <cengjianeng@huaqin.corp-partner.google.com>
Cc: angelogioacchino.delregno@collabora.com, matthias.bgg@gmail.com,
	krzk+dt@kernel.org, conor+dt@kernel.org, knoxchiou@google.com,
	hsinyi@google.com, dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] arm64: dts: mediatek: Add MT8186 Ponyta
Message-ID: <20240904152319.GA2600949-robh@kernel.org>
References: <20240904081501.2060933-1-cengjianeng@huaqin.corp-partner.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240904081501.2060933-1-cengjianeng@huaqin.corp-partner.google.com>

On Wed, Sep 04, 2024 at 04:14:59PM +0800, Jianeng Ceng wrote:
> This is v3 of the MT8186 Chromebook device tree series.
> ---
> Changes in v3:
> - PATCH 0/2: Add the modify records.
> - PATCH 1/2: Modify lable to label.
> - Link to v2:https://lore.kernel.org/all/20240903061603.3007289-1-cengjianeng@huaqin.corp-partner.google.com/
> 
> Changes in v2:
> - PATCH 2/2: Modify the dtb name without rev2.
> - Link to v1:https://lore.kernel.org/all/20240902125502.1844374-1-cengjianeng@huaqin.corp-partner.google.com/
> 
> Jianeng Ceng (2):
>   dt-bindings: arm: mediatek: Add MT8186 Ponyta Chromebook
>   arm64: dts: mediatek: Add MT8186 Ponyta Chromebooks
> 
>  .../devicetree/bindings/arm/mediatek.yaml     | 11 +++++
>  arch/arm64/boot/dts/mediatek/Makefile         |  2 +
>  .../mediatek/mt8186-corsola-ponyta-sku0.dts   | 24 ++++++++++
>  .../mediatek/mt8186-corsola-ponyta-sku1.dts   | 27 ++++++++++++
>  .../dts/mediatek/mt8186-corsola-ponyta.dtsi   | 44 +++++++++++++++++++
>  5 files changed, 108 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-corsola-ponyta-sku0.dts
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-corsola-ponyta-sku1.dts
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-corsola-ponyta.dtsi

Something is wrong in the threading of your series.

Rob

