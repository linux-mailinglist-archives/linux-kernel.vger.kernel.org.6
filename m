Return-Path: <linux-kernel+bounces-393109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17D269B9BEE
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 02:31:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 498DF1C20E8E
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 01:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFA0632C8E;
	Sat,  2 Nov 2024 01:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pyFAeDOi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46FB4EEB2;
	Sat,  2 Nov 2024 01:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730511091; cv=none; b=kCTs7cU7dL6M0l0wKbxODu0Zf28A42+BPdd9gXlV/dfl0HPhvow81g69dDNT2VnMaFY990IMtZ2pFuMcJWxlODYvmDldPI98azxlL6aEoYhjej/+wtuox/aYiTDn+yVNS/JRfdr99ZKec4SMcIKAuqyHRUWUfLElEQSzEByTUz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730511091; c=relaxed/simple;
	bh=bZaX/EKorv9Z86U2/e2k8gpDQqOWK/Dh9xHiMTqLh74=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=NRQYFOt6TBga/USVydKVpXc6sue5bhSJZ50Su1hldiTV27qdKumVtfgyrUonHnxs7mqe0jSrgljZsALEwZQJwPEWgUAfPe29lownWxhFBGupdE9ITxq0Eo+riPAyEJV3YmcRNP1WKxLPs4GUA6RBWZt6KsPcV+1/sZtv1ybD+A4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pyFAeDOi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A39FEC4CECD;
	Sat,  2 Nov 2024 01:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730511090;
	bh=bZaX/EKorv9Z86U2/e2k8gpDQqOWK/Dh9xHiMTqLh74=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=pyFAeDOiUgAVKpl62xURWlUGzVcEvk3W/Zj1JjUj7TH672oZj/EYrbjj1bkZVTaWZ
	 NS0rPlJx+apy0pv6LRheVEqRK7BtOiBBPACx9IdhGXHFgR81eyokoEqJbkg9pbot2Z
	 28ueuMRQU2NZSnaTA0+gw0Qbt1Bp8Isfg6Hwj1FE/XsdguLgLKwQiSddlgtCh+5Tuu
	 rZ5pznQ/v+S8c7zDxosbXnUhBnynN/gBNihdMYQAIWiV1voxlrOHA0OzFrQPXmuj8Z
	 gxVXRXT40wa2kHaWKCaKbnqNJOHYo6cvh2+1m7aYQ5SNxgtAuosGGLlwBh1nMv6uhZ
	 Miid/CtPr05Qw==
Date: Fri, 01 Nov 2024 20:31:28 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Samuel Holland <samuel.holland@sifive.com>
Cc: devicetree@vger.kernel.org, Conor Dooley <conor@kernel.org>, 
 Emil Renner Berthing <kernel@esmil.dk>, Rob Herring <robh+dt@kernel.org>, 
 linux-kernel@vger.kernel.org, 
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org, 
 Alexandre Ghiti <alexghiti@rivosinc.com>
In-Reply-To: <20241102000843.1301099-2-samuel.holland@sifive.com>
References: <20241102000843.1301099-1-samuel.holland@sifive.com>
 <20241102000843.1301099-2-samuel.holland@sifive.com>
Message-Id: <173051108892.583398.1565228083513288043.robh@kernel.org>
Subject: Re: [PATCH 01/11] dt-bindings: riscv: Describe physical memory
 regions


On Fri, 01 Nov 2024 17:07:55 -0700, Samuel Holland wrote:
> Information about physical memory regions is needed by both the kernel
> and M-mode firmware. For example, the kernel needs to know about
> noncacheable aliases of cacheable memory in order to allocate coherent
> memory pages for DMA. M-mode firmware needs to know about aliases so it
> can protect itself from lower-privileged software. Firmware also needs
> to know the platform's Physical Address Width in order to efficiently
> implement Smmpt.
> 
> The RISC-V Privileged Architecture delegates the description of Physical
> Memory Attributes to the platform. On DT-based platforms, it makes sense
> to put this information in the devicetree.
> 
> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
> ---
> 
>  .../bindings/riscv/physical-memory.yaml       | 101 ++++++++++++++++++
>  include/dt-bindings/riscv/physical-memory.h   |  44 ++++++++
>  2 files changed, 145 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/riscv/physical-memory.yaml
>  create mode 100644 include/dt-bindings/riscv/physical-memory.h
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/riscv/physical-memory.example.dtb: /: compatible: 'oneOf' conditional failed, one must be fixed:
	['starfive,jh7100'] is too short
	'starfive,jh7100' is not one of ['beagle,beaglev-starlight-jh7100-r0', 'starfive,visionfive-v1']
	'starfive,jh7100' is not one of ['milkv,mars', 'pine64,star64', 'starfive,visionfive-2-v1.2a', 'starfive,visionfive-2-v1.3b']
	from schema $id: http://devicetree.org/schemas/riscv/starfive.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/riscv/physical-memory.example.dtb: /: 'model' is a required property
	from schema $id: http://devicetree.org/schemas/root-node.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20241102000843.1301099-2-samuel.holland@sifive.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


