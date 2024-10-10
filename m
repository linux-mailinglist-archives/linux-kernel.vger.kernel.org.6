Return-Path: <linux-kernel+bounces-358140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BF6D997A9F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 04:38:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7E271C21791
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 02:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 216E116F0E8;
	Thu, 10 Oct 2024 02:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tr4IhFG5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1D738DD3;
	Thu, 10 Oct 2024 02:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728527925; cv=none; b=ZH2hut8XMW3eWYTXiYyYescjH1oETh2h1vAwE6hQ9JGOBqr6WK6nEphWEhw2kSu/8ZqMoU2UjmA76nlCWodob36ojpF0pa3WNwR+qHhT4rAiB+iC7DS7f7mYvi8Kzlj92q0xiZv5WqwHAfeR+rH565Zyk+OXFDIgQn0IAeSpvw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728527925; c=relaxed/simple;
	bh=XSqV1wjym/BTCByLYqeAc8YnSkVJbWfKB90sYm5ZI6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZEieOcYMSVZC71vq19EezrAy++ZJ7Vb/8uNly/PbLW9UpzG7J15wE2cZOqgUyt03T1wwCw5K7r+FALouN9N5xmsSISpxeeJeYgBxheAACG6f5dije1bNiZeo4rMjP93h+Cc/bK7ZbIKmlfQuJ3L7RQezB+7Lng//Ec/bZz93cSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tr4IhFG5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB315C4CECD;
	Thu, 10 Oct 2024 02:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728527925;
	bh=XSqV1wjym/BTCByLYqeAc8YnSkVJbWfKB90sYm5ZI6Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Tr4IhFG5Il4IDdo8ruej3COzjOfe4HCbPvg8KUuVBKDg5wjsme33eoLyr92sskJNl
	 YxLW0JlKY9HMHREtxElrUYtRkC/0jzw4QZNr/EaYb3cBtpOe+9lQ5i5VHCnRRkUN4i
	 PZTOLQjWBXan9zDFu7ACxtgcK+AuubT3J0eBrP+IUO+to4ip60quEjvJQHq+6mAPNa
	 hB1d3L6TJXtHntA12oZnh5+1frnOy1n0pEjvIwASM+y8/e/QE884DHwbvD6SlPSMFM
	 WqVq503RWkU3gymFVcwN1Px5hVJ3FiwWayZWriSR8e+bY/dVaaT/r7dISPoUdceXlG
	 ZO8E1ENZPnjNQ==
Date: Wed, 9 Oct 2024 21:38:44 -0500
From: Rob Herring <robh@kernel.org>
To: Sam Edwards <cfsworks@gmail.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	=?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
	William Zhang <william.zhang@broadcom.com>,
	Anand Gore <anand.gore@broadcom.com>,
	Kursad Oney <kursad.oney@broadcom.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: mtd: Relax BCM4908 partition schema
Message-ID: <20241010023844.GA968160-robh@kernel.org>
References: <20241009215046.1449389-1-CFSworks@gmail.com>
 <20241009215046.1449389-2-CFSworks@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241009215046.1449389-2-CFSworks@gmail.com>

On Wed, Oct 09, 2024 at 02:50:44PM -0700, Sam Edwards wrote:
> The BCM4908 partition "parser" is really just a fixed partitions table,
> with a special partition compatible (`brcm,bcm4908-firmware`) that
> automatically labels the partition as "firmware" or "backup" depending
> on what CFE is communicating as the selected active partition.
> 
> The bcm4908-partitions schema is currently too restrictive, requiring
> that all child nodes use this special compatible or none at all. This
> not only contracits what is allowed by the "parser" but also causes
> warnings for an existing file ("bcm4908-asus-gt-ac5300.dts").
> 
> Modify the schema to be strict only for child partitions that use the
> -firmware compatible. Also update the child name regex to agree with
> fixed-partitions, so that these differences apply consistently.
> 
> Signed-off-by: Sam Edwards <CFSworks@gmail.com>
> ---
>  .../mtd/partitions/brcm,bcm4908-partitions.yaml | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mtd/partitions/brcm,bcm4908-partitions.yaml b/Documentation/devicetree/bindings/mtd/partitions/brcm,bcm4908-partitions.yaml
> index 94f0742b375c..aed37922a5fc 100644
> --- a/Documentation/devicetree/bindings/mtd/partitions/brcm,bcm4908-partitions.yaml
> +++ b/Documentation/devicetree/bindings/mtd/partitions/brcm,bcm4908-partitions.yaml
> @@ -30,12 +30,17 @@ properties:
>      enum: [ 1, 2 ]
>  
>  patternProperties:
> -  "^partition@[0-9a-f]+$":
> -    $ref: partition.yaml#
> -    properties:
> -      compatible:
> -        const: brcm,bcm4908-firmware
> -    unevaluatedProperties: false
> +  "^partition(-.+|@[0-9a-f]+)$":
> +    type: object
> +    if:
> +      properties:
> +        compatible:
> +          const: brcm,bcm4908-firmware

What schema applies to the node if this is not true? That needs to be 
addressed. You should be able to use oneOf here rather than if/then 
schema.

> +    then:
> +      $ref: partition.yaml#
> +      properties:
> +        compatible: true
> +      unevaluatedProperties: false
>  
>  required:
>    - "#address-cells"
> -- 
> 2.44.2
> 

