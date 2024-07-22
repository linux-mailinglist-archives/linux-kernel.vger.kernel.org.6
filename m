Return-Path: <linux-kernel+bounces-259296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 175689393AD
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 20:41:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4B0E281203
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 18:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 025C4170835;
	Mon, 22 Jul 2024 18:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gZA8f5d0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C51F17085A;
	Mon, 22 Jul 2024 18:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721673690; cv=none; b=QXa22gOqsgaw6S9/mOr1/dWvMYr605LFh2DYQerpY9xTUABPKKde1Cb7qunF6qBgEKQNIc/02kIHogVLDwT3PQkdzzrCGJaLK1Wc9UYBpR3n4DdVosSFftdS1AvOBP3rsHmcWVvqW05XiMDa46qvg8Jsa99wq+HQWoLMaodVy3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721673690; c=relaxed/simple;
	bh=n0Z8R3uKO5VM09Tet96/NToZQmnekfd2qTvrCch6d5M=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=lfqmiWyCHoztrVvwV3a44Q6ZwLR7FTdPqKJWS5U3H5DyMj1eeWC3OVLXsuWSIebwdlSTnaqWj1PO9LpzO+m5Dr9D0sVxQ8iEMlxme0vpzjRAvpYLOCo+89KnjD/iqpnEPWInMAPxrS/NDYROi41PRdcsJWQlHpkX5tdwsj30dos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gZA8f5d0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 263B8C116B1;
	Mon, 22 Jul 2024 18:41:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721673689;
	bh=n0Z8R3uKO5VM09Tet96/NToZQmnekfd2qTvrCch6d5M=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=gZA8f5d0NZjfcZIybUks1ox3JKt4qejk2+/FSDezRc50RNx6ugr97gkiFcZfqcHsH
	 7NG7k492PR+T0CqKl206OCSbW9OKn6+Hpxo9K/LANYthUzg4g/sU82kWO3u7p0F9zD
	 exTyTaGhNJuSJuxEwC/pQ1tAhe51Wj5AnedX/VyDEIESpv+Dv3vU1c80czZmtVytv7
	 AjlBv/8BG3jRqEEG3l9kgH/5p/OaLoPvsq4jR1000vjGzAlgDTKc4dvbm/7UhK9w4j
	 2BnWx9bl0QJm865eQ/dmQXyXRwub2+iUMMfmiIJslTpRNsO3aQQ/uYKw3SgNc4e2VJ
	 H1vfQDqYy7XMw==
Date: Mon, 22 Jul 2024 12:41:25 -0600
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
Cc: Jules Maselbas <jmaselbas@zdiv.net>, 
 Julian Vetter <jvetter@kalrayinc.com>, Conor Dooley <conor+dt@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Jonathan Borne <jborne@kalrayinc.com>, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
In-Reply-To: <20240722094226.21602-6-ysionneau@kalrayinc.com>
References: <20240722094226.21602-1-ysionneau@kalrayinc.com>
 <20240722094226.21602-6-ysionneau@kalrayinc.com>
Message-Id: <172167364473.4307.1608368643775029629.robh@kernel.org>
Subject: Re: [RFC PATCH v3 05/37] dt-bindings: Add binding for
 kalray,coolidge-apic-mailbox


On Mon, 22 Jul 2024 11:41:16 +0200, ysionneau@kalrayinc.com wrote:
> From: Yann Sionneau <ysionneau@kalrayinc.com>
> 
> Add binding for Kalray Coolidge APIC Mailbox interrupt-controller.
> 
> Co-developed-by: Jules Maselbas <jmaselbas@zdiv.net>
> Signed-off-by: Jules Maselbas <jmaselbas@zdiv.net>
> Signed-off-by: Yann Sionneau <ysionneau@kalrayinc.com>
> ---
> 
> Notes:
> 
> V2 -> V3: Fixed bindings to adhere to dt-schema
> ---
>  .../kalray,coolidge-apic-mailbox.yaml         | 90 +++++++++++++++++++
>  1 file changed, 90 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/kalray,coolidge-apic-mailbox.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/interrupt-controller/kalray,coolidge-apic-mailbox.example.dtb: interrupt-controller@a00000: reg: [[0, 10485760], [0, 61952]] is too long
	from schema $id: http://devicetree.org/schemas/interrupt-controller/kalray,coolidge-apic-mailbox.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/interrupt-controller/kalray,coolidge-apic-mailbox.example.dtb: interrupt-controller@a00000: '#address-cells' is a required property
	from schema $id: http://devicetree.org/schemas/interrupt-controller/kalray,coolidge-apic-mailbox.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240722094226.21602-6-ysionneau@kalrayinc.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


