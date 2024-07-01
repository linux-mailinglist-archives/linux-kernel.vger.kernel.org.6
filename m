Return-Path: <linux-kernel+bounces-236830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C004F91E79C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 20:33:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F19291C21E7B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 18:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4B67174ED7;
	Mon,  1 Jul 2024 18:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XW40Af/E"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A8116F284;
	Mon,  1 Jul 2024 18:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719858591; cv=none; b=mo65DVT9yFUYoScLrgs1MbAyXmEvn/rJgdgyGCP0+fOFYIkrZP2nNZBa1qpFE47SlWVmwa7uEK0kuBvFgG+3+g0TIcg9ooTk+HEQQJseN0U/2T9J8cbQwgHPtNGzMhsojaqhX+iJkT2Z7DMpHfaB5la1uYzOCMItAd0mUPVLywE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719858591; c=relaxed/simple;
	bh=kOKJXfn77YBdoorcP1QIopGNCIW+CsRKC6yRszSVKaY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H5xDrCnrahTdVJLPDxc7NCNzVrjG9axyYOBQVfvvxjEPDBnBgLKRxb00wDzD1qvj5WCi/rmvH1GlFcwlqe9J+AyBCIcBR81jK+tWuTMgABtIZK5tZTuwu6DwW7L652Ad2Fd/UqMruv+iAUG1wOw1rAZiytHXW1/WS9H3TiqY1ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XW40Af/E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B540C32781;
	Mon,  1 Jul 2024 18:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719858590;
	bh=kOKJXfn77YBdoorcP1QIopGNCIW+CsRKC6yRszSVKaY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XW40Af/E2Y8kFNrAXnM6dME9FeksSFduyq0fOpscUGFtiIKvCYOMiP9r4BX46bYmE
	 DWNvJ5Zl9mBj0waTRF4YWt3Mh6Kpx0k6j/ubHvRBrFT6UbM9Gfc6A5CIqKDf/GAiKX
	 6Ans25SXIHbSDLfmdxCM7Q/sTxAzOCnNkte/eUnTz4HGejQlYbVw+u+x94IRUifX0h
	 VcvoiGRNxc4nuomin8RLfBOf/cY2bwxcDT8SXOjD1jkBNv6Rb+H22HdTmgSVf2JrK2
	 swL71e4Cn7ilA1bkfNgRD0NxWN4LwBcJI5GWOxJEbDbG8A9atv3TnYacrQ6FyjyDYy
	 mbAEx/CFZaI3Q==
Date: Mon, 1 Jul 2024 12:29:49 -0600
From: Rob Herring <robh@kernel.org>
To: George Liu <liuxiwei1013@gmail.com>
Cc: linux-aspeed@lists.ozlabs.org, devicetree@vger.kernel.org,
	openbmc@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	joel@jms.id.au, andrew@codeconstruct.com.au
Subject: Re: [PATCH v1 1/3] dt-bindings: vendor-prefixes: Add prefix for
 ieisystems
Message-ID: <20240701182949.GA341683-robh@kernel.org>
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

ieisystems or IEIT SYSTEMS
> 
> Signed-off-by: George Liu <liuxiwei@ieisystem.com>

Or ieisystem?

Using the domain name (minus .com, etc.) is common practice.

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

