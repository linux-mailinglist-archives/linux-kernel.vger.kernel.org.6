Return-Path: <linux-kernel+bounces-414696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 997739D2C21
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 18:09:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 486F01F20F06
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 17:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C98FB1D0DE7;
	Tue, 19 Nov 2024 17:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JGfLtTPI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0544E57D;
	Tue, 19 Nov 2024 17:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732036139; cv=none; b=koBnqc0CkNaxu4/qqC3ZcJqt+3kpQYeNwGdYI1b/TFcvtjrCv6j9Y/CGnRPO173DblmiBnWgm6Tdt8WYZ44uujUSA85MRiFQeq73n7WERQzFqLPG7ymWfyF/XpkDzW/JTHHgtYEFIwVXsvOxshdjsZi7VUeXGUhoA2LjjFuk5As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732036139; c=relaxed/simple;
	bh=jsziOO9YUbowy87BvWTnC8X1lFfY8X8yPem1cuFkzzw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=STSJw5sEkwLKTLbgRCjHSgQvuUkz7LMNT/gG+C315A+bJr8zb5nQOzgTQ4WcFBOHhTRsIp2yPQcRpLSPqUR9O1+vRF8naxIojn8JAWB9Z8iCAnU3wu1SWCRScdSOYHl/mn19Wt7B2d69tH1Vi9tIHGI1r0z3QGRNegX0HOgX/HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JGfLtTPI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 638C0C4CECF;
	Tue, 19 Nov 2024 17:08:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1732036138;
	bh=jsziOO9YUbowy87BvWTnC8X1lFfY8X8yPem1cuFkzzw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JGfLtTPIqzcit5VvNsJUVfT/vg9o1LawHE22rSxWK1UcM4MGyOP5a7izMSURy7+VN
	 tWH0YXo08kIUIJgbgfhcPuEreJVJwaR6gSgYEyTiUL9dDj5W6Mmb9fEgp/x7zt1xTR
	 pM3W6BtNqQFTCnfEhxyB1BiDdgHf8e9HOcekMV1s=
Date: Tue, 19 Nov 2024 18:08:34 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Luis Felipe Hernandez <luis.hernandez093@gmail.com>
Cc: Thinh.Nguyen@synopsys.com, skhan@linuxfoundation.org,
	ricardo@marliere.net, linux-usb@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Documentation: usb: dwc3: remove deprecated member
Message-ID: <2024111922-pantyhose-panorama-6f16@gregkh>
References: <20241119154309.98747-1-luis.hernandez093@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241119154309.98747-1-luis.hernandez093@gmail.com>

On Tue, Nov 19, 2024 at 10:43:07AM -0500, Luis Felipe Hernandez wrote:
> This patch updates the documentation for the dwc3_request struct,
> removing the sg (scatter list pointer) member.
> 
> - Remove 'sg' in the doc block for dwc3_request
> 
> This change resolves a documentation warning related to the missing
> description for this field.
> 
> Signed-off-by: Luis Felipe Hernandez <luis.hernandez093@gmail.com>
> ---
> v1->v2: remove unused sg struct member as per review[1]
> [1] https://lore.kernel.org/linux-usb/20241119020807.cn7ugxnhbkqwrr2b@synopsys.com/#t
> ---
>  drivers/usb/dwc3/core.h | 1 -
>  1 file changed, 1 deletion(-)

What about the "Reported-by:" tag?

thanks,

greg k-h

