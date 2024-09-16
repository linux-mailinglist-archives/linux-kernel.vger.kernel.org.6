Return-Path: <linux-kernel+bounces-330991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6304297A6F1
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 19:43:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C688283D96
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 17:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBCC915B963;
	Mon, 16 Sep 2024 17:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RECG0Ubg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2133B158D96;
	Mon, 16 Sep 2024 17:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726508604; cv=none; b=FaN8hje2vy4+tTnOw7bP54OQMbb8zP5baww9IRKzarTXFFioXCPcJhh/lC22PAXCKlG1kQCTSpJO8CD8zktYaMBPxZm0I3NNfzi+EZuvQbUDthrAi8FZuYQ8mbCSVlrYF8LXRmefW3GLF+YfIvM0eGtu/ladj5Kpre9Z2yDgVpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726508604; c=relaxed/simple;
	bh=JjjqoHBbrAIkpCbOUUlkHPM0n0YlMlxgxT2/SNiWpy0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oh2/ctXwkhKyei5h3BD/6bdLUmnV2xD6BUIofirSOHclZOrjneU9kI5H1cTJuebj1bROfMpxEWDUvplgvw4WmDvYONRpFmP9sUUaT4hIkGddAQ4lyhAWeUOCUfHJWt4XyEhESb1aOrxE9lqIIcjxrgYu2KqdUEZhLh90MrAWM30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RECG0Ubg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A77BC4CEC4;
	Mon, 16 Sep 2024 17:43:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726508603;
	bh=JjjqoHBbrAIkpCbOUUlkHPM0n0YlMlxgxT2/SNiWpy0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RECG0Ubg7B6sGx+CjqOr41EeWDehL2TTMnyTKo7+iZPzr214ao+CknbPvNZ1+0VHT
	 qL+FhnRq9hoCYb14wGjUSoCiwu3FsmSrRKkHs0dJ+f6oaQpYidYuI+ko5uxgXanBhM
	 Fha/uRXnklucSEYzPjyMkgEEnIAJh7Ptxyl7KwYseW0DtwDMnE4SqjbM1YkEwNZZBl
	 mWfsHk0Ha9Fpiafq7wszPp18elPPsG5bffLC+0QvHid8Xp117YpVk1BMQSGAEJ/mWQ
	 mr+JaUYowqRzcNUK/38FStV1ZOxzNMQPZ9BaobZ4zGqRwf1ePtzL6dfOnvKQbORxDX
	 HmZR3CmtDNlew==
Date: Mon, 16 Sep 2024 12:43:22 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	devicetree@vger.kernel.org, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: dt-bindings: realtek,rt5640: Convert to dtschema
Message-ID: <172650860184.861976.2123613682245526181.robh@kernel.org>
References: <20240911-topic-amlogic-arm32-upstream-bindings-fixes-covert-realtek-rt5640-v1-1-6b3745e34540@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240911-topic-amlogic-arm32-upstream-bindings-fixes-covert-realtek-rt5640-v1-1-6b3745e34540@linaro.org>


On Wed, 11 Sep 2024 17:34:01 +0200, Neil Armstrong wrote:
> Convert the RT5640/RT5639 audio CODEC bindings to DT schema.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  .../devicetree/bindings/sound/realtek,rt5640.yaml  | 146 +++++++++++++++++++++
>  Documentation/devicetree/bindings/sound/rt5640.txt |  97 --------------
>  2 files changed, 146 insertions(+), 97 deletions(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


