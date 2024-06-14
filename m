Return-Path: <linux-kernel+bounces-215020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FF67908D54
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 16:24:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52B791F21AAD
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 14:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE166DDAA;
	Fri, 14 Jun 2024 14:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HHAC2UmY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED9EE8F6A;
	Fri, 14 Jun 2024 14:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718375009; cv=none; b=gZ4siKE/fWkFBLOr7bde2imsgyWKmSEkA45hCKDSfrhiGVZ6Fhzx7UHRPRPp4V6boe0DkWDkuazlKYGtLKhJ5tmDj2OB59/70XvwLibdUrlJEr3jGHaZkfEcVBkM971Ky/3kDDZ7wD2Ao4hy3anP8IJ3zp8QkLkNOGLLyjctSq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718375009; c=relaxed/simple;
	bh=AFnUDwO0gqdy9MNOQgd5uFUXhZnf4abeUlVCfYuqKRM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hB1OtwGhuWlSwN6FVVr+21c1NFNfMtrhOtKdSexcWnan+HR/I14sXJUMB6Cd+OprrhqZxZ9T7z6BHsgGc/1+2AC4AX7qzQwgaPbU+D9oZhSfhpidrigltp5g6NfDqy2fX0mynGK0r9z8Baqzs5xwd7L7Nz+CpILPhV7/dpw4dqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HHAC2UmY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F389C2BD10;
	Fri, 14 Jun 2024 14:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718375008;
	bh=AFnUDwO0gqdy9MNOQgd5uFUXhZnf4abeUlVCfYuqKRM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=HHAC2UmYdJJmbrvwzgR808Zub9i4FaKr+ST0LF/vcBkBesNHOoEtfa446mxMUhzcm
	 EIV8UQ7ferdvOJJT/jYrzr2qUtu3A92yMCxWFcXuVMLo8z94yETwD/8xlbozsiMnre
	 kpEhxOoCEmNQ4eBa9aZdeqqB/HUH3AXL5I9hydSw8l1+426Bbek0azx4d1tq+jY5Gg
	 P1HTBH+UQokUfXWKWB3/zP649bjDdyButQYoxAyH4yQf0WW27CU4AAKJQKl3ESomsu
	 U0t53Si0tjr7WPskqfP8RXZey86ExuTxBXAIy+r9L+CUxAS+vqB5+H8U5q3LKfBGSU
	 5P9/j3EJDGG+A==
Message-ID: <e73ca078-9333-4b8e-92af-1c0d7d017632@kernel.org>
Date: Fri, 14 Jun 2024 17:23:23 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: soc: ti: Move
 ti,j721e-system-controller.yaml to soc/ti
To: Lee Jones <lee@kernel.org>
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

Hi Vignesh & Nishanth,

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

Would you be picking this up via TI/SoC tree please?

-- 
cheers,
-roger

