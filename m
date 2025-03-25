Return-Path: <linux-kernel+bounces-574690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 036AAA6E88F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 04:13:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE9B03AF7AC
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 03:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCA471A5BA6;
	Tue, 25 Mar 2025 03:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZJ/8rdmg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B621A3172;
	Tue, 25 Mar 2025 03:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742872403; cv=none; b=VVueYtLFHuCSSeIb6vR9ex1kL8Jq4v5jmsZ6KaKnYq+iXI5OuWwRqIywRS51sMQv9WguTapCyu70a3axOW6QEBRuPiKOFn+ce5eiVDFADsrYdUV00xarh/8tZfZSrDj1INkk8IpTyNKVf3+XAi5SEU0Ny9NTsQVdNK8q71CtTuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742872403; c=relaxed/simple;
	bh=E7hVehIeYXHEFzo2cwihH0hixCMqgRhmdfHFRgEeypc=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=hxGEO7U0QFacAI572sIeUBmVrhsyqVf+gVdxRGac0oVpQFNmwp5f3Qss4HGxhTqpgq/RccnEPLu/IdGmTVOJqBk+H7k3OGLlPSbxR7jybAk/h0hZWdVcrdPe0cIYH5TjYPmE3VPkBTP2dJgA/Lx0ueMB1gbBfVLL4edfpaKiPLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZJ/8rdmg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30809C4CEDD;
	Tue, 25 Mar 2025 03:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742872402;
	bh=E7hVehIeYXHEFzo2cwihH0hixCMqgRhmdfHFRgEeypc=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=ZJ/8rdmgejL5ITSuOME+enjRg5eUU+Nk4/jaCfVmLOZdqVbUIHzu3UUpdIiIh0wFV
	 crk+JWcbsM9tidy0Rj0wpAiKiQwCoTV6jLxecNH2LqUt4ph2Im88XI601JjfyoXOjg
	 CNay8ntkC/3jAEtnWf+sB2edz89pd7FVSqHzSO/r5UYyHLfSc9zHOCQO5B+Hqx34jd
	 nZTrg4igkAFmj0fxQbn2kLQpbFvhsSig3T1RDFmmfayXF46Ul1FjUlitv5Kdd+VogW
	 x3VSfKpNA5ObqmwFJiPLkh/uvMxI9iz2RQwAtD8sQXsrEiPOwFinmVjDSO2vACyw7g
	 iauhapHA3WZEg==
Date: Mon, 24 Mar 2025 22:13:21 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, 
 Conor Dooley <conor+dt@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 Heiko Stuebner <heiko@sntech.de>
To: Sebastian Reichel <sebastian.reichel@collabora.com>
In-Reply-To: <20250324-rock5bp-for-upstream-v1-0-6217edf15b19@kernel.org>
References: <20250324-rock5bp-for-upstream-v1-0-6217edf15b19@kernel.org>
Message-Id: <174287236051.1618248.4100886448951731382.robh@kernel.org>
Subject: Re: [PATCH 0/5] arm64: dts: rockchip: add ROCK 5B+ support


On Mon, 24 Mar 2025 18:04:21 +0100, Sebastian Reichel wrote:
> This series adds support for the ROCK 5B+, which (as the name suggests)
> is an improved version of the ROCK 5B. It also adds initial USB-C
> support for both the ROCK 5B and the 5B+.
> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
> Sebastian Reichel (5):
>       arm64: dts: rockchip: move rock 5b to include file
>       arm64: dts: rockchip: move rock 5b to include file
>       dt-bindings: arm: rockchip: Add Radxa ROCK 5B+
>       arm64: dts: rockchip: add Rock 5B+
>       arm64: dts: rockchip: add USB-C support for ROCK 5B and 5B+
> 
>  .../devicetree/bindings/arm/rockchip.yaml          |    5 +
>  arch/arm64/boot/dts/rockchip/Makefile              |    1 +
>  .../boot/dts/rockchip/rk3588-rock-5b-plus.dts      |  117 +++
>  arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts    |  952 +----------------
>  arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dtsi   | 1087 ++++++++++++++++++++
>  5 files changed, 1220 insertions(+), 942 deletions(-)
> ---
> base-commit: 76728fe54f547950f73c9dc446beb2e31604abd7
> change-id: 20250324-rock5bp-for-upstream-fd85b00b593b
> 
> Best regards,
> --
> Sebastian Reichel <sre@kernel.org>
> 
> 
> 


My bot found new DTB warnings on the .dts files added or changed in this
series.

Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
are fixed by another series. Ultimately, it is up to the platform
maintainer whether these warnings are acceptable or not. No need to reply
unless the platform maintainer has comments.

