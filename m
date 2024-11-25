Return-Path: <linux-kernel+bounces-421199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECC3B9D880E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 15:32:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D5D1B2FC8E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 14:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9AD51AF0DB;
	Mon, 25 Nov 2024 14:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marcan.st header.i=@marcan.st header.b="fLZCQyIu"
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE171AF0D5;
	Mon, 25 Nov 2024 14:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.63.210.85
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732544672; cv=none; b=GLu/FgZABD1l/Bga/ZiLa0rYwy/tLfbVDWfO6PQ4APhuTjWhtnL9UprOGcVvppATYYSQgWbkOxK7t5Jz6ZyhI+RZba86sbVZah8cLe7byE3lO3h8SFnjtyOQu4obJgQ+EPPesaE8t2gx+PXxnNwvV3mbvusnkvx0qeho0iK8BZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732544672; c=relaxed/simple;
	bh=UOUHyrClhYT8RMtkXeGlDQvph3N1LZNwe8gDlfAlzfE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D3SRinMtw51rCA6PDndYD5bPrqbyxAP80U5Mpz0RgprT3ANABUxCBTkQFPbw7lCIZxnpNaKe45i/LVRGAQXUhIsTkUSqN5+Zk5Vq4yxNNE55Fil3y++DmGKt0bkn/oEEClm9Wigz+lnj7aOwTlTyUUkQufRODndanLM1OV54KKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marcan.st; spf=pass smtp.mailfrom=marcan.st; dkim=pass (2048-bit key) header.d=marcan.st header.i=@marcan.st header.b=fLZCQyIu; arc=none smtp.client-ip=212.63.210.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marcan.st
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marcan.st
Received: from [127.0.0.1] (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: marcan@marcan.st)
	by mail.marcansoft.com (Postfix) with ESMTPSA id 47E7B3FB17;
	Mon, 25 Nov 2024 14:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
	t=1732544668; bh=UOUHyrClhYT8RMtkXeGlDQvph3N1LZNwe8gDlfAlzfE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=fLZCQyIusdh8e3SDTyI7LVc9rrmfiYWSfLv9s4zriOfmK4DmNv28JPSPDsFupZtce
	 6ZszlADBdGrZQtZylk5LMQwlNqhQep3WDSIkRQpOs8AePl9hEjo1XZ9AfO/pTyJIc5
	 sbvS+3IqCZ/w+BRUu58iIGk0n5KFs1DZseO97HwvrNm4KCt+HGjADIJgbB+AGnNPlr
	 2u8j6YfRNeYYwntaCe/CmFBM7A0OCib9Dxz/JryeBK9jXCR6QNDb73NSwrJX8HbGG3
	 fKv9aTxY41oEg970X1MluDPuMTjCzgZzWeV83pV9Un/mllsYKboYyPTa+YhVQ825Tq
	 MGJSvWD4BUnKA==
Message-ID: <cc71021e-b53d-4eda-bad8-abb4df13575f@marcan.st>
Date: Mon, 25 Nov 2024 23:24:25 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] gpu: drm: adp: Add Apple Display Pipe driver
To: Sasha Finkelstein <fnkl.kernel@gmail.com>, neil.armstrong@linaro.org
Cc: Sven Peter <sven@svenpeter.dev>, Alyssa Rosenzweig
 <alyssa@rosenzweig.io>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jessica Zhang <quic_jesszhan@quicinc.com>,
 asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Janne Grunau <j@jannau.net>
References: <20241124-adpdrm-v1-0-3191d8e6e49a@gmail.com>
 <20241124-adpdrm-v1-2-3191d8e6e49a@gmail.com>
 <10d0aa88-de2e-4856-a137-301519e58b2d@linaro.org>
 <CAMT+MTRWZWj=3AP7wyooXr49-W4vcm0ZbAoqPyEuNkQBMOaJfw@mail.gmail.com>
From: Hector Martin <marcan@marcan.st>
Content-Language: en-US
In-Reply-To: <CAMT+MTRWZWj=3AP7wyooXr49-W4vcm0ZbAoqPyEuNkQBMOaJfw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024/11/25 20:24, Sasha Finkelstein wrote:
> On Mon, 25 Nov 2024 at 09:50, Neil Armstrong <neil.armstrong@linaro.org> wrote:
>>
>> So this controller only supports a single mode ???????
>>
> Most likely. On all devices it is connected to a single built-in display.

More specifically, the controller obviously supports multiple modes but
it is pre-initialized by the bootloader for the single hardwired
display's only mode. So as far as the driver is concerned, there is a
single possible mode, and there's no point in trying to be more generic
if there is no hardware that would use that.

In general, it is not possible/practical to be generic for reverse
engineered hardware with no specs documenting how to drive it
generically. You just can't know how to implement the options that are
never used in practice. I spent a lot of time on exceptions to this rule
for the GPIO and SPI controllers, and that's not going to happen for
more complex hardware like MIPI DSI.

- Hector


