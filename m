Return-Path: <linux-kernel+bounces-440486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CE379EBEEF
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 00:06:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4CCD1887D31
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 23:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF8EB1F1917;
	Tue, 10 Dec 2024 23:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DjF9pw3+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B19D2451C7;
	Tue, 10 Dec 2024 23:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733871978; cv=none; b=M6E3ViXUnqHR7QXJUup8O2lnM62UL+OilSiIIxhDOq2VWCAY3HKeUL1NyQ1Tggtp7hmxq243nAZSA3tWwDEoto5sSM1BqLq8PLLCk2oiJdkXJanIcr6wB7BC7XCWRL2SEdrZ5t33hxwWUF/XdnBmBihtzdZjnbjNOXi4IfQy2O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733871978; c=relaxed/simple;
	bh=8wfuV3wDVS47C9OCGsMUUSuyZIBev6yuyPkJHz2WFmE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QmsvTzMFAw4e03FX/7BWg8Vlmhyu7sdeRDjIMz4SgskrJ4cLltj7G31kCexPwXLNL0cxl/+q4jPYtMA/+g/eQad21SK9MlVrqrlQ48E6Uo2b/sjZ22uziJwVpJKxtQn9Gy19U9hNMMxhu8syQxhOY8d8Bu7CsLC9kXsA9u6hlcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DjF9pw3+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71C25C4CED6;
	Tue, 10 Dec 2024 23:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733871977;
	bh=8wfuV3wDVS47C9OCGsMUUSuyZIBev6yuyPkJHz2WFmE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DjF9pw3+pdV7nSjN5ouGZPIG4ALW32/O7DPA+PpdY1SCBuR5FSTqS13h/FhpmFn8r
	 33BQ/AYp27PmGBacYk3LzICaccUpI/ov7uc/yFNLXriK+hmkkOlFA2M/Bdy/rVxu7q
	 X8jk+0gZugt5Ob5Fx9iZv+DsCEm9COV99nfQExKIN3W03x6VLo0k4LipFZorZyBqU6
	 iVIMbI0gRcrIsCOzKNhMy5kxaU6+X7qL9MP7HHILpmiqLGOcrMGhx08bHx+LMkekTG
	 7dICUcGHOfwNMdqWGINZDSwtHzfo2cCf9JGyVlPq9odupLHpAagWhTc61d9hjgzpga
	 4irqeQ3uZSArw==
Date: Tue, 10 Dec 2024 17:06:15 -0600
From: Rob Herring <robh@kernel.org>
To: Amit Sunil Dhamne <amitsd@google.com>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Badhri Jagan Sridharan <badhri@google.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Kyle Tso <kyletso@google.com>, RD Babiera <rdbabiera@google.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: connector: Add pd-revision property
Message-ID: <20241210230615.GA766674-robh@kernel.org>
References: <20241205-get_rev_upstream-v1-0-90158ee7d75f@google.com>
 <20241205-get_rev_upstream-v1-1-90158ee7d75f@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241205-get_rev_upstream-v1-1-90158ee7d75f@google.com>

On Thu, Dec 05, 2024 at 11:46:08PM -0800, Amit Sunil Dhamne wrote:
> Add pd-revision property definition, to specify the maximum Power
> Delivery Revision and Version supported by the connector.
> 
> Signed-off-by: Amit Sunil Dhamne <amitsd@google.com>
> ---
>  Documentation/devicetree/bindings/connector/usb-connector.yaml | 6 ++++++
>  Documentation/devicetree/bindings/usb/maxim,max33359.yaml      | 1 +
>  2 files changed, 7 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/connector/usb-connector.yaml b/Documentation/devicetree/bindings/connector/usb-connector.yaml
> index 67700440e23b5b7ca0db2c395c8a455bcf650864..341d2872e8d43450d219b7b72d48790051dc4e2b 100644
> --- a/Documentation/devicetree/bindings/connector/usb-connector.yaml
> +++ b/Documentation/devicetree/bindings/connector/usb-connector.yaml
> @@ -293,6 +293,12 @@ properties:
>        PD negotiation till BC1.2 detection completes.
>      default: 0
>  
> +  pd-revision:
> +    description: Specifies the maximum USB PD revision and version supported by
> +      the connector. This property is specified in the following order;
> +      <revision_major, revision_minor, version_major, version_minor>.
> +    $ref: /schemas/types.yaml#/definitions/uint8-array

Always exactly 4 entries? Then:

maxItems: 4

> +
>  dependencies:
>    sink-vdos-v1: [ sink-vdos ]
>    sink-vdos: [ sink-vdos-v1 ]
> diff --git a/Documentation/devicetree/bindings/usb/maxim,max33359.yaml b/Documentation/devicetree/bindings/usb/maxim,max33359.yaml
> index 20b62228371bdedf2fe92767ffe443bec87babc5..350d39fbf2dcd4d99db07cb8f099467e6fc653ee 100644
> --- a/Documentation/devicetree/bindings/usb/maxim,max33359.yaml
> +++ b/Documentation/devicetree/bindings/usb/maxim,max33359.yaml
> @@ -70,6 +70,7 @@ examples:
>                                         PDO_FIXED_DUAL_ROLE)
>                                         PDO_FIXED(9000, 2000, 0)>;
>                  sink-bc12-completion-time-ms = <500>;
> +                pd-revision = /bits/ 8 <0x03 0x01 0x01 0x08>;
>              };
>          };
>      };
> 
> -- 
> 2.47.0.338.g60cca15819-goog
> 

