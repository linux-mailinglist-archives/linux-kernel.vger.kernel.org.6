Return-Path: <linux-kernel+bounces-254447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2075E933352
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 23:13:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE7FD282824
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 21:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 974A713E41A;
	Tue, 16 Jul 2024 21:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OaOJSXam"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B0013CFBB;
	Tue, 16 Jul 2024 21:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721164359; cv=none; b=eVFsu/IfeXk44HIkn+QtWHuq1IriFBxfcWEJfoqLEWAwL0egFkUaWOZ4zNwYac6fZ0/4d9X7FjsKIHWlWdvu9x09WHzjZA4/XiK2MMBD1x3aWg4xaIfZbSLa/Vqz1NlVsHQS+CS3GEliYoq+37aofz4Hf0yQkBCOik09g4LzxWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721164359; c=relaxed/simple;
	bh=pWFMDcCWc4JALdENxjGdvjOkgU/ZmXdU2cvvVS1rfFc=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=R2oBy6yxWKqyn800oDn54qgnlFpU8Ya5/gCj6TqtarqYGNP9XCN926HinVFojgCGTtWLsOmAjjX5yURR8QOXR1eLTEyGGXIt+fi7X2Do5AmYk2NwSVgp+siIio7NyA1UkvW8now2CvjywfNbIvxHLnTuGIKP95nzqdKZbsZwxA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OaOJSXam; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 287C9C4AF0C;
	Tue, 16 Jul 2024 21:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721164359;
	bh=pWFMDcCWc4JALdENxjGdvjOkgU/ZmXdU2cvvVS1rfFc=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=OaOJSXamy5NMWjbjfBO4xslat/mENqg7iYoo4Hg3+zlD9t5ISds9Iji1Z6HyZQRXj
	 hBZRlt5/Eepx2iNKInWXvVn6QmvABOnR1qy1hEQC5BkY4maitGY+qS1Qt/M48dn0pv
	 mxvPrzAt8fi1by5y8tJ+40i+cTJch5IJmP9HJG8666NWyjEjAB0XI/fKHfAHnQ8VL3
	 laHLuGSkQ45mcc8pNK3IhvExeJcvFgYJkT4l5ltgsBHGsROLpBpL9SQdg44vCpe8IN
	 6NqaW4ip+w2+deSrhUVUaMQQaM2+YGSZbCd93rAprlY5lIvLC6xBb0Bmp5vYheLH4D
	 DiHjIC2hWtUFw==
Date: Tue, 16 Jul 2024 15:12:37 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Christopher Obbard <chris.obbard@collabora.com>
Cc: Conor Dooley <conor+dt@kernel.org>, linux-rockchip@lists.infradead.org, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, devicetree@vger.kernel.org, 
 Kever Yang <kever.yang@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240716-rockchip-px30-firefly-v1-0-60cdad3023a3@collabora.com>
References: <20240716-rockchip-px30-firefly-v1-0-60cdad3023a3@collabora.com>
Message-Id: <172116301355.347311.14376396477445638438.robh@kernel.org>
Subject: Re: [PATCH 0/2] Add support for Firefly CORE PX30 JD4


On Tue, 16 Jul 2024 16:51:03 +0100, Christopher Obbard wrote:
> The Firefly CORE PX30 JD4 board is a SOM and motherboard bundle from
> Firefly containing the Rockchip PX30 SOC. This series adds support for it.
> 
> 
> ---
> Christopher Obbard (2):
>       dt-bindings: arm: rockchip: add Firefly CORE PX30 JD4
>       arm64: dts: rockchip: add Firefly CORE PX30 JD4
> 
>  .../devicetree/bindings/arm/rockchip.yaml          |   5 +
>  arch/arm64/boot/dts/rockchip/Makefile              |   1 +
>  .../dts/rockchip/px30-firefly-core-px30-jd4.dts    | 562 +++++++++++++++++++++
>  3 files changed, 568 insertions(+)
> ---
> base-commit: d67978318827d06f1c0fa4c31343a279e9df6fde
> change-id: 20240716-rockchip-px30-firefly-59efc93d6784
> 
> Best regards,
> --
> Christopher Obbard <chris.obbard@collabora.com>
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


New warnings running 'make CHECK_DTBS=y rockchip/px30-firefly-core-px30-jd4.dtb' for 20240716-rockchip-px30-firefly-v1-0-60cdad3023a3@collabora.com:

arch/arm64/boot/dts/rockchip/px30-firefly-core-px30-jd4.dtb: /dsi@ff450000/panel@0: failed to match any schema with compatible: ['sitronix,st7703']






