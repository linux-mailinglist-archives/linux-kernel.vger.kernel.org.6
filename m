Return-Path: <linux-kernel+bounces-449282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 477F29F4CB3
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 14:46:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D947F163839
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 13:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D8C01F4297;
	Tue, 17 Dec 2024 13:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Var43+tn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6DFE1E0490;
	Tue, 17 Dec 2024 13:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734443052; cv=none; b=h2pfTPQTA92AlVP6P0tAoSGRJQtyamjj3swwSGMF6mm6KxQ6c8XehlFK90mlKkvDxsEwmXJM8ZCJOgpdaeVi1cTVPlXi1Ng84SfnFEtfgDJyyh7Et2NHnZaLuR5ir2YuxSwg+1dVTzH+CETp+DcIo70qEsb7jcdAcWvCAI3y8bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734443052; c=relaxed/simple;
	bh=ZyO0SjUbWcS9x/Ck+ggRPJzy7ukxZ1/hZXs4pGbFUDw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AYTE7lbJcDcgpNIXxWfyj0sWA/uspuGFdatsuI6sYYnAhWU946YPZp0ajuStcQL3xfi9Pse4gwJABSJbcMBRfZAtFtVt4PZi0yfQ2nI5hDxSnIvqYndEvsYbgDlfSyo04JrXVWbrIcVdU9Q+9NX7Q+Omqv60WFmX7HSCYRclVMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Var43+tn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BB65C4CED3;
	Tue, 17 Dec 2024 13:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734443051;
	bh=ZyO0SjUbWcS9x/Ck+ggRPJzy7ukxZ1/hZXs4pGbFUDw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Var43+tnLal33Ve78U/eyWkFUO2dXNxSpc35tFHNDtX8PWqmpXj9MlYXbITf0etl8
	 7CCKJNKlPOk8tT7GwVRHbk4BVjqpq/AIrI09Wwc1W/aI0WCj2ckhGayRjo7sMxDns3
	 AB+Htirthjdo490IFxwOSSfS2f4muBNeUwVwW3bXW/+dQfaY2aCQnTpLp+ZnwOPcfw
	 P1gD3GKRXrMMErbN5bZwBaGC2ofjetu2v8MQ5rTCwfVmbcQDjP2ICNAI730zyFWE3v
	 TV1B5V+ff5wqmLHmYgz1e2CVo9PhSKBGtTMv4lynCiYMghuyskJXIdhDwwbsbKQrDB
	 DctIsPx9uQNSQ==
Date: Tue, 17 Dec 2024 07:44:09 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Amit Sunil Dhamne <amitsd@google.com>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kyle Tso <kyletso@google.com>,
	Badhri Jagan Sridharan <badhri@google.com>,
	linux-kernel@vger.kernel.org, RD Babiera <rdbabiera@google.com>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-usb@vger.kernel.org
Subject: Re: [PATCH v2 1/3] dt-bindings: connector: Add pd-revision property
Message-ID: <173444304922.1440983.3295876849064154968.robh@kernel.org>
References: <20241210-get_rev_upstream-v2-0-d0094e52d48f@google.com>
 <20241210-get_rev_upstream-v2-1-d0094e52d48f@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241210-get_rev_upstream-v2-1-d0094e52d48f@google.com>


On Tue, 10 Dec 2024 19:07:07 -0800, Amit Sunil Dhamne wrote:
> Add pd-revision property definition, to specify the maximum Power
> Delivery Revision and Version supported by the connector.
> 
> Signed-off-by: Amit Sunil Dhamne <amitsd@google.com>
> ---
>  Documentation/devicetree/bindings/connector/usb-connector.yaml | 7 +++++++
>  Documentation/devicetree/bindings/usb/maxim,max33359.yaml      | 1 +
>  2 files changed, 8 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


