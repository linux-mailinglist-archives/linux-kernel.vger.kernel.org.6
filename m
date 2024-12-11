Return-Path: <linux-kernel+bounces-441048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBB0E9EC8AA
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 10:16:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D9C91885858
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 09:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C36A51FF1A1;
	Wed, 11 Dec 2024 09:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="OGH+62Ob"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15921207A3F;
	Wed, 11 Dec 2024 09:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733908582; cv=none; b=svc3qSMiduR3EPBSc0K04zyixt79+P9wxC57TbfK8AZCyiUXDggWuYNzTfQSmW59ryUodU75IiJIJUUbZsfeEbx4XyXqynK45q+dnLrJwVcGEDr6m4QDpOmNToBZhC4pbIr6DRnUonemfZ7lzj43yLdmBu69/1vwXWY+rEF970I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733908582; c=relaxed/simple;
	bh=Pbr8TFnAH68Uxd3BnYtQuKKBAuRerzWhYOPBr/hv+kI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f4jOqu1OptYQmbdMq8Rap4CoNWcx/P+v7KEzseXUDYtOialGTbCm3BwFTCTlolIGb+JtOYwmaFLK0WRJ+5hJ7ByoVcviO4fz8n/wxsvO4iiP+Hi3N5rwEOkmlBJp664UMy0VR61HZdPyl49KG7frAJ/KWsTX8aJQBPxVSBAz/O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=OGH+62Ob; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1733908575;
	bh=Pbr8TFnAH68Uxd3BnYtQuKKBAuRerzWhYOPBr/hv+kI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=OGH+62ObJppBdxcPFolFdTnI9ixx/WRUjU6WB3rUcDMneG/sUIK7N55TJ6AkuBQS5
	 tlDAI5hnXQdgtmMlDnP6UJHk1SA5LoyUJCROujtY4S4NNQ/PwYklz8Hgsp/ufsQcer
	 WwqA/gQDa7TzXEGECnjEAG2Toq35f5jZtuqzhlzfqOfk1rnrU9CaAeTBlq4lCk2Ghj
	 AWp2DkhXbKO9yeBWi99t13YGayFkL+qqNhVYGhE7hqSLlqVuNlUx85ex6UuDT3N+WE
	 Cuuur/HxdxyI/MyRtKYQgkNu7iPVq5YNyLWhAQ80DGjVgB5PlgQS+loZpNno/7n8+t
	 WBLnqLjYI8iIA==
Received: from [192.168.1.90] (unknown [188.27.48.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 21E4A17E35CF;
	Wed, 11 Dec 2024 10:16:15 +0100 (CET)
Message-ID: <43ae0fc5-d775-49d7-80cd-af111ff8fb25@collabora.com>
Date: Wed, 11 Dec 2024 11:16:14 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] Add support for HDMI1 output on RK3588 SoC
To: =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
 Sandy Huang <hjc@rock-chips.com>, Andy Yan <andy.yan@rock-chips.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: Alexandre ARNOUD <aarnoud@me.com>, kernel@collabora.com,
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20241211-rk3588-hdmi1-v2-0-02cdca22ff68@collabora.com>
 <12942826.iMDcRRXYNz@diego>
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Content-Language: en-US
In-Reply-To: <12942826.iMDcRRXYNz@diego>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Heiko,

On 12/11/24 10:46 AM, Heiko Stübner wrote:
> Hi Cristian,
> 
> Am Mittwoch, 11. Dezember 2024, 00:06:13 CET schrieb Cristian Ciocaltea:
>> The patches provide the basic support to handle the second HDMI output
>> port found on Rockchip RK3588 SoC.
>>
>> For now I enabled it on Radxa ROCK 5B only, the board I've been using to
>> validate this.
>>
>> ** IMPORTANT **
>>
>> The series has a runtime dependency on "phy: phy-rockchip-samsung-hdptx:
>> Don't use dt aliases to determine phy-id", a patch submitted recently by
>> Heiko [1].  Without applying it, the functionality on both HDMI TX ports
>> will break.
> 
> Looking at the drm/rockchip patch, that should not cause disruptions on
> its own, right?
> 
> Only with the dts-parts enabled would we run into phy-issue.
> (Asking, because things go through different trees and the drm
> part looks ready)

That's right, I should have better explained this - all patches except
the last one (that is actually enabling HDMI1 on a specific board) can
be safely applied.

Thanks,
Cristian

