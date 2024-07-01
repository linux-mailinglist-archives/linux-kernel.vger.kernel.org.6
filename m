Return-Path: <linux-kernel+bounces-236117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6206191DDAF
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 13:17:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 922C71C22260
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 11:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6677313D61A;
	Mon,  1 Jul 2024 11:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B5N+/s2H"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8CAF42056;
	Mon,  1 Jul 2024 11:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719832619; cv=none; b=hLSnS0HP0JMXLqqe7VlsfWQTwwhYTR20TnKKUEvGEoGtKwtROw+8f8XyKoCV5TY4TTZ1mtaC4glZDuCE+YRzu4PujhXkW3vLJdK11IjxJbQm9g6GhmAncJi5Ah+e0wDffpTuiNMQaj46evmcMexTT8lHnhn+0iVJyUSoX4/OTQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719832619; c=relaxed/simple;
	bh=IIq106FRhxKo0ylTcA1LGbkhTM1asUnc9+K4Q74JN84=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ct41LLmBaUCI+cGCDEDIhp1btuyypgnXItXecloZsuYW39+9WZzMpftAtkUr8Z/HibkEarutgxZmdTg5wI5uK4oberGFa75t330dHetazrXZZ+Lo6LE5JCdrcNzjGWpuDSrdABAUJaT8Ob+WFmS5oRcVcjqNcuYIgDXPDUArJws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B5N+/s2H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADD43C116B1;
	Mon,  1 Jul 2024 11:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719832619;
	bh=IIq106FRhxKo0ylTcA1LGbkhTM1asUnc9+K4Q74JN84=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=B5N+/s2Hk25SwMvAC57LMtcc5mlNtZKLvw9z6eLk+v9Ie7FNMTsvd+w5E3zVMsmUA
	 8ttc/OFbhF2cNxn1KwIC6+tJRLG7WRoIAQPd/Oc4ZUZcrvS88jR4lLnt90N1rRrPW1
	 DD2g2mMZ7W1NqOl+8qF0JRdRoqZo36iElyHMnVeG+hoQmdNdiXSVlsGpX5hTfUwVeH
	 7vA/u/xZyOxrWtmQ40T82OG5rx4ZSp5vxRdLh+C5nF8Qhx+SdGQakr97BWH00KfCmg
	 m7Rt0xjq7hyxLARiPcsO9jrvQKy8IiPvrrb8vqx8X22cUYk/XvvWRof8CXDWsBeOgI
	 h/mGkZa1omsFw==
Message-ID: <731e4735-138c-4d00-aed1-9430b3146658@kernel.org>
Date: Mon, 1 Jul 2024 14:16:54 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: soc: ti: Move
 ti,j721e-system-controller.yaml to soc/ti
To: Lee Jones <lee@kernel.org>, Vignesh Raghavendra <vigneshr@ti.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Abraham I <kishon@kernel.org>,
 Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 Tero Kristo <kristo@kernel.org>, "Andrew F. Davis" <afd@ti.com>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240520-for-v6-11-j721e-syscon-v1-1-f57a93e12cad@kernel.org>
 <20240531135017.GL1005600@google.com>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20240531135017.GL1005600@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Vignesh,

On 31/05/2024 16:50, Lee Jones wrote:
> On Mon, 20 May 2024, Roger Quadros wrote:
> 
>> soc/ti is the more appropriate location for the system controller
>> device tree binding documentation so move there.
>>
>> Update Kishon's email address to a working one.
>>
>> Signed-off-by: Roger Quadros <rogerq@kernel.org>
>> ---
>>  .../bindings/{mfd => soc/ti}/ti,j721e-system-controller.yaml          | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> Acked-by: Lee Jones <lee@kernel.org>
> 

Can you please pick this via TI SoC tree? Thanks!

-- 
cheers,
-roger

