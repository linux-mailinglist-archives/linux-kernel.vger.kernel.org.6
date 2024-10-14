Return-Path: <linux-kernel+bounces-363141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB7B999BE58
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 05:53:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EC7D282FE5
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 03:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF97B83CC1;
	Mon, 14 Oct 2024 03:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="LjmScu4v"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94DD5231CB1;
	Mon, 14 Oct 2024 03:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728878028; cv=none; b=OtNoCe8qGGkCrjn4KR9wEZsoo0VivRDIM4u9AeZdNjW2lkMBWPoLqdJvxiru0fsakyPHtnmYnjgexrlX2PIq5XJ3fPalYcMpYGnh7clwFI5smJeB7FFKZ0IAV8NVIR74IYGpYHNZm2vCLazN6DifZ48x1lUodSXCGtxvDYa0l78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728878028; c=relaxed/simple;
	bh=T0PylFUGGEvk/NxJbKOo0gN2s6qagSt3zCfg4Ee1feQ=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=IAIZU+8MXadORjzQUVudxFC997P2Vtbt497ctg2tFhU6xdaOMtrmPZhQC5VDNcJqUkItdq7nO1WqkgI88YzXWJF2mb6WgQJ7D1bJ9vZ0CmxXuDMMSqIC6Fngk36CS6ohyG2pyK5CiWN7mBa849m0dWmN9WaffROENEgZtQymFN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=LjmScu4v; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1728878022;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y1kR0sfl5tb/JBd/o562F1YUU5L9dc/UgrNB2JP6zYU=;
	b=LjmScu4vRNphEIqQE9JBQ026JkApI3Iyyl5w66rT93cJil/Myh717LkU0GzqG7H++9WrfS
	mW5qWEK4F3QVP0naYvBhnvZNglv6b3jyePG5qWSXQcwKTG80KBWBqhfLJJfY7Px9KsQ6Le
	6NBxMnjPw3jooKBGoumcA1fblFfd0/MSGd8iQO+SHLU/5MynnT1EYqBBnJYaYT2thXFYT1
	DyXnos9TPh5aEDsO85u9iaC3d+a8h2li/ocjL4e2z/wxA9DAKqJhQ4cc5/sYsXSCp2bRRI
	5HGhI0L1IZTEit3YQQ6USZfYuapcO8QiahyKNfqrakF1r3wvvl+FtEVbcI8phg==
Date: Mon, 14 Oct 2024 05:53:42 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Frank Wang <frawang.cn@gmail.com>
Cc: vkoul@kernel.org, kishon@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, heiko@sntech.de,
 linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-rockchip@lists.infradead.org, william.wu@rock-chips.com,
 tim.chen@rock-chips.com, yubing.zhang@rock-chips.com, Frank Wang
 <frank.wang@rock-chips.com>
Subject: Re: [PATCH 1/2] dt-bindings: phy: rockchip-usbdp: add rk3576
In-Reply-To: <20241014020342.15974-1-frawang.cn@gmail.com>
References: <20241014020342.15974-1-frawang.cn@gmail.com>
Message-ID: <00175534f48f419c44836129f9cacbeb@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Frank,

On 2024-10-14 04:03, Frank Wang wrote:
> From: Frank Wang <frank.wang@rock-chips.com>
> 
> Add compatible for the USBDP phy in the Rockchip RK3576 SoC.
> 
> Signed-off-by: Frank Wang <frank.wang@rock-chips.com>

Looking good to me, thanks for the patch.

Reviewed-by: Dragan Simic <dsimic@manjaro.org>

> ---
>  Documentation/devicetree/bindings/phy/phy-rockchip-usbdp.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git
> a/Documentation/devicetree/bindings/phy/phy-rockchip-usbdp.yaml
> b/Documentation/devicetree/bindings/phy/phy-rockchip-usbdp.yaml
> index 1f1f8863b80d..b42f1272903d 100644
> --- a/Documentation/devicetree/bindings/phy/phy-rockchip-usbdp.yaml
> +++ b/Documentation/devicetree/bindings/phy/phy-rockchip-usbdp.yaml
> @@ -13,6 +13,7 @@ maintainers:
>  properties:
>    compatible:
>      enum:
> +      - rockchip,rk3576-usbdp-phy
>        - rockchip,rk3588-usbdp-phy
> 
>    reg:

