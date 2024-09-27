Return-Path: <linux-kernel+bounces-341566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F31E9881C0
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 11:48:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A38F2B22B92
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 09:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75C1E1BD508;
	Fri, 27 Sep 2024 09:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BkDc5fxe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21601BCA0F;
	Fri, 27 Sep 2024 09:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727430395; cv=none; b=kkmpzYPjzRnurmp6MBtjx/H1IfH4P5NvAhR8KKvfz5u/SKJJ9DeBspfWx+xKkaXeOWJLQ3ucYbFbcTJUncgktrMN3W/v7r6izxZI/hZsKS59eFvy8w3t3vNE2Wv3P5OKfCVVBZ++R0CxfNRK8hU5F4iNDPTB99RSBYREmfCxWgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727430395; c=relaxed/simple;
	bh=z/SFsFpaz59mtt2KvLxwtvEexJAUyvCC3LJ37LM0M5U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YWQwrNEcnMAsdp1x+eiugSFBWoTF7PNqjPcBUSJz2sVcIBqQ2QJmbaL8rOU0mpkt8Tyo0lvkyKRIFf/5Wnl9/TT++LTPCB0klOxIj6ElKkqyQE+WRn8gNG37rr7Hl5/khwpIcBMrEPAEe69/4tAoHrGWk1sR+YO0c5mJJI37gdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BkDc5fxe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18F2AC4CECD;
	Fri, 27 Sep 2024 09:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727430395;
	bh=z/SFsFpaz59mtt2KvLxwtvEexJAUyvCC3LJ37LM0M5U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BkDc5fxeC74xjmQpdk0OM5X9B3zmb/t6jwIEvs2MuKXvJPwzGAhHQ+i7wOzdgaCSh
	 vDJj+MbCkdfeqCgTqzuLr2pxQEpqvQNvCO9UcIqXH0LOWu4frVsi49qt5lPCIsKigH
	 EhPodeVQC+szm5AOz8lAZlwK5AIJKQbQSnbUpN9ZKLuKwk6sIFXsLY5NdYt8+BPv9a
	 s4BlhTYtDi9oLJM3SWGRk4+RLUbmXikNwS+bmbOV6paPnbhml5MqXwRxFCj8/lsrcm
	 XDjgDsY/0AKzDI7l/Q4HnmaScpfmW1VLYZ/EKjX0+V77eW/TKMlXpwtwRlvm15jMHb
	 l9KgKpVDZC1Mw==
Date: Fri, 27 Sep 2024 11:46:32 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Michael Wu <michael@allwinnertech.com>
Cc: gregkh@linuxfoundation.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, Thinh.Nguyen@synopsys.com, balbi@kernel.org, 
	linux-usb@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: usb: snps,dwc3: Add
 'snps,inv-sync-hdr-quirk' quirk
Message-ID: <zyknvvagphkerbbbxegqw6a26j73garzelthgg7zv5os7bmmef@anc4567netmn>
References: <20240927072557.74194-1-michael@allwinnertech.com>
 <20240927072557.74194-2-michael@allwinnertech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240927072557.74194-2-michael@allwinnertech.com>

On Fri, Sep 27, 2024 at 03:25:57PM +0800, Michael Wu wrote:
> Added the new 'snps,inv-sync-hdr-quirk' DT property to dwc3 core for Gen2
> polarity detection.
> 
> The link uses data block (0011b) sync header for SYNC OS instead of control
> block (1100b). Set this quirk if the third-party PHY does not correct the
> sync header of the SYNC OS in the case of inverse polarity.
> 
> Signed-off-by: Michael Wu <michael@allwinnertech.com>
> ---
>  Documentation/devicetree/bindings/usb/snps,dwc3.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

Why this cannot be deduced from compatible?

Best regards,
Krzysztof


