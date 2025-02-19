Return-Path: <linux-kernel+bounces-520682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 484E2A3AD37
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 01:42:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A354175013
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 00:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0AC72B9A9;
	Wed, 19 Feb 2025 00:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rUE7ym6c"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15BAF22097;
	Wed, 19 Feb 2025 00:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739925737; cv=none; b=ltQz1Ge8+MWvHttdmmlXT/jwpdVPUCZOk/KDSTJCV/Zo4UKDI05OzE7crXCv5n57xjMvStRw72RWfFVR4qpfTLwsKIyQrVBJLXQ81A/8SIe+g9EekJ1odoBv+wsrrSvbbllzRGDdBoxtZSDJiJiFQtlEV3bVXLmzVWjoAFKIbVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739925737; c=relaxed/simple;
	bh=5ATz3qoZO0uyhjafPNvrVGduTAInvw9k8D3BQjGQMP0=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=k2B5e8JjzpibEds3dmAKKy8Xx78F2l5jwjdrlHb5pXadG7ZFKxEqs0DB+Fbfnp4oGuOcO+Vyv6G/i0rl3tyEV+9dG/+rzBCePbTPB7xs3rofKAIfPIQnVGj4vba0LijWAxlEKl+PthA139qJyGA0sDf3XNuttwIYWZpGnQQ/+IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rUE7ym6c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48261C4CEE2;
	Wed, 19 Feb 2025 00:42:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739925736;
	bh=5ATz3qoZO0uyhjafPNvrVGduTAInvw9k8D3BQjGQMP0=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=rUE7ym6cpVcQEMakXZOfcKvSri/zFYTON7R14QqaiGdHeREJV3kluIb5L0feThZQt
	 WSV5HqbJVVH/+R4AUcM71jPqcyfNg/1tA/hNwAr19YdJz4GOnFkq4AcF2q9NdkBN+0
	 5X2EZBB0+hpd5oQjlM48XTt8bKNs1iZX79Sirk5PalU1nOV4cMdo/wO6dXCARqmlz6
	 q8JsnDDjxhyPL7aTO6VeJsinXBz+ytQBxCjXOHPhWYd6lmtab6pEZd27hqc8d5Molm
	 YUE9d/34f9TPO7c4rYgPDyLQr2b74D31VL04ZfYzpQoUg7P3PCfzFStghTkVYD5OAt
	 qlnVLf4ilKHkg==
Date: Tue, 18 Feb 2025 18:42:15 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: gakula@marvell.com, sebastian.hesselbarth@gmail.com, andrew@lunn.ch, 
 linux-arm-kernel@lists.infradead.org, gregory.clement@bootlin.com, 
 salee@marvell.com, devicetree@vger.kernel.org, krzk+dt@kernel.org, 
 linux-kernel@vger.kernel.org, conor+dt@kernel.org, p.zabel@pengutronix.de
To: Wilson Ding <dingwei@marvell.com>
In-Reply-To: <20250214065833.530276-1-dingwei@marvell.com>
References: <20250214065833.530276-1-dingwei@marvell.com>
Message-Id: <173992515450.2064904.7377620309703204862.robh@kernel.org>
Subject: Re: [PATCH 0/4] Add Armada8K reset controller support


On Thu, 13 Feb 2025 22:58:28 -0800, Wilson Ding wrote:
> Armada8K has one simple register for unit soft reset, which is part of
> the system controller register area. The simple reset code doesn't
> support register access via regmap for the syscon devices. This patch
> series added new ops for reset line operation to make the simple reset
> code compatible for syscon device. And add Armada8K support then.
> 
> Wilson Ding (4):
>   reset: simple: Add syscon device compatible
>   reset: simple: Add support for Armada8K reset controller
>   dt-bindings: cp110: Document the reset controller
>   arm64: dts: marvell: cp11x: Add reset controller node
> 
>  .../arm/marvell/cp110-system-controller.txt   |  32 +++++
>  arch/arm64/boot/dts/marvell/armada-cp11x.dtsi |   6 +
>  drivers/reset/reset-simple.c                  | 126 +++++++++++++++---
>  include/linux/reset/reset-simple.h            |  11 ++
>  4 files changed, 154 insertions(+), 21 deletions(-)
> 
> --
> 2.43.0
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


