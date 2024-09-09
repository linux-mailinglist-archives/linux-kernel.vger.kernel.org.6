Return-Path: <linux-kernel+bounces-321083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D3188971439
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 11:47:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DC461F22064
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 09:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92C461B5ECE;
	Mon,  9 Sep 2024 09:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cmIeQ6Kg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C631B5EB0;
	Mon,  9 Sep 2024 09:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725875118; cv=none; b=RTuGP43aVFKrN6yRfdkI+r2GVIE6GbMKGv+w3kiam5UZYFQdHjdFNPJ8hZJLPU++5m+jjgdxwRI1xfdxI8uLsB6unfhjIUMBZ7cpCJCssY1HXnXHY9MCzNCjswFoO6oB2bexFDolPdx98wpTIH3szG6IGbOuldk996MeKUcV5GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725875118; c=relaxed/simple;
	bh=ZXXgZ+ZwjN2IMLT+Ho0SPTqL4Ic9sghs79AQIvchGgs=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=BBYn7yjOU1QPdIIit1ulJutYOnkrGBE5zgSwADylPd7+LvvDRM3x86rAtpfWQYFHmjv3Gg9bQEp4tAX6JKpP34fDySVfYwPA6J7xbb+SR7P9C2hYTtdzWBzTmG1jjnk3+/lG01f5JiRqLRW8NAUDp3m7P4lfIbix6rupDfm+5TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cmIeQ6Kg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9949C4CECF;
	Mon,  9 Sep 2024 09:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725875117;
	bh=ZXXgZ+ZwjN2IMLT+Ho0SPTqL4Ic9sghs79AQIvchGgs=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=cmIeQ6KgVCC9T9bknJTrLGj2hUaYoXSUhIG76J9QkfgQ4pS3i9lVkCC0zZb/vLd8U
	 2czX3nSWZzvlY72ST8lpqej3IXwJCgsB+dE6lnW4O6RAGbimqchkwHw1ShBpTbPUU3
	 I2r2aJT3H79GHAS7iw57P4jjdvLZy5Uh1Uxl6qiGUQszMhXP+FFRHbHOKSlfno3bSN
	 +SEYJJYwyiq5TS8yIwvwc9ysqG62CQ72EkS/oaG2t/W6UU6biV1wfsd3GO2BeHY99p
	 RLghdiiC/7ly+EV1J9Qsmxf5y7ggOLbUuSB5qV8P80aVt7zJu9oi4tXSqEMWWIX1Oh
	 egJ1VRiy1KugA==
Date: Mon, 09 Sep 2024 04:45:16 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Nikita Shubin <nikita.shubin@maquefel.me>
Cc: Conor Dooley <conor+dt@kernel.org>, Mark Brown <broonie@kernel.org>, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, devicetree@vger.kernel.org, 
 Liam Girdwood <lgirdwood@gmail.com>, 
 Alexander Sverdlin <alexander.sverdlin@gmail.com>, 
 Hartley Sweeten <hsweeten@visionengravers.com>, linux-sound@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20240909-ep93xx-v12-27-e86ab2423d4b@maquefel.me>
References: <20240909-ep93xx-v12-0-e86ab2423d4b@maquefel.me>
 <20240909-ep93xx-v12-27-e86ab2423d4b@maquefel.me>
Message-Id: <172587510719.3289382.4217883745550321297.robh@kernel.org>
Subject: Re: [PATCH v12 27/38] ASoC: dt-bindings: ep93xx: Document Audio
 Port support


On Mon, 09 Sep 2024 11:10:52 +0300, Nikita Shubin wrote:
> Document Audio Graph Port support in binding document.
> 
> Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/sound/cirrus,ep9301-i2s.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:


doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240909-ep93xx-v12-27-e86ab2423d4b@maquefel.me

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


