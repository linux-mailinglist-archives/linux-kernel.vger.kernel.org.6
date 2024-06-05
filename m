Return-Path: <linux-kernel+bounces-203378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F08858FDA1C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 00:58:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E4A01F24A11
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 22:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28C591607B6;
	Wed,  5 Jun 2024 22:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YPOWm3OX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F7B29AF;
	Wed,  5 Jun 2024 22:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717628302; cv=none; b=B7lJ1P8Qt7eZBbY9C6+xODPJ3+M31R+gxW6V28LNR63XXbXi3gv5UPY7VNDPK2JKGShzAsjWVAiyWuXIvvNElEm9k56r/YIW6CivKAZwUmLUUOO5ZC6pAW0PperRT4W+rSDK04OcYBnlZ1LkXOqR2UW5wDyVMQsOuTNhHDws5e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717628302; c=relaxed/simple;
	bh=Hs1MEQpf1rk+mSspqcsPE/1Nm1zqDlSxEmhtqQI11BE=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=tO3s3Qnjt95f7jFmidAWCdAFhBiul9vWqygg1Y8jDTsILt+/wxuNQOJ/9kriDPlY/p8t1s5ihVSMgBwEmV2aLIuqjJ1b/B7sSUkYbuaX86NqleIWN7ZUWmrTrjNEasSauiqrM026pVPi5FxFP35eWl/ALuNGZcU+yXfsWx7BFHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YPOWm3OX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9947CC2BD11;
	Wed,  5 Jun 2024 22:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717628301;
	bh=Hs1MEQpf1rk+mSspqcsPE/1Nm1zqDlSxEmhtqQI11BE=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=YPOWm3OXAg5ZX0BI3fLJuv4yQGyd5UFwAUqQJIbHHuDNdrUd7kyGPAaJ+FTv7lkIf
	 TIOANYcJb7vDNPT9Azd2ipT7yE+ZMRDj2N6t/MEVntuqazBBLpO+9z9+CfSAdI83jw
	 bQJTlkZPZrJsUXlv/q6NrAlqW/BZCMXC7Q+Tw9svJ+1a1yXOMiEtfuFKyen/9D1/u0
	 T6lSt542IipP9ILYYFRtqA8sBNYXEacLzQweUIzPwfegoZhqlnZtu21gPRYhh9pcq8
	 NYpcNSr1BGaCXULfIeqECITa1kePKuHHPTOUs3MHHtvvd1fQglL88qcHIpnoU2WQxN
	 0Ibls33o7gHgA==
Date: Wed, 05 Jun 2024 16:58:19 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, 
 Conor Dooley <conor+dt@kernel.org>, Mark Brown <broonie@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-sound@vger.kernel.org, 
 devicetree@vger.kernel.org
In-Reply-To: <20240605-topic-amlogic-upstream-bindings-convert-spdif-receiver-v1-1-262465adbac2@linaro.org>
References: <20240605-topic-amlogic-upstream-bindings-convert-spdif-receiver-v1-1-262465adbac2@linaro.org>
Message-Id: <171762829930.3284644.11774334058249262191.robh@kernel.org>
Subject: Re: [PATCH] ASoC: dt-binding: convert spdif-receiver.txt to
 dt-schema


On Wed, 05 Jun 2024 18:20:50 +0200, Neil Armstrong wrote:
> Convert text bindings to dt-schema format for the Dummy SPDIF receiver
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  .../devicetree/bindings/sound/linux,spdif-dir.yaml | 37 ++++++++++++++++++++++
>  .../devicetree/bindings/sound/spdif-receiver.txt   | 10 ------
>  2 files changed, 37 insertions(+), 10 deletions(-)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/sound/linux,spdif-dir.yaml: 'addirionalProperties' is not one of ['$id', '$schema', 'title', 'description', 'examples', 'required', 'allOf', 'anyOf', 'oneOf', 'definitions', '$defs', 'additionalProperties', 'dependencies', 'dependentRequired', 'dependentSchemas', 'patternProperties', 'properties', 'not', 'if', 'then', 'else', 'unevaluatedProperties', 'deprecated', 'maintainers', 'select', '$ref']
	from schema $id: http://devicetree.org/meta-schemas/base.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/sound/linux,spdif-dir.yaml: 'oneOf' conditional failed, one must be fixed:
	'unevaluatedProperties' is a required property
	'additionalProperties' is a required property
	hint: Either unevaluatedProperties or additionalProperties must be present
	from schema $id: http://devicetree.org/meta-schemas/core.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240605-topic-amlogic-upstream-bindings-convert-spdif-receiver-v1-1-262465adbac2@linaro.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


