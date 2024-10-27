Return-Path: <linux-kernel+bounces-383833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5974D9B20AB
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 22:06:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD84FB20F90
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 21:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4ADE18595B;
	Sun, 27 Oct 2024 21:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pIIcuwp4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09CBC170A1B;
	Sun, 27 Oct 2024 21:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730063206; cv=none; b=EH9xCbHU8WWdreHxedqkq1r5f7uGfFRb2gOhcBffG2vNiPg6rslIBwyiPuafN7ViVwBpkUXpPLfdeboxIJcNfwSnkUXUcyMjnGfkiqxab8RGxn3piz+mFhXHhOeSqfnL0Xmp6DHghTZaaiitqN9vEID7TjeqqyWLTspZ40vkVnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730063206; c=relaxed/simple;
	bh=CO7k2Dg/RtRuxPaLMt+WxKeEr7MfB16b+EAkMICuDQY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hGO6gbI2uHFIVexa7oFtrgvlxHGkUa7Xv81XBNJDw+Js+QLF4deoPyNeAaiNLdQhPoudjj1Ku2KbcTA9c5VCbhTy+eygmdWUKF0CPeQdzQDMSCGi2s+tdkh7UCKM3dgGbHi64DAHl71QN02oYI7mn19b6ND8gBUIyUVZxCJvD7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pIIcuwp4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E333C4CEC3;
	Sun, 27 Oct 2024 21:06:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730063205;
	bh=CO7k2Dg/RtRuxPaLMt+WxKeEr7MfB16b+EAkMICuDQY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pIIcuwp4gdtTDh6Clgp23Kw9gsZ0nOzwkhUKsgMa2vpwg3C9L91p4Fy3gnTZjk6po
	 r3lhEHhgiMCAQYilsGrxu7mOghlEBJuMKhG/xrZ0iWsEGBbqEHlq3K60fcx910Nrh3
	 EsrJWjlmiKyCCifgbgeLoYpS0TA37cXTgXO/2MqyZP7srQ9xsx3D0S4XfP+0F92gYJ
	 MkamC0N2UAGHHFUJoK3YrNWH2XOe27G8eADqIvi+KwXk0EYJ0dpHW7LnIqlzbXIrAn
	 NQbmNOyqYHJRnYlIEwsvScQ0Kvt+xdm/xbhaOPUAdT5M/rCyUxBOsFZwHtDTbSL6c2
	 mycV4qiZ7HAMw==
Date: Sun, 27 Oct 2024 22:06:41 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Markuss Broks <markuss.broks@gmail.com>
Cc: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>, 
	Maksym Holovach <nergzd@nergzd723.xyz>
Subject: Re: [PATCH 1/2] dt-bindings: arm: pmu: Add Samsung Mongoose core
 compatible
Message-ID: <zcxzmsc642ggozzpj73skzxfce7jnoj7fmdg57edbin2rfh7mn@6acurllfar73>
References: <20241026-mongoose-pmu-v1-0-f1a7448054be@gmail.com>
 <20241026-mongoose-pmu-v1-1-f1a7448054be@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241026-mongoose-pmu-v1-1-f1a7448054be@gmail.com>

On Sat, Oct 26, 2024 at 11:28:08PM +0300, Markuss Broks wrote:
> Add the compatible for the Samsung Mongoose CPU PMU to the schema.
> 
> Co-developed-by: Maksym Holovach <nergzd@nergzd723.xyz>
> Signed-off-by: Maksym Holovach <nergzd@nergzd723.xyz>
> Signed-off-by: Markuss Broks <markuss.broks@gmail.com>
> ---
>  Documentation/devicetree/bindings/arm/pmu.yaml | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