New warnings running 'make CHECK_DTBS=y for arch/arm64/boot/dts/marvell/' for 20250214065833.530276-1-dingwei@marvell.com:

arch/arm64/boot/dts/marvell/cn9131-db.dtb: /cp0/config-space@f2000000/system-controller@440000/soft-reset@268: failed to match any schema with compatible: ['marvell,armada8k-reset']
arch/arm64/boot/dts/marvell/cn9130-db.dtb: /cp0/config-space@f2000000/system-controller@440000/soft-reset@268: failed to match any schema with compatible: ['marvell,armada8k-reset']
arch/arm64/boot/dts/marvell/armada-8040-puzzle-m801.dtb: /cp0/config-space@f2000000/system-controller@440000/soft-reset@268: failed to match any schema with compatible: ['marvell,armada8k-reset']
arch/arm64/boot/dts/marvell/armada-7040-db.dtb: /cp0/config-space@f2000000/system-controller@440000/soft-reset@268: failed to match any schema with compatible: ['marvell,armada8k-reset']
arch/arm64/boot/dts/marvell/cn9130-cf-pro.dtb: /cp0/config-space@f2000000/system-controller@440000/soft-reset@268: failed to match any schema with compatible: ['marvell,armada8k-reset']
arch/arm64/boot/dts/marvell/cn9130-db-B.dtb: /cp0/config-space@f2000000/system-controller@440000/soft-reset@268: failed to match any schema with compatible: ['marvell,armada8k-reset']
arch/arm64/boot/dts/marvell/cn9130-cf-base.dtb: /cp0/config-space@f2000000/system-controller@440000/soft-reset@268: failed to match any schema with compatible: ['marvell,armada8k-reset']
arch/arm64/boot/dts/marvell/cn9131-db-B.dtb: /cp0/config-space@f2000000/system-controller@440000/soft-reset@268: failed to match any schema with compatible: ['marvell,armada8k-reset']
arch/arm64/boot/dts/marvell/armada-7040-mochabin.dtb: /cp0/config-space@f2000000/system-controller@440000/soft-reset@268: failed to match any schema with compatible: ['marvell,armada8k-reset']
arch/arm64/boot/dts/marvell/armada-8040-puzzle-m801.dtb: /cp1/config-space@f4000000/system-controller@440000/soft-reset@268: failed to match any schema with compatible: ['marvell,armada8k-reset']
arch/arm64/boot/dts/marvell/cn9131-db.dtb: /cp1/config-space@f4000000/system-controller@440000/soft-reset@268: failed to match any schema with compatible: ['marvell,armada8k-reset']
arch/arm64/boot/dts/marvell/cn9132-clearfog.dtb: /cp0/config-space@f2000000/system-controller@440000/soft-reset@268: failed to match any schema with compatible: ['marvell,armada8k-reset']
arch/arm64/boot/dts/marvell/cn9131-db-B.dtb: /cp1/config-space@f4000000/system-controller@440000/soft-reset@268: failed to match any schema with compatible: ['marvell,armada8k-reset']
arch/arm64/boot/dts/marvell/cn9132-clearfog.dtb: /cp1/config-space@f4000000/system-controller@440000/soft-reset@268: failed to match any schema with compatible: ['marvell,armada8k-reset']
arch/arm64/boot/dts/marvell/armada-8040-mcbin-singleshot.dtb: /cp0/config-space@f2000000/system-controller@440000/soft-reset@268: failed to match any schema with compatible: ['marvell,armada8k-reset']
arch/arm64/boot/dts/marvell/armada-8040-mcbin.dtb: /cp0/config-space@f2000000/system-controller@440000/soft-reset@268: failed to match any schema with compatible: ['marvell,armada8k-reset']
arch/arm64/boot/dts/marvell/cn9132-clearfog.dtb: /cp2/config-space@f6000000/system-controller@440000/soft-reset@268: failed to match any schema with compatible: ['marvell,armada8k-reset']
arch/arm64/boot/dts/marvell/cn9131-cf-solidwan.dtb: /cp0/config-space@f2000000/system-controller@440000/soft-reset@268: failed to match any schema with compatible: ['marvell,armada8k-reset']
arch/arm64/boot/dts/marvell/armada-8040-mcbin-singleshot.dtb: /cp0/config-space@f2000000/spi@700680: failed to match any schema with compatible: ['marvell,armada-380-spi']
arch/arm64/boot/dts/marvell/cn9132-db-B.dtb: /cp0/config-space@f2000000/system-controller@440000/soft-reset@268: failed to match any schema with compatible: ['marvell,armada8k-reset']
arch/arm64/boot/dts/marvell/cn9130-crb-B.dtb: /cp0/config-space@f2000000/system-controller@440000/soft-reset@268: failed to match any schema with compatible: ['marvell,armada8k-reset']
arch/arm64/boot/dts/marvell/ac5x-rd-carrier-cn9131.dtb: /cp0/config-space@f2000000/system-controller@440000/soft-reset@268: failed to match any schema with compatible: ['marvell,armada8k-reset']
arch/arm64/boot/dts/marvell/armada-8040-mcbin.dtb: /cp1/config-space@f4000000/system-controller@440000/soft-reset@268: failed to match any schema with compatible: ['marvell,armada8k-reset']
arch/arm64/boot/dts/marvell/armada-8040-mcbin-singleshot.dtb: /cp1/config-space@f4000000/system-controller@440000/soft-reset@268: failed to match any schema with compatible: ['marvell,armada8k-reset']
arch/arm64/boot/dts/marvell/cn9132-db.dtb: /cp0/config-space@f2000000/system-controller@440000/soft-reset@268: failed to match any schema with compatible: ['marvell,armada8k-reset']
arch/arm64/boot/dts/marvell/cn9130-crb-A.dtb: /cp0/config-space@f2000000/system-controller@440000/soft-reset@268: failed to match any schema with compatible: ['marvell,armada8k-reset']
arch/arm64/boot/dts/marvell/cn9131-cf-solidwan.dtb: /cp1/config-space@f4000000/system-controller@440000/soft-reset@268: failed to match any schema with compatible: ['marvell,armada8k-reset']
arch/arm64/boot/dts/marvell/cn9132-db-B.dtb: /cp1/config-space@f4000000/system-controller@440000/soft-reset@268: failed to match any schema with compatible: ['marvell,armada8k-reset']
arch/arm64/boot/dts/marvell/ac5x-rd-carrier-cn9131.dtb: /cp1/config-space@f4000000/system-controller@440000/soft-reset@268: failed to match any schema with compatible: ['marvell,armada8k-reset']
arch/arm64/boot/dts/marvell/cn9132-db.dtb: /cp1/config-space@f4000000/system-controller@440000/soft-reset@268: failed to match any schema with compatible: ['marvell,armada8k-reset']
arch/arm64/boot/dts/marvell/armada-8040-clearfog-gt-8k.dtb: /cp0/config-space@f2000000/system-controller@440000/soft-reset@268: failed to match any schema with compatible: ['marvell,armada8k-reset']
arch/arm64/boot/dts/marvell/cn9132-db-B.dtb: /cp2/config-space@f6000000/system-controller@440000/soft-reset@268: failed to match any schema with compatible: ['marvell,armada8k-reset']
arch/arm64/boot/dts/marvell/cn9132-db.dtb: /cp2/config-space@f6000000/system-controller@440000/soft-reset@268: failed to match any schema with compatible: ['marvell,armada8k-reset']
arch/arm64/boot/dts/marvell/armada-8040-clearfog-gt-8k.dtb: /cp1/config-space@f4000000/system-controller@440000/soft-reset@268: failed to match any schema with compatible: ['marvell,armada8k-reset']
arch/arm64/boot/dts/marvell/armada-8040-db.dtb: /cp0/config-space@f2000000/system-controller@440000/soft-reset@268: failed to match any schema with compatible: ['marvell,armada8k-reset']
arch/arm64/boot/dts/marvell/armada-8040-db.dtb: /cp1/config-space@f4000000/system-controller@440000/soft-reset@268: failed to match any schema with compatible: ['marvell,armada8k-reset']






