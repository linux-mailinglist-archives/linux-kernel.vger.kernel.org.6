Return-Path: <linux-kernel+bounces-354025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC8BC99367D
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 20:45:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E7AE1F22C7E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 18:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DC401DE3D5;
	Mon,  7 Oct 2024 18:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UWQVDeX2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96BE41DE3BC;
	Mon,  7 Oct 2024 18:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728326678; cv=none; b=XglKK+robRmMR/o8fZUiMlrTKIPUm9ys9rEmCYS6b7e1ci4xtcSylqxBIVqdKfR2v9SiaRf0Dhh4mMUeS3dOjQSx4uJ/vc13qc38hXGo+ER8dHVRfL7ZOhSbqzwPwJlEeE3FkO8bNFrYhRLNTAgqAHOoPH8vUh13HyJwjNUj+GQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728326678; c=relaxed/simple;
	bh=bCI+qgFArcf9UnJxBNHIm5bHVxWp7CHcTrPf+iCLfp0=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=tOAiRvndS4WiTNIgkRP3f26aBw6ftYdtUhjR6Mto3id+xr7HjjU4nML7Tcbei7yg2ayeIxKwimysiw+dmmoXriXKVN1TBT04VTHbtf15+utgQnVelP0lH0r9DBZVq3eo0sZEn68dxbOg3LNNazIO5lOLv8amHBPjlsw5NED0kl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UWQVDeX2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CF05C4CECC;
	Mon,  7 Oct 2024 18:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728326678;
	bh=bCI+qgFArcf9UnJxBNHIm5bHVxWp7CHcTrPf+iCLfp0=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=UWQVDeX2N3N6J8fuUcKH3roh+QukaOQ7DtwHMvBPUzKkZ9fnR8V1VUHIIkM/TbMTr
	 6Kdy9gUxHTK7EslQMltdP5y8DrjwBB7OkaPXbriwM3RCt3JeK/5MNDDfRyQZwUDSbQ
	 46DXmSxY1iu6eAGk0u2d79W6QyIWwbQEpbaNOHPi4zxfbw0WBTk7qZSQAgfS7teS0G
	 e8YbTIRSyZj/uX82FlD+IaDbVCsnx8VzuDH6E3EJ+8kY8AlvnjcWnExqnaFOZ2kJvU
	 hYBqH/kEWP+ps+gLSwBa8n0ngK7tVJZYxz0CkUr+s0+1LZWvf9V2k07HfOyHyb4gFc
	 Dsw5rOz+AlKAg==
Date: Mon, 07 Oct 2024 13:44:37 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Diederik de Haas <didi.debian@cknow.org>
Cc: devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Dragan Simic <dsimic@manjaro.org>, linux-rockchip@lists.infradead.org, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
In-Reply-To: <20241007105657.6203-2-didi.debian@cknow.org>
References: <20241007105657.6203-2-didi.debian@cknow.org>
Message-Id: <172832632958.2107354.3994911613740546826.robh@kernel.org>
Subject: Re: rockchip: Fix several DT validation errors


On Mon, 07 Oct 2024 12:28:15 +0200, Diederik de Haas wrote:
> This is a set of 4 small device-tree validation fixes.
> 
> Patch 1 adds the power-domains property to the csi dphy node on rk356x.
> Patch 2 removes the 2nd interrupt from the hdmi node on rk3328.
> Patch 3 replaces 'wake' with 'wakeup' on brcm BT nodes.
> Patch 4 replaces 'reset-gpios' with 'shutdown-gpios' on brcm BT nodes.
> 
>  arch/arm64/boot/dts/rockchip/rk3328.dtsi           | 3 +--
>  arch/arm64/boot/dts/rockchip/rk3566-box-demo.dts   | 4 ++--
>  arch/arm64/boot/dts/rockchip/rk3566-pinenote.dtsi  | 6 +++---
>  arch/arm64/boot/dts/rockchip/rk3566-radxa-cm3.dtsi | 2 +-
>  arch/arm64/boot/dts/rockchip/rk356x.dtsi           | 1 +
>  5 files changed, 8 insertions(+), 8 deletions(-)
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


New warnings running 'make CHECK_DTBS=y rockchip/rk3566-box-demo.dtb' for 20241007105657.6203-2-didi.debian@cknow.org:

arch/arm64/boot/dts/rockchip/rk3566-box-demo.dtb: bluetooth: Unevaluated properties are not allowed ('clock-names' was unexpected)
	from schema $id: http://devicetree.org/schemas/net/bluetooth/brcm,bluetooth.yaml#






