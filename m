Return-Path: <linux-kernel+bounces-236834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B0BA791E7A5
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 20:33:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65F8B1F230A9
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 18:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B369170826;
	Mon,  1 Jul 2024 18:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GounTX21"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1BA16F0E7;
	Mon,  1 Jul 2024 18:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719858666; cv=none; b=FPeUKDScmbhbocTBnQx837kwMZevXZ5E78Ky9+wDpd4ytprZoUjfDDUyGUedR2UyJz6yyQMp6rjQAK5xXROrXIGHBvieHppBQa84gpOk6CILxQAqd1de70MUwckF28VlLmhLJCMZTWeM1vZPVM82SJWJcmxLYQgPpb8EXVZK0o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719858666; c=relaxed/simple;
	bh=HNfZAebjEnqDnc7ilU0siKxQwoyzXZA4QICmfvi7yeM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p+CcuJC8TctY8dHH4zwjVSgnN99Co8A78c6EgOicfnz994Dj/RuwMy+ht2ACR1XTY2JEQM4CZgsk5QvU98rNWSUxH8zxJndYR6ZBSeI9t6O+6KqBXDVu5qmq/KdulXt+S2R5t9K7pDvzRIXzp1XdLdSatcB2LS7GnVrHOhJLRAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GounTX21; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41F3BC116B1;
	Mon,  1 Jul 2024 18:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719858666;
	bh=HNfZAebjEnqDnc7ilU0siKxQwoyzXZA4QICmfvi7yeM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GounTX21nb+IvqwNGXVMlmoXS9D4ihFXBwHaRbLOSJ+FdW1+OD5s2tBllWCJeNgp/
	 9TNVnccno32Fc4M5puP8feOtmJEFAvaqBrGoSxum+O+7fsTClPoV520bsGGcxuaNir
	 VeDMJlrM7QTxVP/LsylM++2oSdb6C9BMDMgLt6GYUBsjba4IwuNu62iLI5qqCMlTnt
	 y+WwID6Cl6Qw3DLUMwOcGkVQqYoPw88efFfLP+J+o/UmvyR8NtdZsOi127Rg0MeTBP
	 G4R0y0Rmg4gbbf2XY4qxxvQlTSary5YaQLgPgnDeTTO9Fbu/08MWfmJg+6ytDs9dk0
	 7igXvj9kCQzhQ==
Date: Mon, 1 Jul 2024 12:31:05 -0600
From: Rob Herring <robh@kernel.org>
To: George Liu <liuxiwei1013@gmail.com>
Cc: linux-aspeed@lists.ozlabs.org, devicetree@vger.kernel.org,
	openbmc@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	joel@jms.id.au, andrew@codeconstruct.com.au
Subject: Re: [PATCH v1 1/3] dt-bindings: vendor-prefixes: Add prefix for
 ieisystems
Message-ID: <20240701183105.GA345878-robh@kernel.org>
References: <20240701105259.972135-1-liuxiwei@ieisystem.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240701105259.972135-1-liuxiwei@ieisystem.com>

On Mon, Jul 01, 2024 at 06:52:57PM +0800, George Liu wrote:
> Add a vendor prefix entry for ieisystems
> 
> Signed-off-by: George Liu <liuxiwei@ieisystem.com>

Also note that checkpatch.pl reports an author/Sob email mismatch.

> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> index 573578db9509..0ffa8d06aea9 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> @@ -609,6 +609,8 @@ patternProperties:
>      description: IC Plus Corp.
>    "^idt,.*":
>      description: Integrated Device Technologies, Inc.
> +  "^ieit,.*":
> +    description: IEIT SYSTEMS Co.，Ltd.
>    "^ifi,.*":
>      description: Ingenieurburo Fur Ic-Technologie (I/F/I)
>    "^ilitek,.*":
> -- 
> 2.34.1
> 

