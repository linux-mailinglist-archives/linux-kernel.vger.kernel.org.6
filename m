Return-Path: <linux-kernel+bounces-171671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 401DD8BE724
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 17:15:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 717CB1C239E3
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 15:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C0191635AD;
	Tue,  7 May 2024 15:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dbAdNNIB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904E916130B;
	Tue,  7 May 2024 15:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715094890; cv=none; b=d1fRiXmMurRDn2l9hXqrUCtoxnb4GtpueyyTwPxodZzEac0bVWw2oe6U5mg7AccbY6+amLVWFeC5Dm7wu0FA0zE8MK+g4OB8vEAGMco0ZglMoWVGFTFaz3EB0gh3IHTazwVGCzA8EPCzGG7QKm4XrwgLp2VdnUP6ZHIkA3D/4F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715094890; c=relaxed/simple;
	bh=PjCTV7JX3phTYmApghlae2CUkayVRisRZ1IV02RHcnQ=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=ROhMuaGKTVirYgm9J0HG2sx684RDJqSrvaG40RiVLUo+UIM/YEjc2WkWa9Sizo86FfLYjCAlNqzwB0eEk1lB/PuYwo5gpxoNv5cw2GOqZ+wPW4G3o3RIfDVWzZlOWItFwwpeX8QOtjQI0pBtp4N0ytLmN8CNSfoFm8bipf5WYi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dbAdNNIB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0820C2BBFC;
	Tue,  7 May 2024 15:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715094890;
	bh=PjCTV7JX3phTYmApghlae2CUkayVRisRZ1IV02RHcnQ=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=dbAdNNIBE5BaB+wRjqZ49wM9g1YM0gVZe02Rm0cjwLHjVLhtBZR1aPXgpeYbRMnGg
	 vmaeLQBO4tBY+Keab/UbBTMraGLfNaTSbR9kLbKI7uRJ1AXm23+gD4Y5bF74ijPOAd
	 ImNiajCdFbskPhJZ4Rg2q+5CfSfARELppPqbm8FkGSXOmnlhWhV5+VRWAAUMl6fPBs
	 ihKIEwNKLVLzldd2dBvasLF+KjL2zOpji/o/RlQ+4+5EuB1aZGHET/kkx8KmyQdHwF
	 JsiZRsgY6h7Denmo+nfxhDxoDZZ41sscorJEQdQae+j2yjYoBTkAZ5i8u9WzdyHHFJ
	 9+CxSh2LoJDQw==
Date: Tue, 07 May 2024 10:14:48 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Cong Yang <yangcong5@huaqin.corp-partner.google.com>
Cc: sam@ravnborg.org, dianders@chromium.org, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linus.walleij@linaro.org, 
 xuxinxiong@huaqin.corp-partner.google.com, airlied@gmail.com, 
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, 
 devicetree@vger.kernel.org, conor+dt@kernel.org, daniel@ffwll.ch, 
 neil.armstrong@linaro.org
In-Reply-To: <20240507135234.1356855-2-yangcong5@huaqin.corp-partner.google.com>
References: <20240507135234.1356855-1-yangcong5@huaqin.corp-partner.google.com>
 <20240507135234.1356855-2-yangcong5@huaqin.corp-partner.google.com>
Message-Id: <171509488827.493449.2668049686067198439.robh@kernel.org>
Subject: Re: [PATCH v4 1/7] dt-bindings: display: panel: Add himax hx83102
 panel bindings


On Tue, 07 May 2024 21:52:28 +0800, Cong Yang wrote:
> In V1, discussed with Doug and Linus [1], we need break out as separate
> driver for the himax83102-j02 controller. Beacuse "starry,himax83102-j02"
> and in this series "BOE nv110wum-l60" "IVO t109nw41" panels use same
> controller, they have some common CMDS. So add new documentation for
> this panels.
> 
> For himax83102-j02 controller, no need 3v3 supply, so remove it.
> 
> [1]: https://lore.kernel.org/all/CACRpkdbzYZAS0=zBQJUC4CB2wj4s1h6n6aSAZQvdMV95r3zRUw@mail.gmail.com
> 
> Signed-off-by: Cong Yang <yangcong5@huaqin.corp-partner.google.com>
> ---
> Chage since V4:
> 
> - Update commit message and add fallback compatible.
> 
> V3: https://lore.kernel.org/all/20240424023010.2099949-2-yangcong5@huaqin.corp-partner.google.com
> 
> Chage since V3:
> 
> - Update commit message.
> 
> V2: https://lore.kernel.org/all/20240422090310.3311429-2-yangcong5@huaqin.corp-partner.google.com
> 
> ---
>  .../display/panel/boe,tv101wum-nl6.yaml       |  2 -
>  .../bindings/display/panel/himax,hx83102.yaml | 73 +++++++++++++++++++
>  2 files changed, 73 insertions(+), 2 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/himax,hx83102.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/panel/himax,hx83102.example.dtb: panel@0: compatible:0: 'starry,himax83102-j02, himax,hx83102' does not match '^[a-zA-Z0-9][a-zA-Z0-9,+\\-._/]+$'
	from schema $id: http://devicetree.org/schemas/dt-core.yaml#
Documentation/devicetree/bindings/display/panel/himax,hx83102.example.dtb: /example-0/dsi/panel@0: failed to match any schema with compatible: ['starry,himax83102-j02, himax,hx83102']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240507135234.1356855-2-yangcong5@huaqin.corp-partner.google.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


