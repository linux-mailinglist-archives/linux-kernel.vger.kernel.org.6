Return-Path: <linux-kernel+bounces-287913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61E5D952E2C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 14:18:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A97E284080
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 12:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3848517A59A;
	Thu, 15 Aug 2024 12:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B+7Vfl5V"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C15146A6D;
	Thu, 15 Aug 2024 12:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723724294; cv=none; b=FzE0vBUdwsAZn+uQ3dSmU9XxOn9wXlNFBuiyWs5LfWQz0zN1Wkwd0mnxpuITEI11iQbaenZYg/8SPUU1XtFCKnv7b3Zu+ZFUSU3nIypY4FeBpjSjqos16vnVt9XKxEvmuDGq4c5ySa8foXGqF/T0HJgwGPEeo9yj1vOSLhlL3/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723724294; c=relaxed/simple;
	bh=7QhbBW6p0X6p6YPfrcpdaggvWSA98lr0bHquclOIYT8=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=dmCqRkWws6Tc7C6TNrks6wciB+LrGUQxwGHSDRM5L5QshuOq5PCXp51lCuK7AB3MI25W/llmsq8uHDMfQicSyG61DZg5gcHuiNoPXUbpLmKhJbIiCnpkOI7FC8x9jhV8PeWAW1PGuFZTEYtrpbmnvQTtLSl8rHCMjDmYCT+EQH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B+7Vfl5V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF93DC32786;
	Thu, 15 Aug 2024 12:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723724294;
	bh=7QhbBW6p0X6p6YPfrcpdaggvWSA98lr0bHquclOIYT8=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=B+7Vfl5Vp+XJMKkop1QTQS6dmX/eow6feaLeZYuWBBswwuAt4fBmLXLXXEVK+XVaN
	 RiuM3u0gzaduzUAVV9pzW2AFHXVd1LnTI4pdhLsrfbobJnOno+6ZkbsBy3O3lJk2kV
	 8zHgdgWGEEUyHu+Cne7aUOj/oYOkjliPFTEkFF0TvPtmP2XkJsb70noCjjMT1Tgfr1
	 9WtSVgUwNHDWMmxzM9m0I6Rwsu3JkReyMOTz1cekmwOsxNdHIOUSMs6/GXwId5hDOX
	 1Xm0G3aML5xYRFm9lmHCQfkPXj2Z/PB04advWMou3XWtgFA8O/liqMNlfQDKvbLMhf
	 EbyIC8qHr9oGw==
Date: Thu, 15 Aug 2024 06:18:13 -0600
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Stanislav Jakubek <stano.jakubek@gmail.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>, devicetree@vger.kernel.org, 
 Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, 
 Orson Zhai <orsonzhai@gmail.com>, Chunyan Zhang <zhang.lyra@gmail.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Lee Jones <lee@kernel.org>
In-Reply-To: <Zr3X1RoQs7ElTnlJ@standask-GA-A55M-S2HP>
References: <Zr3X1RoQs7ElTnlJ@standask-GA-A55M-S2HP>
Message-Id: <172372429319.1231807.807365186421195669.robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: mfd: sprd,sc2731: convert to YAML


On Thu, 15 Aug 2024 12:26:29 +0200, Stanislav Jakubek wrote:
> Convert the Spreadtrum SC27xx PMIC bindings to DT schema. Adjust the
> filename to match the compatible of the only in-tree user, SC2731.
> Change #interrupt-cells value to 1, as according to [1] that is the
> correct value.
> 
> [1] https://lore.kernel.org/lkml/b6a32917d1e231277d240a4084bebb6ad91247e3.1550060544.git.baolin.wang@linaro.org/
> 
> Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>
> ---
> Depends on:
>   - eFuse YAML conversion: https://lore.kernel.org/lkml/9fba73ce66f1f3b7b2a8f46e7c21f60cff5a85f0.1721199034.git.stano.jakubek@gmail.com/
>   - RTC YAML conversion: https://lore.kernel.org/lkml/ZrBzmQI0IAL7LI3e@standask-GA-A55M-S2HP/
> 
>  .../devicetree/bindings/mfd/sprd,sc2731.yaml  | 124 ++++++++++++++++++
>  .../bindings/mfd/sprd,sc27xx-pmic.txt         |  40 ------
>  2 files changed, 124 insertions(+), 40 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mfd/sprd,sc2731.yaml
>  delete mode 100644 Documentation/devicetree/bindings/mfd/sprd,sc27xx-pmic.txt
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mfd/sprd,sc2731.yaml:
Error in referenced schema matching $id: http://devicetree.org/schemas/nvmem/sprd,sc2731-efuse.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/Zr3X1RoQs7ElTnlJ@standask-GA-A55M-S2HP

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


