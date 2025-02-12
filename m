Return-Path: <linux-kernel+bounces-511357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D345A329E6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 16:26:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE03D165CD3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 15:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4CC4212F92;
	Wed, 12 Feb 2025 15:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iseFGePc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E0B21148C;
	Wed, 12 Feb 2025 15:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739373946; cv=none; b=C6cTX2p/9m8uxPYv/+TqUKYo1SzzhcgR6Ayf3Kl2iYjLxkRE4XAbslcEzfTFKgfBaAREuGMUpmOumzjUX44hEAxtv65aBHHLUsPYfOx8fGDZOwhR8mVKHbrGeDlFRNE9X+w5xoJ6FggoDLTEW+aDY6FIZyHBKqPoXpNkC2VkAlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739373946; c=relaxed/simple;
	bh=GtFDGbP9nNjWeYtJye1vewMcoENRKBgAVsqnzgxSgI0=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=A+tkM3qQ+41JopsxUDnRiXB6N0VjgpCT8y65JcC3nTwKciv7EfucOhzq/R2mHdO/Z5/g/eTDOTdMsMYuPJhzkz6HaRLdDauNQ3jNEl4aRHCEwl+25F0Q/pX3vIB5f5LKCcN9XDJbLjpNahaSEx/CIItT5+oMbdwbUGLBDYNpL/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iseFGePc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D831C4CEDF;
	Wed, 12 Feb 2025 15:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739373945;
	bh=GtFDGbP9nNjWeYtJye1vewMcoENRKBgAVsqnzgxSgI0=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=iseFGePcPYC/R6Y61oF51a8Eq7LoH0srFdcyV33nu3JJam3BFkhVV22B3vM3kNvtk
	 Zzj9PBz8tR1DWLNdFuKZmymt4ucCtHu2JGlYM0ZLGtugDtTpIz1GBm0y0+VV9+pu2i
	 fKvVMqQpAWCL51xLfc0Ls7v1NY9rsK15n4b8kOfeZwGCBBXjjhqc0Xw19GLKZFUrp7
	 PBOOTimy65S1sjaj4VVoR8xVKuxfYpX2vPTHrXRkNufaOV8g+QHX966+i8ofXQ2ad2
	 dZvfNftc3PF0pBSPb4j36vUE6e9o+qTdqTeQX8jJ/yg1o9h6EjBMhBmdVebpUA3Hh6
	 kYjDPw7i+1v0Q==
Date: Wed, 12 Feb 2025 09:25:44 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: shashank.rebbapragada@nxp.com, Frank.Li@nxp.com, krzk+dt@kernel.org, 
 conor+dt@kernel.org, priyanka.jain@nxp.com, vikash.bansal@nxp.com, 
 alexandre.belloni@bootlin.com, linux-i3c@lists.infradead.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
To: Aman Kumar Pandey <aman.kumarpandey@nxp.com>
In-Reply-To: <20250212132227.1348374-1-aman.kumarpandey@nxp.com>
References: <20250212132227.1348374-1-aman.kumarpandey@nxp.com>
Message-Id: <173937394410.3824870.14744594873271734768.robh@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: i3c: Add NXP P3H2x4x i3c-hub support


On Wed, 12 Feb 2025 15:22:26 +0200, Aman Kumar Pandey wrote:
> P3H2x4x (P3H2440/P3H2441/P3H2840/P3H2841) is multiport I3C hub
> device which connects to a host CPU via I3C/I2C/SMBus bus on one
> side and to multiple peripheral devices on the other side.
> 
> Signed-off-by: Aman Kumar Pandey <aman.kumarpandey@nxp.com>
> Signed-off-by: Vikash Bansal <vikash.bansal@nxp.com>
> ---
>  .../bindings/i3c/p3h2x4x_i3c_hub.yaml         | 404 ++++++++++++++++++
>  MAINTAINERS                                   |   7 +
>  2 files changed, 411 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/i3c/p3h2x4x_i3c_hub.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:
./Documentation/devicetree/bindings/i3c/p3h2x4x_i3c_hub.yaml:6:1: [error] syntax error: expected '<document start>', but found '<block mapping start>' (syntax)
./Documentation/devicetree/bindings/i3c/p3h2x4x_i3c_hub.yaml:251:111: [warning] line too long (118 > 110 characters) (line-length)
./Documentation/devicetree/bindings/i3c/p3h2x4x_i3c_hub.yaml:260:111: [warning] line too long (111 > 110 characters) (line-length)

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/i3c/p3h2x4x_i3c_hub.yaml: ignoring, error parsing file
./Documentation/devicetree/bindings/i3c/p3h2x4x_i3c_hub.yaml:6:1: expected '<document start>', but found ('<block mapping start>',)
make[2]: *** Deleting file 'Documentation/devicetree/bindings/i3c/p3h2x4x_i3c_hub.example.dts'
Documentation/devicetree/bindings/i3c/p3h2x4x_i3c_hub.yaml:6:1: expected '<document start>', but found ('<block mapping start>',)
make[2]: *** [Documentation/devicetree/bindings/Makefile:26: Documentation/devicetree/bindings/i3c/p3h2x4x_i3c_hub.example.dts] Error 1
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1511: dt_binding_check] Error 2
make: *** [Makefile:251: __sub-make] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250212132227.1348374-1-aman.kumarpandey@nxp.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


