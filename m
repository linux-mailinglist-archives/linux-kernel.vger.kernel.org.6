Return-Path: <linux-kernel+bounces-204986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11D588FF5DC
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 22:33:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A360E2837F6
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 20:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEB337347F;
	Thu,  6 Jun 2024 20:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m8mX8VVS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 280793FB87;
	Thu,  6 Jun 2024 20:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717705987; cv=none; b=gaZdDRCtKW4xroGdfuic5hIZVAPQA/ZstDcYJ0cbiTJufJZYXvCDm3d7tdLh2K7E00cg74b+HiwG+IJEV+8dHNJa9vOhtS7t7tdDP913xmoI1HHKQDENLaLHqQJ+ZJNIRDzWIhQSa0LW84Ilrrq3lHksVmWa9nVxv+v5uHaau+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717705987; c=relaxed/simple;
	bh=9oouy5x9Ue5GemoAYkfq4PmU8oIHLsNd4GhUYZOdKnk=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=p26gwAcYF67HnhTWpVLKEZDs5EgZuwPFBSAw3zIc50CRIxDwagAHEjrit7GPI0dzSp4yi4l3h+UQt5YHDfcXw80WdXTwvBKZAOvwnTHsB+fI8S4B2Bof7vYXIzgGQaSWoP93iufbpej2z0KM/xRS5PH4QfxlKbXz5OT58pQJYqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m8mX8VVS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C9C8C2BD10;
	Thu,  6 Jun 2024 20:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717705986;
	bh=9oouy5x9Ue5GemoAYkfq4PmU8oIHLsNd4GhUYZOdKnk=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=m8mX8VVS8F5m9+fNPFhT9U7Tp+cSZUAzQXRBB8WXkOY+YlfVD9QnoArFSKUpIXnc/
	 oglUSqQp/CADGTIvBqtooUX4+18DnGe9iXVpURfW8eyb14FP2jtZKTv2XST7yWAn4q
	 RNGJ/m3842XmtWmvJnQ2hTPDalPLSkrqu9MYUlFUy5z9dOJ1/3TIgxpKVd010jWJhH
	 wnfNwvEyi4/UgD6nKSmix0nr+45jCZ3YPdGb8iGh8xcHcTRBhuoVuYaaSBf3WFlkrv
	 qw1wY85gKgLh9bB+SzGpy2v7nIRyUy+oPzH57SpFwCas1t8Yl610Yv8MbzgCoDiQtP
	 n05M4cvFHxi4w==
Date: Thu, 06 Jun 2024 14:33:05 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Shresth Prasad <shresthprasad7@gmail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 heiko@sntech.de, skhan@linuxfoundation.org, krzk+dt@kernel.org, 
 linux-phy@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 conor+dt@kernel.org, javier.carrasco.cruz@gmail.com, 
 linux-kernel@vger.kernel.org, vkoul@kernel.org, kishon@kernel.org
In-Reply-To: <20240606184135.11065-2-shresthprasad7@gmail.com>
References: <20240606184135.11065-2-shresthprasad7@gmail.com>
Message-Id: <171770598518.3813098.8400310988488073666.robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: phy: rockchip-emmc-phy: Convert to
 dtschema


On Fri, 07 Jun 2024 00:11:36 +0530, Shresth Prasad wrote:
> Convert txt bindings of Rockchip EMMC PHY to dtschema to allow
> for validation.
> 
> Signed-off-by: Shresth Prasad <shresthprasad7@gmail.com>
> ---
> Tested against `rockchip/rk3399-firefly.dtb`, `rockchip/rk3399-orangepi.dtb`
> and `rockchip/rk3399-pinebook-pro.dtb`.
> 
>  .../bindings/phy/rockchip,emmc-phy.yaml       | 78 +++++++++++++++++++
>  .../bindings/phy/rockchip-emmc-phy.txt        | 43 ----------
>  2 files changed, 78 insertions(+), 43 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/phy/rockchip,emmc-phy.yaml
>  delete mode 100644 Documentation/devicetree/bindings/phy/rockchip-emmc-phy.txt
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/phy/rockchip,emmc-phy.example.dtb: grf: 'reg' is a required property
	from schema $id: http://devicetree.org/schemas/soc/rockchip/grf.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/phy/rockchip,emmc-phy.example.dtb: grf: 'reg' is a required property
	from schema $id: http://devicetree.org/schemas/mfd/syscon.yaml#

doc reference errors (make refcheckdocs):
Warning: Documentation/devicetree/bindings/soc/rockchip/grf.yaml references a file that doesn't exist: Documentation/devicetree/bindings/phy/rockchip-emmc-phy.txt
Documentation/devicetree/bindings/soc/rockchip/grf.yaml: Documentation/devicetree/bindings/phy/rockchip-emmc-phy.txt

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240606184135.11065-2-shresthprasad7@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


