Return-Path: <linux-kernel+bounces-568067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21145A68DB8
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 14:24:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93A267A2D76
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 13:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55059256C6E;
	Wed, 19 Mar 2025 13:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p/PLqva+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD90A1F4E37;
	Wed, 19 Mar 2025 13:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742390682; cv=none; b=CTQYuZxy9ShX/DODb9d6CvkWx2uN+Whs80h10e4SDF53mnaqn7BqNLTAzXXKnt3OqtIVd9wTnT6l17m2Hh1rH5EErV2il1zly9vnmDvIvG/AtXoeD6I2Bhn2tVrEEYCxjhDjzm1xNT3+R4S5IpISapiImDfJUwLrGD6M12eQ1fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742390682; c=relaxed/simple;
	bh=m7xjR6a+d4xg+jOdfMkVOMo+gvPvraPCBaz/1w2FBMo=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=i0pKRoCCOqXTC2Pz4sCdrxgCac2riS48mmYsRYQ122w8zg6oweGungBqd9Ldm7Ajc/IoDAjqUyKMHckZ0/I1/e3E6FxeiT5pTWzfg4cWAh34Vnvge2A3V0zk2ok2h3RqV0CEja8bkk8phvhldRRph86ZoeLO+N97Lgb9AGCjmX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p/PLqva+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E042C4CEEA;
	Wed, 19 Mar 2025 13:24:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742390680;
	bh=m7xjR6a+d4xg+jOdfMkVOMo+gvPvraPCBaz/1w2FBMo=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=p/PLqva+tn4/EQ8Axv8lj8F23g7eZ/7KBBMFN9F66Baa9eaRV7dDK+S5xqQ/FJ/ZE
	 DVmH97L5BRzxg+JT9D0jVZEe6ZOyS8j7iXn4RWD915V6DZ02IbXLdbFSzJfEv5qUor
	 he3h9c01t6P5v8qcKWpfzYNE2xeDp8Km2gxAAVW9QYMH2OG9eBfvjJClmirPlzBNvd
	 orLRQMm6MG3wA8IjBNGwYPbNzNpZL3M4B//xDw5jr5i+iLv59vRgaRSwv+ky9lutcs
	 fh9GzRnIlFQBjuoZ7kWl3yHHWyGshuJi4nOu7RS86msXlzfBTspNHyMnM1sW+CIPAk
	 zXYOubuOfOq9A==
Date: Wed, 19 Mar 2025 08:24:39 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Colin Foster <colin.foster@in-advantage.com>, 
 devicetree@vger.kernel.org, Felix Blix Everberg <felix.blix@prevas.dk>, 
 Lee Jones <lee@kernel.org>, linux-kernel@vger.kernel.org
To: Rasmus Villemoes <ravi@prevas.dk>
In-Reply-To: <20250319123058.452202-9-ravi@prevas.dk>
References: <20250319123058.452202-1-ravi@prevas.dk>
 <20250319123058.452202-9-ravi@prevas.dk>
Message-Id: <174239067901.1581865.12024894776786719202.robh@kernel.org>
Subject: Re: [PATCH 8/8] dt-bindings: mfd: ocelot: mention MDIO management
 and add example


On Wed, 19 Mar 2025 13:30:58 +0100, Rasmus Villemoes wrote:
> The ocelot switches can also be strapped so that they can be
> controlled via an MDIO bus (on either address 0 or 31). Mention that
> and add an example.
> 
> Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
> ---
>  .../devicetree/bindings/mfd/mscc,ocelot.yaml  | 121 +++++++++++++++++-
>  1 file changed, 119 insertions(+), 2 deletions(-)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mfd/mscc,ocelot.example.dtb: soc@0: ethernet-switch@71010000:ethernet-ports:port@a: 'phy-mode' is a required property
	from schema $id: http://devicetree.org/schemas/mfd/mscc,ocelot.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mfd/mscc,ocelot.example.dtb: soc@0: ethernet-switch@71010000:ethernet-ports:port@a: Unevaluated properties are not allowed ('phys' was unexpected)
	from schema $id: http://devicetree.org/schemas/mfd/mscc,ocelot.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mfd/mscc,ocelot.example.dtb: soc@0: ethernet-switch@71010000: Unevaluated properties are not allowed ('ethernet-ports' was unexpected)
	from schema $id: http://devicetree.org/schemas/mfd/mscc,ocelot.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mfd/mscc,ocelot.example.dtb: soc@0: ethernet-switch@71010000: Unevaluated properties are not allowed ('ethernet-ports' was unexpected)
	from schema $id: http://devicetree.org/schemas/mfd/mscc,ocelot.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mfd/mscc,ocelot.example.dtb: soc@0: 'serdes@710d0000' does not match any of the regexes: '^ethernet-switch@[0-9a-f]+$', '^gpio@[0-9a-f]+$', '^mdio@[0-9a-f]+$', '^pinctrl@[0-9a-f]+$', 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/mfd/mscc,ocelot.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mfd/mscc,ocelot.example.dtb: serdes@710d0000: 'reg' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/phy/mscc,vsc7514-serdes.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mfd/mscc,ocelot.example.dtb: ethernet-switch@71010000: ethernet-ports:port@a: 'phy-mode' is a required property
	from schema $id: http://devicetree.org/schemas/net/mscc,vsc7514-switch.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mfd/mscc,ocelot.example.dtb: ethernet-switch@71010000: ethernet-ports:port@a: Unevaluated properties are not allowed ('phys' was unexpected)
	from schema $id: http://devicetree.org/schemas/net/mscc,vsc7514-switch.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mfd/mscc,ocelot.example.dtb: ethernet-switch@71010000: Unevaluated properties are not allowed ('ethernet-ports' was unexpected)
	from schema $id: http://devicetree.org/schemas/net/mscc,vsc7514-switch.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250319123058.452202-9-ravi@prevas.dk

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


