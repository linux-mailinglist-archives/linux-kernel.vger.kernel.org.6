Return-Path: <linux-kernel+bounces-292607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B8059571C4
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 19:14:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD8B6284092
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 17:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DFA1183CC6;
	Mon, 19 Aug 2024 17:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GcTI01rv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC92188CA8;
	Mon, 19 Aug 2024 17:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724087615; cv=none; b=VsXZwK3RM+++LL43t1u/ayYcP1V+ytOZv1vQge7hMjommlXMfQ8VMm464hmPIObmMmbEJjEyAVxjeLhb4m3LjjvlX15djs0Jeyutwd4Ycz+dEQ+5VPXCBhiJR2UhWMcfTaleHIzqtz4701LZ+A8rG+6O0765Ftrelr3BLao7ts8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724087615; c=relaxed/simple;
	bh=poyNrK4+rkwqpQRN013SCLxOt1CKzezDUiyIK46mjdQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oGvEM5nErg+HI9fVifk9RoJawmlNfi/pY4DaunYm2Zjy63BeYNiCxykfJY2Thna+e1RGDIdurl5vJwbxz6QGp/+McLkZzxnKyfv3XJWnMpLTOFjGVeAiKSmIvfygHYqlyZqypUHfGgZ94tjl1wi1M2Ra4l2q6S5lOxgDfQUF+BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GcTI01rv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E1A8C32782;
	Mon, 19 Aug 2024 17:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724087614;
	bh=poyNrK4+rkwqpQRN013SCLxOt1CKzezDUiyIK46mjdQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GcTI01rvFjez0BhOGF5eDrdK5pMP3A2D4gDA0fCDghsBr6gdl6Ee7k65cgoSsIyR/
	 2a0/cQLtTRqJ+9xMrUS2XpMs2smN7OStUWiMQ0oiAr6TFivH6Vcb5BrY3P4rC0+W5/
	 cJJzxmFnwyEsFqtuwXldibCd6FLgsW7dD5PQih4CVzQURYko4RwgA1ODd/ONlQv5NQ
	 n/d0O5g8b8i1i1w/BdhgSXMOHvdwRqcDjCKyUKoawGXa0WoS1aUGQfT4d3ugzyB5A2
	 YkDLKnRNkp1Ho0mfSyS8MjSPbsmOt5ajBDPw25P9tesfS12jEVnC6uZMuafNV+AfhW
	 V2bYZ4IA3HPow==
Date: Mon, 19 Aug 2024 11:13:32 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Philipp Zabel <p.zabel@pengutronix.de>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Conor Dooley <conor+dt@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: Re: [PATCH] dt-bindings: reset: socionext,uniphier-glue-reset: add
 top-level constraints
Message-ID: <172408761101.1696404.18071767765994153650.robh@kernel.org>
References: <20240818172819.121697-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240818172819.121697-1-krzysztof.kozlowski@linaro.org>


On Sun, 18 Aug 2024 19:28:19 +0200, Krzysztof Kozlowski wrote:
> Properties with variable number of items per each device are expected to
> have widest constraints in top-level "properties:" block and further
> customized (narrowed) in "if:then:".  Add missing top-level constraints
> for clock-names and reset-names.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/reset/socionext,uniphier-glue-reset.yaml     | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


