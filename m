Return-Path: <linux-kernel+bounces-359990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A925999934A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 22:02:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60452283A97
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 20:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DEB21CF2B3;
	Thu, 10 Oct 2024 20:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eSJIRR/w"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A07B19D880;
	Thu, 10 Oct 2024 20:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728590550; cv=none; b=N47g6bNygkKjGU2Ls2m8eScZmxOHYMYL/kAxrFSknOh1leiTA3gfSpLaidFls7yCe89hSvx1t8P1PEiPEFJYXzl9OogtxUq2VotlcHZ7JhsCRpUR9LfZgBe7GPf5YJ6xwG8AtOuo7ZCiYBDXGSWjx9c79f0Rk2cmM0c5gjCfRO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728590550; c=relaxed/simple;
	bh=7wPrTtsLkty6XranwcnE7EH4rlE8VJy3bj43pTwsgl0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lL2DRQt3wYObaQs+0XJfyKN3PeKS8luAMxvXSiTosjul8PHNT6LgmGF5sztQBl4HS2bOs2prPdWlArhx8C9US34jklOMncjkGSgeL35q13tNJGV7f/AMKPpN+z+dHf4LTFylDSkfnoD7BVa+xjiV0bw1Gv6izk+CLf4ZhKpoRBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eSJIRR/w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2E29C4CEC5;
	Thu, 10 Oct 2024 20:02:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728590550;
	bh=7wPrTtsLkty6XranwcnE7EH4rlE8VJy3bj43pTwsgl0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=eSJIRR/wtL/RBZODj1yinpN0k8Ewxvje6X3eZu80JS5hxa/KMKrv5N8FVA+mZ0nwH
	 AdCq3Wb3aoZxHbUY0cw3Q5T1iaH2YE7ej7gN+hpf88LN5SXHlbhgKGh3wcZjxt8rWa
	 koq9zmGEsYCkuo5tsZEgDhBczYWjZwRthaBW1EXzvXAEjV3IlryJLwBQKxSMeZJpHg
	 ixZbvVX58rypavCAYT/2izcUqUDIWYfzMwnHCDxPk7zyFnMUsgmmPsOo0yuzIspfhF
	 eX3Sm+lJRKL4myQdJsPI/YU609NFWLhpwVf6ncIQWZhmNrorQzJLo7ItsSHcAZf9qq
	 8bVasW6K6V5Uw==
Message-ID: <08cf2309-4332-48a0-a04e-db7e933dfc12@kernel.org>
Date: Thu, 10 Oct 2024 23:02:24 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: ethernet: ti: am65-cpsw: Enable USXGMII
 mode for J7200 CPSW5G
To: Siddharth Vadapalli <s-vadapalli@ti.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 dan.carpenter@linaro.org, jpanis@baylibre.com, u.kleine-koenig@baylibre.com,
 c-vankar@ti.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, srk@ti.com
References: <20241010150543.2620448-1-s-vadapalli@ti.com>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20241010150543.2620448-1-s-vadapalli@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/10/2024 18:05, Siddharth Vadapalli wrote:
> TI's J7200 SoC supports USXGMII mode. Add USXGMII mode to the
> extra_modes member of the J7200 SoC data.
> 
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>

Reviewed-by: Roger Quadros <rogerq@kernel.org>

