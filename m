Return-Path: <linux-kernel+bounces-426977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E50B09DFACC
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 07:39:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB6732819B5
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 06:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06E4E1F8F12;
	Mon,  2 Dec 2024 06:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="YmCCzhv7"
Received: from mail-m12775.qiye.163.com (mail-m12775.qiye.163.com [115.236.127.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B482433F6;
	Mon,  2 Dec 2024 06:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.236.127.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733121590; cv=none; b=Qb1jEeBiE8nZQKyP83smKWDXb2cYiDhQ2a2luwFYyISgjrUemwFibCyXPOTNgLOJv4DqYK9zi6UgGGATXCWlXkfTxxsmO4DbpEyC9O7v77tiK3HjgevxNwp6efWpagPB9X2lQlyVbdZoDqMfud8j0Nq9zFLhJ4hEm03317ZS7wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733121590; c=relaxed/simple;
	bh=QF6bRx+38A/b4SJ3Hk5Wl9bwRWRZht6DkboFL4ATpb0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eqX8nR17E8X/RtXiLPIqVyr+/Oo/gq9/tpW4eqSfw+uRhqRr8ARmgHfNtigdtvYoFuIo9/2p9jdpspza10yeCCEFvn8FbH0RQfsk7HoUOVQc8oq1tGhu6KjwpEi70B6bpC5VIcCy5YYQuZQh9kVxSj2CKScIJQPHajzg38Rot0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=YmCCzhv7; arc=none smtp.client-ip=115.236.127.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from [172.16.12.26] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 461506be;
	Mon, 2 Dec 2024 10:03:42 +0800 (GMT+08:00)
Message-ID: <79421ac4-ffb5-4763-8ba7-cb7bd25c1c80@rock-chips.com>
Date: Mon, 2 Dec 2024 10:03:42 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 02/10] dt-bindings: display: rockchip: analogix-dp: Add
 support for RK3588
To: Krzysztof Kozlowski <krzk@kernel.org>, heiko@sntech.de
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 rfoss@kernel.org, vkoul@kernel.org, sebastian.reichel@collabora.com,
 cristian.ciocaltea@collabora.com, l.stach@pengutronix.de,
 andy.yan@rock-chips.com, hjc@rock-chips.com, algea.cao@rock-chips.com,
 kever.yang@rock-chips.com, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-phy@lists.infradead.org
References: <20241127075157.856029-1-damon.ding@rock-chips.com>
 <20241127075157.856029-3-damon.ding@rock-chips.com>
 <5d4bebf5-7954-4739-9cd4-93d78d337738@kernel.org>
Content-Language: en-US
From: Damon Ding <damon.ding@rock-chips.com>
In-Reply-To: <5d4bebf5-7954-4739-9cd4-93d78d337738@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGUxJGFYaHU9LSkNCTRoaSklWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSUhCSE
	NVSktLVUpCS0tZBg++
X-HM-Tid: 0a93851bf68803a3kunm461506be
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PRg6Izo*DzIYNxwXPDMOGEs*
	DTBPFBNVSlVKTEhISktOS0lPSElJVTMWGhIXVR8aFhQVVR8SFRw7CRQYEFYYExILCFUYFBZFWVdZ
	EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFMS043Bg++
DKIM-Signature:a=rsa-sha256;
	b=YmCCzhv7vginIZyrZcj/ecu0aLKtyt+uIpxiTMR1jogyL9BG3ZBbpB6ePDvB6dYxlsc4xGs49TbcG3qacO2l4tUp+wEuyrCqlkVpLbzEzmC1kV9vMcP9F9r9RBMwOtFXL2KEfuhnrjcgbE96xO251M5eyIn0ocPEiX1XEa6jrT0=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=Y241lptnwQ37OUoaH11vBxiTF8EY0NMjd3KnNF0LCj8=;
	h=date:mime-version:subject:message-id:from;

Hi Krzysztof,

On 2024/11/27 18:23, Krzysztof Kozlowski wrote:
> On 27/11/2024 08:51, Damon Ding wrote:
>> Add the compatible "rockchip,rk3588-edp".
> 
> This we see from the diff. Say something about hardware and why it is
> not compatible with existing variants.

In response to your kind suggestion, I will add more details in next 
version, specifically:

Compared with RK3288/RK3399, the HBR2 link rate support is the main
improvement of RK3588 eDP TX controller, and there are also two
independent eDP display interfaces on RK3588 Soc.

> 
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> 
> 
> Best regards,
> Krzysztof
> 
> 

Best regards,
Damon


