Return-Path: <linux-kernel+bounces-255968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27224934729
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 06:33:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D77A5282FD6
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 04:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6CF43D967;
	Thu, 18 Jul 2024 04:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="ibWb1zOp"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88687186A;
	Thu, 18 Jul 2024 04:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721277188; cv=none; b=T4sH7UzK24ALvM2KwnTF7TNon5CptP7zzvTYDVeeQn6wJfWEBWiyEem+YKgFTJY6rYTvdMCGRX46UWiGe9Tdr6k+du9KeTCE/CC6uSGbSArH41fDPHsDrNBnsiKdSr36UlQBzBnxlHFrNGPatxurVoGBeWye+NC+f3mun5fujWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721277188; c=relaxed/simple;
	bh=eXiWsyvo3xbFtmzFjNHUvzmDy5KuNooROFO1O+ua8/U=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=mtazceVTpTeJgcbYvJFJpl4XTywrdqznEtxov0m56118dPAy70QcCJin7Oh+NEBLZ/dhku9F4uwwJq85NQQRyZsJlRxP1dl55cguGQMoPqOxVbqAaYv8I3fkn5AmIkqcpYdlOkdHK8XZyfQPL6XYMu6e9NHNy72BG0vKEE0cG8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=ibWb1zOp; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1721277184;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LtwV/4WIDbK+8ZAf8F7AmoboBuDaoArPtGFAuXsacys=;
	b=ibWb1zOpKy9ZI5nXD1vhDusuMQ4PARctoV12KdFb8hR5WPuN4uPLFz2wfzrkCVgseE9FkK
	wxr+n+jy7ImDib+jkJ8dY+BQykkD0OnOwX9DtGuHtRTx7izrooNAWEnBz1UeIoA3xfaRH8
	KCt0YoqpQQRYN8eaeB6fFRn9V8h4I1ighz62TmxdZZz7d9gG92XNJEVEzvAtUfxVUy3kbJ
	D6guebULiUMWkVarXc7WtMrYBEIWU9+QJznprFnkTcxPJF+zYIZ1Ugk/TB+RK1m0cgNNGE
	EDM+9AbT8tgs2nyQ5Q0J1QSCPrSqeO9bwgk8b4ZZP9sJNvKrs+aFhh83pW8QgA==
Date: Thu, 18 Jul 2024 06:33:04 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Christopher Obbard <chris.obbard@collabora.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, Kever Yang
 <kever.yang@rock-chips.com>, Collabora Kernel Mailing List
 <kernel@collabora.com>
Subject: Re: [PATCH v2 0/3] Add support for Firefly Core-PX30-JD4 SoM &
 baseboard
In-Reply-To: <20240717-rockchip-px30-firefly-v2-0-06541a5a5946@collabora.com>
References: <20240717-rockchip-px30-firefly-v2-0-06541a5a5946@collabora.com>
Message-ID: <38d7b7e9ab71bf1b0817e666f4233b9e@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Christopher,

On 2024-07-17 18:46, Christopher Obbard wrote:
> This adds support for the PX30-based Core-PX30-JD4 system-on-module 
> from
> Firefly and includes support for the SoM in combination with the
> Firefly MB-JD4-PX30 baseboard.
> 
> ---
> Changes in v2:
> - Split into two separate files: dtsi for the SoM and dts for the 
> carrier.
> - Change devicetree compatible to match SoM/carrier split.
> - Change device names to better match vendor's name.
> - Properly model baseboard & SoM regulators.
> - Properly model baseboard recovery key.
> - Remove DSI panel (& related nodes) since "sitronix,st7703" compatible
>   is undocumented & hardware is unavailable.
> - Remove unused audio-related nodes.
> - Remove unused UART nodes.
> - Remove unused PMIC pinctrl nodes.
> - Add node for baseboard LEDs.
> - Link to v1:
> https://lore.kernel.org/r/20240716-rockchip-px30-firefly-v1-0-60cdad3023a3@collabora.com

Thanks for the v2.

> ---
> Christopher Obbard (3):
>       dt-bindings: arm: rockchip: Add Firefly Core-PX30-JD4 with 
> baseboard
>       arm64: dts: rockchip: add Firefly Core-PX30-JD4 SoM
>       arm64: dts: rockchip: add Firefly JD4 baseboard with 
> Core-PX30-JD4 SoM
> 
>  .../devicetree/bindings/arm/rockchip.yaml          |   6 +
>  arch/arm64/boot/dts/rockchip/Makefile              |   1 +
>  .../boot/dts/rockchip/px30-firefly-jd4-core.dtsi   | 322 
> +++++++++++++++++++++
>  arch/arm64/boot/dts/rockchip/px30-firefly-jd4.dts  | 178 ++++++++++++
>  4 files changed, 507 insertions(+)

It would be better to name the new dts(i) files like this:

- px30-firefly-jd4-core.dtsi
- px30-firefly-jd4-core-mb.dts

This would follow the <SoC>-<brand>-<SoM>-<carrier>.dts pattern, which
is somewhat common and sorts nicely in directory listings when there's
more than one carrier board for the same SoM.

> ---
> base-commit: 51835949dda3783d4639cfa74ce13a3c9829de00
> change-id: 20240716-rockchip-px30-firefly-59efc93d6784
> 
> Best regards,

