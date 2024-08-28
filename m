Return-Path: <linux-kernel+bounces-304984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E27D9627C1
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 14:51:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECB011F223DB
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 12:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEAEF1862B7;
	Wed, 28 Aug 2024 12:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KCrY8jpv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C57D149C7A;
	Wed, 28 Aug 2024 12:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724849475; cv=none; b=QUOFnHFJ2v6//j61lBQGfwK1DBh7ipyl3CKT20nVOqXX9qnuGiMw8c2FggcuWbzvyyhvo+i+oeV6OTI/t3ZfEKfGu3gXSkh4u/PREU0Ir30DUUZsbbeXJHHv8TayIdkfTHIKPXACREFVNd4SPMJAEGS0mpq5R2uWzBWsDq+RlMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724849475; c=relaxed/simple;
	bh=Xj3q54Xs8pJypq3V2jbLTbUBopo2sjq2zYTrO+Fvrh8=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=o/LGlPZ3DIMxGRUNBGtr1Hiz8+xtkMmhyCTzCUSc+q66Mbq3zpnpa5wUiulDb/NIaa1I8p9mUPKGarJjaC384cPLkEenqO5EQbX++WF+pC+Z15kNsPXAsSprIp/ieAfRGnxjSskGSY4zMVAFI/JdN0ujtdaCRz5PkcNl3lhq7Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KCrY8jpv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78742C4FEFA;
	Wed, 28 Aug 2024 12:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724849474;
	bh=Xj3q54Xs8pJypq3V2jbLTbUBopo2sjq2zYTrO+Fvrh8=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=KCrY8jpvMbbIitPFuw6LTwsNwwOTO9mGyzvA58CCJtU1zjfI9tIfItgQFNTceWoZx
	 fOsJs/GrhafzzQAm+4wG/xOh6g3HOCUwioE3jp6JGWX2M1uHGVsUFgsDiGlId/fr2k
	 RoWviw0SjpZeW0I74wBvKYDdTOF+y2/6wqFWvuSeEJ4oIQMFmlCuhi4zhfxI6xVr/7
	 yrgeOMyaJo6T4qbUe6HevXRNKshF5AERp4ZJWTvMZ5DT/+Bv+DAMAx1Zr1l6ELOyfx
	 FQDHgr+fJtR37b6RvQ8Uw5D7JDm+njb2eAAFDrMmkGKN+gnKR310R2UGr+xGNHU23Z
	 NpuhWsF5Ee5Rg==
Date: Wed, 28 Aug 2024 07:51:12 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Jonathan Liu <net147@gmail.com>
Cc: Conor Dooley <conor+dt@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 FUKAUMI Naoki <naoki@radxa.com>, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org
In-Reply-To: <20240828074755.1320692-1-net147@gmail.com>
References: <20240828074755.1320692-1-net147@gmail.com>
Message-Id: <172484936512.3462690.18423493121475512611.robh@kernel.org>
Subject: Re: [PATCH v2] arm64: dts: rockchip: Enable RK809 audio codec for
 Radxa ROCK 4C+


On Wed, 28 Aug 2024 17:47:53 +1000, Jonathan Liu wrote:
> This adds the necessary device tree changes to enable analog audio
> output for the 3.5 mm TRS headphone jack on the Radxa ROCK 4C+ with
> its RK809 audio codec.
> 
> Signed-off-by: Jonathan Liu <net147@gmail.com>
> ---
>  .../boot/dts/rockchip/rk3399-rock-4c-plus.dts | 46 ++++++++++++++++++-
>  1 file changed, 45 insertions(+), 1 deletion(-)
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


New warnings running 'make CHECK_DTBS=y rockchip/rk3399-rock-4c-plus.dtb' for 20240828074755.1320692-1-net147@gmail.com:

arch/arm64/boot/dts/rockchip/rk3399-rock-4c-plus.dtb: pmic: vsel1-gpio: {'rockchip,pins': [[1, 17, 0, 194]], 'phandle': 138} is not of type 'array'
	from schema $id: http://devicetree.org/schemas/gpio/gpio-consumer.yaml#
arch/arm64/boot/dts/rockchip/rk3399-rock-4c-plus.dtb: pmic: vsel2-gpio: {'rockchip,pins': [[1, 14, 0, 194]], 'phandle': 139} is not of type 'array'
	from schema $id: http://devicetree.org/schemas/gpio/gpio-consumer.yaml#






