Return-Path: <linux-kernel+bounces-321746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E57A971ED8
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 18:12:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9B181C22CF5
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 16:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF6E513A3E8;
	Mon,  9 Sep 2024 16:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H9ieu6t0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27BDC3D38E;
	Mon,  9 Sep 2024 16:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725898353; cv=none; b=EjTzXMDfk7GMFQ79e28qX3A5bV2ZE/W4owsFH5DlBdSr4nbiBQJb0SYcHmEEjDQwQwsW+ndf2QQAZEFmjDMUt9pl7mj2Rr9uz0Co7j/QDBRzFe3mPlmcqqQMCsOK3SlL98sULmEnJd9ljzccebk9+Su4XACjEKRSJ/fdPjIIFZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725898353; c=relaxed/simple;
	bh=OtOcI4mwE4jLt6DU3HeKv4GZ8kD7yTDwnouuHDCYPhc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QwlH6SqNzxbuM+t81LsK/HTKDdUGGIip14IkBtE6DdjtCmCY1xrFu/Zaqa98S/KRerdAvi1GIBX1blkDkITHwA5VgaHlTs2oBavpesXnKT1s8sKFov/wG2dcLazeSo8iKIPvUwoAIgXqicKzDhLv/15UnLEheH/QVI0BhmCIgQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H9ieu6t0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A6E7C4CECF;
	Mon,  9 Sep 2024 16:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725898352;
	bh=OtOcI4mwE4jLt6DU3HeKv4GZ8kD7yTDwnouuHDCYPhc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H9ieu6t0DxInHvwEGyZjzDRyo24HMrpacur192BO207ZdU9YWj1udgNu7cJFa8b9i
	 Ev1k7lkUnUFmKN53YsjzA8BnUitV9kzpBO0+D/hXfnfxUJU8dpctJ1YgYyO44Maf1X
	 gSd20JtTod/qAK6lLGN+wY8oM5Xu2/Hu72gGqkLQT9rKa4w9ppVaN2ryPGHNlqtiot
	 i+3Knzp5KaBXHksKxizNCjpuFbFk4twpqPUsIL1M+O6wolbnK883UCWjyCeTt/f7nW
	 G2u0mIPvy0fvG+q1/fHBzzM014RkCCwgtbtf50Vwneync30s7woRtMM/lgSF8iLElE
	 ZLGokkxxoDlHA==
Date: Mon, 9 Sep 2024 11:12:31 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Fei Shao <fshao@chromium.org>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Fabien Parent <fparent@baylibre.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-mediatek@lists.infradead.org,
	Markus Schneider-Pargmann <msp@baylibre.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	MandyJH Liu <mandyjh.liu@mediatek.com>,
	linux-arm-kernel@lists.infradead.org,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Alexandre Mergnat <amergnat@baylibre.com>,
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH 07/13] dt-bindings: power: mediatek: Add another nested
 power-domain layer
Message-ID: <172589835005.306979.15596103474181849299.robh@kernel.org>
References: <20240909111535.528624-1-fshao@chromium.org>
 <20240909111535.528624-8-fshao@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240909111535.528624-8-fshao@chromium.org>


On Mon, 09 Sep 2024 19:14:20 +0800, Fei Shao wrote:
> The MT8188 SoC has a more in-depth power-domain tree, and the
> CHECK_DTBS=y check could fail because the current MediaTek power
> dt-binding is insufficient to cover its CAM_SUBA and CAM_SUBB
> sub-domains.
> 
> Add one more nested power-domain layer to pass the check.
> 
> Signed-off-by: Fei Shao <fshao@chromium.org>
> ---
> 
>  .../devicetree/bindings/power/mediatek,power-controller.yaml  | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


