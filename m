Return-Path: <linux-kernel+bounces-377614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C88359AC143
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 10:16:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7339D1F250A3
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 08:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A9FF158555;
	Wed, 23 Oct 2024 08:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DVA9IZEi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B29911C2BD;
	Wed, 23 Oct 2024 08:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729671359; cv=none; b=GAFq0HwIpKtmD35ImOa6NUgSdD0kXsUb1LEHbbp5fu5yR6HsT0BmxzJqfJEmRNmAcuzjwBnKXk/2pwj49xU4YnQh1qfWQgj7LfCImNSgBrJAvRw68mKflz8Ij47uhzVXlSLbZQHZ8p2F8ig9c4ADZe6S1HfRAMgWeEUME59T7+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729671359; c=relaxed/simple;
	bh=PeAsXLDlfCIqhyjcK2CfRpDAfet98xrJsmYFIk2ihog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KN5pwsQGFJumpUVdVzdbD3KpCnw03vA+vRoMKG3QrLKAPdPi83jntKZzCe6d/ER+O13AkllkkFM/nli+v1PLGEB85Cgq3JWspsgfeIkCacresVdtLS36wE8i8POfHU7YiqDsMo1QSDmvgfGwcOAM4K2dkhQ8SLEl9WnyoYTewjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DVA9IZEi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D8BFC4CEC6;
	Wed, 23 Oct 2024 08:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729671359;
	bh=PeAsXLDlfCIqhyjcK2CfRpDAfet98xrJsmYFIk2ihog=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DVA9IZEinMKDzSyhvGUHMrj/I5SdsyshZl7pwRXwaJSAr76GWwRtvJGwPoBHRw8ov
	 L1a6zw7rpBTw+dtEvWGQYnfDd4M49B9zvIymKsNUnLYSPeqmiWFKZgucc6Gy0lwC3y
	 bOgVUY46ZAC3WxS64jGoZCflY+7SxIHbWIP9673zsa3tyht+j1UWBW2Z33hPv09Xqw
	 y+qDt7vFz5QC2AXLJYTY2GIDo7Uecf5Axh5Tz/SU+D2c1E+vVCQay43II9/kgcY71q
	 xkNL4SuylUhzd6Uq/VKdgACL7HG9+Tbu0VrmJOXJiMALcjDmF7M/918cHg1tKQIIen
	 MdqBbBtJY4iug==
Date: Wed, 23 Oct 2024 10:15:56 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Melody Olvera <quic_molvera@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Taniya Das <quic_tdas@quicinc.com>, Trilok Soni <quic_tsoni@quicinc.com>, 
	"Satya Durga Srinivasu Prabhala --cc=linux-arm-msm @ vger . kernel . org" <quic_satyap@quicinc.com>, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/7] dt-bindings: clock: qcom: Document the SM8750 TCSR
 Clock Controller
Message-ID: <cdff3iubtjxxk63rmmgejdkicxluiinlwprujlfskrzveioxpe@vkeoff5hnyfa>
References: <20241021230359.2632414-1-quic_molvera@quicinc.com>
 <20241021230359.2632414-7-quic_molvera@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241021230359.2632414-7-quic_molvera@quicinc.com>

On Mon, Oct 21, 2024 at 04:03:58PM -0700, Melody Olvera wrote:
> From: Taniya Das <quic_tdas@quicinc.com>
> 
> Add bindings documentation for the SM8750 Clock Controller.
> 
> Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
> ---
>  .../bindings/clock/qcom,sm8550-tcsr.yaml          |  2 ++
>  include/dt-bindings/clock/qcom,sm8750-tcsr.h      | 15 +++++++++++++++
>  2 files changed, 17 insertions(+)
>  create mode 100644 include/dt-bindings/clock/qcom,sm8750-tcsr.h

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


