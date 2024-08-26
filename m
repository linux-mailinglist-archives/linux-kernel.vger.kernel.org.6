Return-Path: <linux-kernel+bounces-300779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0459A95E83B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 08:04:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 340011C20C9B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 06:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B47181742;
	Mon, 26 Aug 2024 06:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OHRa/Vm9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C5980BF7;
	Mon, 26 Aug 2024 06:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724652286; cv=none; b=Gf9+RnZTVUeHmrdoFoOlKRrO2BFEROACqLQeBT8wi7/T/plabr4XkdFspSjTJExw53ILrnRUBOoxzxrgPCaAGa0hE67F75hSj5IbGs6LAnjPHsKf/YAnaT6KqsoQbTGsysbWgg4dfk/MLmwYRPAE/9HloSUYnCOzGx3DVYr2NcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724652286; c=relaxed/simple;
	bh=OCBrgSZHOjhaA7DpE+XqUtPuuxhlvNwyfG7+IxakSH4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bBqiWgJikohwpP8lbVsFsoF/1y2nPMxzAiqTCHBapRlApUuZ7R52ZSR3OItJmwpiDpxGIJTzgMxwb98KOttyMrJzy5qS27kb9Uxx7rT68+L/IgClMBtVeAgE8Xbze+rfBO0Q0iQldaeokip4fPItuCenMvWU1+z5YjXXmq/HQmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OHRa/Vm9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06112C4FE9B;
	Mon, 26 Aug 2024 06:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724652285;
	bh=OCBrgSZHOjhaA7DpE+XqUtPuuxhlvNwyfG7+IxakSH4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OHRa/Vm956SqZW5cDNvQG/FcVK2MIdzWOGLrL1RUkmGOUrvNkvAKnPdwhPF2Duv40
	 uMWwAt/83uPnqMQpWxoTSyTQggyA6EvAAp+eK43zgjXRqsug8jFI4bte/l5Cp8FRnw
	 5j9G2eE/VTjAblXHaWlimziUM7OiTZG78IMGFhnDSlBQWppyaYsyH1NaB83rXcieu0
	 CpC4KdJV/85acRpPYJSoPvxugKXbJIhXAVN6GYx+34Ow2+wF/zhQy2VnF7I9ajbvmy
	 sbDyeQyebkFQQAT2xhsg2GjhpFlcmdAUOXUfBuIk0pl+Q7vTheFNEck7jN1pjaFVwH
	 FgzRhrD1/vw5Q==
Date: Mon, 26 Aug 2024 08:04:42 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Junhao Xie <bigfoot@classfun.cn>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
	Jonas Karlman <jonas@kwiboo.se>, Chukun Pan <amadeus@jmu.edu.cn>, FUKAUMI Naoki <naoki@radxa.com>, 
	Dragan Simic <dsimic@manjaro.org>, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: arm: rockchip: Add LCKFB Taishan Pi
 RK3566
Message-ID: <5rohxcypstmm56x7fiywtis7rmavhdvpqx766nzoniejjmeit6@vzxrrg2duzu5>
References: <20240826044530.726458-1-bigfoot@classfun.cn>
 <20240826044530.726458-3-bigfoot@classfun.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240826044530.726458-3-bigfoot@classfun.cn>

On Mon, Aug 26, 2024 at 12:44:12PM +0800, Junhao Xie wrote:
> This documents LCKFB Taishan Pi which is a SBC based on the RK3566 SoC.
> 
> Signed-off-by: Junhao Xie <bigfoot@classfun.cn>
> ---
>  Documentation/devicetree/bindings/arm/rockchip.yaml | 5 +++++
>  1 file changed, 5 insertions(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


