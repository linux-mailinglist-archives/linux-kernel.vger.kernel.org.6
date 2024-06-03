Return-Path: <linux-kernel+bounces-199352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E51478D85EA
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 17:20:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22A8F1C2216B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 15:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D75861304AF;
	Mon,  3 Jun 2024 15:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qKOEUN4P"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 099F012C530;
	Mon,  3 Jun 2024 15:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717427992; cv=none; b=rPGJXks/MWZL4y8gD7/LkWoVI5vcI+wNsElFJy5R5RUkqPKKxK64n4rUY6dBREAZYSsPjItu67UpH6nrqq/OxFulkwLiNCaTlcEvQHcNepTY938wbjeCC+E2GfOnKQFl47nCJCBK+1fxQQb0JZp1YVX2z5FXJyShdMmPULBNlYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717427992; c=relaxed/simple;
	bh=ijFVnlnPe4zsomyhDg/uKsVKn4FbatsAOMaZJzU2c5I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qiMRTBsDgrJKpLxULenIIKcjEVulVkzk+UvhvX3shE7egy3HYT07jZtAiYipZch3luqrPPK7w4JxDZUmIpJECXVUGYGqCn/P5WHDf6Lr6NroIc1QSWD/rZzluCFvlynVmeUhDQKnYmrz0yJX4UDrRgH0TgW74NH9mPUC7KOMqB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qKOEUN4P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29012C32781;
	Mon,  3 Jun 2024 15:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717427991;
	bh=ijFVnlnPe4zsomyhDg/uKsVKn4FbatsAOMaZJzU2c5I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qKOEUN4Pu+QL0in2TzHhV83HuGS3DoXq+HWMG3I5DXalhiauPyPK9E3wWuESvxWY+
	 XR4s1HEk4jd5x9/VtXIJRWcDVuWalwN2U8WtgvaMrv/JHfFljpLK2s9a5RZT6YYjMg
	 1gFz+RoYtaHMGVHkWBAFLE1wa8Vz41dbSxCBsyAFBgXKMnV8D45G74dML9AMrHJ1X1
	 7CQY87wtvaH+uUJErkWK8qGhYjjdZo9T+Q3S9MyidigHGEgGRXwExz83GhMS8SiwHB
	 NUhgjxegNKsd69aGExvSw100T+BLCwixrFqZF54bzii+LQBPw483EOYd82DUuyAOuJ
	 AldrXeO0R5MuA==
Date: Mon, 3 Jun 2024 10:19:48 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Ricard Wanderlof <ricard.wanderlof@axis.com>
Cc: kernel@axis.com, Kevin Lu <kevin-lu@ti.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Shenghao Ding <shenghao-ding@ti.com>, Baojun Xu <baojun.xu@ti.com>,
	alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH] dt-bindings: sound: tlv320adc3xxx: Fix incorrect GPIO
 description
Message-ID: <171742798573.458718.16069041554042584405.robh@kernel.org>
References: <20240528-tlv320adc3xxx-dt-gpio-fix-v1-1-209fb2c2f86f@axis.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240528-tlv320adc3xxx-dt-gpio-fix-v1-1-209fb2c2f86f@axis.com>


On Tue, 28 May 2024 17:40:04 +0200, Ricard Wanderlof wrote:
> Fix the description for the ti,dmdin-gpio1 and ti,dmclk-gpio2
> properties to correctly describe that when configured as general
> purpose outputs (ADC3XXX_GPIO_GPO), the pins are available via
> the GPIO framework.
> 
> Signed-off-by: Ricard Wanderlof <ricard.wanderlof@axis.com>
> ---
>  Documentation/devicetree/bindings/sound/ti,tlv320adc3xxx.yaml | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


