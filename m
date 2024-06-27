Return-Path: <linux-kernel+bounces-233043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E98E191B178
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 23:21:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A34802830F8
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 21:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C488C1A0AEB;
	Thu, 27 Jun 2024 21:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qYpgZwwA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0140819A2A3;
	Thu, 27 Jun 2024 21:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719523292; cv=none; b=NCW6dbXpgv85hWG8iWa52qFyKRcXSWxx2OXFpXe82Ov5ULzAi5Tttgpfvo6eBIqV2NGaXdS7//gBjPQkUcAH406MH5hSF5UNFn1lXTO43O89ZszLb2/DMHYt3UoTOYD54Z91ehs/wvsGBHjvjlwZRprLFaA/oazAwDa/LDYCSO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719523292; c=relaxed/simple;
	bh=vjCxW+3sLYIPoraSwWhaL02w9qFE3SaiJZk225TJQ8U=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=oYUAuyyk//f5HKx2pEMu/cMf+RpkrJNklJ2oOZm1GhXcIvU7Vt/N+WzvwtcTaBA21E0+lCxalrnZPIHL7RhB7wsHhEOQV6QfWPJsTd+Zi9JokwKAihVJFCwoXI6UomTNcHq6xA8+z3bSZJ5xydYupzpdFDzJz3AHhIZqi3kAFx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qYpgZwwA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41F48C2BBFC;
	Thu, 27 Jun 2024 21:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719523291;
	bh=vjCxW+3sLYIPoraSwWhaL02w9qFE3SaiJZk225TJQ8U=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=qYpgZwwAbHvgIxiUnxDm16AFiLLRPt03v2ys+GoM+vL6y23TqRk1WOS6x/dxupzlr
	 iLLj1cAG1uorjFA+Qmq5l28OkS/+03bTO0WMG70FjZn2NnPqK+3gsEYq30fURbQ4eb
	 dlfwoZGQmjeE80xelFaHCZheY8sM+YcpjhPOYDer9n9R+Ek1I5+QPwmiSokGNLhGU+
	 wW3pdr4brHjx+U061QQOdCy254rALJthqfF9ljFUxnc5UV95nCxVIBImBGFXpUnuAA
	 ypuOiBf+npYs+ON8wJ3ml8qEMAwTTSxCV5zKX8EYm/YoMbB1XgHj9AhybV3+lhXdw7
	 0Q52Mgzjn3bwQ==
Date: Thu, 27 Jun 2024 15:21:29 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Tomer Maimon <tmaimon77@gmail.com>
Cc: robh+dt@kernel.org, venture@google.com, linus.walleij@linaro.org, 
 linux-kernel@vger.kernel.org, yuenn@google.com, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org, 
 tali.perry1@gmail.com, benjaminfair@google.com, joel@jms.id.au, 
 openbmc@lists.ozlabs.org
In-Reply-To: <20240627182312.86382-1-tmaimon77@gmail.com>
References: <20240627182312.86382-1-tmaimon77@gmail.com>
Message-Id: <171952328964.589118.6080040699735912834.robh@kernel.org>
Subject: Re: [PATCH v1] dt-bindings: pinctrl: npcm8xx: add missing pin
 group and mux function


On Thu, 27 Jun 2024 21:23:12 +0300, Tomer Maimon wrote:
> Add the following missing pin group and mux function:
> smb6b, smb6c, smb6d, smb7b, smb7c, smb7d, bu4, bu4b, bu5, bu5b, bu6,
> gpo187.
> 
> Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
> ---
>  .../pinctrl/nuvoton,npcm845-pinctrl.yaml      | 22 ++++++++++---------
>  1 file changed, 12 insertions(+), 10 deletions(-)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:
./Documentation/devicetree/bindings/pinctrl/nuvoton,npcm845-pinctrl.yaml:90:1: [error] syntax error: found character '\t' that cannot start any token (syntax)

dtschema/dtc warnings/errors:

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240627182312.86382-1-tmaimon77@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


