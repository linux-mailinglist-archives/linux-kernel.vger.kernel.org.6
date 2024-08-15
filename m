Return-Path: <linux-kernel+bounces-288620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 838F7953C86
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 23:20:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03330B20CB1
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 21:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 022BC14F13E;
	Thu, 15 Aug 2024 21:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s7x5KGay"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3C078C9C;
	Thu, 15 Aug 2024 21:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723756842; cv=none; b=JFLh9M1zUtewYSLt+78wmlxd5vzQTirLEaHTBIPkFNbQR4IzEm5wj8oVWyutNbkzrPJdmwcYDETheSC4PPxRu4rQ3IeR7KJoMzflQJrZkxl4Bwwusdh9cLuiS2wRfimMMnkEm4TwJeNE61oy1m/NRnsoHQUzDx4gG8Uo/bREtRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723756842; c=relaxed/simple;
	bh=Vy7cKa47Wg/jS0t0tdtyRvzFajGY1CewpFgGa15/um0=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=IPLu37oGae0SKjQWciauwkE7+XUo3cd/QmPnYgHPG65NiCAuMfFBHbedSOPyaF7y8v6WnEK1VyfWuqTkxnR6SMrxEFgLyKS7DZz8mvScatykTnrmMz6x0CJqcufEwu2rlzgrkuAFY2sVVZaauH1gQ1NnUVIk6Mip+XZdFGLh/Ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s7x5KGay; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6EE9C32786;
	Thu, 15 Aug 2024 21:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723756841;
	bh=Vy7cKa47Wg/jS0t0tdtyRvzFajGY1CewpFgGa15/um0=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=s7x5KGayWEX6CoYrPwAAPcJK1gvR3zpO6JWbmcljU9KdH8tDfOXOdeKSPf/nkntFh
	 ykt5FspK+dVqxbJEs34O1mJeZqFmdm5ZNpCvO1w8LnbIPaCR+mN9pJ37lqtLM7AS5A
	 NzZSWWjdaynUNrumTg5BZf8KJnnUWw9IoUhezeX4x2S/z+D3CmDJUb/ft4r3wpiIBc
	 MOTq1zeZuNMkLIi/26rfnBONFIn7JiAODw5s7V4SOUZgBnf8R2Odjdac6U109TThxT
	 kdH1ZdKXh3dyF8w/MhsAmFG95H4IcE/QHTupKUqDFY04Ts/yfhhYQVtordoTq3y1xb
	 a7hK493UZcFyg==
Date: Thu, 15 Aug 2024 15:20:40 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Chanwoo Choi <cw00.choi@samsung.com>, 
 MyungJoo Ham <myungjoo.ham@samsung.com>, devicetree@vger.kernel.org, 
 imx@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20240815203244.96963-1-Frank.Li@nxp.com>
References: <20240815203244.96963-1-Frank.Li@nxp.com>
Message-Id: <172375684086.3112792.4682184578952851158.robh@kernel.org>
Subject: Re: [PATCH v2 1/1] dt-bindings: extcon: ptn5150: add child node
 port


On Thu, 15 Aug 2024 16:32:44 -0400, Frank Li wrote:
> Add child node 'port' to allow connect to usb controller to do role-switch.
> Add example for id pin of ptn5150 have not connect to main chip's usb id
> pin.
> 
> Fix below warning:
> arch/arm64/boot/dts/freescale/imx8mn-var-som-symphony.dtb: typec@3d: 'port' does not match any of the regexes: 'pinctrl-[0-9]+'
>         from schema $id: http://devicetree.org/schemas/extcon/extcon-ptn5150.yaml
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> Change from v1 to v2
> - add example for id pin have not connect to main chip's id example.
> - commit 095b96b2b fix "port" warning, but add new warning "connector" is
> not exist. And follow commit revert this change.
> 690085d866f08 Revert "arm64: dts: imx8mn-var-som-symphony: Describe the USB-C connector
> - I have not board in hand to debug why "connector" is not work.
> ---
>  .../bindings/extcon/extcon-ptn5150.yaml       | 46 +++++++++++++++++++
>  1 file changed, 46 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/extcon/extcon-ptn5150.example.dtb: usb@32e40000: interrupts: [[4294967295, 0], [40, 4]] is too long
	from schema $id: http://devicetree.org/schemas/usb/chipidea,usb2-imx.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240815203244.96963-1-Frank.Li@nxp.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


