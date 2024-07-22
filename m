Return-Path: <linux-kernel+bounces-259302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EBA6B9393BA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 20:42:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4F20281CA4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 18:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3800172BB1;
	Mon, 22 Jul 2024 18:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bp0CrouD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FDD9172BD1;
	Mon, 22 Jul 2024 18:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721673706; cv=none; b=G0TkvAUDHSn5poWJRJjObLgepGr9vJYNHfZa6ddEQb1M4zpw/hmIXofuC55TOB4p0aQrEYG+DSEMUAPvAt92BZXwPMt5XV5iVfedx06EJ7Dws+9HHmHPfXirzop0UfajNrvBh7i0ZqOtQJJWqMpN2x2EwUedgCWulHY3nvyfvuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721673706; c=relaxed/simple;
	bh=itmwri9pB8iYLM1WV6O/hF7Nn5gJN5v0SqaL03cJnX0=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=Pgksbwf1EjIfMx7jbegBa8bEghHz5ZEWexgj0Ao+Rcbp2r+dl1iSOYN707QA9QwZYxyJZDlFDQyulEivCBYQ+OZpFVLk/1A9pqnKwF5xqOQG5npOO1FntM7BA4QDdGq67XTYxnObXFXl3nz8QbZ8b73iycIpocGD/ikDwkOV+P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bp0CrouD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3C12C4AF0D;
	Mon, 22 Jul 2024 18:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721673706;
	bh=itmwri9pB8iYLM1WV6O/hF7Nn5gJN5v0SqaL03cJnX0=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=Bp0CrouDEKWs4tFfjbFTAe3LbSDxnMSqUs2nnWDZ84CwqekBpISwzngrpl8zlotVM
	 F1R0BHHaYNV8eR0HQ9+zPCXJTK0cCdmWHulqFxv6sWem++wV+JzzFX+67oAOkcre3M
	 IouurdA8Wv6/lPOpblzDQKOCkx8auQEFVH0UjkORV0AXmK7MLWxAz7H/zcAl6XkuFt
	 sbRbN+hvW/D7pNtJ5KvnPeuzTygpAfdGK8d0y2SbqtDh9wMACxM470kGwAZcmjXv6m
	 tkr0rOXZctcJnmIuPHwNt5riXriJV6Wam6D+bmwSZw19SY2gXalrSFdmge6bLr3wFO
	 GbP7L41X2cUgg==
Date: Mon, 22 Jul 2024 12:41:42 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: ysionneau@kalrayinc.com
Cc: Julian Vetter <jvetter@kalrayinc.com>, devicetree@vger.kernel.org, 
 Conor Dooley <conor+dt@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Jonathan Borne <jborne@kalrayinc.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20240722094226.21602-11-ysionneau@kalrayinc.com>
References: <20240722094226.21602-1-ysionneau@kalrayinc.com>
 <20240722094226.21602-11-ysionneau@kalrayinc.com>
Message-Id: <172167367141.4771.1037260997382401873.robh@kernel.org>
Subject: Re: [RFC PATCH v3 10/37] dt-bindings: kalray: Add CPU bindings for
 Kalray kvx


On Mon, 22 Jul 2024 11:41:21 +0200, ysionneau@kalrayinc.com wrote:
> From: Yann Sionneau <ysionneau@kalrayinc.com>
> 
> Add Kalray kvx CPU bindings.
> 
> Signed-off-by: Yann Sionneau <ysionneau@kalrayinc.com>
> ---
> 
> Notes:
> 
> V2 -> V3: New patch
> ---
>  .../devicetree/bindings/kalray/cpus.yaml      | 105 ++++++++++++++++++
>  1 file changed, 105 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/kalray/cpus.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/kalray/cpus.example.dtb: cpu@0: compatible: ['kalray,kv3-1-pe'] is too short
	from schema $id: http://devicetree.org/schemas/kalray/cpus.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/kalray/cpus.example.dtb: cpu@1: compatible: ['kalray,kv3-1-pe'] is too short
	from schema $id: http://devicetree.org/schemas/kalray/cpus.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240722094226.21602-11-ysionneau@kalrayinc.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


