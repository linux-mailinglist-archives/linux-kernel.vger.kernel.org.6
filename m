Return-Path: <linux-kernel+bounces-331195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA29897A984
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 01:27:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98D1E1F22A13
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 23:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE367153598;
	Mon, 16 Sep 2024 23:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SqYtWNpW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 301D4145B0B;
	Mon, 16 Sep 2024 23:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726529220; cv=none; b=mE5Ngzh6nYqC4TXHToKl+G+2M82RNPBLCVdZ0WxTPOX4LW7VgRufmUx0oS5xAYZKci3H2U/JXRr2DaM+Dngf12tE39vJ3vlW+91JyXa0qWOJVkYQ+Iol9L/trvju7gqhxCgbk7q1ul53AF56ohOSKgxkTecEl7onBTWH4blaqFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726529220; c=relaxed/simple;
	bh=d9UEpU83x5hAG5oMvx4HxcrAGOkKGgQANVisyV8UGI8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BnXH7lm46UMxbN4nij49L/mB1kYC2Dhv2QZ6uxF0WuHOAwyQ/B9oLgMHqSoRf4sAWENwTqGqrt8iMxAKxCmBqqpotUO1mtE14j7O+lhYQPOgCHYl6JgHKpPd9sOHoB6G51CVN1SoAC/QVu6lMJEvBO2CCV6D1x5AS6P8gNY39Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SqYtWNpW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13A89C4CEC4;
	Mon, 16 Sep 2024 23:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726529219;
	bh=d9UEpU83x5hAG5oMvx4HxcrAGOkKGgQANVisyV8UGI8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=SqYtWNpWUVSHBdzHfFF//6C1+brsULRgPpUKjETvFj4vraaGw2aCwwLbh6Ei+plTj
	 bK02Q8DhvkxRslymdv/Y3pscVdgjI89OFN6aOjWvQnOjUPL8q6UVLI9ZcR1S88qQ6A
	 uiQc7Ow141IIoqccqUONlbKl+lLsaNIi+pgAwBXvjDwUuULVqUWZp49yctVCo6nMLW
	 mA0zVB31Ta4H/tZxlWFISn3r9Lc79n+ensJSulvSItS4zuRP4ClcXNDjgVQm2XuMUX
	 hv0MUI0+U/cNqHVW+ZOff08pxtTvAOj97rlZ4wFAe2mla6rgBKyXp2EuUu4GUSCrKh
	 Hn6GnXQk6EFAw==
Message-ID: <f736f02e-f19b-4be2-86ad-73d6ae7c6dc2@kernel.org>
Date: Tue, 17 Sep 2024 01:26:45 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] dt-bindings: phy: Add eDP PHY compatible for
 sa8775p
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Krzysztof Kozlowski <krzk@kernel.org>
Cc: Soutrik Mukhopadhyay <quic_mukhopad@quicinc.com>, vkoul@kernel.org,
 kishon@kernel.org, konradybcio@kernel.org, andersson@kernel.org,
 simona@ffwll.ch, abel.vesa@linaro.org, robdclark@gmail.com,
 quic_abhinavk@quicinc.com, sean@poorly.run, marijn.suijten@somainline.org,
 airlied@gmail.com, daniel@ffwll.ch, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, quic_khsieh@quicinc.com,
 konrad.dybcio@linaro.org, quic_parellan@quicinc.com,
 quic_bjorande@quicinc.com, linux-arm-msm@vger.kernel.org,
 linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 devicetree@vger.kernel.org, quic_riteshk@quicinc.com,
 quic_vproddut@quicinc.com
References: <20240913103755.7290-1-quic_mukhopad@quicinc.com>
 <20240913103755.7290-2-quic_mukhopad@quicinc.com>
 <2hv2hcpbanduw4wg2wbza4jkze4sgilrtyc7zack23uygwsjol@ckskl2rkd5xp>
 <t4ytnii3sdiqsni74d7qsi2c6uv2klwmzmgznnirt2z55to4hj@lyaoh5fzcyti>
Content-Language: en-US
From: Konrad Dybcio <konradybcio@kernel.org>
In-Reply-To: <t4ytnii3sdiqsni74d7qsi2c6uv2klwmzmgznnirt2z55to4hj@lyaoh5fzcyti>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 16.09.2024 10:33 PM, Dmitry Baryshkov wrote:
> On Mon, Sep 16, 2024 at 05:23:55PM GMT, Krzysztof Kozlowski wrote:
>> On Fri, Sep 13, 2024 at 04:07:51PM +0530, Soutrik Mukhopadhyay wrote:
>>> Add compatible string for the supported eDP PHY on sa8775p platform.
>>>
>>> Signed-off-by: Soutrik Mukhopadhyay <quic_mukhopad@quicinc.com>
>>> ---
>>> v2: No change
>>>  
>>
>> Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
> 
> So, is it reviewed or acked?

After a thorough review, it has been acked

Konrad

