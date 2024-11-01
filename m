Return-Path: <linux-kernel+bounces-391833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F5799B8C2B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 08:42:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D06C71C21EF4
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 07:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 348751547C8;
	Fri,  1 Nov 2024 07:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l8Vr2djH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85ADD153BF8;
	Fri,  1 Nov 2024 07:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730446957; cv=none; b=rbTa0kNHfEVG1Tc/yJBV0ddKxdRkC0WJE/0z6Ec8QCHgfb2Gls/MOIrFK9KQBvvjbTA63aytPEq2IWzkvx78nq/MTywPEEHU3LeE64FwKOon0RAimMkyxx1kxYHU8z6HVqbNCK2R5Nn07jvloKce8RzUQJZH+J9Asiv4o8MIwf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730446957; c=relaxed/simple;
	bh=0oNmvFac5245Iw3R03dhUawXYguOd6fOhCVHCDRw/pA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TT/1YCr8/g1WxhLJV/SqIHUlhnY0Q2tJ3DMHlCr+wmIhdpdxwOfA7xBoXn8eDHC/wEA8tXua4QBqCFTXOxxERnJFhNdTQHQkOL258EKYzHPn5czedHUhb77n+SIWocbhjuFpdv8naslmTUYl9Z94XLUGyf7v1h504/7LVOAFeqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l8Vr2djH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39514C4CECD;
	Fri,  1 Nov 2024 07:42:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730446957;
	bh=0oNmvFac5245Iw3R03dhUawXYguOd6fOhCVHCDRw/pA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l8Vr2djHUs7y0gdTiLx9KSyaYapvUg+x7ibuPfsOfpMOet6nEHK4anWnAediZZUBV
	 YC2HKiiJBIwKRWceDnnojRRPl94/RE6ce91Yeoc9O7gZJUGckMLyiZx0yZL1+Anysz
	 ztwVDWcObnOm245zQqmPuzT2TgbCID7qUIX7y4cT9CWDGaRIwuT31p9zYSduD1kR86
	 /+wBEY9xDQs7Fhgb4zixG5LPaHdJeKtORdjyA0EW5LhMqkLVY5B9Cl47nYPU3Pc2yC
	 7SRukrwKmuLrOm7hhdDIP4qoqQrE6ni9iQeD0p2ISkPx5Is7IRxZt8TFF9Ll8HHPLG
	 ykSfamTU39XnA==
Date: Fri, 1 Nov 2024 08:42:33 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Stanislav Jakubek <stano.jakubek@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Orson Zhai <orsonzhai@gmail.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Chunyan Zhang <zhang.lyra@gmail.com>, 
	linux-sound@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: sound: sprd,pcm-platform: convert to
 YAML
Message-ID: <nquz3c6uty64ujtesz6e4nodycxui6xgvktr6hcq4whkokywph@t62vclojf6gx>
References: <9fc646b70a73e7a6c513771d69b0edcd140f09d7.1730310275.git.stano.jakubek@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9fc646b70a73e7a6c513771d69b0edcd140f09d7.1730310275.git.stano.jakubek@gmail.com>

On Wed, Oct 30, 2024 at 06:48:38PM +0100, Stanislav Jakubek wrote:
> Convert the Spreadtrum DMA plaform bindings to DT schema.

typo: platform

> Adjust filename to match compatible.
> 
> Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>
> ---

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


