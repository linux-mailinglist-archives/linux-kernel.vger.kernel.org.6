Return-Path: <linux-kernel+bounces-312234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9C2E9693DF
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 08:39:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 382D12882FF
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 06:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3C681D54FD;
	Tue,  3 Sep 2024 06:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DbKZukXE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 199C61D54DB;
	Tue,  3 Sep 2024 06:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725345563; cv=none; b=b8RQ/N+MSxAWFjHNEL3DY4u1hWIuzSh/QdItL/M0Az2tPjPpfViUIFDf/dq91Yd8zWfonufdf7y48hINn8NsdmcNFDrgyWZRVfHnH0Nq7RsKWwGSU3y0xiNTTA59gh3T/PWdaouUqqkilq8kn6Ac+92Cfish6dJZp/uNGsqsmdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725345563; c=relaxed/simple;
	bh=BvsPQXp0NFlGoX8kbT6UTK+OyBs1VxhW4vkwizjesMA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FG55E3aOEyoJeGuph2DHP8FvDkwY5W/prx3SBuWaW7ZufVyww3Hkvcd7yW5Y/yiuzE8jhdgFJV5P/6nE2Xe4okc1jp+b4bo7pDW1tPH/mcBevHl4Xy3Lgw6EEjyrtWPljB8CGeFc7JmJncqoDdGFyAZxGg+H03nHqKwe9foH6sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DbKZukXE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DE0BC4CEC5;
	Tue,  3 Sep 2024 06:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725345562;
	bh=BvsPQXp0NFlGoX8kbT6UTK+OyBs1VxhW4vkwizjesMA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DbKZukXE5RVS6lTOkbxBzeB+fXb56/qevkylK8BOg4ZyPxvrjDk/nAYsPk3pyW0xG
	 iOemgE9SsUGbzlRdDOr0sHQjYVA3+obPN2MpQqfJcP9NEVo85xVukhmp2SNKUDxlCT
	 Bo0210a7Go3z7h2t4CeSTKJ0OXx9ndF8x8Xh0+ktI7TgLzR49wO7Y9EuYH/q2TNy5f
	 8q5U+Oj/Ep4O0QEwUlLSfcmzC3Q4+7Mm55z2Zee+BcfcDF+nRRDmD71+iia+0AkZJ6
	 d4GbIjzT7CICTCoSdz3auyhf9DNO96NM9lASaHDAcEU7dUiLbVIQMABqs2fvn6tHy/
	 ClXyDMP2ZKvbA==
Date: Tue, 3 Sep 2024 08:39:19 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Manorit Chawdhry <m-chawdhry@ti.com>
Cc: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, 
	Tero Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Udit Kumar <u-kumar1@ti.com>, Neha Malcom Francis <n-francis@ti.com>, 
	Aniket Limaye <a-limaye@ti.com>, Beleswar Padhi <b-padhi@ti.com>, 
	Siddharth Vadapalli <s-vadapalli@ti.com>
Subject: Re: [PATCH v6 2/5] arm64: dts: ti: Refactor J784s4-evm to a common
 file
Message-ID: <4avtzi22ue6nfusdrvyl2x3apwjgmuwa246qu5kh2dk2fdb4si@hka6nygye75z>
References: <20240902-b4-upstream-j742s2-v6-0-6a7aa2736797@ti.com>
 <20240902-b4-upstream-j742s2-v6-2-6a7aa2736797@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240902-b4-upstream-j742s2-v6-2-6a7aa2736797@ti.com>

On Mon, Sep 02, 2024 at 05:56:50PM +0530, Manorit Chawdhry wrote:
> Refactor J784s4-evm to a common file which uses the
> superset device to allow reuse in j742s2-evm which uses the subset part.
> 
> Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
> Reviewed-by: Beleswar Padhi <b-padhi@ti.com>
> ---
> 
> Notes:
>     v6:
>     - Rebased with conflicts
> 
>  arch/arm64/boot/dts/ti/k3-j784s4-evm.dts           | 1488 +------------------
>  .../boot/dts/ti/k3-j784s4-j742s2-evm-common.dtsi   | 1490 ++++++++++++++++++++
>  2 files changed, 1497 insertions(+), 1481 deletions(-)
>

It's impossible to review this. You need to use -B/-M/-C arguments when
creating patch.

Best regards,
Krzysztof


