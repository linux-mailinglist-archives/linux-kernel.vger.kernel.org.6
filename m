Return-Path: <linux-kernel+bounces-368514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78DC79A10B0
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 19:33:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D5642839EF
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 17:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15C17212624;
	Wed, 16 Oct 2024 17:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dliDsSGJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70FDB17333A;
	Wed, 16 Oct 2024 17:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729099990; cv=none; b=S+i1o0BUDHnJlXR1LCo5F705m2PBL8J0ylS/BPDB5tOu1SaPKgQKnKw2s1GKJSZ2aJPYFFlC87cD/+1F7VzukcbJLjyoAicyBainw+ctU6dJGoqiZXdiZ+/+rFqJ3XiHDv5tjyF+VKn+ON0BR6RGmsjtYo5TcqgOvCOWh5FPbs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729099990; c=relaxed/simple;
	bh=WPrD40hISrWG6l6LJDVLR/3iKsPYJfFh0eBKmBOWvCc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IVDS6JHYXHSKElHl107A2R/C6aOb6KRNDKbs5USVIGVhBt9qwct82hYx5aDfdl6Hnwzv2/izICXh7YNQhZg42pLfwtCR2/4XnOaFEqCphbLvA2kr1O7WCjkTbqxYEZrwsRHv2zgg8tYDkP3sikJy/xFLL1U09bAs85klnGsvsj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dliDsSGJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEF19C4CEC5;
	Wed, 16 Oct 2024 17:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729099990;
	bh=WPrD40hISrWG6l6LJDVLR/3iKsPYJfFh0eBKmBOWvCc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dliDsSGJJOrK3aCli3Rr+aiHdE3SJJAA0U5kcmd1rn5lt6TLTUg0CeoJJD//Vb3d3
	 O7ivCQkWX1LWzO1iLPJd77tuGI1rqz4fGt/Au5TtU46F0HnJPslPtpxGaLydfDgOR7
	 BBttuoIYUYLe3XoKYUjX7lWY4VQ6SxHfFXGreUoXE73rtxyyNy73kMTko5rsxGqm5v
	 9q95TcpC+54eqrX1kn1JhkxfAbfEBUvAPvTjuCHCfZBLr5K1zNFCwOMsfluDBztPto
	 gvB+2XQLQa4UyJoeRMpwFiYoAz3XMEJ3ahIp9keZ3FDwR8jTNIplehwYir6+JlzKqU
	 4CGhcx9e+xUdA==
Date: Wed, 16 Oct 2024 12:33:09 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Frank Wang <frawang.cn@gmail.com>
Cc: devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org,
	william.wu@rock-chips.com, gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org, Frank Wang <frank.wang@rock-chips.com>,
	linux-arm-kernel@lists.infradead.org, krzk+dt@kernel.org,
	heiko@sntech.de, tim.chen@rock-chips.com, conor+dt@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: usb: add rk3576 compatible to rockchip,dwc3
Message-ID: <172909998847.2076107.16244680063698227537.robh@kernel.org>
References: <20241016083224.14839-1-frawang.cn@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241016083224.14839-1-frawang.cn@gmail.com>


On Wed, 16 Oct 2024 16:32:24 +0800, Frank Wang wrote:
> From: Frank Wang <frank.wang@rock-chips.com>
> 
> Add the compatible for the Rockchip RK3576 variant.
> 
> Signed-off-by: Frank Wang <frank.wang@rock-chips.com>
> ---
>  Documentation/devicetree/bindings/usb/rockchip,dwc3.yaml | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


