Return-Path: <linux-kernel+bounces-361302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BFED99A678
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 16:39:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA979B21659
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 14:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05B3C4EB51;
	Fri, 11 Oct 2024 14:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pmdA/Zqw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630F317BA2;
	Fri, 11 Oct 2024 14:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728657529; cv=none; b=k4DhUuTVIRCfxOTmIi5fsGQfDBZGH8w1lfSxaPRWnanNNOHhPXkHAV81schIc3kQjkQRZdaEpIe4zX6ccWFCobG3u0cOkfSAOOl/08upLHQ37A5r/VYAMkJP7f7E2VT55HDpJao4tYdbrFr7HMDKH7WlPJvWxU+0DwG+79FTBPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728657529; c=relaxed/simple;
	bh=Hgd6/MnZlw7QnHGiY+zYelPvbloqyZAOn1X5DsWCAek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NfbU5f3uCspghtqx+ZDQuuIsL/37N/OMrEfQWpf5S+y5FkRWT5LOprbjQgs0dDBuMcv0SP5C2gBeJSfZ9R0oEFNNx1mgqwscaXTEqgQBViqznoN0+6GEdLXeAE/fznuUa7DChtgQ3FDv12yvtdncNU5EgUUcqS8ywvunJOMIMh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pmdA/Zqw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA666C4CEC3;
	Fri, 11 Oct 2024 14:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728657528;
	bh=Hgd6/MnZlw7QnHGiY+zYelPvbloqyZAOn1X5DsWCAek=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pmdA/Zqws1TABjcWPDhTbDQuItzuA1vihySaNY+7mjcOBZzRcRvcUqSg0ixVEk6aK
	 4tKvrquUaakBeBcNaipW5ufjZXN5exR5eC5OhoaGP7s/ujVWkkeLuNrtTS/VEVXVJq
	 I9FXtriA2VvA+qUHKtVvf8SCK5pP63PgbMf4diLaNochyxZkg8cmZ3+LBf+hULVP//
	 ZAp8bnw75SgcyuDlRWbYsrsvecs8VGyC/O8OInb4EVU5nt0j46UuBJquZsFbR+bRk/
	 YUEehXdWfxsF8hYyXMpAdhmCKZ5TaWC2EXGpf3irnLGdwdJH4j86Llxo0qriRDFa1I
	 ub8dfONZU9vnA==
Date: Fri, 11 Oct 2024 16:38:44 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Frank Wang <frawang.cn@gmail.com>
Cc: vkoul@kernel.org, kishon@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, heiko@sntech.de, 
	linux-phy@lists.infradead.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, william.wu@rock-chips.com, 
	tim.chen@rock-chips.com, Frank Wang <frank.wang@rock-chips.com>
Subject: Re: [PATCH v5 2/3] dt-bindings: phy: rockchip,inno-usb2phy: add
 rk3576
Message-ID: <vauotttw6efm6krwcn2krw47gq6zhgb4nvs3ctv2e4khvizi5z@vwsu7imdbf5t>
References: <20241011065140.19999-1-frawang.cn@gmail.com>
 <20241011065140.19999-2-frawang.cn@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241011065140.19999-2-frawang.cn@gmail.com>

On Fri, Oct 11, 2024 at 02:51:39PM +0800, Frank Wang wrote:
> From: Frank Wang <frank.wang@rock-chips.com>
> 
> Add compatible for the USB2 phy in the Rockchip RK3576 SoC.
> 
> This change also refactor the clocks list as there are new clocks
> adding used for the USB MMU in RK3576 SoC.
> 
> Signed-off-by: Frank Wang <frank.wang@rock-chips.com>
> ---

Thanks for the changes.


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


