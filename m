Return-Path: <linux-kernel+bounces-439007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD1989EA973
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 08:22:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1401188B079
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 07:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12FDE1FCCE6;
	Tue, 10 Dec 2024 07:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de header.b="tcYaTV8X"
Received: from mail.fris.de (mail.fris.de [116.203.77.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ADF422CBDF
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 07:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.77.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733815322; cv=none; b=CM+6Zbz8nnz81xwj6SSotYx64nlehqGOLePnoja1ffScLKGf6nP2cNUyKdQU6t6KiTOJHBeaMOEhwUtHc8cOpmfIUITMT6hWu5bNJYafCxZwb/t/U/AbQRDpchHwXxmyHJC3FuAJq3+w99vT/KD1dC0s5lz+gNYG5oJSqLmgT8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733815322; c=relaxed/simple;
	bh=a2gwzyeeP2hbQ+noqP/Y5UOI7J0J0iey6F3DlAkHQWs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IFvoIAq0yQafCKh2CirJDiUp7bvO67Lf7O6SeBl22gNr7rwQGjFdlrQA/MdUjtDfp2v1FPen+QkJMYWy3dgsb+7+rD7fAg0waiHrS7NG3/5sgtZqR7mlDizgb6Bq+zn8wvur9Wmhong0AxNKCwM9s8htL42T0jzCCJrEAwNkJHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fris.de; spf=pass smtp.mailfrom=fris.de; dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de header.b=tcYaTV8X; arc=none smtp.client-ip=116.203.77.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fris.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 127F6BFB36;
	Tue, 10 Dec 2024 08:15:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
	t=1733814933; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=mst8N9oqCKySqnU14m4tKZ3IBxjBlOpj8ZD3Z0xTpkY=;
	b=tcYaTV8XX827uzNpFpLkA5VE1o1llHp4vnuewxCPdt0GlIK9rV1BrFbwIJCZ6lbft/lpao
	7DREbmD3D2at69gkzTFMc/tK+qHfrAAoshlcKC0U7hNBDG1pAXkqNJ/xeU/mTqkNNnI/ek
	EOYc1lqLmkJ167mfUYVJyvwotanNEhoK1uAoIZ00wxm4eymBcOc5CAd3lXVxrhq2Ol4G+8
	+6eUJfaPIWSwWIGd9ghAB/tKJkaAlAGpWEzNalcgj9LzGxwmRPXx8IKjkYQwE9ALx7rpLU
	5vpNsEptKe2P5xlC/nLnnfixzIRwOfISrj3zS9zLH0S7Oufdbh8mb25Ux2TR4A==
Message-ID: <0a0af9f8-2903-4852-85ea-117410df595d@fris.de>
Date: Tue, 10 Dec 2024 08:15:28 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Extending PLL LUT for i.MX8MP Samsung HDMI PHY
To: Kishon Vijay Abraham I <kishon@kernel.org>, linux-kernel@vger.kernel.org,
 linux-phy@lists.infradead.org, Vinod Koul <vkoul@kernel.org>
Cc: Dominique Martinet <dominique.martinet@atmark-techno.com>,
 Adam Ford <aford173@gmail.com>, Lucas Stach <l.stach@pengutronix.de>,
 Marco Felsch <m.felsch@pengutronix.de>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
References: <20240910181544.214797-1-frieder@fris.de>
Content-Language: en-GB, de-DE
From: Frieder Schrempf <frieder@fris.de>
In-Reply-To: <20240910181544.214797-1-frieder@fris.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On 10.09.24 20:14, Frieder Schrempf wrote:
> This small series depends on Adam's series here [1].
> 
> The parameters have been determined using the script here [2] and validated by
> trying the modes on a Kontron BL i.MX8MP with a HDMI USB grabber.
> 
> [1] https://patchwork.kernel.org/project/linux-phy/cover/20240904233100.114611-1-aford173@gmail.com/
> [2] https://codeberg.org/fschrempf/samsung-hdmi-phy-pll-calculator/src/branch/main/pll.py
> 
> Frieder Schrempf (2):
>    phy: freescale: fsl-samsung-hdmi: Add references for calculating LUT
>      parameters to comment
>    phy: freescale: fsl-samsung-hdmi: Add PLL LUT entries for some
>      non-CEA-861 modes
> 
>   drivers/phy/freescale/phy-fsl-samsung-hdmi.c | 17 ++++++++++++++++-
>   1 file changed, 16 insertions(+), 1 deletion(-)

I want to kindly ask if there is any further feedback for this?

Thanks
Frieder

