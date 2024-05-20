Return-Path: <linux-kernel+bounces-184181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8517C8CA3A2
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 23:02:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2844E1F21E62
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 21:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AA9F139CE4;
	Mon, 20 May 2024 21:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d+5tbO7X"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE4C01D531;
	Mon, 20 May 2024 21:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716238944; cv=none; b=cleRCLgyhu9+1e+gGxP+aLfsnQyq4mGDvFlaVnTK8CmehOiTbru0j/SOT1PGDaXSqOvL7/OKFEtnFErantt1jeGavfGXp5N8aKiSN/fVdLMDm/q4p5eiANJvzNb4iCxzaxlFgGSuSdBpZi7uNdjjkQUsM/u/CKm6k4Ewp+T7Bq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716238944; c=relaxed/simple;
	bh=5q5CJe3cUTof/pZ8TF7USfHcDrM0ecb8vNHWkTDfkZg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f9ime+mURyoZw8wa9Me3EsgsaLRSOigPnmzrAF9ZdsPrYWDeKywJ7HNubr/76H9/ZxGkns1b9wNBp/Nl9kjnIp10Effs5Fd5zfR0iO8iHrQ1lZLjd/g3qnBQoroqTELEUoMhuaBRFbStT52UPiXPaNxi+giVFXH5EG/V4f912H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d+5tbO7X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41301C2BD10;
	Mon, 20 May 2024 21:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716238944;
	bh=5q5CJe3cUTof/pZ8TF7USfHcDrM0ecb8vNHWkTDfkZg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d+5tbO7XWyVTROzUUI+GqcfH3xJV8WnqEx7V2KkcTNCBTGJoXqVLoa/OKSOU6y3Rn
	 eccIE2eRkzFUiELI0lXxFF4DqznBSnRPhZYf/FHh4A+d1mxuHHu6V19OLZTPEEXPJd
	 lkfp6iK02cHVtK1/wjx/jtO+zHKLKUw/EXN1wkVwkKt1AaE6eI9n9isI4ONBnQ72tA
	 HuhEUtHfQawg97AMNp2reCIhXP9LVjfMAj+W88b5xJbo8B/uvV13reHmvvDPRYdt2H
	 OPJB5I67/LjG1g7zWZvf9/oOpFRIAPKNGzQgqGm9Zqrnjy9cQ40eSwb0QUjeByFL4x
	 wjt6Y65CI6nGw==
Date: Mon, 20 May 2024 16:02:23 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	MandyJH Liu <mandyjh.liu@mediatek.com>, devicetree@vger.kernel.org,
	Lee Jones <lee@kernel.org>, linux-mediatek@lists.infradead.org,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH 1/4] dt-bindings: mfd: mediatek,mt8195-scpsys: add
 mediatek,mt8365-scpsys
Message-ID: <171623893985.1474490.13998302237975026770.robh@kernel.org>
References: <20240518211159.142920-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240518211159.142920-1-krzysztof.kozlowski@linaro.org>


On Sat, 18 May 2024 23:11:56 +0200, Krzysztof Kozlowski wrote:
> Add a new mediatek,mt8365-scpsys compatible, for the SCPSYS syscon block
> having power controller.  Previously the DTS was re-using SYSCFG
> compatible, but that does not seem right, because SYSCFG does not have
> children.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/mfd/mediatek,mt8195-scpsys.yaml          | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


