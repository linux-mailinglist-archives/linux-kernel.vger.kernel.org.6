Return-Path: <linux-kernel+bounces-173736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFDEC8C04B3
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 21:00:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F01301C2290B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 19:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC50812EBED;
	Wed,  8 May 2024 19:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XckR9UnS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBFDE12DDA1;
	Wed,  8 May 2024 19:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715194848; cv=none; b=UvzDv8YCmkVGtGWbWRy7RfWNZlfRHfUVqobW7Yt9XKE2WFzs/gnNftTd7Hsz9RKs3LLuMnbRhI+/zJM+viQU04s+su9aGU1FJoibvvKSbdjH6JEdxd2yW/NV+6pq9BGI8YFEGDncJ46SqK430j4KjlDJFIJt6j/kiwjZK7uiIdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715194848; c=relaxed/simple;
	bh=THUpirS2DYDNx1Syq3v5LR9C0SjXYALQn8Wm0luUztM=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=GjOZQ+lX1fg7m/W9uIgqWWnpgmvKeZEpDeCcU5eLTbflUDevgvxGzUkcWjGQQPamoM5TPT3mJHAt/12QeSfJv7jsbMOIH4sDFdI5Aa/oF/bzhCxA6Ei05LhyhwV48PqE+i+6/CglatMgQj/H6Tr1+YjEcRPwsuqPmoaZpcDjsSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XckR9UnS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61AD6C113CC;
	Wed,  8 May 2024 19:00:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715194847;
	bh=THUpirS2DYDNx1Syq3v5LR9C0SjXYALQn8Wm0luUztM=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=XckR9UnS7pBnMYhcByCFR2JM3VbJnj2bDkXIjOCUhl7bsSwtVI5L7cq9NzfdURzDh
	 MQMFlHAclGGqwGNdDlQIUOAPM1xsGokcM41tJuie4pih91Ep8RoYShURywDjyxnX5x
	 FVNULg+cbSgVr0iJ86/RDqR4P87BgXVhE4bJADj+cxc0yp2V+L4XgLy8b1r0zE5o6H
	 2TWUvTxQlwO6XrVCcj8tKXfbOzPveolmkbVqUY912jAnrSARznmr0WtCqYfZGHYcbX
	 qqlC9+oZFn8L8uWVKWi4DdijmWMEd2fMXfSxlXTuduHwYrq9c16cIG/40RK7UHkwZK
	 N1xG+P0fKz4ww==
Date: Wed, 08 May 2024 14:00:45 -0500
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc: jdelvare@suse.com, linux-hwmon@vger.kernel.org, linux@roeck-us.net, 
 linux-kernel@vger.kernel.org, conor+dt@kernel.org, krzk+dt@kernel.org, 
 devicetree@vger.kernel.org
In-Reply-To: <20240508170544.263059-2-chris.packham@alliedtelesis.co.nz>
References: <20240508170544.263059-1-chris.packham@alliedtelesis.co.nz>
 <20240508170544.263059-2-chris.packham@alliedtelesis.co.nz>
Message-Id: <171519484579.2414809.16063275628400924542.robh@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: hwmon: Document adt7475 PWM initial
 duty cycle


On Thu, 09 May 2024 05:05:42 +1200, Chris Packham wrote:
> Add documentation for the pwm-initial-duty-cycle and
> pwm-initial-frequency properties. These allow the starting state of the
> PWM outputs to be set to cater for hardware designs where undesirable
> amounts of noise is created by the default hardware state.
> 
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> ---
>  .../devicetree/bindings/hwmon/adt7475.yaml    | 26 ++++++++++++++++++-
>  1 file changed, 25 insertions(+), 1 deletion(-)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/hwmon/adt7475.example.dtb: hwmon@2e: adi,pwm-initial-frequency:0:1: 0 is not one of [11, 14, 22, 29, 35, 44, 58, 88, 22500]
	from schema $id: http://devicetree.org/schemas/hwmon/adt7475.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240508170544.263059-2-chris.packham@alliedtelesis.co.nz

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


