Return-Path: <linux-kernel+bounces-532106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1EFCA448B9
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 18:46:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 126F7887C0B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 17:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7121219CC06;
	Tue, 25 Feb 2025 17:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g6tvNyPx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4E419ABAB;
	Tue, 25 Feb 2025 17:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740505073; cv=none; b=oJ7OVEcrEg4YUc+Z/j/9PVrMLC/hwek/udbwJRFJl1SDBbIXBs+4Tms+tvvbKaAeWWzWmQysaMJSc30YwfRVB1srcU4XaYYai9tTxfgPL34u1kknpZFU0+95OTHKZKwwAA8cdDcceuoeZCUV8J9MFqj6TAcGs7M6O4tsHfjzqnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740505073; c=relaxed/simple;
	bh=ZWne6JIpxR1cl8WRkSXXaRRsFzUjy2OTsHXp6XlpFrk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kxtn7Pk2zEDc70WjFNIQFowErOwtHlBn0H701QeceFwMv+VQs8mj4X3mjx9B8xwwGxAGMrG1cyuMTAHLb1N7bTP3KIz98q+eOBq0oPA/D67w/+lxRdO6tZd1rVJvP2NWefc79NGCSYV0/jmOBT4zqRR3j74P8jkaoGzoxqbQEbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g6tvNyPx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 703D4C4CEDD;
	Tue, 25 Feb 2025 17:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740505073;
	bh=ZWne6JIpxR1cl8WRkSXXaRRsFzUjy2OTsHXp6XlpFrk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g6tvNyPxjx/3V9vKCjVQWspEC6u+Itv1OUBW5Vv8LaSBOhrbawOMd9bIgAXpCc0JP
	 l6QOKFSdtG/4WIQ7wuLICPjYHUaC1Emjk+Jywj6fX8kA8Dy4m0JMet3rEwy6aMlwRz
	 RGtOXf1MpU6l7vwgucbH1qkls9yVJ/aXc0fHtKVFMkfann8OrQNiZmGNdqg3gBCYh3
	 cX4jGo93mmWa4RuWQIMNCsumLj33WaT65j1HXhtBmV+FenBKceftxg03dyBadNPqON
	 Vqnao0tSE6EXKZYSuwplJmsAkYJaziakuMtkTVL6DbeMISGia/0jBtKUhhR3rNpLap
	 rM4ubtcElQ07g==
Date: Tue, 25 Feb 2025 11:37:51 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: =?iso-8859-1?Q?J=2E_Neusch=E4fer?= <j.ne@posteo.net>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] dt-bindings: timer: Convert fsl,gtm to YAML
Message-ID: <174050507117.2741247.6409139825987675023.robh@kernel.org>
References: <20250225-gtm-yaml-v1-1-de5da7299430@posteo.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250225-gtm-yaml-v1-1-de5da7299430@posteo.net>


On Tue, 25 Feb 2025 12:50:43 +0100, J. Neuschäfer wrote:
> Convert fsl,gtm.txt to YAML so that device trees using a Freescale
> General-purpose Timers Module can be properly validated.
> 
> Signed-off-by: J. Neuschäfer <j.ne@posteo.net>
> ---
>  .../devicetree/bindings/timer/fsl,gtm.txt          | 30 --------
>  .../devicetree/bindings/timer/fsl,gtm.yaml         | 83 ++++++++++++++++++++++
>  2 files changed, 83 insertions(+), 30 deletions(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