If you already ran DT checks and didn't see these error(s), then
make sure dt-schema is up to date:

  pip3 install dtschema --upgrade


New warnings running 'make CHECK_DTBS=y for arch/arm64/boot/dts/rockchip/' for 20250324-rock5bp-for-upstream-v1-0-6217edf15b19@kernel.org:

arch/arm64/boot/dts/rockchip/rk3588-rock-5b-plus.dtb: power-controller: power-domain@12: Unevaluated properties are not allowed ('domain-supply' was unexpected)
	from schema $id: http://devicetree.org/schemas/power/rockchip,power-controller.yaml#
arch/arm64/boot/dts/rockchip/rk3588-rock-5b-plus.dtb: vop@fdd90000: clocks: [[33, 605], [33, 604], [33, 609], [33, 610], [33, 611], [33, 612], [33, 603], [107], [108]] is too long
	from schema $id: http://devicetree.org/schemas/display/rockchip/rockchip-vop2.yaml#
arch/arm64/boot/dts/rockchip/rk3588-rock-5b-plus.dtb: vop@fdd90000: clock-names: ['aclk', 'hclk', 'dclk_vp0', 'dclk_vp1', 'dclk_vp2', 'dclk_vp3', 'pclk_vop', 'pll_hdmiphy0', 'pll_hdmiphy1'] is too long
	from schema $id: http://devicetree.org/schemas/display/rockchip/rockchip-vop2.yaml#
arch/arm64/boot/dts/rockchip/rk3588-rock-5b-plus.dtb: spdif-tx@fddb0000: compatible: 'oneOf' conditional failed, one must be fixed:
	['rockchip,rk3588-spdif', 'rockchip,rk3568-spdif'] is too long
	'rockchip,rk3066-spdif' was expected
	'rockchip,rk3228-spdif' was expected
	'rockchip,rk3328-spdif' was expected
	'rockchip,rk3366-spdif' was expected
	'rockchip,rk3368-spdif' was expected
	'rockchip,rk3399-spdif' was expected
	'rockchip,rk3568-spdif' was expected
	'rockchip,rk3588-spdif' is not one of ['rockchip,rk3128-spdif', 'rockchip,rk3188-spdif', 'rockchip,rk3288-spdif', 'rockchip,rk3308-spdif']
	from schema $id: http://devicetree.org/schemas/sound/rockchip-spdif.yaml#
arch/arm64/boot/dts/rockchip/rk3588-rock-5b-plus.dtb: /spdif-tx@fddb0000: failed to match any schema with compatible: ['rockchip,rk3588-spdif', 'rockchip,rk3568-spdif']
arch/arm64/boot/dts/rockchip/rk3588-rock-5b-plus.dtb: spdif-tx@fdde0000: compatible: 'oneOf' conditional failed, one must be fixed:
	['rockchip,rk3588-spdif', 'rockchip,rk3568-spdif'] is too long
	'rockchip,rk3066-spdif' was expected
	'rockchip,rk3228-spdif' was expected
	'rockchip,rk3328-spdif' was expected
	'rockchip,rk3366-spdif' was expected
	'rockchip,rk3368-spdif' was expected
	'rockchip,rk3399-spdif' was expected
	'rockchip,rk3568-spdif' was expected
	'rockchip,rk3588-spdif' is not one of ['rockchip,rk3128-spdif', 'rockchip,rk3188-spdif', 'rockchip,rk3288-spdif', 'rockchip,rk3308-spdif']
	from schema $id: http://devicetree.org/schemas/sound/rockchip-spdif.yaml#
arch/arm64/boot/dts/rockchip/rk3588-rock-5b-plus.dtb: /spdif-tx@fdde0000: failed to match any schema with compatible: ['rockchip,rk3588-spdif', 'rockchip,rk3568-spdif']
arch/arm64/boot/dts/rockchip/rk3588-rock-5b-plus.dtb: /rng@fe378000: failed to match any schema with compatible: ['rockchip,rk3588-rng']
arch/arm64/boot/dts/rockchip/rk3588-rock-5b-plus.dtb: spdif-tx@fe4e0000: compatible: 'oneOf' conditional failed, one must be fixed:
	['rockchip,rk3588-spdif', 'rockchip,rk3568-spdif'] is too long
	'rockchip,rk3066-spdif' was expected
	'rockchip,rk3228-spdif' was expected
	'rockchip,rk3328-spdif' was expected
	'rockchip,rk3366-spdif' was expected
	'rockchip,rk3368-spdif' was expected
	'rockchip,rk3399-spdif' was expected
	'rockchip,rk3568-spdif' was expected
	'rockchip,rk3588-spdif' is not one of ['rockchip,rk3128-spdif', 'rockchip,rk3188-spdif', 'rockchip,rk3288-spdif', 'rockchip,rk3308-spdif']
	from schema $id: http://devicetree.org/schemas/sound/rockchip-spdif.yaml#
