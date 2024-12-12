Return-Path: <linux-kernel+bounces-442693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57DB09EE067
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 08:42:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD480280254
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 07:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E8A220B213;
	Thu, 12 Dec 2024 07:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VmC93fNB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C6C25949C;
	Thu, 12 Dec 2024 07:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733989345; cv=none; b=ZvuON0f4C7EjWa4FbciwsCDsJztb29xHYF+oe14rv6e1Ey7ijtzcmrZFOD6fd2iEoEYQguQxYjWpQ09Kew/PmNNGqTx8kOiiGo7EdbdIPCaDl8WMQdEZ0CH/yFcn/RmF9BEksj9/6RnBPi7uJQiXbkwILwzMR3OXyr/zmXcI8m8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733989345; c=relaxed/simple;
	bh=rCD7HbWLUQrQgP4B3ceMrIwrMMTWI8JTtKwqYWB9aGY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DeSWhgDy4MTRvWqN//FHM0Zy41iJdEurJwsVc1NU3rbKOXUkNTJ5r8dmhnTxM+Ynt9aymyEsnh2LTM34zdRRxLR7IIFOvBoX1zs+nEtm/k5y7aKPaA0XMAQ/VOUKlxjteinjj3L08LiInPQM7c0lN6WfVoQHYKatRHrkixX+O/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VmC93fNB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB21BC4CECE;
	Thu, 12 Dec 2024 07:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733989344;
	bh=rCD7HbWLUQrQgP4B3ceMrIwrMMTWI8JTtKwqYWB9aGY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VmC93fNBcQka8l9FaqgvK9jOcUGbt1ANuF+A7Gjw9GX/O0E2TpVelHwUUCayYE9o+
	 TNS30NKDZVkko8YTAMJ/XaC9MtzlfrTH/6ifuYGIZg3i8714ZdEI0TjUDqO+RCXpn8
	 ClG1+mVbPXDCW7hCBs62Tc789FA3mg5m9tLOa316bNCFfctP5s5m1EV3aCtMroQbHp
	 wA8V6lfRgF/sJhWDl8Nbqz0ow+d/BBuvqurtVPuD9rwYVLep/yW72yBgfB3YOhd6Uz
	 hnqXwD+fx6Zft7WYSb/Rro6qW/nIsihGc04oFiGhjWnESSbhOpgxbxf6KQCiCiW7QR
	 kdRnLWlcEtOYg==
Date: Thu, 12 Dec 2024 08:42:21 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Alexey Klimov <alexey.klimov@linaro.org>
Cc: broonie@kernel.org, konradybcio@kernel.org, 
	konrad.dybcio@oss.qualcomm.com, andersson@kernel.org, srinivas.kandagatla@linaro.org, 
	tiwai@suse.com, lgirdwood@gmail.com, perex@perex.cz, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, dmitry.baryshkov@linaro.org, 
	linux-sound@vger.kernel.org, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 04/14] arm64: dts: qcom: sm6115: add LPASS devices
Message-ID: <rl5c6nvo42o3ahqsspdv3aydro6gta6hxgkygnv5zhofschfr2@z7txze7ihizw>
References: <20241212004727.2903846-1-alexey.klimov@linaro.org>
 <20241212004727.2903846-5-alexey.klimov@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241212004727.2903846-5-alexey.klimov@linaro.org>

On Thu, Dec 12, 2024 at 12:47:17AM +0000, Alexey Klimov wrote:
> The rxmacro, txmacro, vamacro, soundwire nodes, lpass clock
> controllers are required to support audio playback and
> audio capture on sm6115 and its derivatives.
> 
> Cc: Konrad Dybcio <konradybcio@kernel.org>
> Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Co-developed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> Signed-off-by: Alexey Klimov <alexey.klimov@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sm6115.dtsi | 132 +++++++++++++++++++++++++++
>  1 file changed, 132 insertions(+)
> 

It does not look like you tested the DTS against bindings. Please run
'make dtbs_check W=1' (see
Documentation/devicetree/bindings/writing-schema.rst or
https://www.linaro.org/blog/tips-and-tricks-for-validating-devicetree-sources-with-the-devicetree-schema/
for instructions).

See also Rob's report. Rest looks good, but you must check the DTS which
did not happen here or happened insufficiently.

Best regards,
Krzysztof


