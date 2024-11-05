Return-Path: <linux-kernel+bounces-396612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBAC19BCF87
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 15:35:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 734CE1F21EF3
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 14:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5C871D95A2;
	Tue,  5 Nov 2024 14:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DNS80Tvv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37BA51D8DE2;
	Tue,  5 Nov 2024 14:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730817308; cv=none; b=RAaiYHHGQhqEezlLMxsACehWl8ZvvEfos7bQO1lB81AnlI8xkLQd4584uqPNd0jmbJ+mp94nyzDyBiq630xYyng4T06T3oz+b+gUFYrFhHfGXxjuYdbLlxLWorhBB05m9xX6tAn1+276+5LCHf74z9SwCexj92cJkJT3X5kE9/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730817308; c=relaxed/simple;
	bh=GzXTzvTNdEFEvbs3vOmKlQenO+9sg1FizpOvjE0B7tI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uTQ6+1sTl76BojRzNGEyZrfKIlv/j87mbouV2YQ6UW/sX+VCOegDQ0qZSNaoGprmSTJcRvYAhNNfwhyHiIw2IOZ4KQUl02eBTSiOwK/h+yVjv8/iTHwOmTkXzhs9z06d6ife+99z99Oq/FtCQMmIlrDKyw/1RgrKXm76IKM4+p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DNS80Tvv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F6DDC4CED0;
	Tue,  5 Nov 2024 14:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730817307;
	bh=GzXTzvTNdEFEvbs3vOmKlQenO+9sg1FizpOvjE0B7tI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DNS80Tvv78J/0XiKXz32MCfQ1gMlSIb4S2IrPsli6ERQEw8owhylWB2jDKFcKN3LS
	 XMv9bqdLMqAfwzsf26akE4PrHlmIVr+XI3+a6+uS6+fwG+VnPBWjokm/aChor3mdfi
	 BLj0+mE2gPFjaszrFSNOxbZz3Q3WTgIkvxgVq11fGqzZp/6rRz2vJJvBh8t5hZNYcO
	 +PqHkZNHGkqhFrAlEZbP9h1drCTn2F6WUDK+fkj+vUtGUzxg0PiJwHLxQzRBbvwN8p
	 4NYfGo934fPMjs+M17YS30Nz/zRFz8AZmWuvqslJDRfeuNvmIt2PX6YTy1eBOcW0dv
	 gYS5tqJguxQVw==
Date: Tue, 5 Nov 2024 08:35:05 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Fei Shao <fshao@chromium.org>
Cc: Mark Brown <broonie@kernel.org>, linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Trevor Wu <trevor.wu@mediatek.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2] ASoC: dt-bindings: mediatek,mt8188-mt6359: Add
 mediatek,adsp property
Message-ID: <173081730525.3220913.16778335543851389759.robh@kernel.org>
References: <20241105091246.3944946-1-fshao@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241105091246.3944946-1-fshao@chromium.org>


On Tue, 05 Nov 2024 17:11:36 +0800, Fei Shao wrote:
> On some MediaTek SoCs, an Audio DSP (ADSP) is integrated as a separate
> hardware block that leverages Sound Open Firmware (SOF) and provides
> additional audio functionalities. This hardware is optional, and the
> audio subsystem will still function normally when it's not present.
> 
> To enable ADSP support, a 'mediatek,adsp' property is required in the
> sound card node to pass the ADSP phandle. This allows AFE to link to
> ADSP when the sound card is probed.
> 
> MT8188 has ADSP integrated, so add the 'mediatek,adsp' property to
> allow using it in the audio subsystem.
> 
> This fixes dtbs_check error:
>   Unevaluated properties are not allowed ('mediatek,adsp' was
>   unexpected)
> 
> Signed-off-by: Fei Shao <fshao@chromium.org>
> ---
> This patch is based on a previous [v1] series.
> This is sent as an individual patch in v2 because the other patches in
> the [v1] series are either invalid or for different purpose in different
> binding, so I think it'd be better to send them separately.
> 
> [v1]:
> https://lore.kernel.org/all/20241025104548.1220076-2-fshao@chromium.org/
> 
> Changes in v2:
> - drop `mediatek,dai-link` vendor property because its goal can be
>   achieved by using the existing `audio-routing`
> - update property description
> - update commit message
> 
>  .../devicetree/bindings/sound/mediatek,mt8188-mt6359.yaml  | 7 +++++++
>  1 file changed, 7 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


