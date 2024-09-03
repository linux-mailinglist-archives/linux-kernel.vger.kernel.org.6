Return-Path: <linux-kernel+bounces-312247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C8FA9693FE
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 08:44:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF5921C22E9A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 06:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 925551D61A1;
	Tue,  3 Sep 2024 06:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KwpyAA4U"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD041D6186;
	Tue,  3 Sep 2024 06:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725345849; cv=none; b=E/Rb6dlDPByAEhYQMicZiQIGfqVtwP1hDh5DMZ4bvAOY+BOGFbeiGVrokNSZCqwpYlVCy2heTFJ33xVM5BtywxspztGuWzdlBRvjcHHxHO2/gtY4eenUOELHhkVoY7RnKiNGAmbg8SjpoQsilAjzGMByoLFjaV9IcFHGwOw9Uyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725345849; c=relaxed/simple;
	bh=y+qVchVRj2J0kurjqFF3Kzdqtrymg26dJqbZeQt5kvw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pRHQ/dKxgaWNDnnq2pBsMaqDRxvwsJv42IsLt2T99OovlgzKCTFalview1UAdCfXx8aEXc4bv6dK1JlX8PQ9/ADKTA9j1coy+UmTcAG3zvPAlUVgfaouG8w4eUoeg6cp01g4ZnnYZGUVr4ZE8lBOQ5xQzYXfnFEvVmKO3Fp9UXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KwpyAA4U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0498C4CEC5;
	Tue,  3 Sep 2024 06:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725345848;
	bh=y+qVchVRj2J0kurjqFF3Kzdqtrymg26dJqbZeQt5kvw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=KwpyAA4U7s4FyZ4JYwp7GY20eFDluiIC6+6NseD68NxdpMKhO0aTDVpjNFIrDHgma
	 q1e+K+1vxDMluzb+7idcch0rjCQxGhc2AdJr1g1Nx/AJcJkM4xAEalQyLv0BFN7TWr
	 A5Gx7wEV7FqaiXOl9Fp1xZUpwvh1qByTMawRS03WF6SlJFOgvf5NbV3ntJouROYcnc
	 NnDuASkCmu/gmKBL4MivVSuiyG6XoQgKgjmjYEVQKfCGJjaHJ6WhcKKsvgPO5Gps14
	 nyC2JI2WyZQw/63VLF9xSr6No9DKX9pJq3W+mlvyExKitS3JhSBqyyi1032vyJpgA+
	 z6Z51T8o5wSqg==
Message-ID: <f5a1d0bd-59d6-45cc-9e8e-0e665e7fbe65@kernel.org>
Date: Tue, 3 Sep 2024 09:44:02 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: mtd: ti, gpmc-nand: support partitions node
To: Miquel Raynal <miquel.raynal@bootlin.com>, Rob Herring <robh@kernel.org>
Cc: Richard Weinberger <richard@nod.at>, Vignesh Raghavendra
 <vigneshr@ti.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Tony Lindgren <tony@atomide.com>,
 Nishanth Menon <nm@ti.com>, srk@ti.com, linux-mtd@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240830-gpmc-dtb-v1-1-792cac1ef3cc@kernel.org>
 <20240830174302.GA551760-robh@kernel.org> <20240902161545.3ca266de@xps-13>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20240902161545.3ca266de@xps-13>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 02/09/2024 17:15, Miquel Raynal wrote:
> Hi,
> 
>>> +  partitions:
>>> +    type: object
>>> +    description:
>>> +      Node containing description of fixed partitions.
>>> +
>>>  patternProperties:
>>>    "@[0-9a-f]+$":
>>>      $ref: /schemas/mtd/partitions/partition.yaml  
>>
>> This and the addition should be replaced with a mtd.yaml reference.
> 
> Yes, indeed.

Thanks. Will revise and send v2.

-- 
cheers,
-roger

