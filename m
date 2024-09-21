Return-Path: <linux-kernel+bounces-334723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 372A397DB14
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 02:56:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA26C28248C
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 00:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AD7E3D7A;
	Sat, 21 Sep 2024 00:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RswCmpqu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9050C1C36;
	Sat, 21 Sep 2024 00:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726880177; cv=none; b=YdXcdDXyJUbEqfrjmXngF9GejTN0P7UKcKv48pfFSxrLaiLe8IRqUa0MArAhxOvmQ5fDzvuw8wP1p+huyPMuVcVHSx3zrdecuJXIKOx0pJpJkmYc2JnkffpfK37K4pdf+S3I5bKC6MPJVODPj3UoUt4SFiNO3Ydll0p1tTyzr1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726880177; c=relaxed/simple;
	bh=gfFO/2Ziqfo0lbjwvZ/k6n/85aHCQWFHkCBTIbo6rmw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g7BW8XQwp0cCLJj/vI8dDItmT/R42l+Z+3AoY3klV4nSrS7/zPZ3tr13EzC2mkJrjcI6xzkmIINbTf6oMw8/fApkgfGLS5yAMopMI0Z1nvgoh2zB/KpuseSt/1iFuSzHTzCZ+dC0aI0hI9LRTUI3UTinSdTrnvCdmG6rtwhKFBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RswCmpqu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03B35C4CEC3;
	Sat, 21 Sep 2024 00:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726880177;
	bh=gfFO/2Ziqfo0lbjwvZ/k6n/85aHCQWFHkCBTIbo6rmw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RswCmpquRIy097l8NzGqmgtdCN/tS3FWz+zkWR93NVGasyGKFqZmAnUlHVteli8zn
	 DxPzKSOzJrmIiuSbt/BfCZZ8jdJsKX1o9s40GlkKeaxcIcnfpD8D+/5hxdYWxsxLzg
	 i2KDXnvOYNhUWiTYH8hTRQfeMcvcTqT+GBW1iNqMRGnFHIjuzIhQn91M4Q6rpn+gDk
	 6TqGZef4dbPkR9OMqS1AJecUp1ijKm3O+Nam7JqiKRNf7IvVdUIHW+nY15iSukcf5r
	 V7av3Ddax3lVWYK0EVpAfQVHAndXDBj3w6EFhE+NAP4+ttzMJu14JQ+lAigT2teeer
	 sKJsDDWhQxkQA==
Date: Fri, 20 Sep 2024 19:56:16 -0500
From: Rob Herring <robh@kernel.org>
To: Amit Sunil Dhamne <amitsd@google.com>
Cc: gregkh@linuxfoundation.org, dmitry.baryshkov@linaro.org,
	heikki.krogerus@linux.intel.com, badhri@google.com,
	kyletso@google.com, rdbabiera@google.com,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [RFC v2 1/2] dt-bindings: connector: Add properties to define
 time values
Message-ID: <20240921005616.GA185456-robh@kernel.org>
References: <20240919075120.328469-1-amitsd@google.com>
 <20240919075120.328469-2-amitsd@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240919075120.328469-2-amitsd@google.com>

On Thu, Sep 19, 2024 at 12:51:13AM -0700, Amit Sunil Dhamne wrote:
> This commit adds the following properties:
>   * sink-wait-cap-time-ms
>   * ps-source-off-time-ms
>   * cc-debounce-time-ms
> 
> This is to enable setting of platform/board specific timer values as
> these timers have a range of acceptable values.

What's acceptable? Put that in constraints for the properties.

> 
> Signed-off-by: Amit Sunil Dhamne <amitsd@google.com>
> ---
>  .../bindings/connector/usb-connector.yaml     | 32 ++++++++++++++++++-
>  1 file changed, 31 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/connector/usb-connector.yaml b/Documentation/devicetree/bindings/connector/usb-connector.yaml
> index fb216ce68bb3..5efa4ea3c41c 100644
> --- a/Documentation/devicetree/bindings/connector/usb-connector.yaml
> +++ b/Documentation/devicetree/bindings/connector/usb-connector.yaml
> @@ -253,6 +253,33 @@ properties:
>  
>      additionalProperties: false
>  
> +  sink-wait-cap-time-ms:
> +    description: Represents the max time in ms that USB Type-C port (in sink
> +      role) should wait for the port partner (source role) to send source caps.
> +      SinkWaitCap timer starts when port in sink role attaches to the source.
> +      This timer will stop when sink receives PD source cap advertisement before
> +      timeout in which case it'll move to capability negotiation stage. A
> +      timeout leads to a hard reset message by the port. If no value is set for
> +      this property then the driver assumes a default value of PD_T_SINK_WAIT_CAP
> +      (defined in include/linux/usb/pd.h).

Express default as "default: N". Sorry, defines don't work here.