arch/arm64/boot/dts/rockchip/rk3588-rock-5b-plus.dtb: /spdif-tx@fe4e0000: failed to match any schema with compatible: ['rockchip,rk3588-spdif', 'rockchip,rk3568-spdif']
arch/arm64/boot/dts/rockchip/rk3588-rock-5b-plus.dtb: spdif-tx@fe4f0000: compatible: 'oneOf' conditional failed, one must be fixed:
	['rockchip,rk3588-spdif', 'rockchip,rk3568-spdif'] is too long
	'rockchip,rk3066-spdif' was expected
	'rockchip,rk3228-spdif' was expected
	'rockchip,rk3328-spdif' was expected
	'rockchip,rk3366-spdif' was expected
	'rockchip,rk3368-spdif' was expected
	'rockchip,rk3399-spdif' was expected
	'rockchip,rk3568-spdif' was expected
	'rockchip,rk3588-spdif' is not one of ['rockchip,rk3128-spdif', 'rockchip,rk3188-spdif', 'rockchip,rk3288-spdif', 'rockchip,rk3308-spdif']
	from schema $id: http://devicetree.org/schemas/sound/rockchip-spdif.yaml#
arch/arm64/boot/dts/rockchip/rk3588-rock-5b-plus.dtb: /spdif-tx@fe4f0000: failed to match any schema with compatible: ['rockchip,rk3588-spdif', 'rockchip,rk3568-spdif']
arch/arm64/boot/dts/rockchip/rk3588-rock-5b-plus.dtb: spdif-tx@fddb8000: compatible: 'oneOf' conditional failed, one must be fixed:
	['rockchip,rk3588-spdif', 'rockchip,rk3568-spdif'] is too long
	'rockchip,rk3066-spdif' was expected
	'rockchip,rk3228-spdif' was expected
	'rockchip,rk3328-spdif' was expected
	'rockchip,rk3366-spdif' was expected
	'rockchip,rk3368-spdif' was expected
	'rockchip,rk3399-spdif' was expected
	'rockchip,rk3568-spdif' was expected
	'rockchip,rk3588-spdif' is not one of ['rockchip,rk3128-spdif', 'rockchip,rk3188-spdif', 'rockchip,rk3288-spdif', 'rockchip,rk3308-spdif']
	from schema $id: http://devicetree.org/schemas/sound/rockchip-spdif.yaml#
arch/arm64/boot/dts/rockchip/rk3588-rock-5b-plus.dtb: /spdif-tx@fddb8000: failed to match any schema with compatible: ['rockchip,rk3588-spdif', 'rockchip,rk3568-spdif']
arch/arm64/boot/dts/rockchip/rk3588-rock-5b-plus.dtb: spdif-tx@fdde8000: compatible: 'oneOf' conditional failed, one must be fixed:
	['rockchip,rk3588-spdif', 'rockchip,rk3568-spdif'] is too long
	'rockchip,rk3066-spdif' was expected
	'rockchip,rk3228-spdif' was expected
	'rockchip,rk3328-spdif' was expected
	'rockchip,rk3366-spdif' was expected
	'rockchip,rk3368-spdif' was expected
	'rockchip,rk3399-spdif' was expected
	'rockchip,rk3568-spdif' was expected
	'rockchip,rk3588-spdif' is not one of ['rockchip,rk3128-spdif', 'rockchip,rk3188-spdif', 'rockchip,rk3288-spdif', 'rockchip,rk3308-spdif']
	from schema $id: http://devicetree.org/schemas/sound/rockchip-spdif.yaml#
arch/arm64/boot/dts/rockchip/rk3588-rock-5b-plus.dtb: /spdif-tx@fdde8000: failed to match any schema with compatible: ['rockchip,rk3588-spdif', 'rockchip,rk3568-spdif']
arch/arm64/boot/dts/rockchip/rk3588-rock-5b-plus.dtb: /hdmi_receiver@fdee0000: failed to match any schema with compatible: ['rockchip,rk3588-hdmirx-ctrler', 'snps,dw-hdmi-rx']
arch/arm64/boot/dts/rockchip/rk3588-rock-5b-plus.dtb: /hdmi_receiver@fdee0000: failed to match any schema with compatible: ['rockchip,rk3588-hdmirx-ctrler', 'snps,dw-hdmi-rx']
arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dtb: vop@fdd90000: clocks: [[33, 605], [33, 604], [33, 609], [33, 610], [33, 611], [33, 612], [33, 603], [107], [108]] is too long
	from schema $id: http://devicetree.org/schemas/display/rockchip/rockchip-vop2.yaml#






