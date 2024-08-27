Return-Path: <linux-kernel+bounces-302726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64C4D960292
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 08:57:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 908921C20AD1
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 06:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB0101547C5;
	Tue, 27 Aug 2024 06:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KTESJBOJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 284C4148FE1;
	Tue, 27 Aug 2024 06:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724741823; cv=none; b=bDqcuJz9HI/vxXOtqQJyOsp44rqEwfRY2mPQsvijEvFWqNfZZi/0lJtYGgcZ3Qh+E2io82FpDHi2SuHhcZ7P5fh530mkrxo0josHmq8iwd+kOiMiyIIvo0XLgJ8cw0gH5QQqg3a9tq0mDwODhkCY2T3ZpzTSNq3YTuOe+Q8N/qM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724741823; c=relaxed/simple;
	bh=EdNPQchORoPessX+G6mk84EUoaM5/m/oPh6e5kb7gTE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MgUG1dDTq5bjaVQ02uza2BMzwGrGeTa/niQ9S90vVN3dBfZ/KMfXqiNSDbzBQRoX/FW2jDR/J2V81mNY4KHa1e1E1yIgwvfClCcIidOovXNqreFs4k0KFHr3ETusgNmT88Ym1H+QqxjwTZ9QoIpT+wUxG83uUEuwBdx3+0LYjeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KTESJBOJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86145C4FE00;
	Tue, 27 Aug 2024 06:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724741822;
	bh=EdNPQchORoPessX+G6mk84EUoaM5/m/oPh6e5kb7gTE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KTESJBOJHBJEU4kUtEaMVsXM4ZBCg3UIH/tGJfMQ4NhjxUuY2D2Vm9HftMhnXAhjm
	 TgJ4U/J06eLspxES147RRkrPxEzWAYRLDXoo0gt0a7fVLMJdQSSuJCic+wEB7biHLn
	 mG1w5o649gC7sxY99zIO0ONvc9Yb7AvyU+cm6lQ3x0MZik9cj3HQkYpIJEf/B4sGHQ
	 aQE4EFUMg/qIX8QQrk3JnIhblFjxWci2n7fNLhqnhvLJa+ZYGav2SHM6bNWu+CrVs0
	 HncDqZPeDQcP9MI+RwiFgvFXXyQwkIoRJzZmUNBEK99nE6L44Rzjb5ropUxxyMuCNk
	 S1/0xPQ+Qnimg==
Date: Tue, 27 Aug 2024 08:56:58 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, kernel@collabora.com, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Conor Dooley <conor@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: soc: rockchip: Fix compatibles for
 RK3588 VO{0,1}_GRF
Message-ID: <5c5juu2ug5wmtzcokvwav2vls2f43ryom6mjrqc27uytscax6d@hj4qfezdrf7u>
References: <20240827-rk3588-vo-grf-compat-v1-0-d4a18acf951a@collabora.com>
 <20240827-rk3588-vo-grf-compat-v1-1-d4a18acf951a@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240827-rk3588-vo-grf-compat-v1-1-d4a18acf951a@collabora.com>

On Tue, Aug 27, 2024 at 02:06:50AM +0300, Cristian Ciocaltea wrote:
> According to RK3588 TRM, VO0_GRF and VO1_GRF have a similar layout, but
> definitely not an identical one, therefore sharing the compatible is not
> really justified.
> 
> Since currently there is no user of this, hence no ABI break, let's fix
> it by providing dedicated strings.
> 
> Reported-by: Conor Dooley <conor@kernel.org>
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> ---
>  Documentation/devicetree/bindings/soc/rockchip/grf.yaml | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/soc/rockchip/grf.yaml b/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
> index 78c6d5b64138..8fd539125f4a 100644
> --- a/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
> +++ b/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
> @@ -31,7 +31,8 @@ properties:
>                - rockchip,rk3588-pcie3-pipe-grf
>                - rockchip,rk3588-usb-grf
>                - rockchip,rk3588-usbdpphy-grf
> -              - rockchip,rk3588-vo-grf

You should deprecate the old one instead (deprecated: true).

Best regards,
Krzysztof


