Return-Path: <linux-kernel+bounces-203459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 647BA8FDB8B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 02:38:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 791FD1C23018
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 00:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E310DCA6B;
	Thu,  6 Jun 2024 00:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Of9q0GTy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2001C2E;
	Thu,  6 Jun 2024 00:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717634324; cv=none; b=jhOvM9xvZRtiFFf+xEtoyvVMBO4dtZb4B1EMQY14VZJNbBM73eod7/tkJtI0xEQPV8vOFGOR5XVjSuoMzxe7P0DWyeFezU7zcihus8z82g3NS50/NWCDDlYuZtrwMNqVc/CqVNSzhERfBvwoA4cH81qYZi55FHEsXLhyu4VkTZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717634324; c=relaxed/simple;
	bh=yA8JXQglBvejFF7jK/DqobhKHQBVwv7RECc+KLN/htY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dVC6PZeqYPTZUgxkksk11M0udEAOEri/ioztzFn6zNZYYTfmeCn7C1mzSl7pt+3t+2b1SfZjG+bPzYhexauRafI1D7FWud1vWDPYmKp6k5NMhW/e/Yaca6+JMNmwowd5/zZ7l4L/JmjAMlxrZlByOh98Ka611HQqzPeO69LddEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Of9q0GTy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34BCDC2BD11;
	Thu,  6 Jun 2024 00:38:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717634323;
	bh=yA8JXQglBvejFF7jK/DqobhKHQBVwv7RECc+KLN/htY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Of9q0GTyzdfSeB7VBeSq4FxJgjsiwPFN9APFFe2lVDkOufkqJG/Pwp3SG6zAuCsnn
	 SqT6ADFmfH+ufRELcCX4QFFQhnDj2SHuZEAyq8mTrcl2D/URsJlxUqpLiO1Hxs8eUC
	 V9QTFu+mvQNqd8BFCYWlpGR9bE/AZTxkqw+fBmUV8Az2DooU6bX0dKktdz0+GOIbvw
	 ENMfY37oK+2A8XISbu18OrNZ+95TR5lgLPBPhk/3uCHl0WHo6N7MW7yGJAESPL7NP5
	 Zqe2YAkCEfZChWVwOzKTn0FemSzNc5IIt0U8fQZXwouvuOaxvHnqr+hOiLQ1G031Dw
	 TOSFVur1ig6Ng==
Date: Wed, 5 Jun 2024 18:38:40 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org,
	Conor Dooley <conor+dt@kernel.org>, Mark Brown <broonie@kernel.org>,
	devicetree@vger.kernel.org
Subject: Re: [PATCH] ASoC: dt-bindings: amlogic,gx-sound-card: drop minItems
 for audio-widgets
Message-ID: <171763431818.3524953.6773726954560624360.robh@kernel.org>
References: <20240605-topic-amlogic-upstream-bindings-fixes-audio-widgets-v1-1-65bd7cc2e09b@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240605-topic-amlogic-upstream-bindings-fixes-audio-widgets-v1-1-65bd7cc2e09b@linaro.org>


On Wed, 05 Jun 2024 11:40:51 +0200, Neil Armstrong wrote:
> Like "audio-routing" drop the minItems: 2 from the "audio-widgets", because
> any limit here - lower or upper- is rather meaningless.
> 
> This will also fix `dtbs_check` warnings like:
> sound: audio-widgets: ['Speaker', '7J4-14 LEFT', 'Speaker', '7J4-11 RIGHT'] is too long
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  Documentation/devicetree/bindings/sound/amlogic,gx-sound-card.yaml | 1 -
>  1 file changed, 1 deletion(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


