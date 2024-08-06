Return-Path: <linux-kernel+bounces-276658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 34E929496A2
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 19:24:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF7C81F286F3
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 17:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E2024C62E;
	Tue,  6 Aug 2024 17:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nX5McNm4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA3C36AF5;
	Tue,  6 Aug 2024 17:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722965091; cv=none; b=c909Cz5ekd5GdKs1x4w8HAeoRN50jA6hZkMrV2JO8nnshlV3XOaoS2f/hhWz08eNjRMGQWsmzrK0NqhHludyVAjKFyiunwx8/0pff6BzHsTjMESw9VynutxwVKZJETxP/wIu2Ve7wI9UeyZ/+lZyH/K/wf5S8a+kyNdyHpZnIxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722965091; c=relaxed/simple;
	bh=MCsRf95V/233ppFa+ogoZO+TKh+T4CSExd6cp5gIZw4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gL+DrmGpQMO3IjKoW1SqqH9XMu9M71r9/aAouQus0ZAICoXXQPQDiGv9kkYSsAVWUKFwl5WbP2ta9jPw3EHWIZYFQuG2AXybb7NdTsMJP48+PZvWwHoHn7ZhGGHypwY0NTVsTu2Ykfsl+1ts5JXDLW9dqn9yzAocYpKJedzzosk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nX5McNm4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E27CDC32786;
	Tue,  6 Aug 2024 17:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722965091;
	bh=MCsRf95V/233ppFa+ogoZO+TKh+T4CSExd6cp5gIZw4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nX5McNm4MWFmK0KGuU0aKb/nNbKdG468bU9lApVnGo7uzkscv+XRH9q2Aa0ZkiWHZ
	 9v5Y6xnJ+4LDwrp1yrlQ1GOEpxDyq8bMe7XFMo5VvvH90uFV+q4yKJQX1RoRjNtLot
	 YgouMUgnDxcqJ0FLVXbfWMqPxffDI9kCG5t/aHVq3Pu6e8arIBFPMemwH3GO9FN8/m
	 T4H/kfn5JW+wuQ8fnMz19iUL92HF0R2MpjK/UcQdEJqEl+qwvA1LwYaMxKo87oQUiB
	 2d+OvoY3xpgclfg3RPHwcqsGNIc+lY9nZZBN8LbeBX52Jcr+lYW3fU5OfRJmCcQVbA
	 FjnEeo4XLNASQ==
Date: Tue, 6 Aug 2024 11:24:49 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Sergey Bostandzhyan <jin@mediatomb.cc>
Cc: linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
	heiko@sntech.de, linux-arm-kernel@lists.infradead.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH V2 2/2 RESEND] dt-bindings: arm: rockchip: Add NanoPi R2S
 Plus
Message-ID: <172296508945.1835210.9491608113074748962.robh@kernel.org>
References: <22bbec28-41c1-4f36-b776-6e091bf118d9@kernel.org>
 <20240801175736.16591-1-jin@mediatomb.cc>
 <20240801175736.16591-3-jin@mediatomb.cc>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240801175736.16591-3-jin@mediatomb.cc>


On Thu, 01 Aug 2024 17:57:36 +0000, Sergey Bostandzhyan wrote:
> Add the NanoPi R2S Plus variant, which is an R2S with eMMC.
> 
> Signed-off-by: Sergey Bostandzhyan <jin@mediatomb.cc>
> ---
>  Documentation/devicetree/bindings/arm/rockchip.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


