Return-Path: <linux-kernel+bounces-419148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75D619D69FF
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 17:17:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BE4B281C0B
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 16:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E57D252F76;
	Sat, 23 Nov 2024 16:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cWRrf8Rz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E05E17C2;
	Sat, 23 Nov 2024 16:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732378671; cv=none; b=RxIIch/D7rlU3/g79gEtvGtLphexd6V2+M806Jik/b7jKDAK2X3dahJYcW1A6cl4KCLhjz+Kf0kJt13HcE2tZsjGn3oxPJm6C3ayceKXNX9BTxcy2W+8OOjpwXUNl4fJ2LFw1p1iBJJZnbVD7naiUFgx+ltvbgnjHOE3FFlB6qA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732378671; c=relaxed/simple;
	bh=r7VawsBWko4JGKpwGiwsn4hr5Gg4jKmMEXWLC4Zu6jo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hSdLCGcREk16MbbVw8dnn7cEcdn4HtvsGeaSwfxODyDmaq6KYfVpjS8wbpNXIA9iCaWEZihRwXfVyxO3ICJJ3UyFxf1n30/94qwkkYMiyOFRihTaH0aFisTFlyD1lNk4dkLdR0SBhQRtjt+EqGt0nxdb5Mn6T6ut5OyNOw7+XuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cWRrf8Rz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA4BBC4CECD;
	Sat, 23 Nov 2024 16:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732378670;
	bh=r7VawsBWko4JGKpwGiwsn4hr5Gg4jKmMEXWLC4Zu6jo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cWRrf8Rz9VUSKtqdMeH5xQslmt3yr8WCrh/jUNlPQdAbDvLReCrQihlUtfMaW5Q/j
	 mTCfSAepcwct5RLq9f2JqO7rmLDxqHOOxV24Wl8/5e3lWaIxb4Itl63lrFzSQ/4Kyn
	 TB3dY4Hi/daPK6kwmAKgljw+MnRTyl9Cl8gpGlpvpo/3Fxhl4r3dr1L/+zDher1IDV
	 WHdRMQRWSGlubx0u4lvCJ/27a2bDDzb9jVYRMRxHdE7BMtAn4ZFQhQl3YTx8Ya88JZ
	 cpIsfDXnoJ1Kt2W9c+eCVQKo2ifTj907w124rZVEa35Qkge5La5CFaRpYZXdyzOPQr
	 X099PezSbMmww==
Date: Sat, 23 Nov 2024 17:17:47 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Wojciech Macek <wmacek@chromium.org>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Chen-Yu Tsai <wenst@chromium.org>, 
	Rafal Milecki <rafal@milecki.pl>, Hsin-Yi Wang <hsinyi@chromium.org>, 
	Sean Wang <sean.wang@mediatek.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v1 1/2] dt-bindings: arm: mediatek: Add MT8186 Starmie
 Chromebooks
Message-ID: <cxuf6dwyp5cyzcq3h4bgydg5fffc24bwfz3umifqnxqyyvuhc5@pbe3v5andnrr>
References: <20241122104938.1437925-1-wmacek@chromium.org>
 <20241122104938.1437925-2-wmacek@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241122104938.1437925-2-wmacek@chromium.org>

On Fri, Nov 22, 2024 at 10:49:37AM +0000, Wojciech Macek wrote:
> Add an entry for the MT8186 based Starmie Chromebooks, also known as the
> ASUS Chromebook Enterprise CM30 Detachable (CM3001). The device is
> a tablet style chromebook.
> 
> Signed-off-by: Wojciech Macek <wmacek@chromium.org>

This was absolutely never tested. You obiovusly miss some items or enum,
but main point is that it neither looks like existing code nor it was
tested BY YOU prior to sending.

Best regards,
Krzysztof


