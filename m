Return-Path: <linux-kernel+bounces-442923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3A0B9EE414
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 11:27:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A670162E75
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 10:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11E90210F60;
	Thu, 12 Dec 2024 10:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sJdAXnxC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68EB12101A3;
	Thu, 12 Dec 2024 10:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733999232; cv=none; b=XhP2nRoHSUeNndKBYIfDbq/+eBvsP9f1RQ5wQntgRVFk9zNe5rXzlWG7X4wj83nUAhYj6r6HHlyjeE6o55YiV+C2NC3MgUZjONQymjyl1bs4HDELsP5cNvvw5/LpIZcmPRR5HFWpXVpACCYTM62Wl4pmsNsNU1os0xfwNaX/z40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733999232; c=relaxed/simple;
	bh=O5MNq+swzioBvBLOZxeS4g6SPUmFvnMVaaoek3tzGZA=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=pMJ+ipHIZPKnfsjC5RmsPexuBvyUZcnmKA8+bTOEFaxB5sbNFpgmhsFKeCTs97Wjt0xl3zpefmECdyFenfmUGVhYQLIyqQFAmhB9rdW9lB97V/h5TDwFgRWSku0CVaG2sc6EXSMFk4bVRJHO7AFA+P/aBa7Y8N8f0NFtw1rgK30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sJdAXnxC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB7E9C4CECE;
	Thu, 12 Dec 2024 10:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733999232;
	bh=O5MNq+swzioBvBLOZxeS4g6SPUmFvnMVaaoek3tzGZA=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=sJdAXnxCRWeXQcDr3Zb1CweOsPMgxjN6XylfVWbNkLOXd3rs8aYq3oktQz9PYcn4w
	 xLUQ9NG8J8+q0vKm+vNJEr77bVkfPvQqs3+jw1wkYwKxYjHmg52ZnO0KiiCCP4P92Z
	 DBSF0tN60yIijGV3U+wyn8+Uqb1ZHBCXj+hrw1GVsG9QFf5r9Em1Q0pmnaYncNajtx
	 qAXtCYrIeJnNsXs4shvH8ghpr1PRqHqZz6ZjJOafLpEmyNe2XFWQ67ktPRFQ90qcAe
	 dWFyR+pbtQ69F0QpelojBgT+KEHChz3njH4ZJw/MRX7eTX2zPCGi1ypatbJGmDeqq2
	 rND1ONGwe2ZvQ==
Date: Thu, 12 Dec 2024 04:27:10 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Project_Global_Chrome_Upstream_Group@mediatek.com, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 devicetree@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-mediatek@lists.infradead.org, Conor Dooley <conor+dt@kernel.org>
To: Crystal Guo <crystal.guo@mediatek.com>
In-Reply-To: <20241212090029.13692-3-crystal.guo@mediatek.com>
References: <20241212090029.13692-1-crystal.guo@mediatek.com>
 <20241212090029.13692-3-crystal.guo@mediatek.com>
Message-Id: <173399922996.1678560.9494303027075425033.robh@kernel.org>
Subject: Re: [PATCH 2/2] dt-bindings: memory-controllers: Add mediatek
 common-dramc dt-bindings


On Thu, 12 Dec 2024 16:59:48 +0800, Crystal Guo wrote:
> Add devicetree binding for mediatek common-dramc driver.
> 
> The DRAM controller of MediaTek SoC provides an interface to
> get the current data rate of DRAM.
> 
> Signed-off-by: Crystal Guo <crystal.guo@mediatek.com>
> ---
>  .../mediatek,common-dramc.yaml                | 129 ++++++++++++++++++
>  1 file changed, 129 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/memory-controllers/mediatek,common-dramc.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/memory-controllers/mediatek,common-dramc.yaml: support-ch-cnt: missing type definition
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/memory-controllers/mediatek,common-dramc.yaml: fmeter-version: missing type definition
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/memory-controllers/mediatek,common-dramc.yaml: crystal-freq: missing type definition
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/memory-controllers/mediatek,common-dramc.yaml: shu-of: missing type definition
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/memory-controllers/mediatek,common-dramc.yaml: pll-id: missing type definition
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/memory-controllers/mediatek,common-dramc.yaml: shu-lv: missing type definition
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/memory-controllers/mediatek,common-dramc.yaml: sdmpcw: missing type definition
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/memory-controllers/mediatek,common-dramc.yaml: posdiv: missing type definition
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/memory-controllers/mediatek,common-dramc.yaml: fbksel: missing type definition
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/memory-controllers/mediatek,common-dramc.yaml: dqsopen: missing type definition
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/memory-controllers/mediatek,common-dramc.yaml: async-ca: missing type definition
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/memory-controllers/mediatek,common-dramc.yaml: dq-ser-mode: missing type definition

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20241212090029.13692-3-crystal.guo@mediatek.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


