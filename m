Return-Path: <linux-kernel+bounces-320660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76512970DD7
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 08:26:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3D3F1C21CD9
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 06:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2F581ACE03;
	Mon,  9 Sep 2024 06:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jXdHQo7a"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA541741FD;
	Mon,  9 Sep 2024 06:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725863160; cv=none; b=FCRFAvxDhuUj1pbD/Qmo8DYpA7+vdRZpe2nijjWGXRTRCFE0HQ5bBHYQDCLkqbZGDvz328bz8qVkROICjb40I1w5edJiBCG17OlDg9PB5RiQQUQ4/wuA01GjKQWZHF9bRcdNTZ/ydmLVmAeu2d2KIuS07OPW1PyiJw5LXKrMUCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725863160; c=relaxed/simple;
	bh=h3R7Wc/y9Jn11tIYXxPq8te7w+gEIXkmjBYE8s+68bw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nib33sPatv42aS7LTln2/15B86k7NA2msA/uQPlb0BR0aJnl51oSGDFfaG3Zr1vG8dIm323Y1gKGLpF+hPgGMbmWONOFygxlqxniYcOAwx+VFaZwltY6Fweg+ymZn+pZ7gJbjLkKv2XAec9Sup16bidsSeU4BFBM3l2DkYqua4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jXdHQo7a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 376B8C4CEC5;
	Mon,  9 Sep 2024 06:25:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725863159;
	bh=h3R7Wc/y9Jn11tIYXxPq8te7w+gEIXkmjBYE8s+68bw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jXdHQo7aaRCa7iGfXH3EpKVNmKcJNH4tYZIvubFW6Ml/al36ieCbrs7mmlcGykROA
	 sCaEJ8mY758FdLDffPfCEVS1Tqo9B9tfporEFRKcL/Jxz6guHEGuWYCm8xy+vDPp4c
	 VK1Fz5RGE4p/xGnrYc4bvDv/kJ0+9alXs9RQ+9kNXKpXFO71mtFUbJEdp+ec8kij+P
	 DipaaDfMgVgbMbRYcd86WpnWpnZi9JoORiAY1SCi3Yh6mu0IQZ5hmohhjBmkYBLdzX
	 gXmPwz3Pl53HlI1WyE49rymwxPU51yOk1+bm4KfRv17/B6rkBD3wu5nUJ26ma+VBV1
	 Azn4imotPlsag==
Date: Mon, 9 Sep 2024 08:25:56 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Jianeng Ceng <cengjianeng@huaqin.corp-partner.google.com>
Cc: hsinyi@chromium.org, angelogioacchino.delregno@collabora.com, 
	conor+dt@kernel.org, devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	hsinyi@google.com, knoxchiou@google.com, krzk+dt@kernel.org, 
	linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, matthias.bgg@gmail.com, 
	robh@kernel.org
Subject: Re: [PATCH v5 1/2] dt-bindings: arm: mediatek: Add MT8186 Ponyta
 Chromebook
Message-ID: <lp7rhdmz5khuu7cpw7cg2oilkgfcip3fu2gr4r2f6vkk3cbg3e@iyqhqhn26pw4>
References: <CAJMQK-imYrDTuycVzQxkfbkZuHehE8uwc+qS2w=UDShETsBvEw@mail.gmail.com>
 <20240909023148.1677936-1-cengjianeng@huaqin.corp-partner.google.com>
 <20240909023148.1677936-2-cengjianeng@huaqin.corp-partner.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240909023148.1677936-2-cengjianeng@huaqin.corp-partner.google.com>

On Mon, Sep 09, 2024 at 10:31:47AM +0800, Jianeng Ceng wrote:
> Ponyta is a custom label Chromebook based on MT8186. It is a
> self-developed project of Huaqin and has no fixed OEM.
> 
> Signed-off-by: Jianeng Ceng <cengjianeng@huaqin.corp-partner.google.com>
> ---

Do not attach (thread) your patchsets to some other threads (unrelated
or older versions). This buries them deep in the mailbox and might
interfere with applying entire sets.


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


