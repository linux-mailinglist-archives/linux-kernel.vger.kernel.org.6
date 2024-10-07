Return-Path: <linux-kernel+bounces-354119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 725FD993802
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 22:12:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D434CB2102D
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 20:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C5451DE4FC;
	Mon,  7 Oct 2024 20:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l8QUUxpq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B38061DE3C9;
	Mon,  7 Oct 2024 20:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728331959; cv=none; b=UyVMHQ9HfvG5VlDgGoXx5muRWjQWWz/YiLWTCiriKFEbUqh29Ylwtwm0NhmwCje+rE4zpexKiReSmRYjNC/GRAKyDjUJUv7UhUIGTZZ/+/OqRwQy0ohJp4+db4clAgSgCfwLyhg5IIVI7PietXQt6bfwUqllx1wWpeLV2QdHjwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728331959; c=relaxed/simple;
	bh=luEIaffhWqESf7hIQ7l8nkL5P040xkqBuXpkvCb9Mqk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i5/ofJ7QmdWu7Eztv5dr803Q8IqUZgSFciN8IM7YKplpIT1iek+Dw7zcs51aH5+PXVPlOxYnNRPW0vdBnvXhDzQfXj6jlTvVx2fl8E4xsY1j98hOeHTNdfS05xJOb5RQl2aMrVojs76+Lh0hHPsWa2tsjrzNam/INzhmKuDtESU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l8QUUxpq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3699AC4CEC6;
	Mon,  7 Oct 2024 20:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728331959;
	bh=luEIaffhWqESf7hIQ7l8nkL5P040xkqBuXpkvCb9Mqk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l8QUUxpqqS/cPnB77e40GdZVvM8c3ncvPEnXkKSYSqsUiiOZR7ZJNQs3DhtFqufRY
	 3PkeQn138ZtpSzf0GAHwyghMMHDBRoLz11eV9Oi+vDbGpr6E+PGiKLxkroLvhW5xn5
	 5qCtsRRBwdyKZrYT446qyJxHm1HP1BK29yxClPgsSJzq8qv3dt3uN2BQER7WXHFPD6
	 pir0IAd8mYFWdx8hauqOEpr3pbCpx36V1ZeawVCCa12JGiI3HAZBuDZEm8HGa4Bs6N
	 WQdDUxYwCe5zWSZfWHQXOL2wnah50+1HHCIYtbwkZ3Jz4XuX2MSjr1PAmrn22CN6U+
	 VzC+nbLMUvnIw==
Date: Mon, 7 Oct 2024 15:12:38 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Heiko Stuebner <heiko@sntech.de>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	conor+dt@kernel.org, broonie@kernel.org, krzk+dt@kernel.org,
	lgirdwood@gmail.com, linux-sound@vger.kernel.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: dt-bindings: rockchip,rk3036-codec: convert to yaml
Message-ID: <172833195769.2322621.15377290813075812117.robh@kernel.org>
References: <20241007164542.2452315-1-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241007164542.2452315-1-heiko@sntech.de>


On Mon, 07 Oct 2024 18:45:42 +0200, Heiko Stuebner wrote:
> Convert the binding to yaml.
> 
> The codec seems to be from Innosilicon, but the compatible has ever only
> been rockchip-based, as they sythesized the codec for the rk3036.
> 
> So the yaml file gets a name matching that compatible.
> The only other notable change is the addition of the #sound-dai-cells
> property, that is always required.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  .../devicetree/bindings/sound/inno-rk3036.txt | 20 -------
>  .../bindings/sound/rockchip,rk3036-codec.yaml | 57 +++++++++++++++++++
>  2 files changed, 57 insertions(+), 20 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/sound/inno-rk3036.txt
>  create mode 100644 Documentation/devicetree/bindings/sound/rockchip,rk3036-codec.yaml
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


