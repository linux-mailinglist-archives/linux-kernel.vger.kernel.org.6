Return-Path: <linux-kernel+bounces-354107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E60239937E1
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 22:04:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93EE41F21BF7
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 20:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10EAF1DE4C2;
	Mon,  7 Oct 2024 20:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vJc/qEe8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA5E1865FC;
	Mon,  7 Oct 2024 20:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728331463; cv=none; b=llsBoIG2LYYR+Jt7WyJAusMjRbsx0qXX+aD0GCOkTXOPZz3yfr/VjtJ8B42oR6bZSxQMyRqsxQMDXmIqz+h7x7VyStKLGY1TvfM7HG6Lg7TcxRirNBUoGd/rwOo3nPas/xhkJ6CPdx3XdG/un3YhYaESMQ6s8rFfINBTJuUyK9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728331463; c=relaxed/simple;
	bh=zMuEK/+LlzrBce+U/LzRTcJ//VPj1HV7lbrBSEf7RLo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jRLX3Cf+hIrfresIxMp0RfVI58jm+ntlB1/uW1lTB2u1rVdZlUhHyMl/kFYuyGq0DW3qr9cOxhkIe1cVVLK6oh7pIxr96+CGT24JsqLludgKNcqS41G+8yOTx4TBzUiVpcFl52qPbJ4uEi0Pey1sUX1C08qXdCTlHNp8WerKUgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vJc/qEe8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB09EC4CEC6;
	Mon,  7 Oct 2024 20:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728331463;
	bh=zMuEK/+LlzrBce+U/LzRTcJ//VPj1HV7lbrBSEf7RLo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vJc/qEe8QWUHpTJAB/2vMtKcCCPLDPKqhGujEcnsY+syGQPYh6seMeeJ8vpd1IVeH
	 FIqAvFz6u7NXEUmDp1jbGaRuaElNQht2OPpe6rrSHtXS4hzFixxSjVoi2pT4fP++/j
	 ulkuL/w+gTB1TNIw1uuWrlMY3HJ+v1Ykx+6XNu0D9geydwdjo5uTIDlFyVrzHbCHMh
	 SncLV2kQ9DLngGCdbiqfxjwI1VDL/aN9AKhUub5xfE6djnT9tH3i+e88cKnvBIK8Wz
	 Fj10FVHJIZRE7n+ar+4yt3OpiVlHi7zbT/KDzzYHui1XkH247fArCb53hqn1kgTlJI
	 N1T1hFOlYerRw==
Date: Mon, 7 Oct 2024 15:04:22 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Jerome Brunet <jbrunet@baylibre.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	linux-amlogic@lists.infradead.org,
	Kevin Hilman <khilman@baylibre.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH] dt-bindings: soc: amlogic,meson-gx-hhi-sysctrl: Document
 the System Control registers found on early Meson SoC
Message-ID: <172833146176.2311218.15217658645332069046.robh@kernel.org>
References: <20241007-topic-amlogic-arm32-upstream-bindings-fixes-hhi-sysctrl-meson8-v1-1-896b24e6c3c8@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241007-topic-amlogic-arm32-upstream-bindings-fixes-hhi-sysctrl-meson8-v1-1-896b24e6c3c8@linaro.org>


On Mon, 07 Oct 2024 16:09:38 +0200, Neil Armstrong wrote:
> The early Amlogic SoCs also has a System Control registers register set,
> document it in the amlogic,meson-gx-hhi-sysctrl now the clock controller
> has been converted to yaml dt-schema.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  .../bindings/soc/amlogic/amlogic,meson-gx-hhi-sysctrl.yaml | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


