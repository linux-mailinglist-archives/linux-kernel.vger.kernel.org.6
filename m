Return-Path: <linux-kernel+bounces-383844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F43E9B20D6
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 22:17:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9EDDAB21196
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 21:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86A7F1865E3;
	Sun, 27 Oct 2024 21:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S+GdVswh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF6F1714D0
	for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2024 21:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730063835; cv=none; b=G4DCKjJSByaYBObX+pntmbIwrsdxKrotReZagn+aJ6L1MYwr5JJCYXrq/HXoge/ABqgF7UescwkKuou/iqmLcUXZq7k26o3HfkM0MWkUoBqCNdw3d+8Y3J+8eSawBlU3uANRi8uEFhk2zooVmu6ksH0of+U60giM1aop/cyNQQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730063835; c=relaxed/simple;
	bh=OkJZ2a0tGPzKgYgNIUYRWslx1RQvJ/CB+bAEJ9oofo0=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=IkvITWKfNbiYV4ToDP1SQeG3BiddQwhPzLUgVtOj+FeskzeMGoVdnYrhG/UbuiHUhGM+mLh0D454k0pgrq6sbm1AL+091QXbumxnNEKj+bfH1i+8HeInvbV9ssBSb04uVfvbBSba21ojIBxapcD6LB4InqQsIJfke8IPQrQRJ80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S+GdVswh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4116FC4CEE7;
	Sun, 27 Oct 2024 21:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730063834;
	bh=OkJZ2a0tGPzKgYgNIUYRWslx1RQvJ/CB+bAEJ9oofo0=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=S+GdVswh60z/kEkUsuzXLgj+T8owXIvOxYNHX6yyDkIxxx2E8rifTfika/3uiDv/q
	 A16J7Jy4OUmIpf06jHuD1wCestK//KnUTHSUodBdeKELQE28xSsiOMzsFw2c7PKipn
	 NF/Yd2mW8S9mLtV4h7HXOlJqZYIvd4qomfcG90oYegHqqzjlhrC/gAKjYYoOO7O2kL
	 5irjDOkbPY0ogJye2vPhSp5m5Fn499YqwwxI2foU8HoR77o0CJFts7oUrlj1bYmQbu
	 BoyVMgEaWQ8JthFewww2TQxFjrSzKkZdIRCOWg5Wp378AcbCyLxt6YJorc36meKEp2
	 LkUAPEC83Wz9Q==
Date: Sun, 27 Oct 2024 16:17:07 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Andy Yan <andyshrk@163.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, heiko@sntech.de
In-Reply-To: <20241026081942.348459-1-andyshrk@163.com>
References: <20241026081942.348459-1-andyshrk@163.com>
Message-Id: <173006367828.91304.9007142735562178151.robh@kernel.org>
Subject: Re: [PATCH 0/3] Enable hdmi for rk3588 based Cool Pi


On Sat, 26 Oct 2024 16:19:25 +0800, Andy Yan wrote:
> As the hdmi-qp controller recently get merged, we can enable hdmi
> display out on these boards now.
> 
> 
> Andy Yan (3):
>   arm64: dts: rockchip: Enable HDMI0 for rk3588 Cool Pi CM5 EVB
>   arm64: dts: rockchip: Enable HDMI display for rk3588 Cool Pi 4B
>   arm64: dts: rockchip: Enable HDMI display for rk3588 Cool Pi GenBook
> 
>  .../dts/rockchip/rk3588-coolpi-cm5-evb.dts    | 49 ++++++++++++++++++
>  .../rockchip/rk3588-coolpi-cm5-genbook.dts    | 51 +++++++++++++++++++
>  .../boot/dts/rockchip/rk3588s-coolpi-4b.dts   | 49 ++++++++++++++++++
>  3 files changed, 149 insertions(+)
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


New warnings running 'make CHECK_DTBS=y rockchip/rk3588-coolpi-cm5-evb.dtb rockchip/rk3588-coolpi-cm5-genbook.dtb rockchip/rk3588s-coolpi-4b.dtb' for 20241026081942.348459-1-andyshrk@163.com:

arch/arm64/boot/dts/rockchip/rk3588-coolpi-cm5-evb.dtb: hdmi@fde80000: Unevaluated properties are not allowed ('enable-gpios' was unexpected)
	from schema $id: http://devicetree.org/schemas/display/rockchip/rockchip,rk3588-dw-hdmi-qp.yaml#
arch/arm64/boot/dts/rockchip/rk3588s-coolpi-4b.dtb: hdmi@fde80000: Unevaluated properties are not allowed ('enable-gpios' was unexpected)
	from schema $id: http://devicetree.org/schemas/display/rockchip/rockchip,rk3588-dw-hdmi-qp.yaml#
arch/arm64/boot/dts/rockchip/rk3588-coolpi-cm5-genbook.dtb: hdmi@fde80000: Unevaluated properties are not allowed ('enable-gpios' was unexpected)
	from schema $id: http://devicetree.org/schemas/display/rockchip/rockchip,rk3588-dw-hdmi-qp.yaml#






