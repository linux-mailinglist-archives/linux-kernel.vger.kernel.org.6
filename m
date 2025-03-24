Return-Path: <linux-kernel+bounces-574330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2F40A6E3FA
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 21:12:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F1163B3D9F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 20:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A391C1B4231;
	Mon, 24 Mar 2025 20:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PYFvWya/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DDD5157A46;
	Mon, 24 Mar 2025 20:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742847122; cv=none; b=uHTs5C4IcnbhHToXgibUDVLtjDZHaEW2aNQwjGAGZGxV7GoZ56jGYb3VqTKFOA9N6FYrcZvXQlFt+pkvby4sc7szK57bZB/rqQk9wR6wH6hZJAFpmf6x16lPDQvQainrj+gU1NrF/pvjWOMgmD7JOB8tJ0m5EX4aZqnl9gfZkNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742847122; c=relaxed/simple;
	bh=xsQnoIiAqK8rI1rdROJkhsNVkB1X7Nz0OtSOwQ8bwkM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bAzf0VrY8VPg9B9MTX7Diz/WqbwO3YsuCUgHdmJEWD06E/7vXoKgTfMaVN5NlOkndycqCUQcy3dg0X9mxSg+DXHjIzCz017y8RU50aaW4S3wCVZ595uboV1V2yMoKMiGY+a/T+IJ+PA5Ip74NC8MmXULoCyZzUa8Xs+NyK6xyJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PYFvWya/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2D6CC4CEDD;
	Mon, 24 Mar 2025 20:12:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742847121;
	bh=xsQnoIiAqK8rI1rdROJkhsNVkB1X7Nz0OtSOwQ8bwkM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PYFvWya/u5/qIFUJ9Yb+9dQDnyAsPIzex6IAmLQV7kmXL+yJp0cJpppeqPQXbeNDb
	 aJu/5rvpVqMbJHuOpQFl0bHM/hqbs1ddbezd8pCkRf55cdK5WROwuNH/1scwhraUiX
	 JiMoApDuCWOC2VphRshq9/7DnlSfh3OQR4A3mhHzy/lkvHstUGJjjnxb+GuqZkk/59
	 fjHvqA9KlN2GwrJFpXoXQsSJa7nXdZxXvNaVPMuNBWMm7QKkj6yNnLbXrP32w42su4
	 mXsK6k32o74PytqV4GzTisL8do8sT3PCml2nGVJnHV3DS25vBTxWEjVgcIrM08rgdn
	 69CeJfE5L3gZg==
Date: Mon, 24 Mar 2025 15:12:00 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Andy Yan <andyshrk@163.com>
Cc: linux-arm-kernel@lists.infradead.org,
	Andy Yan <andy.yan@rock-chips.com>, krzk+dt@kernel.org,
	devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
	conor+dt@kernel.org, hjc@rock-chips.com,
	linux-kernel@vger.kernel.org, heiko@sntech.de,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH 1/2] dt-bindings: display: rockchip,inno-hdmi: Fix ref
 clk Document of RK3036 compatible
Message-ID: <174284712018.797576.18315585486040060273.robh@kernel.org>
References: <20250324103332.159682-1-andyshrk@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250324103332.159682-1-andyshrk@163.com>


On Mon, 24 Mar 2025 18:33:27 +0800, Andy Yan wrote:
> From: Andy Yan <andy.yan@rock-chips.com>
> 
> The RK3036 HDMI DDC bus requires it's PHY's reference clock to be enabled
> first before normal DDC communication can be carried out.
> 
> Therefore, both RK3036 and RK3128 HDMI require two identical clocks.
> 
> Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
> ---
> 
>  .../bindings/display/rockchip/rockchip,inno-hdmi.yaml | 11 ++---------
>  1 file changed, 2 insertions(+), 9 deletions(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


