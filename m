Return-Path: <linux-kernel+bounces-181588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D79608C7DFE
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 23:22:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C221B216A1
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 21:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 297D4158216;
	Thu, 16 May 2024 21:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IwhABSmB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61036147C74;
	Thu, 16 May 2024 21:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715894544; cv=none; b=rMWrWfG3mhDsQTLSVeM+z6WrhoFHcVgNRENykkBJ2a+IqwsZmF2ga/K/raPcd3v4/Uj1M9HcshRJs2GKSKtgClNwUhCGq9r2T6Lv2FcYWEzC0Dg2mxTIwIUSmOWZxoRqUp2CQzBCZi20PHVuuk/r5UHwRUtYPDpsnYRsMuP3+Hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715894544; c=relaxed/simple;
	bh=njkEiF47OWQoz7V5vsTESOJQgzxBy6wBpdve4AkIAJc=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=g99VjBSrkfP6na8pfr8zDQYsRegxI7sBEIYmwjL74cBGW2bhwcZ8oGDvtqR1Mmd6gJt2Fm3ry/AgISUFimQhQVxVHTvzmOnzzHaN7zBVIykBuNidKrYJJGWTRzubTAqerTjuFUKBDCoarA0dsWLOE1iO4UuA+jmuoPZ6sADxpvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IwhABSmB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBE73C113CC;
	Thu, 16 May 2024 21:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715894544;
	bh=njkEiF47OWQoz7V5vsTESOJQgzxBy6wBpdve4AkIAJc=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=IwhABSmBMb9UUIQF+DXzKdWHciPoUGyQ6FH4lzdjZmUdLpAEs30ibhIoFSDpWsPVM
	 dn1n0auO16ImMAlDBBi2kEcmUtysPWBIKHYdELZ04PTeY6LYGNtbBVpki4iFDfIgLO
	 VdNxl3oui86ObGJ6T24HYmMjVG6NnotHUz28ObfAdNkC6+Nkz6m/50Hod66IVBDycF
	 m82tULq1Ns0djB6vzzUSvnLJorA6pwuH3iEbVR1UZdlBW67v9W6RukG7QfNnd241gJ
	 1nVGcIeGLzeCuGmo4NHpz0qZj4Y9E0oK2L7AoPkItE55DYG0Au0Exccl3vkCqZzS9P
	 IcjKEvMGJ20Fw==
Date: Thu, 16 May 2024 16:22:22 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
Cc: Conor Dooley <conor+dt@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>, 
 laurentiu.mihalcea@nxp.com, Lee Jones <lee@kernel.org>, 
 Liu Ying <victor.liu@nxp.com>, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, Sascha Hauer <s.hauer@pengutronix.de>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
In-Reply-To: <20240516204031.171920-2-laurentiumihalcea111@gmail.com>
References: <20240516204031.171920-1-laurentiumihalcea111@gmail.com>
 <20240516204031.171920-2-laurentiumihalcea111@gmail.com>
Message-Id: <171589454168.3876864.16223834694936429980.robh@kernel.org>
Subject: Re: [PATCH 1/4] dt-bindings: reset: add schema for imx8ulp SIM
 reset


On Thu, 16 May 2024 23:40:28 +0300, Laurentiu Mihalcea wrote:
> From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
> 
> Add schema for imx8ulp's SIM reset controller.
> 
> Signed-off-by: Liu Ying <victor.liu@nxp.com>
> Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
> ---
>  .../bindings/reset/nxp,imx8ulp-sim-reset.yaml | 43 +++++++++++++++++++
>  1 file changed, 43 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/reset/nxp,imx8ulp-sim-reset.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/reset/nxp,imx8ulp-sim-reset.example.dtb: /example-0/syscon@2da50000: failed to match any schema with compatible: ['nxp,imx8ulp-avd-sim', 'syscon']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240516204031.171920-2-laurentiumihalcea111@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


