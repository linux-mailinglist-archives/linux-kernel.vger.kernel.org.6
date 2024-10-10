Return-Path: <linux-kernel+bounces-359434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 726A3998B5D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 17:24:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13F862862EB
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 15:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 003231CC89F;
	Thu, 10 Oct 2024 15:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="fgeC9S65"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F61B1CC146;
	Thu, 10 Oct 2024 15:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728573841; cv=none; b=nORb31QaT/6Ccth+1lkdTT8K3JmUCrNcZOt2KHhZUppVs1ZmcojYrm0ywSsiCNXBygJmY7GtkaBeSRttgjBirS80Us5spKZaXsvzfdOWu02P41/QvXI6VN8x2OLUKCFiyj7ytlQ3Zqu95OLOIRvOs+RjARHJEruLCCtpUnmVgRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728573841; c=relaxed/simple;
	bh=V19b+VCEs2Bs0LJtMPPUzPAihCMgMEquXW2T6zeTyG0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=klrSU2o5m3KnuWwFhqD52AuYLU9q9HMaq+b2ZEifQbJmKl+SdQK2p8nk83sTGGFE9pJL864auGjuHttOQ+UEQc5zRzrzZsiG0fXJSciZ97T0UM1xFUAN1rbCiVvK/3Bg6qnDY/VKlS3IywnlVMx1W9qRnHSI0Z6uJsVChXynfYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=fgeC9S65; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4D03F1C0007;
	Thu, 10 Oct 2024 15:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1728573837;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7g+xGPfmPtCVDE9/xOLezbAJ5PFRDtUwPFyP2N7f7H4=;
	b=fgeC9S65MDOezx4kw/I8xvjGqVf75HS8eJ720599rICrC2/T5ED7OzZcfP9mCAJkzdQh6I
	mi3SWrzuD3dtS2fbHm9Nq2eGko4IpJ9Q3gJ70tvC0moYWQKms2Ubks9XdqrydtFcYpZLhc
	YXMIl8q4KprrZz4a5HXoUZXzijQWaKRR3d+R/g1pB6cilen8oox5Jrar//ycffIs4RjzhI
	bHq8MbSWHZic4BNH1iRV0GawpScgW7Ou0i8hghzESz9mVDjb8bweKnK6M8FKgKv5BZCxLU
	HCn5Q2AYGtqvWhl3EENgwntFRpXZrE8lJFx1EP+TIh7tv3WAJ/X2C3GzBmEgYA==
Message-ID: <d7b32bed-2078-4f5b-80c6-681b7d67302a@bootlin.com>
Date: Thu, 10 Oct 2024 17:23:55 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/2] riscv: dts: sophgo: Add initial SG2002 SoC device
 tree
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Paul Walmsley
 <paul.walmsley@sifive.com>, Chen Wang <unicorn_wang@outlook.com>,
 Inochi Amaoto <inochiama@outlook.com>, Chao Wei <chao.wei@sophgo.com>,
 Conor Dooley <conor@kernel.org>
Cc: Albert Ou <aou@eecs.berkeley.edu>, Palmer Dabbelt <palmer@dabbelt.com>,
 Samuel Holland <samuel.holland@sifive.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 =?UTF-8?Q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-riscv@lists.infradead.org
References: <20241010-sg2002-v5-0-a0f2e582b932@bootlin.com>
 <20241010-sg2002-v5-1-a0f2e582b932@bootlin.com>
Content-Language: en-US
From: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
In-Reply-To: <20241010-sg2002-v5-1-a0f2e582b932@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: thomas.bonnefille@bootlin.com

Hello, sorry for the double email.

On 10/10/24 5:07 PM, Thomas Bonnefille wrote:
> Add initial device tree for the SG2002 RISC-V SoC by SOPHGO.
> 
> Signed-off-by: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
> ---
> The commit adding the bindings for the compatible "sophgo,sg2002-clint"
> has been applied to Daniel Lezcano git tree. This commit may trigger the
> bots because of this missing binding.
> ---

I wanted to say, that the comment above is no longer relevant because 
Daniel Lezcano's branch was applied in 6.11.

Best regards,
Thomas

