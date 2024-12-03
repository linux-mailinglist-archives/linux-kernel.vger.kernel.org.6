Return-Path: <linux-kernel+bounces-429910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED5A79E2AB7
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 19:23:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA502B3F47B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 17:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59EEE1F9F5B;
	Tue,  3 Dec 2024 17:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wmat8+rE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADEF41EF0B0;
	Tue,  3 Dec 2024 17:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733245613; cv=none; b=t76SjDGjV+2C2OjDqYn2DiA1OzoitW+oJSQGwOjRgHskXHdeRaG35XdaGuYqAcPlXTDPS04f2tSWdzlOPQOziBFCVrYjc5OG7N+2xFvBjIdv7pkN0HNX9GD3G4AstDCMWtsVSkYSdomScYR/V6TkUl2U1uyr7DbqHSWFO+shUUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733245613; c=relaxed/simple;
	bh=xulMcPRVO3Eq3RIAsvP3n8DqT8Wrm2MkXsbGmNqnne8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aOnXYOLkbI4rVrMw+DhEXSnxUI2P2//km6dlTdJkYvcdsiRUg7npIvkIqKJojqdTE90sFpcZmJxvNVTy4ADdf1JBbDavl55MbMsTSigXCGEYjav6xXERL6Ksv83y9+Tde3x6s0aL+GE/gIX4Q8hD5YRZgWQx4slQRrBZu1M6Y0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wmat8+rE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E929CC4CED8;
	Tue,  3 Dec 2024 17:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733245613;
	bh=xulMcPRVO3Eq3RIAsvP3n8DqT8Wrm2MkXsbGmNqnne8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Wmat8+rEJokmUC9puxX/CKFzXo7btcPOWsLSw83ivMHyFc93EaFPA4XEqLrqsTB1p
	 Vx5j2o1pUZREzPVrJXDBB5phm6IF/jJMAXsy6chDP90tGmo5eo6uIJ58Qvq4pXnVeg
	 iYz0kJlP9EeZ/bD13vK2LW5JyJTlzAl4lPSm93UH/1lal4LygD4R2vZNB8uS7vo444
	 trQaZVYaPFSBrWtHX5wxq0qQNZY+exYq2J3suw5l0PwZPnRFfOFaQEpbJNRZYr/OY7
	 12V0bp0M8FJFAwPK4V2LroyEtFhG3RFcaSenlj0Oeq1Ozn8/WYV4D6BfpZFRcEJb5B
	 TAC+KpdMps0/Q==
Date: Tue, 3 Dec 2024 11:06:51 -0600
From: Rob Herring <robh@kernel.org>
To: CL Wang <cl634@andestech.com>
Cc: alexandre.belloni@bootlin.com, krzk+dt@kernel.org, conor+dt@kernel.org,
	devicetree@vger.kernel.org, linux-rtc@vger.kernel,
	linux-kernel@vger.kernel.org, tim609@andestech.com,
	ycliang@andestech.com
Subject: Re: [PATCH V4 RESEND 2/3] dt-bindings: rtc: Add support for
 ATCRTC100 RTC
Message-ID: <20241203170651.GA1955995-robh@kernel.org>
References: <20241127141939.1570952-1-cl634@andestech.com>
 <20241127141939.1570952-3-cl634@andestech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241127141939.1570952-3-cl634@andestech.com>

On Wed, Nov 27, 2024 at 10:19:38PM +0800, CL Wang wrote:
> Document Device Tree bindings for the Andes ATCRTC100 Real-Time Clock.
> 
> Signed-off-by: CL Wang <cl634@andestech.com>
> 
> ---
> Changes for v2:
>  - First version of devicetree bindings for the Andes ATCRTC100 Real-Time Clock.
> 
> Changes for v3:
>  - Used compatible as the filename.
>  - Placed allOf after maintainers.
>  - Replaced additionalProperties: false with unevaluatedProperties: false.
>  - Added descriptions for interrupts.
> 
> Changes for v4:
>  - Removed wakeup-source attribute.
> ---
>  .../bindings/rtc/andestech,atcrtc100.yaml     | 43 +++++++++++++++++++
>  1 file changed, 43 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/rtc/andestech,atcrtc100.yaml

Missing Conor's tag from the 1st resend. If you got tags and need to 
resend, that's not a resend. You need to add the tags and it is v5.

But don't just go send v5 now for that. Alexandre can add the tag. 

Rob

