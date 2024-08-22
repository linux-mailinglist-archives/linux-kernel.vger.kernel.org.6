Return-Path: <linux-kernel+bounces-296827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7272695AF8A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 09:43:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A553E1C2150B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 07:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D8E015445E;
	Thu, 22 Aug 2024 07:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FUkg6gap"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB9433EA;
	Thu, 22 Aug 2024 07:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724312615; cv=none; b=BGJ3YliMhZmDLzi/guifUGxhFp/m5IPz5lCeTV7rI9b8HjNq+z4SAbRMQfBe1srtrKLq1Wkm24Y6m82VKVH7ktZpuW5otG357oKfMjYEzrRCn88KDBcNKF7gMKTLOOTXfupsjRLoDnUpTdbKlrphCRlqYjngBMtuolPg2FUyUn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724312615; c=relaxed/simple;
	bh=AK/xKIzO4LquYSa3Q1oE65b0txD/L+ZJgcTFxpFcUSA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iTKTNCZNOecVx2dU8aXEDPVblCiroGGF43yf+yVNoN0KbH2pdknZwByXYSDnKCIHxztFttYkl8E4GyuXIRPSZm+ggCWV+WAATR361JaUofd48BNpWnoWtc80HszUvGQinBr5lfZjK1bYDQlTkggFUHuaDBYF0W22OJDoB0Wz3ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FUkg6gap; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17364C4AF09;
	Thu, 22 Aug 2024 07:43:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724312615;
	bh=AK/xKIzO4LquYSa3Q1oE65b0txD/L+ZJgcTFxpFcUSA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FUkg6gapQxxX6quXXXFRUKJOZt+8KjY6nZJXyF1prQnI+xXGfwNK/SyqUE4FNGVNH
	 jB6NbeNeIJkhNoPP0hWb13ZBzxtbUfzqV3sskk6QavLqidPOYb70hbFU/nFBOhP8rP
	 0oQb+ZtvvM/k1tsVS8RdrccthUgsaIAtMZvOGIyVJ1qi3cKtYKeAMiKebMTgYXvAib
	 YhmHnQzN912Q7ZFH0SexObsRX/7Bp68DxY9j/l/qrVFJ4N7MCZf8ni3nGYCfh0ZR+w
	 0e0kunKAtMKKGSjtsOfAEs9RpMt/42pY9gFWadHx8w2vtydKiYt5TOGmZjVqOFhwgn
	 bZTUK4n6FOtHQ==
Date: Thu, 22 Aug 2024 09:43:26 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Rohit Agarwal <rohiagar@chromium.org>
Cc: chunkuang.hu@kernel.org, p.zabel@pengutronix.de, airlied@gmail.com, 
	daniel@ffwll.ch, maarten.lankhorst@linux.intel.com, mripard@kernel.org, 
	tzimmermann@suse.de, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com, ck.hu@mediatek.com, 
	jitao.shi@mediatek.com, dri-devel@lists.freedesktop.org, 
	linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 1/3] dt-bindings: display: mediatek: dpi: Add power
 domains
Message-ID: <uabbapstxrkfwlntifdoowcsifb5ywfhxubaycfyhwkkykfpev@4hdqcxdov3er>
References: <20240822064650.1473930-1-rohiagar@chromium.org>
 <20240822064650.1473930-2-rohiagar@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240822064650.1473930-2-rohiagar@chromium.org>

On Thu, Aug 22, 2024 at 06:46:48AM +0000, Rohit Agarwal wrote:
> Add power domain binding to the mediatek DPI controller
> for MT8186.
> Also, add power domain binding for other SoCs like
> MT6795 and MT8173 that already had power domain property.
> 
> Signed-off-by: Rohit Agarwal <rohiagar@chromium.org>
> ---
>  .../bindings/display/mediatek/mediatek,dpi.yaml | 17 +++++++++++++++++

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


