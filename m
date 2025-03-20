Return-Path: <linux-kernel+bounces-569316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31662A6A165
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 09:30:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31F6346569C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 08:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC5022139C9;
	Thu, 20 Mar 2025 08:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VeMxxPiP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4549C1EE02A;
	Thu, 20 Mar 2025 08:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742459349; cv=none; b=TTRWwXXYZ377l1RoMkgvxB+lmuJBOcD4mSsTioSY2QtSeBRLN9d1jbDzv2EEG/WG7vrp5O2c0pc97W0EePLejImdoW5pgJx7OGKdVp615IUn2LAGMbB0r1/AIost2iWrOjWlpAB5RV/eMV6CjHwLGi87NWNYORIXQJLVXg/Lxmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742459349; c=relaxed/simple;
	bh=iUMIeGOZu+7EerCs1U1bu4NXPnO61FtmA6GHbfUFCLA=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=p+XzBfF8mB4mYY0ckX04xOPupiC+HCwwU/Eg/oTQu0jHHvVbo0CWtGNXXsDqdoQ4FjTsRp73nGiIJaxoxT2tPYruFr2S0kSr8QIMp2HJm+sAlJoepEKpQMDl0u2u6ESS7RaJq6NWedHYnFE3lG8aJWk28ZdY8Tdu3xBfrM1Xt0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VeMxxPiP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 846F2C4CEE7;
	Thu, 20 Mar 2025 08:29:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742459348;
	bh=iUMIeGOZu+7EerCs1U1bu4NXPnO61FtmA6GHbfUFCLA=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=VeMxxPiPLGnkTQ/qvkP9k6tfkbG6SWe7hd5HuuXFaS8UcdO8hy+OZxrfOgmoy87gv
	 gLh4TBUeH4rtKZqNEXwsVSCz6UqHRRpCc08YMNyMSfgpHTv9N7tmca/iErpp7pwd06
	 wlItCW8RlgZVI04+DlFdxcqhhygdZZx4Xf4N9IgMjXD6nOb6ORV8N/IAa29wFALunb
	 sXNL1XW+GHugsuUkUlwsEQ7M2KCnF0imPIz0ubGlXuwPQeBKRc1wKYgq5jW/Mq37Ae
	 HTD8wwqN9aU8A9LHBePLWl4VXp2xNL3SErskWwGnk2sbaGnH0ilvSpjQhtR5eop7bp
	 BNWsRHChuJ1rg==
Date: Thu, 20 Mar 2025 03:29:07 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Alexis Czezar Torreno <alexisczezar.torreno@analog.com>
In-Reply-To: <20250320-upstream-adp5055-v2-1-aac2d3705802@analog.com>
References: <20250320-upstream-adp5055-v2-0-aac2d3705802@analog.com>
 <20250320-upstream-adp5055-v2-1-aac2d3705802@analog.com>
Message-Id: <174245934743.3732121.176471277866008029.robh@kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: regulator: add
 adi,adp5055-regulator


On Thu, 20 Mar 2025 14:53:54 +0800, Alexis Czezar Torreno wrote:
> Add documentation for devicetree bindings for ADP5055. The device consists
> of 3 buck regulators able to connect to high input voltages of up to 18V
> with no preregulators.
> 
> Signed-off-by: Alexis Czezar Torreno <alexisczezar.torreno@analog.com>
> ---
>  .../bindings/regulator/adi,adp5055-regulator.yaml  | 161 +++++++++++++++++++++
>  MAINTAINERS                                        |   6 +
>  2 files changed, 167 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/regulator/adi,adp5055-regulator.example.dtb: regulator@70: Unevaluated properties are not allowed ('DCDC0', 'DCDC1', 'DCDC2' were unexpected)
	from schema $id: http://devicetree.org/schemas/regulator/adi,adp5055-regulator.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250320-upstream-adp5055-v2-1-aac2d3705802@analog.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


