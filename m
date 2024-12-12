Return-Path: <linux-kernel+bounces-442695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 25BDF9EE070
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 08:44:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B37A31885C0E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 07:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CB7120B219;
	Thu, 12 Dec 2024 07:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rd3xG2Q0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D201D14387B;
	Thu, 12 Dec 2024 07:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733989438; cv=none; b=amzZTW/abtraQsbL89yqN+W1EOU99BmJETAmlAyAS17fM7C5kRF/6PaaD9jdLqRI54/s2UH1aKHJ0BRW/IS0cSI67DrvQeL5iuBcZxpasu0CI/ZxbqCDoRVBtR+c1ibxch3DSbkiPiWp9O0BQAls4JSTEwdyvLODMssiIp+DovQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733989438; c=relaxed/simple;
	bh=Ls3tuKWov+K/G8V/TrTRoFNKV8LH/gYbPftIK76pA34=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ifDDlVkRRfLO6oymFJgsvxRey2YbWnB4wxnDcELHW6k6W62uTTcKMRfMUld0YVoZMuD3tSKVpca2gZd9YdCX3FCqSxoS8ivkEQo8Nk8gvljI3HngZq0WZBaBASo+LHWSPcwcpU5GNp/EcgIMg0z3xP6/fODt+IjJUdviwbpyWfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rd3xG2Q0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 839B7C4CED3;
	Thu, 12 Dec 2024 07:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733989437;
	bh=Ls3tuKWov+K/G8V/TrTRoFNKV8LH/gYbPftIK76pA34=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rd3xG2Q0rDf/PzL8EX9TZR7RBhlrab1zVONzajBlnoGguehjPzl5Fea5BnsyugTMN
	 5zv76dYXUvhOs4tapUrFkfH+vH1N4u9sCPxhBAVDJsttn6QNS0mbJ6iDZCUdf0P6Am
	 zrd30QROl3/zAPPt8kxW86n/HUmJd7tHgXRBGYZcqJr26beOkNwh5eBG80aqwrov72
	 JCru6Mgqx+TQMRAl0KbYEMllC3ldHk6bFx0jZcvx50yiapUDKog0BinNdVzdCGLrx2
	 Tzwo/FqKwJwKiJISs33R13z3dJ2sa+2RJeQ0RnjQHliDsZAkNuCGNNxrF3XuekeRdu
	 a/9T4tyJNbsUA==
Date: Thu, 12 Dec 2024 08:43:53 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Alexey Klimov <alexey.klimov@linaro.org>
Cc: broonie@kernel.org, konradybcio@kernel.org, 
	konrad.dybcio@oss.qualcomm.com, andersson@kernel.org, srinivas.kandagatla@linaro.org, 
	tiwai@suse.com, lgirdwood@gmail.com, perex@perex.cz, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, dmitry.baryshkov@linaro.org, 
	linux-sound@vger.kernel.org, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 06/14] arm64: dts: qcom: qrb4210-rb2: add wcd937x
 codec support
Message-ID: <pjmtsky3bgoomd22gijdmcsis2r546me5tzhcu7wy4tzkb52to@nolvwsspc5ir>
References: <20241212004727.2903846-1-alexey.klimov@linaro.org>
 <20241212004727.2903846-7-alexey.klimov@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241212004727.2903846-7-alexey.klimov@linaro.org>

On Thu, Dec 12, 2024 at 12:47:19AM +0000, Alexey Klimov wrote:
> wcd937x codec contains soundwire RX and TX slave devices
> and can convert digital audio to analog audio and vice versa.
> The codec node also requires description of reset pin/gpio.
> 
> Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Signed-off-by: Alexey Klimov <alexey.klimov@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/qrb4210-rb2.dts | 47 ++++++++++++++++++++++++
>  1 file changed, 47 insertions(+)
> 

Your patchset has incorrect order. You cannot have DTS before drivers.
It suggests dependency which would be a NAK.

Please re-order the patches to correct (standard) style, to indicate
clearly that nothing depends on DTS.

Best regards,
Krzysztof


