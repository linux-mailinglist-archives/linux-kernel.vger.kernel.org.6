Return-Path: <linux-kernel+bounces-378292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A80C9ACDB9
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 16:59:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 466D81F22089
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 14:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D83181FF7C6;
	Wed, 23 Oct 2024 14:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d0WLA0BG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 324F81CDFB9;
	Wed, 23 Oct 2024 14:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729694802; cv=none; b=Heev9FQ6piP51KjV4/EUhlQUtYZRagJhxOIPzu0yrtyYzxh995le6IIlZwVv42cXqfNvMQwU2Tr/VpjN9W06nHCAOhu77T9DGDier3HiCWPZuZ+3p6r34xDq47BVY1c6MIY0KVVQu1Nv79nuWdhNoGgsA69AJ2F347hhTv6pc/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729694802; c=relaxed/simple;
	bh=EL/3ucxGBsVCpCHRgw+6AeG2SCSvou58vtDN4x5Ord0=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=VQA7coHjPolUmo8qfZUgGOwmndNaq6xWfYwFBFUmrm9iUf7RM/Fj0E0nzBL4Q133u/FM4wQ/bmnGdJLW9qPejisAmZEw6pYJOfhs/D3zL4N8fyNeTLJ9WEXRgFqfVaarLhZy5FBlvBas6En8NSVAOIRHC4ZDabbTIApmEY5sofY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d0WLA0BG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93675C4CEC6;
	Wed, 23 Oct 2024 14:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729694801;
	bh=EL/3ucxGBsVCpCHRgw+6AeG2SCSvou58vtDN4x5Ord0=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=d0WLA0BGAbQPxtzol4nS3o9iEdMjuYeEzVqJUqhEmQhALFj3eiSH5k3HUEEH0E/pH
	 q13+k0Ct3bB/Qq/aXGCNrTrWuUaTtVZ+ywOTCoGkrPploouaL7dutYnq2wbiJRcZ3S
	 qNtMBZ9++Jh53d4t8mYwnzUxEeZejluMO/AtQXfoH+RxapgGPdb9/BwygkAX6UIvdl
	 zeOVakVMQKNTQwQvz6k8tomrGl2XmjwMhuAA0YZ6WIIjEG5WlcsrB0vUBzKEyq40FU
	 sOI+khxfkzH4CIrhmfDQwg75iMiCX28ZNfpxwo2pLlZKRUq/eIo4rOocke0UM1ReyJ
	 J4WCD1DLAeoFw==
Date: Wed, 23 Oct 2024 09:46:40 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Rouven Czerwinski <r.czerwinski@pengutronix.de>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 devicetree@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>, 
 Rob Herring <robh+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, Daniel Vetter <daniel@ffwll.ch>, 
 kernel@pengutronix.de, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, Sam Ravnborg <sam@ravnborg.org>, 
 David Airlie <airlied@gmail.com>, Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>
In-Reply-To: <20241023124411.1153552-2-r.czerwinski@pengutronix.de>
References: <20241023124411.1153552-1-r.czerwinski@pengutronix.de>
 <20241023124411.1153552-2-r.czerwinski@pengutronix.de>
Message-Id: <172969480074.910010.7226152766419071066.robh@kernel.org>
Subject: Re: [PATCH 2/3] dt-bindings: display: panel: add YAML schema for
 LXD M9189A


On Wed, 23 Oct 2024 14:44:09 +0200, Rouven Czerwinski wrote:
> The LXD M9189A is a 1024x600 MIPI-DSI panel.
> 
> Signed-off-by: Rouven Czerwinski <r.czerwinski@pengutronix.de>
> ---
>  .../bindings/display/panel/lxd,m9189a.yaml    | 64 +++++++++++++++++++
>  1 file changed, 64 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/lxd,m9189a.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Warning: Duplicate compatible "ronbo,rb070d30" found in schemas matching "$id":
	http://devicetree.org/schemas/display/panel/ronbo,rb070d30.yaml#
	http://devicetree.org/schemas/display/panel/lxd,m9189a.yaml#
Documentation/devicetree/bindings/display/panel/lxd,m9189a.example.dtb: /example-0/dsi/panel@0: failed to match any schema with compatible: ['lxd,m9189a']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20241023124411.1153552-2-r.czerwinski@pengutronix.de

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


