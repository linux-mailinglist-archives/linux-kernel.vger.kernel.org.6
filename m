Return-Path: <linux-kernel+bounces-575925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DCFFFA708F1
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 19:21:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1B6A3AB8C7
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 18:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61086199254;
	Tue, 25 Mar 2025 18:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hEnhZwo1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B28B618DB36;
	Tue, 25 Mar 2025 18:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742926879; cv=none; b=VlQdNtx+BeX44EAIK6xxAUZT6RgIBmWeEfvgr4RTEZ2X4AikLQcOiklkgLB3zcFnghBm11U8VF/905J/k82JfRTRp4CVuuhwKWba8+HMSKAY4QA4VzwPFEknyq4sSzGsPwDboFK8qw329cEYwFUA4rdQI2a5EfYFoDALOhXRn/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742926879; c=relaxed/simple;
	bh=mrqiPuMeH3Bzk+l9brzohImr4AuP1M10UqnJWbfgMbo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pF9KrXIYk7s9jBq9YlP8UEavghwVPYj625B5D5HqqNQ6kjD62ZvbfPbX7E7hH5JpF/h0hKeLyhAOuRTmKm6hbichxP+n9egSxemsug853cj11HWybaiFzmQcwEje73JbwKvxuS0PQxqJiZx217EcQGD1gAxfaL85ZYoaNy11ZX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hEnhZwo1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F313C4CEE4;
	Tue, 25 Mar 2025 18:21:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742926879;
	bh=mrqiPuMeH3Bzk+l9brzohImr4AuP1M10UqnJWbfgMbo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=hEnhZwo17O2rCjOGq7cAs0weKt+0+OAWjyguivCnV4oXdyrebrxDGKvzy1dgv3qOS
	 Dx9KLhi1tB9N1B9/50yBtc5AEYJ1vKD8RFKcLmtc+dydh/L0rod+8L8I/nvlmY4hBs
	 XDoNUbKJYwbHSvkOnRkzjidHey7wmdRfYzw17PRganh5wLQlG7puqvvq+E5lDkM1x1
	 5eQ35IJv4+T9xL3UxG0nAAlwnk5W4kidPbIXqoWt05XDk7M850PTUI544z/laAwnp4
	 aF5DgxkGx/AD0CnnaQo3oWUdqX+Q0momeoEcgAnmuY0llHI3I8j5eJAERKmAsOw7u3
	 LWTWPpZUx20Wg==
Message-ID: <7f13200d-9310-46a2-8424-51dcb0f2dbb7@kernel.org>
Date: Tue, 25 Mar 2025 19:21:09 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: display: panel: Add Visionox G2647FB105
To: Danila Tikhonov <danila@jiaxyga.com>
Cc: Alexander Baransky <sanyapilot496@gmail.com>, neil.armstrong@linaro.org,
 quic_jesszhan@quicinc.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
 robh@kernel.org, dri-devel@lists.freedesktop.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250325155756.703907-1-sanyapilot496@gmail.com>
 <20250325155756.703907-2-sanyapilot496@gmail.com>
 <ed62d5f3-a728-4d11-9b59-28496ed267db@kernel.org>
 <190ba70d-89bd-4e46-b7e5-7b93d706d84f@jiaxyga.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <190ba70d-89bd-4e46-b7e5-7b93d706d84f@jiaxyga.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 25/03/2025 19:16, Danila Tikhonov wrote:
>>> +  vsp-supply:
>>> +    description: Positive source voltage rail
>> Are you sure these are real voltage rails on the device? Weirdly similar
>> to some old Samsung AMOLED panels...
> Hello Krzysztof,
> 
> I was somewhat intrigued by your observation, especially since I have
> some schematics for this device. The patch correctly adds four
> regulators – ibb, lab, vdd (3p0), and vio (1p8).
> 
> This situation arises from Xiaomi’s tendency to use different panels in
> various revisions of the same device. Although, AFAIK, the
> sm7150-xiaomi-toco/tucana was released with only one possible variation
> (which this series adds), the sm7150-xiaomi-davinci offers a different
> perspective. The latter was initially produced with a samsung,ams639rq08
> panel (which I had added previously), yet official service centers have
> replaced the factory panel with the visionox,g1639fp106 during repairs.
> This suggests that, in terms of power configuration, the
> samsung,ams639rq08 and the visionox,g1639fp106 panels are effectively
> identical.
> 
> It is therefore likely that the visionox,g2647fb105 from this series
> follows the same way.
> 
> Nevertheless, it is reassuring that I can confirm these findings with
> the schematics rather than relying on mere guesswork xD

Great, appreciated, thanks for checking. Some parts of above -
similarities including replacement of factory panel - might be good for
commit msg. Please add them. With that and simplifying the commit
sentence style:

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

