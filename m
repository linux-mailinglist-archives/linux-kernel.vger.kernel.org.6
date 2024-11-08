Return-Path: <linux-kernel+bounces-402385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22C389C26F4
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 22:13:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E2F5B21B7C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 21:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A3C51F26CB;
	Fri,  8 Nov 2024 21:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JiRAIUQ/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8801AA1F9;
	Fri,  8 Nov 2024 21:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731100404; cv=none; b=bAY4M3YTmH4OaDYc870YbY7xOol++2GNshQmzegztpGxHiY/0HWgoqNim0TVK6kWFOFyHx4yxgBhLJ6iEi+5ugLv1A/iKL4gweYYxKBGT/xMFpq2rLv0+cuxNOJ1NyMzko4Vk8OFlyrHAipuxzzlFVu/tAa0VdAGS8TnOFOkkgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731100404; c=relaxed/simple;
	bh=JqqUEnZISSBjlEVJHEp2gifVmpZJR6UqrvGG5n6Q1+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CsNbT8RCgqTAtcqsHk1MPVgx9acg5olyZpKTK0dPb6P4ZZ9K6YppWatxrddAsox9qn3GAWHZlE6q6C0LIZp9bPWEkUmrQxR/+p39pUmyDczZbVxusGwTE3ZT9/2/4sSnO50ZlSTUCyOD4GUihws2Hg7QloHX34wUHodFI7jkEF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JiRAIUQ/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A3E3C4CECD;
	Fri,  8 Nov 2024 21:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731100404;
	bh=JqqUEnZISSBjlEVJHEp2gifVmpZJR6UqrvGG5n6Q1+0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JiRAIUQ/h06A0rEMbeXI/r8p8Kfuo2FICZju2ct0mlIkRlDgbUSp62XHeNGSoP391
	 b39k1H+ynNiYKtDnxlTsP8SzP8ls+0CPDDDxz01Iu0YlDogZ/RWuDz8Ql9pwAr3Qvl
	 GoTm2Ccz979UG0FfqFqYbidFEcJalNW0SZRMs2fgtpgak0sUMltrX8K/OWQkuJa5Vw
	 lj/SnjOYCucS7BYXhY+87eSzFOOqqzNX96u0zXRRIv3jOCcQ681djs0fZdQtwTmkcX
	 2dvO993Nf3fKV6CtDen6x+FNghz3WO29zzlqiRAjz/deZHRGlz3rAzr7WX4bwv2/BG
	 W1rOX/B7kxDgg==
Date: Fri, 8 Nov 2024 15:13:22 -0600
From: Rob Herring <robh@kernel.org>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: interrupt-controller: qcom,pdc: Add
 SAR2130P compatible
Message-ID: <20241108211322.GA2849214-robh@kernel.org>
References: <20241017-sar2130p-pdc-v1-1-cf9ccd9c37da@linaro.org>
 <t2trcojqskryzbuh6cbuqev35eioduarneskwtcm5aeeqlvbkv@3kj4x36ebkqk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <t2trcojqskryzbuh6cbuqev35eioduarneskwtcm5aeeqlvbkv@3kj4x36ebkqk>

On Thu, Oct 31, 2024 at 07:34:41PM +0200, Dmitry Baryshkov wrote:
> On Thu, Oct 17, 2024 at 09:13:01PM +0300, Dmitry Baryshkov wrote:
> > Document compatible for PDC interrupt controller on SAR2130P platform.
> > 
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > ---
> >  Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.yaml | 1 +
> >  1 file changed, 1 insertion(+)
> 
> Gracious ping, the patch has been acked by DT maintainers, but is still
> not present in linux-next and got no other reviews.

Applied.

> Krzysztof mentioned that the patch should be picked up by Bjorn, but all
> previous patches for PDC schema were picked up by Rob Herring or by Marc
> Zyngier (and one stray patch was picked up by Linus Walleij).

My preference is for it to be applied with the driver or dts changes. 
For standalone patches, I only pick them up if the $subsystem maintainer 
does not.

Rob

